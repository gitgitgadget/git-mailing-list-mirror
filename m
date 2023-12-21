Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3346364A94
	for <git@vger.kernel.org>; Thu, 21 Dec 2023 18:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="QSUJ7tSq"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 855F218678;
	Thu, 21 Dec 2023 13:20:47 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=R3p9a0CWMIurA8QkIgMAfaVtW3mp0hsuZOIbNG
	9OFY0=; b=QSUJ7tSqaA28T5gqH99jv0jhSvTz/f/7Wtzvo59irsso4i3VrRdRUA
	InpxBRyGI48dgE4yBH+pLx2wMj7kfJe8O6sh20vZ1SUVz9CukeLdtSDIMTqNa7yT
	43DPWjshauxxTo7RF1M4KHcnkYfvIR6hSStOBTQjHcJ1NA6jOf48M=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 7E56F18677;
	Thu, 21 Dec 2023 13:20:47 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.193.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 22CD518675;
	Thu, 21 Dec 2023 13:20:44 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Derrick Stolee <stolee@gmail.com>,  git@vger.kernel.org,  Josh Steadmon
 <steadmon@google.com>
Subject: Re: [PATCH/RFC] sparse-checkout: take care of "--end-of-options" in
 set/add
In-Reply-To: <20231221083643.GA545870@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 21 Dec 2023 03:36:43 -0500")
References: <xmqqbkakqx6s.fsf@gitster.g>
	<20231221083643.GA545870@coredump.intra.peff.net>
Date: Thu, 21 Dec 2023 10:20:42 -0800
Message-ID: <xmqqfrzvmn7p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 A7A44A7E-A02D-11EE-BC84-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Jeff King <peff@peff.net> writes:

> Which would mean that simply dropping --end-of-options from the list, as
> your patch does, would be similarly unsafe. It is papering over the
> problem of:
>
>   git sparse-checkout --end-of-options foo
>
> but leaving:
>
>   git sparse-checkout --end-of-options --foo
>
> broken.

Hmph, I do not understand.  The latter case we want to take "--foo"
as the sole parameter to the subcommand, no?

> But the plot thickens! Curiously, in both of these cases, we do not do
> any further parsing of the options at all. We just treat them as
> pattern arguments with no special meaning.

Exactly.

> So your patch is actually OK, but I would argue that the correct fix
> here is to drop the use of PARSE_OPT_KEEP_UNKNOWN_OPT at all. I cannot
> find any indication in the history on why it was ever used. It was added
> when the command was converted to parse-options in 7bffca95ea
> (sparse-checkout: add '--stdin' option to set subcommand, 2019-11-21).
> Back then it was just called KEEP_UNKNOWN. Later it was renamed to
> KEEP_UNKNOWN_OPT in 99d86d60e5 (parse-options: PARSE_OPT_KEEP_UNKNOWN
> only applies to --options, 2022-08-19) to clarify that it was only about
> dashed options; we always keep non-option arguments.

Yes.

> So looking at that original patch, it makes me think that the author was
> confused about the mis-named option, and really just wanted to keep the
> non-option arguments. We never should have used the flag all along (and
> the other cases were cargo-culted within the file).

That is something only the original author can answer, by my working
theory has been they wanted to have a cheap way to allow any string,
even the ones that happen to begin with a dash, to be passed as one
of the patterns.

> There is one minor gotcha, though. Unlike most other Git commands,
> sparse-checkout will happily accept random option names and treat them
> as non-option arguments. E.g. this works:
>
>   git sparse-checkout add --foo --bar
>
> and will add "--foo" and "--bar" as patterns. If we remove the flag,
> we'd be breaking that.

Exactly.  The user _should_ protect these "patterns" by using
"--end-of-options" before "--foo" above, but we have been taking the
patterns with such a loose parser for quite some time, so tightening
would be taken as a regression X-<.

> But I'd argue that anybody relying on that is
> asking for trouble. For example, this does not work in the same way:
>
>   git sparse-checkout add --skip-checks --foo
>
> because "--skip-checks" is a real option. Ditto for any other options,
> including those we add in the future. If you don't trust the contents of
> your arguments, you should be using "--" or "--end-of-options" to
> communicate the intent to the command.

Exactly.  My response to the other message, with a new test,
summarizes my position.

Thanks.
