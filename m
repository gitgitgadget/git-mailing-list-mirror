From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Am able to delete a file with no trace in the log
Date: Wed, 03 Jun 2009 14:55:10 -0700
Message-ID: <7vhbyx6kzl.fsf@alter.siamese.dyndns.org>
References: <EB2D87B9-3B03-431A-B204-C7799F9BA291@ausperks.net>
	<20090602213439.GA7584@coredump.intra.peff.net>
	<alpine.LFD.2.01.0906021439030.4880@localhost.localdomain>
	<7vfxeidqoz.fsf@alter.siamese.dyndns.org>
	<alpine.LFD.2.01.0906022000040.4880@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: eff King <peff@peff.net>, Graham Perks <gperks@ausperks.net>,
	Git List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Jun 03 23:55:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MByQc-0006en-62
	for gcvg-git-2@gmane.org; Wed, 03 Jun 2009 23:55:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754175AbZFCVzM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2009 17:55:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753669AbZFCVzL
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jun 2009 17:55:11 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:42807 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752712AbZFCVzJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2009 17:55:09 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090603215512.RMRC18948.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Wed, 3 Jun 2009 17:55:12 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo01.cox.net with bizsmtp
	id zZvA1b00B4aMwMQ03ZvAJ9; Wed, 03 Jun 2009 17:55:11 -0400
X-VR-Score: -400.00
X-Authority-Analysis: v=1.0 c=1 a=vab_pU7WfN8A:10 a=vn0Xwkm_Dc8A:10
 a=Z4Rwk6OoAAAA:8 a=QEQQbw5F0ipw4YWThgoA:9 a=T_8Yk3hJSAPOSfs-j_YA:7
 a=YirIiFbRn5VnjQoNlIfUsM0BDcYA:4 a=jbrJJM5MRmoA:10
X-CM-Score: 0.00
In-Reply-To: <alpine.LFD.2.01.0906022000040.4880@localhost.localdomain> (Linus Torvalds's message of "Tue\, 2 Jun 2009 20\:03\:31 -0700 \(PDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120649>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Tue, 2 Jun 2009, Junio C Hamano wrote:
>> 
>> Sorry, but I do not quite understand this comment.  REV_TREE_NEW can be
>> treated differently from REV_TREE_DIFFERENT but that only happens if you
>> know about --remove-empty option, and no scripted (and later converted to
>> C) Porcelain uses that option by default.
>
> It's not REV_TREE_NEW, but the other way around, ie when the commit has no 
> contents but the parent _does_ have contents, maybe we shouldn't then look 
> at another parent and say "no content", and then match that other parent 
> (resulting in no difference).
>
> IOW, we are in the situation where one parent gets REV_TREE_SAME, but gets 
> it for a totally pointless reason, namely that neither that parent nor the 
> eventual merge has anything at all in that path. In that case, we simplify 
> towards the parent that results in the smallest diff - which in this case 
> is "nothing there at all".

Here is a crude attempt to do this.  It introduces an diff optflag that
records if we checked any changes at the path level (if left unset, that
means everything was pruned away by pathspec) and teaches the internal
diff-tree logic to set it, so that the caller can tell between "no
changes" and "there was no interesting path that matches the pathspec, so
comparison between parent and child yielded nothing".

	Side note. I didn't bother touching the diff-files and diff-index
	codepaths in this patch; if the distinction turns out to be useful
	we should teach the flag to them as well (but I'll say it is
	probably not very useful shortly).

After looking at its output, I have to say that I do not like it very
much.  Compared to "--simplify-merges", it shows too many uninteresting
merges.  E.g.

    $ git log --oneline -- git-clone.sh

starts like this.

    17d778e Merge branch 'dr/ceiling'
    159e639 Merge branch 'lt/racy-empty'
    bc9c3e0 Merge branch 'jc/maint-combine-diff-pre-context'
    ...

All of them are resolving a merge with a revision that has a scripted "git
clone" (i.e. "maint" track before built-in git-clone) into a newer
revision after "git clone" has become built-in.

After a score or so of such uninteresting merges, we finally see
what matters.

    b84c343 Merge branch 'db/clone-in-c'
    6d9878c clone: bsd shell portability fix
    c904bf3 Be more careful with objects directory permissions on clone
    8434c2f Build in clone
    e42251a Use "=" instead of "==" in condition as it is more portable
    ...

This part is actually somewhat interesting.

    $ git log --oneline --graph b84c343 -- git-clone.sh

looks like this:

    *   b84c343 Merge branch 'db/clone-in-c'
    |\
    | * 8434c2f Build in clone
    * | 6d9878c clone: bsd shell portability fix
    * | c904bf3 Be more careful with objects dir...
    |/
    * e42251a Use "=" instead of "==" in conditi...
    * a2b26ac clone: detect and fail on excess p...
    * c20711d Silence cpio's "N blocks" output w...
    ...

But then that was what "--simplify-merges" gave us without the patch
anyway.



 diff.h      |    1 +
 revision.c  |   32 ++++++++++++++++++++++++++++++--
 revision.h  |    1 +
 tree-diff.c |    1 +
 4 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/diff.h b/diff.h
index 6616877..fcf1d52 100644
--- a/diff.h
+++ b/diff.h
@@ -66,6 +66,7 @@ typedef void (*diff_format_fn_t)(struct diff_queue_struct *q,
 #define DIFF_OPT_DIRSTAT_CUMULATIVE  (1 << 19)
 #define DIFF_OPT_DIRSTAT_BY_FILE     (1 << 20)
 #define DIFF_OPT_ALLOW_TEXTCONV      (1 << 21)
+#define DIFF_OPT_CHECKED_CHANGES     (1 << 22)
 #define DIFF_OPT_TST(opts, flag)    ((opts)->flags & DIFF_OPT_##flag)
 #define DIFF_OPT_SET(opts, flag)    ((opts)->flags |= DIFF_OPT_##flag)
 #define DIFF_OPT_CLR(opts, flag)    ((opts)->flags &= ~DIFF_OPT_##flag)
diff --git a/revision.c b/revision.c
index bf58448..7440f59 100644
--- a/revision.c
+++ b/revision.c
@@ -273,7 +273,7 @@ static void file_add_remove(struct diff_options *options,
 	int diff = addremove == '+' ? REV_TREE_NEW : REV_TREE_OLD;
 
 	tree_difference |= diff;
-	if (tree_difference == REV_TREE_DIFFERENT)
+	if ((tree_difference & REV_TREE_DIFFERENT) == REV_TREE_DIFFERENT)
 		DIFF_OPT_SET(options, HAS_CHANGES);
 }
 
@@ -317,9 +317,13 @@ static int rev_compare_tree(struct rev_info *revs, struct commit *parent, struct
 
 	tree_difference = REV_TREE_SAME;
 	DIFF_OPT_CLR(&revs->pruning, HAS_CHANGES);
+	DIFF_OPT_CLR(&revs->pruning, CHECKED_CHANGES);
 	if (diff_tree_sha1(t1->object.sha1, t2->object.sha1, "",
 			   &revs->pruning) < 0)
 		return REV_TREE_DIFFERENT;
+	if (tree_difference == REV_TREE_SAME &&
+	    !DIFF_OPT_TST(&revs->pruning, CHECKED_CHANGES))
+		tree_difference = REV_TREE_EMPTY;
 	return tree_difference;
 }
 
@@ -351,7 +355,7 @@ static int rev_same_tree_as_empty(struct rev_info *revs, struct commit *commit)
 static void try_to_simplify_commit(struct rev_info *revs, struct commit *commit)
 {
 	struct commit_list **pp, *parent;
-	int tree_changed = 0, tree_same = 0;
+	int tree_changed = 0, tree_same = 0, all_empty = 1;
 
 	/*
 	 * If we don't do pruning, everything is interesting
@@ -384,7 +388,17 @@ static void try_to_simplify_commit(struct rev_info *revs, struct commit *commit)
 			    sha1_to_hex(commit->object.sha1),
 			    sha1_to_hex(p->object.sha1));
 		switch (rev_compare_tree(revs, p, commit)) {
+		case REV_TREE_EMPTY:
+			/*
+			 * This parent is the same as the child but that is
+			 * only because no path we are interested in appears
+			 * in either of them.  Do not cull other parents (yet).
+			 */
+			pp = &parent->next;
+			continue;
+
 		case REV_TREE_SAME:
+			all_empty = 0;
 			tree_same = 1;
 			if (!revs->simplify_history || (p->object.flags & UNINTERESTING)) {
 				/* Even if a merge with an uninteresting
@@ -421,12 +435,26 @@ static void try_to_simplify_commit(struct rev_info *revs, struct commit *commit)
 		/* fallthrough */
 		case REV_TREE_OLD:
 		case REV_TREE_DIFFERENT:
+			all_empty = 0;
 			tree_changed = 1;
 			pp = &parent->next;
 			continue;
+
 		}
 		die("bad tree compare for commit %s", sha1_to_hex(commit->object.sha1));
 	}
+
+	if (all_empty && revs->simplify_history) {
+		/*
+		 * No path we are interested in appears in any of the
+		 * parents nor in this commit.  Just simplify the merge away.
+		 */
+		parent = commit->parents;
+		parent->next = NULL;
+		commit->object.flags |= TREESAME;
+		return;
+	}
+
 	if (tree_changed && !tree_same)
 		return;
 	commit->object.flags |= TREESAME;
diff --git a/revision.h b/revision.h
index 227164c..7064d35 100644
--- a/revision.h
+++ b/revision.h
@@ -121,6 +121,7 @@ struct rev_info {
 #define REV_TREE_NEW		1	/* Only new files */
 #define REV_TREE_OLD		2	/* Only files removed */
 #define REV_TREE_DIFFERENT	3	/* Mixed changes */
+#define REV_TREE_EMPTY		4	/* Same but only because both are empty */
 
 /* revision.c */
 void read_revisions_from_stdin(struct rev_info *revs);
diff --git a/tree-diff.c b/tree-diff.c
index edd8394..692d1cb 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -298,6 +298,7 @@ int diff_tree(struct tree_desc *t1, struct tree_desc *t2, const char *base, stru
 			update_tree_entry(t1);
 			continue;
 		}
+		DIFF_OPT_SET(opt, CHECKED_CHANGES);
 		switch (compare_tree_entry(t1, t2, base, baselen, opt)) {
 		case -1:
 			update_tree_entry(t1);
