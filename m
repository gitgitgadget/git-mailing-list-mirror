Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0F80C4338F
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 17:44:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D67B610C7
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 17:44:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231544AbhHWRpY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Aug 2021 13:45:24 -0400
Received: from mout02.posteo.de ([185.67.36.66]:45713 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230174AbhHWRpY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Aug 2021 13:45:24 -0400
Received: from submission (posteo.de [89.146.220.130]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 6CB1E240105
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 19:44:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1629740679; bh=JzDlByCLNa50azyrycxhqsasZEtcD1chUjxzIg5NA/k=;
        h=Date:From:To:Cc:Subject:From;
        b=AnZcp7Y9e3tF1skp1F1NRiXTA6/WCUQJF9hbzjf7ORC4RBM5ghOVj/eLYaY9oiAww
         fj1+BsV2BvicspKHD3/o5SE8jBr3y3Ve1CTOYfR3MqLNL2oyOKJtEcNNj3ET2MOdvT
         6SrH3Ea9jCJZEjTVli0SYVWUPcSc7f1jk0QGXWFNL915hCZoeQ9pptrkZIr/aPMuG7
         x91/1Bchx/jOOu9Rqoi3McLnpRrLhwz5TLxj9cH5RaB9JpnnKC3BIKMH5Y0Ym5907U
         2rSAhb20bE0Mwp93PKNeiHw6XrxjmbCRAxCEbhIfwz0YpXNX8+MTMg7vrhggJKDa5S
         l2Hs9PeULO+CQ==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4Gtfks1tysz6tmB;
        Mon, 23 Aug 2021 19:44:37 +0200 (CEST)
Date:   Mon, 23 Aug 2021 17:44:32 +0000 (UTC)
From:   =?UTF-8?Q?Marvin_H=C3=A4user?= <mhaeuser@posteo.de>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Message-ID: <5cd5a58b-ac9e-4628-a8d3-836b1f795732@posteo.de>
In-Reply-To: <YSPOOGxTMEgStdjJ@coredump.intra.peff.net>
References: <4db7759c-2123-533b-9f89-954c07f5832a@posteo.de> <YSPOOGxTMEgStdjJ@coredump.intra.peff.net>
Subject: Re: [BUG] send-email propagates "In-Reply-To"
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <5cd5a58b-ac9e-4628-a8d3-836b1f795732@posteo.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


23.08.2021 18:35:14 Jeff King <peff@peff.net>:

> On Sun, Aug 22, 2021 at 09:24:12AM +0000, Marvin H=C3=A4user wrote:
>
>> "git send-email" propagates the "In-Reply-To" header of the last prior p=
atch
>> with such defined to subsequent patches which do not define such explici=
tly.
>> I suspect this behaviour is incorrect as I could not find any documentat=
ion
>> on this. I'm sorry if this behaviour is actually expected, and would be
>> happy if someone could point me to the appropriate documentation. This w=
as
>> reproduced on Fedora 34 with git 2.33.0 and "--no-thread".
>>
>> Steps to reproduce:
>> 1. Create two patches, one of which has an "In-Reply-To" field
>> ("patch-in-reply.patch") and one of which does not
>> ("patch-no-in-reply.patch").
>> 2. Run "git send-email --dry-run --no-thread patch-in-reply.patch
>> patch-no-in-reply.patch"
>> 2.1. Observe the emission of an "In-Reply-To" header for
>> "patch-no-in-reply.patch" with no such header.
>> 3. Run "git send-email --dry-run --no-thread patch-no-in-reply.patch
>> patch-in-reply.patch"
>> 3.1. Observe the omission of an "In-Reply-To" header for
>> "patch-no-in-reply.patch" with no such header.
>>
>> Expected behaviour:
>> With no threading and no other sorts of explicitly defining the
>> "In-Reply-To" header, I expect to always observe the behaviour of 3.1., =
and
>> to not observe the behaviour of 2.1.
>
> Yes, I think this is just a bug. If the user requested --no-thread, then
> we should be sending each patch as it appears on disk, with no
> modification to the in-reply-to header.

OK, thank you.

>
>> The "issue" is "in_reply_to" is overwritten here [1], which is the main =
loop
>> worker to process all files passed to send-email [2], but it is not rest=
ored
>> for subsequent patches. Unless required otherwise (e.g. send-email
>> threading), it should be restored to its default value for each patch I
>> believe.
>
> Right. Most of the values we parse are declared inside the process_file
> function, and so start empty. $in_reply_to is special in that we need to
> carry its value across multiple files, so we need to always handle it in
> each loop iteration, whether we are setting it to a new value or
> resetting it to null.
>
>> I wrote a quick patch to adjust 2.1. to 3.1. [3]. I have no time right n=
ow
>> to review the submission guidelines (and thus did not submit the patch
>> "properly" yet), but I will try to get to that tonight or some time next
>> week. If in the mean time you could provide any feedback on the behaviou=
r or
>> the patch, so that I can get things right the first time, that would be
>> great!
>
> Your patch looks like the right direction. Handling $references at the
> same time is the right thing to do. The extra setting of $subject seems
> weird, though.

Basically the idea is to either 1) advance the values (for threading) or 2)=
 reset them to their defaults, i.e. never just preserve them. I neither kno=
w Perl nor the git design well, so I just applied the pattern to the subjec=
t as well. Should I just drop it? What would be the potential issues with e=
nforcing the pattern?

>
> We'd want to add a test to t/t9001-send-email.sh, too, I'd think.

I'm not home and I might need a few days to look into this. Any helping han=
d is greatly appreciated. :)

Thanks!

Best regards,
Marvin

>
> -Peff

