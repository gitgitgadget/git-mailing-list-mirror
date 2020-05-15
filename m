Return-Path: <SRS0=YoUm=65=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCDA9C433E1
	for <git@archiver.kernel.org>; Fri, 15 May 2020 20:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C4D9206D4
	for <git@archiver.kernel.org>; Fri, 15 May 2020 20:25:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="nzBI075A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbgEOUZB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 May 2020 16:25:01 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:61682 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbgEOUZA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 May 2020 16:25:00 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8EF8ACE766;
        Fri, 15 May 2020 16:24:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=CVdVaOWufCpF
        VwjKFqdcJsQGjzw=; b=nzBI075AMqj8EumCkADh0XmCR83mcGhtqq0Dlow8gwxk
        UCnTUTWBzSCfAfCGvXU/p0LURuaoAbfcIsssQUGH7EX//GbsnZEX2em53pgoAko+
        kQaSDH842H5BMYmJOzW6yNuKIvAnLT0gD21GuCzyGjEPcPANBqnZaXaovnFgCJI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=UFlGrw
        OaMsky26SaPNRyk3SH9dJFzbzamXQz46wQm54+m0nHVo070fBeajAwgG7FcEbokb
        o4d/BY0i4W3L8an/6zr6hAHIK1yKJAzCFAC9G+n7WbZ7RfARcnFoPmcWgtnDDw0N
        +9FbmVrHEp6iVW6WQTj9uY1eFyDc0sSOXIRS8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 830EBCE765;
        Fri, 15 May 2020 16:24:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C3075CE763;
        Fri, 15 May 2020 16:24:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, emaste@freebsd.org, sunshine@sunshineco.com
Subject: Re: [PATCH v2] t4210: detect REG_ILLSEQ dynamically
References: <20200513111636.30818-1-carenas@gmail.com>
        <20200515195157.41217-1-carenas@gmail.com>
Date:   Fri, 15 May 2020 13:24:49 -0700
In-Reply-To: <20200515195157.41217-1-carenas@gmail.com> ("Carlo Marcelo
 Arenas
        =?utf-8?Q?Bel=C3=B3n=22's?= message of "Fri, 15 May 2020 12:51:56 -0700")
Message-ID: <xmqqmu69kktq.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 2194C332-96EA-11EA-A7D3-B0405B776F7B-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Marcelo Arenas Bel=C3=B3n  <carenas@gmail.com> writes:

> diff --git a/t/helper/test-regex.c b/t/helper/test-regex.c
> index 10284cc56f..7a8ddce45b 100644
> --- a/t/helper/test-regex.c
> +++ b/t/helper/test-regex.c
> @@ -41,16 +41,21 @@ int cmd__regex(int argc, const char **argv)
>  {
>  	const char *pat;
>  	const char *str;
> -	int flags =3D 0;
> +	int ret, silent =3D 0, flags =3D 0;
>  	regex_t r;
>  	regmatch_t m[1];
> +	char errbuf[64];
> =20
>  	if (argc =3D=3D 2 && !strcmp(argv[1], "--bug"))
>  		return test_regex_bug();
>  	else if (argc < 3)
>  		usage("test-tool regex --bug\n"
> -		      "test-tool regex <pattern> <string> [<options>]");
> +		      "test-tool regex [--silent] <pattern> <string> [<options>]");
>
> +	if (!strcmp(argv[1], "--silent")) {
> +		silent =3D 1;
> +		argv++;
> +	}

This looks fishy---if argc=3D=3D3 and the first one is "--silent", only
the <pattern> is left in argv and before taking <string> out of the
argv, we need to ensure argc is still large enough, but I do not
think that is done below:

>  	argv++;
>  	pat =3D *argv++;
>  	str =3D *argv++;

So str here would be NULL and/or *argv++ would have given you an
out-of-bounds access already.

> @@ -67,8 +72,14 @@ int cmd__regex(int argc, const char **argv)
>  	}
>  	git_setup_gettext();
> =20
> -	if (regcomp(&r, pat, flags))
> -		die("failed regcomp() for pattern '%s'", pat);
> +	ret =3D regcomp(&r, pat, flags);
> +	if (ret) {
> +		if (silent)
> +			return 1;
> +
> +		regerror(ret, &r, errbuf, sizeof(errbuf));
> +		die("failed regcomp() for pattern '%s' (%s)", pat, errbuf);
> +	}
>  	if (regexec(&r, str, 1, m, 0))
>  		return 1;

Not that it matters _too_ much as this is merely a test helper and
it would not hurt anybody as long as our callers are careful.

> diff --git a/t/t4210-log-i18n.sh b/t/t4210-log-i18n.sh
> index c3792081e6..a89f456817 100755
> --- a/t/t4210-log-i18n.sh
> +++ b/t/t4210-log-i18n.sh
> @@ -10,6 +10,12 @@ latin1_e=3D$(printf '\351')
>  # invalid UTF-8
>  invalid_e=3D$(printf '\303\50)') # ")" at end to close opening "("
> =20
> +if test_have_prereq GETTEXT_LOCALE &&
> +	! LC_ALL=3D$is_IS_locale test-tool regex --silent $latin1_e $latin1_e=
 EXTENDED
> +then
> +	have_reg_illseq=3D1
> +fi

OK.  Have we cleared have_reg_illseq shell variable before we reach
this point?  If not, we should (think: environment variable end user
had before starting the test).

> @@ -56,38 +62,68 @@ test_expect_success !MINGW 'log --grep does
>  	test_must_be_empty actual
>  '
> =20
> +trigger_undefined_behaviour()
> +{

Style:

	triggers_undefined_behaviour () {

My first two readings of this patch mistakenly told me that the name
of the function was an instruction to the test to trigger an
undefined behaviour to see what happens, but this helper answers a
question "does the given engine trigger an undefined behaviour (with
the test data we are going to throw at it)?", right?  Perhaps rename
the helper to "triggerS_undefined_behaviour" would reduce the risk
of inviting such a misinterpretation.

> +	local engine=3D$1
> +
> +	case $engine in
> +	fixed)
> +		if test -n "$have_reg_illseq" &&
> +			! test_have_prereq LIBPCRE2
> +		then
> +			return 0
> +		else
> +			return 1
> +		fi
> +		;;
> +	basic|extended)
> +		if test -n "$have_reg_illseq"
> +		then
> +			return 0
> +		else
> +			return 1
> +		fi
> +		;;
> +	perl)
> +		return 1
> +		;;
> +	esac
> +}

... and the return value is true for "yes it would trigger undefined
behaviour" and false for "no it would not".

>  for engine in fixed basic extended perl
>  do
>  	prereq=3D
>  	if test $engine =3D "perl"
>  	then
> +		prereq=3DPCRE
>  	fi
>  	force_regex=3D
>  	if test $engine !=3D "fixed"
>  	then
> +		force_regex=3D'.*'
>  	fi
> =20
>  	test_expect_success !MINGW,GETTEXT_LOCALE,$prereq "-c grep.patternTyp=
e=3D$engine log --grep does not find non-reencoded values (latin1 + local=
e)" "
> +		LC_ALL=3D$is_IS_locale git -c grep.patternType=3D$engine log --encod=
ing=3DISO-8859-1 --format=3D%s --grep=3D\"$force_regex$utf8_e\" >actual &=
&

Can we do something to these overlong lines, by the way?

>  		test_must_be_empty actual
>  	"
> =20
> +	if ! trigger_undefined_behaviour $engine
> +	then

Much easier to read than the ILLSEQ prerequisite, I would think,
even though the overlong lines are annoying.

> +		test_expect_success !MINGW,GETTEXT_LOCALE,$prereq "-c grep.patternTy=
pe=3D$engine log --grep searches in log output encoding (latin1 + locale)=
" "
> +			cat >expect <<-\EOF &&
> +			latin1
> +			utf8
> +			EOF
> +			LC_ALL=3D$is_IS_locale git -c grep.patternType=3D$engine log --enco=
ding=3DISO-8859-1 --format=3D%s --grep=3D\"$force_regex$latin1_e\" >actua=
l &&
> +			test_cmp expect actual
> +		"
> +
> +		test_expect_success !MINGW,GETTEXT_LOCALE,$prereq "-c grep.patternTy=
pe=3D$engine log --grep does not die on invalid UTF-8 value (latin1 + loc=
ale + invalid needle)" "
> +			LC_ALL=3D$is_IS_locale git -c grep.patternType=3D$engine log --enco=
ding=3DISO-8859-1 --format=3D%s --grep=3D\"$force_regex$invalid_e\" >actu=
al &&
> +			test_must_be_empty actual
> +		"
> +	fi
>  done
> =20
>  test_done
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 0ea1e5a05e..81473fea1d 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -1454,12 +1454,6 @@ case $uname_s in
>  	test_set_prereq SED_STRIPS_CR
>  	test_set_prereq GREP_STRIPS_CR
>  	;;
> -FreeBSD)
> -	test_set_prereq REGEX_ILLSEQ
> -	test_set_prereq POSIXPERM
> -	test_set_prereq BSLASHPSPEC
> -	test_set_prereq EXECKEEPSPID
> -	;;
>  *)
>  	test_set_prereq POSIXPERM
>  	test_set_prereq BSLASHPSPEC

Nice to be able to drop one case arm from here.  Thanks.
