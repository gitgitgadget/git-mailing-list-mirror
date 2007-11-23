From: Wincent Colaiuta <win@wincent.com>
Subject: [PATCH 7/7] Teach builtin-add to handle "--patch" option
Date: Fri, 23 Nov 2007 20:20:50 +0100
Message-ID: <1195845650-85962-8-git-send-email-win@wincent.com>
References: <1195845650-85962-1-git-send-email-win@wincent.com>
 <1195845650-85962-2-git-send-email-win@wincent.com>
 <1195845650-85962-3-git-send-email-win@wincent.com>
 <1195845650-85962-4-git-send-email-win@wincent.com>
 <1195845650-85962-5-git-send-email-win@wincent.com>
 <1195845650-85962-6-git-send-email-win@wincent.com>
 <1195845650-85962-7-git-send-email-win@wincent.com>
Cc: gitster@pobox.com, peff@peff.net,
	Wincent Colaiuta <win@wincent.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 23 20:22:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ive6L-0008CJ-Ct
	for gcvg-git-2@gmane.org; Fri, 23 Nov 2007 20:22:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756838AbXKWTVx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Nov 2007 14:21:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756667AbXKWTVx
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Nov 2007 14:21:53 -0500
Received: from wincent.com ([72.3.236.74]:60679 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756638AbXKWTVw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Nov 2007 14:21:52 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lANJKom4018032;
	Fri, 23 Nov 2007 13:21:03 -0600
X-Mailer: git-send-email 1.5.3.6.886.g6e20-dirty
In-Reply-To: <1195845650-85962-7-git-send-email-win@wincent.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65914>

Now builtin-add can take a "--patch" option; when found, it passes control
over to git-add--interactive, passing the --patch switch and the supplied
pathspecs.

Signed-off-by: Wincent Colaiuta <win@wincent.com>
---
 Documentation/git-add.txt |    5 +++++
 builtin-add.c             |   13 ++++++++-----
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index 0b0ab1d..1acf10f 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -65,6 +65,11 @@ OPTIONS
 	operation to a subset of the files in the working tree.
 	See ``Interactive mode'' for details.
 
+-p, \--patch:
+	Similar to Interactive mode but the initial command loop is
+	bypassed and the 'patch' subcommand is invoked using each of
+	the specified filepatterns before exiting.
+
 -u::
 	Update only files that git already knows about. This is similar
 	to what "git commit -a" does in preparation for making a commit,
diff --git a/builtin-add.c b/builtin-add.c
index 3646a45..c8335f1 100644
--- a/builtin-add.c
+++ b/builtin-add.c
@@ -19,6 +19,7 @@ static const char * const builtin_add_usage[] = {
 	"git-add [options] [--] <filepattern>...",
 	NULL
 };
+static int patch_interactive = 0, add_interactive = 0;
 
 static int take_worktree_changes;
 
@@ -138,10 +139,12 @@ static void refresh(int verbose, const char **pathspec)
 int interactive_add(int argc, const char **argv)
 {
 	int status;
-	const char **args = xmalloc(sizeof(const char *) * (argc + 1));
+	int pre_argc = patch_interactive ? 2 : 1;
+	const char **args = xmalloc(sizeof(const char *) * (argc + pre_argc + 1));
 	args[0] = "add--interactive";
-	memcpy((void *)args + sizeof(const char *), argv, sizeof(const char *) * argc);
-	args[argc + 1] = NULL;
+	args[1] = "--patch";
+	memcpy((void *)args + sizeof(const char *) * pre_argc, argv, sizeof(const char *) * argc);
+	args[argc + pre_argc] = NULL;
 
 	status = run_command_v_opt(args, RUN_GIT_CMD);
 	free(args);
@@ -154,13 +157,13 @@ static const char ignore_error[] =
 "The following paths are ignored by one of your .gitignore files:\n";
 
 static int verbose = 0, show_only = 0, ignored_too = 0, refresh_only = 0;
-static int add_interactive = 0;
 
 static struct option builtin_add_options[] = {
 	OPT__DRY_RUN(&show_only),
 	OPT__VERBOSE(&verbose),
 	OPT_GROUP(""),
 	OPT_BOOLEAN('i', "interactive", &add_interactive, "interactive picking"),
+	OPT_BOOLEAN('p', "patch", &patch_interactive, "interactive patching"),
 	OPT_BOOLEAN('f', NULL, &ignored_too, "allow adding otherwise ignored files"),
 	OPT_BOOLEAN('u', NULL, &take_worktree_changes, "update tracked files"),
 	OPT_BOOLEAN( 0 , "refresh", &refresh_only, "don't add, only refresh the index"),
@@ -175,7 +178,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 
 	argc = parse_options(argc, argv, builtin_add_options,
 			  builtin_add_usage, 0);
-	if (add_interactive)
+	if (add_interactive || patch_interactive)
 		exit(interactive_add(argc, argv));
 
 	git_config(git_default_config);
-- 
1.5.3.6.886.g3364
