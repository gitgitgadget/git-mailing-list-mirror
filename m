Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490C0801
	for <git@vger.kernel.org>; Thu, 16 May 2024 16:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715877166; cv=none; b=Vr0ZBorLyNqXM8vdMjS0GZUYDH75VwMPS94po1AYDPmI2LLM/5bjEXru61Nju6QEywgwLzGl8YwmDo6/ZFs38MfStP/c2FHfEsg+eOIQqHGttxNqNh5+LIbcZ/n0lyen8oIWiIUNBo4ARRaE393LdQ+wq5ck91YOQWup3p+IDJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715877166; c=relaxed/simple;
	bh=LChZeapQCr3FcPFYk/493YUpulfjWyACgNZZ5c2D3pY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QOsaeMjDDPtXIGuao+FTjavtr9xPsxxyGISCn7kOAQCj+vswOWXq4KIvKFRHAUALWjk4m0RG33Jup1muJ6Gt1f9Vgaq29tqMkD8kpy8Eu0l4BADnzxYJev93b/kxAlWXz9hhFjGvNcAeUjW86M2o2gF416iWhn6lOLR8U9ZXC7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=utSLyTQy; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="utSLyTQy"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 2E8BC26E92;
	Thu, 16 May 2024 12:32:41 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=LChZeapQCr3FcPFYk/493YUpulfjWyACgNZZ5c
	2D3pY=; b=utSLyTQyOM77i3zoTJT+WQfTyQSOU66pzq0EFsv494367dDWegWt1l
	5BrOK/DyoIPK/Ax/nc0czFiIOc1qV3JH//TKC7W53B8agRIh4fEcrodEmE11/cdh
	3kuJ34bTH6v8L4RSA/mQ1j0YJQ9j34dsBfad6QRXrJ8/ce3at+/TE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 2737E26E91;
	Thu, 16 May 2024 12:32:41 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id ADA6826E90;
	Thu, 16 May 2024 12:32:37 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Emily Shaffer <nasamuffin@google.com>,  git@vger.kernel.org,
  git@jeffhostetler.com
Subject: Re: [PATCH] trace2: intercept all common signals
In-Reply-To: <20240516071127.GA83658@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 16 May 2024 03:11:27 -0400")
References: <20240510172243.3529851-1-emilyshaffer@google.com>
	<20240510194118.GA1954863@coredump.intra.peff.net>
	<CAJoAoZmdU281buNTm+K0wHMunsbzbZ6NXFdqh=PkDUwQKfpYEg@mail.gmail.com>
	<20240516071127.GA83658@coredump.intra.peff.net>
Date: Thu, 16 May 2024 09:32:36 -0700
Message-ID: <xmqqwmntra3f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 E826858E-13A1-11EF-AA1B-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Jeff King <peff@peff.net> writes:

>   - the opposite approach might be: stop using any allocating functions
>     in the trace2 code. There's a certain simplicity there, even for
>     non-signal functions, that we know we're just touching a few
>     fixed-size buffers, and you can never create a weird DoS by tweaking
>     the tracing code. But it would mean rewriting a lot of it (including
>     json formatting stuff) without many of our usual strbuf niceties.
>
>     This is more or less the approach we take with error(), die(), etc,
>     which are built on vreportf() and its fixed buffer.

Would another approach be to add various trace2 functions that use
strbuf() allocation a way to tell if they are called from a signal
handing codepath, and punt (by doing nothing if needed, but
hopefully we have enough slop in the buffer to say "hey we got
interrupted so no more detailed report for you, sorry") if that is
the case?

> So overall it is a pretty thorny problem, and for the most part we've
> just tried to keep what we do inside signal handlers to a minimum
> (usually cleanup, but even there we have to be careful not to do things
> like build up allocated paths for recursive removal).

Yes, I agree that it is the right approach to do very little in a
signal handler.

