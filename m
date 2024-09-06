Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8CC14883B
	for <git@vger.kernel.org>; Fri,  6 Sep 2024 21:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725659057; cv=none; b=UZ2fuLT/ywR+ncjjvDFjsbCPdjMyz0iqo+d0MLV7e+rrTBe/67u+kzutZqBHuR6mjuYRw46GKcJX6y/5bkUOlZq/w8zsqGIF3uM9FRzzBuzUv/Jwk8uFMIht7A10cIE7+O/0ahJSdxqNaiPHkGTJm5xkP+06aZMDIaJmxske+c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725659057; c=relaxed/simple;
	bh=1EHXQ9Z/B96ApGIGlJ6s+hCWKg7yBsnt55E3zqBMD/k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FdbYSbEzKcrFt0zBDNQs2SvjbejFUe1Qtvt6hJfTn6xmvgjtVy0kOATQf/l6qcJjQvRJmt3fAIqaC4UfokY/YFxS4Ia3Gruro72qzmdTdvVAZ2DDMJ8TpHStoN1qVIv2g7MtsTPRJPcagKUhryL1HaItC/+1XwBoYE++K0bmXy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=iteFf5ZH; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="iteFf5ZH"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 26CF91F19D;
	Fri,  6 Sep 2024 17:44:14 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=1EHXQ9Z/B96ApGIGlJ6s+hCWKg7yBsnt55E3zq
	BMD/k=; b=iteFf5ZHDgzxhwPPFgGj6qwxhx8Zi3xa8N2P/D1sdFm2E4d+/ID9MZ
	pK4MeKwr1Qqcd1iVqCZFjV0ei4J1rJuTEwyy73eEQs/twsa10AIWTdzzRnKfF4IU
	Z0JKxAPql6DYrIT5PiOvkemV4H9SAe5f59dhHMqagJdpdvWSW8vsI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 1E35D1F19B;
	Fri,  6 Sep 2024 17:44:14 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 810A11F19A;
	Fri,  6 Sep 2024 17:44:13 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  "brian m. carlson"
 <sandals@crustytoothpaste.net>,  Elijah Newren <newren@gmail.com>,
  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v3 3/9] finalize_object_file(): implement collision check
In-Reply-To: <0feee5d1d4fc1e0aa1ca5d98f2f404ecdbb2f6b6.1725651952.git.me@ttaylorr.com>
	(Taylor Blau's message of "Fri, 6 Sep 2024 15:46:12 -0400")
References: <cover.1725206584.git.me@ttaylorr.com>
	<cover.1725651952.git.me@ttaylorr.com>
	<0feee5d1d4fc1e0aa1ca5d98f2f404ecdbb2f6b6.1725651952.git.me@ttaylorr.com>
Date: Fri, 06 Sep 2024 14:44:12 -0700
Message-ID: <xmqqh6asv4nn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 28683A84-6C99-11EF-B738-9B0F950A682E-77302942!pb-smtp2.pobox.com

Taylor Blau <me@ttaylorr.com> writes:

> Note that this may cause some extra computation when the files are in
> fact identical, but this should happen rarely. For example, when writing
> a loose object, we compute the object id first, then check manually for
> an existing object (so that we can freshen its timestamp) before
> actually trying to write and link the new data.

True.

> +static int check_collision(const char *filename_a, const char *filename_b)
> +{
> +	char buf_a[4096], buf_b[4096];
> +	int fd_a = -1, fd_b = -1;
> +	int ret = 0;
> +
> +	fd_a = open(filename_a, O_RDONLY);
> +	if (fd_a < 0) {
> +		ret = error_errno(_("unable to open %s"), filename_a);
> +		goto out;
> +	}
> +
> +	fd_b = open(filename_b, O_RDONLY);
> +	if (fd_b < 0) {
> +		ret = error_errno(_("unable to open %s"), filename_b);
> +		goto out;
> +	}

Two and two half comments on this function.

 * We compare 4k at a time here, while copy.c copies 8k at a time,
   and bulk-checkin.c uses 16k at a time.  Outside the scope of this
   topic, we probably should pick one number and stick to it, unless
   we have measured to pick perfect number for each case (and I know
   I picked 8k for copy.c and 16k for bulk-checkin.c both out of
   thin air).

 * I would have expected at least we would fstat() them to declare
   difference immediately after we find their sizes differ, for
   example.  As we assume that calling into this function should be
   rare, we prefer not to pay in complexity for performance here?

 * We use read_in_full() and assume that a short-read return from
   the function happens only at the end of file due to EOF, which is
   another reason why we can do away without fstat() on these files.

 * An error causes the caller to assume collision (because we assign
   the return value of error() to ret), which should do the same
   action as an actual collision to abort and keep the problematic
   file for forensics.

>  /*
>   * Move the just written object into its final resting place.
>   */
> @@ -1941,8 +1992,8 @@ int finalize_object_file(const char *tmpfile, const char *filename)
>  			errno = saved_errno;
>  			return error_errno(_("unable to write file %s"), filename);
>  		}
> -		/* FIXME!!! Collision check here ? */
> -		unlink_or_warn(tmpfile);
> +		if (check_collision(tmpfile, filename))
> +			return -1;
>  	}

OK.
