From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 3/2] Enhance --early-output format
Date: Mon, 5 Nov 2007 13:22:34 -0800 (PST)
Message-ID: <alpine.LFD.0.999.0711051313350.15101@woody.linux-foundation.org>
References: <18211.59478.188419.397886@cargo.ozlabs.ibm.com>
 <18217.41899.54812.227152@cargo.ozlabs.ibm.com>
 <alpine.LFD.0.999.0711010815320.3342@woody.linux-foundation.org>
 <18218.63946.772767.179841@cargo.ozlabs.ibm.com>
 <e5bfff550711020544h1e9a648apfd268eb549645ccc@mail.gmail.com>
 <alpine.LFD.0.999.0711020828440.3342@woody.linux-foundation.org>
 <alpine.LFD.0.999.0711021114390.3342@woody.linux-foundation.org>
 <alpine.LFD.0.999.0711021301200.3342@woody.linux-foundation.org>
 <alpine.LFD.0.999.0711021809060.3342@woody.linux-foundation.org>
 <alpine.LFD.0.999.0711031103340.3342@woody.linux-foundation.org>
 <18221.14113.498416.396006@cargo.ozlabs.ibm.com>
 <alpine.LFD.0.999.0711032234030.15101@woody.linux-foundation.org>
 <alpine.LFD.0.999.0711041004220.15101@woody.linux-foundation.org>
 <alpine.LFD.0.999.0711041124050.15101@woody.linux-foundation.org>
 <7vsl3kphjp.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.0.999.0711051233270.15101@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Paul Mackerras <paulus@samba.org>,
	Marco Costalba <mcostalba@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 05 22:24:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ip9Qw-0002pa-76
	for gcvg-git-2@gmane.org; Mon, 05 Nov 2007 22:24:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754008AbXKEVXk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Nov 2007 16:23:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754952AbXKEVXj
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Nov 2007 16:23:39 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:53864 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754937AbXKEVXi (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Nov 2007 16:23:38 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lA5LMZZ9029769
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 5 Nov 2007 13:22:36 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lA5LMY3A020380;
	Mon, 5 Nov 2007 13:22:34 -0800
In-Reply-To: <alpine.LFD.0.999.0711051233270.15101@woody.linux-foundation.org>
X-Spam-Status: No, hits=-6.238 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_UNIFIED_DIFF_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63557>



On Mon, 5 Nov 2007, Linus Torvalds wrote:
> 
> That said, I've often found the "TREECHANGE" bit annoying. The fact that 
> we always have to test it together with testing "rev->prune_fn" and often 
> also the "rev->dense" flag is just annoying. I'd almost like to just 
> always set the bit if "rev->prune_fn" isn't set. Alternatively, the code 
> could be rewritten to just have a few inline helper functions, and it 
> could perhaps be written as
> 
> 	if (!(flags & TREECHANGE) && revs->dense && single_parent(commit))
> 		continue;
> 
> I dunno.

Here's a possible cleanup patch. It's on top of the enhanced 
--early-output format commit, and in fact fixes a stupid bug in that 
commit ("return -1" vs "return NULL"), but that bug-fix is really an 
independent thing.

It basically removes the unnecessary indirection of "revs->prune_fn", 
since that function is always the same one (or NULL), and there is in fact 
not even an abstraction reason to make it a function (ie its not called 
from some other file and doesn't allow us to keep the function itself 
static or anything like that).

It then just replaces it with a bit that says "prune or not", and if not 
pruning, every commit gets TREECHANGE.

That in turn means that

 - if (!revs->prune_fn || (flags & TREECHANGE))
 - if (revs->prune_fn && !(flags & TREECHANGE))

just become

 - if (flags & TREECHANGE)
 - if (!(flags & TREECHANGE))

respectively.

Together with adding the "single_parent()" helper function, the "complex" 
conditional now becomes

	if (!(flags & TREECHANGE) && rev->dense && single_parent(commit))
		continue;

Anyway, do with this as you will. I think it's ok, but apart from passing 
the test-suite and looking obvious, this has gotten zero testing.

		Linus

---
 builtin-log.c      |    6 ++----
 builtin-rev-list.c |   14 +++++++-------
 commit.h           |    5 +++++
 revision.c         |   20 ++++++++++++--------
 revision.h         |    5 +----
 5 files changed, 27 insertions(+), 23 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index 981f388..76c84e2 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -92,10 +92,8 @@ static int estimate_commit_count(struct rev_info *rev, struct commit_list *list)
 		list = list->next;
 		if (flags & UNINTERESTING)
 			continue;
-		if (rev->prune_fn && rev->dense && !(flags & TREECHANGE)) {
-			if (commit->parents && !commit->parents->next)
-				continue;
-		}
+		if (!(flags & TREECHANGE) && rev->dense && single_parent(commit))
+			continue;
 		n++;
 	}
 	return n;
diff --git a/builtin-rev-list.c b/builtin-rev-list.c
index 6970467..2dec887 100644
--- a/builtin-rev-list.c
+++ b/builtin-rev-list.c
@@ -142,7 +142,7 @@ static int count_distance(struct commit_list *entry)
 
 		if (commit->object.flags & (UNINTERESTING | COUNTED))
 			break;
-		if (!revs.prune_fn || (commit->object.flags & TREECHANGE))
+		if (commit->object.flags & TREECHANGE)
 			nr++;
 		commit->object.flags |= COUNTED;
 		p = commit->parents;
@@ -198,7 +198,7 @@ static inline int halfway(struct commit_list *p, int nr)
 	/*
 	 * Don't short-cut something we are not going to return!
 	 */
-	if (revs.prune_fn && !(p->item->object.flags & TREECHANGE))
+	if (!(p->item->object.flags & TREECHANGE))
 		return 0;
 	if (DEBUG_BISECT)
 		return 0;
@@ -268,7 +268,7 @@ static struct commit_list *best_bisection(struct commit_list *list, int nr)
 		int distance;
 		unsigned flags = p->item->object.flags;
 
-		if (revs.prune_fn && !(flags & TREECHANGE))
+		if (!(flags & TREECHANGE))
 			continue;
 		distance = weight(p);
 		if (nr - distance < distance)
@@ -308,7 +308,7 @@ static struct commit_list *best_bisection_sorted(struct commit_list *list, int n
 		int distance;
 		unsigned flags = p->item->object.flags;
 
-		if (revs.prune_fn && !(flags & TREECHANGE))
+		if (!(flags & TREECHANGE))
 			continue;
 		distance = weight(p);
 		if (nr - distance < distance)
@@ -362,7 +362,7 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
 		p->item->util = &weights[n++];
 		switch (count_interesting_parents(commit)) {
 		case 0:
-			if (!revs.prune_fn || (flags & TREECHANGE)) {
+			if (flags & TREECHANGE) {
 				weight_set(p, 1);
 				counted++;
 				show_list("bisection 2 count one",
@@ -435,7 +435,7 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
 			 * add one for p itself if p is to be counted,
 			 * otherwise inherit it from q directly.
 			 */
-			if (!revs.prune_fn || (flags & TREECHANGE)) {
+			if (flags & TREECHANGE) {
 				weight_set(p, weight(q)+1);
 				counted++;
 				show_list("bisection 2 count one",
@@ -482,7 +482,7 @@ static struct commit_list *find_bisection(struct commit_list *list,
 			continue;
 		p->next = last;
 		last = p;
-		if (!revs.prune_fn || (flags & TREECHANGE))
+		if (flags & TREECHANGE)
 			nr++;
 		on_list++;
 	}
diff --git a/commit.h b/commit.h
index 4ed0c1c..aa67986 100644
--- a/commit.h
+++ b/commit.h
@@ -117,4 +117,9 @@ extern int interactive_add(void);
 extern void add_files_to_cache(int verbose, const char *prefix, const char **files);
 extern int rerere(void);
 
+static inline int single_parent(struct commit *commit)
+{
+	return commit->parents && !commit->parents->next;
+}
+
 #endif /* COMMIT_H */
diff --git a/revision.c b/revision.c
index 5d6f208..7a1ecba 100644
--- a/revision.c
+++ b/revision.c
@@ -308,6 +308,14 @@ static void try_to_simplify_commit(struct rev_info *revs, struct commit *commit)
 	struct commit_list **pp, *parent;
 	int tree_changed = 0, tree_same = 0;
 
+	/*
+	 * If we don't do pruning, everything is interesting
+	 */
+	if (!revs->prune) {
+		commit->object.flags |= TREECHANGE;
+		return;
+	}
+
 	if (!commit->tree)
 		return;
 
@@ -415,8 +423,7 @@ static int add_parents_to_list(struct rev_info *revs, struct commit *commit, str
 	 * simplify the commit history and find the parent
 	 * that has no differences in the path set if one exists.
 	 */
-	if (revs->prune_fn)
-		revs->prune_fn(revs, commit);
+	try_to_simplify_commit(revs, commit);
 
 	if (revs->no_walk)
 		return 0;
@@ -684,9 +691,6 @@ void init_revisions(struct rev_info *revs, const char *prefix)
 	revs->skip_count = -1;
 	revs->max_count = -1;
 
-	revs->prune_fn = NULL;
-	revs->prune_data = NULL;
-
 	revs->commit_format = CMIT_FMT_DEFAULT;
 
 	diff_setup(&revs->diffopt);
@@ -1271,7 +1275,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
 		diff_tree_setup_paths(revs->prune_data, &revs->pruning);
 		/* Can't prune commits with rename following: the paths change.. */
 		if (!revs->diffopt.follow_renames)
-			revs->prune_fn = try_to_simplify_commit;
+			revs->prune = 1;
 		if (!revs->full_diff)
 			diff_tree_setup_paths(revs->prune_data, &revs->diffopt);
 	}
@@ -1412,7 +1416,7 @@ enum commit_action simplify_commit(struct rev_info *revs, struct commit *commit)
 		return commit_ignore;
 	if (!commit_match(commit, revs))
 		return commit_ignore;
-	if (revs->prune_fn && revs->dense) {
+	if (revs->prune && revs->dense) {
 		/* Commit without changes? */
 		if (!(commit->object.flags & TREECHANGE)) {
 			/* drop merges unless we want parenthood */
@@ -1460,7 +1464,7 @@ static struct commit *get_revision_1(struct rev_info *revs)
 		case commit_ignore:
 			continue;
 		case commit_error:
-			return -1;
+			return NULL;
 		default:
 			return commit;
 		}
diff --git a/revision.h b/revision.h
index 2232247..a798514 100644
--- a/revision.h
+++ b/revision.h
@@ -15,8 +15,6 @@
 struct rev_info;
 struct log_info;
 
-typedef void (prune_fn_t)(struct rev_info *revs, struct commit *commit);
-
 struct rev_info {
 	/* Starting list */
 	struct commit_list *commits;
@@ -28,12 +26,11 @@ struct rev_info {
 	/* Basic information */
 	const char *prefix;
 	void *prune_data;
-	prune_fn_t *prune_fn;
-
 	unsigned int early_output;
 
 	/* Traversal flags */
 	unsigned int	dense:1,
+			prune:1,
 			no_merges:1,
 			no_walk:1,
 			remove_empty_trees:1,
