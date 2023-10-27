Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E013238BB2
	for <git@vger.kernel.org>; Fri, 27 Oct 2023 15:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="B8ZJmO3v"
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF4F21B9
	for <git@vger.kernel.org>; Fri, 27 Oct 2023 08:54:17 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 518EB1CC37D;
	Fri, 27 Oct 2023 11:54:17 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=kWVM5IdLCbPL+Ubv4uwj00ltahDBfqVKJIHzXb
	KnxfE=; b=B8ZJmO3vikHHYhYVuTrEwmC6DWkLOJL9i047ov1pOgh9zTAN5Q7QMK
	b/NTNgxuqGn2gypnmV9FkRRKEzIUBk5Zv/lE8ul/zuOTyErCO151Gvcc6x4gE9zu
	izK64ICxoUpQObr9Zxc22NMxgbIohUZs8UT07XI/kQ5yTPEM1iGq4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 47AD61CC37C;
	Fri, 27 Oct 2023 11:54:17 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.198.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A48401CC37B;
	Fri, 27 Oct 2023 11:54:16 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,  Taylor Blau
 <me@ttaylorr.com>,  git@vger.kernel.org,  stolee@gmail.com
Subject: Re: [PATCH v1 3/4] config: factor out global config file
 retrievalync-mailbox>
In-Reply-To: <ZTjMMC1GiPJUXnQm@tanuki> (Patrick Steinhardt's message of "Wed,
	25 Oct 2023 10:05:04 +0200")
References: <cover.1697660181.git.code@khaugsbakk.name>
	<147c767443c35b3b4a5516bf40557f41bb201078.1697660181.git.code@khaugsbakk.name>
	<ZTZDqToqcsDiS5AP@tanuki> <ZTav2u1JWmLexEHL@nand.local>
	<87badbe0-de18-4f8a-9589-314cea46065e@app.fastmail.com>
	<ZTip7JWm-WRWTImU@tanuki>
	<2b764f52-d3ae-467f-a915-fb73beb247bb@app.fastmail.com>
	<ZTjMMC1GiPJUXnQm@tanuki>
Date: Sat, 28 Oct 2023 00:54:15 +0900
Message-ID: <xmqq8r7ooyc8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 152E7470-74E1-11EE-AA15-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> This parameter would only exist for the purpose of the error message,
> right? If so, I think that'd be overkill. If we want to have differing
> errors depending on how the function is called the best way to handle
> that would likely be to generate the error message at the callsite
> instead of in the library itself.

We would need to make sure the lower-level helpers need to be able
to tell what kind of failure they saw (in other words, why they are
failing) to the callers, which may require a bit of designing the
error return convention and plumbing through necessary pieces of
information, but the longer term payoff would be great.

I do not think this is such a case, but if the lower-level needs to
fail differently (e.g., the thing not existing is acceptable when
writing as we will create a new one, but is a fail-worthy error when
reading), then the caller needs to give that down the callchain,
though.
