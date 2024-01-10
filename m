Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98DFC4D10C
	for <git@vger.kernel.org>; Wed, 10 Jan 2024 19:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="JCRPP7VQ"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id E34EB3F694;
	Wed, 10 Jan 2024 14:45:28 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Ft3t5vreluasJP/IAmWKYfANyq4/plgsNr6Htk
	UoGeE=; b=JCRPP7VQ6e2D0UM6rGcokCIdPD7ZsgAOPNI9WYNTnP5sbD68wJuPLl
	uAZfydTIetlVjiEak6ZNEap7LV8GpAQrVEdPNXKV1kSR9ZvirfqCUd1ijiazoR/C
	JYyLQ2MopbQ6Kle7+E2Vqkbl1uFlv5Q5q75LPqnWB5NmT+Iz3BDdo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id DBAA63F693;
	Wed, 10 Jan 2024 14:45:28 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 16FE23F690;
	Wed, 10 Jan 2024 14:45:25 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Emily Shaffer <nasamuffin@google.com>,  Christian
 Couder <chriscool@tuxfamily.org>,  Linus Arver <linusa@google.com>
Subject: Re: [PATCH 00/10] Enrich Trailer API
In-Reply-To: <pull.1632.git.1704869487.gitgitgadget@gmail.com> (Linus Arver
	via GitGitGadget's message of "Wed, 10 Jan 2024 06:51:16 +0000")
References: <pull.1632.git.1704869487.gitgitgadget@gmail.com>
Date: Wed, 10 Jan 2024 11:45:23 -0800
Message-ID: <xmqqy1cx9dm4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 CC62AD1A-AFF0-11EE-9C0B-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

"Linus Arver via GitGitGadget" <gitgitgadget@gmail.com> writes:

> This patch series is the first 10 patches of a much larger series I've been
> working. The main goal of this series is to enrich the API in trailer.h. The
> larger series brings a number of additional code simplifications and
> cleanups (exposing and fixing some bugs along the way), and builds on top of
> this series. The goal of the larger series is to make the trailer interface
> ready for unit testing. By "trailer API" I mean those functions exposed in
> trailer.h.

Are there places in the current code that deals with trailers but
does not use the trailer API (e.g., manually parse and/or insert the
trailer in an in-core buffer)?  Is it part of the larger goal to
update these places so that we will always use the trailer API to
touch trailers, and if so, have these places been identified?

Obviously the reason why I ask is that testing cannot be the goal by
itself.  The "alternative" ...

> As an alternative to this patch series, we could keep trailer.h intact and
> decide to unit-test the existing "trailer_info_get()" function which does
> most of the trailer parsing work.

... may allow you to "test", but it would make it more difficult in
the future to revamp the trailer API, if it is needed, in order to
cover code paths that ought to be using but currently bypassing the
trailer API.

> This series breaks up "process_trailers()" into smaller pieces, exposing
> many of the parts relevant to trailer-related processing in trailer.h. This
> forces us to start writing unit tests for these now public functions, but
> that is a good thing because those same unit tests should be easy to write
> (due to their small(er) sizes), but also, because those unit tests will now
> ensure some degree of stability across new versions of trailer.h (we will
> start noticing when the behavior of any of these API functions change).

And helper functions, each of which does one small thing well, may
be more applicable to other code paths that are currently bypassing
the API.

> Thanks to the aggressive refactoring in this series, I've been able to
> identify and fix a couple bugs in our existing implementation. Those fixes
> build on top of this series but were not included here, in order to keep
> this series small.

It would be nicer to have a concise list of these fixes (in the form
of "git shortlog") as a teaser here ;-).  That would hopefully
entice others into reviewing this part that forms the foundation.

Thanks.
