From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH] Fix behavior with non-committish upstream references
Date: Mon, 27 Apr 2009 18:26:43 +0200
Message-ID: <1240849603-26127-1-git-send-email-git@drmicha.warpmail.net>
References: <49F03A74.5080805@emlix.com>
Cc: Simon Braunschmidt <sb@emlix.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 27 18:27:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LyTfb-0002OP-QQ
	for gcvg-git-2@gmane.org; Mon, 27 Apr 2009 18:27:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755899AbZD0Q0z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Apr 2009 12:26:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755831AbZD0Q0y
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Apr 2009 12:26:54 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:56002 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755768AbZD0Q0y (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Apr 2009 12:26:54 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id 14D8C322453;
	Mon, 27 Apr 2009 12:26:53 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Mon, 27 Apr 2009 12:26:53 -0400
X-Sasl-enc: aJkM4WpZyQGCtgAKWH5uTG4hmXt0mukLMZHaSEjCLibU 1240849612
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 646A533251;
	Mon, 27 Apr 2009 12:26:52 -0400 (EDT)
X-Mailer: git-send-email 1.6.3.rc3
In-Reply-To: <49F03A74.5080805@emlix.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117686>

stat_tracking_info() assumes that upstream references (as specified by
--track or set up automatically) are commits. By calling lookup_commit()
on them, create_objects() creates objects for them with type commit no
matter what their real type is; this disturbs lookup_tag() later on the
call sequence, leading to git status, git branch -v  and git checkout
erroring out.

Fix this by using lookup_commit_reference() instead so that (annotated)
tags can be used as upstream references.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
I'm sorry I won't be able to write a test any more today. Please let me
whether it's okay without a test.

 remote.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

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
 
-- 
1.6.3.rc3
