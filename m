Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34753C08F
	for <git@vger.kernel.org>; Tue,  9 Jan 2024 18:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="dtizIA5f"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 29E7437090;
	Tue,  9 Jan 2024 13:23:08 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=B1B3XtDJhEY0
	p4ZUnvhnCF9Nc26ZOsEhdAK2U8ikdlk=; b=dtizIA5fhaBS6l71r8akkMmGf+Cf
	ShtOIzJSI4r1cKJO4IAUJXUPjMbKceIW9B4ysIkI+GZRt8hlFlDBB1kkxTzJvs1s
	T5pIfYeNFD41Or9Sh9Xu0kXlTeeFNd4gkzeUT5FPR/6Fh82PDyBFOWhWziWays+m
	MnDZLPEytQlSF74=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 0CD463708F;
	Tue,  9 Jan 2024 13:23:08 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 97C973708E;
	Tue,  9 Jan 2024 13:23:04 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH 3/3] advice: allow disabling the automatic hint in
 advise_if_enabled()
In-Reply-To: <d6099d78-43c6-4709-9121-11f84228cf91@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
	message of "Tue, 9 Jan 2024 16:30:16 +0100")
References: <7c68392c-af2f-4999-ae64-63221bf7833a@gmail.com>
	<d6099d78-43c6-4709-9121-11f84228cf91@gmail.com>
Date: Tue, 09 Jan 2024 10:23:03 -0800
Message-ID: <xmqqo7dugyd4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 2138810A-AF1C-11EE-B351-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

Rub=C3=A9n Justo <rjusto@gmail.com> writes:

> Using advise_if_enabled() to display an advice will automatically
> include instructions on how to disable the advice, along with the
> main advice:
>
> 	hint: use --reapply-cherry-picks to include skipped commits
> 	hint: Disable this message with "git config advice.skippedCherryPicks =
false"
>
> This can become distracting or noisy over time, while the user may
> still want to receive the main advice.
>
> Let's have a switch to allow disabling this automatic advice.
>
> Signed-off-by: Rub=C3=A9n Justo <rjusto@gmail.com>
> ---
>  advice.c          | 3 ++-
>  advice.h          | 3 ++-
>  t/t0018-advice.sh | 8 ++++++++
>  3 files changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/advice.c b/advice.c
> index 50c79443ba..fa203f8806 100644
> --- a/advice.c
> +++ b/advice.c
> @@ -79,6 +79,7 @@ static struct {
>  	[ADVICE_UPDATE_SPARSE_PATH]			=3D { "updateSparsePath", 1 },
>  	[ADVICE_WAITING_FOR_EDITOR]			=3D { "waitingForEditor", 1 },
>  	[ADVICE_WORKTREE_ADD_ORPHAN]			=3D { "worktreeAddOrphan", 1 },
> +	[ADVICE_ADVICE_OFF]				=3D { "adviceOff", 1 },
>  };
> =20
>  static const char turn_off_instructions[] =3D
> @@ -93,7 +94,7 @@ static void vadvise(const char *advice, int display_i=
nstructions,
> =20
>  	strbuf_vaddf(&buf, advice, params);
> =20
> -	if (display_instructions)
> +	if (display_instructions && advice_enabled(ADVICE_ADVICE_OFF))
>  		strbuf_addf(&buf, turn_off_instructions, key);
> =20
>  	for (cp =3D buf.buf; *cp; cp =3D np) {
> diff --git a/advice.h b/advice.h
> index 2affbe1426..1f2eef034e 100644
> --- a/advice.h
> +++ b/advice.h
> @@ -10,7 +10,7 @@ struct string_list;
>   * Add the new config variable to Documentation/config/advice.txt.
>   * Call advise_if_enabled to print your advice.
>   */
> - enum advice_type {
> +enum advice_type {
>  	ADVICE_ADD_EMBEDDED_REPO,
>  	ADVICE_ADD_EMPTY_PATHSPEC,
>  	ADVICE_ADD_IGNORED_FILE,
> @@ -50,6 +50,7 @@ struct string_list;
>  	ADVICE_WAITING_FOR_EDITOR,
>  	ADVICE_SKIPPED_CHERRY_PICKS,
>  	ADVICE_WORKTREE_ADD_ORPHAN,
> +	ADVICE_ADVICE_OFF,
>  };
> =20
>  int git_default_advice_config(const char *var, const char *value);
> diff --git a/t/t0018-advice.sh b/t/t0018-advice.sh
> index c13057a4ca..0b6a8b4a10 100755
> --- a/t/t0018-advice.sh
> +++ b/t/t0018-advice.sh
> @@ -30,4 +30,12 @@ test_expect_success 'advice should not be printed wh=
en config variable is set to
>  	test_must_be_empty actual
>  '
> =20
> +test_expect_success 'advice without the instructions to disable it' '
> +	cat >expect <<-\EOF &&
> +	hint: This is a piece of advice
> +	EOF
> +	test-tool -c advice.adviceOff=3D0 advise "This is a piece of advice" =
2>actual &&
> +	test_cmp expect actual
> +'

This is testing the right thing but in a "showing off a shiny new
toy" way.  We want to make sure we will catch regressions in the
future by testing with a bit more conditions perturbed.  For
example, with the new "-c var=3Dval" mechanism, we could

  * set advice.nestedtag to off (which would disable the whole
    advice)

  * set advice.adviceoff to on (which should be the same as not
    setting it explicitly at all).

to test different combinations that we were unable to test before
[2/3] invented the mechanism.

Thanks.
