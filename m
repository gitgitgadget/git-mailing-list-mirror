Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 713DC1F6BF
	for <e@80x24.org>; Fri,  9 Sep 2016 21:55:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753367AbcIIVzK (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Sep 2016 17:55:10 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56679 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751120AbcIIVzJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2016 17:55:09 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E372A3B60B;
        Fri,  9 Sep 2016 17:55:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=AXpecekTMgApiGhJY8wpjbXpZ+g=; b=HQ7sGp
        lUdG+9SvqbUVvoXT2yws77njZv1x2zU1tRDWnZZ2TRQJ4EcoAkwc+dpspndt9pCF
        0drJx43O0rsZ6RKPH4YMjIAaXzTIDMedAxeFHmmA9/KazXhXtWcPgiRyjY+syCEH
        wl1QyHUsXTQnW5N0Q5xgdx80CuR7M7U8gT9G4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=gx+IRYl6dcPNV1pOlUl48WJz8fedZcAy
        /tgnm1hKlSEcscw6zqBF+JHq13FVZzdv8jU6/3l7DUsOtpVRk78wMYJPDHFKMgrK
        S6QNkJCdF+t1GBBrIcEJHpdJZMxguRvHp0NkLfV6w5aCtqQauXnx/wFCfGg+BnZM
        tUhkhhBb92A=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D9C823B608;
        Fri,  9 Sep 2016 17:55:07 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 296353B607;
        Fri,  9 Sep 2016 17:55:07 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ben Peart <peartben@gmail.com>
Cc:     git@vger.kernel.org, pclouds@gmail.com,
        Ben Peart <benpeart@microsoft.com>
Subject: Re: [PATCH v2] checkout: eliminate unnecessary merge for trivial checkout
References: <20160909192520.4812-1-benpeart@microsoft.com>
Date:   Fri, 09 Sep 2016 14:55:05 -0700
In-Reply-To: <20160909192520.4812-1-benpeart@microsoft.com> (Ben Peart's
        message of "Fri, 9 Sep 2016 15:25:20 -0400")
Message-ID: <xmqq1t0sagcm.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 123E7EC2-76D8-11E6-8A9D-F7BB12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ben Peart <peartben@gmail.com> writes:

> @@ -802,6 +806,87 @@ static void orphaned_commit_warning(struct commit *old, struct commit *new)
>  	free(refs.objects);
>  }
>  
> +static int needs_working_tree_merge(const struct checkout_opts *opts,
> +	const struct branch_info *old,
> +	const struct branch_info *new)
> +{
> +	/*
> +	 * We must do the merge if we are actually moving to a new
> +	 * commit tree.
> +	 */
> +	if (!old->commit || !new->commit ||
> +		oidcmp(&old->commit->tree->object.oid, &new->commit->tree->object.oid))
> +		return 1;

A huge helper function helps it somewhat, compared with the earlier
unreadable mess ;-).

Are we certain that at this point the commit objects are both parsed
and their tree->object.oid are both valid?

> +	/*
> +	 * Honor the explicit request for a three-way merge or to throw away
> +	 * local changes
> +	 */
> +	if (opts->merge || opts->force)
> +		return 1;

Hmph, "git checkout -m HEAD" wouldn't have to do anything wrt the
index status, no?

For that matter, neither "git checkout -f HEAD".  Unless we rely on
unpack_trees() to write over the working tree files.

    ... me goes and looks, and finds that merge_working_tree()
    indeed does have a logic to do quite different thing when
    "--force" is given.

This makes me wonder if the "merge_working_tree() is expensive, so
selectively skip calling it" approach is working at a wrong level.
Wouldn't the merge_working_tree() function itself a better place to
do this kind of "we may not have to do the full two-way merge"
optimization?  It already looks at opts and does things differently
(e.g. when running with "--force", it does not even call unpack).
If you can optimize even more by looking at other fields in opts to
avoid unpack, that would fit better with the structure of the code
that we already have.

> +	/*
> +	 * Checking out the requested commit may require updating the working
> +	 * directory and index, let the merge handle it.
> +	 */
> +	if (opts->force_detach)
> +		return 1;

This does not make much sense to me.  After "git branch -f foo
HEAD", there is no difference in what is done to the index and the
working directory between "git checkout --detach HEAD" and "git
checkout foo", is there?

> +	/*
> +	 * opts->writeout_stage cannot be used with switching branches so is
> +	 * not tested here
> +	 */
> +
> +	 /*
> +	  * Honor the explicit ignore requests
> +	  */
> +	if (!opts->overwrite_ignore || opts->ignore_skipworktree
> +		|| opts->ignore_other_worktrees)
> +		return 1;

Style.  I think you earlier had

	if (a || b ||
            c)

and here you are doing

	if (a || b
            || c)

Please pick one and stick to it (I'd pick the former).

> +	 /*
> +	 * If we're not creating a new branch, by definition we're changing
> +	 * the existing one so need to do the merge
> +	 */
> +	if (!opts->new_branch)
> +		return 1;

Sorry, but I fail to follow that line of thought.  Starting from a
state where your HEAD points at commit A,

 - switching to a detached HEAD pointing at a commit A,
 - switching to an existing branch that already points at the same
   commit A, and
 - force updating an existing branch that was pointing at something
   else to point at the same commit A,

would have the same effect as creating a new branch at commit A and
switching to it, no?  The same comment applies to the remainder of
this function.

More importantly, merge_working_tree() checks things other than what
this function is checking.  For example, it prevents you from
branch-switching (whether it is to switch to an existing branch that
has the same commit as the current HEAD, to switch to detached HEAD
state at the same commit as the current HEAD, or to switch to a new
branch that points at the same commit as the current HEAD) if your
index is unmerged (i.e. you are in the middle of a mergy operation).

So my gut feeling is that this:

> +	/*
> +	 * Optimize the performance of "git checkout foo" by skipping the call
> +	 * to merge_working_tree where possible.
> +	 */
> +	if (needs_working_tree_merge(opts, &old, new)) {
> +		ret = merge_working_tree(opts, &old, new, &writeout_error);

works at the wrong level.  The comment up to 'Optimize the
performance of "git checkout foo"' may correctly state what we want
to achieve, but I think we should do so not with "by skipping the
call to", but with "by optimizing merge_working_tree()".

Thanks.


