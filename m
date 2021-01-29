Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 826F8C433DB
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 03:22:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F00064DFB
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 03:22:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbhA2DWH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jan 2021 22:22:07 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64286 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231517AbhA2DV5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jan 2021 22:21:57 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 34394FD040;
        Thu, 28 Jan 2021 22:21:14 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=MEJB+rk3h4dD8zW/6RFKGz8GQOc=; b=IeX92O
        c9AxH1D3Wua9DZb8dPluHhrH99YWKMuYJsqdkBVwGwl4sJYtZs5WPtwUVlr6A9xX
        /rMpqzo76z8oyDQPwJzzY6WJBZ/Oxkfl36SXuaIchyaiwRIFsx29j+TBuIUuh6cu
        62gs/e/QIeYza8JsE0ldGuDAaVWuvRObSF1CI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=G2A4HJoldAvIrZ7hOMvH4UpNFfuLC5fQ
        F+CxUiz2NCBPqExdPR9eSfp5TICCZKg1g7zJHZhdiKCwd6HCvAIqKXyk2cn9NK5b
        mEdJTFDyaVrzNFwCYm9/uW9U96GmFLnDUP/3thAG1GfKxvmMKv+cipOaT0M/kUdO
        cVUhs+GLF+U=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2BE5AFD03E;
        Thu, 28 Jan 2021 22:21:14 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 706BBFD03D;
        Thu, 28 Jan 2021 22:21:11 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net, dstolee@microsoft.com
Subject: Re: [PATCH 03/10] builtin/pack-objects.c: learn
 '--assume-kept-packs-closed'
References: <cover.1611098616.git.me@ttaylorr.com>
        <2da42e9ca26c9ef914b8b044047d505f00a27e20.1611098616.git.me@ttaylorr.com>
Date:   Thu, 28 Jan 2021 19:21:09 -0800
In-Reply-To: <2da42e9ca26c9ef914b8b044047d505f00a27e20.1611098616.git.me@ttaylorr.com>
        (Taylor Blau's message of "Tue, 19 Jan 2021 18:24:08 -0500")
Message-ID: <xmqqk0rwtom2.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 09321CE6-61E1-11EB-8D3C-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> Teach pack-objects an option to imply the revision machinery's new
> '--no-kept-objects' option when doing a reachability traversal.
>
> When '--assume-kept-packs-closed' is given as an argument to
> pack-objects, it behaves differently (i.e., passes different options to
> the ensuing revision walk) depending on whether or not other arguments
> are passed:
>
>   - If the caller also specifies a '--keep-pack' argument (to mark a
>     pack as kept in-core), then assume that this combination means to
>     stop traversal only at in-core packs.
>
>   - If instead the caller passes '--honor-pack-keep', then assume that
>     the caller wants to stop traversal only at packs with a
>     corresponding .keep file (consistent with the original meaning which
>     only refers to packs with a .keep file).
>
>   - If both '--keep-pack' and '--honor-pack-keep' are passed, then
>     assume the caller wants to stop traversal at either kind of kept
>     pack.

If there is an out-of-band guarantee that .kept packs won't refer to
outside world, then we can obtain identical results to what existing
--honor-pack-keep (which traverses everything and then filteres out
what is in .keep pack) does by just stopping traversal when we see
an object that is found in a .keep pack.  OK, I guess that it
answers the correctness question I asked about [02/10].

It still is curious how we can safely "assume", but presumably we
will see how in a patch that appears later in the series.

How "closed" are these kept packs supposed to be?  When there are
two .keep packs, should objects in each of the packs never refer to
outside their own pack, or is it OK for objects in one kept pack to
refer to another object in the other kept pack?  Readers and those
who want to understand and extend this code in the future would need
to know what definition of "closed" you are using here.

Thanks.
