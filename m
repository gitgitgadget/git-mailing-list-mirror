From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [RFC/PATCH] commit: allow partial commits with relative paths
Date: Mon, 25 Jul 2011 09:42:10 +0200
Message-ID: <19b908142567fcfafe4da3d0fd60b134d30c613a.1311579663.git.git@drmicha.warpmail.net>
References: <CAOnWdohKfwEOMx=wr_PKiW+ucYBK2ZWykm_7dqr7hy4xGRM02A@mail.gmail.com>
Cc: Reuben Thomas <rrt@sc3d.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 25 09:42:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QlFnv-0007MI-VT
	for gcvg-git-2@lo.gmane.org; Mon, 25 Jul 2011 09:42:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751380Ab1GYHmQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jul 2011 03:42:16 -0400
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:33211 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751112Ab1GYHmO (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Jul 2011 03:42:14 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 8A9AA20D02;
	Mon, 25 Jul 2011 03:42:13 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute3.internal (MEProxy); Mon, 25 Jul 2011 03:42:13 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references; s=smtpout; bh=P1JxJ/FNmdV7uv+SU+HoNE8Vx
	Xs=; b=t6+xx6Ry6A+49fpEcXX4ZGMQIQjkqKOVDwn2uCuBF82qOddEiQiNFfmIL
	CCAvJrnHTrtFsNEwnjcBTC3TLagP1YMdI9bthFx5b5oUrTSaZUvSMjTd5licxQ6D
	FfwgqxkyVV7iNy9SD6QwFKp5+rpHESKnPssvMJXs6+oenvxGvA=
X-Sasl-enc: RvLnGY5ees5g/Z219Quo+Wp3JaiVmYKJa06Ooqh3LGS4 1311579733
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 0FC95453F83;
	Mon, 25 Jul 2011 03:42:12 -0400 (EDT)
X-Mailer: git-send-email 1.7.6.336.gdf067
In-Reply-To: <CAOnWdohKfwEOMx=wr_PKiW+ucYBK2ZWykm_7dqr7hy4xGRM02A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177783>

In order to do partial commits, git-commit overlays a tree on the
cache and checks pathspecs against the result. Currently, the overlaying
is done using "prefix" which prevents relative pathspecs with ".." and
absolute pathspec from matching when they refer to files not under
"prefix" and absent from the index, but still in the tree (i.e. files
staged for removal).

Overlay the full tree instead.

Reported-by: Reuben Thomas <rrt@sc3d.org>
Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
RFC because lack of test, and also because I'm not sure we want this, and
what to do about git add which has the same problem, but would need a
different fix.
---
 builtin/commit.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index e1af9b1..431590c 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -257,7 +257,7 @@ static int list_paths(struct string_list *list, const char *with_tree,
 	m = xcalloc(1, i);
 
 	if (with_tree)
-		overlay_tree_on_cache(with_tree, prefix);
+		overlay_tree_on_cache(with_tree, NULL);
 
 	for (i = 0; i < active_nr; i++) {
 		struct cache_entry *ce = active_cache[i];
-- 
1.7.6.336.gdf067
