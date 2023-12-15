Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90BC4122D
	for <git@vger.kernel.org>; Fri, 15 Dec 2023 17:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="TZMeO67N"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 364D72569F;
	Fri, 15 Dec 2023 12:09:21 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=89PODJ2n/yQ75vH6CeTr5zf9s2Dlk7Q6YNxJNq
	2zXLM=; b=TZMeO67NHGTWo2pIwgW400VhjTN6yXqaEINlEB2aApCepVBMpJzU4Y
	oco6RYdP+/nbX2PUsM1WK9MVkDdwEaXgZ7FhC29RR/tbuaNGXVWykyGppSpPx+v7
	JmOgDdOPXCt+i/JuhJ4vMexnFMLitNh13F/rIYIvIJuf4nusuDLGs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 197132569E;
	Fri, 15 Dec 2023 12:09:21 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.193.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B3F3D2569D;
	Fri, 15 Dec 2023 12:09:17 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Jeff King <peff@peff.net>,  =?utf-8?Q?Ren=C3=A9?= Scharfe
 <l.s.r@web.de>,  AtariDreams
 via GitGitGadget <gitgitgadget@gmail.com>,  git@vger.kernel.org,  Seija
 Kijin <doremylover123@gmail.com>
Subject: Re: [PATCH] Use ^=1 to toggle between 0 and 1
In-Reply-To: <99b3a727-36fd-4fa5-a6be-60ae6fc5911e@gmail.com> (Phillip Wood's
	message of "Fri, 15 Dec 2023 14:46:36 +0000")
References: <pull.1620.git.git.1702401468082.gitgitgadget@gmail.com>
	<20231212200920.GC1127366@coredump.intra.peff.net>
	<8bea38fe-38a3-412a-b189-541a6596d623@web.de>
	<20231213080143.GA1684525@coredump.intra.peff.net>
	<4d0b2a5f-305b-4350-b164-44923cb250d8@web.de>
	<20231214220503.GA3320432@coredump.intra.peff.net>
	<99b3a727-36fd-4fa5-a6be-60ae6fc5911e@gmail.com>
Date: Fri, 15 Dec 2023 09:09:16 -0800
Message-ID: <xmqqo7erl7er.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 AE4403C6-9B6C-11EE-975B-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Phillip Wood <phillip.wood123@gmail.com> writes:

> Even if it unlikely that we would directly compare a boolean variable
> to "true" or "false" it is certainly conceivable that we'd compare two
> boolean variables directly. For the integer fallback to be safe we'd
> need to write
>
> 	if (!cond_a == !cond_b)
>
> rather than
>
> 	if (cond_a == cond_b)

Eek, it defeats the benefit of using true Boolean type if we had to
train ourselves to write the former, doesn't it?

> A weather-balloon seems like the safest route forward. We have been
> requiring C99 for two years now [1], hopefully there aren't any
> compilers out that claim to support C99 but don't provide
> "<stdbool.h>" (I did check online and the compiler on NonStop does
> support _Bool).
>
> Best Wishes
>
> Phillip
>
> [1] 7bc341e21b (git-compat-util: add a test balloon for C99 support,
> 2021-12-01)

Nice to be reminded of this one.

The cited commit does not start to use any specific feature from
C99, other than that we now require that the compiler claims C99
conformance by __STDC_VERSION__ set appropriately.  The commit log
message says C99 "provides a variety of useful features, including
..., many of which we already use.", which implies that our wish was
to officially allow any and all features in C99 to be used in our
codebase after a successful flight of this test balloon.

Now, I think we saw a successful flight of this test balloon by now.
Is allowing all the C99 the next step we really want to take?

I still personally have an aversion against decl-after-statement and
//-comments, not due to portability reasons at all, but because I
find that the code is easier to read without it. But in principle,
it is powerful to be able to say "OK, as long as the feature is in
C99 you can use it", instead of having to decide on individual
features, and I am not fundamentally against going that route if it
is where people want to go.

Thanks.

