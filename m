From: Jeff King <peff@github.com>
Subject: Re: [PATCH 2/2] archive: support gzipped tar files
Date: Tue, 14 Jun 2011 16:45:21 -0400
Message-ID: <20110614204521.GA12776@sigill.intra.peff.net>
References: <20110614181732.GA31635@sigill.intra.peff.net>
 <20110614181821.GA32685@sigill.intra.peff.net>
 <4DF7B90B.9050802@lsrfire.ath.cx>
 <20110614201433.GB1567@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, git-dev@github.com
To: =?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Tue Jun 14 22:45:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QWaUL-0005r7-Sj
	for gcvg-git-2@lo.gmane.org; Tue, 14 Jun 2011 22:45:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753840Ab1FNUpY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jun 2011 16:45:24 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:53260
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751214Ab1FNUpX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jun 2011 16:45:23 -0400
Received: (qmail 30896 invoked by uid 107); 14 Jun 2011 20:45:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 14 Jun 2011 16:45:33 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 14 Jun 2011 16:45:21 -0400
Content-Disposition: inline
In-Reply-To: <20110614201433.GB1567@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175799>

On Tue, Jun 14, 2011 at 04:14:33PM -0400, Jeff King wrote:

> Yeah, I am unsurprised that doing it in a single process is actually
> slower. I do think because of the remote issue that we should provide
> something like this. But we could implement it by piping to an external
> gzip. That would make us just slightly less portable, but would give us
> the multi-processor speedup, or even allow using something like pigz.

So here's a relatively quick implementation of the pipe idea. It just
handles .tar.gz, but it would be trivial to do bz2 or other formats, as
long as they can act as a stdio filter.

The gzip path is not configurable at all. Probably it should read the
path and arguments from the config file. In fact, we could even allow
arbitrary config like:

  [tarfilter "tgz"]
    command = gzip -c
    extension = tgz
    extension = tar.gz

which also solves the "don't advertise in --list if you don't have it
installed problem".  At the same time, that is a lot to have to
configure for somebody who is not providing remote service and just
wants:

  git archive -o HEAD foo.tar.gz

to work out of the box.

I think we could probably allow arbitrary config, but provide a few
sane, common defaults like gzip and bz2 unless the user specifically
turns them off at build time.

---
 archive-tar.c       |   45 +++++++++++++++++++++++++++++++++++++++++++++
 archive.c           |    1 +
 archive.h           |    1 +
 builtin/archive.c   |    6 ++++++
 t/t5000-tar-tree.sh |   26 ++++++++++++++++++++++++++
 5 files changed, 79 insertions(+), 0 deletions(-)

diff --git a/archive-tar.c b/archive-tar.c
index cee06ce..a77d605 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -4,6 +4,7 @@
 #include "cache.h"
 #include "tar.h"
 #include "archive.h"
+#include "run-command.h"
 
 #define RECORDSIZE	(512)
 #define BLOCKSIZE	(RECORDSIZE * 20)
@@ -248,3 +249,47 @@ int write_tar_archive(struct archiver_args *args)
 		write_trailer();
 	return err;
 }
+
+static int write_tar_to_filter(struct archiver_args *args, const char **argv)
+{
+	struct child_process filter;
+	int r;
+
+	memset(&filter, 0, sizeof(filter));
+	filter.argv = argv;
+	filter.in = -1;
+
+	if (start_command(&filter) < 0)
+		die_errno("unable to start '%s' filter", argv[0]);
+	close(1);
+	if (dup2(filter.in, 1) < 0)
+		die_errno("unable to redirect descriptor");
+	close(filter.in);
+
+	r = write_tar_archive(args);
+
+	close(1);
+	if (finish_command(&filter) != 0)
+		die("'%s' filter reported error", argv[0]);
+
+	return r;
+}
+
+int write_tgz_archive(struct archiver_args *args)
+{
+	char compression[4];
+	const char *argv[] = {
+		"gzip",
+		"-c",
+		NULL, /* compression level */
+		NULL
+	};
+
+	if (args->compression_level >= 0) {
+		snprintf(compression, sizeof(compression),
+			 "-%d", args->compression_level);
+		argv[2] = compression;
+	}
+
+	return write_tar_to_filter(args, argv);
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
1.7.6.rc1.4.g49204
