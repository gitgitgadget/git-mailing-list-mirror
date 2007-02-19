From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] rev-list --max-age, --max-count: support --boundary
Date: Mon, 19 Feb 2007 03:14:59 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702190312120.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Mon Feb 19 03:15:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HIy3i-0006oq-Mk
	for gcvg-git@gmane.org; Mon, 19 Feb 2007 03:15:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752726AbXBSCPD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Feb 2007 21:15:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752727AbXBSCPD
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Feb 2007 21:15:03 -0500
Received: from mail.gmx.net ([213.165.64.20]:39103 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752726AbXBSCPB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Feb 2007 21:15:01 -0500
Received: (qmail invoked by alias); 19 Feb 2007 02:14:59 -0000
X-Provags-ID: V01U2FsdGVkX1+HrFM/npyH5CEXgaQqlZDuMsqzeaJLZ20B7IFNGj
	Lp4Q==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40094>


Now, when saying --max-age=<timestamp>, or --max-count=<n>, together
with --boundary, rev-list prints the boundary commits, i.e. the
commits which are _just_ not shown without --boundary, i.e. their
children are, but they aren't.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---

	Of course, this is meant to speed up an otherwise expensive
	operation in git-bundle.

	However, this touches a very sensitive point in core git:
	the revision walking machinery. It passes all tests, but
	some eyeballing is much appreciated.

	Ah, and somebody better at writing short concise descriptions
	then me should look into documenting "edge" objects and
	"boundary" commits to the glossary (possibly after thinking
	if "edge" and "boundary" do mean the same after all).

	'nough for one night.

 revision.c |   24 ++++++++++++++++++++----
 1 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/revision.c b/revision.c
index 5b1794b..87aea9c 100644
--- a/revision.c
+++ b/revision.c
@@ -1233,9 +1233,15 @@ static struct commit *get_revision_1(struct rev_info *revs)
 		 */
 		if (!revs->limited) {
 			if (revs->max_age != -1 &&
-			    (commit->date < revs->max_age))
-				continue;
-			add_parents_to_list(revs, commit, &revs->commits);
+			    (commit->date < revs->max_age)) {
+				if (revs->boundary)
+					commit->object.flags |=
+						BOUNDARY_SHOW | BOUNDARY;
+				else
+					continue;
+			} else
+				add_parents_to_list(revs, commit,
+						&revs->commits);
 		}
 		if (commit->object.flags & SHOWN)
 			continue;
@@ -1336,7 +1342,17 @@ struct commit *get_revision(struct rev_info *revs)
 	case -1:
 		break;
 	case 0:
-		return NULL;
+		if (revs->boundary) {
+			struct commit_list *list = revs->commits;
+			while (list) {
+				list->item->object.flags |=
+					BOUNDARY_SHOW | BOUNDARY;
+				list = list->next;
+			}
+			revs->max_count = -1;
+			revs->limited = 1;
+		} else
+			return NULL;
 	default:
 		revs->max_count--;
 	}
