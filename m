Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEB99C25B08
	for <git@archiver.kernel.org>; Wed, 17 Aug 2022 22:42:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239161AbiHQWmN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Aug 2022 18:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233371AbiHQWmM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Aug 2022 18:42:12 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C779998D09
        for <git@vger.kernel.org>; Wed, 17 Aug 2022 15:42:10 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 70C9F1433F5;
        Wed, 17 Aug 2022 18:42:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=FEgUb2YPsc8UFqOdVOnZssRX3WJvY6ZsbIvdIh
        hiDkE=; b=d66eoqq4er62/0qj3fhmuzJ0AwZk09AmTuXW21uo7RBKumQiiX3Od2
        Ldl+vNHu1v4mS+RUUBif0176NxZsCf/ka/uP0WeiHCEz0X9Bxmbd3QH0zctxpgUw
        kQKImR2rgkhFMumRUHiZQ5+4loUwrrkgFHMkHmkiPy3PHwz5CXDjE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 685E61433F4;
        Wed, 17 Aug 2022 18:42:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D13301433F3;
        Wed, 17 Aug 2022 18:42:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 2/2] revision: allow --ancestry-path to take an argument
References: <pull.1303.git.1660704498.gitgitgadget@gmail.com>
        <99287b67fd1c1e9fbceb4877738fb0aed722ec4a.1660704498.git.gitgitgadget@gmail.com>
Date:   Wed, 17 Aug 2022 15:42:07 -0700
In-Reply-To: <99287b67fd1c1e9fbceb4877738fb0aed722ec4a.1660704498.git.gitgitgadget@gmail.com>
        (Elijah Newren via GitGitGadget's message of "Wed, 17 Aug 2022
        02:48:18 +0000")
Message-ID: <xmqqpmgysda8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D3A26CA6-1E7D-11ED-A1D8-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Elijah Newren <newren@gmail.com>
>
> We have long allowed users to run e.g.
>     git log --ancestry-path next..seen
> which shows all commits which satisfy all three of these criteria:
>   * are an ancestor of seen
>   * are not an ancestor next
>   * have next as an ancestor

Is it a very good example, though?  Nothing builds on next, and next
is not an ancestor of seen, so the command without --ancestry-path
does give us individual commits that are not in 'next' yet, plus all
the merge commits in master..seen but with --ancestry-path the
answer is most likely an empty set.

If you replace 'next' with 'master', it does start to make sense,
but that is a bit too straight first-parent merge chain that may not
be all that interesting.

> This commit allows another variant:
>     git log --ancestry-path=$TOPIC next..seen
> which shows all commits which satisfy all of these criteria:
>   * are an ancestor of seen
>   * are not an ancestor of next
>   * have $TOPIC in their ancestry-path
> that last bullet can be defined as commits meeting any of these
> criteria:
>     * are an ancestor of $TOPIC
>     * have $TOPIC as an ancestor
>     * are $TOPIC

So, I have en/ancestry-path-in-a-range topic merged somewhere
between 'master' and 'seen'.  Here is what I see:

    $ seen/git log --oneline --ancestry-path=en/ancestry-path-in-a-range master..seen
    21aef6c754 Merge branch 'ab/submodule-helper-leakfix' into seen
    2a57fcc25e Merge branch 'ab/submodule-helper-prep' into seen
    72ff5f5d3a ###
    edb5cf4c31 Merge branch 'cw/remote-object-info' into seen
    cc8f65a665 Merge branch 'ag/merge-strategies-in-c' into seen
    c1bacacabf Merge branch 'es/mark-gc-cruft-as-experimental' into seen
    fdf2d207d2 Merge branch 'js/bisect-in-c' into seen
    2a1bbfc016 Merge branch 'po/glossary-around-traversal' into seen
    7ecf004b9e Merge branch 'vd/scalar-enables-fsmonitor' into jch
    9dba189986 Merge branch 'en/ancestry-path-in-a-range' into jch
    4461e34d7d revision: allow --ancestry-path to take an argument
    0605b4aad9 rev-list-options.txt: fix simple typo

which is very much expected.  Two commits are what we want to
highlight, and its merge into the first-parent-chain that leads to
'seen', and all its descendants on 'seen' are shown.

Due to the way "ancestry-path" is defined, replacing the value to
"--ancestry-path" from 4461e34d7d to 0605b4aad9 would not change the
output, which is also expected.  If this were a three-commit topic,
giving the middle commit would find both the first one (i.e. the
ancestor) and the third one (i.e. the descendant) in the topic, while
excluding the much-less-interesting base commit and its ancestors
the topic builds on. 

I am not exactly sure when this feature is useful, though.  It is
handy to be able to enumerate descendants of a given commit, so
perhaps the user knows about 0605b4aad9 and is trying to find other
commits on the same topic, or something?  But then the merges nearer
the tip of 'seen' than 9dba189986 are not very useful for that
purpose.  It somehow feels like a solution in search of a problem.

> diff --git a/revision.c b/revision.c
> index 0c6e26cd9c8..660f1dd1b9b 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -1105,7 +1105,7 @@ static int process_parents(struct rev_info *revs, struct commit *commit,
>  			   struct commit_list **list, struct prio_queue *queue)
>  {
>  	struct commit_list *parent = commit->parents;
> -	unsigned left_flag;
> +	unsigned left_flag, ancestry_flag;
>  
>  	if (commit->object.flags & ADDED)
>  		return 0;
> @@ -1161,6 +1161,7 @@ static int process_parents(struct rev_info *revs, struct commit *commit,
>  		return 0;
>  
>  	left_flag = (commit->object.flags & SYMMETRIC_LEFT);
> +	ancestry_flag = (commit->object.flags & ANCESTRY_PATH);

Wouldn't we want

	if (revs->ancestry_path)
		ancestry_flag = (commit->object.flags & ANCESTRY_PATH);

instead, so that the propagation of contaminated flag bits ...

>  	for (parent = commit->parents; parent; parent = parent->next) {
>  		struct commit *p = parent->item;
> @@ -1181,6 +1182,8 @@ static int process_parents(struct rev_info *revs, struct commit *commit,
>  			if (!*slot)
>  				*slot = *revision_sources_at(revs->sources, commit);
>  		}
> +		if (revs->ancestry_path)
> +			p->object.flags |= ancestry_flag;
>  		p->object.flags |= left_flag;

... can become a simple

		p->object.flags |= ancestry_flag;

here?  Or even just use a single variable to compute the set of
flags to pass down i.e.

	pass_flags = commit->object.flags & (SYMMETRIC_LEFT | ANCESTRY_PATH);

before the loop, and then pass these two bits down at once, i.e.

-  		p->object.flags |= left_flag;
+  		p->object.flags |= pass_flags;

taking advantage of the fact that ANCESTRY_PATH and SYMMETRIC_LEFT
bits can be set to any object only when these features are in use?

Or did I misread the patch and sometimes ANCESTRY_PATH bit is set on
objects even when revs->ancestry_path is not in use?

> +static void limit_to_ancestry(struct commit_list *bottoms, struct commit_list *list)
>  {
>  	struct commit_list *p;
>  	struct commit_list *rlist = NULL;
> @@ -1323,7 +1333,7 @@ static void limit_to_ancestry(struct commit_list *bottom, struct commit_list *li
>  	for (p = list; p; p = p->next)
>  		commit_list_insert(p->item, &rlist);
>  
> -	for (p = bottom; p; p = p->next)
> +	for (p = bottoms; p; p = p->next)
>  		p->item->object.flags |= TMP_MARK;
>  
>  	/*
> @@ -1356,38 +1366,39 @@ static void limit_to_ancestry(struct commit_list *bottom, struct commit_list *li
>  	 */
>  
>  	/*
> -	 * The ones that are not marked with TMP_MARK are uninteresting
> +	 * The ones that are not marked with either TMP_MARK or
> +	 * ANCESTRY_PATH are uninteresting
>  	 */
>  	for (p = list; p; p = p->next) {
>  		struct commit *c = p->item;
> -		if (c->object.flags & TMP_MARK)
> +		if (c->object.flags & (TMP_MARK | ANCESTRY_PATH))
>  			continue;
>  		c->object.flags |= UNINTERESTING;
>  	}
>  
> -	/* We are done with the TMP_MARK */
> +	/* We are done with TMP_MARK and ANCESTRY_PATH */
>  	for (p = list; p; p = p->next)
> -		p->item->object.flags &= ~TMP_MARK;
> -	for (p = bottom; p; p = p->next)
> -		p->item->object.flags &= ~TMP_MARK;
> +		p->item->object.flags &= ~(TMP_MARK | ANCESTRY_PATH);
> +	for (p = bottoms; p; p = p->next)
> +		p->item->object.flags &= ~(TMP_MARK | ANCESTRY_PATH);
>  	free_commit_list(rlist);
>  }

We have called process_parents() to paint ancestor commits that can
be reached from the commit(s) of interest.  This helper function is
called after that is done, and propagates the ancestry_path bit in
the reverse direction, i.e. from parent to child.

Once we are done with this processing, we no longer need
ANCESTRY_PATH bit because the surviving ones without UNINTERESTING
bit set are the commits on the ancestry_path.  OK.

