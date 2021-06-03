Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B3F2C47096
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 22:29:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 588C461402
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 22:29:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbhFCWav (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Jun 2021 18:30:51 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62182 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbhFCWav (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Jun 2021 18:30:51 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B3445CB874;
        Thu,  3 Jun 2021 18:29:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=MIEslBfbRnjV
        OHPKikW6+Mq9+ijF1XfOWA3w7otgQgE=; b=emLQIaPJlTkvdx2IHZLzmdRjjt1F
        zf2JctDnNTCqrzaCllPc63jskcIuQOyU2UoATh/aHuyLWg4+Tg9uHbykg+gKn+gD
        +Rzc00SLCDWxFBXLcfzDbQQTl8HNvT0aXZCkQH3imszE1VhjJb2qpA+5fD5akLjK
        +/+KgB4VH1Lk/DQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A1BF0CB872;
        Thu,  3 Jun 2021 18:29:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0BE88CB870;
        Thu,  3 Jun 2021 18:29:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
Subject: Re: [PATCH v9 07/37] hook: add 'run' subcommand
References: <20210527000856.695702-1-emilyshaffer@google.com>
        <20210527000856.695702-8-emilyshaffer@google.com>
        <875yyv71lz.fsf@evledraar.gmail.com>
Date:   Fri, 04 Jun 2021 07:29:03 +0900
In-Reply-To: <875yyv71lz.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Thu, 03 Jun 2021 11:07:29 +0200")
Message-ID: <xmqqeedi4m6o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 1AB2EF80-C4BB-11EB-872F-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Wed, May 26 2021, Emily Shaffer wrote:
>
>> +void run_hooks_opt_init(struct run_hooks_opt *o)
>> +{
>> +	strvec_init(&o->env);
>> +	strvec_init(&o->args);
>> +	o->run_hookdir =3D configured_hookdir_opt();
>> +}
>
> I suggested in
> https://lore.kernel.org/git/87y2bs7gyc.fsf@evledraar.gmail.com/ that
> this could and should be a RUN_HOOKS_OPT_INIT
>
> After some digging I see that was the case in an earlier version of you=
r
> series, i.e. before:
> https://lore.kernel.org/git/20210131042254.1032233-1-jonathantanmy@goog=
le.com/
>
> You came up with this current pattern because of
> configured_hookdir_opt().
>
> But a better option here is to use a RUN_HOOKS_OPT_INIT still and just
> defer the initialization of this "run_hookdir" member. I.e. set it to
> "we have not asked the config yet" in the initializer. I.e. the diff on
> top your series at the end of this E-Mail[1].

When I compared the result of applying your 31-patch series to
2.32-rc2 and the result of rebasing this series on the same base,
before sending out a responce to Emily's reaction, I found that the
31-patch series did a good job of not stepping on the "hook defined
with configuration" part and concentrated on providing a clean base
to build on with a better structure in the series, and there weren't
many changes that overlapped with Emily's series in a significant
way.  The above was one of the "overlapping" differences that stood
out.

Thanks.



