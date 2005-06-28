From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Use enhanced diff_delta() in the similarity estimator.
Date: Tue, 28 Jun 2005 16:58:27 -0700
Message-ID: <7vr7emrq3g.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 29 02:31:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DnQUL-0000Ps-2m
	for gcvg-git@gmane.org; Wed, 29 Jun 2005 02:31:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262246AbVF2AhW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 28 Jun 2005 20:37:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262313AbVF1X70
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Jun 2005 19:59:26 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:46031 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S262324AbVF1X6e (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jun 2005 19:58:34 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050628235827.BAZS7275.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 28 Jun 2005 19:58:27 -0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

The diff_delta() interface has been extended to reject
generating too big a delta while we were working on the packed
GIT archive format.  Take advantage of that when generating
delta in the similarity estimator used in diffcore-rename.c

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 diffcore-rename.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

e4495245cf1ffc1c443df9177c95ce9d1b5052b0
diff --git a/diffcore-rename.c b/diffcore-rename.c
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -136,6 +136,7 @@ static int estimate_similarity(struct di
 	 */
 	void *delta;
 	unsigned long delta_size, base_size, src_copied, literal_added;
+	unsigned long delta_limit;
 	int score;
 
 	/* We deal only with regular files.  Symlink renames are handled
@@ -163,9 +164,13 @@ static int estimate_similarity(struct di
 	if (diff_populate_filespec(src, 0) || diff_populate_filespec(dst, 0))
 		return 0; /* error but caught downstream */
 
+	delta_limit = base_size * (MAX_SCORE-minimum_score) / MAX_SCORE;
 	delta = diff_delta(src->data, src->size,
 			   dst->data, dst->size,
-			   &delta_size, ~0UL);
+			   &delta_size, delta_limit);
+	if (!delta)
+		/* If delta_limit is exceeded, we have too much differences */
+		return 0;
 
 	/* A delta that has a lot of literal additions would have
 	 * big delta_size no matter what else it does.
------------
