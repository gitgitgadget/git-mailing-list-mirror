Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B30BC43334
	for <git@archiver.kernel.org>; Fri,  1 Jul 2022 02:17:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232025AbiGACRx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 22:17:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiGACRw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 22:17:52 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 681F06051F
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 19:17:51 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8B2D213782A;
        Thu, 30 Jun 2022 22:17:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=s64gZU0RMGhc
        9mVJdT50gokkcl9PRzM0A16GS7GU2JM=; b=E+TIl+lcWat6/r9EEz09hl2Vna0S
        rasXWn2NmqxLY2WdJebzRoZOxdhqthXZCgWYboEZkRaANfJUz4tE3kYMnIeOmFbF
        8HbokNYJWZpAZSsUzmrH+Kw6iTmB5jSIMr0cFa5TFHKXNiQ7mMS/gbOXrRtR4Md8
        WPCm4ekt+t3D2EY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7546A137827;
        Thu, 30 Jun 2022 22:17:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AC73C137826;
        Thu, 30 Jun 2022 22:17:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 5/9] test-tool regex: call regfree(), fix memory leaks
References: <cover-0.9-00000000000-20220630T180129Z-avarab@gmail.com>
        <patch-5.9-fe2a8d898f6-20220630T180129Z-avarab@gmail.com>
Date:   Thu, 30 Jun 2022 19:17:47 -0700
In-Reply-To: <patch-5.9-fe2a8d898f6-20220630T180129Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 1 Jul
 2022 01:47:05 +0200")
Message-ID: <xmqq8rpda850.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 008ED0D4-F8E4-11EC-A4DB-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> diff --git a/t/helper/test-regex.c b/t/helper/test-regex.c
> index d6f28ca8d14..a37d1f7a546 100644
> --- a/t/helper/test-regex.c
> +++ b/t/helper/test-regex.c
> @@ -24,27 +24,35 @@ static int test_regex_bug(void)
>  	char *str =3D "=3D{}\nfred";
>  	regex_t r;
>  	regmatch_t m[1];
> +	int err =3D 0;
> =20
>  	if (regcomp(&r, pat, REG_EXTENDED | REG_NEWLINE))
>  		die("failed regcomp() for pattern '%s'", pat);
> -	if (regexec(&r, str, 1, m, 0))
> -		die("no match of pattern '%s' to string '%s'", pat, str);
> +	if (regexec(&r, str, 1, m, 0)) {
> +		err =3D error("no match of pattern '%s' to string '%s'", pat, str);
> +		goto cleanup;
> +	}

Hmph.  Does it count as leaking to die() while r is still on the
stack?  I do not mind cleaning everything up thoroughly, but I am
curious if this is really necessary.  Apparently it is, as can be
seen in the patch to t/t7812-grep-icase-non-ascii.sh that allows
us to say "PASSES" with this patch.

> @@ -85,27 +93,29 @@ int cmd__regex(int argc, const char **argv)
>  	}
>  	git_setup_gettext();
> =20
> -	ret =3D regcomp(&r, pat, flags);
> -	if (ret) {
> +	if (regcomp(&r, pat, flags)) {
>  		if (silent)
> -			return ret;
> +			return 1;
> =20
>  		regerror(ret, &r, errbuf, sizeof(errbuf));
>  		die("failed regcomp() for pattern '%s' (%s)", pat, errbuf);
>  	}
>  	if (!str)
> -		return 0;
> +		goto cleanup;

Ahh, OK, this one does not bother with regfree() at all.  The
changes to the other one may be irrelevant but the changes to this
function would be necessary to mark the test with "PASSES".

> -	ret =3D regexec(&r, str, 1, m, 0);
> -	if (ret) {
> +	if (regexec(&r, str, 1, m, 0)) {
> +		ret =3D 1;
>  		if (silent || ret =3D=3D REG_NOMATCH)
> -			return ret;
> +			goto cleanup;
> =20
>  		regerror(ret, &r, errbuf, sizeof(errbuf));
> -		die("failed regexec() for subject '%s' (%s)", str, errbuf);
> +		error("failed regexec() for subject '%s' (%s)", str, errbuf);
> +		goto cleanup;
>  	}
> =20
> -	return 0;
> +cleanup:
> +	regfree(&r);
> +	return ret;
>  usage:
>  	usage("\ttest-tool regex --bug\n"
>  	      "\ttest-tool regex [--silent] <pattern>\n"
> diff --git a/t/t7812-grep-icase-non-ascii.sh b/t/t7812-grep-icase-non-a=
scii.sh
> index ac7be547145..31c66b63c2c 100755
> --- a/t/t7812-grep-icase-non-ascii.sh
> +++ b/t/t7812-grep-icase-non-ascii.sh
> @@ -2,6 +2,7 @@
> =20
>  test_description=3D'grep icase on non-English locales'
> =20
> +TEST_PASSES_SANITIZE_LEAK=3Dtrue
>  . ./lib-gettext.sh
> =20
>  doalarm () {
