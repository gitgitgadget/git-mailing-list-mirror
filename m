Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74002C433FE
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 07:29:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D412617E3
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 07:29:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243794AbhKRHcQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Nov 2021 02:32:16 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52216 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242809AbhKRHcL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Nov 2021 02:32:11 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C3806E2D36;
        Thu, 18 Nov 2021 02:29:10 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=TpJUQh/GTHdy9m5csoaj6NiWP
        M5HVro0X4RyHAMaUdY=; b=RJahTAtShHWI5CWb5HgOqBZfm2TgpAdeDQZDVQGop
        fBFLcBcAlt1Xuwuymw7XrqSeOJnVL9Gvs8GpQJxljW2blfP3i47VHagqvkTGx36s
        2myDU9BOaPjR3byZvVmJ+PoMHmKYW0vWDuJhR8pJqekzcPpDL3h3qwQxJgtS4w3v
        jM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A844AE2D33;
        Thu, 18 Nov 2021 02:29:10 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BBC45E2D19;
        Thu, 18 Nov 2021 02:29:09 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, someguy@effective-light.com,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH v2] grep: avoid setting UTF mode when dangerous with PCRE
References: <20211116110035.22140-1-carenas@gmail.com>
        <20211117102329.95456-1-carenas@gmail.com>
Date:   Wed, 17 Nov 2021 23:29:08 -0800
Message-ID: <xmqqpmqxyla3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 3865CC64-4841-11EC-8B5F-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Marcelo Arenas Bel=C3=B3n  <carenas@gmail.com> writes:

> Since ae39ba431a (grep/pcre2: fix an edge case concerning ascii pattern=
s
> and UTF-8 data, 2021-10-15), PCRE2_UTF mode is enabled for cases where =
it
> will trigger UTF-8 validation errors (as reported) or can result in
> undefined behaviour.
>
> Our use of PCRE2 only allows searching through non UTF-8 validated data
> safely through the use of the PCRE2_MATCH_INVALID_UTF flag, that is onl=
y
> available after 10.34, so restrict the change to newer versions of PCRE
> and revert to the old logic for older releases, which will still allow
> for matching not using UTF-8 for likely most usecases (as shown in the
> tests).
>
> Fix one test that was using an expression that wouldn't fail without th=
e
> new code so it can be forced to fail if it is missing and restrict it t=
o
> run only for newer PCRE releases; while at it do some minor refactoring
> to cleanup the fallout for when that test might be skipped or might
> succeed under the new conditions.
>
> Keeping the overly complex and unnecessary logic for now, to reduce ris=
k
> but with the hope that it will be cleaned up later.
>
> Helped-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
> Reported-by: Andreas Schwab <schwab@linux-m68k.org>
> Signed-off-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>
> ---
> v2:
> * restrict the code at compile time instead of reverting
> * "fix" test to document  the behaviour under both PCRE code versions
> * update commit message to better explain the issue

So, is this the final verrsion everybody is happy with, instead of
just reverting the whole "paint hits in log --grep" topic, or did I
miss more discussion in the original thread?

With too many patches on the list, it is a bit hard to keep track of
the more urgent regresison fixes X-<.

Thanks.

>  grep.c                          |  7 ++++++-
>  t/t7812-grep-icase-non-ascii.sh | 32 ++++++++++++++++++--------------
>  2 files changed, 24 insertions(+), 15 deletions(-)
>
> diff --git a/grep.c b/grep.c
> index f6e113e9f0..0126aa3db4 100644
> --- a/grep.c
> +++ b/grep.c
> @@ -382,12 +382,17 @@ static void compile_pcre2_pattern(struct grep_pat=
 *p, const struct grep_opt *opt
>  		}
>  		options |=3D PCRE2_CASELESS;
>  	}
> +#ifdef GIT_PCRE2_VERSION_10_34_OR_HIGHER
>  	if ((!opt->ignore_locale && !has_non_ascii(p->pattern)) ||
>  	    (!opt->ignore_locale && is_utf8_locale() &&
>  	     has_non_ascii(p->pattern) && !(!opt->ignore_case &&
>  					    (p->fixed || p->is_fixed))))
>  		options |=3D (PCRE2_UTF | PCRE2_MATCH_INVALID_UTF);
> -
> +#else
> +	if (!opt->ignore_locale && is_utf8_locale() && has_non_ascii(p->patte=
rn) &&
> +	    !(!opt->ignore_case && (p->fixed || p->is_fixed)))
> +		options |=3D PCRE2_UTF;
> +#endif
>  #ifdef GIT_PCRE2_VERSION_10_36_OR_HIGHER
>  	/* Work around https://bugs.exim.org/show_bug.cgi?id=3D2642 fixed in =
10.36 */
>  	if (PCRE2_MATCH_INVALID_UTF && options & (PCRE2_UTF | PCRE2_CASELESS)=
)
> diff --git a/t/t7812-grep-icase-non-ascii.sh b/t/t7812-grep-icase-non-a=
scii.sh
> index 22487d90fd..3bfe1ee728 100755
> --- a/t/t7812-grep-icase-non-ascii.sh
> +++ b/t/t7812-grep-icase-non-ascii.sh
> @@ -53,14 +53,27 @@ test_expect_success REGEX_LOCALE 'pickaxe -i on non=
-ascii' '
>  	test_cmp expected actual
>  '
> =20
> -test_expect_success GETTEXT_LOCALE,PCRE 'log --author with an ascii pa=
ttern on UTF-8 data' '
> -	cat >expected <<-\EOF &&
> -	Author: <BOLD;RED>=C3=80 =C3=9A Thor<RESET> <author@example.com>
> -	EOF
> +test_expect_success GETTEXT_LOCALE,PCRE 'setup ascii pattern on UTF-8 =
data' '
>  	test_write_lines "forth" >file4 &&
>  	git add file4 &&
>  	git commit --author=3D"=C3=80 =C3=9A Thor <author@example.com>" -m s=C3=
=A9cond &&
> -	git log -1 --color=3Dalways --perl-regexp --author=3D".*Thor" >log &&
> +	test_write_lines "fifth" >file5 &&
> +	git add file5 &&
> +	GIT_COMMITTER_NAME=3D"=C3=87 O M=C3=AEtter" &&
> +	GIT_COMMITTER_EMAIL=3D"committer@example.com" &&
> +	git -c i18n.commitEncoding=3Dlatin1 commit -m th=C3=AFrd
> +'
> +
> +test_lazy_prereq PCRE2_MATCH_INVALID_UTF '
> +	test-tool pcre2-config has-PCRE2_MATCH_INVALID_UTF
> +'
> +
> +test_expect_success GETTEXT_LOCALE,PCRE,PCRE2_MATCH_INVALID_UTF 'log -=
-author with an ascii pattern on UTF-8 data' '
> +	cat >expected <<-\EOF &&
> +	Author: <BOLD;RED>A U Thor<RESET> <author@example.com>
> +	Author: <BOLD;RED>=C3=80 =C3=9A Thor<RESET> <author@example.com>
> +	EOF
> +	git log --color=3Dalways --perl-regexp --author=3D". . Thor" >log &&
>  	grep Author log >actual.raw &&
>  	test_decode_color <actual.raw >actual &&
>  	test_cmp expected actual
> @@ -70,11 +83,6 @@ test_expect_success GETTEXT_LOCALE,PCRE 'log --commi=
tter with an ascii pattern o
>  	cat >expected <<-\EOF &&
>  	Commit:     =C3=87<BOLD;RED> O M=C3=AEtter <committer@example.com><RE=
SET>
>  	EOF
> -	test_write_lines "fifth" >file5 &&
> -	git add file5 &&
> -	GIT_COMMITTER_NAME=3D"=C3=87 O M=C3=AEtter" &&
> -	GIT_COMMITTER_EMAIL=3D"committer@example.com" &&
> -	git -c i18n.commitEncoding=3Dlatin1 commit -m th=C3=AFrd &&
>  	git -c i18n.logOutputEncoding=3Dlatin1 log -1 --pretty=3Dfuller --col=
or=3Dalways --perl-regexp --committer=3D" O.*" >log &&
>  	grep Commit: log >actual.raw &&
>  	test_decode_color <actual.raw >actual &&
> @@ -141,10 +149,6 @@ test_expect_success GETTEXT_LOCALE,LIBPCRE2 'PCRE =
v2: grep non-ASCII from invali
>  	test_cmp invalid-0xe5 actual
>  '
> =20
> -test_lazy_prereq PCRE2_MATCH_INVALID_UTF '
> -	test-tool pcre2-config has-PCRE2_MATCH_INVALID_UTF
> -'
> -
>  test_expect_success GETTEXT_LOCALE,LIBPCRE2 'PCRE v2: grep non-ASCII f=
rom invalid UTF-8 data with -i' '
>  	test_might_fail git grep -hi "=C3=86" invalid-0x80 >actual &&
>  	test_might_fail git grep -hi "(*NO_JIT)=C3=86" invalid-0x80 >actual
