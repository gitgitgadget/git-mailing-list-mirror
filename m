From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv2 2/2] Make local branches behave like remote branches when --tracked
Date: Wed,  1 Apr 2009 23:42:49 +0200
Message-ID: <1238622169-5238-3-git-send-email-git@drmicha.warpmail.net>
References: <49CD0440.6010304@drmicha.warpmail.net>
 <1238622169-5238-1-git-send-email-git@drmicha.warpmail.net>
 <1238622169-5238-2-git-send-email-git@drmicha.warpmail.net>
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 01 23:44:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lp8Em-0000Pm-Nu
	for gcvg-git-2@gmane.org; Wed, 01 Apr 2009 23:44:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934728AbZDAVnL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Apr 2009 17:43:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934761AbZDAVnI
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Apr 2009 17:43:08 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:44076 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934727AbZDAVnG (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Apr 2009 17:43:06 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 0D24130DFD8;
	Wed,  1 Apr 2009 17:43:04 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Wed, 01 Apr 2009 17:43:04 -0400
X-Sasl-enc: /e8eJv4XRhtr92PQpLuzM4ZQOc+1kJG1yL7bOXMIehY0 1238622183
Received: from localhost (p4FC63601.dip0.t-ipconnect.de [79.198.54.1])
	by mail.messagingengine.com (Postfix) with ESMTPSA id F405045E18;
	Wed,  1 Apr 2009 17:43:02 -0400 (EDT)
X-Mailer: git-send-email 1.6.2.1.507.g0e68d
In-Reply-To: <1238622169-5238-2-git-send-email-git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115417>

This makes sure that local branches, when followed using --track, behave
the same as remote ones (e.g. differences being reported by git status
and git checkout). This fixes 1 known failure.

The fix is done within branch_get(): The first natural candidate,
namely remote_find_tracking(), does not have all the necessary info
because in general there is no remote struct for '.', and we don't want
one because it would show up in other places as well.

branch_get(), on the other hand, has access to merge_names[] (in
addition to merge[]) and therefore can set up the followed branch
easily.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 remote.c                 |    7 +++++--
 t/t6040-tracking-info.sh |    2 +-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/remote.c b/remote.c
index 2b037f1..d12140e 100644
--- a/remote.c
+++ b/remote.c
@@ -1170,8 +1170,9 @@ struct branch *branch_get(const char *name)
 			for (i = 0; i < ret->merge_nr; i++) {
 				ret->merge[i] = xcalloc(1, sizeof(**ret->merge));
 				ret->merge[i]->src = xstrdup(ret->merge_name[i]);
-				remote_find_tracking(ret->remote,
-						     ret->merge[i]);
+				if (remote_find_tracking(ret->remote, ret->merge[i])
+				    && !strcmp(ret->remote_name, "."))
+					ret->merge[i]->dst = xstrdup(ret->merge_name[i]);
 			}
 		}
 	}
@@ -1451,6 +1452,8 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb)
 	base = branch->merge[0]->dst;
 	if (!prefixcmp(base, "refs/remotes/")) {
 		base += strlen("refs/remotes/");
+	} else if (!prefixcmp(base, "refs/heads/")) {
+		base += strlen("refs/heads/");
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
