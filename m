Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4962C432BE
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 06:01:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AADC6023F
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 06:01:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231501AbhH0GCR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Aug 2021 02:02:17 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55871 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbhH0GCQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Aug 2021 02:02:16 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A8C0ED8A79;
        Fri, 27 Aug 2021 02:01:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=kE4yJuBHn+3l1O3jOH261Yp+oDCBY+oye+w6TL
        GOdBg=; b=g5DLIKfy+96PR1R4ihmvczM4AWhM/txL6f3Z0CBI98UI8kFiStEwOk
        mX3TiTd8fzSzib4qLh3xPfgYOP7SIiwXzYhvvbzy0WEo2/8/2h2PGkIi1/b6/HQE
        qT9vYrhrwXkD9e0ltoYnrBjGFTZ943SXwQueuiqVbvDRKV5I9lwBg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A0876D8A77;
        Fri, 27 Aug 2021 02:01:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2D85BD8A76;
        Fri, 27 Aug 2021 02:01:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net, dstolee@microsoft.com,
        jonathantanmy@google.com
Subject: Re: [PATCH v4 05/25] midx: clear auxiliary .rev after replacing the
 MIDX
References: <cover.1617991824.git.me@ttaylorr.com>
        <cover.1629821743.git.me@ttaylorr.com>
        <771741844be3570395abfda813ed5ef2fa78332e.1629821743.git.me@ttaylorr.com>
        <xmqqa6l6oafd.fsf@gitster.g> <YSVX18UXh9vX+Zhp@nand.local>
        <xmqqr1eimtrp.fsf@gitster.g> <YSVjnSDaBXgXvT9W@nand.local>
        <xmqq35qymrcn.fsf@gitster.g> <xmqqy28qlcow.fsf@gitster.g>
        <YSVuUYFh7lmhNlEy@nand.local>
Date:   Thu, 26 Aug 2021 23:01:26 -0700
In-Reply-To: <YSVuUYFh7lmhNlEy@nand.local> (Taylor Blau's message of "Tue, 24
        Aug 2021 18:10:25 -0400")
Message-ID: <xmqqo89jbf49.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 375D1E20-06FC-11EC-8773-D601C7D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> On Tue, Aug 24, 2021 at 03:06:55PM -0700, Junio C Hamano wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>> > FWIW, here is what I have somewhere in 'seen' where two topics meet.
>>
>> Oops, one change missed.
>
> Thanks; that matches my own resolution. I noticed that it does fail the
> new test in t5319, since writing a MIDX wants to make sure that we are
> only touching an alternate's object directory (which will fail if we are
> running `git multi-pack-index` from outside of a repository).
>
> My opinion is that we should require being inside of a repository to run
> the MIDX builtin. Otherwise we're allowing that command to modify any
> old MIDX, which doesn't make sense.
>
> I think we probably need a single unifying topic, so I'm happy if you
> want to discard one of our two topics from seen in the meantime.

It seems that the *.rev test (probably added by the other topic that
is a single patch fix) fails under sha256 hash.  I am not going to
dig it any further myself, but for the interested, CI breakage is
here:

  https://github.com/git/git/runs/3440068613?check_suite_focus=true#step:5:1219

Thanks.

