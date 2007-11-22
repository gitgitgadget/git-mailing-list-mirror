From: Wincent Colaiuta <win@wincent.com>
Subject: [PATCH 3/4] Teach builtin-add to pass multiple paths to git-add--interactive
Date: Thu, 22 Nov 2007 01:02:52 +0100
Message-ID: <1195689773-28601-4-git-send-email-win@wincent.com>
References: <C6E820C8-91E9-48B2-9219-377CA83163A7@wincent.com>
 <1195689773-28601-1-git-send-email-win@wincent.com>
 <1195689773-28601-2-git-send-email-win@wincent.com>
 <1195689773-28601-3-git-send-email-win@wincent.com>
Cc: gitster@pobox.com, peff@peff.net,
	Wincent Colaiuta <win@wincent.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 22 01:04:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IuzXz-0004Wi-Oz
	for gcvg-git-2@gmane.org; Thu, 22 Nov 2007 01:04:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754247AbXKVADo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Nov 2007 19:03:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754335AbXKVADo
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Nov 2007 19:03:44 -0500
Received: from wincent.com ([72.3.236.74]:56123 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754247AbXKVADn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Nov 2007 19:03:43 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lAM02s0W030459;
	Wed, 21 Nov 2007 18:03:00 -0600
X-Mailer: git-send-email 1.5.3.6.862.g369c8
In-Reply-To: <1195689773-28601-3-git-send-email-win@wincent.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65720>

Instead of just accepting a single file parameter, git-add now accepts
any number of path parameters, fowarding them to git-add--interactive.

Signed-off-by: Wincent Colaiuta <win@wincent.com>
---
 builtin-add.c |   23 +++++++++++++----------
 commit.h      |    2 +-
 2 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/builtin-add.c b/builtin-add.c
index 278c02e..13f27e8 100644
--- a/builtin-add.c
+++ b/builtin-add.c
@@ -135,11 +135,17 @@ static void refresh(int verbose, const char **pathspec)
         free(seen);
 }
 
-int interactive_add(const char *path)
+int interactive_add(const char **argv, int argc)
 {
-	const char *argv[3] = { "add--interactive", path, NULL };
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
@@ -170,13 +176,10 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, builtin_add_options,
 			  builtin_add_usage, 0);
 	if (add_interactive) {
-		if (argc > 1)
-			die("add --interactive may take only 1 optional "
-			    "parameter");
-		else if (argc == 1)
-			exit(interactive_add(argv[0]));
+		if (argc > 0)
+			exit(interactive_add(argv, argc));
 		else
-			exit(interactive_add(NULL));
+			exit(interactive_add(NULL, 0));
 	}
 
 	git_config(git_default_config);
diff --git a/commit.h b/commit.h
index 03a6ec5..3a398fc 100644
--- a/commit.h
+++ b/commit.h
@@ -113,7 +113,7 @@ extern struct commit_list *get_shallow_commits(struct object_array *heads,
 
 int in_merge_bases(struct commit *, struct commit **, int);
 
-extern int interactive_add(const char *path);
+extern int interactive_add(const char **argv, int argc);
 extern void add_files_to_cache(int verbose, const char *prefix, const char **files);
 extern int rerere(void);
 
-- 
1.5.3.6.867.g539b6-dirty
