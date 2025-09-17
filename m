Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6BE4086A
	for <git@vger.kernel.org>; Wed, 17 Sep 2025 12:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758110856; cv=none; b=J7cyCRXsbPwkoSGjI9Qxfx/765RA8a59CIRPC0zYptS7CtknpLaJRqrLb/o48pqKvBYiYkj6vc55i0baQZbakLvUVJo9C8gn/yB1oHhtFqRXK4bMURLlKkf6vULqS3klmqeJvSK73bsrcA7P2GHJN03OZ4OU86VRr4B747IfZTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758110856; c=relaxed/simple;
	bh=XFGqed9xt5nRnCGDAl5qxgPu8wCSt/RwcQeaTr989aI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ow3Hl5ISqIIfR7S4ZZt11d+D+qn3fnQjP9AWQsH8tqo3glLADHFXlhruc6/PYq73I8EjiAccMZM6YY8cNo3VnW75U+pGOcEX/ir+1HYnWYXVDWLq4ROYU6kzoHNkPdnoM0xrfXwAoxtymwDrM9cG5GcSh1+cxaGVTWbRksNIh9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from mop.sam.mop (2.8.3.0.0.0.0.0.0.0.0.0.0.0.0.0.a.5.c.d.c.d.9.1.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:19dc:dc5a::382])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sam)
	by smtp.gentoo.org (Postfix) with ESMTPSA id E5B4D340EAF;
	Wed, 17 Sep 2025 12:07:29 +0000 (UTC)
From: Sam James <sam@gentoo.org>
To: Patrick Steinhardt <ps@pks.im>
Cc: Ezekiel Newren <ezekielnewren@gmail.com>,  git@vger.kernel.org,
  "Haelwenn (lanodan) Monnier" <contact@hacktivis.me>,  "brian m. carlson"
 <sandals@crustytoothpaste.net>,  Ben Knoble <ben.knoble@gmail.com>,
  Christian Brabandt <cb@256bit.org>,  Collin Funk
 <collin.funk1@gmail.com>,  Eli Schwartz <eschwartz@gentoo.org>,  Elijah
 Newren <newren@gmail.com>,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>,  Junio C Hamano <gitster@pobox.com>,
  Phillip Wood <phillip.wood123@gmail.com>,  Pierre-Emmanuel Patry
 <pierre-emmanuel.patry@embecosm.com>,  Taylor Blau <me@ttaylorr.com>,
  Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v5 0/9] Introduce Rust and announce that it will become
 mandatory
In-Reply-To: <aMk2mo5OHPNQi0PW@pks.im>
Organization: Gentoo
References: <20250904-b4-pks-rust-breaking-change-v1-0-3af1d25e0be9@pks.im>
	<20250915-b4-pks-rust-breaking-change-v5-0-dc3a32fbb216@pks.im>
	<CAH=ZcbB0Qv=b-hdB2EVW-D-dob4NnzyWDYGEThYZm94S0V7OGg@mail.gmail.com>
	<aMk2mo5OHPNQi0PW@pks.im>
User-Agent: mu4e 1.12.12; emacs 31.0.50
Date: Wed, 17 Sep 2025 13:07:26 +0100
Message-ID: <87plbpffk1.fsf@gentoo.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Mon, Sep 15, 2025 at 08:03:29PM -0600, Ezekiel Newren wrote:
>> I am currently working on a patch series that makes Rust optional and
>> addresses several concerns that this series does not:
>>   * Rust calling C: Makefile has no way to build or run Rust so it
>> would have to call cargo test, but that doesn't work unless build.rs
>> tells cargo where libgit.a is (among other things).
>>   * Build tooling alignment: My build_rust.sh is called by make and
>> meson which eliminates defining how to build Rust in 2 places.
>>   * Cargo vs Meson: Meson is adding support for Rust and it's getting
>> better, but Cargo is the canonical build system for Rust. cargo is
>> released in lockstep with rustc, and we _have_ to use cargo when
>> building with make because Meson won't be available in that case.
>>   * Crates: Patrick's series assumes the Git codebase is _the_ crate
>>     * cbindgen: Cbindgen outputs a single header file for each crate,
>> with only 1 we'll have an unmanageably large auto generated header
>> file.
>>     * Modularity: Using multiple crates makes Git more modular. Elijah
>> told me that there was some desire to make Git more modular.
>>     * Cargo Dependencies: Patrick wrote his series with Meson first in
>> mind which doesn't address how we'll be able to use crates from
>> crates.io
>>   * CI:
>>     * Sparse coverage: I think there's only one target that tests his changes.
>>     * With vs Without Rust: I don't see anywhere that he covers
>> building with vs without Rust in CI
>>   * Build integration: Meson has to have every .rs file specified
>> where as the default layout of a Rust project allows Cargo to just
>> know where to look for .rs files
>
> Yeah, as I mentioned my patch series here really aims at getting an
> minimum viable user of Rust into the Git codebase so that we can focus
> the discussion more on the roadmap towards Rust rather than the actual
> Rust infrastructure. The whole infra is very simplistic because of that,
> but that is intentional for now.
>
> Once we have agreed on the roadmap I very much expect that we will
> iterate on it to allow for more complex use cases. My next step would
> have been to pick patches from your series that make all of this work
> on Windows. But of course I don't have to be the (only) one to iterate
> on the initial simple infrasturcture, this should ideally be an effort
> by the whole community.
>
> And yes, many of the points you mention above are things we'll have to
> address over time to make Rust a viable alternative to implement
> anything more complex than the trivial "varint.c" thing. I think that
> iteration is key here: let's start simple and then gradually build out
> the infrastructure.

I think adding external crates especially will need discussion given the
licencing and "offline" issues (which are solvable but they should be
examined).

>
> Patrick
