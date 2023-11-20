Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="n+WFU4Ur"
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D9DFC7
	for <git@vger.kernel.org>; Mon, 20 Nov 2023 12:21:49 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id F321626008;
	Mon, 20 Nov 2023 15:21:48 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=0B8TGdHjTAxDmdvchhFkcPV4Cs8OtEN+Ke9ZwW
	pMzB0=; b=n+WFU4UrR1JE6P43hNPPw/q/n7mtH948cjJZ649OyBWpFDplPYcV4U
	HEGxLghSwFEQUpjUgbDp6Z79VDt3URmdD4YNQOsrrSpvr4qUU7GHsvu4+pIvzm32
	Vicy1aXmweG8aNolqIcpTHlvRThqQhzED9f45pCjqPLF65bIww1bE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id EB5BD26007;
	Mon, 20 Nov 2023 15:21:48 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 893B626006;
	Mon, 20 Nov 2023 15:21:45 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Kousik Sanagavarapu <five231003@gmail.com>,  Liam Beguin
 <liambeguin@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH 2/2] pretty: add '%aA' to show domain-part of email
 addresses
In-Reply-To: <xmqqv8apgf4y.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
	30 Oct 2023 08:53:01 +0900")
References: <20231026-pretty-email-domain-v1-2-5d6bfa6615c0@gmail.com>
	<20231027184357.21049-1-five231003@gmail.com>
	<xmqq7cn7obah.fsf@gitster.g>
	<20231028021301.GA35796@coredump.intra.peff.net>
	<xmqqv8apgf4y.fsf@gitster.g>
Date: Tue, 21 Nov 2023 05:21:43 +0900
Message-ID: <xmqqwmucjhuw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 6CFA9A26-87E2-11EE-938E-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> Another line of thought is perhaps it is potentially useful to teach
> the --format= machinery to be a bit more programmable, e.g. allowing
> to compute a substring of an existing field %{%aE#*@} without having
> to waste a letter each for the local part and domain part.  But as I
> already said, we are now talking about "postprocessing", and adding
> complexity to our codebase only to have incomplete flexibility may
> not be worth it.  A more specific %(authoremail:localpart) and its
> domain counterpart may be easier to explain and understand.
>
> In any case, it is a bit too late to say "let's not waste the
> precious single letter namespace to add useless features", as we
> have come way too far, so I do not mind too much using a currently
> unused letter $X for yet another author and committer trait.

When I wrote the above, I somehow forgot the existing work in the
ref-filter (aka "for-each-ref") placeholders, where we have support
to a lot more flexible way to customize these things.

For example, "%(authoremail:mailmap,localpart)" can be used to say,
instead of wasting two letters 'l' and 'L' out of precious 52, that
we want e-mail address honoring the mailmap, and take only the local
part.  And the support for the host part of the address that this
topic discussed should be implementable fairly easily (just adding
EO_HOSTPART bit to the email_option structure would be sufficient)
on the ref-filter side.

We saw efforts from time to time to give "log --pretty=format:" more
of the good things from the "for-each-ref --format=" placeholders
(and vice versa), and it may give us a good way forward.

