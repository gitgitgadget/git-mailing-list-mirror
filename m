From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 3/2] format-patch: use clear_commit_marks() instead of some
 adhocery
Date: Mon, 26 Jun 2006 17:33:40 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0606261728340.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0606250349280.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Mon Jun 26 17:35:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fut69-0004lf-Rw
	for gcvg-git@gmane.org; Mon, 26 Jun 2006 17:34:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932489AbWFZPdo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Jun 2006 11:33:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932487AbWFZPdo
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jun 2006 11:33:44 -0400
Received: from mail.gmx.net ([213.165.64.21]:52615 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932489AbWFZPdn (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Jun 2006 11:33:43 -0400
Received: (qmail invoked by alias); 26 Jun 2006 15:33:41 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp017) with SMTP; 26 Jun 2006 17:33:41 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net, martin@catalyst.net.nz
In-Reply-To: <Pine.LNX.4.63.0606250349280.29667@wbgn013.biozentrum.uni-wuerzburg.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22675>


It is cleaner, and it describes better what is the idea behind the code.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

	This goes on top of the --ignore-if-in-upstream patch.

	On Sun, 25 Jun 2006, Johannes Schindelin wrote:

	> - To add the patch ids of the upstream, the revision walker must
	> be called twice.
	> 
	> So, if format-patch was called with a range "a..b" (a single
	> revision "a" is handled as "a..HEAD" by format-patch), a 
	> revision walker is set up for "b..a", and the patch ids are 
	> calculated and stored. This is done by toggling the 
	> UNINTERESTING bits of both pending objects.
	> 
	> After that, the flags of all objects are reset to 0, so that the
	> revisions can be walked again. The flags of the two pending 
	> objects are then reset to their original state.

	It is not clean to reset the flags of all objects to 0. Instead, 
	the commits are walked directly. Not that it matters in that
	particular case (the only read objects _are_ these commits).

 builtin-log.c |   12 ++----------
 1 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index e78a9a4..e2cd975 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -160,15 +160,6 @@ static void reopen_stdout(struct commit 
 	freopen(filename, "w", stdout);
 }
 
-static void reset_all_objects_flags()
-{
-	int i;
-
-	for (i = 0; i < obj_allocs; i++)
-		if (objs[i])
-			objs[i]->flags = 0;
-}
-
 static int get_patch_id(struct commit *commit, struct diff_options *options,
 		unsigned char *sha1)
 {
@@ -220,7 +211,8 @@ static void get_patch_ids(struct rev_inf
 	}
 
 	/* reset for next revision walk */
-	reset_all_objects_flags();
+	clear_commit_marks((struct commit *)o1, SEEN | UNINTERESTING);
+	clear_commit_marks((struct commit *)o2, SEEN | UNINTERESTING);
 	o1->flags = flags1;
 	o2->flags = flags2;
 }
-- 
1.4.1.rc1.gc792
