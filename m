From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Fix tweak in similarity estimator.
Date: Sun, 22 May 2005 01:31:28 -0700
Message-ID: <7vacmnd5lr.fsf_-_@assigned-by-dhcp.cox.net>
References: <7vwtpsdvgm.fsf@assigned-by-dhcp.cox.net>
	<7v1x80dluj.fsf@assigned-by-dhcp.cox.net>
	<7vvf5cc779.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505212253350.2206@ppc970.osdl.org>
	<7vis1bd9y4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 22 10:30:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZlqs-00078l-64
	for gcvg-git@gmane.org; Sun, 22 May 2005 10:30:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261780AbVEVIbh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 May 2005 04:31:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261783AbVEVIbd
	(ORCPT <rfc822;git-outgoing>); Sun, 22 May 2005 04:31:33 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:25553 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S261780AbVEVIba (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 May 2005 04:31:30 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050522083128.SISU7629.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 22 May 2005 04:31:28 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vis1bd9y4.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Sat, 21 May 2005 23:57:39 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "JCH" == Junio C Hamano <junkio@cox.net> writes:

JCH> Plain -C (or -M) not working was a bug I now understand why,
JCH> and I would not be surprised that -C10 may give ridiculous
JCH> or hilarious results (false hits), but I am having trouble
JCH> reproducing the -C90 case.  Will do some more digging later.

An embarrasing math thinko was causing this confusion.

------------
Fix tweak in similarity estimator.

There was a screwy math bug in the estimator that confused what
-C1 meant and what -C9 meant, only in one of the early "cheap"
check, which resulted in quite confusing behaviour.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

diffcore-rename.c |    4 ++--
1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/diffcore-rename.c b/diffcore-rename.c
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -77,12 +77,12 @@ static int estimate_similarity(struct di
 
 	/* We would not consider edits that change the file size so
 	 * drastically.  delta_size must be smaller than
-	 * minimum_score/MAX_SCORE * min(src->size, dst->size).
+	 * (MAX_SCORE-minimum_score)/MAX_SCORE * min(src->size, dst->size).
 	 * Note that base_size == 0 case is handled here already
 	 * and the final score computation below would not have a
 	 * divide-by-zero issue.
 	 */
-	if (base_size * minimum_score < delta_size * MAX_SCORE)
+	if (base_size * (MAX_SCORE-minimum_score) < delta_size * MAX_SCORE)
 		return 0;
 
 	delta = diff_delta(src->data, src->size,

