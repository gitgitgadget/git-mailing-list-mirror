From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Teach revision machinery about --reverse
Date: Sun, 21 Jan 2007 12:19:10 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701211154320.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0701181149260.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <45AF5F83.6090207@fs.ei.tum.de> <Pine.LNX.4.63.0701181441010.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vps9ag58g.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0701200052210.12889@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vvej2bkn2.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0701200213020.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vfya69xym.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0701201025070.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vwt3h7dp6.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0701202240210.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <45B2D651.7010606@fs.ei.tum.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 21 12:19:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H8ajE-00070C-Ic
	for gcvg-git@gmane.org; Sun, 21 Jan 2007 12:19:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751356AbXAULTN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 21 Jan 2007 06:19:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751298AbXAULTN
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Jan 2007 06:19:13 -0500
Received: from mail.gmx.net ([213.165.64.20]:57407 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751356AbXAULTM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jan 2007 06:19:12 -0500
Received: (qmail invoked by alias); 21 Jan 2007 11:19:10 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp002) with SMTP; 21 Jan 2007 12:19:10 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
In-Reply-To: <45B2D651.7010606@fs.ei.tum.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37319>


The option --reverse reverses the order of the commits.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---

	On Sun, 21 Jan 2007, Simon 'corecode' Schubert wrote:
	
	> > [the --reverse patch]
	
	Please do not quote parts of the mail you don't really refer to.
	
	> I like this.  However, rev_info.reverse needs some 
	> documentation.  Or the block in get_revision does:
	> 
	> /*
	> * rev_info.reverse is used to note the fact that we want to output the list
	> * of revisions in reverse order.  To accomplish this goal, reverse can have
	> * different values:
	> *  0  do nothing
	> *  1  reverse the list
	> *  2  internal use:  we have already obtained and reversed the list,
	> *     now we only need to yield its items.
	> */
	
	I liked the comment in get_revision() better.
	
	But then an idea just hit me: it might make sense to introduce 
	another flag instead, "no_walk", which says that revs->commits 
	should be walked as is, not walking parents.
	
	And then I saw it already exists. D'oh.

 Documentation/git-rev-list.txt |    5 +++++
 revision.c                     |   20 ++++++++++++++++++++
 revision.h                     |    3 ++-
 3 files changed, 27 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-rev-list.txt b/Documentation/git-rev-list.txt
index 86c94e7..6bb9f51 100644
--- a/Documentation/git-rev-list.txt
+++ b/Documentation/git-rev-list.txt
@@ -27,6 +27,7 @@ SYNOPSIS
 	     [ \--pretty | \--header ]
 	     [ \--bisect ]
 	     [ \--merge ]
+	     [ \--reverse ]
 	     <commit>... [ \-- <paths>... ]
 
 DESCRIPTION
@@ -249,6 +250,10 @@ By default, the commits are shown in reverse chronological order.
 	parent comes before all of its children, but otherwise things
 	are still ordered in the commit timestamp order.
 
+--reverse::
+
+	Output the commits in reverse order.
+
 Object Traversal
 ~~~~~~~~~~~~~~~~
 
diff --git a/revision.c b/revision.c
index ebd0250..6d512ff 100644
--- a/revision.c
+++ b/revision.c
@@ -1057,6 +1057,10 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
 					git_log_output_encoding = "";
 				continue;
 			}
+			if (!strcmp(arg, "--reverse")) {
+				revs->reverse ^= 1;
+				continue;
+			}
 
 			opts = diff_opt_parse(&revs->diffopt, argv+i, argc-i);
 			if (opts > 0) {
@@ -1285,6 +1289,22 @@ struct commit *get_revision(struct rev_info *revs)
 {
 	struct commit *c = NULL;
 
+	if (revs->reverse) {
+		struct commit_list *list;
+
+		revs->reverse = 0;
+		list = NULL;
+		while ((c = get_revision(revs)))
+			commit_list_insert(c, &list);
+		revs->commits = list;
+		revs->no_walk = 1;
+		/* reset flags */
+		while (list) {
+			list->item->object.flags &= ~(ADDED | SEEN | SHOWN);
+			list = list->next;
+		}
+	}
+
 	if (0 < revs->skip_count) {
 		while ((c = get_revision_1(revs)) != NULL) {
 			if (revs->skip_count-- <= 0)
diff --git a/revision.h b/revision.h
index d93481f..3eb1ce4 100644
--- a/revision.h
+++ b/revision.h
@@ -42,7 +42,8 @@ struct rev_info {
 			unpacked:1, /* see also ignore_packed below */
 			boundary:1,
 			left_right:1,
-			parents:1;
+			parents:1,
+			reverse:1;
 
 	/* Diff flags */
 	unsigned int	diff:1,
-- 
1.5.0.rc1.g956c1-dirty
