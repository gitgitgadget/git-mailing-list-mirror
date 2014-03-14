From: Andrew Wong <andrew.kw.w@gmail.com>
Subject: [PATCH 3/3] reset: Print a warning when user uses "git reset" during a merge
Date: Fri, 14 Mar 2014 00:37:52 -0400
Message-ID: <1394771872-25940-4-git-send-email-andrew.kw.w@gmail.com>
References: <1394771872-25940-1-git-send-email-andrew.kw.w@gmail.com>
Cc: Andrew Wong <andrew.kw.w@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 14 05:39:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WOJuL-000396-9A
	for gcvg-git-2@plane.gmane.org; Fri, 14 Mar 2014 05:39:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752073AbaCNEje (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2014 00:39:34 -0400
Received: from mail-ie0-f182.google.com ([209.85.223.182]:54225 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751762AbaCNEjH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2014 00:39:07 -0400
Received: by mail-ie0-f182.google.com with SMTP id y20so2063835ier.41
        for <git@vger.kernel.org>; Thu, 13 Mar 2014 21:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IolASf2Bk0peWFF0fkFtPe/CHZYmz/8RkgesEmZEoZk=;
        b=WTwfA/E9G1VKod5Mq0GZ/xGscdgeiUWAI3a3X311go08A9fEj9kha4Lwj75fTJ/fGG
         qVeGAjK5voLmHyM1A4AYgewpi6sMqePu7p+YuZycTWaV+J3DPngQgAJ0AuQOuTFtQbqa
         9aP4WXWpF27zWHtZG8yVS88DxtAJEB3v2+nUNLKMLiYp9KjYQQgI7X1MqXA6nRDWSrzU
         UotifxhYHj12yMeh57AAtfIb6NQf70uXaSo32Lnf1l6XWfcMXtbOL4296f2XQlmcuItA
         Q2HyPBpZ6e7spn9b37Eg98WBirjQt9X2s8DYT5IrXgBS60TftCFY+30WT5fTrHQ/fJQA
         ZxIw==
X-Received: by 10.42.121.147 with SMTP id j19mr4577543icr.13.1394771946681;
        Thu, 13 Mar 2014 21:39:06 -0700 (PDT)
Received: from dresden.sidefx.com (nat.sidefx.com. [38.104.156.10])
        by mx.google.com with ESMTPSA id ji9sm2293656igb.1.2014.03.13.21.39.04
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 13 Mar 2014 21:39:04 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.175.gb69385f
In-Reply-To: <1394771872-25940-1-git-send-email-andrew.kw.w@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244078>

During a merge, "--mixed" is most likely not what the user wants. Using
"--mixed" during a merge would leave the merged changes and new files
mixed in with the local changes. The user would have to manually clean
up the work tree, which is non-trivial. In future releases, we want to
make "git reset" error out when used in the middle of a merge. For now,
we simply print out a warning to the user.

Signed-off-by: Andrew Wong <andrew.kw.w@gmail.com>
---
 builtin/reset.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/builtin/reset.c b/builtin/reset.c
index 4fd1c6c..04e8103 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -331,8 +331,29 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 					_(reset_type_names[reset_type]));
 	}
 	if (reset_type == NONE)
+	{
 		reset_type = MIXED; /* by default */
 
+		/* During a merge, "--mixed" is most likely not what the user
+		 * wants. Using "--mixed" during a merge would leave the merged
+		 * changes and new files mixed in with the local changes. The
+		 * user would have to manually clean up the work tree, which is
+		 * non-trivial. In future releases, we want to make "git reset"
+		 * error out when used in the middle of a merge. For now, we
+		 * simply print out a warning to the user. */
+		if (is_merge())
+			warning(_("You have used 'git reset' in the middle of a merge. 'git reset' defaults to\n"
+				  "'git reset --mixed', which means git will not clean up any merged changes and\n"
+				  "new files that were created in the work tree. It also becomes impossible for\n"
+				  "git to automatically clean up the work tree later, so you would have to clean\n"
+				  "up the work tree manually. To avoid this next time, you may want to use 'git\n"
+				  "reset --merge', or equivalently 'git merge --abort'.\n"
+				  "\n"
+				  "In future releases, using 'git reset' in the middle of a merge will result in\n"
+				  "an error."
+				 ));
+	}
+
 	if (reset_type != SOFT && reset_type != MIXED)
 		setup_work_tree();
 
-- 
1.9.0.174.g6f75b8f
