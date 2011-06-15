From: Jeff King <peff@peff.net>
Subject: [PATCH 5/7] archive: refactor format-guessing from filename
Date: Wed, 15 Jun 2011 18:34:07 -0400
Message-ID: <20110615223407.GE16807@sigill.intra.peff.net>
References: <20110615223030.GA16110@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"J.H." <warthog19@eaglescrag.net>, git@vger.kernel.org,
	git-dev@github.com
To: =?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Thu Jun 16 00:34:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QWyfA-0008P0-CX
	for gcvg-git-2@lo.gmane.org; Thu, 16 Jun 2011 00:34:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754622Ab1FOWeL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jun 2011 18:34:11 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:45252
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753534Ab1FOWeJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jun 2011 18:34:09 -0400
Received: (qmail 7569 invoked by uid 107); 15 Jun 2011 22:34:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 15 Jun 2011 18:34:20 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 15 Jun 2011 18:34:07 -0400
Content-Disposition: inline
In-Reply-To: <20110615223030.GA16110@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175861>

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
a "--format" option as before, and passed to the remote.  We
could in theory pass the name hint to the remote side and
let it decide which format to use. But that introduces a
compatibility problem, as we have no place to put that
information during the remote call without adding a new
"--name-hint=" argument. An older version of git would choke
on that, and the client has no way of knowing if the server
is new enough or not (i.e., there is no capabilities
advertisement, as there is with the git protocol itself).

On top of this, it's unclear whether the remote side should
be in charge of format selection, anyway. There is a minor
information leak; the server will learn about the filename
you are using to save. If we sent just the basename, though,
that would lessen the leak and still give the remote side
enough information to make a decision.

But more important is that the name hint is only a hint, and
we default to the tar format. Which means that
inconsistencies between the client's and server's set of
formats will have confusing results. For example, imagine
the client learns about "tar.gz" as an extension for gzip'd
tar ("tgz") files, but the server does not. Locally,
running:

  git archive -o file.tar.gz HEAD

will produce a gzip'd file. If we make the mapping decision
locally, then running:

  git archive --remote=origin -o file.tar.gz HEAD

will send "--format=tgz" to the remote side. The server will
complain, saying that it doesn't know about the tgz format.

If we instead send the name hint to the remote side and let
it make the decision, it will not know what ".tar.gz" is,
and will silently default to a plain tar, without the user
even realizing it.

The flip side of this is an old client talking to a new
server (i.e., only the servers knows about ".tar.gz"). If we
map the filename remotely, then the user is happy. If we map
it locally, though, we will send the server no --format and
it will silently default to tar.

So the question is: should the mapping of filenames to
formats be consistent for a single client (i.e., doing it
locally or against a remote will either produce the same
format, or report an error if the remote does not support
the format), or should it be consistent for multiple clients
hitting the same server (i.e., no matter what machine I am
on, if I use git-archive to hit kernel.org, I will always
see the same format for the same filename)?

I chose consistency on a single client (i.e., we do the
mapping locally), because:

  1. Using git on one machine against multiple remotes is
     more common than using git on many machines against the
     same remote. So it's less likely for the user to be
     surprised.

  2. Even if we wanted to do the reverse, it is not as
     simple as making the decision and writing some code.
     Because the server literally says nothing before we
     send it arguments, it's difficult to get
     interoperability between versions. We'd probably end up
     having to write the server side, wait sufficiently long
     for everybody to have deployed it, and then write the
     client side.

Signed-off-by: Jeff King <peff@peff.net>
---
 archive.c                |   25 +++++++++++++++++++---
 archive.h                |    4 ++-
 builtin/archive.c        |   51 ++++++++++++++-------------------------------
 builtin/upload-archive.c |    2 +-
 4 files changed, 41 insertions(+), 41 deletions(-)

diff --git a/archive.c b/archive.c
index a987936..e04f689 100644
--- a/archive.c
+++ b/archive.c
@@ -302,9 +302,10 @@ static void parse_treeish_arg(const char **argv,
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
@@ -366,6 +367,11 @@ static int parse_archive_args(int argc, const char **argv,
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
@@ -398,7 +404,7 @@ static int parse_archive_args(int argc, const char **argv,
 }
 
 int write_archive(int argc, const char **argv, const char *prefix,
-		int setup_prefix)
+		int setup_prefix, const char *name_hint)
 {
 	int nongit = 0;
 	const struct archiver *ar = NULL;
@@ -410,7 +416,7 @@ int write_archive(int argc, const char **argv, const char *prefix,
 	git_config(git_default_config, NULL);
 	tar_filter_load_config();
 
-	argc = parse_archive_args(argc, argv, &ar, &args);
+	argc = parse_archive_args(argc, argv, &ar, &args, name_hint);
 	if (nongit) {
 		/*
 		 * We know this will die() with an error, so we could just
@@ -425,3 +431,14 @@ int write_archive(int argc, const char **argv, const char *prefix,
 
 	return ar->write_archive(&args);
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
index fb2bb9e..894d4c4 100644
--- a/archive.h
+++ b/archive.h
@@ -29,7 +29,7 @@ extern int write_zip_archive(struct archiver_args *);
 extern int write_tar_filter_archive(struct archiver_args *);
 
 extern int write_archive_entries(struct archiver_args *args, write_archive_entry_fn_t write_entry);
-extern int write_archive(int argc, const char **argv, const char *prefix, int setup_prefix);
+extern int write_archive(int argc, const char **argv, const char *prefix, int setup_prefix, const char *name_hint);
 
 struct tar_filter {
 	char *name;
@@ -44,4 +44,6 @@ extern struct tar_filter *tar_filter_by_name(const char *name);
 
 extern void tar_filter_load_config(void);
 
+const char *archive_format_from_filename(const char *filename);
+
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
1.7.6.rc1.4.g49204
