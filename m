Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1761DC433F5
	for <git@archiver.kernel.org>; Tue, 11 Oct 2022 05:42:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbiJKFm5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Oct 2022 01:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiJKFm4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2022 01:42:56 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB0B27B79E
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 22:42:46 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 303961CF94D;
        Tue, 11 Oct 2022 01:42:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ytag7k2mHsjW
        wrn6nwNdWlhojpYyQ4w/0s4U2rXvJ8Y=; b=VgmaInbCacdSRjbJ3Y5meD32rBI3
        xQ67IR+dR/H15LQhieTNMroUDqxCElMzZnSAXkYXZ5HU1LKR7ThvyijS+62rSWUZ
        oeDxjqeGf0jAJhrQq7lTf8ErWTxi3dzOXuBvju7Rx5UndQhk+0aeb+YuZ965O96H
        joaVTSIb2tXHcw0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 283C71CF94C;
        Tue, 11 Oct 2022 01:42:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 5CFAC1CF94B;
        Tue, 11 Oct 2022 01:42:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        =?utf-8?B?w4Z2YXIgQXJu?= =?utf-8?B?ZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>, Git List <git@vger.kernel.org>
Subject: Re: [PATCH v2] bisect--helper: plug strvec leak
References: <5c6a4c30-d454-51b6-ec57-9af036b9c4e0@web.de>
        <221005.8635c2u3k5.gmgdl@evledraar.gmail.com>
        <xmqqy1tunjgp.fsf@gitster.g>
        <221006.86a668r5mf.gmgdl@evledraar.gmail.com>
        <xmqqk05cipq8.fsf@gitster.g>
        <1965b54b-122a-c965-f886-1a7dd6afbfb4@web.de>
        <Y0TXTl0gSBOFQa9B@coredump.intra.peff.net>
Date:   Mon, 10 Oct 2022 22:42:42 -0700
In-Reply-To: <Y0TXTl0gSBOFQa9B@coredump.intra.peff.net> (Jeff King's message
        of "Mon, 10 Oct 2022 22:39:10 -0400")
Message-ID: <xmqq35buykz1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 86E33F42-4927-11ED-A728-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Fri, Oct 07, 2022 at 05:08:42PM +0200, Ren=C3=A9 Scharfe wrote:
>
>> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
>> index 501245fac9..28ef7ec2a4 100644
>> --- a/builtin/bisect--helper.c
>> +++ b/builtin/bisect--helper.c
>> @@ -765,11 +765,10 @@ static enum bisect_error bisect_start(struct bis=
ect_terms *terms, const char **a
>>  		strbuf_read_file(&start_head, git_path_bisect_start(), 0);
>>  		strbuf_trim(&start_head);
>>  		if (!no_checkout) {
>> -			struct strvec argv =3D STRVEC_INIT;
>> +			const char *argv[] =3D { "checkout", start_head.buf,
>> +					       "--", NULL };
>>=20
>> -			strvec_pushl(&argv, "checkout", start_head.buf,
>> -				     "--", NULL);
>> -			if (run_command_v_opt(argv.v, RUN_GIT_CMD)) {
>> +			if (run_command_v_opt(argv, RUN_GIT_CMD)) {
>
> This is OK with me, but note that one thing we lose is compiler
> protection that we remembered the trailing NULL pointer in the argv
> array (whereas strvec_pushl() has an attribute that makes sure the last
> argument is a NULL).

The first parameter to run_command_v_opt() must be a NULL terminated
array of strings.  argv.v[] after strvec_push*() is such a NULL
terminated array, and is suitable to be passed to the function.

That much human programmers would know.

But does the compiler know that run_command_v_opt() requires a NULL
terminated array of strings, and does it know to check that argv.v[]
came from strvec_pushl() without any annotation in the first place?

For such a check to happen, I think we need to tell the compiler
with some annotation that the first parameter to run_command_v_opt()
is supposed to be a NULL terminated char *[] array.

In the code before the patch, strvec_pushl() is annotated to require
the last arg to be NULL, but without following data/control flow, it
may not be clear to the compiler that argv.v[] will be NULL terminated
after the function returns.  If the compiler is sufficiently clever
to figure it out, with the knowledge that run_command_v_opt() must
be given a NULL terminated array of strings, we do have compiler
protection to make the run_command_v_opt() safe.

But if the code tells the compiler that run_command_v_opt() must be
given a NULL terminated array of strings, it is obvious that the
array passed by the code after the patch, i.e. argv[], is NULL
terminated, and the compiler would be happy, as well.

> Probably not that big a deal in practice. It would be nice if there was
> a way to annotate this for the compiler, but I don't think there's any
> attribute for "this pointer-to-pointer parameter should have a NULL at
> the end".

But the code before this patch is safe only for strvec_pushl() call,
not run_command_v_opt() call, so we are not losing anything, I would
think.

