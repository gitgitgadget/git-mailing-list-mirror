Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 575D1C433EF
	for <git@archiver.kernel.org>; Thu, 17 Feb 2022 22:56:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbiBQW5K (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Feb 2022 17:57:10 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:57556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiBQW5J (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Feb 2022 17:57:09 -0500
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04A08D5DC5
        for <git@vger.kernel.org>; Thu, 17 Feb 2022 14:56:53 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C22BC10452D;
        Thu, 17 Feb 2022 17:56:52 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=OjFtrC0x1pef
        LcKCABVDsVg9L7vMCd/sFH6qSdCPv8c=; b=WFMcj1uu5SEtytPl87AcQiU+ZKT/
        hQgTEzUMv5uMmUlJ4Aw/WDH0DGuvtbqz5PzJqYaS3YIVEsie5P7NseunubXXaf3V
        4koLZ9y+MDgT0yYdf3mOyW0mgzHeNTZtFaNlPG3b0BGgKpL/ZExzPZQdyiSS2te9
        485pc2BM6eFYXmk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BA43A10452C;
        Thu, 17 Feb 2022 17:56:52 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 209A3104528;
        Thu, 17 Feb 2022 17:56:52 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Git List <git@vger.kernel.org>,
        Hamza Mahfooz <someguy@effective-light.com>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>, Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [v2.35.0 regression] some PCRE hangs under UTF-8 locale
References: <5fa6962e-3c1c-6dbc-f6d7-589151a9baec@web.de>
        <20220129172542.GB2581@szeder.dev>
        <dca59178-6e9b-315b-06ee-8e3201aa391c@web.de>
        <20220130090422.GA4769@szeder.dev>
        <b74f781c-548b-5254-d3d1-fc1873c70e10@web.de>
        <220131.868ruvbovo.gmgdl@evledraar.gmail.com>
        <1425e548-c1bb-3cff-d75d-c3760abb6129@web.de>
        <220212.86zgmvx13i.gmgdl@evledraar.gmail.com>
        <4e391e2e-6561-3c2e-0306-c860a37356bc@web.de>
Date:   Thu, 17 Feb 2022 14:56:50 -0800
In-Reply-To: <4e391e2e-6561-3c2e-0306-c860a37356bc@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Thu, 17 Feb 2022 22:14:29 +0100")
Message-ID: <xmqq1r016r0t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: E5578CB4-9044-11EC-B683-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Subject: [PATCH] grep: fix triggering PCRE2_NO_START_OPTIMIZE workaroun=
d
>
> PCRE2 bug 2642 was fixed in version 10.36.  Our 95ca1f987e (grep/pcre2:
> better support invalid UTF-8 haystacks, 2021-01-24) worked around it on
> older versions by setting the flag PCRE2_NO_START_OPTIMIZE.  797c359978
> (grep/pcre2: use compile-time PCREv2 version test, 2021-02-18) switched
> it around to set the flag on 10.36 and higher instead, while it claimed
> to use "the same test done at compile-time".
>
> Switch the condition back to apply the workaround on PCRE2 versions
> _before_ 10.36.
>
> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
> ---
>  grep.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/grep.c b/grep.c
> index 5bec7fd793..ef34d764f9 100644
> --- a/grep.c
> +++ b/grep.c
> @@ -386,7 +386,7 @@ static void compile_pcre2_pattern(struct grep_pat *=
p, const struct grep_opt *opt
>  	if (!opt->ignore_locale && is_utf8_locale() && !literal)
>  		options |=3D (PCRE2_UTF | PCRE2_MATCH_INVALID_UTF);
>
> -#ifdef GIT_PCRE2_VERSION_10_36_OR_HIGHER
> +#ifndef GIT_PCRE2_VERSION_10_36_OR_HIGHER
>  	/* Work around https://bugs.exim.org/show_bug.cgi?id=3D2642 fixed in =
10.36 */

Oh, that's embarrassing.  The #ifdef and the comment sit next to
each other and they make contradicting statement.

>  	if (PCRE2_MATCH_INVALID_UTF && options & (PCRE2_UTF | PCRE2_CASELESS)=
)
>  		options |=3D PCRE2_NO_START_OPTIMIZE;
> --
> 2.35.1
