Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660B81411FE
	for <git@vger.kernel.org>; Mon,  8 Apr 2024 15:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712590951; cv=none; b=GCkAaLS+wcTBLghL/zv6QkbzI0W1NGZwxPazUhjT/eUeBpMZNzkA3O4houyFBShJcnb6lHoxORZmPjPGqZSppgQt6lGSale2bZd6eoTMY7Z8wOknIAF2kZrTYkO5BwLY2MVHjNWMQ3Y+TCGUGxV981QOt4H3tNtAJXKvmfV+D6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712590951; c=relaxed/simple;
	bh=PqiBXbcVWj0rDPAt+gy4E9H8GnzHl/64n5tzcEOwwyQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rHDnhRXK9Bm7QCsqBC/gVkvBp74hOr2BdLOih2mv1pzH9VazsVSMH5fQ4ZJfvNLWC7NN1wt9eOIGq4VVb5fvIcBO0GSnWDiazflGirPGLIQ6AgkQz5iKN55KPK4WGJ1DAcWV7KUjj6DiAv7UrEFBbpGj2QZQV3VejT54frBiu+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=OkiXgLb/; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="OkiXgLb/"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B1C211D95BC;
	Mon,  8 Apr 2024 11:42:21 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=PqiBXbcVWj0rDPAt+gy4E9H8GnzHl/64n5tzcE
	OwwyQ=; b=OkiXgLb/pqdFKflpvbFL7XNJht5IxQsRyHovjh7LDBgB256hJpGfcL
	d2EKoa8oS9msPJ4DPH1+S6UUacfB0v2RxEiJYt6TtZTU1RlZdGOJvbmhxy8aD6pX
	JBBQFDzXdDEspRsb7gjlOEWr8SaDFYSxMurBXtNSHn9Sqa2ONxM8M=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AA64C1D95BB;
	Mon,  8 Apr 2024 11:42:21 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1887A1D95BA;
	Mon,  8 Apr 2024 11:42:21 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,  Git List
 <git@vger.kernel.org>,  Han-Wen
 Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH] reftable: use xmalloc() and xrealloc()
In-Reply-To: <ZhOETox9FTIOAShN@tanuki> (Patrick Steinhardt's message of "Mon,
	8 Apr 2024 07:44:46 +0200")
References: <963961ee-0f1d-42b8-8dda-5838e7a2ed94@web.de>
	<ZhOETox9FTIOAShN@tanuki>
Date: Mon, 08 Apr 2024 08:42:19 -0700
Message-ID: <xmqq34rvg8tg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 9669D094-F5BE-11EE-BEE2-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> These are part of the library interfaces that should ideally not be tied
> to the Git code base at all so that they can theoretically be reused by
> another project like libgit2. So I think that instead of rewriting the
> generic fallbacks we should call `reftable_set_alloc()` somewhen early
> in Git's startup code.

It sounds like a sensible approach to me on the surface.

The reftable_subsystem_init() function, which would be the interface
into "reftable library" from Git side, can call such customization
functions supplied by the library.

> It does raise the question what to do about the generic fallbacks.

Generic fallbacks would be a plain vanilla malloc(), realloc(), and
friends, right?

> We could start calling `abort()` when we observe allocation
> failures. It's not exactly nice behaviour in a library though,
> where the caller may in fact want to handle this case.

But they would not be able to "handle" it, unless their substitute
alloc() function magically finds more memory and never runs out.  If
you want to allow them to "handle" the situation, the library itself
needs be prepared to see NULL returned from the allocator, and fail
the operation it was doing, and return an error.  If the caller asks
reftable_write_foo(), which may need to allocate some memory to
finish its work, it would see NULL and say "sorry, I cannot
continue", and return an error to its caller, I would imagine.

I think there are two levels of "handling" allocation and its
failure.  Substituting allocation functions would be a way to solve
only one of them (i.e. somehow allow the library client to specify a
way to supply you an unbounded amount of memory).  As long as the
library is not willing to check allocation failures and propagate
the error to the caller, you would have to "abort" the operation no
matter what before returning the control back to your client, and at
that point you would start wanting to make it customizable how to
"abort".  Their custom "abort" function might do longjmp() to try to
"recover", or simply call die() in our case where Git is the library
client, I guess.  So reftable_set_alloc() and reftable_set_abort() may
need to be there.  If you make it mandatory to call them, you can punt
and make it the responsibility of the library clients to worry about
error handling, I guess?

Thanks.



