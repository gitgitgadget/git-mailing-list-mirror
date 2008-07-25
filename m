From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 2/6] archive: move parameter parsing code to archive.c
Date: Fri, 25 Jul 2008 12:41:22 +0200
Message-ID: <1216982486-5887-2-git-send-email-rene.scharfe@lsrfire.ath.cx>
References: <1216982486-5887-1-git-send-email-rene.scharfe@lsrfire.ath.cx>
Cc: Junio C Hamano <gitster@pobox.com>, Stephan Beyer <s-beyer@gmx.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 25 12:50:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMKsh-0001aq-FY
	for gcvg-git-2@gmane.org; Fri, 25 Jul 2008 12:50:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754309AbYGYKtk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2008 06:49:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754281AbYGYKti
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jul 2008 06:49:38 -0400
Received: from india601.server4you.de ([85.25.151.105]:55538 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751819AbYGYKtd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2008 06:49:33 -0400
X-Greylist: delayed 486 seconds by postgrey-1.27 at vger.kernel.org; Fri, 25 Jul 2008 06:49:32 EDT
Received: by india601.server4you.de (Postfix, from userid 1000)
	id 4D8112F8192; Fri, 25 Jul 2008 12:41:26 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.2
In-Reply-To: <1216982486-5887-1-git-send-email-rene.scharfe@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90030>

write_archive() in archive.c is the only callsite for the command line
parsing functions located in builtin-archive.c.  Move them to the place
where they are used, un-export them and make them static, as hinted at
by Stephan.

Cc: Stephan Beyer <s-beyer@gmx.net>
Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 archive.c         |  137 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 archive.h         |    8 ---
 builtin-archive.c |  137 -----------------------------------------------------
 3 files changed, 137 insertions(+), 145 deletions(-)

diff --git a/archive.c b/archive.c
index 75eb257..c4662a2 100644
--- a/archive.c
+++ b/archive.c
@@ -1,8 +1,19 @@
 #include "cache.h"
 #include "commit.h"
+#include "tree-walk.h"
 #include "attr.h"
 #include "archive.h"
 
+static const char archive_usage[] = \
+"git archive --format=<fmt> [--prefix=<prefix>/] [--verbose] [<extra>] <tree-ish> [path...]";
+
+#define USES_ZLIB_COMPRESSION 1
+
+const struct archiver archivers[] = {
+	{ "tar", write_tar_archive },
+	{ "zip", write_zip_archive, USES_ZLIB_COMPRESSION },
+};
+
 static void format_subst(const struct commit *commit,
                          const char *src, size_t len,
                          struct strbuf *buf)
@@ -156,6 +167,132 @@ int write_archive_entries(struct archiver_args *args,
 	return err;
 }
 
+static const struct archiver *lookup_archiver(const char *name)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(archivers); i++) {
+		if (!strcmp(name, archivers[i].name))
+			return &archivers[i];
+	}
+	return NULL;
+}
+
+static void parse_pathspec_arg(const char **pathspec,
+		struct archiver_args *ar_args)
+{
+	ar_args->pathspec = get_pathspec(ar_args->base, pathspec);
+}
+
+static void parse_treeish_arg(const char **argv,
+		struct archiver_args *ar_args, const char *prefix)
+{
+	const char *name = argv[0];
+	const unsigned char *commit_sha1;
+	time_t archive_time;
+	struct tree *tree;
+	const struct commit *commit;
+	unsigned char sha1[20];
+
+	if (get_sha1(name, sha1))
+		die("Not a valid object name");
+
+	commit = lookup_commit_reference_gently(sha1, 1);
+	if (commit) {
+		commit_sha1 = commit->object.sha1;
+		archive_time = commit->date;
+	} else {
+		commit_sha1 = NULL;
+		archive_time = time(NULL);
+	}
+
+	tree = parse_tree_indirect(sha1);
+	if (tree == NULL)
+		die("not a tree object");
+
+	if (prefix) {
+		unsigned char tree_sha1[20];
+		unsigned int mode;
+		int err;
+
+		err = get_tree_entry(tree->object.sha1, prefix,
+				     tree_sha1, &mode);
+		if (err || !S_ISDIR(mode))
+			die("current working directory is untracked");
+
+		tree = parse_tree_indirect(tree_sha1);
+	}
+	ar_args->tree = tree;
+	ar_args->commit_sha1 = commit_sha1;
+	ar_args->commit = commit;
+	ar_args->time = archive_time;
+}
+
+static int parse_archive_args(int argc, const char **argv,
+		const struct archiver **ar, struct archiver_args *args)
+{
+	const char *format = "tar";
+	const char *base = "";
+	int compression_level = -1;
+	int verbose = 0;
+	int i;
+
+	for (i = 1; i < argc; i++) {
+		const char *arg = argv[i];
+
+		if (!strcmp(arg, "--list") || !strcmp(arg, "-l")) {
+			for (i = 0; i < ARRAY_SIZE(archivers); i++)
+				printf("%s\n", archivers[i].name);
+			exit(0);
+		}
+		if (!strcmp(arg, "--verbose") || !strcmp(arg, "-v")) {
+			verbose = 1;
+			continue;
+		}
+		if (!prefixcmp(arg, "--format=")) {
+			format = arg + 9;
+			continue;
+		}
+		if (!prefixcmp(arg, "--prefix=")) {
+			base = arg + 9;
+			continue;
+		}
+		if (!strcmp(arg, "--")) {
+			i++;
+			break;
+		}
+		if (arg[0] == '-' && isdigit(arg[1]) && arg[2] == '\0') {
+			compression_level = arg[1] - '0';
+			continue;
+		}
+		if (arg[0] == '-')
+			die("Unknown argument: %s", arg);
+		break;
+	}
+
+	/* We need at least one parameter -- tree-ish */
+	if (argc - 1 < i)
+		usage(archive_usage);
+	*ar = lookup_archiver(format);
+	if (!*ar)
+		die("Unknown archive format '%s'", format);
+
+	args->compression_level = Z_DEFAULT_COMPRESSION;
+	if (compression_level != -1) {
+		if ((*ar)->flags & USES_ZLIB_COMPRESSION)
+			args->compression_level = compression_level;
+		else {
+			die("Argument not supported for format '%s': -%d",
+					format, compression_level);
+		}
+	}
+	args->verbose = verbose;
+	args->base = base;
+	args->baselen = strlen(base);
+
+	return i;
+}
+
 int write_archive(int argc, const char **argv, const char *prefix,
 		int setup_prefix)
 {
diff --git a/archive.h b/archive.h
index 6b5fe5a..f6ceaeb 100644
--- a/archive.h
+++ b/archive.h
@@ -26,14 +26,6 @@ struct archiver {
 	unsigned int flags;
 };
 
-extern int parse_archive_args(int argc, const char **argv, const struct archiver **ar, struct archiver_args *args);
-
-extern void parse_treeish_arg(const char **treeish,
-			      struct archiver_args *ar_args,
-			      const char *prefix);
-
-extern void parse_pathspec_arg(const char **pathspec,
-			       struct archiver_args *args);
 /*
  * Archive-format specific backends.
  */
diff --git a/builtin-archive.c b/builtin-archive.c
index 502b339..4dd2716 100644
--- a/builtin-archive.c
+++ b/builtin-archive.c
@@ -5,21 +5,9 @@
 #include "cache.h"
 #include "builtin.h"
 #include "archive.h"
-#include "commit.h"
-#include "tree-walk.h"
 #include "pkt-line.h"
 #include "sideband.h"
 
-static const char archive_usage[] = \
-"git archive --format=<fmt> [--prefix=<prefix>/] [--verbose] [<extra>] <tree-ish> [path...]";
-
-#define USES_ZLIB_COMPRESSION 1
-
-const struct archiver archivers[] = {
-	{ "tar", write_tar_archive },
-	{ "zip", write_zip_archive, USES_ZLIB_COMPRESSION },
-};
-
 static int run_remote_archiver(const char *remote, int argc,
 			       const char **argv)
 {
@@ -74,131 +62,6 @@ static int run_remote_archiver(const char *remote, int argc,
 	return !!rv;
 }
 
-static const struct archiver *lookup_archiver(const char *name)
-{
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(archivers); i++) {
-		if (!strcmp(name, archivers[i].name))
-			return &archivers[i];
-	}
-	return NULL;
-}
-
-void parse_pathspec_arg(const char **pathspec, struct archiver_args *ar_args)
-{
-	ar_args->pathspec = get_pathspec(ar_args->base, pathspec);
-}
-
-void parse_treeish_arg(const char **argv, struct archiver_args *ar_args,
-		       const char *prefix)
-{
-	const char *name = argv[0];
-	const unsigned char *commit_sha1;
-	time_t archive_time;
-	struct tree *tree;
-	const struct commit *commit;
-	unsigned char sha1[20];
-
-	if (get_sha1(name, sha1))
-		die("Not a valid object name");
-
-	commit = lookup_commit_reference_gently(sha1, 1);
-	if (commit) {
-		commit_sha1 = commit->object.sha1;
-		archive_time = commit->date;
-	} else {
-		commit_sha1 = NULL;
-		archive_time = time(NULL);
-	}
-
-	tree = parse_tree_indirect(sha1);
-	if (tree == NULL)
-		die("not a tree object");
-
-	if (prefix) {
-		unsigned char tree_sha1[20];
-		unsigned int mode;
-		int err;
-
-		err = get_tree_entry(tree->object.sha1, prefix,
-				     tree_sha1, &mode);
-		if (err || !S_ISDIR(mode))
-			die("current working directory is untracked");
-
-		tree = parse_tree_indirect(tree_sha1);
-	}
-	ar_args->tree = tree;
-	ar_args->commit_sha1 = commit_sha1;
-	ar_args->commit = commit;
-	ar_args->time = archive_time;
-}
-
-int parse_archive_args(int argc, const char **argv, const struct archiver **ar,
-		struct archiver_args *args)
-{
-	const char *format = "tar";
-	const char *base = "";
-	int compression_level = -1;
-	int verbose = 0;
-	int i;
-
-	for (i = 1; i < argc; i++) {
-		const char *arg = argv[i];
-
-		if (!strcmp(arg, "--list") || !strcmp(arg, "-l")) {
-			for (i = 0; i < ARRAY_SIZE(archivers); i++)
-				printf("%s\n", archivers[i].name);
-			exit(0);
-		}
-		if (!strcmp(arg, "--verbose") || !strcmp(arg, "-v")) {
-			verbose = 1;
-			continue;
-		}
-		if (!prefixcmp(arg, "--format=")) {
-			format = arg + 9;
-			continue;
-		}
-		if (!prefixcmp(arg, "--prefix=")) {
-			base = arg + 9;
-			continue;
-		}
-		if (!strcmp(arg, "--")) {
-			i++;
-			break;
-		}
-		if (arg[0] == '-' && isdigit(arg[1]) && arg[2] == '\0') {
-			compression_level = arg[1] - '0';
-			continue;
-		}
-		if (arg[0] == '-')
-			die("Unknown argument: %s", arg);
-		break;
-	}
-
-	/* We need at least one parameter -- tree-ish */
-	if (argc - 1 < i)
-		usage(archive_usage);
-	*ar = lookup_archiver(format);
-	if (!*ar)
-		die("Unknown archive format '%s'", format);
-
-	args->compression_level = Z_DEFAULT_COMPRESSION;
-	if (compression_level != -1) {
-		if ((*ar)->flags & USES_ZLIB_COMPRESSION)
-			args->compression_level = compression_level;
-		else {
-			die("Argument not supported for format '%s': -%d",
-					format, compression_level);
-		}
-	}
-	args->verbose = verbose;
-	args->base = base;
-	args->baselen = strlen(base);
-
-	return i;
-}
-
 static const char *extract_remote_arg(int *ac, const char **av)
 {
 	int ix, iy, cnt = *ac;
-- 
1.6.0.rc0.42.g186458
