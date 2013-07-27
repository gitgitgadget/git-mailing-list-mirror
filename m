From: Stefan Beller <stefanbeller@googlemail.com>
Subject: [PATCH] builtins: search builtin commands via binary search.
Date: Sat, 27 Jul 2013 10:50:38 +0200
Message-ID: <1374915038-6717-1-git-send-email-stefanbeller@googlemail.com>
References: <51F38997.9010507@googlemail.com>
Cc: Stefan Beller <stefanbeller@googlemail.com>
To: git@vger.kernel.org, jrnieder@gmail.com, sunshine@sunshineco.com
X-From: git-owner@vger.kernel.org Sat Jul 27 10:50:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V30D1-0006Eu-Ln
	for gcvg-git-2@plane.gmane.org; Sat, 27 Jul 2013 10:50:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750974Ab3G0Iuf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Jul 2013 04:50:35 -0400
Received: from mail-wg0-f42.google.com ([74.125.82.42]:44719 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750888Ab3G0Iud (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jul 2013 04:50:33 -0400
Received: by mail-wg0-f42.google.com with SMTP id j13so1449223wgh.1
        for <git@vger.kernel.org>; Sat, 27 Jul 2013 01:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=E/X1C63/6gHKh8cKeXY13hA4Rh2D9bgrrQxK0jqNkLs=;
        b=djtwcGlqL2Ueawqc0VjsN488fZaXoCXMzBDa6rJ6Q/DSAJlT0yZCl/A9ycMa2Ng8DL
         EhJivsTWioJWPv5yzxCeWBbPZg4vVQhOthOX0d1DlhnVEpx9llMgA6PneIbKedz2rIoG
         C/+jDiVHacG+M6Lfo7lCe6aswbPgB8cKFq9qm4LbnlRbBG95pVqlBGUGuOvYpK2pnmcc
         rYvURX4yJLWPVn7NUDZOMs1lGetPyEbGWDaY3edP5uwYTUMmQ+BdePiwjIN99spVhTir
         +GWw7+FUO/ZoYlmj0GXxDA4s4nYwVsKTH2Ymt8Fx3Rn3yjm6Hf0XvcOyxCO3vnrVzj1R
         pkwQ==
X-Received: by 10.180.107.167 with SMTP id hd7mr1344406wib.33.1374915032395;
        Sat, 27 Jul 2013 01:50:32 -0700 (PDT)
Received: from localhost (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id nb12sm9386190wic.7.2013.07.27.01.50.31
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 27 Jul 2013 01:50:31 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.rc0.1.g8f6a3e5
In-Reply-To: <51F38997.9010507@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231231>

There are currently 115 commands built into the git executable.
Before this commit, it was iterated over these commands in a linear
order, i.e. each command was checked.

As it turns out the commands are already sorted alphabetically, it is easy
to perform a binary search instead of linear searching.
This results in 7 lookups in the worst case.

Signed-off-by: Stefan Beller <stefanbeller@googlemail.com>
---
 git.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/git.c b/git.c
index 2025f77..6d4de2b 100644
--- a/git.c
+++ b/git.c
@@ -309,9 +309,14 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv)
 	return 0;
 }
 
+static int compare_internal_command(const void *name, const void *cmd) {
+	return strcmp((const char*)name, ((const struct cmd_struct*)cmd)->cmd);
+}
+
 static void handle_internal_command(int argc, const char **argv)
 {
 	const char *cmd = argv[0];
+	/* commands must be sorted alphabetically for binary search */
 	static struct cmd_struct commands[] = {
 		{ "add", cmd_add, RUN_SETUP | NEED_WORK_TREE },
 		{ "annotate", cmd_annotate, RUN_SETUP },
@@ -447,12 +452,12 @@ static void handle_internal_command(int argc, const char **argv)
 		argv[0] = cmd = "help";
 	}
 
-	for (i = 0; i < ARRAY_SIZE(commands); i++) {
-		struct cmd_struct *p = commands+i;
-		if (strcmp(p->cmd, cmd))
-			continue;
+	struct cmd_struct *p = bsearch(cmd, commands,
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
