Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44E82C433EF
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 18:18:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25946613B1
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 18:18:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232397AbhKRSVF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Nov 2021 13:21:05 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56030 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbhKRSVF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Nov 2021 13:21:05 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 884E116615C;
        Thu, 18 Nov 2021 13:18:04 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=BLLzDgiiHy5k
        z8FH1JNhWB0jB+jQ4xEfy12njiwkLaQ=; b=nRoChnQrn/E1z20mJgg0eTFeHhEJ
        bkVWZkdL2fzgyvu/5ZkVYR8UfeScNR35JXCad+2/T12rBKAobgr+Wg7kGkGx8NbD
        RsGtOQYdHB02pIGSQlhUSmQPpAH3+y6Y6rsz/L3eiwlaMeDp5cvoO+ulkgAHwkDn
        uO+7cHpdzwgdeeU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7FF6916615B;
        Thu, 18 Nov 2021 13:18:04 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 7C1DF166156;
        Thu, 18 Nov 2021 13:18:00 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Arenas <carenas@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Hamza Mahfooz <someguy@effective-light.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v13 3/3] grep/pcre2: fix an edge case concerning ascii
 patterns and UTF-8 data
References: <20211015161356.3372-1-someguy@effective-light.com>
        <20211015161356.3372-3-someguy@effective-light.com>
        <877dd9i1zj.fsf@igel.home>
        <211115.86fsrxqbvp.gmgdl@evledraar.gmail.com>
        <87o86kv6fh.fsf@igel.home>
        <CAPUEspi=r9EsG8KPvdiD-HM7Drq8ho1yjkN_c_T1e+ZeR4eejg@mail.gmail.com>
        <87fsrwv46h.fsf@igel.home>
        <CAPUEspg8ZUdn+KFz35yG1k9bbfVTe1b+7=+WdMknRS1zu8VcDQ@mail.gmail.com>
        <634c4237-325a-13e8-0a92-09d23bdfb111@web.de>
        <211117.86y25m5wez.gmgdl@evledraar.gmail.com>
Date:   Thu, 18 Nov 2021 10:17:59 -0800
In-Reply-To: <211117.86y25m5wez.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Wed, 17 Nov 2021 21:59:45 +0100")
Message-ID: <xmqqczmxxr8o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: DCEC99AC-489B-11EC-890E-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>> Let's have a look at the map.  Here are the differences between the
>> versions regarding use of PCRE2_UTF:
>>
>> o: opt->ignore_locale
>> h: has_non_ascii(p->pattern)
>> i: is_utf8_locale()
>> l: !opt->ignore_case && (p->fixed || p->is_fixed)
>>
>> o h i l master hamza rene2
>> 0 0 0 0      0     1     0
>> 0 0 0 1      0     1     0
>> 0 0 1 0      0     1     1
>> 0 0 1 1      0     1     0  <=3D=3D 7812.13, confirmed using fprint() =
debugging
>>
>> So http://public-inbox.org/git/0ea73e7a-6d43-e223-ab2e-24c684102856@we=
b.de/
>> should not have this breakage, because it doesn't enable PCRE2_UTF for
>> literal patterns.
>
> PCRE2_UTF will also matter for literal patterns. Try to peel apart the
> two bytes in "=C3=A9" and match them under -i with/without PCRE_UTF.

Sorry for being late to the party, but doesn't "literal" in the
context of this thread mean the column "l" above, i.e. we are not
ignoring case and fixed or is_fixed member is set?  So "under -i"
disqualifies as an example for "will also matter for literal",
doesn't it?

In hindsight, I guess we could have pushed a bit harder when Ren=C3=A9's

-	if (!opt->ignore_locale && is_utf8_locale() && has_non_ascii(p->pattern=
) &&
+	if (!opt->ignore_locale && is_utf8_locale() &&
 	    !(!opt->ignore_case && (p->fixed || p->is_fixed)))
 		options |=3D (PCRE2_UTF | PCRE2_MATCH_INVALID_UTF);

in https://public-inbox.org/git/0ea73e7a-6d43-e223-ab2e-24c684102856@web.=
de/
(is that what is called 'rene2' above?) was raised on Oct 17th to
amend/fix Hamza's [v13 3/3]; that would have prevented 'master' from
having this breakage?

Carlo, in your [PATCH v2] in <20211117102329.95456-1-carenas@gmail.com>,
I see that the #else side for older PCREv2 users essentially reverts
what Hamza's [PATCH v13 3/3] did to this area.

+#else
+	if (!opt->ignore_locale && is_utf8_locale() && has_non_ascii(p->pattern=
) &&
+	    !(!opt->ignore_case && (p->fixed || p->is_fixed)))
+		options |=3D PCRE2_UTF;
+#endif

I guess this is a lot of change in the amount of text involved but
the least amount of actual change in the behaviour.  For those with
newer PCREv2, the behaviour would be the same as v2.34.0, and for
others, the behaviour would be the same as v2.33.0.

Having said all that, because the consensus seems to be that the
whole "when we should match in UTF mode" may need to be rethought, I
think reverting Hamza's [v13 3/3] would be the simplest way to clean
up the mess for v2.34.1 that will give us a cleaner slate to later
build on, than applying this patch.

So, I dunno.  Comments from those involved in the discussion?

Thanks.

