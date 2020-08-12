Return-Path: <SRS0=KdtI=BW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AC48C433E0
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 19:40:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF81D206DA
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 19:40:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="H8GN1h4t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbgHLTkK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Aug 2020 15:40:10 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63460 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726512AbgHLTkK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Aug 2020 15:40:10 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 49CFCD6514;
        Wed, 12 Aug 2020 15:40:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=yBHpBKYLp6uEBFv//ViTwe6MiC0=; b=H8GN1h
        4tlzfgIILHOSBJx3Tyw+skXENEkmPh6+MymdtpAJBmIYwnVrwpOuuYzR6QmzvbtA
        tRWpciJRALNbolo4BZI3KOrC1B4KGHfzw+RDVFOIBZsVsYwtMura3zNuqXUBppHE
        HdVB0r9sAi/5V9cy+r3Io8AWx3qmI6KK0AHKU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=l4o27eCyreSQDl/PIqX64vJSsJfcPeab
        LqN+C6xGQ28TOGRgLYFeklssd8tn32GrGkrvJJcb96z8ybBaHEBIX19PB5Af5fdA
        FkBDRZ0hp/Au0nXaByNhcvBAA7VxAW6a/8hqwicm1hsNgLTwWi3r9uFm3xJX9+yh
        GckT32IUb+M=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 34169D6513;
        Wed, 12 Aug 2020 15:40:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 676C0D6512;
        Wed, 12 Aug 2020 15:40:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Antti =?utf-8?Q?Ker=C3=A4nen?= <antti@keraset.fi>,
        phillip.wood@dunelm.org.uk,
        Antti =?utf-8?Q?Ker=C3=A4nen?= <detegr@rbx.email>,
        git@vger.kernel.org,
        Jussi =?utf-8?Q?Ker=C3=A4nen?= <jussike@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] rebase -i: Fix possibly wrong onto hash in todo
References: <20200811131313.3349582-1-detegr@rbx.email>
        <ebdc0bc7-f48e-9f38-328d-b1181ac974d7@gmail.com>
        <20200811153621.GD19871@syl.lan>
        <20200811181537.qt7jkoxy7qn3k7mo@haukka.localdomain>
        <xmqqsgct9fi1.fsf@gitster.c.googlers.com>
        <20200811190139.GB34058@syl.lan>
        <xmqqft8t9f55.fsf@gitster.c.googlers.com>
        <20200812140352.GC74542@syl.lan>
Date:   Wed, 12 Aug 2020 12:40:02 -0700
In-Reply-To: <20200812140352.GC74542@syl.lan> (Taylor Blau's message of "Wed,
        12 Aug 2020 10:03:52 -0400")
Message-ID: <xmqqpn7v64bx.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9E8BD5D6-DCD3-11EA-AFA7-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> *Grumble*, it's not anywhere in POSIX:
>
>   https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap09.html
>
> ...making this a GNU-ism.
>
>> Look for "stick to a subset of BRE" in Documention/CodingGuidelines;
>> we may need to update the document to raise the baseline to match
>> the reality of year 2020, though.
>
> So, I think the "reality of year 2020" is that we still write '..*'
> instead of '.\+'.

Another interesting thing I found is this piece in "man sed" on
Linux (hence GNU):

    REGULAR EXPRESSIONS
           ...
           The -E option switches to using extended regular  expressions  instead;
           it  has  been  supported  for  years by GNU sed, and is now included in
           POSIX.

But the "sed" documentation [*1*] that matches what you cited above (The
Open Group Base Specifications Issue 7, 2018 edition) does not
mention "-E", "-r" nor "--regexp-extended".


[Reference]

*1*
https://pubs.opengroup.org/onlinepubs/9699919799/utilities/sed.html#tag_20_116_02
