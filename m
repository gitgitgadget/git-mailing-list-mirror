From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 2/2] Fix behavior with non-committish upstream references
Date: Mon, 11 May 2009 16:42:54 +0200
Message-ID: <1242052974-28184-3-git-send-email-git@drmicha.warpmail.net>
References: <1242052974-28184-1-git-send-email-git@drmicha.warpmail.net>
 <1242052974-28184-2-git-send-email-git@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 11 16:43:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3WjC-0003qm-0x
	for gcvg-git-2@gmane.org; Mon, 11 May 2009 16:43:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753709AbZEKOnN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 May 2009 10:43:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756717AbZEKOnL
	(ORCPT <rfc822;git-outgoing>); Mon, 11 May 2009 10:43:11 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:40714 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756126AbZEKOnH (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 May 2009 10:43:07 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 66621342500;
	Mon, 11 May 2009 10:43:08 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Mon, 11 May 2009 10:43:08 -0400
X-Sasl-enc: 1ed/jRVtcHtYMicL/locjkzR6Tg2XoyGsPAAMyQr3miY 1242052987
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id C79604FA40;
	Mon, 11 May 2009 10:43:07 -0400 (EDT)
X-Mailer: git-send-email 1.6.3.195.gad816
In-Reply-To: <1242052974-28184-2-git-send-email-git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118806>

stat_tracking_info() assumes that upstream references (as specified by
--track or set up automatically) are commits. By calling lookup_commit()
on them, create_objects() creates objects for them with type commit no
matter what their real type is; this disturbs lookup_tag() later on in the
call sequence, leading to git status, git branch -v  and git checkout
erroring out.

Fix this by using lookup_commit_reference() instead so that (annotated)
tags can be used as upstream references.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 remote.c                 |    4 ++--
 t/t6040-tracking-info.sh |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/remote.c b/remote.c
index d66e2f3..2c3e905 100644
--- a/remote.c
+++ b/remote.c
@@ -1399,13 +1399,13 @@ int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs)
 	base = branch->merge[0]->dst;
 	if (!resolve_ref(base, sha1, 1, NULL))
 		return 0;
-	theirs = lookup_commit(sha1);
+	theirs = lookup_commit_reference(sha1);
 	if (!theirs)
 		return 0;
 
 	if (!resolve_ref(branch->refname, sha1, 1, NULL))
 		return 0;
-	ours = lookup_commit(sha1);
+	ours = lookup_commit_reference(sha1);
 	if (!ours)
 		return 0;
 
diff --git a/t/t6040-tracking-info.sh b/t/t6040-tracking-info.sh
index 2397774..e38c597 100755
--- a/t/t6040-tracking-info.sh
+++ b/t/t6040-tracking-info.sh
@@ -82,7 +82,7 @@ test_expect_success 'status when tracking lightweight tags' '
 	git checkout lighttrack
 '
 
-test_expect_failure 'status when tracking annotated tags' '
+test_expect_success 'status when tracking annotated tags' '
 	git checkout master &&
 	git tag -m heavy heavy && 
 	git branch --track heavytrack heavy >actual &&
-- 
1.6.3.195.gad816
