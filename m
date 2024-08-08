Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472512AD17
	for <git@vger.kernel.org>; Thu,  8 Aug 2024 16:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723133700; cv=none; b=UK9sqmkbUMqXds8Ay3p+KRtYhyfEnGglDGzWbuDgG+o5afjJJWb4EPXK5EGeQ7LV6hJu8eO4B4734NG3ntIz91+jQJpjuxo6eylbSy0nMYVUmtpMEOhAd6xC1i1yEiRBtix2N/K4fmxklUXiL4U9rJ4ggaxzB2RP7qrHR6/yu+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723133700; c=relaxed/simple;
	bh=AUsp5nRFQK5rLyzBR9iEDyAT0gM92t8UyBr169yRhw4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jVI49FadHA12tIo2zTf6lfoPyElL1mFfFn/bqv2ziYbJerr0DkF1bhKXAcoin2o3/s00NvBFeTjmc+F298Us4xWtvF8rZtlvvVMcR3gJX5MisdY/rFEOf5SK1Ot0dgYlLdV3VAcQz3XeoC8Dj70GseFR/uuZr2L0b7HwFFn7VOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=HoU57qrh; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="HoU57qrh"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id BF2EA23582;
	Thu,  8 Aug 2024 12:14:57 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=AUsp5nRFQK5rLyzBR9iEDyAT0gM92t8UyBr169
	yRhw4=; b=HoU57qrh+YvESkNwu8qxpwys34acc48DFrOpIEgX71dpjGF9zIJa2d
	rtPJ0gKpc1gRBmxPhGQWOQMkzuMH9ybLEZ4yIST+SApV+BO+KPmr0RR8DsEFQIWl
	GD/P76bEI6L+85DjbcsE8tPdcnS7SV8KEzmG5fjds6A3MYRWQCrfs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id B82DE23581;
	Thu,  8 Aug 2024 12:14:57 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 77A7E23580;
	Thu,  8 Aug 2024 12:14:53 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] transport: fix leak with transport helper URLs
In-Reply-To: <ZrRV_HrUArsvRgn8@tanuki> (Patrick Steinhardt's message of "Thu,
	8 Aug 2024 07:22:04 +0200")
References: <xmqq34nfn7ip.fsf@gitster.g> <ZrRPD0ggZapZym7E@tanuki>
	<ZrRV_HrUArsvRgn8@tanuki>
Date: Thu, 08 Aug 2024 09:14:51 -0700
Message-ID: <xmqqo763j8jo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 5886391E-55A1-11EF-B9AE-BF444491E1BC-77302942!pb-smtp20.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

>> I saw that you've merged this to `next` already, but: this looks good to
>> me, thanks!
>> 
>> Patrick
>
> I just noticed that this also makes a couple of test suites pass with
> leak checking enabled. So below diff should likely be applied on top.

I'll think about it.  I do not want to see too many "ok, we have now
marked this as leak-free" plus "ouch, we have unrelated fix and its
test now triggers leaks from another subsystem we happen to use",
especially when our primary business is not leak-plugging (e.g., the
"ls-remote outside a repo" use case was a real regression fix even
though it sort of falls into "if it hurts, don't do it" category).

Thanks.

