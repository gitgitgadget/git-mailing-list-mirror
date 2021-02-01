Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 391D9C433E0
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 20:07:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E11CB64DDB
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 20:07:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232990AbhBAUHN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 15:07:13 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60544 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233011AbhBAUGk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 15:06:40 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CEB3E120ECE;
        Mon,  1 Feb 2021 15:05:58 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8ZB2RZwoFmfEvfs0Uc1tSxgGBZM=; b=i/iV5r
        KA4LllKVJ1mcMTLvKHhXmuUJeVXozY56AaPEJqWHb0geU+eaSREnwkykiRn9yygo
        5Qt7s3VHiv9sb8n6MpnX8Ugc6NssCHxl9W52gci7gVolHWyESLGSH+U3EH9KooMd
        4UHW0hfBJHFNSq5ZsP/h78aKx3U/b6DNnQg5k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=RkpK8AwfHPFAUkuM+f4AaEJ1KjTUc+Lg
        /ATHFDzIy9PyDi7pWfQbKKA9MFgmeCYVlMWrWQsvPpRcouxAPGUVueVLGxX4umbY
        oeeKuw39l9jDjE/5ZQOKAZSDi/Oqs8npg72uSTPlo1vN8Tk1vdyc/7Xmr9ZJOSXL
        JOsfTHXXdB0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C708B120ECD;
        Mon,  1 Feb 2021 15:05:58 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 12723120ECA;
        Mon,  1 Feb 2021 15:05:55 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
        me@ttaylorr.com, peff@peff.net,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 4/5] commit-reach: use heuristic in remove_redundant()
References: <pull.852.git.1611851095.gitgitgadget@gmail.com>
        <pull.852.v2.git.1612183647.gitgitgadget@gmail.com>
        <83feabeebb5f035059758fba1ca5cf74f3a22c91.1612183647.git.gitgitgadget@gmail.com>
Date:   Mon, 01 Feb 2021 12:05:54 -0800
In-Reply-To: <83feabeebb5f035059758fba1ca5cf74f3a22c91.1612183647.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Mon, 01 Feb 2021
        12:47:26 +0000")
Message-ID: <xmqqczxjlfj1.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E4DE0658-64C8-11EB-8206-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> The important piece is to ensure we short-circuit the walk when we find
> that there is a single non-redundant commit. This happens frequently
> when looking for merge-bases or comparing several tags with 'git
> merge-base --independent'. Use a new count 'count_still_independent' and
> if that hits 1 we can stop walking.

That is because when you are left one single thing, it may be able
to reach many other things, but the fact that it by itself won't be
reachable by remaining independent things will not change (because,
that sole remaining independent thing is itself)?

> To update 'count_still_independent' properly, we add use of the RESULT
> flag on the input commits. Then we can detect when we reach one of these
> commits and decrease the count. We need to remove the RESULT flag at
> that moment because we might re-visit that commit when popping the
> stack.
>
> We use the STALE flag to mark parents that have been added to the new
> walk_start list, but we need to clear that flag before we start walking
> so those flags don't halt our depth-first-search walk.
>
> On my copy of the Linux kernel repository, the performance of 'git
> merge-base --independent <all-tags>' goes from 1.1 seconds to 0.11
> seconds.

These two numbers are with commit-graph fully populated with usable
generation numbers, I presume, and it is quite impressive.

