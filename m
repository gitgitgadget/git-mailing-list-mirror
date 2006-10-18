From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] When rewriting parents, cull duplicates
Date: Wed, 18 Oct 2006 16:26:56 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0610181622320.14200@wbgn013.biozentrum.uni-wuerzburg.de>
References: <eh5242$rar$1@sea.gmane.org>
 <Pine.LNX.4.63.0610181551150.14200@wbgn013.biozentrum.uni-wuerzburg.de>
 <200610181602.36856.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 18 16:27:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GaCNp-0004Mj-8E
	for gcvg-git@gmane.org; Wed, 18 Oct 2006 16:27:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161027AbWJRO07 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Oct 2006 10:26:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161033AbWJRO07
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Oct 2006 10:26:59 -0400
Received: from mail.gmx.net ([213.165.64.20]:39822 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1161027AbWJRO06 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Oct 2006 10:26:58 -0400
Received: (qmail invoked by alias); 18 Oct 2006 14:26:57 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp042) with SMTP; 18 Oct 2006 16:26:57 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <200610181602.36856.jnareb@gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29235>


Earlier, when calling

	git log --parents some-ref -- path/file

it was possible that in case of merges, multiple parents would be
rewritten as the _same_ commit, which would happily be printed
multiple times.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

	Subject: Re: [BUG] git-log shows first parent and repeated last 
	for octopus merge

	On Wed, 18 Oct 2006, Jakub Narebski wrote:

	> Johannes Schindelin wrote:
	> > On Wed, 18 Oct 2006, Jakub Narebski wrote:
	> > 
	> > > When trying to find how many merges and how many octopus 
	> > > merges (merges with more than two parents) are in git.git 
	> > > repository I have encountered the following strange output 
	> > > of git-log:
	> > > 
	> > > 1000:jnareb@roke:~/git> git log --parents --full-history \
	> > > --max-count=1 211232bae64bcc60bbf5d1b5e5b2344c22ed767e -- a//b
	> > >  commit 211232bae64bcc60bbf5d1b5e5b2344c22ed767e <...>
	> > >  Merge: d0d0d0b... d0d0d0b... d0d0d0b... d0d0d0b... d0d0d0b...
	> > >  [...]
	> > 
	> > This happens because a//b rewrites the history, i.e. the 
	> > parents are edited. IMHO it makes no sense at all to show the 
	> > parents in such a case, since they are bogus.
	> 
	> Or rather it has no sense to _repeat_ rewritten parent the 
	> number of times the commit has parents originally.

	Here you are.

 revision.c |   13 ++++++++++++-
 1 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/revision.c b/revision.c
index 280e92b..8a2ca52 100644
--- a/revision.c
+++ b/revision.c
@@ -1086,12 +1086,23 @@ static int rewrite_one(struct rev_info *
 	}
 }
 
+static int parent_is_duplicate(struct commit_list *parents,
+		struct commit_list *current)
+{
+	for (; parents != current; parents = parents->next)
+		if (parents->item == current->item)
+			return 1;
+	return 0;
+}
+
 static void rewrite_parents(struct rev_info *revs, struct commit *commit)
 {
 	struct commit_list **pp = &commit->parents;
 	while (*pp) {
 		struct commit_list *parent = *pp;
-		if (rewrite_one(revs, &parent->item) < 0) {
+		if (rewrite_one(revs, &parent->item) < 0 ||
+				/* cull duplicates */
+				parent_is_duplicate(commit->parents, parent)) {
 			*pp = parent->next;
 			continue;
 		}
-- 
1.4.2.4.g21cef-dirty
