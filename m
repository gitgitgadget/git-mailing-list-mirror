From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 19/20] worktree: populate via "git reset --hard" rather than "git checkout"
Date: Thu, 16 Jul 2015 04:20:24 -0400
Message-ID: <1437034825-32054-20-git-send-email-sunshine@sunshineco.com>
References: <1437034825-32054-1-git-send-email-sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 16 10:22:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZFeQf-0000H8-CP
	for gcvg-git-2@plane.gmane.org; Thu, 16 Jul 2015 10:22:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754516AbbGPIVy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jul 2015 04:21:54 -0400
Received: from mail-ie0-f170.google.com ([209.85.223.170]:33496 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753978AbbGPIVD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jul 2015 04:21:03 -0400
Received: by ietj16 with SMTP id j16so50962213iet.0
        for <git@vger.kernel.org>; Thu, 16 Jul 2015 01:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=osF2GwhnGt3UtGdkIeNoR1TmliUMLFAipUu6OogkbJs=;
        b=r99aIDGql9HHvvjn5qbsb45aeLn47B2daXs/CaozRDJoKShBI7HW+eIg0T1KZ82D/B
         V8Rtay3eGWi+V8xznV8RFxIT2/2x5FsvVIvqlN2aqCYAyKi0dYgndKWTiOq5yIUilQ/9
         xooIN7cPCWiIspjaNTAHZD7aJ9SdfeOa0XjEVNQvbKiFudL1xwZTO10SBjG63E4XjDyV
         i3wDNqOPmoUaln4FHXx3MTD8McSeg5wMh5UOuH1ePrkAH8+6NQTUVJKQlBkDEoFCAeWO
         RQxozQGuTfse/mpOc/ROxX2+pMre+weHBUBLQ/1JAJ3VcDUYPXu+munLp57eRO/ZcpRO
         wkUw==
X-Received: by 10.50.129.101 with SMTP id nv5mr1598369igb.31.1437034862501;
        Thu, 16 Jul 2015 01:21:02 -0700 (PDT)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by smtp.gmail.com with ESMTPSA id j83sm4581146iod.25.2015.07.16.01.21.01
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 16 Jul 2015 01:21:02 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc2.378.g0af52e8
In-Reply-To: <1437034825-32054-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274019>

Now that git-worktree handles all functionality (--force, --detach,
-b/-B) previously delegated to git-checkout, actual population of the
new worktree can be accomplished more directly and lightweight with
"git reset --hard" in place of "git checkout".

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---

Changes since v1: reword commit message.

 builtin/worktree.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 54f2f35..2873064 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -266,7 +266,6 @@ static int add_worktree(const char *path, const char *refname,
 
 	fprintf_ln(stderr, _("Enter %s (identifier %s)"), path, name);
 
-	setenv("GIT_CHECKOUT_NEW_WORKTREE", "1", 1);
 	argv_array_pushf(&child_env, "%s=%s", GIT_DIR_ENVIRONMENT, sb_git.buf);
 	argv_array_pushf(&child_env, "%s=%s", GIT_WORK_TREE_ENVIRONMENT, path);
 	memset(&cp, 0, sizeof(cp));
@@ -285,7 +284,7 @@ static int add_worktree(const char *path, const char *refname,
 
 	cp.argv = NULL;
 	argv_array_clear(&cp.args);
-	argv_array_push(&cp.args, "checkout");
+	argv_array_pushl(&cp.args, "reset", "--hard", NULL);
 	cp.env = child_env.argv;
 	ret = run_command(&cp);
 	if (!ret) {
-- 
2.5.0.rc2.378.g0af52e8
