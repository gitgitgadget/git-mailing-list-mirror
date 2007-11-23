From: Wincent Colaiuta <win@wincent.com>
Subject: [PATCH 5/7] Teach builtin-add to pass path arguments to git-add--interactive
Date: Fri, 23 Nov 2007 20:20:48 +0100
Message-ID: <1195845650-85962-6-git-send-email-win@wincent.com>
References: <1195845650-85962-1-git-send-email-win@wincent.com>
 <1195845650-85962-2-git-send-email-win@wincent.com>
 <1195845650-85962-3-git-send-email-win@wincent.com>
 <1195845650-85962-4-git-send-email-win@wincent.com>
 <1195845650-85962-5-git-send-email-win@wincent.com>
Cc: gitster@pobox.com, peff@peff.net,
	Wincent Colaiuta <win@wincent.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 23 20:22:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ive6j-0008Lf-Hw
	for gcvg-git-2@gmane.org; Fri, 23 Nov 2007 20:22:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756888AbXKWTWN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Nov 2007 14:22:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756855AbXKWTWN
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Nov 2007 14:22:13 -0500
Received: from wincent.com ([72.3.236.74]:60687 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756667AbXKWTWM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Nov 2007 14:22:12 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lANJKom2018032;
	Fri, 23 Nov 2007 13:20:59 -0600
X-Mailer: git-send-email 1.5.3.6.886.g6e20-dirty
In-Reply-To: <1195845650-85962-5-git-send-email-win@wincent.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65916>

The previous patches in the series taught git-add--interactive to handle
optional path arguments. This patch teaches builtin-add to pass
these arguments through to the script.

Signed-off-by: Wincent Colaiuta <win@wincent.com>
---
 Documentation/git-add.txt |    4 +++-
 builtin-add.c             |   23 +++++++++++++----------
 commit.h                  |    2 +-
 3 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index 63829d9..0b0ab1d 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -61,7 +61,9 @@ OPTIONS
 
 -i, \--interactive::
 	Add modified contents in the working tree interactively to
-	the index.
+	the index. Optional path arguments may be supplied to limit
+	operation to a subset of the files in the working tree.
+	See ``Interactive mode'' for details.
 
 -u::
 	Update only files that git already knows about. This is similar
diff --git a/builtin-add.c b/builtin-add.c
index cf815a0..3646a45 100644
--- a/builtin-add.c
+++ b/builtin-add.c
@@ -135,11 +135,17 @@ static void refresh(int verbose, const char **pathspec)
         free(seen);
 }
 
-int interactive_add(void)
+int interactive_add(int argc, const char **argv)
 {
-	const char *argv[2] = { "add--interactive", NULL };
-
-	return run_command_v_opt(argv, RUN_GIT_CMD);
+	int status;
+	const char **args = xmalloc(sizeof(const char *) * (argc + 1));
+	args[0] = "add--interactive";
+	memcpy((void *)args + sizeof(const char *), argv, sizeof(const char *) * argc);
+	args[argc + 1] = NULL;
+
+	status = run_command_v_opt(args, RUN_GIT_CMD);
+	free(args);
+	return status;
 }
 
 static struct lock_file lock_file;
@@ -163,17 +169,14 @@ static struct option builtin_add_options[] = {
 
 int cmd_add(int argc, const char **argv, const char *prefix)
 {
-	int i, newfd, orig_argc = argc;
+	int i, newfd = argc;
 	const char **pathspec;
 	struct dir_struct dir;
 
 	argc = parse_options(argc, argv, builtin_add_options,
 			  builtin_add_usage, 0);
-	if (add_interactive) {
-		if (add_interactive != 1 || orig_argc != 2)
-			die("add --interactive does not take any parameters");
-		exit(interactive_add());
-	}
+	if (add_interactive)
+		exit(interactive_add(argc, argv));
 
 	git_config(git_default_config);
 
diff --git a/commit.h b/commit.h
index aa67986..d82b8bc 100644
--- a/commit.h
+++ b/commit.h
@@ -113,7 +113,7 @@ extern struct commit_list *get_shallow_commits(struct object_array *heads,
 
 int in_merge_bases(struct commit *, struct commit **, int);
 
-extern int interactive_add(void);
+extern int interactive_add(int argc, const char **argv);
 extern void add_files_to_cache(int verbose, const char *prefix, const char **files);
 extern int rerere(void);
 
-- 
1.5.3.6.886.g3364
