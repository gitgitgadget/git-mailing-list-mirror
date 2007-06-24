From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH] diffcore-rename: don't change similarity index based on basename
 equality
Date: Mon, 25 Jun 2007 00:23:28 +0200
Message-ID: <467EEEE0.5010203@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>,
	David Kastrup <dak@gnu.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Jun 25 00:23:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2aUk-0003f0-Je
	for gcvg-git@gmane.org; Mon, 25 Jun 2007 00:23:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751829AbXFXWXn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Jun 2007 18:23:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751692AbXFXWXn
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Jun 2007 18:23:43 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:40542
	"EHLO neapel230.server4you.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751202AbXFXWXn (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Jun 2007 18:23:43 -0400
Received: from [10.0.1.201] (p508E4382.dip.t-dialin.net [80.142.67.130])
	by neapel230.server4you.de (Postfix) with ESMTP id E2EEE7059;
	Mon, 25 Jun 2007 00:23:41 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.4 (Windows/20070604)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50834>

This implements a suggestion from Johannes.  It uses a separate field in
struct diff_score to keep the result of the file name comparison in the
rename detection logic.  This reverts the value of the similarity index
to be a function of file contents, only, and basename comparison is only
used to decide between files with equal amounts of content changes.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---

 diffcore-rename.c |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index 79c984c..e0a89f3 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -138,6 +138,7 @@ struct diff_score {
 	int src; /* index in rename_src */
 	int dst; /* index in rename_dst */
 	int score;
+	int name_score;
 };
 
 static int estimate_similarity(struct diff_filespec *src,
@@ -201,11 +202,8 @@ static int estimate_similarity(struct diff_filespec *src,
 	 */
 	if (!dst->size)
 		score = 0; /* should not happen */
-	else {
+	else
 		score = (int)(src_copied * MAX_SCORE / max_size);
-		if (basename_same(src, dst))
-			score++;
-	}
 	return score;
 }
 
@@ -242,6 +240,10 @@ static void record_rename_pair(int dst_index, int src_index, int score)
 static int score_compare(const void *a_, const void *b_)
 {
 	const struct diff_score *a = a_, *b = b_;
+
+	if (a->score == b->score)
+		return b->name_score - a->name_score;
+
 	return b->score - a->score;
 }
 
@@ -360,6 +362,7 @@ void diffcore_rename(struct diff_options *options)
 			m->dst = i;
 			m->score = estimate_similarity(one, two,
 						       minimum_score);
+			m->name_score = basename_same(one, two);
 			diff_free_filespec_data(one);
 		}
 		/* We do not need the text anymore */
