From: Jeff King <peff@peff.net>
Subject: [PATCH 2/2] archive: support gzipped tar files
Date: Tue, 14 Jun 2011 14:18:21 -0400
Message-ID: <20110614181821.GA32685@sigill.intra.peff.net>
References: <20110614181732.GA31635@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	git-dev@github.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 14 20:18:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QWYC7-0007J6-Gp
	for gcvg-git-2@lo.gmane.org; Tue, 14 Jun 2011 20:18:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752874Ab1FNSSY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jun 2011 14:18:24 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:48376
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752798Ab1FNSSX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jun 2011 14:18:23 -0400
Received: (qmail 29051 invoked by uid 107); 14 Jun 2011 18:18:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 14 Jun 2011 14:18:33 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 14 Jun 2011 14:18:21 -0400
Content-Disposition: inline
In-Reply-To: <20110614181732.GA31635@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175786>

git-archive already supports the creation of tar files. For
local cases, one can simply pipe the output to gzip, and
having git-archive do the gzip is a minor convenience.

However, when running git-archive against a remote site,
having the remote side do the compression can save
considerable bandwidth. Service providers could always wrap
git-archive to provide that functionality, but this makes it
much simpler.

Creating gzipped archives is of course more expensive than
regular tar archives; however, the amount of work should be
comparable to that of creating a zip file, which is already
possible. So there should be no new security implications
with respect to creating load on a remote server.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/git-archive.txt |   17 +++++++++++++++--
 archive-tar.c                 |   27 +++++++++++++++++++++++++++
 archive.c                     |    1 +
 archive.h                     |    1 +
 builtin/archive.c             |    6 ++++++
 t/t5000-tar-tree.sh           |   26 ++++++++++++++++++++++++++
 6 files changed, 76 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-archive.txt b/Documentation/git-archive.txt
index 9c750e2..963bec4 100644
--- a/Documentation/git-archive.txt
+++ b/Documentation/git-archive.txt
@@ -34,10 +34,11 @@ OPTIONS
 -------
 
 --format=<fmt>::
-	Format of the resulting archive: 'tar' or 'zip'. If this option
+	Format of the resulting archive: 'tar', 'tgz', or 'zip'. If this option
 	is not given, and the output file is specified, the format is
 	inferred from the filename if possible (e.g. writing to "foo.zip"
-	makes the output to be in the zip format). Otherwise the output
+	creates the output in the zip format; "foo.tgz" or "foo.tar.gz"
+	creates the output in the tgz format). Otherwise the output
 	format is `tar`.
 
 -l::
@@ -89,6 +90,12 @@ zip
 	Highest and slowest compression level.  You can specify any
 	number from 1 to 9 to adjust compression speed and ratio.
 
+tgz
+~~~
+-9::
+	Highest and slowest compression level. You can specify any
+	number from 1 to 9 to adjust compression speed and ratio.
+
 
 CONFIGURATION
 -------------
@@ -133,6 +140,12 @@ git archive --format=tar --prefix=git-1.4.0/ v1.4.0 | gzip >git-1.4.0.tar.gz::
 
 	Create a compressed tarball for v1.4.0 release.
 
+git archive --prefix=git-1.4.0/ -o git-1.4.0.tar.gz v1.4.0
+
+	Same as above, except that we use the internal gzip. Note that
+	the output format is inferred by the extension of the output
+	file.
+
 git archive --format=tar --prefix=git-1.4.0/ v1.4.0{caret}\{tree\} | gzip >git-1.4.0.tar.gz::
 
 	Create a compressed tarball for v1.4.0 release, but without a
diff --git a/archive-tar.c b/archive-tar.c
index b1aea87..86c8aa9 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -260,3 +260,30 @@ int write_tar_archive(struct archiver_args *args)
 	output = output_write;
 	return write_tar_archive_internal(args);
 }
+
+static gzFile gz_file;
+static void output_gz(const char *buf, unsigned long len)
+{
+	if (!gzwrite(gz_file, buf, len))
+		die("unable to write compressed stream: %s",
+		    gzerror(gz_file, NULL));
+}
+
+int write_tgz_archive(struct archiver_args *args)
+{
+	int r;
+
+	gz_file = gzdopen(1, "w");
+	if (!gz_file)
+		die_errno("unable to open compressed stream");
+	gzsetparams(gz_file, args->compression_level, Z_DEFAULT_STRATEGY);
+
+	output = output_gz;
+	r = write_tar_archive_internal(args);
+	if (r == 0) {
+		int zerr = gzclose(gz_file);
+		if (zerr != Z_OK)
+			die("unable to write compressed stream (err=%d)", zerr);
+	}
+	return r;
+}
diff --git a/archive.c b/archive.c
index 42f2d2f..6073a8d 100644
--- a/archive.c
+++ b/archive.c
@@ -23,6 +23,7 @@ static const struct archiver {
 } archivers[] = {
 	{ "tar", write_tar_archive },
 	{ "zip", write_zip_archive, USES_ZLIB_COMPRESSION },
+	{ "tgz", write_tgz_archive, USES_ZLIB_COMPRESSION },
 };
 
 static void format_subst(const struct commit *commit,
diff --git a/archive.h b/archive.h
index 038ac35..c1bf72e 100644
--- a/archive.h
+++ b/archive.h
@@ -23,6 +23,7 @@ typedef int (*write_archive_entry_fn_t)(struct archiver_args *args, const unsign
  */
 extern int write_tar_archive(struct archiver_args *);
 extern int write_zip_archive(struct archiver_args *);
+extern int write_tgz_archive(struct archiver_args *);
 
 extern int write_archive_entries(struct archiver_args *args, write_archive_entry_fn_t write_entry);
 extern int write_archive(int argc, const char **argv, const char *prefix, int setup_prefix);
diff --git a/builtin/archive.c b/builtin/archive.c
index b14eaba..4f60af5 100644
--- a/builtin/archive.c
+++ b/builtin/archive.c
@@ -71,6 +71,12 @@ static const char *format_from_name(const char *filename)
 	ext++;
 	if (!strcasecmp(ext, "zip"))
 		return "--format=zip";
+	if (!strcasecmp(ext, "tgz"))
+		return "--format=tgz";
+	if (!strcasecmp(ext, "gz") &&
+	    ext - 4 >= filename &&
+	    !strcasecmp(ext - 4, "tar.gz"))
+		return "--format=tgz";
 	return NULL;
 }
 
diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
index cff1b3e..faf2784 100755
--- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -26,6 +26,7 @@ commit id embedding:
 
 . ./test-lib.sh
 UNZIP=${UNZIP:-unzip}
+GUNZIP=${GUNZIP:-gunzip}
 
 SUBSTFORMAT=%H%n
 
@@ -252,4 +253,29 @@ test_expect_success 'git-archive --prefix=olde-' '
 	test -f h/olde-a/bin/sh
 '
 
+test_expect_success 'git archive --format=tgz' '
+	git archive --format=tgz HEAD >e.tgz
+'
+
+test_expect_success 'infer tgz from .tgz filename' '
+	git archive --output=e1.tgz HEAD &&
+	test_cmp e.tgz e1.tgz
+'
+
+test_expect_success 'infer tgz from .tar.gz filename' '
+	git archive --output=e2.tar.gz HEAD &&
+	test_cmp e.tgz e2.tar.gz
+'
+
+if $GUNZIP --version >/dev/null 2>&1; then
+	test_set_prereq GUNZIP
+else
+	say "Skipping tgz tests because gunzip was not found"
+fi
+
+test_expect_success GUNZIP 'extract tgz file' '
+	gunzip -c <e.tgz >e.tar &&
+	test_cmp b.tar e.tar
+'
+
 test_done
-- 
1.7.6.rc1.37.g6d4ed.dirty
