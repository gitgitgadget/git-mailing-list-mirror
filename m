Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C201F20FCF
	for <e@80x24.org>; Wed, 29 Jun 2016 19:04:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752078AbcF2TEw (ORCPT <rfc822;e@80x24.org>);
	Wed, 29 Jun 2016 15:04:52 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61773 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751391AbcF2TEv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jun 2016 15:04:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 374C926E05;
	Wed, 29 Jun 2016 14:56:24 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bP2oRgpeOk/qDMm5TJXiS4j1nTg=; b=q9IMOz
	JtyFcH9epqE6whANjQfM4PH1LbLdZPOfojsDFc7iFTte35T9s82+3KQf3NQpIH44
	CLImXZIojNm/yuDGp90X92Wf/bO+ZDFNjUrs5B9tyTOPA+U2SV9tXmpxbG2U+Lfw
	fn1ITe4u4m7gxcLXps11HyqbGRHDWHB4TFjrM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=e/1rcPFe7KRRtSW/Rz42+e611/1iQchg
	qOmncVxNoWTJ68ziefzbvJc0fT/Jg5T0bmOO8N/fNeoIJeDhIAgnGBdjhA3B5qJW
	tArCWyytd4u23BITjaN44rwm6Pg/5Dce8qqqBuUZYE6GY78DEZWsb3h8+98as4Za
	ZIE6+IuKQCY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2DDF026E04;
	Wed, 29 Jun 2016 14:56:24 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7CE5026E03;
	Wed, 29 Jun 2016 14:56:23 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:	git@vger.kernel.org
Subject: Re: [PATCH 3/9] Prepare the builtins for a libified merge_recursive()
References: <cover.1467199553.git.johannes.schindelin@gmx.de>
	<753eabc5193c148c67e64ed5d070b6ff08f51d82.1467199553.git.johannes.schindelin@gmx.de>
Date:	Wed, 29 Jun 2016 11:56:21 -0700
In-Reply-To: <753eabc5193c148c67e64ed5d070b6ff08f51d82.1467199553.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Wed, 29 Jun 2016 13:36:48 +0200
	(CEST)")
Message-ID: <xmqqziq33ju2.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2CA999DA-3E2B-11E6-9B59-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> A truly libified function does not die() just for fun.

The sentence is wasting bits.  After all, a helper function in
run-once-and-exit program does not die() just for fun, either.

So what's more interesting to know for the readers?

> As such, the
> recursive merge will convert all die() calls to return -1 instead in the
> next commits, giving the caller a chance at least to print some helpful
> message.
>
> Let's prepare the builtins for this fatal error condition, even if we do
> not really do more than imitating the previous die()'s exit(128): this is
> what callers of e.g. `git merge` have come to expect.

One thing missing is your design decision and justification.

For example, the above explanation hints that the original code in
this hunk expected merge_trees() to die() with some useful message
when there is an error condition, but merge_trees() is going to be
improved not to die() itself and return -1 instead to signal an
error, so that the caller can react more flexibly, and this is a
step to prepare for the version of merge_trees() that no longer
dies.

> -			merge_trees(&o, new->commit->tree, work,
> +			ret = merge_trees(&o, new->commit->tree, work,
>  				old->commit->tree, &result);
> +			if (ret < 0)
> +				exit(128);

The postimage of the patch tells us that the caller is now
responsible for exiting with status 128, but neither the proposed
log message nor the above hunk tells us where the message the
original code must have given to the end user from die() inside
merge_trees().  The updated caller just exits, so a natural guess is
that the calls to die() have been changed to fprintf(stderr) with
the patch.

But that does not mesh very well with the stated objective of the
patch.  The callers want flexibility to do their own error handling,
including giving their own message, so letting merge_trees() to
still write the same message to the standard error stream would not
work well for them.  A caller may want to do merge_trees() just to
see if it succeeds, without wanting to give _any_ indication of that
is happening to the user, because it has an alternate/fallback code
if merge_trees() fails, for example (analogy: "am -3" first tries a
straight patch application before fallking back to 3-way merge; it
may not want to show the error from the first attempt).

The reader _can_ guess that this step ignores the error-message
issue, and improving it later (or keep ignoring that issue) might be
OK in the context of this patch series, but it is necessary to be
upfront to the readers what the design choices were and which one of
those choices the proposed patch adopted as its design for them to
be able to evaluate the patch series correctly.

One design alternative we've seen used in our code to help callers
who want no default messages is to pass struct strbuf &err down the
callchain and collect the default messages without emitting them
directly to the standard error stream when an error is diagnosed.  I
do not know if that pattern is applicable or should be applied to
this codepath.

> Note that the callers of the sequencer (revert and cherry-pick) already
> fail fast even for the return value -1; The only difference is that they
> now get a chance to say "<command> failed".
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  builtin/checkout.c | 4 +++-
>  builtin/merge.c    | 4 ++++
>  sequencer.c        | 4 ++++
>  3 files changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index c3486bd..14312f7 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -567,8 +567,10 @@ static int merge_working_tree(const struct checkout_opts *opts,
>  			o.ancestor = old->name;
>  			o.branch1 = new->name;
>  			o.branch2 = "local";
> -			merge_trees(&o, new->commit->tree, work,
> +			ret = merge_trees(&o, new->commit->tree, work,
>  				old->commit->tree, &result);
> +			if (ret < 0)
> +				exit(128);
>  			ret = reset_tree(new->commit->tree, opts, 0,
>  					 writeout_error);
>  			if (ret)
> diff --git a/builtin/merge.c b/builtin/merge.c
> index b555a1b..133b853 100644
> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -682,6 +682,8 @@ static int try_merge_strategy(const char *strategy, struct commit_list *common,
>  		hold_locked_index(&lock, 1);
>  		clean = merge_recursive(&o, head,
>  				remoteheads->item, reversed, &result);
> +		if (clean < 0)
> +			exit(128);
>  		if (active_cache_changed &&
>  		    write_locked_index(&the_index, &lock, COMMIT_LOCK))
>  			die (_("unable to write %s"), get_index_file());
> @@ -1550,6 +1552,8 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
>  		ret = try_merge_strategy(use_strategies[i]->name,
>  					 common, remoteheads,
>  					 head_commit, head_arg);
> +		if (ret < 0)
> +			exit(128);
>  		if (!option_commit && !ret) {
>  			merge_was_ok = 1;
>  			/*
> diff --git a/sequencer.c b/sequencer.c
> index c6362d6..13b794a 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -293,6 +293,8 @@ static int do_recursive_merge(struct commit *base, struct commit *next,
>  	clean = merge_trees(&o,
>  			    head_tree,
>  			    next_tree, base_tree, &result);
> +	if (clean < 0)
> +		return clean;
>  
>  	if (active_cache_changed &&
>  	    write_locked_index(&the_index, &index_lock, COMMIT_LOCK))
> @@ -561,6 +563,8 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
>  	if (!opts->strategy || !strcmp(opts->strategy, "recursive") || opts->action == REPLAY_REVERT) {
>  		res = do_recursive_merge(base, next, base_label, next_label,
>  					 head, &msgbuf, opts);
> +		if (res < 0)
> +			return res;
>  		write_message(&msgbuf, git_path_merge_msg());
>  	} else {
>  		struct commit_list *common = NULL;
