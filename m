From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] threeway_merge: if file will not be touched, leave it alone
Date: Sun, 22 Oct 2006 23:04:07 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0610222301080.14200@wbgn013.biozentrum.uni-wuerzburg.de>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
 <200610201821.34712.jnareb@gmail.com> <20061020181210.GA29843@artax.karlin.mff.cuni.cz>
 <200610202047.11291.jnareb@gmail.com> <Pine.LNX.4.64.0610201151130.3962@g5.osdl.org>
 <45391F1C.80100@utoronto.ca> <Pine.LNX.4.64.0610201231570.3962@g5.osdl.org>
 <4539318D.9040004@utoronto.ca> <Pine.LNX.4.64.0610201333240.3962@g5.osdl.org>
 <Pine.LNX.4.63.0610210359040.14200@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v4ptyjttb.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 22 23:04:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbkUQ-0006QH-49
	for gcvg-git@gmane.org; Sun, 22 Oct 2006 23:04:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751470AbWJVVEK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Oct 2006 17:04:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751505AbWJVVEK
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Oct 2006 17:04:10 -0400
Received: from mail.gmx.net ([213.165.64.20]:26554 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751470AbWJVVEJ (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Oct 2006 17:04:09 -0400
Received: (qmail invoked by alias); 22 Oct 2006 21:04:07 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp040) with SMTP; 22 Oct 2006 23:04:07 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v4ptyjttb.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29793>


If the merge base _and_ the to-be merged brach have a certain file, but
HEAD has not, do not complain if that file exists anyway. It will not be
overwritten.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

	On Fri, 20 Oct 2006, Junio C Hamano wrote:

	> While we are talking about merge-recursive, I could use some
	> help from somebody familiar with merge-recursive to complete the
	> read-tree changes Linus mentioned early this month.
	>
	> The issue is that we would want to remove one verify_absent()
	> call in unpack-tree.c:threeway_merge().  When read-tree decides
	> to leave higher stages around, we do not want it to check if the
	> merge could clobber a working tree file, because having an
	> unrelated file at the same path in the working tree sometimes is
	> and sometimes is not a conflict, depending on the outcome of the
	> merge, and that part of the code does not _know_ the outcome
	> yet.

	How about this? It passes the testsuite, and I tested it with the 
	test case you did, and with the same test case with recursive 
	merge.

 unpack-trees.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 3ac0289..b4994c4 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -658,10 +658,9 @@ int threeway_merge(struct cache_entry **
 	 * up-to-date to avoid the files getting overwritten with
 	 * conflict resolution files.
 	 */
-	if (index) {
+	if (index)
 		verify_uptodate(index, o);
-	}
-	else if (path)
+	else if (no_anc_exists)
 		verify_absent(path, "overwritten", o);
 
 	o->nontrivial_merge = 1;
-- 
1.4.3.1.ga3de1-dirty
