From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Clean up and simplify rev_compare_tree()
Date: Tue, 2 Jun 2009 18:34:01 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0906021820570.4880@localhost.localdomain>
References: <EB2D87B9-3B03-431A-B204-C7799F9BA291@ausperks.net> <20090602213439.GA7584@coredump.intra.peff.net> <alpine.LFD.2.01.0906021439030.4880@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Graham Perks <gperks@ausperks.net>, Jeff King <peff@peff.net>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 03 03:34:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBfNQ-0001Eb-EF
	for gcvg-git-2@gmane.org; Wed, 03 Jun 2009 03:34:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752075AbZFCBek (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2009 21:34:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751902AbZFCBej
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Jun 2009 21:34:39 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:54055 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751264AbZFCBei (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Jun 2009 21:34:38 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n531Y2nr030167
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 2 Jun 2009 18:34:03 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n531Y17f012675;
	Tue, 2 Jun 2009 18:34:01 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <alpine.LFD.2.01.0906021439030.4880@localhost.localdomain>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.463 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120571>


This simplifies the logic of rev_compare_tree() by removing a special 
case. 

It does so by turning the special case of finding a diff to be "all new 
files" into a more generic case of "all new" vs "all removed" vs "mixed 
changes", so now the code is actually more powerful and more generic, and 
the added symmetry actually makes it simpler too.

This makes no changes to any existing behavior, but apart from the 
simplification it does make it possible to some day care about whether all 
changes were just deletions if we want to. Which we may well want to for 
merge handling.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---

This is just a cleanup while I'm looking at the code. There's two things 
that are relevant to merges - the "TREESAME" logic that determines whether 
we should simplify the merge away and pick just one parent, and the actual 
diff creation logic that then creates diffs of the merges that we don't 
simplify away.

The two are totally independent, and this patch just cleans up the helper 
function that we use for the commit simplification logic. 

The only half-way subtle part here (and it really isn't that subtle) is 
that "REV_TREE_NEW | REV_TREE_OLD == REV_TREE_DIFFERENT", which makes 
sense and just simplifies the logic in general. It used to be that mixing 
REV_TREE_NEW state with REV_TREE_DIFFERENT was complicated. Now it's 
trivial, thanks to REV_TREE_OLD that is currently otherwise unused (we 
treat it the same way as REV_TREE_DIFFERENT, which is what that case used 
to result in).

There's an unrelated cleanup which is to just move the "can't happen" 
special case code of a missing commit tree up to the same point as the 
"can't happen" missing parent tree.

On Tue, 2 Jun 2009, Linus Torvalds wrote:
> 
> Now, I admit that in this case the matching heuristic is dubious, and 
> maybe we should consider "does not exist in result" to not match any 
> parent. We already think that "all new" is special ("REV_TREE_NEW" vs 
> "REV_TREE_DIFFERENT"), so maybe we should think that "all deleted" is also 
> special ("REV_TREE_DEL")
> 
> 		Linus
> 

 revision.c |   33 ++++++++++++---------------------
 revision.h |    5 +++--
 2 files changed, 15 insertions(+), 23 deletions(-)

diff --git a/revision.c b/revision.c
index 18b7ebb..bf58448 100644
--- a/revision.c
+++ b/revision.c
@@ -256,10 +256,12 @@ static int everybody_uninteresting(struct commit_list *orig)
 
 /*
  * The goal is to get REV_TREE_NEW as the result only if the
- * diff consists of all '+' (and no other changes), and
- * REV_TREE_DIFFERENT otherwise (of course if the trees are
- * the same we want REV_TREE_SAME).  That means that once we
- * get to REV_TREE_DIFFERENT, we do not have to look any further.
+ * diff consists of all '+' (and no other changes), REV_TREE_OLD
+ * if the whole diff is removal of old data, and otherwise
+ * REV_TREE_DIFFERENT (of course if the trees are the same we
+ * want REV_TREE_SAME).
+ * That means that once we get to REV_TREE_DIFFERENT, we do not
+ * have to look any further.
  */
 static int tree_difference = REV_TREE_SAME;
 
@@ -268,22 +270,9 @@ static void file_add_remove(struct diff_options *options,
 		    const unsigned char *sha1,
 		    const char *fullpath)
 {
-	int diff = REV_TREE_DIFFERENT;
+	int diff = addremove == '+' ? REV_TREE_NEW : REV_TREE_OLD;
 
-	/*
-	 * Is it an add of a new file? It means that the old tree
-	 * didn't have it at all, so we will turn "REV_TREE_SAME" ->
-	 * "REV_TREE_NEW", but leave any "REV_TREE_DIFFERENT" alone
-	 * (and if it already was "REV_TREE_NEW", we'll keep it
-	 * "REV_TREE_NEW" of course).
-	 */
-	if (addremove == '+') {
-		diff = tree_difference;
-		if (diff != REV_TREE_SAME)
-			return;
-		diff = REV_TREE_NEW;
-	}
-	tree_difference = diff;
+	tree_difference |= diff;
 	if (tree_difference == REV_TREE_DIFFERENT)
 		DIFF_OPT_SET(options, HAS_CHANGES);
 }
@@ -305,6 +294,8 @@ static int rev_compare_tree(struct rev_info *revs, struct commit *parent, struct
 
 	if (!t1)
 		return REV_TREE_NEW;
+	if (!t2)
+		return REV_TREE_OLD;
 
 	if (revs->simplify_by_decoration) {
 		/*
@@ -323,8 +314,7 @@ static int rev_compare_tree(struct rev_info *revs, struct commit *parent, struct
 		if (!revs->prune_data)
 			return REV_TREE_SAME;
 	}
-	if (!t2)
-		return REV_TREE_DIFFERENT;
+
 	tree_difference = REV_TREE_SAME;
 	DIFF_OPT_CLR(&revs->pruning, HAS_CHANGES);
 	if (diff_tree_sha1(t1->object.sha1, t2->object.sha1, "",
@@ -429,6 +419,7 @@ static void try_to_simplify_commit(struct rev_info *revs, struct commit *commit)
 				p->parents = NULL;
 			}
 		/* fallthrough */
+		case REV_TREE_OLD:
 		case REV_TREE_DIFFERENT:
 			tree_changed = 1;
 			pp = &parent->next;
diff --git a/revision.h b/revision.h
index be39e7d..227164c 100644
--- a/revision.h
+++ b/revision.h
@@ -118,8 +118,9 @@ struct rev_info {
 };
 
 #define REV_TREE_SAME		0
-#define REV_TREE_NEW		1
-#define REV_TREE_DIFFERENT	2
+#define REV_TREE_NEW		1	/* Only new files */
+#define REV_TREE_OLD		2	/* Only files removed */
+#define REV_TREE_DIFFERENT	3	/* Mixed changes */
 
 /* revision.c */
 void read_revisions_from_stdin(struct rev_info *revs);
