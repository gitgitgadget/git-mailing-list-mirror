Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48953C43381
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 01:08:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2194A64EAE
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 01:08:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348026AbhCDBDe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Mar 2021 20:03:34 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53441 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388496AbhCDAZF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Mar 2021 19:25:05 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A3894BF663;
        Wed,  3 Mar 2021 19:24:19 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=GQGxiLbG+Mrf
        sibZxtX4dGsSuJ4=; b=cH2lTtGzzrgiQOE2bErBmNu5D5RVnhHX0CuGNL/xM8js
        wuSuPRpbwdQf+B0NFcoLZErFuz2iu1qaZxOVGwhajd9AyIwp6ZDf+Hb53eDx1dH5
        LyrRNUrcpHGzgR2t7BKEFat97+0V2VcgPdZ/r6f1mtZR0BHhD5603TkGFFcIv5k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Jq+nIS
        a8ldzlP+uE1IECOJYLQc7Z9DuxmomeEetdtA9BfHcdVREQecmBgiMreOt+8Dw7xs
        B5bE85VDPJU+/HXa3pgaSEXyGZX0nAwGnpGfXRCs0QDY9BxUsXzAezDgEOFEfAKY
        wAO4x/aMDuWuai8rnwuBlQDPBknY3XV174iBQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8C178BF661;
        Wed,  3 Mar 2021 19:24:19 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E068ABF65D;
        Wed,  3 Mar 2021 19:24:17 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: Re: [PATCH v2 08/10] grep/pcre2: actually make pcre2 use custom
 allocator
References: <20210204210556.25242-1-avarab@gmail.com>
        <20210218000728.13995-9-avarab@gmail.com>
Date:   Wed, 03 Mar 2021 16:24:17 -0800
In-Reply-To: <20210218000728.13995-9-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 18 Feb 2021 01:07:26 +0100")
Message-ID: <xmqqlfb3hiku.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: F513D86C-7C7F-11EB-847A-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Continue work started in 513f2b0bbd4 (grep: make PCRE2 aware of custom
> allocator, 2019-10-16) and make PCREv2 use our pcre2_{malloc,free}().
> functions for allocation. We'll now use it for all PCREv2 allocations.
>
> The reason 513f2b0bbd4 worked as a bugfix for the USE_NED_ALLOCATOR
> issue is because it targeted the allocation freed via free(), as
> opposed to by a pcre2_*free() function. I.e. the pcre2_maketables()
> and pcre2_maketables_free() pair.
>
> For most of the rest we continued allocating with stock malloc()
> inside PCREv2 itself, but didn't segfault because we'd use its
> corresponding free().
>
> In a preceding commit of mine I changed the free() to
> pcre2_maketables_free() on versions of PCREv2 10.34 and newer. So as
> far as fixing the segfault goes ...

Wait, wait.  So, because of the previous step, we would start
segfaulting and we need to fix that breakage, which is the reason
why this commit exists?

If so, ...

> we could revert 513f2b0bbd4. But then
> we wouldn't use the desired allocator, let's just use it instead.

... I agree with the conclusion that both the previous step and this
step are needed and better than a reversion of 513f2b0b (grep: make
PCRE2 aware of custom allocator, 2019-10-16) and the previou step.

But even then, it feels somewhat backwards.  Shouldn't this step
come first, so that we would be using a matching alloc/free pair,
and then do the previous step?

> Instead we should always create it, and then pass the general context
> to those functions that accept it, so that they'll consistently use
> our preferred memory allocation functions.

Thanks.
