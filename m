Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4589280BEC
	for <git@vger.kernel.org>; Tue,  9 Jul 2024 18:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720551093; cv=none; b=NU8LSKLZTjox8jrLnNQNw+Mt1afBtsRujNdvW61EzFOewoOkmmHhRt9XxtCm+OCZyMIpBiOA9fyShGav/g9LTXAF1V+X0T0Z+sLMGYjvh8gL5XZ+z26xSIBkkgoyw2Z6odLoHNh3dO4urKq4pQyEC0sbJq5yEZpMV0Weu74sR1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720551093; c=relaxed/simple;
	bh=LPsu5dP5UyGfoxbgVsUaZLqXcmJwId8qI4I8b8wPjEY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sSVDcjJDN2fCfDX10qnFWPtYbnEQ1J+bSQ9IXeC/4lLX6iDz2oqSeb82kvExRVLzcI6lnJZvL8S33tNMO6Yz9txPzykGhhgJn8IEgbv0l4mQegSoDx7tmzTmvDmPLFGvevsebaB+VE+KHSQSYJv8HWO1gN6DfHPWPAlSne6e2L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Ru37gmJZ; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ru37gmJZ"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2AD0C35761;
	Tue,  9 Jul 2024 14:51:30 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=LPsu5dP5UyGfoxbgVsUaZLqXcmJwId8qI4I8b8
	wPjEY=; b=Ru37gmJZX4JEZZm0ddL3xBzvHlsKvmAbn/xgMu9HTeGKjsxtoGeupz
	oJA4nTgT7lDVYj3RRWx2jL6GsnR47pHyGObqW5Rb7Ma2lARjnwS8LpLvxjymlLfC
	x+zlNP8Q43qDiZc9MbI9nkxL+RbtUyp5Ke8GEPTOVy74Uu28oz+5I=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 220FD35760;
	Tue,  9 Jul 2024 14:51:30 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.219.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8865C3575F;
	Tue,  9 Jul 2024 14:51:29 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Antonin Delpeuch <antonin@delpeuch.eu>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] merge-recursive: honor diff.algorithm
In-Reply-To: <198a4c00-291f-456d-84ac-082e142bd4fe@delpeuch.eu> (Antonin
	Delpeuch's message of "Tue, 9 Jul 2024 19:16:52 +0200")
References: <pull.1743.git.git.1720431288496.gitgitgadget@gmail.com>
	<198a4c00-291f-456d-84ac-082e142bd4fe@delpeuch.eu>
Date: Tue, 09 Jul 2024 11:51:28 -0700
Message-ID: <xmqqy16ae6vj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 40A01962-3E24-11EF-ABF1-5B6DE52EC81B-77302942!pb-smtp1.pobox.com

Antonin Delpeuch <antonin@delpeuch.eu> writes:

> I have second thoughts about this, perhaps it is possible to refactor
> things a bit further, imitating diff.c which has "git_diff_ui_config"
> and "git_diff_basic_config". In a similar way, we could have
> "init_merge_ui_options" and "init_merge_basic_options" which the
> commands could call depending on whether they are porcelain or plumbing.

It does make sense to treat the internal merge_recursive() function
as robust and reliable building block whose behaviour does not get
affected by configuration beyond the control of the caller, just
like we treat a plumbing command.

Thanks.
