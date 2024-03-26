Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C24571B53
	for <git@vger.kernel.org>; Tue, 26 Mar 2024 20:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711485967; cv=none; b=eJ2oomxfYy86uo4P3YslaMl5WuQnf2sb8BBk240Pum8tT5F0GUVVrAj621olPZieliPVGigD64tFOaXIAQcZyO03OIXt/DQ3xDQUDc4GFsvDNfzdtGJYDBFKMf6w2ytvBjHUBBb+Z14mc9/nF1Rb5iPIsiBzQ96/f/TuLArbDkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711485967; c=relaxed/simple;
	bh=vIT9RYY4SWPG7fAvWf5LM2XnrizHtVqlAjbqnP7kVRE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Cjw8F539CJSk7mo18K4dM0wGYIAn0R2B7Ks773v0zS8De00Lp08f9Gdhb5A3qpXQvcZfFLOV06G4TcpIWsuFusuCGQX6i3DK6/5uYjNt9a0GSOQbVT8S+wiTL76yd7fULSjsTLhjuueYWqiWJGX8EIMpUBOmvyN25T40N2+jF1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=xxykDoSF; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="xxykDoSF"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 521A52FC7C;
	Tue, 26 Mar 2024 16:46:04 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=vIT9RYY4SWPG7fAvWf5LM2XnrizHtVqlAjbqnP
	7kVRE=; b=xxykDoSFPOp1hxrVvRd7Kx77qQtNTG7TF5bLLB0nAFgBT6bYwE4j6H
	56VJaBljE0fVIIwCmvrwj0b7znqYAa8NGdfj65KkcSl/MI/OhmADmlbQMMqaMUcn
	hK257xlzRRXrcT1ARR3FhJgqlCVUeqpEy/h/dnoDPJz9yBaUBhsNk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 4BDE22FC7B;
	Tue, 26 Mar 2024 16:46:04 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C70562FC78;
	Tue, 26 Mar 2024 16:46:00 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: Jeff King <peff@peff.net>,  git@vger.kernel.org
Subject: Re: What's cooking in git.git (Mar 2024, #08; Tue, 26)
In-Reply-To: <ZgMwaG28aoC7Njcg@nand.local> (Taylor Blau's message of "Tue, 26
	Mar 2024 16:30:32 -0400")
References: <xmqqle64algt.fsf@gitster.g> <ZgMwaG28aoC7Njcg@nand.local>
Date: Tue, 26 Mar 2024 13:45:59 -0700
Message-ID: <xmqqwmpo90xk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 DAD6B574-EBB1-11EE-9E2A-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Taylor Blau <me@ttaylorr.com> writes:

>>  The pack-bitmap machinery has been extended to write bitmaps for
>>  pseudo-merges, which are imaginary commits which act as octopus
>>  merges covering groups of the un-bitmapped parts of history at
>>  reference tips.  This is good for ... what ...?
>
> Instead of "this is good for ... what ...", let me know what you think
> of:
>
>   This allows for greater bitmap coverage (and, thus, performance when
>   using bitmaps) of repositories with many references which ordinarily
>   would not receive full coverage.

Much better than "god for ... what ..." ;-)

Now if it gets summarized in 2-5 lines, we have something we can
use.

Thanks.
