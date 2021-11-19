Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D56EC433F5
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 17:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2203A61A56
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 17:11:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236472AbhKSROw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Nov 2021 12:14:52 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58096 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbhKSROv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Nov 2021 12:14:51 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DF56E15861D;
        Fri, 19 Nov 2021 12:11:49 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=oTycxMTVsfkE
        Q7lc4oZKxC/IlfaZiZdeMhZK61/XXRU=; b=DeZAIj0p01UQosom8iPLnajRx9El
        RXd5cDn7+oS9IHh0Uq3H/7TBBn13LqCEH9FrIdL7v26rrpslvfGxBAK2aaJbwJls
        PZzaJNVMK/QPF+C//OFbceQfF4t+II2qGIle+g4f26GOazz+gefHMnlJ7JgA5HCw
        i9tcgIfqoxBqflE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D789115861C;
        Fri, 19 Nov 2021 12:11:49 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 32EE315861B;
        Fri, 19 Nov 2021 12:11:47 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Carlo Arenas <carenas@gmail.com>,
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
        <xmqqczmxxr8o.fsf@gitster.g>
        <c5223004-6db6-e808-f607-d11bd45e7d99@web.de>
        <211119.86mtm04og8.gmgdl@evledraar.gmail.com>
Date:   Fri, 19 Nov 2021 09:11:45 -0800
In-Reply-To: <211119.86mtm04og8.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Fri, 19 Nov 2021 08:00:30 +0100")
Message-ID: <xmqqczmwqdda.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: C70FF6C2-495B-11EC-A31E-98D80D944F46-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Thu, Nov 18 2021, Ren=C3=A9 Scharfe wrote:
>>
>> Makes sense to me.  It gives a better starting point to solve the issu=
e
>> afresh without getting entangled in mind-melting boolean expressions.
>
> Yes, agreed. As noted I haven't had time to dig deeply into this, but
> from what I've seen so far there doesn't seem to be any obvious way
> forward in terms of a quick fix.
>
> I thought perhaps your patch would be that (but I haven't looked into i=
t
> carefully enough), but since you're on-board with reverting & retrying.

OK.  Here is what I'll queue 'master', in the hope of later merging
down and be part of v2.34.1.

Thanks, all.

----- >8 --------- >8 --------- >8 --------- >8 -----
Subject: [PATCH] Revert "grep/pcre2: fix an edge case concerning ascii pa=
tterns and UTF-8 data"

This reverts commit ae39ba431ab861548eb60b4bd2e1d8b8813db76f, as it
breaks "grep" when looking for a string in non UTF-8 haystack, when
linked with certain versions of PCREv2 library.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 grep.c                          |  6 ++---
 t/t7812-grep-icase-non-ascii.sh | 48 ---------------------------------
 2 files changed, 2 insertions(+), 52 deletions(-)

diff --git a/grep.c b/grep.c
index f6e113e9f0..fe847a0111 100644
--- a/grep.c
+++ b/grep.c
@@ -382,10 +382,8 @@ static void compile_pcre2_pattern(struct grep_pat *p=
, const struct grep_opt *opt
 		}
 		options |=3D PCRE2_CASELESS;
 	}
-	if ((!opt->ignore_locale && !has_non_ascii(p->pattern)) ||
-	    (!opt->ignore_locale && is_utf8_locale() &&
-	     has_non_ascii(p->pattern) && !(!opt->ignore_case &&
-					    (p->fixed || p->is_fixed))))
+	if (!opt->ignore_locale && is_utf8_locale() && has_non_ascii(p->pattern=
) &&
+	    !(!opt->ignore_case && (p->fixed || p->is_fixed)))
 		options |=3D (PCRE2_UTF | PCRE2_MATCH_INVALID_UTF);
=20
 #ifdef GIT_PCRE2_VERSION_10_36_OR_HIGHER
diff --git a/t/t7812-grep-icase-non-ascii.sh b/t/t7812-grep-icase-non-asc=
ii.sh
index 22487d90fd..e5d1e4ea68 100755
--- a/t/t7812-grep-icase-non-ascii.sh
+++ b/t/t7812-grep-icase-non-ascii.sh
@@ -53,54 +53,6 @@ test_expect_success REGEX_LOCALE 'pickaxe -i on non-as=
cii' '
 	test_cmp expected actual
 '
=20
-test_expect_success GETTEXT_LOCALE,PCRE 'log --author with an ascii patt=
ern on UTF-8 data' '
-	cat >expected <<-\EOF &&
-	Author: <BOLD;RED>=C3=80 =C3=9A Thor<RESET> <author@example.com>
-	EOF
-	test_write_lines "forth" >file4 &&
-	git add file4 &&
-	git commit --author=3D"=C3=80 =C3=9A Thor <author@example.com>" -m s=C3=
=A9cond &&
-	git log -1 --color=3Dalways --perl-regexp --author=3D".*Thor" >log &&
-	grep Author log >actual.raw &&
-	test_decode_color <actual.raw >actual &&
-	test_cmp expected actual
-'
-
-test_expect_success GETTEXT_LOCALE,PCRE 'log --committer with an ascii p=
attern on ISO-8859-1 data' '
-	cat >expected <<-\EOF &&
-	Commit:     =C3=87<BOLD;RED> O M=C3=AEtter <committer@example.com><RESE=
T>
-	EOF
-	test_write_lines "fifth" >file5 &&
-	git add file5 &&
-	GIT_COMMITTER_NAME=3D"=C3=87 O M=C3=AEtter" &&
-	GIT_COMMITTER_EMAIL=3D"committer@example.com" &&
-	git -c i18n.commitEncoding=3Dlatin1 commit -m th=C3=AFrd &&
-	git -c i18n.logOutputEncoding=3Dlatin1 log -1 --pretty=3Dfuller --color=
=3Dalways --perl-regexp --committer=3D" O.*" >log &&
-	grep Commit: log >actual.raw &&
-	test_decode_color <actual.raw >actual &&
-	test_cmp expected actual
-'
-
-test_expect_success GETTEXT_LOCALE,PCRE 'log --grep with an ascii patter=
n on UTF-8 data' '
-	cat >expected <<-\EOF &&
-	    s=C3=A9<BOLD;RED>con<RESET>d
-	EOF
-	git log -1 --color=3Dalways --perl-regexp --grep=3D"con" >log &&
-	grep con log >actual.raw &&
-	test_decode_color <actual.raw >actual &&
-	test_cmp expected actual
-'
-
-test_expect_success GETTEXT_LOCALE,PCRE 'log --grep with an ascii patter=
n on ISO-8859-1 data' '
-	cat >expected <<-\EOF &&
-	    <BOLD;RED>th=C3=AFrd<RESET>
-	EOF
-	git -c i18n.logOutputEncoding=3Dlatin1 log -1 --color=3Dalways --perl-r=
egexp --grep=3D"th.*rd" >log &&
-	grep "th.*rd" log >actual.raw &&
-	test_decode_color <actual.raw >actual &&
-	test_cmp expected actual
-'
-
 test_expect_success GETTEXT_LOCALE,LIBPCRE2 'PCRE v2: setup invalid UTF-=
8 data' '
 	printf "\\200\\n" >invalid-0x80 &&
 	echo "=C3=A6var" >expected &&
--=20
2.34.0-202-gd9146917d7

