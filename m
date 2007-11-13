From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 4/2] Fix parent rewriting in --early-output
Date: Mon, 12 Nov 2007 23:16:08 -0800 (PST)
Message-ID: <alpine.LFD.0.9999.0711122309270.2786@woody.linux-foundation.org>
References: <18211.59478.188419.397886@cargo.ozlabs.ibm.com> <18218.63946.772767.179841@cargo.ozlabs.ibm.com> <e5bfff550711020544h1e9a648apfd268eb549645ccc@mail.gmail.com> <alpine.LFD.0.999.0711020828440.3342@woody.linux-foundation.org>
 <alpine.LFD.0.999.0711021114390.3342@woody.linux-foundation.org> <alpine.LFD.0.999.0711021301200.3342@woody.linux-foundation.org> <alpine.LFD.0.999.0711021809060.3342@woody.linux-foundation.org> <alpine.LFD.0.999.0711031103340.3342@woody.linux-foundation.org>
 <18221.14113.498416.396006@cargo.ozlabs.ibm.com> <alpine.LFD.0.999.0711032234030.15101@woody.linux-foundation.org> <alpine.LFD.0.999.0711041004220.15101@woody.linux-foundation.org> <alpine.LFD.0.999.0711041124050.15101@woody.linux-foundation.org>
 <alpine.LFD.0.9999.0711122046570.2786@woody.linux-foundation.org> <7v1wauzomr.fsf@gitster.siamese.dyndns.org> <alpine.LFD.0.9999.0711122238330.2786@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Paul Mackerras <paulus@samba.org>,
	Marco Costalba <mcostalba@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 13 08:16:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Irq0t-0005sO-Gv
	for gcvg-git-2@gmane.org; Tue, 13 Nov 2007 08:16:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751874AbXKMHQ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 02:16:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751844AbXKMHQ3
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 02:16:29 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:59771 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751470AbXKMHQ2 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Nov 2007 02:16:28 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lAD7G9Pc022295
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 12 Nov 2007 23:16:10 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lAD7G8Vw031479;
	Mon, 12 Nov 2007 23:16:09 -0800
In-Reply-To: <alpine.LFD.0.9999.0711122238330.2786@woody.linux-foundation.org>
X-Spam-Status: No, hits=-6.235 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_UNIFIED_DIFF_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64757>



On Mon, 12 Nov 2007, Linus Torvalds wrote:
> 
> I think the real problem is that "TREECHANGE" has the wrong polarity. It 
> should default to always being set, and then we could actively clear it 
> when we do the work to say "it's the same tree". Instead, we default it to 
> being the same (which triggers parent rewriting), and only later may we 
> notice that it wasn't the same.

So, maybe the proper solution is to say "commits are assumed to be 
different to their parents, but we have an explicit bit saying TREESAME 
when we find them to be the same".

This solves the problem quite naturally, because any tree that hasn't been 
parsed - or even if it *has* been parsed, but just hasn't gone through 
the compare function - will then always be seen as "different" and thus 
interesting.

This fairly straight-forward patch seems to work. It *replaces* the 
pervious "patch 4/2", and yes, Junio, I think you were very right to 
complain about that one.

How does this one feel? It basically says "a commit that has TREESAME set 
is kind-of-UNINTERESTING", but obviously in a different way than an 
outright UNINTERESTING commit.

The diff is pretty straightforward - just change the sense of TREECHANGE, 
and that sometimes removes a line, and sometimes adds one, but most of the 
changes are just TREECHANGE => TREESAME, together with a negation of the 
operation.

		Linus

---
 builtin-fmt-merge-msg.c |    2 +-
 builtin-log.c           |    2 +-
 builtin-rev-list.c      |   16 ++++++++--------
 revision.c              |   22 +++++++++++-----------
 revision.h              |    2 +-
 5 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/builtin-fmt-merge-msg.c b/builtin-fmt-merge-msg.c
index 8a3c962..6163bd4 100644
--- a/builtin-fmt-merge-msg.c
+++ b/builtin-fmt-merge-msg.c
@@ -176,7 +176,7 @@ static void shortlog(const char *name, unsigned char *sha1,
 	struct commit *commit;
 	struct object *branch;
 	struct list subjects = { NULL, NULL, 0, 0 };
-	int flags = UNINTERESTING | TREECHANGE | SEEN | SHOWN | ADDED;
+	int flags = UNINTERESTING | TREESAME | SEEN | SHOWN | ADDED;
 
 	branch = deref_tag(parse_object(sha1), sha1_to_hex(sha1), 40);
 	if (!branch || branch->type != OBJ_COMMIT)
diff --git a/builtin-log.c b/builtin-log.c
index d6845bc..54ddaad 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -89,7 +89,7 @@ static int estimate_commit_count(struct rev_info *rev, struct commit_list *list)
 		struct commit *commit = list->item;
 		unsigned int flags = commit->object.flags;
 		list = list->next;
-		if ((flags & TREECHANGE) && !(flags & UNINTERESTING))
+		if (!(flags & (TREESAME | UNINTERESTING)))
 			n++;
 	}
 	return n;
diff --git a/builtin-rev-list.c b/builtin-rev-list.c
index 2dec887..0258ec4 100644
--- a/builtin-rev-list.c
+++ b/builtin-rev-list.c
@@ -142,7 +142,7 @@ static int count_distance(struct commit_list *entry)
 
 		if (commit->object.flags & (UNINTERESTING | COUNTED))
 			break;
-		if (commit->object.flags & TREECHANGE)
+		if (!(commit->object.flags & TREESAME))
 			nr++;
 		commit->object.flags |= COUNTED;
 		p = commit->parents;
@@ -198,7 +198,7 @@ static inline int halfway(struct commit_list *p, int nr)
 	/*
 	 * Don't short-cut something we are not going to return!
 	 */
-	if (!(p->item->object.flags & TREECHANGE))
+	if (p->item->object.flags & TREESAME)
 		return 0;
 	if (DEBUG_BISECT)
 		return 0;
@@ -234,7 +234,7 @@ static void show_list(const char *debug, int counted, int nr,
 		char *ep, *sp;
 
 		fprintf(stderr, "%c%c%c ",
-			(flags & TREECHANGE) ? 'T' : ' ',
+			(flags & TREESAME) ? ' ' : 'T',
 			(flags & UNINTERESTING) ? 'U' : ' ',
 			(flags & COUNTED) ? 'C' : ' ');
 		if (commit->util)
@@ -268,7 +268,7 @@ static struct commit_list *best_bisection(struct commit_list *list, int nr)
 		int distance;
 		unsigned flags = p->item->object.flags;
 
-		if (!(flags & TREECHANGE))
+		if (flags & TREESAME)
 			continue;
 		distance = weight(p);
 		if (nr - distance < distance)
@@ -308,7 +308,7 @@ static struct commit_list *best_bisection_sorted(struct commit_list *list, int n
 		int distance;
 		unsigned flags = p->item->object.flags;
 
-		if (!(flags & TREECHANGE))
+		if (flags & TREESAME)
 			continue;
 		distance = weight(p);
 		if (nr - distance < distance)
@@ -362,7 +362,7 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
 		p->item->util = &weights[n++];
 		switch (count_interesting_parents(commit)) {
 		case 0:
-			if (flags & TREECHANGE) {
+			if (!(flags & TREESAME)) {
 				weight_set(p, 1);
 				counted++;
 				show_list("bisection 2 count one",
@@ -435,7 +435,7 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
 			 * add one for p itself if p is to be counted,
 			 * otherwise inherit it from q directly.
 			 */
-			if (flags & TREECHANGE) {
+			if (!(flags & TREESAME)) {
 				weight_set(p, weight(q)+1);
 				counted++;
 				show_list("bisection 2 count one",
@@ -482,7 +482,7 @@ static struct commit_list *find_bisection(struct commit_list *list,
 			continue;
 		p->next = last;
 		last = p;
-		if (flags & TREECHANGE)
+		if (!(flags & TREESAME))
 			nr++;
 		on_list++;
 	}
diff --git a/revision.c b/revision.c
index 931f978..5796153 100644
--- a/revision.c
+++ b/revision.c
@@ -311,17 +311,15 @@ static void try_to_simplify_commit(struct rev_info *revs, struct commit *commit)
 	/*
 	 * If we don't do pruning, everything is interesting
 	 */
-	if (!revs->prune) {
-		commit->object.flags |= TREECHANGE;
+	if (!revs->prune)
 		return;
-	}
 
 	if (!commit->tree)
 		return;
 
 	if (!commit->parents) {
-		if (!rev_same_tree_as_empty(revs, commit->tree))
-			commit->object.flags |= TREECHANGE;
+		if (rev_same_tree_as_empty(revs, commit->tree))
+			commit->object.flags |= TREESAME;
 		return;
 	}
 
@@ -329,10 +327,8 @@ static void try_to_simplify_commit(struct rev_info *revs, struct commit *commit)
 	 * Normal non-merge commit? If we don't want to make the
 	 * history dense, we consider it always to be a change..
 	 */
-	if (!revs->dense && !commit->parents->next) {
-		commit->object.flags |= TREECHANGE;
+	if (!revs->dense && !commit->parents->next)
 		return;
-	}
 
 	pp = &commit->parents;
 	while ((parent = *pp) != NULL) {
@@ -357,6 +353,7 @@ static void try_to_simplify_commit(struct rev_info *revs, struct commit *commit)
 			}
 			parent->next = NULL;
 			commit->parents = parent;
+			commit->object.flags |= TREESAME;
 			return;
 
 		case REV_TREE_NEW:
@@ -385,7 +382,8 @@ static void try_to_simplify_commit(struct rev_info *revs, struct commit *commit)
 		die("bad tree compare for commit %s", sha1_to_hex(commit->object.sha1));
 	}
 	if (tree_changed && !tree_same)
-		commit->object.flags |= TREECHANGE;
+		return;
+	commit->object.flags |= TREESAME;
 }
 
 static int add_parents_to_list(struct rev_info *revs, struct commit *commit, struct commit_list **list)
@@ -1354,7 +1352,9 @@ static enum rewrite_result rewrite_one(struct rev_info *revs, struct commit **pp
 				return rewrite_one_error;
 		if (p->parents && p->parents->next)
 			return rewrite_one_ok;
-		if (p->object.flags & (TREECHANGE | UNINTERESTING))
+		if (p->object.flags & UNINTERESTING)
+			return rewrite_one_ok;
+		if (!(p->object.flags & TREESAME))
 			return rewrite_one_ok;
 		if (!p->parents)
 			return rewrite_one_noparents;
@@ -1427,7 +1427,7 @@ enum commit_action simplify_commit(struct rev_info *revs, struct commit *commit)
 		return commit_ignore;
 	if (revs->prune && revs->dense) {
 		/* Commit without changes? */
-		if (!(commit->object.flags & TREECHANGE)) {
+		if (commit->object.flags & TREESAME) {
 			/* drop merges unless we want parenthood */
 			if (!revs->parents)
 				return commit_ignore;
diff --git a/revision.h b/revision.h
index a798514..992e1e9 100644
--- a/revision.h
+++ b/revision.h
@@ -3,7 +3,7 @@
 
 #define SEEN		(1u<<0)
 #define UNINTERESTING   (1u<<1)
-#define TREECHANGE	(1u<<2)
+#define TREESAME	(1u<<2)
 #define SHOWN		(1u<<3)
 #define TMP_MARK	(1u<<4) /* for isolated cases; clean after use */
 #define BOUNDARY	(1u<<5)
