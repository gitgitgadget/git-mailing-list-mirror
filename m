From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] format-patch: use clear_commit_marks() instead of some
 adhocery
Date: Tue, 27 Jun 2006 22:38:04 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0606272236350.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0606250349280.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.63.0606261728340.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <46a038f90606261520k7df8cb3ci7a4a609644e0be12@mail.gmail.com>
 <7vr71bh6sv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 27 22:38:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FvKK3-0005Pw-Tm
	for gcvg-git@gmane.org; Tue, 27 Jun 2006 22:38:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161293AbWF0UiI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Jun 2006 16:38:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161294AbWF0UiI
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jun 2006 16:38:08 -0400
Received: from mail.gmx.de ([213.165.64.21]:26337 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1161293AbWF0UiG (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Jun 2006 16:38:06 -0400
Received: (qmail invoked by alias); 27 Jun 2006 20:38:05 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp029) with SMTP; 27 Jun 2006 22:38:05 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vr71bh6sv.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22753>


It is cleaner, and it describes better what is the idea behind the code.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

	On Mon, 26 Jun 2006, Junio C Hamano wrote:

	> I'll be pushing out a new test for format-patch shortly in
	> "next".

	... and this test fails with my original patch: We also need to 
	reset ADDED, and I threw in SHOWN for good measure.

	Maybe there is room for improvement of the revision walker here;
	It smells a little like ADDED is not only used to avoid duplicate
	parsing (which I guess is now happening, even with
	reset_all_objects_flags() instead of clear_commit_marks()), but
	also to decide if the revision walker should walk on.

	We are getting more and more users of the revision walker, and this
	is just the first to call the walker more than once.

 builtin-log.c |   14 ++++----------
 1 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index 4ee5891..f9515a8 100644
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
@@ -220,7 +211,10 @@ static void get_patch_ids(struct rev_inf
 	}
 
 	/* reset for next revision walk */
-	reset_all_objects_flags();
+	clear_commit_marks((struct commit *)o1,
+			SEEN | UNINTERESTING | SHOWN | ADDED);
+	clear_commit_marks((struct commit *)o2,
+			SEEN | UNINTERESTING | SHOWN | ADDED);
 	o1->flags = flags1;
 	o2->flags = flags2;
 }
-- 
1.4.1.rc1.g9de8f-dirty
