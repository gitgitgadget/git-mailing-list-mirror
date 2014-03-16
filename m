From: Dragos Foianu <dragos.foianu@gmail.com>
Subject: [PATCH] branch.c: simplify chain of if statements
Date: Sun, 16 Mar 2014 23:22:42 +0200
Message-ID: <1395004962-18200-1-git-send-email-dragos.foianu@gmail.com>
Cc: Dragos Foianu <dragos.foianu@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 16 22:23:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPIWL-0006o0-3a
	for gcvg-git-2@plane.gmane.org; Sun, 16 Mar 2014 22:23:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755644AbaCPVW5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Mar 2014 17:22:57 -0400
Received: from mail-ee0-f52.google.com ([74.125.83.52]:35493 "EHLO
	mail-ee0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754829AbaCPVW4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Mar 2014 17:22:56 -0400
Received: by mail-ee0-f52.google.com with SMTP id e49so3455735eek.11
        for <git@vger.kernel.org>; Sun, 16 Mar 2014 14:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=qdxZ3ei+rI567Uy1hTo9qZC82WPdryGza4ydzAALpT4=;
        b=qOYNhmE35RlgQzKelMZSHGE0LdS6ieICKKHc7Gniv8B0M3GO9L7Xntv0sTDCH2diNv
         y90qW8PpfPKWTFk+xTULY3RcJ8ENeu5dCKPsLx330LNdR1Cw36dUk3FJ7HE6IPtQ4DVh
         beU9Coc5xnp69uqMDTVrqRP9dDqsHT0KURMuuUYgZ8iCgpTukwoVTRfvplO/6JhZzJag
         HTXNRT81kqrtE79iSUpYkh4DUfwrSbYvji6PmGnCP0I12AXANI9KUe1Z412VHcYOMgj3
         wD4m8/N7l9hUtXNqe58ADft0swcMyny/Bt6O+oYYjqf6zcVIsYo1yX63w44LVWhH9Bu9
         3JyQ==
X-Received: by 10.14.39.3 with SMTP id c3mr20214101eeb.42.1395004975388;
        Sun, 16 Mar 2014 14:22:55 -0700 (PDT)
Received: from localhost.localdomain ([109.100.93.176])
        by mx.google.com with ESMTPSA id 46sm34864721ees.4.2014.03.16.14.22.54
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Mar 2014 14:22:54 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244210>

This patch uses a table-driven approach in order to make the code
cleaner. Although not necessary, it helps code reability by not
forcing the user to read the print message when trying to
understand what the code does. The rebase check has been moved to
the verbose if statement to avoid making the same check in each of
the four if statements.

Signed-off-by: Dragos Foianu <dragos.foianu@gmail.com>
---
 branch.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/branch.c b/branch.c
index 723a36b..e2fe455 100644
--- a/branch.c
+++ b/branch.c
@@ -54,6 +54,14 @@ void install_branch_config(int flag, const char *local, const char *origin, cons
 	struct strbuf key = STRBUF_INIT;
 	int rebasing = should_setup_rebase(origin);
 
+	const char *verbose_prints[4] = {
+		"Branch %s set up to track remote branch %s from %s%s",
+		"Branch %s set up to track local branch %s%s",
+		"Branch %s set up to track remote ref %s%s",
+		"Branch %s set up to track local ref %s%s"
+	};
+	char *verbose_rebasing = rebasing ? " by rebasing." : ".";
+
 	if (remote_is_branch
 	    && !strcmp(local, shortname)
 	    && !origin) {
@@ -78,25 +86,17 @@ void install_branch_config(int flag, const char *local, const char *origin, cons
 
 	if (flag & BRANCH_CONFIG_VERBOSE) {
 		if (remote_is_branch && origin)
-			printf_ln(rebasing ?
-				  _("Branch %s set up to track remote branch %s from %s by rebasing.") :
-				  _("Branch %s set up to track remote branch %s from %s."),
-				  local, shortname, origin);
+			printf_ln(_(verbose_prints[0]),
+				local, shortname, origin, verbose_rebasing);
 		else if (remote_is_branch && !origin)
-			printf_ln(rebasing ?
-				  _("Branch %s set up to track local branch %s by rebasing.") :
-				  _("Branch %s set up to track local branch %s."),
-				  local, shortname);
+			printf_ln(_(verbose_prints[1]),
+				local, shortname, verbose_rebasing);
 		else if (!remote_is_branch && origin)
-			printf_ln(rebasing ?
-				  _("Branch %s set up to track remote ref %s by rebasing.") :
-				  _("Branch %s set up to track remote ref %s."),
-				  local, remote);
+			printf_ln(_(verbose_prints[2]),
+				local, remote, verbose_rebasing);
 		else if (!remote_is_branch && !origin)
-			printf_ln(rebasing ?
-				  _("Branch %s set up to track local ref %s by rebasing.") :
-				  _("Branch %s set up to track local ref %s."),
-				  local, remote);
+			printf_ln(_(verbose_prints[3]),
+				local, remote, verbose_rebasing);
 		else
 			die("BUG: impossible combination of %d and %p",
 			    remote_is_branch, origin);
-- 
1.8.3.2
