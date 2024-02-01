Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F45DF6D
	for <git@vger.kernel.org>; Thu,  1 Feb 2024 16:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706805040; cv=none; b=P6xIIinMb8SiRREcWYxNy3k4CHssu5vaGPtX33UvgXbxktd1BJQiQUBKnWio37E10+NZweY/VxHCMplNCEDtQb3MzipJ9GW/E+mGKCaEpEq2Z34RXi4DFfjYJHu3a8vOSMmiF4niMjmR1VjoMlHr848+EGT/ocB8MzAl+Fj8zUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706805040; c=relaxed/simple;
	bh=CYjjetSEA2Z7ggT30/TLGwa97qymiY2LA0bwMPK6grQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GbqSzsUXz5YjWhxZ5aAPWhZdZocqC6LhnmobOTntjWVC9CS1SarenoVHsNYCF43IQc2QaG8IpsJcfguCxcP5aM9ZIKUCDCLpPSi08uWy9pj3WJb5uU0u9mUvetToWt+v/TnSjau7uJsNNBM9BXNfASfGjIdLrYNaMI87BXLNKU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=q8GdYWs8; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="q8GdYWs8"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 5CF733AEC8;
	Thu,  1 Feb 2024 11:30:38 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=CYjjetSEA2Z7ggT30/TLGwa97qymiY2LA0bwMP
	K6grQ=; b=q8GdYWs8BMZmCM4qDEmBRxuk3oUHIosrJf2o1de6bNFFsDr0yR11ZD
	06/ClOSYajKCUlM7JkElhIQDy+0TvIaQ/TGFm6q9b73/ip5p0r7dsTZ35h5uGlpt
	2vI4j9Wcuc27lrpCy424wwECwD3wrzuNr2Ywjp0NwnSEfV0iqvSD4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 555F53AEC7;
	Thu,  1 Feb 2024 11:30:38 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 8A2C33AEB9;
	Thu,  1 Feb 2024 11:30:34 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/9] reftable: introduce macros to grow arrays
In-Reply-To: <ZbtIQ3Hk6Mgvkv4j@tanuki> (Patrick Steinhardt's message of "Thu,
	1 Feb 2024 08:29:07 +0100")
References: <cover.1706687982.git.ps@pks.im>
	<0597e6944a1a65720d050f47bc82766d5bcf860b.1706687982.git.ps@pks.im>
	<xmqqmssl44wo.fsf@gitster.g> <ZbtIQ3Hk6Mgvkv4j@tanuki>
Date: Thu, 01 Feb 2024 08:30:32 -0800
Message-ID: <xmqqbk902llj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 395F9EC0-C11F-11EE-8695-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> Very good point indeed. I don't think peak memory usage is really all
> that helpful either because the problem is not that we are allocating
> arrays that we keep around all the time, but many small arrays which are
> short lived. So what is telling is the total number of bytes we end up
> allocating:

True.  sum of requested sizes to all the calls to malloc() and
friends to allocate, ignoring what gets free()d in between, is what
would show how much we try to consume.

> Allocating 21 times as many bytes with our default growth factor should
> be a much more compelling argument why we don't actually want to use it
> compared to the 2% speedup.

;-).

