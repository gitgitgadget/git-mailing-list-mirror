Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026581A0713
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 15:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723563690; cv=none; b=lDJuLHFTrTUekxuiQkQMzZbnoxKwOIh4E6259uvgYwzTjaBOd/oAxhqAsle+BwETxBb/Sbnoq/cAM1X4/1nriKlIzaOYJH5GQEx9ADxiFRy/lz7fWaezCOEx7SpbRlP6WaJSDnuxaD9EWBuU1ZUiQYgKdjd3UXFtZz3nvv9D8FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723563690; c=relaxed/simple;
	bh=7ZOvOCIriz8A/WOCexF5xQYQ3bthjk6z4cyGDiYWx+g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bs2cvJU6IiNc1t9UJJF9y2k045Mu6BusFRxpsllo7AWP/NusAC2CTV6vhJfNF6PdTn7LA1hV3dfoHqN94yOsYb2onDcuPSvNvTcsLFwqeQb4AQiCTc/9GyXd5+eR+m6PlEeJZRq4KTLHEBq1TSt1booQ+RrnKBJK4ELbHflE40k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=J6WQDVve; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="J6WQDVve"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5BEAC275C0;
	Tue, 13 Aug 2024 11:41:22 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=7ZOvOCIriz8A/WOCexF5xQYQ3bthjk6z4cyGDi
	YWx+g=; b=J6WQDVvesj66fyb+zkI0T/MplxyhxR8l8A4f1f0kwdhbKdgoh/okSi
	x9FeFC++fhwCbWSm233rdeUs6e41RhlEgVLXUK3ewuWc8d3RhQFFo4haohVanovD
	tJrSdnqH2PhxO/P43QAd2mWYpVJwHVThTiJBwq18FJAruXPp0IXKM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 52C36275BF;
	Tue, 13 Aug 2024 11:41:22 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9F14F275BD;
	Tue, 13 Aug 2024 11:41:21 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Matt Thompson <fortran@gmail.com>,  git@vger.kernel.org
Subject: Re: Bug: Git sees branch as valid commit ref and works; should fail
In-Reply-To: <20240813115358.GB968816@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 13 Aug 2024 07:53:58 -0400")
References: <CAFb48S8LDz4kiWsKSCBn8J=AHyQ5SVPFH4GY=z+8=DntT=PyAw@mail.gmail.com>
	<xmqqy15b2aiz.fsf@gitster.g>
	<CAFb48S8+X0=Zqi8oisB0fAgx7HoyQrahF-RGQdagXTX3RdfSNQ@mail.gmail.com>
	<20240813115358.GB968816@coredump.intra.peff.net>
Date: Tue, 13 Aug 2024 08:41:20 -0700
Message-ID: <xmqqle108m73.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 7D71959C-598A-11EF-A34E-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

Jeff King <peff@peff.net> writes:

>   $ git rev-parse bugfix/mathomp4/trivial-ci-commit-gcc14
>   cc14d30e332cd06327fe5a81ed26c24140882f42
>
> That narrows it down to the name resolution code. If I step through it
> in a debugger, the culprit seems to be get_describe_name().

ROTFL.  Couldn't resist laughing with wonder, as I totally missed
the fact that -gcc14 exactly looks like a valid describe suffix.

> In other words, it's a false positive in the name resolver looking for
> "describe" names. We'd prefer a real ref of that full name, I think, but
> since there isn't one, we prefer the describe resolution rather than
> treating it as a path.
>
> I can think of a few ways to make this better:
>
>   - we ignore everything before the "-g<hex>" part entirely. Generally
>     this should be the name of a tag or at least some ref, so we could
>     perhaps verify that. But part of the point of sticking the hash in
>     the name is that you might have gotten the name from another source,
>     and your local one might not have the same tag. So that might be a
>     bad direction.

Sad but you are absolutely right.

>   - the hash is abbreviated in the usual way, making it as short as
>     possible while remaining unambiguous. But unless the user goes out
>     of their way to set core.abbrev to something smaller, the minimum is
>     always 7. So perhaps get_describe_name() should be a bit more picky
>     about about that?
>
>     That doesn't fix the problem, but it makes it a lot less likely to
>     trigger in the real world. And anybody who really does somehow end
>     up with a describe name with 4 characters can always pick the hash
>     out of the string themselves (or just set core.abbrev in their local
>     repo to be more permissive).

That sounds like not-so-bad a direction to go.  But notice that
autogenerated preformatted documentation repositories record the
corresponding source material using the "describe" name that is
instructed to use absolutely minimum 4 chars when possible.  I would
imagine that it is not only me who does that, assuming that those
who care enough about the correspondence between the commits in
artifact repository and the commits in source repository would have
tags used by the "describe" from the source repository.

> I think the second one is something like this:
>
> diff --git a/object-name.c b/object-name.c
> index 527b853ac4..a90338aa62 100644
> --- a/object-name.c
> +++ b/object-name.c
> @@ -1276,6 +1276,10 @@ static int get_describe_name(struct repository *r,
>  			if (ch == 'g' && cp[-1] == '-') {
>  				cp++;
>  				len -= cp - name;
> +				if (len < (default_abbrev < 0 ?
> +					   FALLBACK_DEFAULT_ABBREV :
> +					   default_abbrev))
> +					return -1;
>  				return get_short_oid(r,
>  						     cp, len, oid, flags);
>  			}

So, perhaps we probably would want to allow shorter than the
fallback default hexadecimal after "-g" _iff_ the leading "tag" part
actually names an existing tag, or something like that.

Thanks.
