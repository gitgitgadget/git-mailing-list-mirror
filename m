Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE164412
	for <git@vger.kernel.org>; Tue, 14 Nov 2023 01:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="J9BYRJz0"
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A6B6D5F
	for <git@vger.kernel.org>; Mon, 13 Nov 2023 17:08:52 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 57C7228850;
	Mon, 13 Nov 2023 20:08:51 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=irveddYyuGeq
	wNk2VHPakMyJRf59J3VvvRkRDo1VRzA=; b=J9BYRJz0t9ov0EcLppcMudcNGgeG
	3ctFarwkhyJ2kK6eC2ixV9NTt5x2sC5Za4SIaLwKL8VAoPGBAZ3H4VRQ50gkyVGH
	C6M6DN5/3oaw9DOJ6JGT51/EyLX7wwGZAJoJQOOHxBPv/lFugqehOwPlP7zSKMXE
	CVqwtB7TkhGH2uI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 509882884F;
	Mon, 13 Nov 2023 20:08:51 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E572228843;
	Mon, 13 Nov 2023 20:08:47 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc: git@vger.kernel.org,  Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH] completion: add and use the __git_get_config_subsection
 helper function
In-Reply-To: <20231113222528.62771-1-szeder.dev@gmail.com> ("SZEDER
 =?utf-8?Q?G=C3=A1bor=22's?=
	message of "Mon, 13 Nov 2023 23:25:27 +0100")
References: <20231113222528.62771-1-szeder.dev@gmail.com>
Date: Tue, 14 Nov 2023 10:08:46 +0900
Message-ID: <xmqqzfzh16qp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 5D6C4A94-828A-11EE-81FB-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

> +# Lists all subsections in the given section which contain the given
> +# config variable, with the section and variable names removed.
> +__git_get_config_subsections ()
> +{
> +	local section=3D"$1" var=3D"$2" i IFS=3D$'\n'
> +	for i in $(__git config --name-only --get-regexp "^$section\..*\.$var=
$"); do
> +		i=3D${i#$section.}
> +		i=3D${i%.$var}

As this script is allowed bash-isms, I wondered if we can use
a single pattern substitution instead of two remove pre/suffix
pattern substitution, but I guess it would not work, and the above
is perfectly readable.

> +		echo "$i"

As the subsection is designed to contain unbounded set of end-user
controlled names, we probably should do

		printf "%s\n" "$i"

instead to protect us from interesting names (e.g. ones that begin
with a dash).

> +	done
> +}

Interesting to see that we do not need to bother deduplicating the
output from here.

> diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
> index a7c3b4eb63..11ed83d0ed 100755
> --- a/t/t9902-completion.sh
> +++ b/t/t9902-completion.sh
> @@ -2130,6 +2130,19 @@ test_expect_success '__git_get_config_variables'=
 '
>  	test_cmp expect actual
>  '
> =20
> +test_expect_success '__git_get_config_subsections' '
> +	cat >expect <<-\EOF &&
> +	subsection-1
> +	SubSection-2
> +	sub.section.3
> +	EOF
> +	test_config interesting.subsection-1.name good &&
> +	test_config Interesting.SubSection-2.Name good &&
> +	test_config interesting.sub.section.3.name good &&
> +	__git_get_config_subsections interesting name >actual &&
> +	test_cmp expect actual
> +'

Good to see an uppercase character is used here ;-).

Thanks.
