From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] Make --full-history consider more merges
Date: Wed, 24 Apr 2013 15:34:46 -0700
Message-ID: <7va9ona77d.fsf@alter.siamese.dyndns.org>
References: <7v4nfcj2kq.fsf@alter.siamese.dyndns.org>
	<1366658602-12254-1-git-send-email-kevin@bracey.fi>
	<7vzjwqny64.fsf@alter.siamese.dyndns.org> <5176B854.2000707@bracey.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Kevin Bracey <kevin@bracey.fi>
X-From: git-owner@vger.kernel.org Thu Apr 25 00:35:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UV8HD-0001MR-PK
	for gcvg-git-2@plane.gmane.org; Thu, 25 Apr 2013 00:35:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758403Ab3DXWez (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Apr 2013 18:34:55 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33344 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756215Ab3DXWey (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Apr 2013 18:34:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ADBE21949D;
	Wed, 24 Apr 2013 22:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jH7XhIjotoZuYdtm1LLi1o0mUqg=; b=vejkim
	Mr8x2gmsx4aBaRvOsWM9cpsMWy0UV4TrLCZpe5aSYd8R7PA4II4zWV4CVC1cTqef
	pVMna2ySq+A+Cs0LH8VAj1S74FjgLOYisUgShSqOWLCzpYQBjO5ghK+wEcwpgPhE
	AaAlaY+gDLryXF4PQRR2fZAE/aJJUDmUUF0T4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=diTtw9yQSmLFKfwFy3IY89Wv4XEn4h6V
	vGXBKIpuJ6mQYm1DHRPOHlHvsEHfnE5H8UqLrqK1bZs0mhgl1c52khegYOHpzVLI
	2DFK9Jz3JQWYoZYQLPr/uNv/+5fiFVTDrGeDhd6Hm0N1bTgWJEX9S+6YrdWLMaPN
	afyVir4UlMA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A44451949C;
	Wed, 24 Apr 2013 22:34:53 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 117BF1949B;
	Wed, 24 Apr 2013 22:34:52 +0000 (UTC)
In-Reply-To: <5176B854.2000707@bracey.fi> (Kevin Bracey's message of "Tue, 23
	Apr 2013 19:35:32 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2E90928E-AD2F-11E2-889A-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222333>

Kevin Bracey <kevin@bracey.fi> writes:

> If simplify_history is set, and we do want ancestry, then it doesn't
> matter about the TREESAME definition because it shows all merges,
> regardless of the TREESAME flag. Thus adding "--parents" to the above
> command means it can find it, but only because it drags _every_ merge
> into consideration. Should that be necessary?
>
> Futher, if we add simplify_merges, then TREESAME becomes a problem.
> After merge simplification, we can be left with a single-parent
> commit that doesn't match its parent but is skipped due to its
> TREESAME flag being set: it was TREESAME to a parent that got dropped.
>
> I think the correction is that TREESAME for a commit needs to be
> redefined to be "this commit matches all its (remaining) parents",
> rather than "this commit matches at least 1 of its (remaining)
> parents". And when we eliminate parents, we have to check for the
> flag changing, but we should have been doing that anyway.

Thanks, I think this analysis is quite correct.  Marking a commit
with TREESAME means the commit is not worth showing.  If we are
simplifying side branches away, remaining parents may be reduced to
1 and "all its remaining parents" would be the same as "at least 1
of its remaining parents", but if we want to keep side branches that
matter in explaining the history, we do not want to paint the merge
with TREESAME unless it matches with all its remaining parents.

> If we redefine TREESAME, then recalculation becomes necessary to
> handle the "normal" case - the merge will not initially be TREESAME,
> as it differs from B and C. But once B and C are eliminated, we
> should then determine that the commit is TREESAME from matching
> its remaining parent A. Simplification should only ever "increase"
> the sameness, so we can avoid recalculation if TREESAME is already
> set. Without this recalculation, 6016.7 fails.
>
> So I believe that if reduce_heads() does eliminate any parents, and
> TREESAME wasn't set, then we have to recalculate TREESAME, by
> running over the remaining parents. A call to
> try_to_simplify_commit() does the job, but it feels hacky, and
> obviously it's slow. It would be nice if we could remember
> "per-parent TREESAME" flags, and shuffle them when we change
> parents, but that could be fiddly.
>
> Also if limit_to_ancestry() did eliminate parents from outside the
> ancestry, as per the NEEDSWORK comment, then that would also want
> to do the TREESAME recalculation. (And it could conceivably be very
> useful, helping pick up only the merges that went against your base
> commit).

Yeah, I agree to that.

>
> So, given all that, revised patch below:
>
> ---


>  revision.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/revision.c b/revision.c
> index eb98128..15d2f3b 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -432,7 +432,7 @@ static int rev_same_tree_as_empty(struct rev_info *revs, struct commit *commit)
>  static void try_to_simplify_commit(struct rev_info *revs, struct commit *commit)
>  {
>      struct commit_list **pp, *parent;
> -    int tree_changed = 0, tree_same = 0, nth_parent = 0;
> +    int tree_changed = 0, nth_parent = 0;
>
>      /*
>       * If we don't do pruning, everything is interesting
> @@ -474,7 +474,6 @@ static void try_to_simplify_commit(struct rev_info *revs, struct commit *commit)
>                  sha1_to_hex(p->object.sha1));
>          switch (rev_compare_tree(revs, p, commit)) {
>          case REV_TREE_SAME:
> -            tree_same = 1;
>              if (!revs->simplify_history || (p->object.flags & UNINTERESTING)) {
>                  /* Even if a merge with an uninteresting
>                   * side branch brought the entire change
> @@ -516,7 +515,7 @@ static void try_to_simplify_commit(struct rev_info *revs, struct commit *commit)
>          }
>          die("bad tree compare for commit %s", sha1_to_hex(commit->object.sha1));
>      }
> -    if (tree_changed && !tree_same)
> +    if (tree_changed)
>          return;
>      commit->object.flags |= TREESAME;
>  }
> @@ -2042,9 +2041,19 @@ static struct commit_list **simplify_one(struct rev_info *revs, struct commit *c
>       */
>      if (1 < cnt) {
>          struct commit_list *h = reduce_heads(commit->parents);
> +        int orig_cnt = commit_list_count(commit->parents);
>          cnt = commit_list_count(h);
>          free_commit_list(commit->parents);
>          commit->parents = h;
> +        if (cnt < orig_cnt && !(commit->object.flags & TREESAME)) {
> +            /* Rewrite will likely change the TREESAME state. Eg in
> +             * example above, X could be TREESAME or not to its
> +             * remaining single parent, depending on how the merge
> +             * was resolved - most likely it is now TREESAME, but
> +             * it may not be.
> +             */
> +            try_to_simplify_commit(revs, commit);
> +        }
>      }
>
>      /*
