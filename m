Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94442C433EF
	for <git@archiver.kernel.org>; Wed, 12 Jan 2022 19:23:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345232AbiALTXK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jan 2022 14:23:10 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50154 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242688AbiALTXK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jan 2022 14:23:10 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DE72B159C9E;
        Wed, 12 Jan 2022 14:23:09 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=CmiZK4lCaWkU
        iZl3vxGfqJYFWlg3GeOvci3wUCoKsro=; b=fkBNC4e5y9iVXaeI6iDWIyWeeAWV
        5ygVfwdYkcv+VnDl4z3s4UgN5synhzWZUDE3UEQyo2tJWycISbOGEjgY/KEl4kyV
        O/ZeZhwsoCY9WSGLwWqMPXU6JJ1cH3C/XStFfszbPRghtTw6faUhWZ9bFAktV/dA
        rNbqgn9EZAgJCvU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D59C1159C9B;
        Wed, 12 Jan 2022 14:23:09 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 4CFB8159C9A;
        Wed, 12 Jan 2022 14:23:07 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Fabian Stelzer <fs@gigacodes.de>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Hans Jerry Illikainen <hji@dyntopia.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Gwyneth Morgan <gwymor@tilde.club>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>
Subject: Re: [PATCH v2] t/gpg: simplify test for unknown key
References: <20220107091432.581225-1-fs@gigacodes.de>
        <20220112120757.874714-1-fs@gigacodes.de>
Date:   Wed, 12 Jan 2022 11:23:06 -0800
In-Reply-To: <20220112120757.874714-1-fs@gigacodes.de> (Fabian Stelzer's
        message of "Wed, 12 Jan 2022 13:07:57 +0100")
Message-ID: <xmqqv8you5b9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 124867B8-73DD-11EC-87FB-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fabian Stelzer <fs@gigacodes.de> writes:

> To test for a key that is completely unknown to the keyring we need one
> to sign the commit with. This was done by generating a new key and not
> add it into the keyring. To avoid the key generation overhead and
> problems where GPG did hang in CI during it, switch GNUPGHOME to the
> empty $GNUPGHOME_NOT_USED instead, therefore making all used keys unkno=
wn=20
> for this single `verify-commit` call.
>
> Reported-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> Signed-off-by: Fabian Stelzer <fs@gigacodes.de>
> ---

The original one is already in 'next' so I'll revert the merge and
queue this one instead.

We could turn this into incremental and apply it on the original
one, which may give us a chance to highlight this common mistake
of using a single-shot environment with shell functions, but let's
not bother.

Thanks.


>  t/t7510-signed-commit.sh | 22 ++--------------------
>  1 file changed, 2 insertions(+), 20 deletions(-)
>
> diff --git a/t/t7510-signed-commit.sh b/t/t7510-signed-commit.sh
> index 9882b69ae2..8593b7e3cb 100755
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
> +	test_must_fail env GNUPGHOME=3D"$GNUPGHOME_NOT_USED" git verify-commi=
t initial 2>actual &&
>  	! grep "Good signature from" actual &&
>  	! grep "BAD signature from" actual &&
>  	grep -q -F -e "No public key" -e "public key not found" actual
