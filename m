From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] revision walker: Fix --boundary when limited
Date: Mon, 5 Mar 2007 19:55:48 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703051951340.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <8aa486160703050202y5ee159d2i42a2859a00b41679@mail.gmail.com>
 <7vlkicynwm.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1148973799-300406434-1173120948=:22628"
Cc: =?utf-8?Q?Santi_B=C3=A9jar?= <sbejar@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Mar 05 19:56:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOIMF-0005O7-M3
	for gcvg-git@gmane.org; Mon, 05 Mar 2007 19:56:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932215AbXCESzv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Mar 2007 13:55:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932226AbXCESzv
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Mar 2007 13:55:51 -0500
Received: from mail.gmx.net ([213.165.64.20]:37109 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932215AbXCESzu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2007 13:55:50 -0500
Received: (qmail invoked by alias); 05 Mar 2007 18:55:48 -0000
X-Provags-ID: V01U2FsdGVkX181cpBnI6o1VvBKxAwxLjo+GO33bwTzG32XFv8A7R
	yI5PSDOU6p2bA4
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vlkicynwm.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41472>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1148973799-300406434-1173120948=:22628
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT


In case revs->limited == 1, the revision walker really reads
everything into revs->commits. The behaviour introduced in
c4025103fa does not behave correctly in that case.

It used to say: everything which is _still_ in the pipeline
must be a boundary commit.

So, in the case that revs->limited == 1, filter out all commits
which are not dangling, in effect marking only the dangling
ones as boundary commits.

This bug was noticed by Santi Béjar.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---

	On Mon, 5 Mar 2007, Junio C Hamano wrote:

	> "Santi Béjar" <sbejar@gmail.com> writes:
	> 
	> > the --topo-order does not play well with --boundary and 
	> > --max-count.
	> >
	> > $ git-rev-list --boundary --max-count=50 5ced0 | wc -l
	> > 56
	> > $ git-rev-list --topo-order --boundary --max-count=50 5ced0 \
	> >   | wc -l
	> > 8846
	> >
	> > (5ced0 is git.git's master). I think it should be 56 for both. 
	> > It presents this behaviour since c4025103fa, when was added 
	> > --boundary support for git-rev-list --max-count and --max-age.
	> 
	> I think the code that does --boundary when the list is limited
	> with --max-count is not quite right, even without topo-order.

	Right.

	> It needs to find out commits (be they marked as UNINTERESTING or
	> not) still in the revs->commits that are _not_ reachable by any
	> other commits in the list, or something like that.
	> 
	> I suspect that would unfortunately be very expensive.  Dscho,
	> have better ideas?

	Unfortunately not. Fortunately, it is nowhere near as expensive as 
	I originally thought. It just has to iterate through revs->commits 
	three times, which is way cheaper than sorting the commits in the 
	first place.

	Junio, if you apply this, could you make extra sure that I did not 
	fsck up Santi's family name (I am running on a peculiar mixture of 
	UTF-8 and ISO-8859-1 terminals...).

 revision.c |   31 +++++++++++++++++++++++++++----
 1 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/revision.c b/revision.c
index f5b8ae4..8d47fac 100644
--- a/revision.c
+++ b/revision.c
@@ -1294,6 +1294,26 @@ static struct commit *get_revision_1(struct rev_info *revs)
 	return NULL;
 }
 
+static struct commit_list *get_dangling_commits(struct commit_list *list)
+{
+	struct commit_list *result = NULL, *iter, *parent;
+
+	for (iter = list; iter; iter = iter->next)
+		for (parent = iter->item->parents;
+				parent;
+				parent = parent->next)
+			parent->item->object.flags |= TMP_MARK;
+	for (iter = list; iter; iter = iter->next)
+		if (!(iter->item->object.flags & TMP_MARK))
+			commit_list_insert(iter->item, &result);
+	for (iter = list; iter; iter = iter->next)
+		for (parent = iter->item->parents;
+				parent;
+				parent = parent->next)
+			parent->item->object.flags &= ~TMP_MARK;
+	return result;
+}
+
 struct commit *get_revision(struct rev_info *revs)
 {
 	struct commit *c = NULL;
@@ -1345,12 +1365,15 @@ struct commit *get_revision(struct rev_info *revs)
 		break;
 	case 0:
 		if (revs->boundary) {
-			struct commit_list *list = revs->commits;
-			while (list) {
+			struct commit_list *list;
+			if (revs->limited) {
+				list = get_dangling_commits(revs->commits);
+				free_commit_list(revs->commits);
+				revs->commits = list;
+			}
+			for (list = revs->commits; list; list = list->next)
 				list->item->object.flags |=
 					BOUNDARY_SHOW | BOUNDARY;
-				list = list->next;
-			}
 			/* all remaining commits are boundary commits */
 			revs->max_count = -1;
 			revs->limited = 1;
-- 
1.5.0.3.2518.g2f72-dirty

---1148973799-300406434-1173120948=:22628--
