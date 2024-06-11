Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFBB14A96
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 15:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718119033; cv=none; b=J/IVbfxXxHFU78KkhdWf8ZjMXMxj5+6cEiefLE8pEnhJH35vaqiq9b4Sflp1cPoWClQ5+AOp8wWUm2u4HVAozq6n3s0YiXTXKueINVKqN5wRa6rOh9hHNkob7jx8ECqwPSWdsTa7SS8GfE00FrXOi0IGKPYXM0Hfvi9sOvV+H/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718119033; c=relaxed/simple;
	bh=F+OCiYBQfJ/J8gFOLq96cV3SsWf/U8iI//snF6eKyzw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LvMkPOVPi0hK/w19EoemzQ+5UvxYjhnqD8e+7+WJpL2DVeRmK9m6vOS+u/YHC6QGh/rhqyTbPb9X1pCMcGAgZjHVgy0wrJTmSg5NlUohhNUIEDz/fnCCgjCS6bJwrbnrJsPHGZxmRZa3w1a1/8nukaYPGVk7uFVlE0PjqXRBS6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=eJv18erK; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="eJv18erK"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id ACA6828129;
	Tue, 11 Jun 2024 11:17:10 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=F+OCiYBQfJ/J8gFOLq96cV3SsWf/U8iI//snF6
	eKyzw=; b=eJv18erK3T9j7xR5Jm7AaHAsPR87buAgmhGYmsoLJRYPwQLcgStvli
	tUTk8kkIrTFJ/hThkL58xRGukIxAkXSKaUDzUgDlQMqFvln+N5izyeWAEKrrI175
	NPlpV++tTKTKkvHciQCyvri6iqVudXKWzGoriDmBNJIIT7kwSs6k4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A2EF028128;
	Tue, 11 Jun 2024 11:17:10 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 136E528127;
	Tue, 11 Jun 2024 11:17:10 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/4] varargs functions with __attributes__(())
In-Reply-To: <20240611081735.GI3248245@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 11 Jun 2024 04:17:35 -0400")
References: <20240608183747.2084294-1-gitster@pobox.com>
	<20240611081735.GI3248245@coredump.intra.peff.net>
Date: Tue, 11 Jun 2024 08:17:08 -0700
Message-ID: <xmqqcyony0ej.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 AC366B3E-2805-11EF-AAAD-6488940A682E-77302942!pb-smtp2.pobox.com

Jeff King <peff@peff.net> writes:

> On Sat, Jun 08, 2024 at 11:37:43AM -0700, Junio C Hamano wrote:
>
>> There are several varargs functions that take either NULL-terminated
>> list of parameters, or printf-like format followed by list of
>> parameters, that are not declared as such with __attributes__(()).
>> 
>> Adding such a missing attribute to trace2_region_enter_printf()
>> revealed that an existing call to it was trying to format a value of
>> type size_t using "%d", which is not such an excellent idea.  Other
>> functions that were lacking attributes fortunately did not have any
>> broken existing callers.
>
> Great, I am happy to see these. I assume you found them all by grepping?
>
> I wonder if there is a way to convince the compiler (or coccinelle) to
> complain about any varargs function that does not have one of our
> usual annotations. It's possible to have other conventions (e.g., an
> "int" up front specifying the number of entries) but in practice I doubt
> we would ever use one.
>
> Still, I suspect the answer is probably "no", there is not an easy way
> to do it.

I just went from grepping for fixed "...)" in *.[ch] files.  I do
admit I wished some form of automation, but didn't come up with one.

I was happy that the exercise found a real bug ;-)  I started it
only as a clean-up topic.
