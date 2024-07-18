Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2381B86D0
	for <git@vger.kernel.org>; Thu, 18 Jul 2024 16:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721320186; cv=none; b=Q8Xz4sfe3W6pNrNXSb62Lrn3hXjV3ue60lArtRjlFCNepU3iBkW+LoyHHZd1ZQTULr3cc5IKQk7qXxSzSdLjxw3pD9Q0gSoTrqA6kTI1z0zCX9YaUcQPdqg1W1Y5M6RB2WigygYVifraDNGzHD8FscUsjcEwbi014L2eh6/yhks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721320186; c=relaxed/simple;
	bh=87ZshmxNTEadscgy4SdfYIYHEQDJ7oXRnwIM1iQIGBo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=g4EVcKS1D4aCsBBPg/K15h6+Nkw/z+IsQ6+WhcA48pjeOq5a8zrQIQSWYvlIJmhHmYsmsQIRJymfQlM6c/ox2qukljvdKl0Ny6qFuDzMtkhMu5HPZlcs48cTTJvng8A/BvfhymtWUAoBTLgk6E6szLhLZfEQT8Wz+s92smPGKgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=vnG8ALdw; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="vnG8ALdw"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 346A42BDBC;
	Thu, 18 Jul 2024 12:29:37 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=87ZshmxNTEadscgy4SdfYIYHEQDJ7oXRnwIM1i
	QIGBo=; b=vnG8ALdw+gZTq7iATroX3Zdz6Uf9oifruGoLf8jhMjrNc+wT1fUY4W
	uoiZyDbtdeiEcFaV5TrTXZOPMRAO0TIt8E3380BSytYCXplK1+bLOu5jJx1tMqLQ
	SIU+wNb0qJIDgf7l9T+b9tIgTGci487Bd7IpNcFtQ9gQcV6eO9sDw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2C9752BDBB;
	Thu, 18 Jul 2024 12:29:37 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 973712BDBA;
	Thu, 18 Jul 2024 12:29:36 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Phillip Wood
 <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH] add-patch: handle splitting hunks with
 diff.suppressBlankEmpty
In-Reply-To: <pull.1763.git.1721312619822.gitgitgadget@gmail.com> (Phillip
	Wood via GitGitGadget's message of "Thu, 18 Jul 2024 14:23:39 +0000")
References: <pull.1763.git.1721312619822.gitgitgadget@gmail.com>
Date: Thu, 18 Jul 2024 09:29:35 -0700
Message-ID: <xmqqikx2wtn4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 EC3C4BC4-4522-11EF-A570-34EEED2EC81B-77302942!pb-smtp1.pobox.com

"Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> When "add -p" parses diffs, it looks for context lines starting with a
> single space. But when diff.suppressBlankEmpty is in effect, an empty
> context line will omit the space, giving us a true empty line. This
> confuses the parser, which is unable to split based on such a line.
>
> It's tempting to say that we should just make sure that we generate a
> diff without that option.  However, although we do not parse hunks that
> the user has manually edited with parse_diff() we do allow the user
> to split such hunks. As POSIX calls the decision of whether to print the
> space here "implementation-defined" we need to handle edited hunks where
> empty context lines omit the space.
>
> So let's handle both cases: a context line either starts with a space or
> consists of a totally empty line by normalizing the first character to a
> space when we parse them. Normalizing the first character rather than
> changing the code to check for a space or newline will hopefully future
> proof against introducing similar bugs if the code is changed.
>
> Reported-by: Ilya Tumaykin <itumaykin@gmail.com>
> Helped-by: Jeff King <peff@peff.net>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---

Well written.  Thanks for a pleasant read.

> @@ -953,7 +960,7 @@ static int split_hunk(struct add_p_state *s, struct file_diff *file_diff,
>  	context_line_count = 0;
>  
>  	while (splittable_into > 1) {
> -		ch = s->plain.buf[current];
> +		ch = normalize_marker(s->plain.buf + current);

I wondered if &s->plain.buf[current] is easier to grok, but what's
written already is good enough ;-)

There is another explicit mention of ' ' in merge_hunks().  Unless
we are normalizing the buffer here (which I do not think we do),
wouldn't we have to make sure that the code over there also knows
that an empty line in a patch is an unmodified empty line?

                if (plain[overlap_end] != ' ')
                        return error(_("expected context line "
                                       "#%d in\n%.*s"),

