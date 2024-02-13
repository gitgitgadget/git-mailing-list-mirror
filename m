Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C465A6088F
	for <git@vger.kernel.org>; Tue, 13 Feb 2024 19:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707853375; cv=none; b=AcKAIzM4E7IOCos1J6sUxwlI2Z5+cF+54pgxOTY9QPfJ5+I8Y9sp/TDRIDHTrmiLt5k5PN97JpQS05dPWeZQpTFxFw4fy2p+DvP1/bvLva4kKNAbNz8wYatg8S7C6mqUAduv2IEPvnVccfwLPEsQ1xX55FARIqtZoDmKlPUqikM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707853375; c=relaxed/simple;
	bh=zFQM6LOJE7D2yStadX7Tly6hmx4IunBO+FLKkMXHJdc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MglRY72J1GpaQkA5MFtSTCWdJx2Ej0eQFxHizG57fptZPIuiQCEO+etjC/idKe52ExA2kUcHEogIpmtghp8CWYLH0rl/eqcDSNKdfvprO4wcIGfvmgTkS3DN6OiikT8GxuyliZMU3GnNd0oQbozSiwheT11bkyKnwILNGRiyxao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=scBLauWk; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="scBLauWk"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 41D1735CF6;
	Tue, 13 Feb 2024 14:42:53 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=zFQM6LOJE7D2yStadX7Tly6hmx4IunBO+FLKkM
	XHJdc=; b=scBLauWk/7P4wvcli5YV2TBL6OIAfvEqEt+s64JaS+hWjXfREtlHSB
	kT1YiX9PC42cnJIpJm4sz10qaRSc1IvvsUKWY28LrpSwA4tcfDe4nCvXzeEyTc2y
	PcaMPm6bwm/LlWawh/AT43MaFVC/BrQfjD/VUUjCZorxshppRysgo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 3B6CB35CF5;
	Tue, 13 Feb 2024 14:42:53 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E176635CF4;
	Tue, 13 Feb 2024 14:42:49 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Karthik Nayak <karthik.188@gmail.com>,  git@vger.kernel.org,
  phillip.wood123@gmail.com,  Jeff King <peff@peff.net>
Subject: Re: [PATCH v4 1/5] refs: introduce `is_pseudoref()` and `is_headref()`
In-Reply-To: <ZcoTbRxIaGmTd4fJ@tanuki> (Patrick Steinhardt's message of "Mon,
	12 Feb 2024 13:47:41 +0100")
References: <20240119142705.139374-1-karthik.188@gmail.com>
	<20240211183923.131278-1-karthik.188@gmail.com>
	<20240211183923.131278-2-karthik.188@gmail.com>
	<ZcoTbRxIaGmTd4fJ@tanuki>
Date: Tue, 13 Feb 2024 11:42:48 -0800
Message-ID: <xmqqh6ic5ex3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 11F13D16-CAA8-11EE-88D4-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> I wonder whether we can maybe consolidate the interface into one or
> maybe even two functions where the behaviour can be tweaked with a flag
> field. Something like `refname_is_valid()` with a bunch of flags:
>
>   - REFNAME_ACCEPT_HEAD to accept "HEAD"
>   - REFNAME_ACCEPT_PSEUDOREF to accept all of the refs ending with
>     "_HEAD" or being one of the irregular pseudorefs.
>   - REFNAME_ACCEPT_INVALID_BUT_SAFE to accept refnames which aren't
>     valid, but which would pass `refname_is_safe()`.

I am certain we _can_, but it will take an actual patch to see if
such a refactoring makes the callers easier to follow, which is the
real test.  FWIW, I am much less skeptical than hopeful in this
particular case.



