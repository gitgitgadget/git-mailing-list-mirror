Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5012715E5BB
	for <git@vger.kernel.org>; Fri,  2 Feb 2024 19:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706902248; cv=none; b=FdLQfMQsb4TJnDTPdPgWDJEsCQOs9TmeJoRV8FFgopKNQESlco03YvG+7h1OdT/FhOn4UZJ7l+tcJFPTN1qrAKQohOkANVk5PWEhXAzfZeJzlVkNs1M4gFzL1drvT8PYQIlFEhXi5cQlaiotNjFYM6DRNUTjvdi5zARTLQWDbb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706902248; c=relaxed/simple;
	bh=vqoLUT1riI17M1Nvjt2mCqW8UjQ3HY/aNez9RV/gTfQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=C4E6NDU22utInXmUL54hcK7GKxJPI2VYkwJc11dnLNDH8x8Ezl6J8E7jBIVgTzPp+Uulq0zNF9IS0/N211Q3r2fR56ysRBdPsbmK3gfPah/ydaBvwO6/XIJNEAZ+eElp9zRsacdR0mlDyIYP+lfVkwcvSb16z2TyD8rY6+R3S7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=VmCRyDwi; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="VmCRyDwi"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 7736B1D53F;
	Fri,  2 Feb 2024 14:30:45 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=vqoLUT1riI17M1Nvjt2mCqW8UjQ3HY/aNez9RV
	/gTfQ=; b=VmCRyDwiG5gTn7ajD2LHTG9VXUsszVnes9iGZpwg8a9z4qnyOIhnK8
	HlogQ2DNY9rIi1Pw3wE/o771oZt265SrE9tbcrkNbGNEyw+XBa7IlI0GZ/hVIrCm
	YkY2aVkh3uP21je2QyxDs8hyLzTe4XhREFwU7DuTde/vuBhYRPU8U=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 6F6861D53E;
	Fri,  2 Feb 2024 14:30:45 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A703F1D53C;
	Fri,  2 Feb 2024 14:30:41 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff Hostetler <git@jeffhostetler.com>
Cc: Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Jeff Hostetler <jeffhostetler@github.com>
Subject: Re: [PATCH] sparse-index: pass string length to index_file_exists()
In-Reply-To: <2bae709a-18da-6ab8-2b76-032ddc045641@jeffhostetler.com> (Jeff
	Hostetler's message of "Fri, 2 Feb 2024 14:19:17 -0500")
References: <pull.1649.git.1706897095273.gitgitgadget@gmail.com>
	<xmqqo7cysp01.fsf@gitster.g>
	<2bae709a-18da-6ab8-2b76-032ddc045641@jeffhostetler.com>
Date: Fri, 02 Feb 2024 11:30:39 -0800
Message-ID: <xmqq1q9usly8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 8D559088-C201-11EE-AE77-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Jeff Hostetler <git@jeffhostetler.com> writes:

> I don't remember if this bug caused visible problems or not. It felt
> like it caused a few extra rounds of mutually-recursive calls between
> `index_file_exists()` and `expand_to_path()`, but I can't say that
> for certain (and I was focused on a different problem at the time).
>
> I do have some test code in `t/helper/lazy-init-name-hash.c` that
> I suppose we could extend to beat on it, but I'm not sure it is
> worth it in this case.

Yeah, if we had a reproduction already handy that would have been a
different story, but I agree that it is not worth it.

Thanks for a fix.  Queued.


