Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 60B781F461
	for <e@80x24.org>; Wed, 28 Aug 2019 16:04:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbfH1QEJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Aug 2019 12:04:09 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54004 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726560AbfH1QEJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Aug 2019 12:04:09 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2E6CC87E8A;
        Wed, 28 Aug 2019 12:04:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Q1GmkSwi4l5lbSyGsL8u3QPuNyY=; b=mmT7u/
        SOlnuQNYu4YwVlNAhn8tKrsm/mFWMSqxaicfsEbZEk4xUHVAui0xwik+Zo2MsMpW
        MjrogVJCC/OjyhSjqt7ZEziz7KxTdMxBvGmsNgoHOdbUATumolcLrKL6CrPJo/vA
        d2AJTu0+Er5meKMr8l5+lv/4MjoZotZ3SjHwA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=yjmUxZKSs/0AJ1hhaqZl66U5IrGetuAV
        TnfbFVJYRI0ULV4TjgpJkszWFqv2ERdMjF6oGsapGZ7Ntkv2l0pxSU5AmLvkS7/3
        LK78T2ZNGjwfBm86l/RUejT0JqBFxw6zoft3ePY54UHmB5RKjhn+jpYpLHVrsBvs
        xmWGJR6mEpc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2663C87E89;
        Wed, 28 Aug 2019 12:04:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 45D4587E81;
        Wed, 28 Aug 2019 12:04:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Ben Wijen <ben@wijen.net>, git@vger.kernel.org,
        Pratik Karki <predatoramigo@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 1/1] rebase.c: make sure the active branch isn't moved when autostashing
References: <20190821182941.12674-1-ben@wijen.net>
        <20190826164513.9102-1-ben@wijen.net>
        <nycvar.QRO.7.76.6.1908281454070.46@tvgsbejvaqbjf.bet>
        <xmqqh8611eza.fsf@gitster-ct.c.googlers.com>
Date:   Wed, 28 Aug 2019 09:03:58 -0700
In-Reply-To: <xmqqh8611eza.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 28 Aug 2019 08:34:01 -0700")
Message-ID: <xmqq8srd1dld.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 735587B6-C9AD-11E9-AA2D-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> IIUC, the bug is twofold:
> ...
>  - A message is given only when the above happens.  When rebasing
> ...
>    That "reset --hard" is done only to clean the index and the
>    working tree and talking about "HEAD is now..." is a bug in its
>    context.

Actually, this "latter" bug can further be split into two

 * The "HEAD is now" is given only when autostash feature needs to
   clean the working tree, and we have never moved HEAD anyway.

 * The message does not indicate what we are rebuilding on top of.

and dealt with separately, so with that in mind the step that would
follow the first patch, i.e.

> ... update
> this patch to add logic to give a pointless and misleading "HEAD is
> now at..." message so that we will report the location of HEAD where
> the "rebase --autostash" command started at, to fix only the first
> bug.

may become different.  The fact that the "HEAD is now..." is given
only when autostash actually happens _might_ be taken as a feature
by some users---the location of HEAD reported by the message is
irrelevant to them (we know that as a fact---we have been reporting
a wrong commit all along anyway), but the single-bit "we got a
message" is a signal that "--autostash" had something valuable to
save.

So the second step may be to replace the "HEAD is now..." message we
add back (relative to Ben's patch under discussion) to the first
patch with a more direct "stashed away your local changes" message
(perhaps with diffstat???  I do not care about the details, as we
are talking about resurrecting one single useful bit of information
and extending it futher is beyond the scope of this analysis).

And the last point, i.e. "First, rewinding head to replay your
work..." does not give enough information to be truly useful, is a
totally separate bug (that Ben's patch does not even mention or
attempt to address), so we can leave it out of this analysis, too.

So, yeah, if we are to spend extra effort to polish Ben's patch
further while keeping the "fix things without making unnecessary
changes", I think the approach that takes least amount of effort may
not to make the code manually say "Head is at ...", but to add a new
message to report that autostash happened.  That fixes two bugs
(i.e. the original bug, and the "we autostashed" bit is reported in
a roundabout and misleading way via "HEAD is now at ...") in a
single patch ;-)

