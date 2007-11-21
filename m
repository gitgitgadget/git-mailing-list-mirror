From: Wincent Colaiuta <win@wincent.com>
Subject: [PATCH 3/4] Teach builtin-add to pass a path argument to git-add--interactive
Date: Wed, 21 Nov 2007 13:36:40 +0100
Message-ID: <1195648601-21736-4-git-send-email-win@wincent.com>
References: <1195648601-21736-1-git-send-email-win@wincent.com>
 <1195648601-21736-2-git-send-email-win@wincent.com>
 <1195648601-21736-3-git-send-email-win@wincent.com>
Cc: gitster@pobox.com, Wincent Colaiuta <win@wincent.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 21 13:37:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iuopn-0002sG-2Y
	for gcvg-git-2@gmane.org; Wed, 21 Nov 2007 13:37:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755752AbXKUMhJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Nov 2007 07:37:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756045AbXKUMhJ
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Nov 2007 07:37:09 -0500
Received: from wincent.com ([72.3.236.74]:54660 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755752AbXKUMhH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Nov 2007 07:37:07 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lALCagcm013817;
	Wed, 21 Nov 2007 06:36:48 -0600
X-Mailer: git-send-email 1.5.3.6.862.g369c8
In-Reply-To: <1195648601-21736-3-git-send-email-win@wincent.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65637>

The previous patch in the series taught git-add--interactive to handle
a single optional path argument. This patch teaches builtin-add to pass
this argument through to the script.

Signed-off-by: Wincent Colaiuta <win@wincent.com>
---
 builtin-add.c |   16 ++++++++++------
 commit.h      |    2 +-
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/builtin-add.c b/builtin-add.c
index cf815a0..278c02e 100644
--- a/builtin-add.c
+++ b/builtin-add.c
@@ -135,9 +135,9 @@ static void refresh(int verbose, const char **pathspec)
         free(seen);
 }
 
-int interactive_add(void)
+int interactive_add(const char *path)
 {
-	const char *argv[2] = { "add--interactive", NULL };
+	const char *argv[3] = { "add--interactive", path, NULL };
 
 	return run_command_v_opt(argv, RUN_GIT_CMD);
 }
@@ -163,16 +163,20 @@ static struct option builtin_add_options[] = {
 
 int cmd_add(int argc, const char **argv, const char *prefix)
 {
-	int i, newfd, orig_argc = argc;
+	int i, newfd = argc;
 	const char **pathspec;
 	struct dir_struct dir;
 
 	argc = parse_options(argc, argv, builtin_add_options,
 			  builtin_add_usage, 0);
 	if (add_interactive) {
-		if (add_interactive != 1 || orig_argc != 2)
-			die("add --interactive does not take any parameters");
-		exit(interactive_add());
+		if (argc > 1)
+			die("add --interactive may take only 1 optional "
+			    "parameter");
+		else if (argc == 1)
+			exit(interactive_add(argv[0]));
+		else
+			exit(interactive_add(NULL));
 	}
 
 	git_config(git_default_config);
diff --git a/commit.h b/commit.h
index aa67986..03a6ec5 100644
--- a/commit.h
+++ b/commit.h
@@ -113,7 +113,7 @@ extern struct commit_list *get_shallow_commits(struct object_array *heads,
 
 int in_merge_bases(struct commit *, struct commit **, int);
 
-extern int interactive_add(void);
+extern int interactive_add(const char *path);
 extern void add_files_to_cache(int verbose, const char *prefix, const char **files);
 extern int rerere(void);
 
-- 
1.5.3.5.737.gdee1b
