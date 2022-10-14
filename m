Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04B4CC433FE
	for <git@archiver.kernel.org>; Fri, 14 Oct 2022 20:23:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbiJNUXn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Oct 2022 16:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231444AbiJNUXm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2022 16:23:42 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEE971D584D
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 13:23:40 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 217A0146C3D;
        Fri, 14 Oct 2022 16:23:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=tyveJeXFQS2b
        T4p+kCnAbD21Io7bhiSK9n36//s2qwQ=; b=PfxPTLA7/Dv6ZmLGcdKtp4PQEGQa
        BWK32ku5wGmwK9cCJFTOGka04dJh3ekWPkDWk3ElC7lAJHRjV4jECDOpWOF+NnTy
        U9AUt6o5XPALV534QdyxLjMhkI6Zugz3PPueOGJ/uFaDUCo1SCksCJHOAQ4t0bcV
        0f+IJe4Vkvd/r+c=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 17158146C3C;
        Fri, 14 Oct 2022 16:23:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6F992146C39;
        Fri, 14 Oct 2022 16:23:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH v2] bisect--helper: plug strvec leak
References: <xmqqy1tunjgp.fsf@gitster.g>
        <221006.86a668r5mf.gmgdl@evledraar.gmail.com>
        <xmqqk05cipq8.fsf@gitster.g>
        <1965b54b-122a-c965-f886-1a7dd6afbfb4@web.de>
        <Y0TXTl0gSBOFQa9B@coredump.intra.peff.net>
        <xmqq35buykz1.fsf@gitster.g>
        <Y0VtkmNwjKcXcemP@coredump.intra.peff.net>
        <xmqqpmeyuvxt.fsf@gitster.g>
        <221011.86czayns5x.gmgdl@evledraar.gmail.com>
        <xmqq8rlmujcz.fsf@gitster.g>
        <Y0m8AU+Yf7PREI2E@coredump.intra.peff.net>
Date:   Fri, 14 Oct 2022 13:23:36 -0700
In-Reply-To: <Y0m8AU+Yf7PREI2E@coredump.intra.peff.net> (Jeff King's message
        of "Fri, 14 Oct 2022 15:44:01 -0400")
Message-ID: <xmqqczau888n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 159D8796-4BFE-11ED-9763-2AEEC5D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Tue, Oct 11, 2022 at 02:43:24PM -0700, Junio C Hamano wrote:
>
>> > -	if (run_command_v_opt(argv.v, RUN_GIT_CMD)) {
>> > +	if (run_command_opt_l(RUN_GIT_CMD, "-C", repo, "sparse-checkout",
>> > +			      "set", NULL)) {
>>=20
>> And this does give us protection from the "Programmers can give
>> unterminated list to run_command_v_opt() by mistake", which is not
>> really solved mechanically even if the list is prepared with the
>> strvec API (because the compiler has to be smart enough to know that
>> argv.v was prepared with proper use of the API), which is nice.
>
> Yeah, I agree this addresses the point I raised (which I am somewhat
> regretting raising, as IMHO it was not worth the amount of discussion
> that has ensued).
>
> Since nobody asked, my _real_ opinion is that I prefer Ren=C3=A9's orig=
inal
> that used an actual struct, and its auto-freeing strvec.

Yup, it was you who worried about forgotten NULL at the end, though
;-)
