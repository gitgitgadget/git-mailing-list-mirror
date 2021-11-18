Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F38E3C433EF
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 19:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9BD861AD2
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 19:00:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231905AbhKRTDe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Nov 2021 14:03:34 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50786 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231825AbhKRTD3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Nov 2021 14:03:29 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4E9991023D7;
        Thu, 18 Nov 2021 14:00:27 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=84mxf3ZapOfQQ2MZG8X5VWWbUdzbaX75UTW+CO
        0d3RM=; b=rmcyvFKKJd1jdq2/q7OcwjmlYhLHGbdpk8XNtMtiSQR31pChvXl1Bv
        HrmO8WfyX7ZYuw0ogNG+EhHy2Molm5nJ6LTSzM17ULP862plKij9kTNZpTaxapeB
        N530miSFfx+wLiVtA4TjnhtLqcg+8B6EuBKE2wvSgOrqVKhfHCXBo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 426C01023D6;
        Thu, 18 Nov 2021 14:00:27 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 902331023D3;
        Thu, 18 Nov 2021 14:00:26 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Neeraj Singh <nksingh85@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git List <git@vger.kernel.org>, Patrick Steinhardt <ps@pks.im>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Eric Wong <e@80x24.org>, Christoph Hellwig <hch@lst.de>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: RFC: A configuration design for future-proofing fsync()
 configuration
References: <211110.86r1bogg27.gmgdl@evledraar.gmail.com>
        <20211111004724.GA839@neerajsi-x1.localdomain>
        <211111.86pmr7pk9o.gmgdl@evledraar.gmail.com>
        <CANQDOdcdhfGtPg0PxpXQA5gQ4x9VknKDKCCi4HEB0Z1xgnjKzg@mail.gmail.com>
Date:   Thu, 18 Nov 2021 11:00:25 -0800
In-Reply-To: <CANQDOdcdhfGtPg0PxpXQA5gQ4x9VknKDKCCi4HEB0Z1xgnjKzg@mail.gmail.com>
        (Neeraj Singh's message of "Wed, 17 Nov 2021 14:16:35 -0800")
Message-ID: <xmqq35ntxp9y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CA8332B6-48A1-11EC-A399-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Neeraj Singh <nksingh85@gmail.com> writes:

> After sleeping on it for a while, I'm willing to consolidate the
> configuration along the lines that you've specified, but I'd like to
> reduce the number of degrees of freedom.
>
> My proposal in Documentation form:
>
> core.fsync::
> A comma-separated list of parts of the repository which should be hardened by
> calling fsync when created or modified. When an aggregate option is
> specified, a subcomponent can be overriden by prefixing it with a '-'. For
> example, `core.fsync=all,-index` means "fsync everything except the index".
> Items which are not fsync'ed may be lost in the even of an unclean system
> shutdown. This setting defaults to `objects,-loose-objects`
> +
> * `loose-objects` hardens objects added to the repo in loose-object form.
> * `packs` hardens objects added to the repo in packfile form and the related
>   bitmap and index files.
> * `commit-graph` hardens the commit graph file.
> * `refs` (future) hardens references when they are modified.
> * `index` (future) hardens the index when it is modified.
> * `objects` is an aggregate option that includes `loose-objects`, `packs`, and
>   `commit-graph`.
> * `all` is an aggregate option that syncs all individual components above.
> * `none` is an aggregate option that disables fsync completely.

I wasn't closely following the discussion at all, but the above
simplification may still even be too fine-grained?  For example,
what does it mean to care less about the robustness of loose objects
than packs or ref updates?  How does an existing fine-grained
classification interact with new classes of filesystem entity we
will introduce under .git in the future?  Imagine that we didn't
have .midx and multi-pack bitmap yet; since 'loose-objects',
'packs', and 'commit-graph' are the only three groups we can choose
to place any "objects and reachability" related data in, we need to
pick one, and choosing 'packs' class may be the choice of least
resistance, the default kitchen-sync category for anything related
to "object".  Or just like 'commit-graph' has its own category,
would we invent a new class and call it 'multi-pack'?

I cannot shake the feeling that these are making everything
unnecessarily complex and adding more things that we need to explain
to the end-user---and the worst part is I doubt it would help the
end-users very much tot understand what gets explained.

> core.fsyncMethod::
> A value indicating the strategy Git will use to harden repository data using
> fsync and related primitives.
> +
> * 'default' uses the fsync(2) system call or platform equivalents.
> * 'batch' uses APIs such as sync_file_range or equivalent to reduce the number
>   of hardware FLUSH CACHE requests sent to the storage hardware.
> * 'writeout-only' (future) issues requests to send the writes to the storage
> * hardware, but does not send any FLUSH CACHE request.
> * 'syncfs' (future) uses the syncfs API, where available, to sync all of the
>   files on the same filesystem as the Git repo.

How would an end-user choose among these?  If they assume that the
version of Git they use is bug-free, is there a reason why they
should ever pick 'default' over 'batch', for example?  Shouldn't we
be the one to choose the best approach on the underlying filesystem
for the users, instead of forcing them to choose?

As implementors, these choices may be of interest and give you a
handy way to compare different design, but I am not sure if we want
to give anything more complex than a binary choice, "default" and
"eatmydata".

> core.fsyncObjectFiles::
> If `true`, this legacy setting is equivalent to `core.fsync=objects`. If
> `core.fsync` is explicitly specified, then this setting is ignored.

I think deprecating this very-specific knob is a good idea,
regardless of how complex we'd want to make the alternative.

Thanks.
