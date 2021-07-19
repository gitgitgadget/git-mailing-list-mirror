Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 879CEC07E9B
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 15:44:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B83361363
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 15:44:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239333AbhGSPDg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Jul 2021 11:03:36 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55864 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345353AbhGSPBw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jul 2021 11:01:52 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5E39CDD15F;
        Mon, 19 Jul 2021 11:42:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=1w2wZTXxIxMx
        3vq9DTOCRIp6Xvmt7ZrQu83iuXaOKkg=; b=SLGiWpsYhUL6hz20CY5HF13kQonj
        I8ExTUxo0Ui9kk6VxMteS7rBehScX6qavXVAYZvODq+yrCqyKt2AJmSKqIxPM0Gx
        Fq2g8t+zXwtgSKMpcCTlxZhG1PS2yiPVOVN6g75ACZmZze8OwqCWSc858bSHC8C8
        Se9RrLd/BIhQWVY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 55336DD15E;
        Mon, 19 Jul 2021 11:42:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CCF79DD15B;
        Mon, 19 Jul 2021 11:42:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] refs file backend: remove dead "errno == EISDIR" code
References: <patch-1.1-de0838fe99-20210714T111351Z-avarab@gmail.com>
        <YO8PBBJZ2Q+5ZqFs@coredump.intra.peff.net>
        <871r801yp6.fsf@evledraar.gmail.com>
        <YO9wCqetxHii+TvK@coredump.intra.peff.net>
        <875yxczbd6.fsf@evledraar.gmail.com>
        <YO/EpxU0NG+HVSlx@coredump.intra.peff.net>
        <xmqqk0lppw49.fsf@gitster.g>
        <YPJBY8LjiwYRyDOu@coredump.intra.peff.net>
Date:   Mon, 19 Jul 2021 08:42:29 -0700
In-Reply-To: <YPJBY8LjiwYRyDOu@coredump.intra.peff.net> (Jeff King's message
        of "Fri, 16 Jul 2021 22:33:07 -0400")
Message-ID: <xmqqo8aynwd6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: ED041634-E8A7-11EB-927A-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Fri, Jul 16, 2021 at 06:28:06PM -0700, Junio C Hamano wrote:
>
>> >> I then just never got to picking it up again, I'll probably re-roll=
 it &
>> >> make it a part of this series, then we can remove this whole OID !=3D=
 NULL
>> >> case and will be sure nothing fishy's going on.
>> >
>> > Yeah, that sounds like a good path forward. I do think the patch und=
er
>> > discussion here is probably the right thing to do. But it becomes al=
l
>> > the more obvious if lock_ref_oid_basic() ends up dropping that param=
eter
>> > entirely.
>>=20
>> OK, so what's the final verdict on this step?  It is unfortunate
>> that when =C3=86var took over a topic from Han-Wen, this patch has bee=
n
>> inserted as the very first step before the patches in the series, so
>> until we know we are happy with it, it takes several other patches
>> hostage.
>
> I just read through v2. Modulo a few small nits (mostly typos, but a fe=
w
> commit message suggestions), it looks good to me. I agree it's a lot to
> stick in front of another set of patches, but I think in this case we
> can proceed quickly enough to make it worth doing in the order =C3=86va=
r
> suggests.

I did not check the v2 thouroughly myself, but read it enough to
convince me that it would be good preliminary clean-up steps to come
before the main series (modulo typoes and nits, as you pointed out).

Thanks.
