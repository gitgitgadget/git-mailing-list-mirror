Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C093C47095
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 07:47:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03BBA61361
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 07:47:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235564AbhFIHtg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Jun 2021 03:49:36 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50079 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234871AbhFIHtf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jun 2021 03:49:35 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EFA9D134F7A;
        Wed,  9 Jun 2021 03:47:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=RC0NyhKRtWR6xMGN3ePhe1cdh+B+e76d3w/I4M
        FfP9k=; b=cgboc9nuJHioQA9IJuo98ZOM8N21SgAFYy0N74HwIQ4LyQlH25b5pZ
        JXNadSB+0NHpCBukBZ0uGBPdWORYa3syD8efmIsem+5MJp8BeJN+7KTtUkS9KHmX
        vX5vJtpEX9r3UCT1qCuRc0nYMaPxr0hZJRlsWFmEkOFrPG4gR0560=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E8494134F79;
        Wed,  9 Jun 2021 03:47:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2B583134F76;
        Wed,  9 Jun 2021 03:47:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Greg Hurrell" <greg@hurrell.net>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH] gitweb: use HEAD as primary sort key in
 git_get_heads_list()
References: <f04ffea4-ff37-432a-a0c6-abe11721060b@www.fastmail.com>
        <20210608211440.37985-1-greg@hurrell.net> <xmqqpmwvnbaz.fsf@gitster.g>
        <26dbf49f-4972-4960-9383-2b69a3e6043c@www.fastmail.com>
Date:   Wed, 09 Jun 2021 16:47:36 +0900
In-Reply-To: <26dbf49f-4972-4960-9383-2b69a3e6043c@www.fastmail.com> (Greg
        Hurrell's message of "Wed, 09 Jun 2021 09:38:16 +0200")
Message-ID: <xmqqpmwviinb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F622EA36-C8F6-11EB-9562-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Greg Hurrell" <greg@hurrell.net> writes:

> One thing I do notice is that there is already a `current_head` CSS
> class applied to the corresponding row, so it would be possible for the
> gitweb owner to make tha row stand out however they pleased.
>
> In short, I am happy to amend the commit message but I fear the
> rationale for it is a bit weak. If nobody chimes in with a resounding
> endorsement, I am inclined to probably drop it.
>
>> Wasn't your motivating example about tiebreaking between 'main' and
>> 'master' that always point at the same commit?
>
> Yes indeed, that was the original motivation, although after the fix
> in 7c5045fc180ed09ed4cb5 the tie-breaking by refname already has the
> equivalent desired effect, albeit coincidentally.
>
> Perhaps the sort keys _should_ be `-committerdate`, then `-HEAD`, then
> `refname` (implicit default); ie. `--sort=-HEAD --sort=-committerdate`
> (which is the opposite order to what I have in the patch). I would have
> prepared the patch in that way in the first place if my testing hadn't
> been confounded by the fact that I was running an older version of Git
> on the installation where I was trying it out.
>
> I feel the argument for using `HEAD` as a tiebreaker is easier to make
> than the case for using it as a primary sort key, because it is a less
> invasive change. If there is support for that idea, I'll tweak the
> patch.

I agree that using HEADness as a tiebreaker is a much easier sell.

Another idea would be to give site administrators (or even to the
end users via UI) an option to tweak how they are sorted.
