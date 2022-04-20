Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15FFCC433EF
	for <git@archiver.kernel.org>; Wed, 20 Apr 2022 18:25:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381511AbiDTS2b (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Apr 2022 14:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381478AbiDTS23 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Apr 2022 14:28:29 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D821A049
        for <git@vger.kernel.org>; Wed, 20 Apr 2022 11:25:42 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 294511848DC;
        Wed, 20 Apr 2022 14:25:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6iyz2kbxVmZ2Dp4y3rjR5r877Rqd+/EEXMQC6X
        5427E=; b=Vq0+N9+1PqKk0I4atK5pYGb1e0KKMsdsMRLgWoY7FO0l+nZrl/Cb/C
        /avsrcPz+219+yqJOhtpp4AUCPEgUehRADn7bD3o88QqxtmiCAUVdNx6vtCau2Cc
        vdm2esVEB/6hmZriMD5/6GpW7I3Pl6k+v8eqe734uknD4q9fefv68=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 214361848D9;
        Wed, 20 Apr 2022 14:25:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.84.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A670B1848D8;
        Wed, 20 Apr 2022 14:25:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2 1/8] rebase --apply: remove duplicated code
References: <pull.1150.git.1645441854.gitgitgadget@gmail.com>
        <pull.1150.v2.git.1650448612.gitgitgadget@gmail.com>
        <a4320f2fcf35f180e1c585be4105194f1555a874.1650448612.git.gitgitgadget@gmail.com>
Date:   Wed, 20 Apr 2022 11:25:36 -0700
In-Reply-To: <a4320f2fcf35f180e1c585be4105194f1555a874.1650448612.git.gitgitgadget@gmail.com>
        (Phillip Wood via GitGitGadget's message of "Wed, 20 Apr 2022 09:56:44
        +0000")
Message-ID: <xmqq35i7r4rj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 469F4F6C-C0D7-11EC-963A-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:

> -	strbuf_reset(&msg);

This is unnecessary, because we have released immediately before.

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> When we are reattaching HEAD after a fast-forward we can use
> move_to_original_branch() rather than open coding a copy of that
> code. The old code appears to handle the case where the rebase is
> started from a detached HEAD but in fact in that case there is nothing
> to do as we have already updated HEAD.

At the beginning of move_to_original_branch(), there is an early
return to do nothing when the head is detached.  But the code before
the pre-context of the hunk already detached the head at the "onto",
and the fast-forward case wants to leave the detached head pointing
at that "onto" commit, so the early return without doing anything is
exactly what we want to see.

Does that mean that the original code had left two reflog entries
for HEAD, one to detach at the "onto" commit, and then in this block
to say "rebase finished" here?  With the new code, because we return
early from move_to_original_branch(), we no longer leave the "rebase
finished" record in the reflog of HEAD?

Is it done deliberately as an improvement, or an oversight that led
to a possible regression?

Or do we still add the reflog entry for HEAD that says "rebase finished"
somewhere else when we trigger the early return and I am misreading
the code?

> >  	if (oideq(&merge_base, &options.orig_head)) {
>  		printf(_("Fast-forwarded %s to %s.\n"),
>  			branch_name, options.onto_name);
> -		strbuf_addf(&msg, "rebase finished: %s onto %s",
> -			options.head_name ? options.head_name : "detached HEAD",
> -			oid_to_hex(&options.onto->object.oid));
> -		memset(&ropts, 0, sizeof(ropts));
> -		ropts.branch = options.head_name;
> -		ropts.flags = RESET_HEAD_REFS_ONLY;
> -		ropts.head_msg = msg.buf;
> -		reset_head(the_repository, &ropts);
> -		strbuf_release(&msg);
> +		move_to_original_branch(&options);
>  		ret = finish_rebase(&options);
>  		goto cleanup;
>  	}

