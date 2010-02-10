From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] git log -p -m: Document, honor --first-parent
Date: Wed, 10 Feb 2010 02:11:49 +0100
Message-ID: <20100210011149.GR9553@machine.or.cz>
References: <46d6db661002091545j74f625ffr74ca70a0474948fc@mail.gmail.com>
 <20100209235707.GQ9553@machine.or.cz>
 <7v1vguuf8h.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian MICHON <christian.michon@gmail.com>,
	git list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 10 02:12:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nf17n-0005Kx-OJ
	for gcvg-git-2@lo.gmane.org; Wed, 10 Feb 2010 02:12:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754919Ab0BJBLz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Feb 2010 20:11:55 -0500
Received: from w241.dkm.cz ([62.24.88.241]:57602 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754913Ab0BJBLy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Feb 2010 20:11:54 -0500
Received: by machine.or.cz (Postfix, from userid 2001)
	id D560786209A; Wed, 10 Feb 2010 02:11:49 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7v1vguuf8h.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139466>

On Tue, Feb 09, 2010 at 04:05:50PM -0800, Junio C Hamano wrote:
> Petr Baudis <pasky@suse.cz> writes:
> 
> >   I'm not sure if there is any clever switch for this, but I usually
> > just use one of
> >
> > 	git diff mergecommit^1 mergecommit
> > 	git diff mergecommit^2 mergecommit
> >
> > depending on which parent I want the diff against. If you always do your
> > merges as "on mainline, merging in a topic" without fast-forwarding,
> > diff against the first parent will be probably the right one and you can
> > simply use:
> >
> > 	git diff mergecommit^ mergecommit
> 
> Frankly, we should make "git log --first-parent -p" DTRT, I think.
> 
> The attitude towards merges we maintain officially is "all parents are
> equal", but in practice, there often are cases where --first-parent
> traversal makes a lot more sense when browsing the history (especially
> "the official" one).  The use of that option should be a clear enough sign
> that diff between the first parent and the merge result is asked for.

I have also discovered -m while digging into this, which seems to have
the effect of showing the merge TWICE, each time against a different
parent; this is sort-of-almost what Christian also wanted.

This seems to be undocumented and does have this effect only in log,
not in show - I have absolutely no idea why from cursory code
examination.

I think making just --first-parent alone imply this behavior is wrong,
IMHO first-parent alone does not warrant avoiding combined-diff behavior.
I'm not really sure though, so feel free to add another

	if (revs->diff && revs->follow_first_parent)
		revs->ignore_merges = 0;

test at the right place (whatever that is).  At any rate, -m explicitly
states the intent and the current behavior of not honoring
--first-parent is IMHO a bug.

I think --first-parent documentation is still accurate with the new
behavior, so I adjusted just -m documentation - also making the flag
actually visible for non-diff-tree-stdin cases. Sorry that it's both
conflated in a single patch, I'd rather avoid creating a patch queue
out of this supposedly-5-minute hack.

--8<--

git log -p -m has a special magic behavior of showin one merge entry per
parent, with an appropriate diff; this can be frequently useful when
examining histories where full set of changes introduced by a merged
branch is interesting, not only the conflicts.

This patch properly documents the -m switch, which has so far been
mentioned only as a fairly special diff-tree flag. It also makes the
code show full patch entry only for the first parent in case
--first-parent is used. Thus,

	git log -p -m --first-parent

will show the history from the "main branch perspective", while also
including full diff of changes introduced by other merged in branches.

Signed-off-by: Petr Baudis <pasky@suse.cz>

---

diff --git a/Documentation/diff-generate-patch.txt b/Documentation/diff-generate-patch.txt
index 0f25ba7..8f9a241 100644
--- a/Documentation/diff-generate-patch.txt
+++ b/Documentation/diff-generate-patch.txt
@@ -56,7 +56,8 @@ combined diff format
 
 "git-diff-tree", "git-diff-files" and "git-diff" can take '-c' or
 '--cc' option to produce 'combined diff'.  For showing a merge commit
-with "git log -p", this is the default format.
+with "git log -p", this is the default format; you can force showing
+full diff with the '-m' option.
 A 'combined diff' format looks like this:
 
 ------------
diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index 0e39bb6..a2a2d04 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -118,6 +118,15 @@ git log master --not --remotes=*/master::
 	Shows all commits that are in local master but not in any remote
 	repository master branches.
 
+git log -p -m --first-parent::
+
+	Shows the history including change diffs, but only from the
+	"main branch" perspective, skipping commits that come only from
+	merges, and showing full diffs of changes introduced by the merges.
+	This makes sense only when following a strict policy of merging all
+	topic branches when staying on a single integration branch and
+	making sure the merges are not fast-forwards.
+
 Discussion
 ----------
 
diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 6e9baf8..d7d0dee 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -108,8 +108,8 @@ options may be given. See linkgit:git-diff-files[1] for more options.
 
 -c::
 
-	This flag changes the way a merge commit is displayed.  It shows
-	the differences from each of the parents to the merge result
+	This flag forces the default way a merge commit is displayed.  It
+	shows the differences from each of the parents to the merge result
 	simultaneously instead of showing pairwise diff between a parent
 	and the result one at a time. Furthermore, it lists only files
 	which were modified from all parents.
@@ -121,6 +121,15 @@ options may be given. See linkgit:git-diff-files[1] for more options.
 	the parents have only two variants and the merge result picks
 	one of them without modification.
 
+-m::
+
+	This flag makes the merge commits show the full diff like
+	regular commits; for each merge parent, a separate log entry
+	and diff is generated. (An exception is made if '--first-parent'
+	option has been also passed; in that case, only diff against
+	the first parent is shown, representing the changes the merge
+	brought _into_ the then-current branch.)
+
 -r::
 
 	Show recursive diffs.
diff --git a/log-tree.c b/log-tree.c
index 27afcf6..fb990a1 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -514,6 +514,14 @@ static int log_tree_diff(struct rev_info *opt, struct commit *commit, struct log
 			return 0;
 		else if (opt->combine_merges)
 			return do_diff_combined(opt, commit);
+		else if (opt->first_parent_only) {
+			/* Generate merge log entry only for the first
+			 * parent, showing summary diff of the others
+			 * we merged _in_. */
+			diff_tree_sha1(parents->item->object.sha1, sha1, "", &opt->diffopt);
+			log_tree_diff_flush(opt);
+			return !opt->loginfo;
+		}
 
 		/* If we show individual diffs, show the parent info */
 		log->parent = parents->item;
