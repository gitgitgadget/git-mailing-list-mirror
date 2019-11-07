Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C7F01F454
	for <e@80x24.org>; Thu,  7 Nov 2019 06:05:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbfKGGF4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Nov 2019 01:05:56 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58425 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbfKGGF4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Nov 2019 01:05:56 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5BAC2918B9;
        Thu,  7 Nov 2019 01:05:54 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=lQSmuGoZco0YmxnWN/QezVK83sg=; b=PX8Dic
        shzA7CigK4ilgRbcfy6L+7NLVZOfCSWw/TEKmkfRY2Yie9KmUMgWpE0ygi0nJnou
        LcuZT5ilyDbqTevLpTIWNYV2yovSUowMV/UjKF3pE8zjSqubBQ7yG5NjvBPKzwBr
        R8LUdvGfF9DUYlSdn3pOgoNw2l3VBO1JGSiLQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=sXTqS3ot71BmrxHgKCVDU7zO+FOScrFM
        Sj56pIndp1cDJuZ50iBUftf5Yhh5F3rh2N5P8bJicczgjlyHrmRH3h3QzSgrw1rh
        NDfXi7ekJU/oLRJ8M9APWiM0daPTsy8GlNmU6+0P+t+TYRI0JyNTogH5rgJITNT2
        ObeoZn6QLTw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 543DE918B8;
        Thu,  7 Nov 2019 01:05:54 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8092E918B7;
        Thu,  7 Nov 2019 01:05:51 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ingo Rohloff <ingo.rohloff@lauterbach.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] branch: Forbid to create local branches with confusing names
References: <20191106165628.28563-1-ingo.rohloff@lauterbach.com>
Date:   Thu, 07 Nov 2019 15:05:49 +0900
In-Reply-To: <20191106165628.28563-1-ingo.rohloff@lauterbach.com> (Ingo
        Rohloff's message of "Wed, 6 Nov 2019 17:56:28 +0100")
Message-ID: <xmqqftj0qkzm.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A6B2D63C-0124-11EA-8812-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ingo Rohloff <ingo.rohloff@lauterbach.com> writes:

> Without this patch, git allows to do something like this:
>   git branch remotes/origin/master
>   git branch refs/remotes/origin/master
>   git branch heads/master
>   git branch tags/v3.4
> All of these local branch names lead to severe confusion,
> not only for a user but also for git itself.
>
> This patch forbids to create local branches, with names which start
> with any of
>
>   refs/
>   heads/
>   remotes/
>   tags/

Is there a reason why notes/ hierarchy is excluded?  What about
pull/?  Are we dealing with an unbounded set?  Should this list be
somehow end-user configurable so that say Gerrit users can add for/
and changes/ to the "forbidden" set?

> With this patch, you might still create these kind of local branches,
> but now you have to additionally specify the '-f' option.

This is not a change to builtin/branch.c, so other commands that
call create_branch() would be affected---are they all equipped to
toggle on the same bit that is affected by the '-f' option you have
in mind (presumably "git branch -f")?  Wouldn't forcing for those
other command have undesirable side effects?

I didn't check the code, but I think "checkout -b" also calls
create_branch() so presumably it also is affected.  Using "-B"
instead of "-b" for "checkout" might pass the force bit on, but
typically that is done only to recreate an existing branch.  Is it a
good idea to change the meaning of "-B" to also mean "do not bother
checking the sanity of the branch name"?

> --- a/branch.c
> +++ b/branch.c
> @@ -256,6 +256,16 @@ void create_branch(struct repository *r,
>  	int dont_change_ref = 0;
>  	int explicit_tracking = 0;
>  
> +	if (!force && (
> +		starts_with(name, "refs/") ||
> +		starts_with(name, "heads/") ||
> +		starts_with(name, "remotes/") ||
> +		starts_with(name, "tags/")
> +	)) {
> +		die(_("A local branch name should not start with "
> +		      "\"refs/\", \"heads/\", \"remotes/\" or \"tags/\""));
> +	}
> +
>  	if (track == BRANCH_TRACK_EXPLICIT || track == BRANCH_TRACK_OVERRIDE)
>  		explicit_tracking = 1;
