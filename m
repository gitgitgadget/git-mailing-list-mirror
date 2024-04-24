Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09901B7FD
	for <git@vger.kernel.org>; Wed, 24 Apr 2024 19:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713985662; cv=none; b=Mg48q8NxWUf1l1LksqCVsjNGm3VXRFII7M3I5C76r3Cs5MXGhcpGUGc2aELluCKaAaaiR3iWxCjZvJYahY6gjmUHPbxj6WZXaoBdQPDHkv2bcKfxA/pM0BmRsfsRH6f3kuZZiC5n3R8f6Hx5zQ7G18lbh8+nt6K9dy9BmiXBQDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713985662; c=relaxed/simple;
	bh=xOZpdWN6DQG23iTRxJuJDTQbJ/HLGrwGzwNRGOR/pgo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kvUbAduFWs6vTpt06KtAwc4s7oQ9yt9mfWlCq+1i4IW+AeQeDO2Ckn4lWL1AFu7vKypc0Kny1jBMz1nABQP9hU00SusOpyPa+Q3HV5OL5dQ72EuJEJ7NbCtwRVUhWjW9zp+/NUOSs2KvJRotrx90x+l3rT/qkoEqTmHWkLjgr1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=NPf+9Z4z; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="NPf+9Z4z"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BA5F4215DC;
	Wed, 24 Apr 2024 15:07:34 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=xOZpdWN6DQG23iTRxJuJDTQbJ/HLGrwGzwNRGO
	R/pgo=; b=NPf+9Z4z/bEVA9+rQVRBFiWH+xatherJJgsgb4TlQm/qwZOe6be1aJ
	qJIwwGp2qqPJS0baMcaWxZZAgnzXDgFi6SXx8Bh0izcMhEkEzeeqmCQq3pWdeCiJ
	eqj82t+uX80JzYk6dhSGeXO4LR+6OsmKjJSWnPsBddc1zilcggyMM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B1194215DB;
	Wed, 24 Apr 2024 15:07:34 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 21EF5215DA;
	Wed, 24 Apr 2024 15:07:34 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Josh Steadmon <steadmon@google.com>
Cc: git@vger.kernel.org,  peff@peff.net
Subject: Re: [PATCH v3] fuzz: link fuzz programs with `make all` on Linux
In-Reply-To: <ba9d24c6445de309226bf7c165499f1969807fef.1713982389.git.steadmon@google.com>
	(Josh Steadmon's message of "Wed, 24 Apr 2024 11:14:42 -0700")
References: <cover.1709673020.git.steadmon@google.com>
	<ba9d24c6445de309226bf7c165499f1969807fef.1713982389.git.steadmon@google.com>
Date: Wed, 24 Apr 2024 12:07:32 -0700
Message-ID: <xmqqv846y3yj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 E82AF6C2-026D-11EF-8564-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Josh Steadmon <steadmon@google.com> writes:

> Since linking the fuzzer executables without a fuzzing engine does not
> require a C++ compiler, we can change the FUZZ_PROGRAMS build rule to
> use $(CC) by default. This avoids compiler mis-match issues when
> overriding $(CC) but not $(CXX). When we *do* want to actually link with
> a fuzzing engine, we can set $(FUZZ_CXX). The build instructions in the
> CI fuzz-smoke-test job and in the Makefile comment have been updated
> accordingly.
>
> While we're at it, we can consolidate some of the fuzzer build
> instructions into one location in the Makefile.

Looks good to me.  Will replace and let's mark it for 'next'.

I do not recall suggesting anything concrete on this one, though ;-)

Thanks.

> Suggested-by: Junio C Hamano <gitster@pobox.com>
> Helped-by: Jeff King <peff@peff.net>
> Signed-off-by: Josh Steadmon <steadmon@google.com>
> ---
> Changes in V3:
> * Dropped CI config patch; no longer needed since we don't use CXX in
>   fuzzer build rules anymore
