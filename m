Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 557BDC433EF
	for <git@archiver.kernel.org>; Tue,  9 Nov 2021 23:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F53A61038
	for <git@archiver.kernel.org>; Tue,  9 Nov 2021 23:37:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbhKIXkB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Nov 2021 18:40:01 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61786 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbhKIXj6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Nov 2021 18:39:58 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 564D2152E97;
        Tue,  9 Nov 2021 18:37:12 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=zUG5uhh3VEi4
        WCcmyMuIhgcWVzqu2udjdC/uxgzQU5s=; b=cPsBpQa1LBWjO1WccfvdQ9hgbKiC
        huyf9aYnnprmGN8LBGH4Te2UsX+/3QH0sKey/itvVDqlZBtX591pzoII7EJLPnK5
        f3NS7cuX0OxlqT8ciebZ747K/smOoEi23VVAUQpyLhpzwRHOSv6Sgd4lHWDt0QX6
        2ZrDCzmpu9yuHmM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4F95F152E96;
        Tue,  9 Nov 2021 18:37:12 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A0073152E95;
        Tue,  9 Nov 2021 18:37:09 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        SZEDER =?utf-8?Q?G?= =?utf-8?Q?=C3=A1bor?= 
        <szeder.dev@gmail.com>, Thomas Rast <tr@thomasrast.ch>,
        =?utf-8?Q?Ren?= =?utf-8?Q?=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 2/2] parse-options.c: use "enum parse_opt_result" for
 parse_nodash_opt()
References: <211106.86lf21ezqx.gmgdl@evledraar.gmail.com>
        <cover-0.2-00000000000-20211109T110113Z-avarab@gmail.com>
        <patch-2.2-aa6224b10f8-20211109T110113Z-avarab@gmail.com>
        <xmqqo86t2oud.fsf@gitster.g>
        <211110.867ddgkjcp.gmgdl@evledraar.gmail.com>
Date:   Tue, 09 Nov 2021 15:37:08 -0800
In-Reply-To: <211110.867ddgkjcp.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Wed, 10 Nov 2021 00:18:24 +0100")
Message-ID: <xmqqa6iczysb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: F4FC74D2-41B5-11EC-B820-98D80D944F46-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>>> -	return -2;
>>> +	return PARSE_OPT_ERROR;
>>>  }
>>
>> The current caller only checks to skip a token that yields 0 (aka
>> PARSE_OPT_DONE) and does not distinguish between other values, so
>> this won't change the behaviour of the current code, but it is=20
>> not clear if returning -1 (aka PARSE_OPT_ERROR) is better than -2
>> (aka PARSE_OPT_HELP).
>
> I think PARSE_OPT_ERROR is probably better.
>
> It looks like the -2 return value might have been somewhat blindly
> copy/pasted between 07fe54db3cd (parse-opt: do not print errors on
> unknown options, return -2 intead., 2008-06-23) and 51a9949eda7
> (parseopt: add PARSE_OPT_NODASH, 2009-05-07).
>
> I.e. we use the full enum values for the code in the former, but in the
> latter we're just looking for "not zero", so error/-1 seemed like a
> better fit.

OK.  That sounds like a good explanation for the change, to be
recorded in the proposed log message.

Thanks.
