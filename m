Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71774D103
	for <git@vger.kernel.org>; Wed, 10 Jan 2024 17:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="YdFXvOZr"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 873741C71A9;
	Wed, 10 Jan 2024 12:30:53 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=9PUG/T2yo95NxOSJbSGH/+HQaGVfpE/0itqooi
	apF9s=; b=YdFXvOZrcIXe5hj51iZOH0u1R6tT5WiQ8dPjm3tq67DpVVOJoLYnF3
	kEJHOdU7XAraS3jX+RFhx/nz8sOREeI3bG9mZNVQTJFB7TPlfL4dF0cQOnuxnkKM
	WdckXWTGtyEuY/JkaGheLM8oFg8lBmh0Z08XxxxO1uxs9hKuKyCOs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7EC291C71A5;
	Wed, 10 Jan 2024 12:30:53 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DF0F81C719C;
	Wed, 10 Jan 2024 12:30:52 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH 1/4] reftable/stack: refactor stack reloading to have
 common exit path
In-Reply-To: <01ece2626dd4cb494829e146d99c172fa8428478.1704714575.git.ps@pks.im>
	(Patrick Steinhardt's message of "Mon, 8 Jan 2024 13:18:31 +0100")
References: <cover.1704714575.git.ps@pks.im>
	<01ece2626dd4cb494829e146d99c172fa8428478.1704714575.git.ps@pks.im>
Date: Wed, 10 Jan 2024 09:30:51 -0800
Message-ID: <xmqqmstdccz8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 00FDA0F6-AFDE-11EE-A862-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> The `reftable_stack_reload_maybe_reuse()` function is responsible for
> reloading the reftable list from disk. The function is quite hard to
> follow though because it has a bunch of different exit paths, many of
> which have to free the same set of resources.
>
> Refactor the function to have a common exit path. While at it, touch up
> the style of this function a bit to match our usual coding style better.
> ---
>  reftable/stack.c | 86 +++++++++++++++++++++++-------------------------
>  1 file changed, 42 insertions(+), 44 deletions(-)

Missing sign-off.

Other than that, I did not find anything questionable in the
conversion.  By sticking to the two simple invariants:

 - we use "err" as our return value when we jump to "out:"

 - we always keep "names" and "names_after" freeable, and free them
   when we jump to "out:".

the exit status and leak prevention are both very clear (and the
behaviour is not changed---it is not like there are any existing
leaks that are plugged by this restructuring of the loop).

