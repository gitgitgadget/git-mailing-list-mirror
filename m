From: =?ISO-8859-2?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: obnoxious CLI complaints
Date: Fri, 11 Sep 2009 00:19:13 +0200
Message-ID: <4AA97B61.6030301@lsrfire.ath.cx>
References: <ef38762f0909091427m5b8f3am72c88fd4dbfebc59@mail.gmail.com> <m3fxavvl5k.fsf@localhost.localdomain> <ef38762f0909091709t7336d86dkd2f175e5b3a6a3f@mail.gmail.com> <200909101116.55098.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Cc: Brendan Miller <catphive@catphive.net>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 11 00:19:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MlrzO-0003Rk-6V
	for gcvg-git-2@lo.gmane.org; Fri, 11 Sep 2009 00:19:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754592AbZIJWTX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Sep 2009 18:19:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754568AbZIJWTX
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Sep 2009 18:19:23 -0400
Received: from india601.server4you.de ([85.25.151.105]:38598 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754478AbZIJWTW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Sep 2009 18:19:22 -0400
Received: from [10.0.1.101] (p57B7F065.dip.t-dialin.net [87.183.240.101])
	by india601.server4you.de (Postfix) with ESMTPSA id 6C2BB2F84EF;
	Fri, 11 Sep 2009 00:19:24 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <200909101116.55098.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128155>

Jakub Narebski schrieb:
> [...] Second, compression is better left to separate program, but
> I guess we can follow GNU tar example and add equivalents of -Z/-z/-j
> and --use-compress-program options when using --output=<file>. [...]

Compression only makes sense for the tar format, so I think it's better
exposed by new formats and not by generic options.

For compress and bzip2 we'd need to call the external archiver, similar
to a pager.  Interesting idea.

For gzip, we can use the zlib helper functions, since we're linking
against it anyway.  I mention this because the following patch has been
laying around here for a while, collecting dust because it was a feature
waiting for a requester.

Using zlib directly avoids the overhead of a pipe and of buffering the
output for blocked writes; surprisingly (to me), it isn't any faster.
I didn't make any tuning efforts, yet, though.  Anyway, here it is:

---
 Documentation/git-archive.txt |    2 +-
 archive-tar.c                 |   76 ++++++++++++++++++++++++++++++++++++----
 archive.c                     |   43 ++++++++++++++++++++++-
 archive.h                     |    1 +
 t/t5000-tar-tree.sh           |   30 ++++++++++++++++
 5 files changed, 141 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-archive.txt b/Documentation/git-archive.txt
index 92444dd..2935246 100644
--- a/Documentation/git-archive.txt
+++ b/Documentation/git-archive.txt
@@ -34,7 +34,7 @@ OPTIONS
 -------
 
 --format=<fmt>::
-	Format of the resulting archive: 'tar' or 'zip'.  The default
+	Format of the resulting archive: 'tar', 'tar.gz' or 'zip'.  The default
 	is 'tar'.
 
 -l::
diff --git a/archive-tar.c b/archive-tar.c
index cee06ce..f22304d 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -58,18 +58,78 @@ static void write_blocked(const void *data, unsigned long size)
 	write_if_needed();
 }
 
+static void gzwrite_or_die(gzFile *gzfile, const void *buf, size_t count)
+{
+	const int chunk = 1 << 30; /* Big arbitrary value that fits into int. */
+	const char *p = buf;
+
+	while (count > 0) {
+		unsigned int to_write = (count < chunk) ? count : chunk;
+		int written = gzwrite(gzfile, p, to_write);
+		if (written <= 0) {
+			int err;
+			const char *msg = gzerror(gzfile, &err);
+			if (err != Z_ERRNO)
+				die("zlib error: %s", msg);
+			if (errno == EAGAIN || errno == EINTR)
+				continue;
+			if (errno == EPIPE)
+				exit(0);
+			die_errno("write error");
+		}
+		count -= written;
+		p += written;
+	}
+}
+
+/*
+ * Writes directly through zlib and pads with NUL bytes to multiples of
+ * RECORDSIZE.  Updates offset because the length of the trailer depends
+ * on it.
+ */
+static void write_to_tgz(struct archiver_args *args, const void *data,
+			 unsigned long size)
+{
+	unsigned long tail = size % RECORDSIZE;
+	gzwrite_or_die(args->gzfile, data, size);
+	if (tail) {
+		tail = RECORDSIZE - tail;
+		if (gzseek(args->gzfile, tail, SEEK_CUR) == -1)
+			die("zlib error while seeking.");
+	}
+	offset = (offset + size + tail) % BLOCKSIZE;
+}
+
+static void write_to_archive(struct archiver_args *args, const void *data,
+			     unsigned long size)
+{
+	if (args->gzfile)
+		write_to_tgz(args, data, size);
+	else
+		write_blocked(data, size);
+}
+
 /*
  * The end of tar archives is marked by 2*512 nul bytes and after that
  * follows the rest of the block (if any).
  */
-static void write_trailer(void)
+static void write_trailer(struct archiver_args *args)
 {
 	int tail = BLOCKSIZE - offset;
-	memset(block + offset, 0, tail);
-	write_or_die(1, block, BLOCKSIZE);
-	if (tail < 2 * RECORDSIZE) {
-		memset(block, 0, offset);
+	if (args->gzfile) {
+		if (tail < 2 * RECORDSIZE)
+			tail += BLOCKSIZE;
+		if (gzseek(args->gzfile, tail - 1, SEEK_CUR) == -1)
+			die("zlib error while seeking.");
+		if (gzputc(args->gzfile, '\0') == -1)
+			die("zlib error while writing a NUL byte.");
+	} else {
+		memset(block + offset, 0, tail);
 		write_or_die(1, block, BLOCKSIZE);
+		if (tail < 2 * RECORDSIZE) {
+			memset(block, 0, offset);
+			write_or_die(1, block, BLOCKSIZE);
+		}
 	}
 }
 
@@ -201,9 +261,9 @@ static int write_tar_entry(struct archiver_args *args,
 			return err;
 	}
 	strbuf_release(&ext_header);
-	write_blocked(&header, sizeof(header));
+	write_to_archive(args, &header, sizeof(header));
 	if (S_ISREG(mode) && buffer && size > 0)
-		write_blocked(buffer, size);
+		write_to_archive(args, buffer, size);
 	return err;
 }
 
@@ -245,6 +305,6 @@ int write_tar_archive(struct archiver_args *args)
 	if (!err)
 		err = write_archive_entries(args, write_tar_entry);
 	if (!err)
-		write_trailer();
+		write_trailer(args);
 	return err;
 }
diff --git a/archive.c b/archive.c
index 0bca9ca..8809f51 100644
--- a/archive.c
+++ b/archive.c
@@ -15,6 +15,8 @@ static char const * const archive_usage[] = {
 };
 
 #define USES_ZLIB_COMPRESSION 1
+#define USES_GZIP_COMPRESSION 2
+#define USES_COMPRESSION (USES_ZLIB_COMPRESSION | USES_GZIP_COMPRESSION)
 
 static const struct archiver {
 	const char *name;
@@ -22,6 +24,7 @@ static const struct archiver {
 	unsigned int flags;
 } archivers[] = {
 	{ "tar", write_tar_archive },
+	{ "tar.gz", write_tar_archive, USES_GZIP_COMPRESSION },
 	{ "zip", write_zip_archive, USES_ZLIB_COMPRESSION },
 };
 
@@ -336,7 +339,7 @@ static int parse_archive_args(int argc, const char **argv,
 
 	args->compression_level = Z_DEFAULT_COMPRESSION;
 	if (compression_level != -1) {
-		if ((*ar)->flags & USES_ZLIB_COMPRESSION)
+		if ((*ar)->flags & USES_COMPRESSION)
 			args->compression_level = compression_level;
 		else {
 			die("Argument not supported for format '%s': -%d",
@@ -351,11 +354,38 @@ static int parse_archive_args(int argc, const char **argv,
 	return argc;
 }
 
+static void archive_gzfile_open(struct archiver_args *args)
+{
+	char mode[] = "wbX";
+	if (args->compression_level == Z_DEFAULT_COMPRESSION)
+		mode[2] = '\0';
+	else
+		mode[2] = '0' + args->compression_level;
+	args->gzfile = gzdopen(xdup(1), mode);
+	if (!args->gzfile)
+		die("zlib error: out of memory.");
+}
+
+static void archive_gzfile_close(struct archiver_args *args)
+{
+	int err = gzclose(args->gzfile);
+	switch (err) {
+	case Z_OK:
+		break;
+	case Z_ERRNO:
+		die_errno("zlib error");
+	default:
+		die("zlib error %d while closing.", err);
+	}
+	args->gzfile = NULL;
+}
+
 int write_archive(int argc, const char **argv, const char *prefix,
 		int setup_prefix)
 {
 	const struct archiver *ar = NULL;
 	struct archiver_args args;
+	int err;
 
 	argc = parse_archive_args(argc, argv, &ar, &args);
 	if (setup_prefix && prefix == NULL)
@@ -366,5 +396,14 @@ int write_archive(int argc, const char **argv, const char *prefix,
 
 	git_config(git_default_config, NULL);
 
-	return ar->write_archive(&args);
+	args.gzfile = NULL;
+	if (ar->flags & USES_GZIP_COMPRESSION)
+		archive_gzfile_open(&args);
+
+	err = ar->write_archive(&args);
+
+	if (!err && (ar->flags & USES_GZIP_COMPRESSION))
+		archive_gzfile_close(&args);
+
+	return err;
 }
diff --git a/archive.h b/archive.h
index 038ac35..638a7ba 100644
--- a/archive.h
+++ b/archive.h
@@ -12,6 +12,7 @@ struct archiver_args {
 	unsigned int verbose : 1;
 	unsigned int worktree_attributes : 1;
 	int compression_level;
+	gzFile gzfile;
 };
 
 typedef int (*write_archive_fn_t)(struct archiver_args *);
diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
index 5f84b18..4094c18 100755
--- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -26,6 +26,8 @@ commit id embedding:
 
 . ./test-lib.sh
 UNZIP=${UNZIP:-unzip}
+GZIP=${GZIP:-gzip}
+GUNZIP=${GUNZIP:-$GZIP -d}
 
 SUBSTFORMAT=%H%n
 
@@ -79,6 +81,15 @@ test_expect_success \
     'git tar-tree HEAD >b2.tar'
 
 test_expect_success \
+    'git archive --format=tar.gz' \
+    'git archive --format=tar.gz HEAD >bz.tar.gz'
+
+test_expect_success \
+    'git archive --format=tar.gz with --output' \
+    'git archive --format=tar.gz --output=bz1.tar.gz HEAD &&
+     test_cmp bz.tar.gz bz1.tar.gz'
+
+test_expect_success \
     'git archive vs. git tar-tree' \
     'test_cmp b.tar b2.tar'
 
@@ -146,7 +157,9 @@ test_expect_success \
     'cp .git/info/attributes .git/info/attributes.before &&
      echo "substfile?" export-subst >>.git/info/attributes &&
      git archive HEAD >f.tar &&
+     git archive --format=tar.gz HEAD >fz.tar.gz &&
      git archive --prefix=prefix/ HEAD >g.tar &&
+     git archive --format=tar.gz --prefix=prefix/ HEAD >gz.tar.gz &&
      mv .git/info/attributes.before .git/info/attributes'
 
 test_expect_success \
@@ -173,6 +186,23 @@ test_expect_success \
       test_cmp a/substfile2 g/prefix/a/substfile2
 '
 
+$GUNZIP -h >/dev/null 2>&1
+if [ $? -eq 127 ]; then
+	echo "Skipping tar.gz expansion tests, because gunzip was not found"
+else
+	test_expect_success \
+		'expand *.tar.gz' \
+		'$GUNZIP bz.tar.gz &&
+		 $GUNZIP fz.tar.gz &&
+		 $GUNZIP gz.tar.gz'
+
+	test_expect_success \
+		'compare files created by formats tar and tar.gz' \
+		'test_cmp b.tar bz.tar &&
+		 test_cmp f.tar fz.tar &&
+		 test_cmp g.tar gz.tar'
+fi
+
 test_expect_success \
     'git archive --format=zip' \
     'git archive --format=zip HEAD >d.zip'
-- 
1.6.5.rc0
