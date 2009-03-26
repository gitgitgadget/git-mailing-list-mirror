From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 2/2] Make local branches behave like remote branches when --tracked
Date: Thu, 26 Mar 2009 21:53:25 +0100
Message-ID: <1238100805-19619-3-git-send-email-git@drmicha.warpmail.net>
References: <alpine.LNX.1.00.0903201358440.19665@iabervon.org>
 <1238100805-19619-1-git-send-email-git@drmicha.warpmail.net>
 <1238100805-19619-2-git-send-email-git@drmicha.warpmail.net>
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 26 21:55:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lmwbt-0000q8-FQ
	for gcvg-git-2@gmane.org; Thu, 26 Mar 2009 21:55:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759364AbZCZUxg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Mar 2009 16:53:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756781AbZCZUxf
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Mar 2009 16:53:35 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:37872 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758275AbZCZUxe (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Mar 2009 16:53:34 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id EDFFE2FF337;
	Thu, 26 Mar 2009 16:53:32 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Thu, 26 Mar 2009 16:53:33 -0400
X-Sasl-enc: UicrGkttvV0xlH/N6gzfd2ptMr4HsHAuOPx2sTW1RTWC 1238100812
Received: from localhost (p4FC63417.dip0.t-ipconnect.de [79.198.52.23])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 223BD5903;
	Thu, 26 Mar 2009 16:53:31 -0400 (EDT)
X-Mailer: git-send-email 1.6.2.1.507.g0e68d
In-Reply-To: <1238100805-19619-2-git-send-email-git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114818>

This makes sure that local branches, when followed using --track, behave
the same as remote ones (e.g. differences being reported by git status
and git checkout). This fixes 1 known failure.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 remote.c                 |    9 +++++----
 t/t6040-tracking-info.sh |    2 +-
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/remote.c b/remote.c
index 2b037f1..5d2d7a1 100644
--- a/remote.c
+++ b/remote.c
@@ -1170,8 +1170,9 @@ struct branch *branch_get(const char *name)
 			for (i = 0; i < ret->merge_nr; i++) {
 				ret->merge[i] = xcalloc(1, sizeof(**ret->merge));
 				ret->merge[i]->src = xstrdup(ret->merge_name[i]);
-				remote_find_tracking(ret->remote,
-						     ret->merge[i]);
+				if(remote_find_tracking(ret->remote,
+						     ret->merge[i]) && !strcmp(ret->remote_name, "."))
+					ret->merge[i]->dst = xstrdup(ret->merge_name[i]);
 			}
 		}
 	}
@@ -1449,8 +1450,8 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb)
 		return 0;
 
 	base = branch->merge[0]->dst;
-	if (!prefixcmp(base, "refs/remotes/")) {
-		base += strlen("refs/remotes/");
+	if (!prefixcmp(base, "refs/")) {
+		base += strlen("refs/");
 	}
 	if (!num_theirs)
 		strbuf_addf(sb, "Your branch is ahead of '%s' "
diff --git a/t/t6040-tracking-info.sh b/t/t6040-tracking-info.sh
index 2a2b6b6..3d6db4d 100755
--- a/t/t6040-tracking-info.sh
+++ b/t/t6040-tracking-info.sh
@@ -58,7 +58,7 @@ test_expect_success 'checkout' '
 	grep "have 1 and 1 different" actual
 '
 
-test_expect_failure 'checkout with local tracked branch' '
+test_expect_success 'checkout with local tracked branch' '
 	git checkout master &&
 	git checkout follower >actual
 	grep "is ahead of" actual
-- 
1.6.2.1.507.g0e68d
