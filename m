Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB091C693
	for <git@vger.kernel.org>; Fri,  2 Aug 2024 14:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722610684; cv=none; b=uiH6LIaytlIGJuU3YsaIaXq4IKP6u46TzWk+lrQiaIdvUsRo9KQYJtJ8xWsHEOtDbKuJDYJR64geU5PpB10zcVtXAXLUnuz3QbjOUz0RkBetD09z9E9zWHeZxE2S6Id8VCkjRp0HcOhxQwfkLoAU8BCxiV8nwk0TQKKwXKQftvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722610684; c=relaxed/simple;
	bh=TVbYpXhxDpnQtfDH9Aw18LlR4oJbBpyOkE3Epjd8xpc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=B4/3bBFh7JHZOsRYO3+o0MowvpDd1bz/n1OEQxfmr3MZ9+vsIfIrgC6rouFHXntQBqsOWv4qfRvNo4okRARHVqq1BSktN5MZwutsrSbuNhxeK3gNKGsvsBhgm9KPLcuApqnezckt7jEaIAfA4BzXzQjZlwT1zLeU81l4MUV1el0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=k6yGzcLa; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="k6yGzcLa"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 382DE263FA;
	Fri,  2 Aug 2024 10:57:56 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=TVbYpXhxDpnQtfDH9Aw18LlR4oJbBpyOkE3Epj
	d8xpc=; b=k6yGzcLa3rGR5dHyTbnKijYG1jZJzuFef9+ahyxPjLW5q15yAtYehS
	AaV42PcnqQk5Okrq1BUl2vNeNZRmWIQhC+6WV6ed8J+O9Utb8kyUDJkZ0fFTX8By
	YU8dHR43rAQCItynMuNzM9I40onyA6b577NnnaFqeSTghdssWwqEk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 30B88263F9;
	Fri,  2 Aug 2024 10:57:56 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 92B6E263F8;
	Fri,  2 Aug 2024 10:57:55 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Andrew Morton <akpm@linux-foundation.org>,  git@vger.kernel.org
Subject: Re: quiltimport mode detection oddity
In-Reply-To: <20240802035121.GB1246312@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 1 Aug 2024 23:51:21 -0400")
References: <20240801155702.70242c31d476c46c84ee11a3@linux-foundation.org>
	<xmqqed77hifn.fsf@gitster.g>
	<20240801180706.933d797b0ae5744fdcdf47d2@linux-foundation.org>
	<20240802035121.GB1246312@coredump.intra.peff.net>
Date: Fri, 02 Aug 2024 07:57:54 -0700
Message-ID: <xmqq7cczgefh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 9991F32E-50DF-11EF-8E90-BAC1940A682E-77302942!pb-smtp2.pobox.com

Jeff King <peff@peff.net> writes:

> Given that, I think it is reasonable for git to also normalize the mode
> of the patches it reads, so that we are consistently working in the
> world of simplified modes. I.e., this:
>
> diff --git a/apply.c b/apply.c
> index 142e3d913c..3d50fade78 100644
> --- a/apply.c
> +++ b/apply.c
> @@ -995,6 +995,7 @@ static int parse_mode_line(const char *line, int linenr, unsigned int *mode)
>  	*mode = strtoul(line, &end, 8);
>  	if (end == line || !isspace(*end))
>  		return error(_("invalid mode on line %d: %s"), linenr, line);
> +	*mode = canon_mode(*mode);
>  	return 0;
>  }
>  
>
> which makes the warning go away in the example above. But I'm not sure
> if there could be other fallout. E.g., is there a mode for git-apply to
> just touch the working tree and not the index, where we'd perhaps want
> to retain the original to compare against the filesystem mode? I don't
> think so.

Makes sense.

The above is consistent with what we do for the permission bits;
only the execute bit matters, and the patch recording 100664 should
mean the same thing to us as permission bits 100644---we should warn
if the on-disk file is executable while applying such a patch, and
we should not warn otherwise.

> Alternatively (or maybe in addition), I wonder if quilt should similarly
> canonicalize the mode. git-apply is certainly meant to work with patches
> generated elsewhere, but normal patches don't have modes in them at all.
> The "deleted file mode" line is git-ism, so here we have something which
> is implementing the git line in a (slightly) incompatible way.

It's an orthogonal fix and probably worth doing.

If a third-party tool adds git-ism mode lines, we should be lenient
when we see a wrong mode, as long as the leniency does not affect
our normal mode of operation negatively.  It is OK if they record a
non-executable regular file with 100666.  Using 664 (no type bits)
or 100755, however, crosses the line and they must stop producing
such a bogus mode line, if they do not want to see a warning.


