Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12C37C433B4
	for <git@archiver.kernel.org>; Thu,  6 May 2021 01:32:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB693613C1
	for <git@archiver.kernel.org>; Thu,  6 May 2021 01:32:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbhEFBdR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 May 2021 21:33:17 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50386 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229465AbhEFBdR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 May 2021 21:33:17 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8695ED3862;
        Wed,  5 May 2021 21:32:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/2ceqBAlnzF1+jjQwr6wJd4lkFJKL9YnELWjkF
        i3P48=; b=eiYEe66C7tE4UQrjkBIS/BcakzPxVXWZ+iP9a9+m7RI7F1vOeDTv1u
        davjywZ3tw1pHeZDrWOJyRQINTaHLqR4vDYSZWUFR+mUaaruOKydSSE2c11Bmz2e
        zpbhoTCA79rvIj4D6UWLupoOrUS34Z+R4uKLd0MWujbUMAmCO6SJw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7DFFDD3861;
        Wed,  5 May 2021 21:32:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 07F17D3860;
        Wed,  5 May 2021 21:32:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 1/2] patience diff: remove unnecessary string comparisons
References: <pull.948.git.1620120345.gitgitgadget@gmail.com>
        <a339d1cf9b9ffd6365fca3efda8fb7e10346dda4.1620120345.git.gitgitgadget@gmail.com>
        <xmqqpmy658e1.fsf@gitster.g>
        <nycvar.QRO.7.76.6.2105051649280.50@tvgsbejvaqbjf.bet>
Date:   Thu, 06 May 2021 10:32:18 +0900
In-Reply-To: <nycvar.QRO.7.76.6.2105051649280.50@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Wed, 5 May 2021 16:58:38 +0200 (CEST)")
Message-ID: <xmqqo8do1wbh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E5A2AC0C-AE0A-11EB-A9DC-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Right. I had the same concern. But it does look as if
> `xdl_classify_record()` replaced the possibly non-unique hash values to
> unique sequential identifiers.
>
> I have to admit that the code is unnecessarily hard to read for me:
> https://github.com/git/git/blob/v2.31.1/xdiff/xprepare.c#L110-L157
>
> But I do gather that the loop at
> https://github.com/git/git/blob/v2.31.1/xdiff/xprepare.c#L119-L123
> is called for every line, that it does compare it to every seen line with
> the same hash, and that it exits the loop early if the contents disagree:
>
> 	for (rcrec = cf->rchash[hi]; rcrec; rcrec = rcrec->next)
> 		if (rcrec->ha == rec->ha &&
> 				xdl_recmatch(rcrec->line, rcrec->size,
> 					rec->ptr, rec->size, cf->flags))
> 			break;

Yeah, I arrived at the same conclusion.  Also as Phillip said in a
separate message, Myers side already takes advantage of this same
fact, so I am fine with this change.

Thanks, both.
