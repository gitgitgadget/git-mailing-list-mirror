Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 38B1F1F462
	for <e@80x24.org>; Sun, 16 Jun 2019 22:26:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727478AbfFPW0f (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Jun 2019 18:26:35 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64545 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727238AbfFPW0f (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Jun 2019 18:26:35 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C165014B595;
        Sun, 16 Jun 2019 18:26:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=jxTsbw0DOa7+
        5SQgDOLW1vRUOfM=; b=Q9bjPevzAISEnYZv5fFwqPiQu+WWP6rHHnko2pzjxXH9
        n2MF1CyCXt/QEihLVA36sd/Sx1OcayIN1r7GRnGidlOXfxcKjgV0o1EpPtSqQkes
        GCp/6PRhtHApN9UrNyRO5rHBlAMUBiDf85dVJ8mj7PbF/LZMZR4EVmiOPGLiNY0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=dvkrLm
        QV6eAvPX4q5RfzNuYHL3QcoS/d+j6Z+BdwBx0C2ecyZXubS/OS4RiluxU7GUHxwu
        cdMaYOutKSs/VlY4YrsgVBxq/2tIEBNqeAlD8t/4Yn+9uLfgBOTHT9tR+OtL0QRQ
        /WCL86cGsF182ApYnjDkryyOHqaNrw3CI2xJ8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BA06414B594;
        Sun, 16 Jun 2019 18:26:30 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 343DB14B592;
        Sun, 16 Jun 2019 18:26:30 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 4/4] config: avoid calling `labs()` on too-large data type
References: <pull.265.git.gitgitgadget@gmail.com>
        <9613c88849e53e00e1f7ade49c6c9056309ef0b9.1560426581.git.gitgitgadget@gmail.com>
        <03a68560-8058-7436-6edb-38e276a37190@web.de>
        <f22599d4-148f-212c-282c-790f5bde1706@web.de>
        <90ef3797-78a6-f6d9-443b-387c0ab7cbe7@web.de>
Date:   Sun, 16 Jun 2019 15:26:29 -0700
In-Reply-To: <90ef3797-78a6-f6d9-443b-387c0ab7cbe7@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Sun, 16 Jun 2019 16:01:23 +0200")
Message-ID: <xmqq7e9ltbe2.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: C9CDD906-9085-11E9-923D-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

>>>> To fix it, let's just "unroll" the function (i.e. negate the value i=
f it
>>>> is negative).
>>>
>>> There's also imaxabs(3).

That may be true, but seeing that some platforms wants to see
intmax_t defined in the compat/ layer, I suspect we cannot avoid
having a copy of unrolled implementation somewhere in our code.

>>>> +		uval =3D val < 0 ? -val : val;
>>>>  		uval *=3D factor;
>>>> -		if (uval > max || labs(val) > uval) {
>>>> +		if (uval > max || (val < 0 ? -val : val) > uval) {
>>>>  			errno =3D ERANGE;
>>>>  			return 0;
>>>>  		}
>>>
>>> So this check uses unsigned arithmetic to find out if the multiplicat=
ion
>>> overflows, right?...
>> No, this example is wrong...
> ...
> Anyway, the code would be easier to read and ready for any units if it
> used unsigned_mult_overflows; would have saved me time spent painfully
> wading through the math at least.

A patch to use unsigned_mult_overflows() here, on top of the
"unrolled imaxabs" patch we reviewed, would be good to tie a loose
end.

Thanks.

