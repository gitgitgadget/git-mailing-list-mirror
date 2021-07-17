Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A19E2C12002
	for <git@archiver.kernel.org>; Sat, 17 Jul 2021 01:28:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A8DD613E8
	for <git@archiver.kernel.org>; Sat, 17 Jul 2021 01:28:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231899AbhGQBbE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Jul 2021 21:31:04 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62686 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbhGQBbE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jul 2021 21:31:04 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E43E6E293A;
        Fri, 16 Jul 2021 21:28:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=EfM7+s1ePMo7
        jwlwWlb4MgUbfSCuGnY20gwLm4WecXM=; b=vGm510xKWFjlsR4gGnN8gbvp3JVo
        Won8RiqqSZOgluWvmi0UrqI2qYfMeBlsjyEe2+l5hmiD7PZ0SwsiOxwK2XGELslP
        3ff2utUEM87IEsGSS3B/JpMWMpiygr59EoINtigD/7lhE4Ch0CQCRe2zsBKx6RMH
        L/21vF12gFmpRhQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CE213E2939;
        Fri, 16 Jul 2021 21:28:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 43DBAE2938;
        Fri, 16 Jul 2021 21:28:07 -0400 (EDT)
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
Date:   Fri, 16 Jul 2021 18:28:06 -0700
In-Reply-To: <YO/EpxU0NG+HVSlx@coredump.intra.peff.net> (Jeff King's message
        of "Thu, 15 Jul 2021 01:16:23 -0400")
Message-ID: <xmqqk0lppw49.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 3D527B1E-E69E-11EB-82C4-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Thu, Jul 15, 2021 at 02:02:40AM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason wrote:
>
>> > Maybe that is splitting hairs, but I definitely try to err on the si=
de
>> > of caution and over-analysis when touching tricky code (and the
>> > ref-backend code is in my experience one of the trickiest spots for
>> > corner cases, races, etc).
>>=20
>> I'd entirely forgotten about this, but I had a patch to remove that
>> "oid" call entirely, as it's really an unrelated bug/undesired behavio=
r
>>=20
>> You also looked at it at the time & Michael Haggerty reviewed it:
>> https://lore.kernel.org/git/20190315155959.12390-9-avarab@gmail.com/
>>=20
>> The state of that patch was that I needed to get to some minor issues
>> with it (commit message rewording, cleaning up some related callers),
>> but the fundamental approach seemed good.
>>=20
>> I then split it off from the v4 of that series to get the non-tricky
>> changes in:
>> https://lore.kernel.org/git/20190328161434.19200-1-avarab@gmail.com/
>>=20
>> I then just never got to picking it up again, I'll probably re-roll it=
 &
>> make it a part of this series, then we can remove this whole OID !=3D =
NULL
>> case and will be sure nothing fishy's going on.
>
> Yeah, that sounds like a good path forward. I do think the patch under
> discussion here is probably the right thing to do. But it becomes all
> the more obvious if lock_ref_oid_basic() ends up dropping that paramete=
r
> entirely.

OK, so what's the final verdict on this step?  It is unfortunate
that when =C3=86var took over a topic from Han-Wen, this patch has been
inserted as the very first step before the patches in the series, so
until we know we are happy with it, it takes several other patches
hostage.

Thanks.
