From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 15/16] worktree: populate via "git reset --hard" rather than "git checkout"
Date: Fri, 10 Jul 2015 20:05:45 -0400
Message-ID: <1436573146-3893-16-git-send-email-sunshine@sunshineco.com>
References: <1436573146-3893-1-git-send-email-sunshine@sunshineco.com>
Cc: Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Mikael Magnusson <mikachu@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 11 09:20:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZDp58-00055e-TQ
	for gcvg-git-2@plane.gmane.org; Sat, 11 Jul 2015 09:20:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753473AbbGKHUL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Jul 2015 03:20:11 -0400
Received: from mail-ig0-f172.google.com ([209.85.213.172]:37744 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752505AbbGKHUJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Jul 2015 03:20:09 -0400
Received: by igpy18 with SMTP id y18so27421243igp.0
        for <git@vger.kernel.org>; Sat, 11 Jul 2015 00:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+8Yoi74NFcCekxrENgPwPDqeaxJg48kWNwmy4uL/3dk=;
        b=X6ekgVt+g9ey6v2i0ho75nk/72i40xU/8pPWHEaYA+YJ+gfxZZjPe2CVhJpDi8Cb80
         Ttsj/Qxm7El39gk2P2808f0GcimM7EARbWjfIvZL+RpZIm3sWLbcuUVzdxgZjAWCyiTc
         7zl40BU3tz7Azp8GcLZyfcFbvZ09kqOkLoU4BNVjZJEOlT4w/mHjXf/jyn0FzH/Jc6UZ
         ANBjN7qL/L7aVjhNS5EIZ5eIvRVx8jNVletTxF6sHJ97Dus/DeB5gHeummv58tbcwkwH
         /LC9y0BlOMQ49sekdVut5M2vQfX5k/qOBDdfQz94Xlt6flQ/Ha6SE/qIgUNFMZ1jcwGT
         GKKA==
X-Received: by 10.50.137.40 with SMTP id qf8mr1418953igb.52.1436573200918;
        Fri, 10 Jul 2015 17:06:40 -0700 (PDT)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by smtp.gmail.com with ESMTPSA id g81sm7533321ioi.20.2015.07.10.17.06.40
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 10 Jul 2015 17:06:40 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc1.201.ga12d9f8
In-Reply-To: <1436573146-3893-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273863>

Now that git-worktree handles all functionality (--force, --detach,
-b/-B) previously delegated to git-checkout, actual population of the
new worktree can be accomplished more directly and more lightweight with
"git reset --hard" rather than "git checkout".

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 builtin/worktree.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 9101a3c..51c57bc 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -262,7 +262,6 @@ static int add_worktree(const char *path, const char *refname,
 
 	fprintf_ln(stderr, _("Enter %s (identifier %s)"), path, name);
 
-	setenv("GIT_CHECKOUT_NEW_WORKTREE", "1", 1);
 	setenv(GIT_DIR_ENVIRONMENT, sb_git.buf, 1);
 	setenv(GIT_WORK_TREE_ENVIRONMENT, path, 1);
 	memset(&cp, 0, sizeof(cp));
@@ -280,7 +279,7 @@ static int add_worktree(const char *path, const char *refname,
 
 	cp.argv = NULL;
 	argv_array_clear(&cp.args);
-	argv_array_push(&cp.args, "checkout");
+	argv_array_pushl(&cp.args, "reset", "--hard", NULL);
 	ret = run_command(&cp);
 	if (!ret) {
 		is_junk = 0;
-- 
2.5.0.rc1.201.ga12d9f8
