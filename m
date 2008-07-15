From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 1/6] archive: remove args member from struct archiver
Date: Tue, 15 Jul 2008 09:49:40 +0200
Message-ID: <487C5694.7050607@lsrfire.ath.cx>
References: <487B8E81.5030402@lsrfire.ath.cx> <487BA7C1.3000109@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Tue Jul 15 09:50:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIfJA-0005XK-4L
	for gcvg-git-2@gmane.org; Tue, 15 Jul 2008 09:50:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751002AbYGOHtp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2008 03:49:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754597AbYGOHto
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jul 2008 03:49:44 -0400
Received: from india601.server4you.de ([85.25.151.105]:42494 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754780AbYGOHtm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2008 03:49:42 -0400
Received: from [10.0.1.200] (p57B7DD33.dip.t-dialin.net [87.183.221.51])
	by india601.server4you.de (Postfix) with ESMTPSA id 61BA52F80A7;
	Tue, 15 Jul 2008 09:49:41 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.14 (Windows/20080421)
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <487BA7C1.3000109@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88533>

[Resent with fixed line wrap.]
Pass struct archiver and struct archiver_args explicitly to parse_archive_args
and remove the latter from the former.  This allows us to get rid of struct
archiver_desc and simplifies the code a bit.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 archive.h                |    5 +---
 builtin-archive.c        |   51 +++++++++++++++++++---------------------------
 builtin-upload-archive.c |   11 +++++----
 3 files changed, 28 insertions(+), 39 deletions(-)

diff --git a/archive.h b/archive.h
index ddf004a..1b24ae3 100644
--- a/archive.h
+++ b/archive.h
@@ -21,14 +21,11 @@ typedef void *(*parse_extra_args_fn_t)(int argc, const char **argv);
 
 struct archiver {
 	const char *name;
-	struct archiver_args args;
 	write_archive_fn_t write_archive;
 	parse_extra_args_fn_t parse_extra;
 };
 
-extern int parse_archive_args(int argc,
-			      const char **argv,
-			      struct archiver *ar);
+extern int parse_archive_args(int argc, const char **argv, const struct archiver **ar, struct archiver_args *args);
 
 extern void parse_treeish_arg(const char **treeish,
 			      struct archiver_args *ar_args,
diff --git a/builtin-archive.c b/builtin-archive.c
index c2e0c1e..6ee3677 100644
--- a/builtin-archive.c
+++ b/builtin-archive.c
@@ -15,12 +15,7 @@
 static const char archive_usage[] = \
 "git-archive --format=<fmt> [--prefix=<prefix>/] [--verbose] [<extra>] <tree-ish> [path...]";
 
-static struct archiver_desc
-{
-	const char *name;
-	write_archive_fn_t write_archive;
-	parse_extra_args_fn_t parse_extra;
-} archivers[] = {
+const struct archiver archivers[] = {
 	{ "tar", write_tar_archive, NULL },
 	{ "zip", write_zip_archive, parse_extra_zip_args },
 };
@@ -79,21 +74,15 @@ static int run_remote_archiver(const char *remote, int argc,
 	return !!rv;
 }
 
-static int init_archiver(const char *name, struct archiver *ar)
+static const struct archiver *lookup_archiver(const char *name)
 {
-	int rv = -1, i;
+	int i;
 
 	for (i = 0; i < ARRAY_SIZE(archivers); i++) {
-		if (!strcmp(name, archivers[i].name)) {
-			memset(ar, 0, sizeof(*ar));
-			ar->name = archivers[i].name;
-			ar->write_archive = archivers[i].write_archive;
-			ar->parse_extra = archivers[i].parse_extra;
-			rv = 0;
-			break;
-		}
+		if (!strcmp(name, archivers[i].name))
+			return &archivers[i];
 	}
-	return rv;
+	return NULL;
 }
 
 void parse_pathspec_arg(const char **pathspec, struct archiver_args *ar_args)
@@ -145,7 +134,8 @@ void parse_treeish_arg(const char **argv, struct archiver_args *ar_args,
 	ar_args->time = archive_time;
 }
 
-int parse_archive_args(int argc, const char **argv, struct archiver *ar)
+int parse_archive_args(int argc, const char **argv, const struct archiver **ar,
+		struct archiver_args *args)
 {
 	const char *extra_argv[MAX_EXTRA_ARGS];
 	int extra_argc = 0;
@@ -190,17 +180,18 @@ int parse_archive_args(int argc, const char **argv, struct archiver *ar)
 	/* We need at least one parameter -- tree-ish */
 	if (argc - 1 < i)
 		usage(archive_usage);
-	if (init_archiver(format, ar) < 0)
+	*ar = lookup_archiver(format);
+	if (!*ar)
 		die("Unknown archive format '%s'", format);
 
 	if (extra_argc) {
-		if (!ar->parse_extra)
+		if (!(*ar)->parse_extra)
 			die("'%s' format does not handle %s",
-			    ar->name, extra_argv[0]);
-		ar->args.extra = ar->parse_extra(extra_argc, extra_argv);
+			    (*ar)->name, extra_argv[0]);
+		args->extra = (*ar)->parse_extra(extra_argc, extra_argv);
 	}
-	ar->args.verbose = verbose;
-	ar->args.base = base;
+	args->verbose = verbose;
+	args->base = base;
 
 	return i;
 }
@@ -238,7 +229,8 @@ static const char *extract_remote_arg(int *ac, const char **av)
 
 int cmd_archive(int argc, const char **argv, const char *prefix)
 {
-	struct archiver ar;
+	const struct archiver *ar = NULL;
+	struct archiver_args args;
 	int tree_idx;
 	const char *remote = NULL;
 
@@ -248,14 +240,13 @@ int cmd_archive(int argc, const char **argv, const char *prefix)
 
 	setvbuf(stderr, NULL, _IOLBF, BUFSIZ);
 
-	memset(&ar, 0, sizeof(ar));
-	tree_idx = parse_archive_args(argc, argv, &ar);
+	tree_idx = parse_archive_args(argc, argv, &ar, &args);
 	if (prefix == NULL)
 		prefix = setup_git_directory();
 
 	argv += tree_idx;
-	parse_treeish_arg(argv, &ar.args, prefix);
-	parse_pathspec_arg(argv + 1, &ar.args);
+	parse_treeish_arg(argv, &args, prefix);
+	parse_pathspec_arg(argv + 1, &args);
 
-	return ar.write_archive(&ar.args);
+	return ar->write_archive(&args);
 }
diff --git a/builtin-upload-archive.c b/builtin-upload-archive.c
index 371400d..295e24c 100644
--- a/builtin-upload-archive.c
+++ b/builtin-upload-archive.c
@@ -19,7 +19,8 @@ static const char lostchild[] =
 
 static int run_upload_archive(int argc, const char **argv, const char *prefix)
 {
-	struct archiver ar;
+	const struct archiver *ar;
+	struct archiver_args args;
 	const char *sent_argv[MAX_ARGS];
 	const char *arg_cmd = "argument ";
 	char *p, buf[4096];
@@ -65,12 +66,12 @@ static int run_upload_archive(int argc, const char **argv, const char *prefix)
 	sent_argv[sent_argc] = NULL;
 
 	/* parse all options sent by the client */
-	treeish_idx = parse_archive_args(sent_argc, sent_argv, &ar);
+	treeish_idx = parse_archive_args(sent_argc, sent_argv, &ar, &args);
 
-	parse_treeish_arg(sent_argv + treeish_idx, &ar.args, prefix);
-	parse_pathspec_arg(sent_argv + treeish_idx + 1, &ar.args);
+	parse_treeish_arg(sent_argv + treeish_idx, &args, prefix);
+	parse_pathspec_arg(sent_argv + treeish_idx + 1, &args);
 
-	return ar.write_archive(&ar.args);
+	return ar->write_archive(&args);
 }
 
 static void error_clnt(const char *fmt, ...)
-- 
1.5.6.2.212.g08b51
