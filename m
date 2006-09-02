From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH] Add support for tgz archive format
Date: Sat, 02 Sep 2006 14:37:56 +0200
Message-ID: <44F97B24.7090305@lsrfire.ath.cx>
References: <44F977C0.4060901@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>,
	Franck Bui-Huu <vagabon.xyz@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 02 14:38:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GJUlR-00084V-Vd
	for gcvg-git@gmane.org; Sat, 02 Sep 2006 14:38:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751060AbWIBMiA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 2 Sep 2006 08:38:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751057AbWIBMh7
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Sep 2006 08:37:59 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:63122
	"EHLO neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S1751051AbWIBMh7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Sep 2006 08:37:59 -0400
Received: from [10.0.1.3] (p508E733A.dip.t-dialin.net [80.142.115.58])
	by neapel230.server4you.de (Postfix) with ESMTP id 9300D20045;
	Sat,  2 Sep 2006 14:37:57 +0200 (CEST)
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
To: Git Mailing List <git@vger.kernel.org>
In-Reply-To: <44F977C0.4060901@lsrfire.ath.cx>
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26333>

 Documentation/git-archive-tree.txt |    9 ++---
 archive.h                          |    2 +
 builtin-archive-tree.c             |    4 +-
 builtin-tar-tree.c                 |   63 ++++++++++++++++++++++++++++++++-----
 4 files changed, 65 insertions(+), 13 deletions(-)

diff --git a/Documentation/git-archive-tree.txt b/Documentation/git-archive-tree.txt
index 122c482..25136d9 100644
--- a/Documentation/git-archive-tree.txt
+++ b/Documentation/git-archive-tree.txt
@@ -8,7 +8,7 @@ git-archive-tree - Creates a archive of the f
 
 SYNOPSIS
 --------
-'git-archive-tree' -f {tar|zip} [--prefix=<prefix>/] [-0|...|-9]
+'git-archive-tree' -f {tar|tgz|zip} [--prefix=<prefix>/] [-0|...|-9]
 	    <tree-ish> [path...]
 
 DESCRIPTION
@@ -29,7 +29,8 @@ OPTIONS
 -------
 
 -f::
-	Format of the resulting archive, can be either 'tar' or 'zip'.
+	Format of the resulting archive, can be either 'tar', 'tgz'
+	or 'zip'.
 
 <tree-ish>::
 	The tree or commit to produce an archive for.
@@ -71,11 +72,11 @@ git archive -f tar --prefix=junk/ HEAD |
 	latest commit on the current branch, and extracts it in
 	`/var/tmp/junk` directory.
 
-git archive -f tar --prefix=git-1.4.0/ v1.4.0 | gzip >git-1.4.0.tar.gz::
+git archive -f tgz --prefix=git-1.4.0/ v1.4.0 >git-1.4.0.tar.gz::
 
 	Create a compressed tarball for v1.4.0 release.
 
-git archive -f tar --prefix=git-1.4.0/ v1.4.0{caret}\{tree\} | gzip >git-1.4.0.tar.gz::
+git archive -f tgz --prefix=git-1.4.0/ v1.4.0{caret}\{tree\} >git-1.4.0.tar.gz::
 
 	Create a compressed tarball for v1.4.0 release, but without a
 	global extended pax header.
diff --git a/archive.h b/archive.h
index 7813962..6a03864 100644
--- a/archive.h
+++ b/archive.h
@@ -3,4 +3,6 @@ #include "tree.h"
 typedef int (*write_archive_fn_t)(struct tree *tree, const unsigned char *commit_sha1, const char *prefix, time_t time, const char **pathspec);
 
 int write_tar_archive(struct tree *tree, const unsigned char *commit_sha1, const char *prefix, time_t time, const char **pathspec);
+int write_tgz_archive(struct tree *tree, const unsigned char *commit_sha1,
+                      const char *prefix, time_t time, const char **pathspec);
 int write_zip_archive(struct tree *tree, const unsigned char *commit_sha1, const char *prefix, time_t time, const char **pathspec);
diff --git a/builtin-archive-tree.c b/builtin-archive-tree.c
index 2c6ee60..f61e26d 100644
--- a/builtin-archive-tree.c
+++ b/builtin-archive-tree.c
@@ -9,12 +9,14 @@ #include "tree-walk.h"
 #include "archive.h"
 
 static const char archive_usage[] =
-"git-archive-tree -f {tar|zip} [--prefix=<prefix>/] [-0|...|-9] <tree-ish> [path...]";
+"git-archive-tree -f {tar|tgz|zip} [--prefix=<prefix>/] [-0|...|-9] <tree-ish> [path...]";
 
 static write_archive_fn_t parse_archive_format(const char *format)
 {
 	if (!strcmp(format, "tar"))
 		return write_tar_archive;
+	if (!strcmp(format, "tgz"))
+		return write_tgz_archive;
 	if (!strcmp(format, "zip"))
 		return write_zip_archive;
 	return NULL;
diff --git a/builtin-tar-tree.c b/builtin-tar-tree.c
index e0da01e..743d53a 100644
--- a/builtin-tar-tree.c
+++ b/builtin-tar-tree.c
@@ -23,6 +23,10 @@ static unsigned long offset;
 static time_t archive_time;
 static int tar_umask;
 
+static gzFile gzstdout;
+
+typedef void (*blocked_write_fn)(const void *data, unsigned long size);
+
 /* writes out the whole block, but only if it is full */
 static void write_if_needed(void)
 {
@@ -36,7 +40,7 @@ static void write_if_needed(void)
  * queues up writes, so that all our write(2) calls write exactly one
  * full block; pads writes to RECORDSIZE
  */
-static void write_blocked(const void *data, unsigned long size)
+static void do_write_blocked(const void *data, unsigned long size)
 {
 	const char *buf = data;
 	unsigned long tail;
@@ -68,19 +72,20 @@ static void write_blocked(const void *da
 	write_if_needed();
 }
 
+static blocked_write_fn write_blocked = do_write_blocked;
+
 /*
  * The end of tar archives is marked by 2*512 nul bytes and after that
  * follows the rest of the block (if any).
  */
 static void write_trailer(void)
 {
-	int tail = BLOCKSIZE - offset;
-	memset(block + offset, 0, tail);
-	write_or_die(1, block, BLOCKSIZE);
-	if (tail < 2 * RECORDSIZE) {
-		memset(block, 0, offset);
-		write_or_die(1, block, BLOCKSIZE);
-	}
+	char zeroes[RECORDSIZE];
+	memset(zeroes, 0, RECORDSIZE);
+	write_blocked(zeroes, RECORDSIZE);
+	write_blocked(zeroes, RECORDSIZE);
+	while (offset)
+		write_blocked(zeroes, RECORDSIZE);
 }
 
 static void strbuf_append_string(struct strbuf *sb, const char *s)
@@ -404,6 +409,48 @@ int write_tar_archive(struct tree *tree,
 	return 0;
 }
 
+static void write_blocked_gzip(const void *data, unsigned long size)
+{
+	const char *p = data;
+	int written;
+	unsigned long tail = size % RECORDSIZE;
+
+	while (size > 0) {
+		written = gzwrite(gzstdout, p, size);
+		if (written == 0) {
+			if (errno == EPIPE)
+				exit(0);
+			die("gzwrite error (%s)", strerror(errno));
+		}
+		size -= written;
+		p += written;
+	}
+
+	if (tail) {
+		z_off_t result = gzseek(gzstdout, RECORDSIZE - tail, SEEK_CUR);
+		if (result == -1)
+			die("gzseek error (%s)", strerror(errno));
+	}
+}
+
+int write_tgz_archive(struct tree *tree, const unsigned char *commit_sha1,
+                      const char *prefix, time_t time, const char **pathspec)
+{
+	int result;
+
+	gzstdout = gzdopen(1, "wb");
+	if (!gzstdout)
+		die("zlib is unable to open stdout");
+
+	write_blocked = write_blocked_gzip;
+	result = write_tar_archive(tree, commit_sha1, prefix, time, pathspec); 
+
+	if (gzclose(gzstdout) != Z_OK)
+		result = 1;
+
+	return result;
+}
+
 static const char *exec = "git-upload-tar";
 
 static int remote_tar(int argc, const char **argv)

-- 
VGER BF report: U 0.497484
