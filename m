From: Jeff King <peff@peff.net>
Subject: [PATCHv2 5/9] archive: move file extension format-guessing lower
Date: Tue, 21 Jun 2011 21:24:48 -0400
Message-ID: <20110622012448.GE30604@sigill.intra.peff.net>
References: <20110622011923.GA30370@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	"J.H." <warthog19@eaglescrag.net>, git@vger.kernel.org,
	git-dev@github.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 22 03:24:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZCBc-000588-1l
	for gcvg-git-2@lo.gmane.org; Wed, 22 Jun 2011 03:24:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757795Ab1FVBYv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jun 2011 21:24:51 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:51550
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757729Ab1FVBYu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2011 21:24:50 -0400
Received: (qmail 7479 invoked by uid 107); 22 Jun 2011 01:25:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 21 Jun 2011 21:25:04 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 21 Jun 2011 21:24:48 -0400
Content-Disposition: inline
In-Reply-To: <20110622011923.GA30370@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176208>

The process for guessing an archive output format based on
the filename is something like this:

  a. parse --output in cmd_archive; check the filename
     against a static set of mapping heuristics (right now
     it just matches ".zip" for zip files).

  b. if found, stick a fake "--format=zip" at the beginning
     of the arguments list (if the user did specify a
     --format manually, the later option will override our
     fake one)

  c. if it's a remote call, ship the arguments to the remote
     (including the fake), which will call write_archive on
     their end

  d. if it's local, ship the arguments to write_archive
     locally

There are two problems:

  1. The set of mappings is static and at too high a level.
     The write_archive level is going to check config for
     user-defined formats, some of which will specify
     extensions. We need to delay lookup until those are
     parsed, so we can match against them.

  2. For a remote archive call, our set of mappings (or
     formats) may not match the remote side's. This is OK in
     practice right now, because all versions of git
     understand "zip" and "tar". But as new formats are
     added, there is going to be a mismatch between what the
     client can do and what the remote server can do.

To fix (1), this patch refactors the location guessing to
happen at the write_archive level, instead of the
cmd_archive level. So instead of sticking a fake --format
field in the argv list, we actually pass a "name hint" down
the callchain; this hint is used at the appropriate time to
guess the format (if one hasn't been given already).

This patch leaves (2) unfixed. The name_hint is converted to
a "--format" option as before, and passed to the remote.
This means the local side's idea of how extensions map to
formats will take precedence.

Another option would be to pass the name hint to the remote
side and let the remote choose. This isn't a good idea for
two reasons:

  1. There's no room in the protocol for passing that
     information. We can pass a new argument, but older
     versions of git on the server will choke on it.

  2. Letting the remote side decide creates a silent
     inconsistency in user experience. Consider the case
     that the locally installed git knows about the "tar.gz"
     format, but a remote server doesn't.

     Running "git archive -o foo.tar.gz" will use the tar.gz
     format. If we use --remote, and the local side chooses
     the format, then we send "--format=tar.gz" to the
     remote, which will complain about the unknown format.
     But if we let the remote side choose the format, then
     it will realize that it doesn't know about "tar.gz" and
     output uncompressed tar without even issuing a warning.

Signed-off-by: Jeff King <peff@peff.net>
---
Code same as v1, but I cleaned up the commit message to be a little less
rambling.

 archive.c                |   25 +++++++++++++++++++---
 archive.h                |    4 ++-
 builtin/archive.c        |   51 ++++++++++++++-------------------------------
 builtin/upload-archive.c |    2 +-
 4 files changed, 41 insertions(+), 41 deletions(-)

diff --git a/archive.c b/archive.c
index a0a5beb..7d0ca32 100644
--- a/archive.c
+++ b/archive.c
@@ -298,9 +298,10 @@ static void parse_treeish_arg(const char **argv,
 	  PARSE_OPT_NOARG | PARSE_OPT_NONEG | PARSE_OPT_HIDDEN, NULL, (p) }
 
 static int parse_archive_args(int argc, const char **argv,
-		const struct archiver **ar, struct archiver_args *args)
+		const struct archiver **ar, struct archiver_args *args,
+		const char *name_hint)
 {
-	const char *format = "tar";
+	const char *format = NULL;
 	const char *base = NULL;
 	const char *remote = NULL;
 	const char *exec = NULL;
@@ -359,6 +360,11 @@ static int parse_archive_args(int argc, const char **argv,
 		exit(0);
 	}
 
+	if (!format && name_hint)
+		format = archive_format_from_filename(name_hint);
+	if (!format)
+		format = "tar";
+
 	/* We need at least one parameter -- tree-ish */
 	if (argc < 1)
 		usage_with_options(archive_usage, opts);
@@ -384,7 +390,7 @@ static int parse_archive_args(int argc, const char **argv,
 }
 
 int write_archive(int argc, const char **argv, const char *prefix,
-		int setup_prefix)
+		  int setup_prefix, const char *name_hint)
 {
 	int nongit = 0;
 	const struct archiver *ar = NULL;
@@ -397,7 +403,7 @@ int write_archive(int argc, const char **argv, const char *prefix,
 	init_tar_archiver();
 	init_zip_archiver();
 
-	argc = parse_archive_args(argc, argv, &ar, &args);
+	argc = parse_archive_args(argc, argv, &ar, &args, name_hint);
 	if (nongit) {
 		/*
 		 * We know this will die() with an error, so we could just
@@ -412,3 +418,14 @@ int write_archive(int argc, const char **argv, const char *prefix,
 
 	return ar->write_archive(ar, &args);
 }
+
+const char *archive_format_from_filename(const char *filename)
+{
+	const char *ext = strrchr(filename, '.');
+	if (!ext)
+		return NULL;
+	ext++;
+	if (!strcasecmp(ext, "zip"))
+		return "zip";
+	return NULL;
+}
diff --git a/archive.h b/archive.h
index b3cf219..202d528 100644
--- a/archive.h
+++ b/archive.h
@@ -29,6 +29,8 @@ extern void init_zip_archiver(void);
 typedef int (*write_archive_entry_fn_t)(struct archiver_args *args, const unsigned char *sha1, const char *path, size_t pathlen, unsigned int mode, void *buffer, unsigned long size);
 
 extern int write_archive_entries(struct archiver_args *args, write_archive_entry_fn_t write_entry);
-extern int write_archive(int argc, const char **argv, const char *prefix, int setup_prefix);
+extern int write_archive(int argc, const char **argv, const char *prefix, int setup_prefix, const char *name_hint);
+
+const char *archive_format_from_filename(const char *filename);
 
 #endif	/* ARCHIVE_H */
diff --git a/builtin/archive.c b/builtin/archive.c
index b14eaba..2578cf5 100644
--- a/builtin/archive.c
+++ b/builtin/archive.c
@@ -24,7 +24,8 @@ static void create_output_file(const char *output_file)
 }
 
 static int run_remote_archiver(int argc, const char **argv,
-			       const char *remote, const char *exec)
+			       const char *remote, const char *exec,
+			       const char *name_hint)
 {
 	char buf[LARGE_PACKET_MAX];
 	int fd[2], i, len, rv;
@@ -37,6 +38,17 @@ static int run_remote_archiver(int argc, const char **argv,
 	transport = transport_get(_remote, _remote->url[0]);
 	transport_connect(transport, "git-upload-archive", exec, fd);
 
+	/*
+	 * Inject a fake --format field at the beginning of the
+	 * arguments, with the format inferred from our output
+	 * filename. This way explicit --format options can override
+	 * it.
+	 */
+	if (name_hint) {
+		const char *format = archive_format_from_filename(name_hint);
+		if (format)
+			packet_write(fd[1], "argument --format=%s\n", format);
+	}
 	for (i = 1; i < argc; i++)
 		packet_write(fd[1], "argument %s\n", argv[i]);
 	packet_flush(fd[1]);
@@ -63,17 +75,6 @@ static int run_remote_archiver(int argc, const char **argv,
 	return !!rv;
 }
 
-static const char *format_from_name(const char *filename)
-{
-	const char *ext = strrchr(filename, '.');
-	if (!ext)
-		return NULL;
-	ext++;
-	if (!strcasecmp(ext, "zip"))
-		return "--format=zip";
-	return NULL;
-}
-
 #define PARSE_OPT_KEEP_ALL ( PARSE_OPT_KEEP_DASHDASH | 	\
 			     PARSE_OPT_KEEP_ARGV0 | 	\
 			     PARSE_OPT_KEEP_UNKNOWN |	\
@@ -84,7 +85,6 @@ int cmd_archive(int argc, const char **argv, const char *prefix)
 	const char *exec = "git-upload-archive";
 	const char *output = NULL;
 	const char *remote = NULL;
-	const char *format_option = NULL;
 	struct option local_opts[] = {
 		OPT_STRING('o', "output", &output, "file",
 			"write the archive to this file"),
@@ -98,32 +98,13 @@ int cmd_archive(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix, local_opts, NULL,
 			     PARSE_OPT_KEEP_ALL);
 
-	if (output) {
+	if (output)
 		create_output_file(output);
-		format_option = format_from_name(output);
-	}
-
-	/*
-	 * We have enough room in argv[] to muck it in place, because
-	 * --output must have been given on the original command line
-	 * if we get to this point, and parse_options() must have eaten
-	 * it, i.e. we can add back one element to the array.
-	 *
-	 * We add a fake --format option at the beginning, with the
-	 * format inferred from our output filename.  This way explicit
-	 * --format options can override it, and the fake option is
-	 * inserted before any "--" that might have been given.
-	 */
-	if (format_option) {
-		memmove(argv + 2, argv + 1, sizeof(*argv) * argc);
-		argv[1] = format_option;
-		argv[++argc] = NULL;
-	}
 
 	if (remote)
-		return run_remote_archiver(argc, argv, remote, exec);
+		return run_remote_archiver(argc, argv, remote, exec, output);
 
 	setvbuf(stderr, NULL, _IOLBF, BUFSIZ);
 
-	return write_archive(argc, argv, prefix, 1);
+	return write_archive(argc, argv, prefix, 1, output);
 }
diff --git a/builtin/upload-archive.c b/builtin/upload-archive.c
index 73f788e..e6bb97d 100644
--- a/builtin/upload-archive.c
+++ b/builtin/upload-archive.c
@@ -64,7 +64,7 @@ static int run_upload_archive(int argc, const char **argv, const char *prefix)
 	sent_argv[sent_argc] = NULL;
 
 	/* parse all options sent by the client */
-	return write_archive(sent_argc, sent_argv, prefix, 0);
+	return write_archive(sent_argc, sent_argv, prefix, 0, NULL);
 }
 
 __attribute__((format (printf, 1, 2)))
-- 
1.7.5.4.44.g4b107
