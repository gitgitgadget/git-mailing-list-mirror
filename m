Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8CFCC433DB
	for <git@archiver.kernel.org>; Mon,  8 Feb 2021 17:38:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AABAE64E7D
	for <git@archiver.kernel.org>; Mon,  8 Feb 2021 17:38:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232985AbhBHRie (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Feb 2021 12:38:34 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52476 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234998AbhBHRiJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Feb 2021 12:38:09 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 24AD8AECD5;
        Mon,  8 Feb 2021 12:37:25 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2mIytjy5Hxmu0y/I+aZT94wL1jI=; b=x3IF5H
        RdCMJqx+g7lGNJzlI+8k7SeBZVMghh3WLeN+2Ml95+GqZ1xvqNl5d5syeCaU0TFC
        KVUhWpMbCNHHKBfmc3/YWjYd7PEhqW5+BQ5jKCjZ+fNPPUSexvNI+g9o8UDPqIiO
        XyG4NhMBnroknxtqoiPiQdGxlnr5qkHh8CJEY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=RcPOY3/OSJxexiPqcrHWa4TOvehym9mZ
        W48dk01Aiyk/jGL1de4rwwBWcN8HBBvHKXGmc/tdOxEyAiThfG2LV6dJhhlUp4C0
        t1OH03V8k9SxTvweNwCX0A0e84zUtFbDOOmoudAxoB4g7hJ6jT+ZWM+d/6Y7yAGZ
        eYifCMAySrg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1BB1EAECD4;
        Mon,  8 Feb 2021 12:37:25 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 86FA6AECD3;
        Mon,  8 Feb 2021 12:37:24 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] diffcore-rename: guide inexact rename detection
 based on basenames
References: <pull.843.git.1612651937.gitgitgadget@gmail.com>
        <1d941c35076e8d515c8ff7ef01d6b9d8c092aaa9.1612651937.git.gitgitgadget@gmail.com>
        <9fbed0f9-032e-3f99-8467-f8a9cfa2d8f1@gmail.com>
        <xmqqsg677j2u.fsf@gitster.c.googlers.com>
        <CABPp-BGAgi+ooq==ZY2tWif0--W4Cruz02GDvxueHe6GjQEAXQ@mail.gmail.com>
Date:   Mon, 08 Feb 2021 09:37:23 -0800
In-Reply-To: <CABPp-BGAgi+ooq==ZY2tWif0--W4Cruz02GDvxueHe6GjQEAXQ@mail.gmail.com>
        (Elijah Newren's message of "Mon, 8 Feb 2021 00:38:00 -0800")
Message-ID: <xmqq4kim7964.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4E14B430-6A34-11EB-998B-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> idea is still possible.  For example, A.txt could have been compared
> to source/some-module/A.txt.  And I don't do anything in the final
> "full matrix" stage to avoid re-comparing those two files again.
> However, it is worth noting that A.txt will have been compared to at
> most one other file, not N files.

Sorry, but where does this "at most one other file" come from?  "It
is rare to remove source/some-other-module/A.txt at the same time
while the above is happening"?  If so, yes, that sounds like a
sensible thing.

> 1) The most expensive comparison is the first one,...

Yes. we keep the spanhash table across comparison.

> 2) This would only save us from at most N comparisons in the N x M
> matrix (since no file in this optimization is compared to more than
> one other)

True, but doesn't rename_src[] and rename_dst[] entries have the
original pathname, where you can see A.txt and some-module/A.txt
share the same filename part cheaply?  Is that more expensive than
comparing spanhash tables?

Having asked these, I do think it is not worth pursuing, especially
because I agree with Derrick that this "we see a new file whose name
is the same as the one deleted from a different directory, so if
they are similar enough, let's declare victory and not bother
finding a better match" needs to be used with higher similarity bar
than the normal one.  If -M60 says "only consider pairs that are
with at least 60% similarity index", finding one at 60% similarity
and stopping at it only because the pair looks to move a file from
one directory to another directory while retaining the same name,
rejecting other paring, feels a bit too crude a heuristics.  And if
we require higher similarity levels to short-circuit, the later full
matrix stage won't be helped with "we must have already rejected"
logic.  A.txt and some-module/A.txt may not have been similar enough
to short-circuit and reject others in the earlier part, but the
full-matrix part work at a lower bar, which may consider the pair
good enough to keep as match candidates.

Thanks.

