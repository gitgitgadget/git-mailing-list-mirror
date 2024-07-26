Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89FDC14A82
	for <git@vger.kernel.org>; Fri, 26 Jul 2024 14:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722004879; cv=none; b=OPHRN2tufmIyqlbHkZyJSXz8y1JnYL8rYvO8KiTX3HQHdupPNJ4I3X52QR7c/fA/Zfh9b3jm7MfQH7jkUJpHjcPqCLCIrx94w/nej7W8QKJnlbWlfKdgBc7qJbeTHHS3hVyluWFdIQWvZYFwom0Add6F9kxl6hyw2YJ3ajGVykU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722004879; c=relaxed/simple;
	bh=c2SGBbBPRCMQzbCJRBDLLF6IoF5rCm1TqbOnSmHYPLU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tM+xirft2re/K8BwPHuWZ+uNJdWba2uYgWc5Ei+iVQTCXkF6GvoI/Hc0FzZ1f7VBh4lv0E2WOkDy2aOkQrpA9pmNtxLvMnh4U1HJdLbFDEGqt0ncO5HmsxLUuNCOb4KWcNP1qw9isuI73hVzAG0DwqDptKZI6FPmCa6nvKIFqik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=XIEfPOEQ; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="XIEfPOEQ"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 5A16E210ED;
	Fri, 26 Jul 2024 10:41:16 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=c2SGBbBPRCMQzbCJRBDLLF6IoF5rCm1TqbOnSm
	HYPLU=; b=XIEfPOEQVawrBs79VayjOdpsgUIkqAEXFtgRjG1BC4WWK8bqnQ8fOg
	nNkJPd2DZ7gdCPK5h444QViIKFdNC3zIWuYw1yc0e2v6y+v3QMTsYZXG3ZZElJs3
	+SAnCFX7qxSxAcGgmq0gVlu44Pkwf7n7jIq9zX1JctbannZg5KK+s=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 51283210EC;
	Fri, 26 Jul 2024 10:41:16 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AC9DB210EB;
	Fri, 26 Jul 2024 10:41:15 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] csum-file: introduce discard_hashfile()
In-Reply-To: <20240726044216.GA642208@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 26 Jul 2024 00:42:16 -0400")
References: <xmqqle1p1367.fsf@gitster.g>
	<20240726044216.GA642208@coredump.intra.peff.net>
Date: Fri, 26 Jul 2024 07:41:14 -0700
Message-ID: <xmqqplr0z051.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 1CB1B9A2-4B5D-11EF-BD83-BAC1940A682E-77302942!pb-smtp2.pobox.com

Jeff King <peff@peff.net> writes:

> There's other repeated cleanup happening here, like free(ieot) and
> strbuf_release(), which made wonder if we could bump it down to the
> cleanup label at the end of the function to simplify things. But
> probably not, as we are often doing that cleanup even in the non-error
> case. And of course the "sb" strbuf is local to a lot of blocks.

These localized and independent strbuf instances were indeed what
discouraged me from moving other clean-up to a central place.

> So even if we did want to do it, I think it would come as a separate
> patch. But mostly I wondered whether the label should be a more generic
> "cleanup" than "discard_hashfile". We could probably worry about that
> later, though, if that separate patch ever materializes.

Yup, I wobbled between a more generic "cleanup" and "hashfile is the
only thing that needs special clean-up right now", and it does show,
as you noticed, how the error code paths after calling finalize
looks like.

I think I'll rename the label to "cleaup".

Thanks.
