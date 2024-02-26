Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8679512C55E
	for <git@vger.kernel.org>; Mon, 26 Feb 2024 17:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708968338; cv=none; b=r4cyywI54M7g95PbAMr5Zu4CTIztr+WD/ms9CEEUr2u6IAl/OhqSo5H2zSO2CqmbtTzMPBOxnX9JpniIxoxeTWUZGoUPYBCKH827KfIC2Hwoih6Z4Z+K/ZIvGwLdHOPIVGoQCB5bPouEvyLSHMu04C+TJsrv3/PN5SF9sjX7c1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708968338; c=relaxed/simple;
	bh=Wmj8WfOhDcvbry34PniWWlpod6NeKsGzX1mt2bvDJXQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NzYHAIvuVycYEo0leOD5TEOC4W1CQ00feeF980dpyFZoUfjoJzUH3k2ug7ftxmI+037rPB+Qe4pH4wmf2HtX4q9b1zxyXFe6GkhrUs4trBwENS7Te94Ip9Pb8W73c5Y89h1jkZ1vR83p0w809Czd6D0HGYoLckwKugI+BqWAWdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=yTBNb2ym; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="yTBNb2ym"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 0E5B51AE7B;
	Mon, 26 Feb 2024 12:25:37 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Wmj8WfOhDcvbry34PniWWlpod6NeKsGzX1mt2b
	vDJXQ=; b=yTBNb2ymKnF628k55DBMiJyQjEpqU0ax/Hcg4qeZuCe4PsW8mIbrRC
	E1ktQP8X3wRYdIKPUUROjI/O0EOn3hNdRUrwAWBBxZSF0dykWCp/RdiTBuVyP3Kc
	jfs+oZwOdBjrZuRB7A4Mo37Z31zUsnHAjkERCG28DLs3Zg/zzK30A=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 07BEB1AE7A;
	Mon, 26 Feb 2024 12:25:37 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 983A81AE79;
	Mon, 26 Feb 2024 12:25:33 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Patrick Steinhardt <ps@pks.im>,  Yasushi SHOJI
 <yasushi.shoji@gmail.com>,  Denton Liu <liu.denton@gmail.com>,  Git
 Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 3/3] read_ref_at(): special-case ref@{0} for an empty
 reflog
In-Reply-To: <20240226101027.GA2685773@coredump.intra.peff.net> (Jeff King's
	message of "Mon, 26 Feb 2024 05:10:27 -0500")
References: <20240226100010.GA1214708@coredump.intra.peff.net>
	<20240226100803.GC2685600@coredump.intra.peff.net>
	<20240226101027.GA2685773@coredump.intra.peff.net>
Date: Mon, 26 Feb 2024 09:25:32 -0800
Message-ID: <xmqqh6hvcf3n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 0C180B44-D4CC-11EE-BB54-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Jeff King <peff@peff.net> writes:

> That's one of the reasons I split this out from patch 2; we can see
> exactly what must be done to make each case work. And in fact I had
> originally started to write a patch that simply changed t1508 to expect
> failure. I could still be persuaded to go that way if anybody feels
> strongly.

I do not feel strongly either way myself.  It just is interesting
that the older end of the history is with @{20.years.ago} special
case that is only for time-based query, while the newer end of the
history is with @{0} special case.
