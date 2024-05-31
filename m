Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1702415CD62
	for <git@vger.kernel.org>; Fri, 31 May 2024 16:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717172095; cv=none; b=bSRfwzNMLGykLi5KpWQmQImdMVLmfzYmKlCOtGwemzSoMXmm7h+tsFAsWn0hnmzcZjtNceJc4q5ZJpNgcRSSZTzzX1ZGpeDKIt2YvdmvBNc+7Ku+ql499RmStxY3uxvx1sXgzISxeamOctAefTDUUV6Q2QLCB9/X7vk0EcggbIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717172095; c=relaxed/simple;
	bh=1/UwYfYZkYGyaNXLVJiAeDUgQXJBnXa0T3yYcIocP1w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NdyA710whAXBRp7LNMqGPxOedDEHsfy4gKUZOALJ6ouBzQl/H1mgZ+XOk/lnqJajRqz74hVRBpwX9e8wFDk+LB3noDLgwFqiGcsNheD8oz7o1KHClA6HJyqU8A+tFmzJq2HGQnfVfCN+jmwlJpdftBkrxgrTvZ0q/gZQLNPr8X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ygl6OtH1; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ygl6OtH1"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 711331AF1D;
	Fri, 31 May 2024 12:14:53 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=1/UwYfYZkYGyaNXLVJiAeDUgQXJBnXa0T3yYcI
	ocP1w=; b=ygl6OtH1k/Yj7SulRftEggTNXdP3AP75ySb9Tgro9pC6+Lk30Bnh93
	ksTHS+3uKWG/weMu3BI9t9iQ6hhoxkVuQlkfW92Q4mDINiPb8i5cKJ7aOzrgYciZ
	ZA8jHVp3VxJGnNyaKg/96SysUtLlcumm1oXZisAC6042Le6IlOZ6k=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 69FEA1AF1C;
	Fri, 31 May 2024 12:14:53 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 8827A1AF1A;
	Fri, 31 May 2024 12:14:50 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 02/13] sparse-checkout: pass string literals directly to
 add_pattern()
In-Reply-To: <20240531112613.GB428814@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 31 May 2024 07:26:13 -0400")
References: <20240531112433.GA428583@coredump.intra.peff.net>
	<20240531112613.GB428814@coredump.intra.peff.net>
Date: Fri, 31 May 2024 09:14:49 -0700
Message-ID: <xmqqr0digdqe.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 E8459AB4-1F68-11EF-90E2-8F8B087618E4-77302942!pb-smtp21.pobox.com

Jeff King <peff@peff.net> writes:

> The add_pattern() function takes a pattern string, but neither makes a
> copy of it nor takes ownership of the memory. So it is the caller's
> responsibility to make sure the string hangs around as long as the
> pattern_list which references it.

Wow.  That's an extremely bad API.

I suspect that it long time ago did not aggressively "pre-parse" the
given pattern string and kept the original copy in the struct (i.e.,
taking ownership), and these copies of the literal strings were made
at the calling sites with the expectation that the API takes
ownership of them, as most of the strings fed to add_pattern() are
what we read from the environment into heap.

> In the long run, we will also want to clean up this (undocumented!)
> memory lifetime requirement of add_pattern(). But that can come in a
> later patch; passing the string literals directly will be the right
> thing either way.

OK.
