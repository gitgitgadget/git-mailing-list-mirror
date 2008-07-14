From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 6/6] archive: remove extra arguments parsing code
Date: Mon, 14 Jul 2008 21:22:05 +0200
Message-ID: <487BA75D.7080208@lsrfire.ath.cx>
References: <487B92FC.5030103@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 14 21:36:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KITqE-0000zW-79
	for gcvg-git-2@gmane.org; Mon, 14 Jul 2008 21:36:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754847AbYGNTfN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2008 15:35:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754605AbYGNTfL
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jul 2008 15:35:11 -0400
Received: from india601.server4you.de ([85.25.151.105]:45937 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754491AbYGNTfI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2008 15:35:08 -0400
Received: from [10.0.1.200] (p57B7FF09.dip.t-dialin.net [87.183.255.9])
	by india601.server4you.de (Postfix) with ESMTPSA id A666D2F8073;
	Mon, 14 Jul 2008 21:24:15 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.14 (Windows/20080421)
In-Reply-To: <487B92FC.5030103@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88456>

Replace the code that calls backend specific argument parsers by a
simple flag mechanism.  This reduces code size and complexity.

We can add back such a mechanism (based on incremental parse_opt(),
perhaps) when we need it.  The compression level parameter, though,
is going to be shared by future compressing backends like tgz.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 archive-zip.c     |   13 -------------
 archive.h         |    6 +-----
 builtin-archive.c |   29 ++++++++++++++++-------------
 3 files changed, 17 insertions(+), 31 deletions(-)

diff --git a/archive-zip.c b/archive-zip.c
index 8131289..d56e5cf 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -282,16 +282,3 @@ int write_zip_archive(struct archiver_args *args)
 
 	return err;
 }
-
-void *parse_extra_zip_args(int argc, const char **argv)
-{
-	for (; argc > 0; argc--, argv++) {
-		const char *arg = argv[0];
-
-		if (arg[0] == '-' && isdigit(arg[1]) && arg[2] == '\0')
-			zlib_compression_level = arg[1] - '0';
-		else
-			die("Unknown argument for zip format: %s", arg);
-	}
-	return NULL;
-}
diff --git a/archive.h b/archive.h
index 88ee3be..96bb1cd 100644
--- a/archive.h
+++ b/archive.h
@@ -13,19 +13,16 @@ struct archiver_args {
 	time_t time;
 	const char **pathspec;
 	unsigned int verbose : 1;
-	void *extra;
 };
 
 typedef int (*write_archive_fn_t)(struct archiver_args *);
 
-typedef void *(*parse_extra_args_fn_t)(int argc, const char **argv);
-
 typedef int (*write_archive_entry_fn_t)(struct archiver_args *args, const unsigned char *sha1, const char *path, size_t pathlen, unsigned int mode, void *buffer, unsigned long size);
 
 struct archiver {
 	const char *name;
 	write_archive_fn_t write_archive;
-	parse_extra_args_fn_t parse_extra;
+	unsigned int flags;
 };
 
 extern int parse_archive_args(int argc, const char **argv, const struct archiver **ar, struct archiver_args *args);
@@ -41,7 +38,6 @@ extern void parse_pathspec_arg(const char **pathspec,
  */
 extern int write_tar_archive(struct archiver_args *);
 extern int write_zip_archive(struct archiver_args *);
-extern void *parse_extra_zip_args(int argc, const char **argv);
 
 extern int write_archive_entries(struct archiver_args *args, write_archive_entry_fn_t write_entry);
 
diff --git a/builtin-archive.c b/builtin-archive.c
index e7f4ec6..88204bf 100644
--- a/builtin-archive.c
+++ b/builtin-archive.c
@@ -15,9 +15,11 @@
 static const char archive_usage[] = \
 "git-archive --format=<fmt> [--prefix=<prefix>/] [--verbose] [<extra>] <tree-ish> [path...]";
 
+#define USES_ZLIB_COMPRESSION 1
+
 const struct archiver archivers[] = {
-	{ "tar", write_tar_archive, NULL },
-	{ "zip", write_zip_archive, parse_extra_zip_args },
+	{ "tar", write_tar_archive },
+	{ "zip", write_zip_archive, USES_ZLIB_COMPRESSION },
 };
 
 static int run_remote_archiver(const char *remote, int argc,
@@ -137,10 +139,9 @@ void parse_treeish_arg(const char **argv, struct archiver_args *ar_args,
 int parse_archive_args(int argc, const char **argv, const struct archiver **ar,
 		struct archiver_args *args)
 {
-	const char *extra_argv[MAX_EXTRA_ARGS];
-	int extra_argc = 0;
 	const char *format = "tar";
 	const char *base = "";
+	int compression_level = -1;
 	int verbose = 0;
 	int i;
 
@@ -168,12 +169,12 @@ int parse_archive_args(int argc, const char **argv, const struct archiver **ar,
 			i++;
 			break;
 		}
-		if (arg[0] == '-') {
-			if (extra_argc > MAX_EXTRA_ARGS - 1)
-				die("Too many extra options");
-			extra_argv[extra_argc++] = arg;
+		if (arg[0] == '-' && isdigit(arg[1]) && arg[2] == '\0') {
+			compression_level = arg[1] - '0';
 			continue;
 		}
+		if (arg[0] == '-')
+			die("Unknown argument: %s", arg);
 		break;
 	}
 
@@ -184,11 +185,13 @@ int parse_archive_args(int argc, const char **argv, const struct archiver **ar,
 	if (!*ar)
 		die("Unknown archive format '%s'", format);
 
-	if (extra_argc) {
-		if (!(*ar)->parse_extra)
-			die("'%s' format does not handle %s",
-			    (*ar)->name, extra_argv[0]);
-		args->extra = (*ar)->parse_extra(extra_argc, extra_argv);
+	if (compression_level != -1) {
+		if ((*ar)->flags & USES_ZLIB_COMPRESSION)
+			zlib_compression_level = compression_level;
+		else {
+			die("Argument not supported for format '%s': -%d",
+					format, compression_level);
+		}
 	}
 	args->verbose = verbose;
 	args->base = base;
-- 
1.5.6.2.212.g08b51
