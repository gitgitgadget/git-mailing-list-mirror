Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 37F1B1F461
	for <e@80x24.org>; Thu,  5 Sep 2019 19:25:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727514AbfIETZp (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Sep 2019 15:25:45 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51398 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbfIETZp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Sep 2019 15:25:45 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E3DB829D09;
        Thu,  5 Sep 2019 15:25:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Mc8iBOSy1apD
        DVAmdbt0dJiuJw0=; b=hhvJQgnS1YPC/bAMfUbqHEX5dzmAEeCzp+64qAUrqlhT
        giE930bcj4wYGyBwax0cAhxUckdR6ToLcrxpzlbu75mYpEaWghJ7yGgjaTuqfCGA
        1ez+tESbfC+V1FHLFjOOO2Bsy76s/bswjqBt+/D+S1G+jgnCBt9LFTRumnC277M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=I+255g
        lJ962yQ+avCnK6DLhVJ60vrQexpaQIKg5nwhmCExYJFrH5sF5gHXg707m/oCu0qD
        gEL/SUH0qs6eiStiWetSwBso9qbQEoIDf2LSM0KN5yIUQxKvHboFUto9Ir0hvDXf
        DWjsXMQ6pkIDKZyKKTC9xBKoefo6lzWE3zTOY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DAE5829D08;
        Thu,  5 Sep 2019 15:25:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 495BF29D07;
        Thu,  5 Sep 2019 15:25:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Jeff King <peff@peff.net>, Stephan Beyer <s-beyer@gmx.net>,
        Paul Tan <pyokagan@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH] Fix maybe-uninitialized warnings found by gcc 9 -flto
References: <20190905082459.26816-1-s-beyer@gmx.net>
        <6c6c4e71-d9e5-1ad4-74db-12c323da42f7@web.de>
        <20190905175304.GA23663@sigill.intra.peff.net>
        <b4f53049-ff50-8143-1653-d321cce6421c@web.de>
Date:   Thu, 05 Sep 2019 12:25:41 -0700
In-Reply-To: <b4f53049-ff50-8143-1653-d321cce6421c@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Thu, 5 Sep 2019 21:09:27 +0200")
Message-ID: <xmqqr24upmtm.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: F3684036-D012-11E9-AE86-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Am 05.09.19 um 19:53 schrieb Jeff King:
>>>> int cmd__read_cache(int argc, const char **argv)
>>>> {
>>>> -       int i, cnt =3D 1, namelen;
>>>> +       int i, cnt =3D 1, namelen =3D 0;
>>
>> I actually saw this one the other day, because it triggered for me whe=
n
>> compiling with SANITIZE=3Daddress. AFAICT it's a false positive. "name=
" is
>> always NULL unless skip_prefix() returns true, in which case we always
>> set "namelen". And we only look at "namelen" if "name" is non-NULL.
>>
>> This one doesn't even require LTO, because skip_prefix() is an inline
>> function. I'm not sure why the compiler gets confused here.
>
> Yes, that's curious.
>
>> I don't mind
>> initializing namelen to 0 to silence it, though (we already set name t=
o
>> NULL, so this would just match).
>
> Pushing the strlen() call into the loop and getting rid of namelen shou=
ld
> work as well -- and I'd be surprised if this had a measurable performan=
ce
> impact.

Yeah, we are making strlen() call on a constant "name" in a loop
over argv[].  I do not think it matters in this case, either.

