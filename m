Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA29137778
	for <git@vger.kernel.org>; Fri, 19 Apr 2024 21:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713562281; cv=none; b=gV7KAqfw0yZ5IvMqTQRyn+9XyzqxbEPaR2sx/1z8xtV/A5PL/pCk+Mt9fcuAv+UyMQ/H4YezLXu5mg19vV8AUbME28gvNoVIK0ew76jgd4U337Yn2X1Jvd19KPnrqUuaiswdk+FquZJ5PfSbfchLERM4dHuLR6mtonyR1gXwN7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713562281; c=relaxed/simple;
	bh=7eRJ1PnNtUknx/ULLE00UG0d8eW+ShDshx0jEWWgNlw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AC/brU9vweAYvZW6O71+2SwWWtWNXszklfe+Z1OUcd/ma4B+yCWvCg18/JjLn+Y2dvwrKYo2jTXS49/ccdDoEXDvT1EtprYkAieMBdYdnUp6bCQM4xaXY+i9MWHZqNx2DgZjrqkKpSQt+WUwr6RZvfdXOP+yvemJ8lv1+G77Yrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=s/JU6Dhy; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="s/JU6Dhy"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id EC87334580;
	Fri, 19 Apr 2024 17:31:18 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=7eRJ1PnNtUknx/ULLE00UG0d8eW+ShDshx0jEW
	WgNlw=; b=s/JU6Dhy8Zveh1NoFKOUZDVUgUiDBNGAILn32pS1eBbbXZfVcQOz3v
	vtpGqOMskf9ZGic9hjt97VjQTyynm0T9RUaYfyQ2e+4ye2kA9R18erxCzg2SKfrz
	iVat/orQiJJEOIXG07qsq41tkYBAbKF1bMMtNlKtzyndR+zUm2gJI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id E54A13457F;
	Fri, 19 Apr 2024 17:31:18 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 562303457D;
	Fri, 19 Apr 2024 17:31:15 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Wong <e@80x24.org>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/3] switch to tombstone-free khashl table
In-Reply-To: <xmqqy1a4ao3t.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
	26 Mar 2024 10:40:06 -0700")
References: <20240325230704.262272-1-e@80x24.org> <xmqqy1a4ao3t.fsf@gitster.g>
Date: Fri, 19 Apr 2024 14:31:13 -0700
Message-ID: <xmqqy19959b2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 26BE4B74-FE94-11EE-8BA3-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> Eric Wong <e@80x24.org> writes:
>
>> The memory improvement is minor, but any memory reduction at all
>> is welcome at this point.  Fortunately, this set of changes is
>> unintrusive.
>>
>> I have some other ideas that I'll hopefully get to implement before
>> swapping kills all my SSDs (see bottom).
>
> Please describe what this topic aims at to sell the topic better.
> Are we trying to reduce memory footprint?  In other words, if this
> topic were to hit a released version of Git, what would the short
> paragraph description for the topic in the release notes look like?
> ...

So, did anything happened since this exchange?  I remember that we
caught and fixed a few minor sparse errors, but other than that, I
am not sure what to do with this topic.

Not that I want to merge loud tree-wide topics down during the
prerelease period...

Thanks.
