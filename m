From: TamerTas <tamertas@outlook.com>
Subject: [PATCH][GSOC2014] install_branch_config: change logical chain to lookup table
Date: Fri, 14 Mar 2014 23:30:54 +0200
Message-ID: <BLU0-SMTP430B54F52C27DDA0C405A5D5700@phx.gbl>
References: <CAPig+cRCKCcfYQVM=pyXUQtTsbaD8g=OKff+K5+Bd+kBgqAufg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: TamerTas <tamertas@outlook.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 14 22:32:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WOZib-0000ma-Px
	for gcvg-git-2@plane.gmane.org; Fri, 14 Mar 2014 22:32:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161032AbaCNVcR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2014 17:32:17 -0400
Received: from [65.55.116.100] ([65.55.116.100]:13025 "EHLO
	blu0-omc3-s25.blu0.hotmail.com" rhost-flags-FAIL-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1161029AbaCNVcQ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Mar 2014 17:32:16 -0400
Received: from BLU0-SMTP43 ([65.55.116.74]) by blu0-omc3-s25.blu0.hotmail.com with Microsoft SMTPSVC(6.0.3790.4675);
	 Fri, 14 Mar 2014 14:31:15 -0700
X-TMN: [x680QRPpmphTwbWDGgHcPSwAtsHLa4nY]
X-Originating-Email: [tamertas@outlook.com]
Received: from localhost.localdomain ([24.133.189.163]) by BLU0-SMTP43.phx.gbl over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
	 Fri, 14 Mar 2014 14:31:14 -0700
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <CAPig+cRCKCcfYQVM=pyXUQtTsbaD8g=OKff+K5+Bd+kBgqAufg@mail.gmail.com>
X-OriginalArrivalTime: 14 Mar 2014 21:31:14.0362 (UTC) FILETIME=[BA0239A0:01CF3FCC]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244113>

Signed-off-by: TamerTas <tamertas@outlook.com>
---

Thanks again for the feedback it's been a great learning experience. Comments Below :)

I have refactored the commit [1] to * suggested changes [2].
format-patch was placing 2 hyphens instead of 3 but it's fixed now.
I've turned the table into a multidimensional one and I didn't put
the inner braces since this was used method in other multidimensional arrays
throughout the project.
I've also changed shortname to short_name since that seems to be how variables are named
in this project.
It appears that table-driven code might be more readable after all.

[1]http://git.661346.n2.nabble.com/PATCH-GSOC2014-install-branch-config-change-logical-chain-to-lookup-table-tp7605550.html
[2]http://git.661346.n2.nabble.com/PATCH-GSOC2014-install-branch-config-change-logical-chain-to-lookup-table-tp7605550p7605605.html
---
 branch.c |   42 +++++++++++++++++-------------------------
 1 file changed, 17 insertions(+), 25 deletions(-)

diff --git a/branch.c b/branch.c
index 723a36b..eab6fa4 100644
--- a/branch.c
+++ b/branch.c
@@ -49,13 +49,27 @@ static int should_setup_rebase(const char *origin)
 
 void install_branch_config(int flag, const char *local, const char *origin, const char *remote)
 {
-	const char *shortname = remote + 11;
+	const char *short_name = remote + 11;
+	const char *setup_message[][2][2] = {
+		N_("Branch %s set up to track local ref %s."), 
+		N_("Branch %s set up to track local branch %s."),
+		N_("Branch %s set up to track remote ref %s."), 
+		N_("Branch %s set up to track remote branch %s from %s."),
+		N_("Branch %s set up to track local ref %s by rebasing."), 
+		N_("Branch %s set up to track local branch %s by rebasing."),
+		N_("Branch %s set up to track remote ref %s by rebasing."), 
+		N_("Branch %s set up to track remote branch %s from %s by rebasing.")
+	}; 
+
 	int remote_is_branch = starts_with(remote, "refs/heads/");
 	struct strbuf key = STRBUF_INIT;
 	int rebasing = should_setup_rebase(origin);
 
+	const char *remote_name = remote_is_branch? short_name : remote;
+	const char *message = setup_message[!!rebasing][!!origin][!!remote_is_branch];
+
 	if (remote_is_branch
-	    && !strcmp(local, shortname)
+	    && !strcmp(local, short_name)
 	    && !origin) {
 		warning(_("Not setting branch %s as its own upstream."),
 			local);
@@ -77,29 +91,7 @@ void install_branch_config(int flag, const char *local, const char *origin, cons
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
+		printf_ln(_(message), local, remote_name, origin);
 	}
 }
 
---
1.7.9.5
