From: Vincenzo di Cicco <enzodicicco@gmail.com>
Subject: [PATCH][GSoC] branch.c:install_branch_config Simplified long chain of if statements
Date: Mon, 10 Mar 2014 23:04:01 +0100
Message-ID: <1394489041-2377-1-git-send-email-enzodicicco@gmail.com>
Cc: NaN <enzodicicco@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 10 23:05:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WN8K7-0001Ws-GN
	for gcvg-git-2@plane.gmane.org; Mon, 10 Mar 2014 23:05:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752705AbaCJWFX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2014 18:05:23 -0400
Received: from mail-ee0-f54.google.com ([74.125.83.54]:42551 "EHLO
	mail-ee0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752614AbaCJWFW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2014 18:05:22 -0400
Received: by mail-ee0-f54.google.com with SMTP id d49so3393349eek.13
        for <git@vger.kernel.org>; Mon, 10 Mar 2014 15:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=7vlTk5V6Kevj+adoLvlolEkkY8mTU6s5DD/pUpr8YiQ=;
        b=JBmWqCpANnAx1UWvQtXjWVwuNZjgfU8PiDGaXg51uhy8NjCG1UWoyauXcqkDfrwyjr
         N4NBvQu63GA8740J1MFzLLlhCkmrFpynO3rElxfKBAbF3J0iHbmPOY8IMuAKsLUhD/BJ
         zQ/xoufrF21NMuSQoIXAhleDdC4tAQ4PEPwV3LL+x7Qlp9ifdB3g9QYS4BckdsID28kW
         orwD4fyYnqi+zJ3E/zEy+cVSfzN8o0iYN6j9LCTHuEMbg31oD4i7owIpz1OFppresMHI
         DpK+F46SlHOM+gfOSlH7V2tgDiaz99Pxs7LjK3zfO9/Qo1JD8gAaWRrHzZ9pwncGzyWw
         /llw==
X-Received: by 10.14.94.3 with SMTP id m3mr6832148eef.54.1394489121631;
        Mon, 10 Mar 2014 15:05:21 -0700 (PDT)
Received: from workstation.Belkin (ppp-97-180.24-151.libero.it. [151.24.180.97])
        by mx.google.com with ESMTPSA id i1sm49824066eeo.16.2014.03.10.15.05.20
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 10 Mar 2014 15:05:20 -0700 (PDT)
X-Mailer: git-send-email 1.9.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243823>

From: NaN <enzodicicco@gmail.com>

Hi there, I've made this patch in according to the rules to participate at GSoC.
I've seen other patches about this issue very well constructed, so this is only another way to solve this microproject and to test how I can send a patch and discuss about it.

Thanks,
NaN

Signed-off-by: Vincenzo di Cicco <enzodicicco@gmail.com>
---
 Table-driven approach to avoid the long chain of if statements.

 branch.c | 37 ++++++++++++++-----------------------
 1 file changed, 14 insertions(+), 23 deletions(-)

diff --git a/branch.c b/branch.c
index 723a36b..cb8a544 100644
--- a/branch.c
+++ b/branch.c
@@ -53,6 +53,10 @@ void install_branch_config(int flag, const char *local, const char *origin, cons
 	int remote_is_branch = starts_with(remote, "refs/heads/");
 	struct strbuf key = STRBUF_INIT;
 	int rebasing = should_setup_rebase(origin);
+	struct strbuf msg = STRBUF_INIT;
+	char *locations[2][2] = {{"locate ref \%s", "local branch \%s"},
+				 {"remote ref \%s", "remote branch \%s from \%s"}};
+	char *location;

 	if (remote_is_branch
 	    && !strcmp(local, shortname)
@@ -77,30 +81,17 @@ void install_branch_config(int flag, const char *local, const char *origin, cons
 	strbuf_release(&key);

 	if (flag & BRANCH_CONFIG_VERBOSE) {
-		if (remote_is_branch && origin)
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
-		else
-			die("BUG: impossible combination of %d and %p",
-			    remote_is_branch, origin);
+		location = locations[origin != NULL][remote_is_branch];
+
+		strbuf_addstr(&msg, "Branch \%s set up to track ");
+		strbuf_addstr(&msg, location);
+		if(rebasing)
+			strbuf_addstr(&msg, " by rebasing");
+		strbuf_addch(&msg, '.');
+
+		printf_ln(_(msg.buf), local, remote_is_branch ? remote: shortname, origin);
 	}
+	strbuf_release(&msg);
 }

 /*
--
1.9.0
