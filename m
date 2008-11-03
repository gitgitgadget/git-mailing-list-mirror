From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 2/4] revision: make tree comparison functions take commits
 rather than trees
Date: Mon, 3 Nov 2008 11:35:35 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0811031133590.3419@nehalem.linux-foundation.org>
References: <200811031439.12111.brian.foster@innova-card.com> <alpine.LFD.2.00.0811031129060.3419@nehalem.linux-foundation.org> <alpine.LFD.2.00.0811031132520.3419@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Brian Foster <brian.foster@innova-card.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 03 20:38:06 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kx5FL-0001P2-Ba
	for gcvg-git-2@gmane.org; Mon, 03 Nov 2008 20:37:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754063AbYKCTgV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2008 14:36:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754055AbYKCTgV
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Nov 2008 14:36:21 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:43762 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754000AbYKCTgU (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Nov 2008 14:36:20 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id mA3JZa6b022264
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 3 Nov 2008 11:35:37 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id mA3JZZDj023859;
	Mon, 3 Nov 2008 11:35:36 -0800
In-Reply-To: <alpine.LFD.2.00.0811031132520.3419@nehalem.linux-foundation.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.94 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99983>


From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 3 Nov 2008 10:45:41 -0800
Subject: [PATCH 2/4] revision: make tree comparison functions take commits rather than trees

This will make it easier to do various clever things that don't depend
on the pure tree contents.  It also makes the parameter passing much
simpler - the callers doesn't really look at trees anywhere else, and
it's really the function that should look at the low-level details.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---

This is a trivial no-op change that just passes commits instead of trees 
to the commit compare functions. The whole point is that we can now start 
comparing them based on not just contents of the trees, but other 
attributes too.

The patch makes no semantic changes. Just preparation.

 revision.c |   14 +++++++++-----
 1 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/revision.c b/revision.c
index d45f05a..56b09eb 100644
--- a/revision.c
+++ b/revision.c
@@ -294,8 +294,11 @@ static void file_change(struct diff_options *options,
 	DIFF_OPT_SET(options, HAS_CHANGES);
 }
 
-static int rev_compare_tree(struct rev_info *revs, struct tree *t1, struct tree *t2)
+static int rev_compare_tree(struct rev_info *revs, struct commit *parent, struct commit *commit)
 {
+	struct tree *t1 = parent->tree;
+	struct tree *t2 = commit->tree;
+
 	if (!t1)
 		return REV_TREE_NEW;
 	if (!t2)
@@ -308,12 +311,13 @@ static int rev_compare_tree(struct rev_info *revs, struct tree *t1, struct tree
 	return tree_difference;
 }
 
-static int rev_same_tree_as_empty(struct rev_info *revs, struct tree *t1)
+static int rev_same_tree_as_empty(struct rev_info *revs, struct commit *commit)
 {
 	int retval;
 	void *tree;
 	unsigned long size;
 	struct tree_desc empty, real;
+	struct tree *t1 = commit->tree;
 
 	if (!t1)
 		return 0;
@@ -347,7 +351,7 @@ static void try_to_simplify_commit(struct rev_info *revs, struct commit *commit)
 		return;
 
 	if (!commit->parents) {
-		if (rev_same_tree_as_empty(revs, commit->tree))
+		if (rev_same_tree_as_empty(revs, commit))
 			commit->object.flags |= TREESAME;
 		return;
 	}
@@ -367,7 +371,7 @@ static void try_to_simplify_commit(struct rev_info *revs, struct commit *commit)
 			die("cannot simplify commit %s (because of %s)",
 			    sha1_to_hex(commit->object.sha1),
 			    sha1_to_hex(p->object.sha1));
-		switch (rev_compare_tree(revs, p->tree, commit->tree)) {
+		switch (rev_compare_tree(revs, p, commit)) {
 		case REV_TREE_SAME:
 			tree_same = 1;
 			if (!revs->simplify_history || (p->object.flags & UNINTERESTING)) {
@@ -387,7 +391,7 @@ static void try_to_simplify_commit(struct rev_info *revs, struct commit *commit)
 
 		case REV_TREE_NEW:
 			if (revs->remove_empty_trees &&
-			    rev_same_tree_as_empty(revs, p->tree)) {
+			    rev_same_tree_as_empty(revs, p)) {
 				/* We are adding all the specified
 				 * paths from this parent, so the
 				 * history beyond this parent is not
-- 
1.6.0.3.616.gf1239d6.dirty
