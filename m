From: Stefan Beller <stefanbeller@googlemail.com>
Subject: [PATCH] builtins: search builtin commands via binary search.
Date: Fri, 26 Jul 2013 22:50:50 +0200
Message-ID: <1374871850-24323-1-git-send-email-stefanbeller@googlemail.com>
Cc: Stefan Beller <stefanbeller@googlemail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 26 22:50:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V2oyX-00050g-2I
	for gcvg-git-2@plane.gmane.org; Fri, 26 Jul 2013 22:50:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932520Ab3GZUuw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jul 2013 16:50:52 -0400
Received: from mail-wi0-f173.google.com ([209.85.212.173]:61878 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932484Ab3GZUur (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jul 2013 16:50:47 -0400
Received: by mail-wi0-f173.google.com with SMTP id en1so1215473wid.6
        for <git@vger.kernel.org>; Fri, 26 Jul 2013 13:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=2S9wjfPIx6QWRUr+YQtY5xopEAey8cw+FL2EHKVrF+4=;
        b=bFdQplPwY3+n7z54owzGLOoNrikUwGedXg6QqprD0mWijGO7II9gecBVnIAChqGvKl
         upI1TEEVeHMc2VVKtohQLfn9nD2ay3JAbUh4DMAxgqko2caAvYSvj+k+JZ7YotijCGDr
         pF5B8RPpI+8NbJsIEFWPlcvFYa25uYB3lhWuQ+FCnA2lMP+a0eNYC4mdrh2TXVVM3EKB
         +AIhI6apUs0D+/6B5UWCmyYF9pSZqZbpN8HC4kox+/BshprTcmK1dTkX58Q0J/+IAzY2
         68h3PltG20+44VXOB48d7oDw6QwmnNMyatB691Lw6OrU4g1Uuht6iz0ZBtel10+RJBed
         E+cA==
X-Received: by 10.180.206.97 with SMTP id ln1mr218287wic.39.1374871845808;
        Fri, 26 Jul 2013 13:50:45 -0700 (PDT)
Received: from localhost (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id fd3sm7116768wic.10.2013.07.26.13.50.44
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 26 Jul 2013 13:50:44 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.rc0.1.g8f6a3e5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231200>

There are currently 115 commands built into the git executable.
Before this commit, it was iterated over these commands in a linear
order, i.e. each command was checked.

As it turns out the commands are already sorted alphabetically, it is easy
to perform a binary search instead of linear searching.
This results in 7 lookups in the worst case.

Signed-off-by: Stefan Beller <stefanbeller@googlemail.com>
---
 git.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/git.c b/git.c
index 2025f77..0d7a9b5 100644
--- a/git.c
+++ b/git.c
@@ -309,9 +309,18 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv)
 	return 0;
 }
 
+static int compare_internal_command(const void *a, const void *b) {
+	/* The first parameter is of type char* describing the name,
+	   the second is a struct cmd_struct */
+	const char *name = (const char*)a;
+	const struct cmd_struct *cmd_struct = (struct cmd_struct*)b;
+	return strcmp(name, cmd_struct->cmd);
+}
+
 static void handle_internal_command(int argc, const char **argv)
 {
 	const char *cmd = argv[0];
+	/* commands must be sorted alphabetically */
 	static struct cmd_struct commands[] = {
 		{ "add", cmd_add, RUN_SETUP | NEED_WORK_TREE },
 		{ "annotate", cmd_annotate, RUN_SETUP },
@@ -447,12 +456,12 @@ static void handle_internal_command(int argc, const char **argv)
 		argv[0] = cmd = "help";
 	}
 
-	for (i = 0; i < ARRAY_SIZE(commands); i++) {
-		struct cmd_struct *p = commands+i;
-		if (strcmp(p->cmd, cmd))
-			continue;
+	struct cmd_struct *p = (struct cmd_struct *)bsearch(cmd, commands,
+				ARRAY_SIZE(commands), sizeof(struct cmd_struct),
+				compare_internal_command);
+
+	if (p)
 		exit(run_builtin(p, argc, argv));
-	}
 }
 
 static void execv_dashed_external(const char **argv)
-- 
1.8.4.rc0.1.g8f6a3e5
