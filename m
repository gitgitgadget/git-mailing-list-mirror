From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 2/2] wt-status: take advice.statusHints seriously
Date: Thu, 22 Apr 2010 22:30:20 +0200
Message-ID: <86a4d8e5df80008c5c2b3ff4f2a5842ad1f58dc4.1271968072.git.git@drmicha.warpmail.net>
References: <7v39yo53mt.fsf@alter.siamese.dyndns.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 22 22:31:18 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O533N-0004X8-Rq
	for gcvg-git-2@lo.gmane.org; Thu, 22 Apr 2010 22:31:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758453Ab0DVUad (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Apr 2010 16:30:33 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:37765 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758506Ab0DVUaa (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Apr 2010 16:30:30 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id D2625EA973;
	Thu, 22 Apr 2010 16:30:29 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Thu, 22 Apr 2010 16:30:29 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references:in-reply-to:references; s=smtpout; bh=hZPGmQ8fO5S9SkYMwBfCmMWWimw=; b=LHwo8ItVomPBmCPkKliuV49hbZpRYggzLjjSHkT0066xa7EIHNy2tSIHHs1NtVrRCIftHGqcNcfZV/tejxlcTD8VtHwHhlN8LDyEbRwwXbZDxjpYBo0FUT7o8ohzCPC+b4SMizLYer+tm2wDiQKOtEW0Awg68RyLIcEFD7kY2Mk=
X-Sasl-enc: o3tWBxV4PP0pYUuJ/EXDqnwslLTN4tySY/aVpe/rMz+i 1271968228
Received: from localhost (p5DCC0786.dip0.t-ipconnect.de [93.204.7.134])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 72F9F4B3507;
	Thu, 22 Apr 2010 16:30:28 -0400 (EDT)
X-Mailer: git-send-email 1.7.1.rc1.248.gcefbb
In-Reply-To: <7v39yo53mt.fsf@alter.siamese.dyndns.org>
In-Reply-To: <c7003ec93f4ea01be80fbba08d2ed5544fa0df4d.1271968072.git.git@drmicha.warpmail.net>
References: <c7003ec93f4ea01be80fbba08d2ed5544fa0df4d.1271968072.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145556>

Currently, status gives a lot of hints even when advice.statusHints is
false. Change this so that all hints depend on the config variable.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 t/t7508-status.sh |    2 +-
 wt-status.c       |   21 +++++++++++++++------
 2 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index 7409a06..1301ec8 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -151,7 +151,7 @@ cat >expect <<EOF
 # Changed but not updated:
 #	modified:   dir1/modified
 #
-# Untracked files not listed (use -u option to show untracked files)
+# Untracked files not listed
 EOF
 git config advice.statusHints false
 test_expect_success 'status -uno (advice.statusHints false)' '
diff --git a/wt-status.c b/wt-status.c
index 8ca59a2..d44486c 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -625,7 +625,9 @@ void wt_status_print(struct wt_status *s)
 	if (s->show_untracked_files)
 		wt_status_print_untracked(s);
 	else if (s->commitable)
-		 fprintf(s->fp, "# Untracked files not listed (use -u option to show untracked files)\n");
+		fprintf(s->fp, "# Untracked files not listed%s\n",
+			advice_status_hints
+			? " (use -u option to show untracked files)" : "");
 
 	if (s->verbose)
 		wt_status_print_verbose(s);
@@ -635,15 +637,22 @@ void wt_status_print(struct wt_status *s)
 		else if (s->nowarn)
 			; /* nothing */
 		else if (s->workdir_dirty)
-			printf("no changes added to commit (use \"git add\" and/or \"git commit -a\")\n");
+			printf("no changes added to commit%s\n",
+				advice_status_hints
+				? " (use \"git add\" and/or \"git commit -a\")" : "");
 		else if (s->untracked.nr)
-			printf("nothing added to commit but untracked files present (use \"git add\" to track)\n");
+			printf("nothing added to commit but untracked files present%s\n",
+				advice_status_hints
+				? " (use \"git add\" to track)" : "");
 		else if (s->is_initial)
-			printf("nothing to commit (create/copy files and use \"git add\" to track)\n");
+			printf("nothing to commit%s\n", advice_status_hints
+				? " (create/copy files and use \"git add\" to track)" : "");
 		else if (!s->show_untracked_files)
-			printf("nothing to commit (use -u to show untracked files)\n");
+			printf("nothing to commit%s\n", advice_status_hints
+				? " (use -u to show untracked files)" : "");
 		else
-			printf("nothing to commit (working directory clean)\n");
+			printf("nothing to commit%s\n", advice_status_hints
+				? " (working directory clean)" : "");
 	}
 }
 
-- 
1.7.1.rc1.248.gcefbb
