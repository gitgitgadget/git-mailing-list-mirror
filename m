From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 1/3] revision.c: tighten up TREESAME handling of merges
Date: Sat, 27 Apr 2013 15:36:46 -0700
Message-ID: <7vppxfsirl.fsf@alter.siamese.dyndns.org>
References: <517AD304.6020807@bracey.fi>
	<1367004718-30048-1-git-send-email-kevin@bracey.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
To: Kevin Bracey <kevin@bracey.fi>
X-From: git-owner@vger.kernel.org Sun Apr 28 00:36:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWDjj-0006EM-92
	for gcvg-git-2@plane.gmane.org; Sun, 28 Apr 2013 00:36:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754120Ab3D0Wgu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Apr 2013 18:36:50 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63129 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753646Ab3D0Wgt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Apr 2013 18:36:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B26991AF0C;
	Sat, 27 Apr 2013 22:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gwCTvlE9ekQ2y0o1pdoQdxl/yW0=; b=WlVAGb
	110a3vUij4oJi3hkZnLrS7/kJte4YG1ihd/CPp7DrG+KVp7ixWNKAehjkDotOJV3
	c5rhiGAEJ9ofAzwdccEV9crr6dIn0GBahWSJnR6pD7RfkYwISS7m/XzKaZyevUvs
	FIfFc9I53/62sozyaQQiQdjTfKDlM6sPdElNQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bai5pVYWNc+8ofru4VS/85HZI5YuRh+n
	9qic57Ma4r3qvAsQUk9yM9+DWzSPEuS3zCD5c9KEiepYKSzsC3H9ScxukAC/oBWU
	/gGYfQbmBzGzmEAdZ70VlCSs0c7EljoFaInKArKB4M8QzRSMmiw1U8olQoxaRfPu
	ONUh7cY671k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A82051AF0B;
	Sat, 27 Apr 2013 22:36:48 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8091D1AF0A;
	Sat, 27 Apr 2013 22:36:47 +0000 (UTC)
In-Reply-To: <1367004718-30048-1-git-send-email-kevin@bracey.fi> (Kevin
	Bracey's message of "Fri, 26 Apr 2013 22:31:56 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F2062028-AF8A-11E2-B270-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222711>

Kevin Bracey <kevin@bracey.fi> writes:

> Historically TREESAME was set on a commit if it was TREESAME to _any_ of
> its parents. This is not optimal, as such a merge could still be worth
> showing, particularly if it is an odd "-s ours" merge that (possibly
> accidentally) dropped a change.

"... and with options like --full-history or --simplify-merges are
used to get more complete history", I think.  "git log path" without
these options is a tool to get one version of simplified history
that explains the end result, and by definition, the side branch
merged by "-s ours" did _not_ contribute anything to the end result.

> And the problem is further compounded by
> the fact that simplify_merges could drop the actual parent that a commit
> was TREESAME to, leaving it as a normal commit marked TREESAME that
> isn't actually TREESAME to its remaining parent.
>
> This commit redefines TREESAME to be true only if a commit is TREESAME to
> _all_ of its parents. This doesn't affect either the default
> simplify_history behaviour (because partially TREESAME merges are turned
> into normal commits), or full-history with parent rewriting (because all
> merges are output). But it does affect other modes.

Yes.

> It also modifies simplify_merges to recalculate TREESAME after removing
> a parent. This is achieved by storing per-parent TREESAME flags on the
> initial scan, so the combined flag can be easily recomputed.

This is a very deep core part of the system, so let me summon/cc
Linus for an extra set of eyes.

> Signed-off-by: Kevin Bracey <kevin@bracey.fi>
> ---
>  Documentation/rev-list-options.txt |   2 +-
>  revision.c                         | 220 ++++++++++++++++++++++++++++++++-----
>  revision.h                         |   1 +
>  3 files changed, 192 insertions(+), 31 deletions(-)
>
> diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
> index 3bdbf5e..380db48 100644
> --- a/Documentation/rev-list-options.txt
> +++ b/Documentation/rev-list-options.txt
> @@ -413,7 +413,7 @@ parent lines.
>  	I  A  B  N  D  O
>  -----------------------------------------------------------------------
>  +
> -`P` and `M` were excluded because they are TREESAME to a parent.  `E`,
> +`P` and `M` were excluded because they are TREESAME to both parents.  `E`,
>  `C` and `B` were all walked, but only `B` was !TREESAME, so the others
>  do not appear.
>  +
> diff --git a/revision.c b/revision.c
> index a67b615..176eb7b 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -429,10 +429,85 @@ static int rev_same_tree_as_empty(struct rev_info *revs, struct commit *commit)
>  	return retval >= 0 && (tree_difference == REV_TREE_SAME);
>  }
>  
> +struct treesame_state {
> +	unsigned int nparents;
> +	unsigned char treesame[FLEX_ARRAY];
> +};
> +
> +static struct treesame_state *initialise_treesame(struct rev_info *revs, struct commit *commit)
> +{
> +	unsigned n = commit_list_count(commit->parents);
> +	struct treesame_state *st = xcalloc(1, sizeof(*st) + n);
> +	st->nparents = n;
> +	add_decoration(&revs->treesame, &commit->object, st);
> +	return st;
> +}
> +
> +static int compact_treesame(struct rev_info *revs, struct commit *commit, unsigned parent)
> +{
> +	struct treesame_state *st = lookup_decoration(&revs->treesame, &commit->object);
> +	int old_same;
> +
> +	if (!st || parent >= st->nparents)
> +		die("compact_treesame %u", parent);
> +
> +	/* Can be useful to indicate sameness of removed parent */
> +	old_same = st->treesame[parent];

(mental note) "Can" may refer to the fact that this value is not yet
used in this series; my gut feeling is that returning old value is a
good API design even if there is no current user.

> +	memmove(st->treesame + parent,
> +		st->treesame + parent + 1,
> +		st->nparents - parent - 1);
> +
> +	/* If we've just become a non-merge commit, update TREESAME

(style) "/*" occupies its own line.

> +	 * immediately, in case we trigger an early-exit optimisation.
> +	 * (Note that there may be a mismatch between commit->parents and the
> +	 * treesame_state at this stage, as we may be in mid-rewrite).
> +	 * If still a merge, defer update until update_treesame().
> +	 */
> +	switch (--st->nparents) {
> +	case 0:
> +		if (rev_same_tree_as_empty(revs, commit))
> +			commit->object.flags |= TREESAME;
> +		else
> +			commit->object.flags &= ~TREESAME;
> +		break;
> +	case 1:
> +		if (st->treesame[0] && revs->dense)
> +			commit->object.flags |= TREESAME;
> +		else
> +			commit->object.flags &= ~TREESAME;
> +		break;
> +	}

Do we want to discard the decoration data when the commit becomes a
non-merge?

> +	return old_same;
> +}

(mental note) compact_treesame() is not to "compact" after
everything is done, but as we remove one parent we call it to remove
the treesame[] record for that parent.  A commit can only lose parents
and never gain a new one, so we will never have to reallocate flex
array part.

> +static unsigned update_treesame(struct rev_info *revs, struct commit *commit)
> +{
> +	/* If 0 or 1 parents, TREESAME should be valid already */
> +	if (commit->parents && commit->parents->next) {
> +		int n = 0;

"compact" counted parents from 0 upwards with "unsigned", here it is
"int". It wouldn't make practical difference (nobody will create a
merge of 2 billion side branches), but we may want to be consistent.

> +		struct treesame_state *st;
> +
> +		st = lookup_decoration(&revs->treesame, &commit->object);
> +		if (!st) die("update_treesame");

(style) put this on two lines.

> +		commit->object.flags |= TREESAME;
> +		for (n = 0; n < st->nparents; n++) {
> +			if (!st->treesame[n]) {
> +				commit->object.flags &= ~TREESAME;
> +				break;
> +			}
> +		}

Can a commit that earlier was marked as TREESAME become not TREESAME?
Wouldn't simplification only increase sameness, never decrease?

> +	}
> +
> +	return commit->object.flags & TREESAME;
> +}
> +
>  static void try_to_simplify_commit(struct rev_info *revs, struct commit *commit)
>  {
>  	struct commit_list **pp, *parent;
> -	int tree_changed = 0, tree_same = 0, nth_parent = 0;
> +	struct treesame_state *ts = NULL;
> +	int tree_changed = 0, nth_parent = 0;
>  
>  	/*
>  	 * If we don't do pruning, everything is interesting
> @@ -456,25 +531,38 @@ static void try_to_simplify_commit(struct rev_info *revs, struct commit *commit)
>  	if (!revs->dense && !commit->parents->next)
>  		return;
>  
> -	pp = &commit->parents;
> -	while ((parent = *pp) != NULL) {
> +	for (pp = &commit->parents;
> +	     (parent = *pp) != NULL;
> +	     pp = &parent->next, nth_parent++) {

I see the reason to change from while to for is because you wanted
to count, and I think it makes sense; but it is more readable to
initialise the counter here, too, if that is the case. I.e.

	for (pp = &commit->parents, nth_parent = 0;
	     !(parent = *pp);
	     pp = &parent->next, nth_parent++) {

>  		struct commit *p = parent->item;
>  
> +		if (nth_parent == 1) {
> +			/*
> +			 * Do not compare with later parents when we care only about
> +			 * the first parent chain, in order to avoid derailing the
> +			 * traversal to follow a side branch that brought everything
> +			 * in the path we are limited to by the pathspec.
> +			 */
> +			if (revs->first_parent_only)
> +				break;
> +			/*
> +			 * If this is going to remain a merge, and it's
> +			 * interesting, remember per-parent treesame for
> +			 * simplify_merges().
> +			 */
> +			if (revs->simplify_merges && !(p->object.flags & UNINTERESTING)) {
> +				ts = initialise_treesame(revs, commit);
> +				if (!tree_changed)
> +					ts->treesame[0] = 1;

Have we made any two tree comparison at this point to set this one?
Ahh, this is tricky.  You do this in the _second_ iteration of the
loop, so tree_changed here is from inspecting the first parent, not
the one we are looking at (i.e. *p).

> +

(style) unnecessary new blank line?

> +			}
> +		}
>  		if (parse_commit(p) < 0)
>  			die("cannot simplify commit %s (because of %s)",
>  			    sha1_to_hex(commit->object.sha1),
>  			    sha1_to_hex(p->object.sha1));
>  		switch (rev_compare_tree(revs, p, commit)) {
>  		case REV_TREE_SAME:
> -			tree_same = 1;
>  			if (!revs->simplify_history || (p->object.flags & UNINTERESTING)) {
>  				/* Even if a merge with an uninteresting
>  				 * side branch brought the entire change
> @@ -482,7 +570,8 @@ static void try_to_simplify_commit(struct rev_info *revs, struct commit *commit)
>  				 * to lose the other branches of this
>  				 * merge, so we just keep going.
>  				 */
> -				pp = &parent->next;
> +				if (ts)
> +					ts->treesame[nth_parent] = 1;

Again, tricky but correct. ts->treesame[0] is filled during the
second iteration above, and the same iteration fills ts-tree>same[1]
here.

I am starting to like this code ;-).

>  				continue;
>  			}
>  			parent->next = NULL;
> @@ -511,12 +600,11 @@ static void try_to_simplify_commit(struct rev_info *revs, struct commit *commit)
>  		case REV_TREE_OLD:
>  		case REV_TREE_DIFFERENT:
>  			tree_changed = 1;
> -			pp = &parent->next;
>  			continue;
>  		}
>  		die("bad tree compare for commit %s", sha1_to_hex(commit->object.sha1));
>  	}
> -	if (tree_changed && !tree_same)
> +	if (tree_changed)
>  		return;
>  	commit->object.flags |= TREESAME;
>  }
> @@ -773,6 +861,9 @@ static void limit_to_ancestry(struct commit_list *bottom, struct commit_list *li
>  	 * NEEDSWORK: decide if we want to remove parents that are
>  	 * not marked with TMP_MARK from commit->parents for commits
>  	 * in the resulting list.  We may not want to do that, though.
> +	 *
> +	 * Maybe it should be considered if we are TREESAME to such
> +	 * parents - now possible with stored per-parent flags.
>  	 */

Hmm, that is certainly a thought.

> @@ -1930,28 +2021,32 @@ static void add_child(struct rev_info *revs, struct commit *parent, struct commi
>  	l->next = add_decoration(&revs->children, &parent->object, l);
>  }
>  
> -static int remove_duplicate_parents(struct commit *commit)
> +static int remove_duplicate_parents(struct rev_info *revs, struct commit *commit)
>  {
> +	struct treesame_state *ts = lookup_decoration(&revs->treesame, &commit->object);
>  	struct commit_list **pp, *p;
>  	int surviving_parents;
>  
>  	/* Examine existing parents while marking ones we have seen... */
>  	pp = &commit->parents;
> +	surviving_parents = 0;
>  	while ((p = *pp) != NULL) {
>  		struct commit *parent = p->item;
>  		if (parent->object.flags & TMP_MARK) {
>  			*pp = p->next;
> +			if (ts)
> +				compact_treesame(revs, commit, surviving_parents);
>  			continue;
>  		}
>  		parent->object.flags |= TMP_MARK;
> +		surviving_parents++;
>  		pp = &p->next;
>  	}
> -	/* count them while clearing the temporary mark */
> -	surviving_parents = 0;
> +	/* clear the temporary mark */
>  	for (p = commit->parents; p; p = p->next) {
>  		p->item->object.flags &= ~TMP_MARK;
> -		surviving_parents++;
>  	}
> +	/* no update_treesame() - removing duplicates can't affect TREESAME */
>  	return surviving_parents;
>  }

OK.

> @@ -1971,6 +2066,70 @@ static struct merge_simplify_state *locate_simplify_state(struct rev_info *revs,
>  	return st;
>  }
>  
> +static int mark_redundant_parents(struct rev_info *revs, struct commit *commit)
> +{
> +	struct commit_list *h = reduce_heads(commit->parents);
> +	int i = 0, marked = 0;
> +	struct commit_list *po, *pn;
> +
> +	/* Want these for sanity only */
> +	int orig_cnt = commit_list_count(commit->parents);
> +	int cnt = commit_list_count(h);
> +
> +	/* Not ready to remove items yet, just mark them for now, based

(same style on "/*")

> +	 * on the output of reduce_heads(). reduce_heads outputs the reduced
> +	 * set in its original order, so this isn't too hard.
> +	 */
> +	po = commit->parents;
> +	pn = h;
> +	while (po) {
> +		if (pn && po->item == pn->item) {
> +			pn=pn->next;

(style) SPs before and after '='.

> +			i++;
> +		}
> +		else {
> +			po->item->object.flags |= TMP_MARK;
> +			marked++;
> +		}
> +		po=po->next;
> +	}
> +
> +	if (i != cnt || cnt+marked != orig_cnt)
> +		die("mark_redundant_parents %d %d %d %d", orig_cnt, cnt, i, marked);
> +
> +	free_commit_list(h);
> +
> +	return marked;
> +}
> +
> +static int remove_marked_parents(struct rev_info *revs, struct commit *commit)
> +{
> +	struct treesame_state *ts = lookup_decoration(&revs->treesame, &commit->object);
> +	struct commit_list **pp, *p;
> +	int n, removed = 0;
> +
> +	pp = &commit->parents;
> +	n = 0;
> +	while ((p = *pp) != NULL) {
> +		struct commit *parent = p->item;
> +		if (parent->object.flags & TMP_MARK) {
> +			parent->object.flags &= ~TMP_MARK;
> +			compact_treesame(revs, commit, n);
> +			*pp = p->next;
> +			free(p);
> +			removed++;
> +			continue;
> +		}
> +		pp = &p->next;
> +		n++;
> +	}
> +
> +	if (removed)
> +		update_treesame(revs, commit);
> +
> +	return removed;
> +}

OK, even though the use of TMP_MARK (meant to be very localized)
across two functions feel somewhat yucky, they are file scope
statics next to each other and hopefully are called back to back.

>  static struct commit_list **simplify_one(struct rev_info *revs, struct commit *commit, struct commit_list **tail)
>  {
>  	struct commit_list *p;
> @@ -2015,7 +2174,9 @@ static struct commit_list **simplify_one(struct rev_info *revs, struct commit *c
>  	}
>  
>  	/*
> -	 * Rewrite our list of parents.
> +	 * Rewrite our list of parents. Note that this cannot
> +	 * affect our TREESAME flags in anyway - a commit is
> +	 * always TREESAME to its simplification.
>  	 */
>  	for (p = commit->parents; p; p = p->next) {
>  		pst = locate_simplify_state(revs, p->item);
> @@ -2027,31 +2188,30 @@ static struct commit_list **simplify_one(struct rev_info *revs, struct commit *c
>  	if (revs->first_parent_only)
>  		cnt = 1;
>  	else
> -		cnt = remove_duplicate_parents(commit);
> +		cnt = remove_duplicate_parents(revs, commit);
>  
>  	/*
>  	 * It is possible that we are a merge and one side branch
>  	 * does not have any commit that touches the given paths;
> -	 * in such a case, the immediate parents will be rewritten
> -	 * to different commits.
> +	 * in such a case, the immediate parent from that branch
> +	 * will be rewritten to be the merge base.
>  	 *
>  	 *      o----X		X: the commit we are looking at;
>  	 *     /    /		o: a commit that touches the paths;
>  	 * ---o----'
>  	 *
> -	 * Further reduce the parents by removing redundant parents.
> +	 * Detect and simplify this case.
>  	 */
>  	if (1 < cnt) {
> -		struct commit_list *h = reduce_heads(commit->parents);
> -		cnt = commit_list_count(h);
> -		free_commit_list(commit->parents);
> -		commit->parents = h;
> +		int marked = mark_redundant_parents(revs, commit);
> +		if (marked)
> +			remove_marked_parents(revs, commit);
>  	}

OK.

>  	/*
>  	 * A commit simplifies to itself if it is a root, if it is
>  	 * UNINTERESTING, if it touches the given paths, or if it is a
> -	 * merge and its parents simplifies to more than one commits
> +	 * merge and its parents simplify to more than one commit
>  	 * (the first two cases are already handled at the beginning of
>  	 * this function).
>  	 *
> @@ -2218,7 +2378,7 @@ static int rewrite_parents(struct rev_info *revs, struct commit *commit)
>  		}
>  		pp = &parent->next;
>  	}
> -	remove_duplicate_parents(commit);
> +	remove_duplicate_parents(revs, commit);
>  	return 0;
>  }
>  
> diff --git a/revision.h b/revision.h
> index 01bd2b7..1abe57b 100644
> --- a/revision.h
> +++ b/revision.h
> @@ -167,6 +167,7 @@ struct rev_info {
>  	struct reflog_walk_info *reflog_info;
>  	struct decoration children;
>  	struct decoration merge_simplification;
> +	struct decoration treesame;
>  
>  	/* notes-specific options: which refs to show */
>  	struct display_notes_opt notes_opt;

Nicely done.
