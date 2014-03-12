From: TamerTas <tamertas@outlook.com>
Subject: [PATCH][GSOC2014] install_branch_config: change logical chain to lookup table
Date: Wed, 12 Mar 2014 23:24:10 +0200
Message-ID: <BLU0-SMTP223196BC56240FAE28FF9DD5760@phx.gbl>
References: <http://git.661346.n2.nabble.com/PATCH-GSOC2014-changed-logical-chain-in-branch-c-to-lookup-tables-tp7605343p7605444.html>
Mime-Version: 1.0
Content-Type: text/plain
Cc: TamerTas <tamertas@outlook.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 12 22:24:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNqdb-0006IP-10
	for gcvg-git-2@plane.gmane.org; Wed, 12 Mar 2014 22:24:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751963AbaCLVY1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2014 17:24:27 -0400
Received: from blu0-omc3-s16.blu0.hotmail.com ([65.55.116.91]:35485 "EHLO
	blu0-omc3-s16.blu0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751244AbaCLVY0 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 Mar 2014 17:24:26 -0400
Received: from BLU0-SMTP22 ([65.55.116.72]) by blu0-omc3-s16.blu0.hotmail.com with Microsoft SMTPSVC(6.0.3790.4675);
	 Wed, 12 Mar 2014 14:24:25 -0700
X-TMN: [67WML7A1WkveYEo+7yXvwn702EIok1/N]
X-Originating-Email: [tamertas@outlook.com]
Received: from localhost.localdomain ([24.133.189.163]) by BLU0-SMTP22.phx.gbl over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
	 Wed, 12 Mar 2014 14:24:23 -0700
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <http://git.661346.n2.nabble.com/PATCH-GSOC2014-changed-logical-chain-in-branch-c-to-lookup-tables-tp7605343p7605444.html>
X-OriginalArrivalTime: 12 Mar 2014 21:24:24.0115 (UTC) FILETIME=[70A80030:01CF3E39]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244000>


Signed-off-by: TamerTas <tamertas@outlook.com>
--
Thanks for the feedback. Comments below. 

I've made the suggested changes [1] to patch [2] 
but, since there are different number of format 
specifiers, an if-else clause is necessary. 
Removing the if-else chain completely doesn't seem to be possible. 
So making the format table-driven seems to be like an optional change.

[1]: http://git.661346.n2.nabble.com/PATCH-GSOC2014-changed-logical-chain-in-branch-c-to-lookup-tables-tp7605343p7605444.html
[2]: http://git.661346.n2.nabble.com/PATCH-GSOC2014-changed-logical-chain-in-branch-c-to-lookup-tables-tp7605343p7605407.html
--
 branch.c |   44 +++++++++++++++++++++-----------------------
 1 file changed, 21 insertions(+), 23 deletions(-)

diff --git a/branch.c b/branch.c
index 723a36b..1ccf30f 100644
--- a/branch.c
+++ b/branch.c
@@ -50,10 +50,25 @@ static int should_setup_rebase(const char *origin)
 void install_branch_config(int flag, const char *local, const char *origin, const char *remote)
 {
 	const char *shortname = remote + 11;
+	const char *setup_message[] = {
+		N_("Branch %s set up to track local ref %s."),
+		N_("Branch %s set up to track local branch %s."),
+		N_("Branch %s set up to track remote ref %s."),
+		N_("Branch %s set up to track remote branch %s from %s."),
+		N_("Branch %s set up to track local ref %s by rebasing.")
+		N_("Branch %s set up to track local branch %s by rebasing."),
+		N_("Branch %s set up to track remote ref %s by rebasing."),
+		N_("Branch %s set up to track remote branch %s from %s by rebasing."),
+	}; 
+
 	int remote_is_branch = starts_with(remote, "refs/heads/");
 	struct strbuf key = STRBUF_INIT;
 	int rebasing = should_setup_rebase(origin);
 
+	int msg_index = (!!remote_is_branch << 0) +
+			(!!origin << 1) +
+			(!!rebasing << 2);
+
 	if (remote_is_branch
 	    && !strcmp(local, shortname)
 	    && !origin) {
@@ -77,29 +92,12 @@ void install_branch_config(int flag, const char *local, const char *origin, cons
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
+	    if(remote_is_branch && origin)
+		printf_ln(_(setup_message[msg_index]), local, shortname, origin);
+	    else if (remote_is_branch && !origin)
+		printf_ln(_(setup_message[msg_index]), local, shortname);
+	    else
+		printf_ln(_(setup_message[msg_index]), local, remote);
 	}
 }
 
-- 
1.7.9.5
