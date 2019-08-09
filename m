Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9206E1F731
	for <e@80x24.org>; Fri,  9 Aug 2019 17:47:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407561AbfHIRq7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Aug 2019 13:46:59 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51160 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407436AbfHIRq7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Aug 2019 13:46:59 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 601B11740FE;
        Fri,  9 Aug 2019 13:46:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Czi9TcwgwnZ/
        usay2APWYZWAtbk=; b=HSP8IBx9ooPbx015cv5XhgCZ3Hrnmcbp2GWaycWw3zHM
        lS7248wnt08E9XwzwPCab/OE551lD2v6+fsgGxmA2Q5gtxEueJz1Cc1FrV/TZocn
        EG6RUurF8hQT17sIcoRIu1XSrXR1CLJ36T67P/pPNfYO0igd91uBn5hiv94Iwvo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=fIO1jg
        2RLRoU4UMH4BZjrF2RJDLsJ7s3ZYHcWEzbWWmuPfuvYaCTsaGRsD5WFomW+mUFa9
        Rew2QCJR7V4Pf9L65Qfs6KNAbYiRQvWsWGSMgpDg6IUGss8R+KOM3WkFFwe8i20Y
        IYxReUbPdQxJnKlwg6f0VeTFr8t8W/NJ0/BIk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 580E71740FD;
        Fri,  9 Aug 2019 13:46:57 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C656B1740FC;
        Fri,  9 Aug 2019 13:46:56 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Carlo Arenas <carenas@gmail.com>, git@vger.kernel.org,
        avarab@gmail.com, johannes.schindelin@gmx.de,
        michal.kiedrowicz@gmail.com
Subject: Re: [RFC PATCH v5 0/3] grep: almost no more leaks, hopefully no crashes
References: <20190807213945.10464-1-carenas@gmail.com>
        <20190809030210.18353-1-carenas@gmail.com>
        <CAPUEspiK7MTZPMktbU=_C_GPOH9vQiBmVUZp7GuR97RZS3onRQ@mail.gmail.com>
        <d239326e-11c3-5875-13a8-f4123baea6eb@web.de>
Date:   Fri, 09 Aug 2019 10:46:55 -0700
In-Reply-To: <d239326e-11c3-5875-13a8-f4123baea6eb@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Fri, 9 Aug 2019 19:01:02 +0200")
Message-ID: <xmqqy302cju8.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: AE626750-BACD-11E9-8621-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> So how about starting stupidly simple?  You can test it everywhere, it
> just needs libpcre2.  It works without that library as well (tested wit=
h
> "make USE_LIBPCRE=3D USE_LIBPCRE2=3D test"), but doesn't allocate anyth=
ing
> in that case, of course.  The character tables leak fix should be safe
> on top.  If you detect performance issues then we can address them in
> additional patches.
>
> -- >8 --
> Subject: [PATCH] grep: use xmalloc() for all PCRE2 allocations
>
> Build a PCRE2 global custom context when compiling a pattern and use it
> to tell the library to use xmalloc() for allocations.  This provides
> consistent out-of-memory handling and makes sure it uses a custom
> allocator, e.g. with USE_NED_ALLOCATOR.
>
> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
> ---
> The function names are ridiculously long, I tried to stay within 80
> characters per line but gave up in the end and just kept going without
> line breaks.  Fits the "stupidly simple" approach..

;-)  Thanks for keeping the conversation going.

