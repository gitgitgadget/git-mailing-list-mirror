From: Dragos Foianu <dragos.foianu@gmail.com>
Subject: [PATCHv2] branch.c: simplify chain of if statements
Date: Mon, 17 Mar 2014 17:51:33 +0200
Message-ID: <1395071493-31435-1-git-send-email-dragos.foianu@gmail.com>
Cc: Dragos Foianu <dragos.foianu@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 17 16:52:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPZpZ-0008TH-Kv
	for gcvg-git-2@plane.gmane.org; Mon, 17 Mar 2014 16:52:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754624AbaCQPv4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Mar 2014 11:51:56 -0400
Received: from mail-ee0-f49.google.com ([74.125.83.49]:33617 "EHLO
	mail-ee0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751500AbaCQPvz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Mar 2014 11:51:55 -0400
Received: by mail-ee0-f49.google.com with SMTP id c41so4278612eek.36
        for <git@vger.kernel.org>; Mon, 17 Mar 2014 08:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=L8e2XsEZOTxMpcFBGV5WvbybssyHklx8nK+aE/KDefo=;
        b=tw3/OADeeGL8BAoCsut/Ffs6b8w3AnhobgCmkVCDLRDQNBfXHwZEJSp0cpvPFW7a7X
         IJd7p3VJnkvv0OGxB0rMSOoxTpUBsB7pyyqQFfamFOIQ7ZAcktqN+bA2yXFtvuN9rwnf
         GNCLer6lqoHA4xpSde4GmFDDE3/eAfsGxGrG0deuVAW3qbTsrxK6u3gBzjW73WTnQ20/
         jTeg/4RQ9l19xJ9TURJbgeXB5ruJIraO6tcXSL1qTUhSRFsibyQIgqgerUcD13Jz8KNZ
         /yh11mNUL/Mxul2qb+JORMme61/rtjosV2LlQaR+DmzwwawgCTh53YGcHlYhMjzVkB9+
         TIkQ==
X-Received: by 10.15.64.75 with SMTP id n51mr15892523eex.33.1395071514286;
        Mon, 17 Mar 2014 08:51:54 -0700 (PDT)
Received: from aiur.labs.cs.pub.ro ([141.85.225.204])
        by mx.google.com with ESMTPSA id s46sm40308339ees.3.2014.03.17.08.51.52
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Mar 2014 08:51:52 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244254>

This patch uses a table to store the different messages that can
be emitted by the verbose install_branch_config function. It
computes an index based on the three flags and prints the message
located at the specific index in the table of messages. If the
index somehow is not within the table, we have a bug.

Signed-off-by: Dragos Foianu <dragos.foianu@gmail.com>
---
 branch.c | 44 +++++++++++++++++++++++++-------------------
 1 file changed, 25 insertions(+), 19 deletions(-)

diff --git a/branch.c b/branch.c
index 723a36b..95645d5 100644
--- a/branch.c
+++ b/branch.c
@@ -54,6 +54,18 @@ void install_branch_config(int flag, const char *local, const char *origin, cons
 	struct strbuf key = STRBUF_INIT;
 	int rebasing = should_setup_rebase(origin);
 
+	const char *messages[] = {
+		N_("Branch %s set up to track local ref %s."),
+		N_("Branch %s set up to track remote ref %s."),
+		N_("Branch %s set up to track local branch %s."),
+		N_("Branch %s set up to track remote branch %s from %s."),
+		N_("Branch %s set up to track local ref %s by rebasing."),
+		N_("Branch %s set up to track remote ref %s by rebasing."),
+		N_("Branch %s set up to track local branch %s by rebasing."),
+		N_("Branch %s set up to track remote branch %s from %s by rebasing.")
+	};
+	int index = 0;
+
 	if (remote_is_branch
 	    && !strcmp(local, shortname)
 	    && !origin) {
@@ -76,28 +88,22 @@ void install_branch_config(int flag, const char *local, const char *origin, cons
 	}
 	strbuf_release(&key);
 
+	if (origin)
+		index += 1;
+	if (remote_is_branch)
+		index += 2;
+	if (rebasing)
+		index += 4;
+
 	if (flag & BRANCH_CONFIG_VERBOSE) {
 		if (remote_is_branch && origin)
-			printf_ln(rebasing ?
-				  _("Branch %s set up to track remote branch %s from %s by rebasing.") :
-				  _("Branch %s set up to track remote branch %s from %s."),
-				  local, shortname, origin);
-		else if (remote_is_branch && !origin)
-			printf_ln(rebasing ?
-				  _("Branch %s set up to track local branch %s by rebasing.") :
-				  _("Branch %s set up to track local branch %s."),
-				  local, shortname);
-		else if (!remote_is_branch && origin)
-			printf_ln(rebasing ?
-				  _("Branch %s set up to track remote ref %s by rebasing.") :
-				  _("Branch %s set up to track remote ref %s."),
-				  local, remote);
-		else if (!remote_is_branch && !origin)
-			printf_ln(rebasing ?
-				  _("Branch %s set up to track local ref %s by rebasing.") :
-				  _("Branch %s set up to track local ref %s."),
-				  local, remote);
+			printf_ln(_(messages[index]),
+				local, shortname, origin);
 		else
+			printf_ln(_(messages[index]),
+				local, (!remote_is_branch) ? remote : shortname);
+
+		if (index < 0 || index > sizeof(messages) / sizeof(*messages))
 			die("BUG: impossible combination of %d and %p",
 			    remote_is_branch, origin);
 	}
-- 
1.8.3.2
