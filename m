Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15075C433F5
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 20:22:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7356610D2
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 20:22:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbhJNUYx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Oct 2021 16:24:53 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51219 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbhJNUYw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Oct 2021 16:24:52 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6D14F157987;
        Thu, 14 Oct 2021 16:22:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=bjy5b9604LRT
        bZ70P+qNN54x14LerfrWiFtOxDEOLbs=; b=XbfXFf4lU68OY1KNh42SfJfFk0Nk
        s9FlPys5ATrUwozbgMWXxrkTX6OQgvk2YkkmxgoYhe/1oCsI4aDQMt1VyyrCkU9r
        Z789EtMz6ScLGxwQ9porqTSKdrdepT+SlwOQftTB0eL6s7kStlSe497L2uIoSI/z
        34oenvDYbeqZGI4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 63BDC157986;
        Thu, 14 Oct 2021 16:22:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B59D9157982;
        Thu, 14 Oct 2021 16:22:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     phillip.wood@dunelm.org.uk, git@vger.kernel.org,
        Jeff King <peff@peff.net>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: To "const char *" and cast on free(), or "char *" and no cast...
References: <patch-1.1-9b17170b794-20211014T000949Z-avarab@gmail.com>
        <8f87cdb9-b52b-8d1a-545d-ed3055c536c0@gmail.com>
        <87mtnbfk0g.fsf@evledraar.gmail.com>
Date:   Thu, 14 Oct 2021 13:22:43 -0700
In-Reply-To: <87mtnbfk0g.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Thu, 14 Oct 2021 21:54:19 +0200")
Message-ID: <xmqqlf2vbbl8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 7D6AA918-2D2C-11EC-9C06-98D80D944F46-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>> It's great to see these leaks being fixed. I wonder though if it would
>> be better to change the structure definition so that 'name' and 'path'=
=20
>> are no longer 'const'. That would be a better reflection of the new
>> regime.[...]
>
> I think this is the right thing to do, but I'm not quite sure. There wa=
s
> a thread at it here:
>
>     https://lore.kernel.org/git/YUZG0D5ayEWd7MLP@carlos-mbp.lan/
>
> Where I chimed in and suggested exactly what you're saying here, but th=
e
> consensus seemed to go the other way, and if you grep:
>
>     git grep -F 'free((char *)'
>
> You can see that we use this pattern pretty widely.

Unfortunately, we probably need to make a trade-off and cannot eat
the cake and have it at the same time.

If we leave the .members non-const, the destructor may have to cast
the constness away.  If it is marked const * const, then we also
need to let the constructor do the same.

By marking the .members const, we can be sure that the users of the
API will not muck with the values once the structure is instanciated
and given to them, but the destructor need to cast the constness
away.  It may be lessor of two evils, as the need to cast is isolated
in the _implementation_ of the API, and casts in the _users_ of the API
would stand out more.
