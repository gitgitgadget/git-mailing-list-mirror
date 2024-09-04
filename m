Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0CC1E0B81
	for <git@vger.kernel.org>; Wed,  4 Sep 2024 18:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725473916; cv=none; b=e0fGTQ+Y3ka04UPU0YK9dA6HK+/7G0A2zEkGvHnkmEjgW8SuU1sy5Fqw5Qv7MOhW1phU34FkrtTA0QOxKajFpn6uGTc+uQiF6gxgUdUgsumGIC3WhiXQZ3pqAjJ2gKOmzR5mIYvhFAOTrbMdp7tEMYHElRiSMOnROGCcKZih+sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725473916; c=relaxed/simple;
	bh=B1OHRMylmBTnag5LS0Sqva9EY1s4yTvt0w/XTkiuS10=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LT7AW0nf5jlDLXce3VqSsZlQ9Ev8D8WkQUeDPMZnT8eeM2Vsr6aOtJcpcbPFX28yUKqdu4jTg/ZswO9Rx6i50OsSVVgcZugTocWb6o4IqC0dk49w0sXbJzpi6W0rIKKeH5ewyg3ZFwsV/t5du1r9Ev93JtWmmdxz2AXNSjs6Kc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=AcNu+Mt2; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="AcNu+Mt2"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A94251E8FC;
	Wed,  4 Sep 2024 14:18:33 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=B1OHRMylmBTnag5LS0Sqva9EY1s4yTvt0w/XTk
	iuS10=; b=AcNu+Mt2GUBGLggW7jTBPHjU2d5Pui1jKoUKKJZZ42vltEY45i6NAK
	a/rwUHAMGPqXBUwekK4c8G0c+AQ7OU9oRv9/z1L1iAV+S0AW7vYC7W1VWsflHVL4
	PkZalGB4fcu+mc/hxKwNV4y6Zn1CCtDAGm6Q3uuhnA9LcLUJrgbVk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9E11A1E8FB;
	Wed,  4 Sep 2024 14:18:33 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 044E31E8FA;
	Wed,  4 Sep 2024 14:18:32 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/5] builtin/pack-objects.c: translate bit positions
 during pack-reuse
In-Reply-To: <8998e51135e76061e603304a6b7bbe19893fc067.1724793201.git.me@ttaylorr.com>
	(Taylor Blau's message of "Tue, 27 Aug 2024 17:13:33 -0400")
References: <cover.1724793201.git.me@ttaylorr.com>
	<8998e51135e76061e603304a6b7bbe19893fc067.1724793201.git.me@ttaylorr.com>
Date: Wed, 04 Sep 2024 11:18:31 -0700
Message-ID: <xmqqh6av9tag.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 180FE980-6AEA-11EF-AC9B-9B0F950A682E-77302942!pb-smtp2.pobox.com

Taylor Blau <me@ttaylorr.com> writes:

> Instead, make sure that we translate bit positions in the MIDX's
> pseudo-pack order to pack positions in the respective source packs by:
>
>   - Translating the bit position (pseudo-pack order) to a MIDX position
>     (lexical order).
>
>   - Use the MIDX position to obtain the offset at which the given object
>     occurs in the source pack.
>
>   - Then translate that offset back into a pack relative position within
>     the source pack by calling offset_to_pack_pos().

Quite straight-forward, and the implementation below matches the
design well.
