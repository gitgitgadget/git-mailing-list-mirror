Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8422C433F5
	for <git@archiver.kernel.org>; Wed, 16 Feb 2022 02:20:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343701AbiBPCUv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Feb 2022 21:20:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343668AbiBPCUq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Feb 2022 21:20:46 -0500
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 578DEBF97D
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 18:20:35 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0D555174F3C;
        Tue, 15 Feb 2022 21:20:35 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=22GZAmXNMpGa
        zSvDiwiL+Di5z3pGcDH8SsJ0TPfogIA=; b=cfU3wMKs2KE0umCujs10bNLDGQzf
        u3NUk+VJdedoTOdgbbeGcNTQmkW48t1zP3CWRy788j0hEKoXWIY4nFMnieFYIeS+
        L/SwDm2ki0kh5OEdj8ee6522v99xJPqY2RfUh1asZSKI7GvcQozgWhdF3KC63oh8
        HeZe8Qoey9j82tg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 05176174F3B;
        Tue, 15 Feb 2022 21:20:35 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 59255174F39;
        Tue, 15 Feb 2022 21:20:32 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, J Smith <dark.panda@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v11 00/10] grep: simplify & delete "init" & "config" code
References: <cover-v10-0.9-00000000000-20220204T211534Z-avarab@gmail.com>
        <cover-v11-00.10-00000000000-20220216T000006Z-avarab@gmail.com>
Date:   Tue, 15 Feb 2022 18:20:31 -0800
In-Reply-To: <cover-v11-00.10-00000000000-20220216T000006Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 16 Feb
 2022 01:00:29
        +0100")
Message-ID: <xmqqh78zwo0g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 04569A28-8ECF-11EC-B8E6-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

>   * A new 3/10 and 4/10 hopefully address the comments about the test
>     code. I ended up just adding a helper to reduce the existing and
>     new verbosity of the tests, which should make it easier to reason
>     about them.

Here is an excerpt plus comments on "git diff @{1}" after queuing
the new series.  I found only a few minor "Huh?", none of them a
huge deal.

Will queue; thanks.

+test_pattern_type () {
+	H=3D$1 &&
+	HC=3D$2 &&
+	L=3D$3 &&
+	type=3D$4 &&
+	shift 4 &&
+
+	expected_str=3D &&
+	case "$type" in
+	BRE)
+		expected_str=3D"${HC}ab:a+bc"
+		;;
+	ERE)
+		expected_str=3D"${HC}ab:abc"
+		;;
+	FIX)
+		expected_str=3D"${HC}ab:a+b*c"
+		;;
+	*)
+		BUG "unknown pattern type '$type'"
+		;;
+	esac &&

Excellent.  I always had to think twice when commenting on earlier
rounds of the patches which expected strings corresponded to what
pattern type.  Now we have a clearly defined table.

+	config_str=3D"$@" &&

This forces each element of $@ to lose its identity, and makes it a
single string separated by a whitespace, so it is less misleading to
write

	config_str=3D"$*"

instead, but it is not a huge deal.

+	test_expect_success "grep $L with '$config_str' interpreted as $type" '
+		echo $expected_str >expected &&
+		git $config_str grep "a+b*c" $H ab >actual &&
+		test_cmp expected actual
+	'

We must leave $config_str unquoted (because we do want the string
split at $IFS), but not quoting "$expected_str" looks a bit yucky
(because we have no intention to let $IFS to split it).

+}
+

+	test_pattern_type "$H" "$HC" "$L" BRE -c grep.extendedRegexp=3Dfalse
+	test_pattern_type "$H" "$HC" "$L" ERE -c grep.extendedRegexp=3Dtrue
+	test_pattern_type "$H" "$HC" "$L" BRE -c grep.patternType=3Dbasic
+	test_pattern_type "$H" "$HC" "$L" ERE -c grep.patternType=3Dextended
+	test_pattern_type "$H" "$HC" "$L" FIX -c grep.patternType=3Dfixed
=20
This part demonstrates the beauty of the new helper very well ;-)

s/FIX/FIXED/ would be more grammatically correct.  It would break
alignment above and I suspect that was why the patch chose to say
"FIX" instead, but I am not sure if the alignment here is so
valuable.

+	test_pattern_type "$H" "$HC" "$L" ERE \
+		-c grep.patternType=3Ddefault \
+		-c grep.extendedRegexp=3Dtrue
+	test_pattern_type "$H" "$HC" "$L" ERE \
+		-c grep.extendedRegexp=3Dtrue \
+		-c grep.patternType=3Ddefault
+	test_pattern_type "$H" "$HC" "$L" ERE \
+		-c grep.patternType=3Dextended \
+		-c grep.extendedRegexp=3Dfalse
+	test_pattern_type "$H" "$HC" "$L" BRE \
+		-c grep.patternType=3Dbasic \
+		-c grep.extendedRegexp=3Dtrue
+	test_pattern_type "$H" "$HC" "$L" ERE \
+		-c grep.extendedRegexp=3Dfalse \
+		-c grep.patternType=3Dextended
+	test_pattern_type "$H" "$HC" "$L" BRE \
+		-c grep.extendedRegexp=3Dtrue \
+		-c grep.patternType=3Dbasic

OK.  A bit redundant, knowing the implementation that parses the two
variables independently just like any other two variables, but these
are correct, which counts even more ;-).

+	# grep.extendedRegexp is last-one-wins
+	test_pattern_type "$H" "$HC" "$L" BRE \
+		-c grep.extendedRegexp=3Dtrue \
+		-c grep.extendedRegexp=3Dfalse
+
+	# grep.patternType=3Dbasic pays no attention to grep.extendedRegexp
+	test_pattern_type "$H" "$HC" "$L" BRE \
+		-c grep.extendedRegexp=3Dtrue \
+		-c grep.patternType=3Dbasic \
+		-c grep.extendedRegexp=3Dfalse
+
+	# grep.patternType=3Dextended pays no attention to grep.extendedRegexp
+	test_pattern_type "$H" "$HC" "$L" ERE \
+		-c grep.extendedRegexp=3Dtrue \
+		-c grep.patternType=3Dextended \
+		-c grep.extendedRegexp=3Dfalse

All correct.

+	# grep.extendedRegexp is used with a last-one-wins grep.patternType=3Dd=
efault
+	test_pattern_type "$H" "$HC" "$L" ERE \
+		-c grep.patternType=3Dfixed \
+		-c grep.extendedRegexp=3Dtrue \
+		-c grep.patternType=3Ddefault

Nice.

+	# grep.extendedRegexp is used with earlier grep.patternType=3Ddefault
+	test_pattern_type "$H" "$HC" "$L" ERE \
+		-c grep.extendedRegexp=3Dfalse \
+		-c grep.patternType=3Ddefault \
+		-c grep.extendedRegexp=3Dtrue

OK.  I would have expected "the last" instead of "earlier".  Because
these two variables are independently "the last one wins", just like
any two variables that are "the last one wins", the relative order
of their appearance does not matter.

+	# grep.extendedRegexp is used with a last-one-loses grep.patternType=3D=
default
+	test_pattern_type "$H" "$HC" "$L" ERE \
+		-c grep.extendedRegexp=3Dfalse \
+		-c grep.extendedRegexp=3Dtrue \
+		-c grep.patternType=3Ddefault

I am not sure what last-one-loses mean here.  Both variables are
independently last-one-wins, so at the end of the parsing,
grep.extendedRegexp has 'true' (because it is the last value seen
for the variable) while grep.patternType has 'default' (again, it is
the last value seen for the variable).

+	# grep.extendedRegexp and grep.patternType are both last-one-wins indep=
endently
+	test_pattern_type "$H" "$HC" "$L" BRE \
+		-c grep.patternType=3Ddefault \
+		-c grep.extendedRegexp=3Dtrue \
+		-c grep.patternType=3Dbasic

The title of this one gets the gist of the mistakes in the code in
earlier rounds.

+	# grep.patternType=3Dextended and grep.patternType=3Ddefault
+	test_pattern_type "$H" "$HC" "$L" BRE \
+		-c grep.patternType=3Dextended \
+		-c grep.patternType=3Ddefault
+
+	# grep.patternType=3D[extended -> default -> fixed] (BRE)" '
+	test_pattern_type "$H" "$HC" "$L" FIX \
+		-c grep.patternType=3Dextended \
+		-c grep.patternType=3Ddefault \
+		-c grep.patternType=3Dfixed
=20
OK.

 	test_expect_success "grep --count $L" '
 		echo ${HC}ab:3 >expected &&
