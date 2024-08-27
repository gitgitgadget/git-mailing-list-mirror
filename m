Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E070E7FD
	for <git@vger.kernel.org>; Tue, 27 Aug 2024 00:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724718921; cv=none; b=pckVaqTFS+HDdBMxhjIl/zuMW7qrUuGg06nPdD/YzDfT65R2SlneDP4BovtuH93q1YbFXSvzVZZSYlhuyqUNhaYgE0jwEDXeEUzGFrzq4kefHFF9qI9Q0YisLhzcI5iUpg2LAJ9/WIvfOVVXzEewNc1xdYbhRjWL4CLMp3J+NkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724718921; c=relaxed/simple;
	bh=Lb5mfmmSE+H2LuDggCsxn0SOuSbEdyVIOhtOx3MdjiQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=k5NjsgpCUdNnC7t+Ype6uWboqheU/W5RX1mN2gw3Q7bsJAgOckwnEaMkOGx33rxc3WP80ky8dPeSfl3ruS78LmfT5qp38fpL6zIqDRJXgZ6JcHOIAZhjeoWBND/PX+4rbOrk0HoX3Qzp1ihjaAFDpzK65ZaSsh13s8Md8Yu72F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=HE6Xuft4; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="HE6Xuft4"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 318112AA1A;
	Mon, 26 Aug 2024 20:35:19 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Lb5mfmmSE+H2
	LuDggCsxn0SOuSbEdyVIOhtOx3MdjiQ=; b=HE6Xuft4E0IvFj1AUxCKl8X+9VeP
	iHEnh2Pe9ED7OFTgYvr34CseB4fz4LvauqhxxoqZWIOLaoYiLfRc5bPJuZmPbw/8
	foUIh5GkQcADSSDlyhpxpmsyrFyMIa5snwvYoFuFXcaNcW880NCV/5qPQFLClQcc
	c7FGAtv4kvbIe7Y=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 1CE862AA19;
	Mon, 26 Aug 2024 20:35:19 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9CB6B2AA17;
	Mon, 26 Aug 2024 20:35:15 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH 2/5] apply: honor `ignore_ws_none` with `correct_ws_error`
In-Reply-To: <1eb33969-1739-4a27-a77b-3f4268f5519d@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
	message of "Sun, 25 Aug 2024 12:18:28 +0200")
References: <6dd964c2-9dee-4257-8f1a-5bc31a73722e@gmail.com>
	<1eb33969-1739-4a27-a77b-3f4268f5519d@gmail.com>
Date: Mon, 26 Aug 2024 17:35:14 -0700
Message-ID: <xmqqseuqerb1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 3A8E4414-640C-11EF-A2E8-BF444491E1BC-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

Rub=C3=A9n Justo <rjusto@gmail.com> writes:

> Ensure strict matching of context lines when applying with
> `--whitespace=3Dfix` combined with `--no-ignore-whitespace`.
>
> Signed-off-by: Rub=C3=A9n Justo <rjusto@gmail.com>
> ---
>  apply.c                  |  3 ++-
>  t/t4124-apply-ws-rule.sh | 27 +++++++++++++++++++++++++++
>  2 files changed, 29 insertions(+), 1 deletion(-)
>
> diff --git a/apply.c b/apply.c
> index 63e58086f1..0cb9d38e5a 100644
> --- a/apply.c
> +++ b/apply.c
> @@ -2596,7 +2596,8 @@ static int match_fragment(struct apply_state *sta=
te,
>  		goto out;
>  	}
> =20
> -	if (state->ws_error_action !=3D correct_ws_error) {
> +	if (state->ws_error_action !=3D correct_ws_error ||
> +	    state->ws_ignore_action =3D=3D ignore_ws_none) {
>  		ret =3D 0;
>  		goto out;
>  	}

Hmph, if we are correcting for whitespace violations, even if
whitespace fuzz is not allowed externally, wouldn't the issue that
c1beba5b (git-apply --whitespace=3Dfix: fix whitespace fuzz introduced
by previous run, 2008-01-30) corrected still apply?  IOW, isn't this
change introducing a regression when an input touches a file with a
change with broken whitespaces, and then touches the same file to
replace the broken whitespace lines with something else?

