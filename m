Return-Path: <SRS0=9bkr=2Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B1CDC32767
	for <git@archiver.kernel.org>; Sat,  4 Jan 2020 23:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D75522464E
	for <git@archiver.kernel.org>; Sat,  4 Jan 2020 23:52:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Mw9t2eQw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbgADXso (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Jan 2020 18:48:44 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52116 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbgADXsn (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Jan 2020 18:48:43 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 184FB1863D;
        Sat,  4 Jan 2020 18:48:40 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=fbojODH0YVSu2goTdsVMD5g74Mk=; b=Mw9t2e
        QwrdnZ+U7GKzjXKo3onEHDh0O2zMlbYMlyyP4L8ihwvLqTUZJUGlQ0d6sg37tTJu
        RHPDqoexlGM6x4o5quM4Vg4h33jyWexVP95ZO1v60YrXfYiX2GKPn0MDIF6yA40x
        U6684MT6ZA91bjHB6LJJTFipCbvWC72y3j7es=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=QQ2pqSllyf1L1pFb3pNpE7x/UzTQH0I/
        Qys3VDOMhJAvjOTEyVIZSYsn7FPEilNCaQ2KWJkPUu5O5zawi3jV6XIt6s4YShNZ
        9zOP7gUjyEN1DHNdwpiNECJqAR9rNNlWtH6RFR4rujeL2ankrf4NGRaxqiPZ/kwz
        t9yBt++cOB8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 101231863C;
        Sat,  4 Jan 2020 18:48:40 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7601E1863B;
        Sat,  4 Jan 2020 18:48:39 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 1/1] unpack-trees: exit check_updates() early if updates are not wanted
References: <pull.686.git.git.1578087730.gitgitgadget@gmail.com>
        <de0f381284cfe90c1bd8521abb8d29e3529c981a.1578087730.git.gitgitgadget@gmail.com>
Date:   Sat, 04 Jan 2020 15:48:38 -0800
In-Reply-To: <de0f381284cfe90c1bd8521abb8d29e3529c981a.1578087730.git.gitgitgadget@gmail.com>
        (Elijah Newren via GitGitGadget's message of "Fri, 03 Jan 2020
        21:42:09 +0000")
Message-ID: <xmqqimlqbx61.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BB528A00-2F4C-11EA-80A6-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +	if (!o->update || o->dry_run) {
> +		remove_marked_cache_entries(index, 0);
> +		trace_performance_leave("check_updates");
> +		return 0;
> +	}

OK, so the idea is that bunch of codepaths we see later are
protected by "o->update && !o->dry_run" in the original and are not
executed, so we can leave early here.

So the primary task of the reviewers of this patch is to see if the
remainder of the function has some code that were *not* no-op when
(!o->update || o->dry_run) is true in the current code, which would
indicate possible behaviour change, and assess if the change in
behaviour matters in the real world if there is.

>  	if (o->clone)
>  		setup_collided_checkout_detection(&state, index);

If there were such a thing as dry-run of a clone, we will stop
calling the report based on the thing we are setting up here?
Presumably that does not happen in the current code---is that
something we guarantee in the future evolution of the code, though?

>  	progress = get_progress(o);

get_progress() would yield NULL when !o->update, but o->dry_run does
not influence it, so we would have called the progress API in
today's code, if o->dry_run and o->update are both true.

Presumably, o->update and o->dry_run are not true at the same time
in the current code---but even if in the future we start supporting
the combination, dry-run should be skipping the filesystem update
(which is the slow part) and lack of progress may not matter, I
guess?

It seems to me that unpack_trees_options.dry_run can become true
only in "git read-tree" when the -n (or --dry-run) option is given
and no other codepath touches it.  Am I reading the code correctly?

Similarly, unpack_trees_options.clone is turned on only in the
builtin/clone.c::checkout().  It _might_ occur to future developers
that "git clone --no-checkout" is better implemented by actually
going through builtin/clone.c::checkout() with .dry_run turned on,
instead of leaving that function early.  That would for example
allow collided_checkout() detection to still be done---in such a
future, is the optimization this patch makes still safe, I wonder?

> -	if (o->update)
> -		git_attr_set_direction(GIT_ATTR_CHECKOUT);
> +	git_attr_set_direction(GIT_ATTR_CHECKOUT);
>  
> -	if (should_update_submodules() && o->update && !o->dry_run)
> +	if (should_update_submodules())
>  		load_gitmodules_file(index, NULL);

Good (no behaviour change because this wouldn't have been done under
the early-exit condition anyway).
>  
>  	for (i = 0; i < index->cache_nr; i++) {
> @@ -388,18 +393,18 @@ static int check_updates(struct unpack_trees_options *o)
>  
>  		if (ce->ce_flags & CE_WT_REMOVE) {
>  			display_progress(progress, ++cnt);
> -			if (o->update && !o->dry_run)
> -				unlink_entry(ce);
> +			unlink_entry(ce);

Good (no behaviour change because this wouldn't have been done under
the early-exit condition anyway).

>  		}
>  	}
> +
>  	remove_marked_cache_entries(index, 0);
>  	remove_scheduled_dirs();
>  
> -	if (should_update_submodules() && o->update && !o->dry_run)
> +	if (should_update_submodules())
>  		load_gitmodules_file(index, &state);

Good (no behaviour change because this wouldn't have been done under
the early-exit condition anyway).
>  
>  	enable_delayed_checkout(&state);
> -	if (has_promisor_remote() && o->update && !o->dry_run) {
> +	if (has_promisor_remote()) {

Good (no behaviour change because this wouldn't have been done under
the early-exit condition anyway).

>  		/*
>  		 * Prefetch the objects that are to be checked out in the loop
>  		 * below.
> @@ -431,15 +436,12 @@ static int check_updates(struct unpack_trees_options *o)
>  				    ce->name);
>  			display_progress(progress, ++cnt);
>  			ce->ce_flags &= ~CE_UPDATE;
> -			if (o->update && !o->dry_run) {
> -				errs |= checkout_entry(ce, &state, NULL, NULL);
> -			}
> +			errs |= checkout_entry(ce, &state, NULL, NULL);

Good (no behaviour change because this wouldn't have been done under
the early-exit condition anyway).

>  		}
>  	}
>  	stop_progress(&progress);
>  	errs |= finish_delayed_checkout(&state, NULL);
> -	if (o->update)
> -		git_attr_set_direction(GIT_ATTR_CHECKIN);
> +	git_attr_set_direction(GIT_ATTR_CHECKIN);
>  
>  	if (o->clone)
>  		report_collided_checkout(index);

Behaviour around this one (and the corresponding setup) may make a
difference before and after the patch to future developers (who may
need to revert this change to achieve what they want to do), but I
think it is a no-op clean-up for today's code.

