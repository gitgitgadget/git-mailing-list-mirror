From: =?utf-8?B?UGF3ZcWC?= Wawruch <pawlo@aleg.pl>
Subject: [PATH] branch.c:install_branch_config():Simplify code generating verbose message.
Date: Thu, 06 Mar 2014 08:58:59 +0100
Message-ID: <8889967.JbMR8CXVSx@endymion>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 06 09:05:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLTJE-0001ZH-Bc
	for gcvg-git-2@plane.gmane.org; Thu, 06 Mar 2014 09:05:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751648AbaCFIFB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2014 03:05:01 -0500
Received: from mail-we0-f178.google.com ([74.125.82.178]:47252 "EHLO
	mail-we0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751105AbaCFIFA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2014 03:05:00 -0500
Received: by mail-we0-f178.google.com with SMTP id u56so2550765wes.23
        for <git@vger.kernel.org>; Thu, 06 Mar 2014 00:04:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:user-agent:mime-version
         :content-transfer-encoding:content-type;
        bh=p0Our5xWTi0aADaV92h9+Z0gLpJ68X5UoTPuDEQgngI=;
        b=EzJ7TyJJxXzKSYW+l1kwp273FgEMcdPzDQTQiGHqs1U47zqzS//qHR6I8G0fKqooeI
         XgKwPRf0GEQcMIpPSsOvequVoc9PVZQjFDh0vphA31IeAwg3fOfOh+sJMmBaaTn031c3
         LO06J6ruSqj0EuMLz/T78OsaH0rZPrR+zb5lGVRM104OzPVSOh1Cg8qWzcYH4sqyPB4D
         /3KX/M8NveabX2u9nDVZ7vJ6RXWDPltxRVfA5xsbo/ZyayWYrNovyhW4/8LcMnofxfOO
         tqM61ZJc0NbWoUXEKvo6S1mS3SiRgaRqo7xbc1Hfg3NC+eyCgLzUQaA+Xs75xsQ4GH/0
         AI5w==
X-Received: by 10.194.92.38 with SMTP id cj6mr7569948wjb.70.1394093099164;
        Thu, 06 Mar 2014 00:04:59 -0800 (PST)
Received: from endymion.localnet (fw-gw-atm.mimuw.edu.pl. [193.0.96.15])
        by mx.google.com with ESMTPSA id q15sm13001954wjw.18.2014.03.06.00.04.57
        for <git@vger.kernel.org>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 06 Mar 2014 00:04:58 -0800 (PST)
User-Agent: KMail/4.11.5 (Linux/3.11.0-15-generic; KDE/4.11.5; x86_64; ; )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243502>

>From adfcfa0a334378a6242347efc0d614fa193610db Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Pawe=C5=82=20Wawruch?= <pawlo@aleg.pl>
Date: Thu, 6 Mar 2014 00:05:00 +0100
Subject: [PATCH] branch.c:install_branch_config(): Simplify the long chain of
 if statements. Threre was a long chain of if statements. The code can be more
 clear. The chain is replaced with table of strings. New approach is more
 compact.

---
 branch.c | 38 ++++++++++++++++----------------------
 1 file changed, 16 insertions(+), 22 deletions(-)

diff --git a/branch.c b/branch.c
index 723a36b..ebc2172 100644
--- a/branch.c
+++ b/branch.c
@@ -77,29 +77,23 @@ void install_branch_config(int flag, const char *local, 
const char *origin, cons
 	strbuf_release(&key);
 
 	if (flag & BRANCH_CONFIG_VERBOSE) {
-		if (remote_is_branch && origin)
-			printf_ln(rebasing ?
-				  _("Branch %s set up to track remote branch %s from %s by 
rebasing.") :
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
+		const char *messages[8] ;
+		messages[0] = _("Branch %s set up to track remote branch %s from %s by 
rebasing.");
+		messages[1] = _("Branch %s set up to track remote branch %s from %s.");
+		messages[2] = _("Branch %s set up to track local branch %s by 
rebasing.");
+		messages[3] = _("Branch %s set up to track local branch %s.");
+		messages[4] = _("Branch %s set up to track remote ref %s by rebasing.");
+		messages[5] = _("Branch %s set up to track remote ref %s.");
+		messages[6] = _("Branch %s set up to track local ref %s by rebasing.");
+		messages[7] = _("Branch %s set up to track local ref %s.");
+
+		const char *name = remote_is_branch ? remote : shortname;
+		int message_number = rebasing + 2 * (origin != NULL) + 4 * 
remote_is_branch;
+
+		if (message_number < 2)
+			printf_ln(messages[message_number], local, name, origin);
 		else
-			die("BUG: impossible combination of %d and %p",
-			    remote_is_branch, origin);
+			printf_ln(messages[message_number], local, name);
 	}
 }
 
-- 
1.8.3.2
