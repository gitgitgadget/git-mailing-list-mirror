From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 5/6] Make merge-base a built-in.
Date: Tue, 09 Jan 2007 02:41:29 -0800
Message-ID: <7vd55oo52e.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Jan 09 11:41:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4EQO-0003nM-1j
	for gcvg-git@gmane.org; Tue, 09 Jan 2007 11:41:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751307AbXAIKlf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Jan 2007 05:41:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751305AbXAIKlf
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jan 2007 05:41:35 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:47976 "EHLO
	fed1rmmtao11.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751307AbXAIKla (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jan 2007 05:41:30 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070109104130.MVNY25875.fed1rmmtao11.cox.net@fed1rmimpo02.cox.net>;
          Tue, 9 Jan 2007 05:41:30 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 8yhl1W00J1kojtg0000000; Tue, 09 Jan 2007 05:41:46 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36343>


Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 Makefile             |    2 +-
 builtin-merge-base.c |   87 +++++++++++++++++++++++++++++++++++++++++++++++++
 builtin.h            |    1 +
 git.c                |    1 +
 merge-base.c         |   88 --------------------------------------------------
 5 files changed, 90 insertions(+), 89 deletions(-)

diff --git a/Makefile b/Makefile
index 6c12bc6..7fcc3ff 100644
--- a/Makefile
+++ b/Makefile
@@ -191,7 +191,6 @@ SCRIPTS = $(patsubst %.sh,%,$(SCRIPT_SH)) \
 PROGRAMS = \
 	git-convert-objects$X git-fetch-pack$X git-fsck-objects$X \
 	git-hash-object$X git-index-pack$X git-local-fetch$X \
-	git-merge-base$X \
 	git-daemon$X \
 	git-merge-index$X git-mktag$X git-mktree$X git-patch-id$X \
 	git-peek-remote$X git-receive-pack$X \
@@ -286,6 +285,7 @@ BUILTIN_OBJS = \
 	builtin-ls-tree.o \
 	builtin-mailinfo.o \
 	builtin-mailsplit.o \
+	builtin-merge-base.o \
 	builtin-merge-file.o \
 	builtin-mv.o \
 	builtin-name-rev.o \
diff --git a/builtin-merge-base.c b/builtin-merge-base.c
new file mode 100644
index 0000000..fa07352
--- /dev/null
+++ b/builtin-merge-base.c
@@ -0,0 +1,87 @@
+#include "cache.h"
+#include "commit.h"
+
+static const char merge_base_usage[] =
+"git-merge-base [--all] <commit> <commit> | --check-ancestry <commit> <commit>...";
+
+static int show_merge_base(struct commit *rev1, struct commit *rev2, int show_all)
+{
+	struct commit_list *result = get_merge_bases(rev1, rev2, 0);
+
+	if (!result)
+		return 1;
+
+	while (result) {
+		printf("%s\n", sha1_to_hex(result->item->object.sha1));
+		if (!show_all)
+			return 0;
+		result = result->next;
+	}
+
+	return 0;
+}
+
+static int check_ancestry(int argc, const char **argv)
+{
+	struct commit *one, *two, **reference;
+	unsigned char sha1[20];
+	int i;
+
+	if (argc < 2)
+		usage(merge_base_usage);
+	if (get_sha1(argv[0], sha1))
+		die("Not a valid object name %s", argv[0]);
+	one = lookup_commit_reference(sha1);
+	if (!one)
+		return 1;
+
+	reference = xcalloc(argc - 1, sizeof(struct commit *));
+	for (i = 1; i < argc; i++) {
+		if (get_sha1(argv[i], sha1))
+			die("Not a valid object name %s", argv[i]);
+		two = lookup_commit_reference(sha1);
+		if (!two)
+			return 1;
+		reference[i - 1] = two;
+	}
+	return !!in_merge_bases(one, reference, argc - 1);
+}
+
+int cmd_merge_base(int argc, const char **argv, const char *prefix)
+{
+	struct commit *rev1, *rev2;
+	unsigned char rev1key[20], rev2key[20];
+	int show_all = 0;
+	int check = 0;
+
+	git_config(git_default_config);
+
+	while (1 < argc && argv[1][0] == '-') {
+		const char *arg = argv[1];
+		if (!strcmp(arg, "-a") || !strcmp(arg, "--all"))
+			show_all = 1;
+		else if (!strcmp(arg, "-c") || !strcmp(arg, "--check-ancestry"))
+			check = 1;
+		else
+			usage(merge_base_usage);
+		argc--; argv++;
+	}
+
+	if (check) {
+		if (show_all)
+			die("--all and --check-ancestry are mutually incompatible");
+		return check_ancestry(argc - 1, argv + 1);
+	}
+
+	if (argc != 3)
+		usage(merge_base_usage);
+	if (get_sha1(argv[1], rev1key))
+		die("Not a valid object name %s", argv[1]);
+	if (get_sha1(argv[2], rev2key))
+		die("Not a valid object name %s", argv[2]);
+	rev1 = lookup_commit_reference(rev1key);
+	rev2 = lookup_commit_reference(rev2key);
+	if (!rev1 || !rev2)
+		return 1;
+	return show_merge_base(rev1, rev2, show_all);
+}
diff --git a/builtin.h b/builtin.h
index df72d09..ae32993 100644
--- a/builtin.h
+++ b/builtin.h
@@ -42,6 +42,7 @@ extern int cmd_ls_files(int argc, const char **argv, const char *prefix);
 extern int cmd_ls_tree(int argc, const char **argv, const char *prefix);
 extern int cmd_mailinfo(int argc, const char **argv, const char *prefix);
 extern int cmd_mailsplit(int argc, const char **argv, const char *prefix);
+extern int cmd_merge_base(int argc, const char **argv, const char *prefix);
 extern int cmd_merge_file(int argc, const char **argv, const char *prefix);
 extern int cmd_mv(int argc, const char **argv, const char *prefix);
 extern int cmd_name_rev(int argc, const char **argv, const char *prefix);
diff --git a/git.c b/git.c
index bf55499..e7bc79a 100644
--- a/git.c
+++ b/git.c
@@ -238,6 +238,7 @@ static void handle_internal_command(int argc, const char **argv, char **envp)
 		{ "ls-tree", cmd_ls_tree, RUN_SETUP },
 		{ "mailinfo", cmd_mailinfo },
 		{ "mailsplit", cmd_mailsplit },
+		{ "merge-base", cmd_merge_base, RUN_SETUP },
 		{ "merge-file", cmd_merge_file },
 		{ "mv", cmd_mv, RUN_SETUP },
 		{ "name-rev", cmd_name_rev, RUN_SETUP },
diff --git a/merge-base.c b/merge-base.c
deleted file mode 100644
index bc478eb..0000000
--- a/merge-base.c
+++ /dev/null
@@ -1,88 +0,0 @@
-#include "cache.h"
-#include "commit.h"
-
-static int show_all;
-static const char merge_base_usage[] =
-"git-merge-base [--all] <commit> <commit> | --check-ancestry <commit> <commit>...";
-
-static int merge_base(struct commit *rev1, struct commit *rev2)
-{
-	struct commit_list *result = get_merge_bases(rev1, rev2, 0);
-
-	if (!result)
-		return 1;
-
-	while (result) {
-		printf("%s\n", sha1_to_hex(result->item->object.sha1));
-		if (!show_all)
-			return 0;
-		result = result->next;
-	}
-
-	return 0;
-}
-
-static int check_ancestry(int argc, char **argv)
-{
-	struct commit *one, *two, **reference;
-	unsigned char sha1[20];
-	int i;
-
-	if (argc < 2)
-		usage(merge_base_usage);
-	if (get_sha1(argv[0], sha1))
-		die("Not a valid object name %s", argv[0]);
-	one = lookup_commit_reference(sha1);
-	if (!one)
-		return 1;
-
-	reference = xcalloc(argc - 1, sizeof(struct commit *));
-	for (i = 1; i < argc; i++) {
-		if (get_sha1(argv[i], sha1))
-			die("Not a valid object name %s", argv[i]);
-		two = lookup_commit_reference(sha1);
-		if (!two)
-			return 1;
-		reference[i - 1] = two;
-	}
-	return !!in_merge_bases(one, reference, argc - 1);
-}
-
-int main(int argc, char **argv)
-{
-	struct commit *rev1, *rev2;
-	unsigned char rev1key[20], rev2key[20];
-	int check = 0;
-
-	setup_git_directory();
-	git_config(git_default_config);
-
-	while (1 < argc && argv[1][0] == '-') {
-		char *arg = argv[1];
-		if (!strcmp(arg, "-a") || !strcmp(arg, "--all"))
-			show_all = 1;
-		else if (!strcmp(arg, "-c") || !strcmp(arg, "--check-ancestry"))
-			check = 1;
-		else
-			usage(merge_base_usage);
-		argc--; argv++;
-	}
-
-	if (check) {
-		if (show_all)
-			die("--all and --check-ancestry are mutually incompatible");
-		return check_ancestry(argc - 1, argv + 1);
-	}
-
-	if (argc != 3)
-		usage(merge_base_usage);
-	if (get_sha1(argv[1], rev1key))
-		die("Not a valid object name %s", argv[1]);
-	if (get_sha1(argv[2], rev2key))
-		die("Not a valid object name %s", argv[2]);
-	rev1 = lookup_commit_reference(rev1key);
-	rev2 = lookup_commit_reference(rev2key);
-	if (!rev1 || !rev2)
-		return 1;
-	return merge_base(rev1, rev2);
-}
-- 
1.4.4.4.g564d
