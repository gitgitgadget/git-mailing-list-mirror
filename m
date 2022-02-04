Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10BD4C433F5
	for <git@archiver.kernel.org>; Fri,  4 Feb 2022 23:24:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378243AbiBDXY6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Feb 2022 18:24:58 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61514 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378174AbiBDXYm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Feb 2022 18:24:42 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D52B4175EC0;
        Fri,  4 Feb 2022 18:24:41 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ciG3T1K6hN9U
        ZtDP4ksgP6v5C/Ebd6dyHChWw+1+VWw=; b=O2kWx3EG5YPvjD8i0fQR8gja/ApS
        GP80dEqh3+TIvS9YNoYlmIWEwdEFt8AdFJXFW6soM19LMiw7M1v135rQuJrkzuSk
        ghx3ini9BEED3026AjsDHT5uNOafwrWhQc9l5yDgbMfX6pngSuXwbbIUklTth1Na
        qPQt+al1scXTO/o=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CE092175EBE;
        Fri,  4 Feb 2022 18:24:41 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 46971175EBD;
        Fri,  4 Feb 2022 18:24:39 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, J Smith <dark.panda@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v10 3/9] grep tests: add missing "grep.patternType"
 config tests
References: <cover-v9-0.9-00000000000-20220127T115058Z-avarab@gmail.com>
        <cover-v10-0.9-00000000000-20220204T211534Z-avarab@gmail.com>
        <patch-v10-3.9-3464c76cfd7-20220204T211534Z-avarab@gmail.com>
Date:   Fri, 04 Feb 2022 15:24:38 -0800
In-Reply-To: <patch-v10-3.9-3464c76cfd7-20220204T211534Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 4 Feb
 2022 22:20:45
        +0100")
Message-ID: <xmqqv8xui5ah.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 9FABC622-8611-11EC-8566-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> +	test_expect_success "grep $L with grep.extendedRegexp is last-one-win=
s" '

The statement is true, but ...

> +		echo "${HC}ab:a+bc" >expected &&
> +		git \
> +			-c grep.extendedRegexp=3Dtrue \
> +			-c grep.patternType=3Dbasic \
> +			-c grep.extendedRegexp=3Dfalse \

... I do not think that is what is tested here.  It checks that
the value of grep.extendedRegexp is irrelevant when grep.patternType
is anything but default, no?  In other words, if you lose the last
one that overrides the earlier .extendedRegexp=3Dtrue, this should
still pass, no?

> +			grep "a+b*c" $H ab >actual &&
> +		test_cmp expected actual
> +	'
> +
> +	test_expect_success "grep $L with grep.extendedRegexp is last-one-win=
s & defers to grep.patternType" '
> +		echo "${HC}ab:abc" >expected &&
> +		git \
> +			-c grep.extendedRegexp=3Dtrue \
> +			-c grep.patternType=3Dextended \
> +			-c grep.extendedRegexp=3Dfalse \

Likewise.  grep.extendedRegexp being last-one-wins has no relevance
to this result, just like the previous one.  I would understand:

	grep $L with grep.patternType=3Dextended pays no atention to grep.extend=
edRegexp

though.

> +			grep "a+b*c" $H ab >actual &&
> +		test_cmp expected actual
> +	'
> +
> +	test_expect_success "grep $L with grep.extendedRegexp and grep.patter=
nType are both last-one-wins independently (ERE)" '
> +		echo "${HC}ab:abc" >expected &&
> +		git \
> +			-c grep.patternType=3Dfixed \
> +			-c grep.extendedRegexp=3Dtrue \
> +			-c grep.patternType=3Ddefault \
> +			grep "a+b*c" $H ab >actual &&

.patternType=3Ddefault lets .extendedRegexp to decide, and we get ERE.

This does have a correct name and tests the right thing (but
grep.extendedRegexp is set only once in this, so "last-one-wins" is
technically correct but may not be very useful thing to stress upon
;-).

> +		test_cmp expected actual
> +	'
> +
> +	test_expect_success "grep $L with grep.extendedRegexp and grep.patter=
nType are both last-one-wins independently (ERE)" '
> +		echo "${HC}ab:abc" >expected &&
> +		git \
> +			-c grep.extendedRegexp=3Dfalse \
> +			-c grep.patternType=3Ddefault \
> +			-c grep.extendedRegexp=3Dtrue \

.patternType=3Ddefault lets .extendedRegexp to decide, and we get ERE.

Future readers might wonder why we are are testing the same thing
again, without enough imagination to guess what faulty implementation
is possible to require this test ;-).

> +			grep "a+b*c" $H ab >actual &&
> +		test_cmp expected actual
> +	'
> +
> +	test_expect_success "grep $L with grep.extendedRegexp and grep.patter=
nType are both last-one-wins independently (BRE)" '
> +		echo "${HC}ab:a+bc" >expected &&
> +		git \
> +			-c grep.extendedRegexp=3Dtrue \
> +			-c grep.extendedRegexp=3Dfalse \
> +			grep "a+b*c" $H ab >actual &&

.patternType=3Ddefault that is implicit is the "last" value and lets
.extendedRegexp to decide, and we get BRE.

> +		test_cmp expected actual
> +	'
> +
> +	test_expect_success "grep $L with grep.extendedRegexp and grep.patter=
nType are both last-one-wins independently (BRE)" '
> +		echo "${HC}ab:abc" >expected &&
> +		git \
> +			-c grep.extendedRegexp=3Dfalse \
> +			-c grep.extendedRegexp=3Dtrue \
> +			-c grep.patternType=3Ddefault \

Similar.  As the default for .patternType is the default anyway,
even with an implementation that commits the choice too early would
get this right, as it assumes that .patternType is the default when
it sees true given to .extendedRegexp variable.

> +			grep "a+b*c" $H ab >actual &&
> +		test_cmp expected actual
> +	'
> +
> +	test_expect_success "grep $L with grep.extendedRegexp and grep.patter=
nType are both last-one-wins independently (BRE)" '
> +		echo "${HC}ab:a+bc" >expected &&
> +		git \
> +			-c grep.patternType=3Ddefault \
> +			-c grep.extendedRegexp=3Dtrue \
> +			-c grep.patternType=3Dbasic \

The last value for .patternType not being "default" makes it the
only thing that matters.  This one also tests the right thing.

> +			grep "a+b*c" $H ab >actual &&
> +		test_cmp expected actual
> +	'
> +	test_expect_success "grep $L with grep.patternType=3Dextended and gre=
p.patternType=3Ddefault" '
> +		echo "${HC}ab:a+bc" >expected &&
> +		git \
> +			-c grep.patternType=3Dextended \
> +			-c grep.patternType=3Ddefault \

The last value for .patternType being "default" lets .extendedRegexp
to decide, but .extendedRegexp is left to its default, which is
false, so we should get BRE.

> +			grep "a+b*c" $H ab >actual &&
> +		test_cmp expected actual
> +	'
> +
> +	test_expect_success "grep $L with grep.patternType=3D[extended -> def=
ault -> fixed]" '
> +		echo "${HC}ab:a+b*c" >expected &&
> +		git \
> +			-c grep.patternType=3Dextended \
> +			-c grep.patternType=3Ddefault \
> +			-c grep.patternType=3Dfixed \
> +			grep "a+b*c" $H ab >actual &&

OK.

> +		test_cmp expected actual
> +	'
> +
>  	test_expect_success "grep $L with grep.patternType=3Dextended and gre=
p.extendedRegexp=3Dfalse" '
>  		echo "${HC}ab:abc" >expected &&
>  		git \
> @@ -478,6 +565,15 @@ do
>  		test_cmp expected actual
>  	'
> =20
> +	test_expect_success "grep $L with grep.extendedRegexp=3Dfalse and gre=
p.patternType=3Ddefault" '
> +		echo "${HC}ab:abc" >expected &&
> +		git \
> +			-c grep.extendedRegexp=3Dfalse \
> +			-c grep.patternType=3Dextended \

Again, .patternType not being "default" makes .extendedRegexp not to
matter at all, and we get ERE.

> +			grep "a+b*c" $H ab >actual &&
> +		test_cmp expected actual
> +	'
> +
>  	test_expect_success "grep $L with grep.extendedRegexp=3Dtrue and grep=
.patternType=3Dbasic" '
>  		echo "${HC}ab:a+bc" >expected &&
>  		git \

All tests look correct.  The first two had labels that missed the
point of what is being tested, which need fixing.  Other tests were
correct, I know that all of them may have helped to catch mistakes
made in past iterations of this series, but without knowing the past
mistakes, new readers may not get exactly the point of these tests.

Thanks.
