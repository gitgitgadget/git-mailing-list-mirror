Return-Path: <SRS0=3/hf=DT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88FDBC433DF
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 16:55:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42CFC2080A
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 16:55:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Asf2+RqK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390752AbgJLQzD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Oct 2020 12:55:03 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52800 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390705AbgJLQzD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Oct 2020 12:55:03 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 922238C03B;
        Mon, 12 Oct 2020 12:55:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=oCI23vePdkM7
        r7pGlZA5L2W+oCQ=; b=Asf2+RqK+7/NcSqfVV6Wsc4ljg4CsDapXAtGJXXwhmvD
        3CMbCUazhsblc+ebrLS+Me+B4pCwN0mZHZmat3LZ20F6xlqZVSe35YIZ8KvsJCpZ
        ZPgKFkg/Hu8ccpchhXb/ULQCDBY7kmEXFvOfbC65/xPDewiWahDA61IPhgLIcks=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=aBafeM
        N2FJS0iO/6Ea68fYH0AtilEZ5Cj5m2JEJMgZFX5FyJZrEBP74NuDbSZfXGrBZRYN
        1p9Vv0qSSYyHRDxLgLytBU66HgqmVY4HhxjTZLntK3Wb8QtgbNXoikroRHAQOb0X
        QNHyJq4MQBOFp43B2C7efCyL7Out4wzmbqNNQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6670F8C039;
        Mon, 12 Oct 2020 12:55:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C66588C038;
        Mon, 12 Oct 2020 12:54:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Barret Rhoden <brho@google.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/4] blame: validate and peel the object names on the
 ignore list
References: <20200925055954.1111389-1-gitster@pobox.com>
        <20200925055954.1111389-3-gitster@pobox.com>
        <40488753-c179-4ce2-42d0-e57b5b1ec6cd@web.de>
        <xmqqtuvkii1j.fsf@gitster.c.googlers.com>
        <32370477-c6e4-5378-fedc-c86b9ddf96bd@google.com>
        <1fa730c4-eaef-2f32-e1b4-716a27ed4646@web.de>
Date:   Mon, 12 Oct 2020 09:54:59 -0700
In-Reply-To: <1fa730c4-eaef-2f32-e1b4-716a27ed4646@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Sun, 11 Oct 2020 18:03:20 +0200")
Message-ID: <xmqqa6wrqt98.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: AA232694-0CAB-11EB-9984-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

>>>> This preexisting feature is curious.  It's even documented ('An
>>>> empty file name, "", will clear the list of revs from previously
>>>> processed files.') and covered by t8013.6.  Why would we need
>>>> such magic in addition to the standard negation
>>>> (--no-ignore-revs-file) for clearing the list?  The latter
>>>> counters blame.ignoreRevsFile as well. *puzzled*
>>>
>>> I shared the puzzlement when I saw it, but ditto.
>>
>> I don't recall exactly.  Someone on the list might have wanted to
>> both counter the blame.ignoreRevsFile and specify another file.  Or
>> maybe they just wanted to counter the ignoreRevsFile, and I didn't
>> know that --no- would already do that.  I'm certainly not wed to it.
>
> The first step would be to show a deprecation warning, wait a few
> releases and then remove that feature.  Not sure the effort and
> potential user irritation is worth the saved conditional, doc lines
> and test.  (We already established that I'm lazy.)

I do not particularly see the need to.  Perhaps when somebody
complains the next time?

> Anyway, here's the patch:
> ---
>  blame.c         |  2 +-
>  blame.h         |  5 +++--
>  builtin/blame.c | 16 ++++++++++++----
>  object.h        |  3 ++-
>  4 files changed, 18 insertions(+), 8 deletions(-)

Looks OK to me from a quick scan.
