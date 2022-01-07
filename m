Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B26AAC433F5
	for <git@archiver.kernel.org>; Fri,  7 Jan 2022 21:43:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbiAGVnu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Jan 2022 16:43:50 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60777 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbiAGVns (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jan 2022 16:43:48 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B7AE016FAC0;
        Fri,  7 Jan 2022 16:43:47 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=71N7XbHExvmD
        NxEZy1BK+sYVTXaV0U3tvlUyEnWsmV8=; b=aGN2tjC4HezKgsKZC2L5eakJGibx
        ziCMCI2K2vzcIIuEDTIFtbBFyoJ1s05Esgw/Qr7cLtTbAzoIE372b5EtOp/u9R+A
        30ZuRI5dnR0smmc8C+0GmwjrIcYN1GILjyf5nl6Ns/n/ARjjkSKRpqm2cNC9r1dT
        FEb8k+Tgh5r8jhY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AF32E16FABF;
        Fri,  7 Jan 2022 16:43:47 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 29E5E16FAB0;
        Fri,  7 Jan 2022 16:43:45 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Fabian Stelzer <fs@gigacodes.de>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Hans Jerry Illikainen <hji@dyntopia.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Gwyneth Morgan <gwymor@tilde.club>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH] t/gpg: simplify test for unknown key
References: <20220107091432.581225-1-fs@gigacodes.de>
Date:   Fri, 07 Jan 2022 13:43:44 -0800
In-Reply-To: <20220107091432.581225-1-fs@gigacodes.de> (Fabian Stelzer's
        message of "Fri, 7 Jan 2022 10:14:32 +0100")
Message-ID: <xmqqmtk76x2n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: E3923742-7002-11EC-8A60-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fabian Stelzer <fs@gigacodes.de> writes:

> To test for a key that is completely unknown to the keyring we need one
> to sign the commit with. This was done by generating a new key and not
> add it into the keyring. To avoid the key generation overhead and
> problems where GPG did hang in CI during it, switch GNUPGHOME to an
> empty directory instead, therefore making all used keys unknown for thi=
s
> single `verify-commit` call.
>
> Reported-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> Signed-off-by: Fabian Stelzer <fs@gigacodes.de>
> ---
> This was reported by =C3=86var in <211222.86ilvhpbl0.gmgdl@evledraar.gm=
ail.com>.
> Just using an empty keyring / gpg homedir should achieve the same effec=
t and=20
> keeps the stress of generating a gpg key out of the CI.

Clever.  Losing lines of code and gaining more stability in CI is a
great thing.

>
>
>  t/t7510-signed-commit.sh | 22 ++--------------------
>  1 file changed, 2 insertions(+), 20 deletions(-)
>
> diff --git a/t/t7510-signed-commit.sh b/t/t7510-signed-commit.sh
> index 9882b69ae2..2d38580847 100755
> --- a/t/t7510-signed-commit.sh
> +++ b/t/t7510-signed-commit.sh
> @@ -71,25 +71,7 @@ test_expect_success GPG 'create signed commits' '
>  	git tag eleventh-signed $(cat oid) &&
>  	echo 12 | git commit-tree --gpg-sign=3DB7227189 HEAD^{tree} >oid &&
>  	test_line_count =3D 1 oid &&
> -	git tag twelfth-signed-alt $(cat oid) &&
> -
> -	cat >keydetails <<-\EOF &&
> -	Key-Type: RSA
> -	Key-Length: 2048
> -	Subkey-Type: RSA
> -	Subkey-Length: 2048
> -	Name-Real: Unknown User
> -	Name-Email: unknown@git.com
> -	Expire-Date: 0
> -	%no-ask-passphrase
> -	%no-protection
> -	EOF
> -	gpg --batch --gen-key keydetails &&
> -	echo 13 >file && git commit -a -S"unknown@git.com" -m thirteenth &&
> -	git tag thirteenth-signed &&
> -	DELETE_FINGERPRINT=3D$(gpg -K --with-colons --fingerprint --batch unk=
nown@git.com | grep "^fpr" | head -n 1 | awk -F ":" "{print \$10;}") &&
> -	gpg --batch --yes --delete-secret-keys $DELETE_FINGERPRINT &&
> -	gpg --batch --yes --delete-keys unknown@git.com
> +	git tag twelfth-signed-alt $(cat oid)
>  '
> =20
>  test_expect_success GPG 'verify and show signatures' '
> @@ -129,7 +111,7 @@ test_expect_success GPG 'verify and show signatures=
' '
>  '
> =20
>  test_expect_success GPG 'verify-commit exits failure on unknown signat=
ure' '
> -	test_must_fail git verify-commit thirteenth-signed 2>actual &&
> +	GNUPGHOME=3D./empty_home test_must_fail git verify-commit initial 2>a=
ctual &&
>  	! grep "Good signature from" actual &&
>  	! grep "BAD signature from" actual &&
>  	grep -q -F -e "No public key" -e "public key not found" actual
