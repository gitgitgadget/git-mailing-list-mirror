Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75A1142621
	for <git@vger.kernel.org>; Tue, 17 Sep 2024 21:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726607724; cv=none; b=WykSD3cckRX1foDvJ3AKhaKX4rvgzQMVwXxKazcLhAdc50kXMpbO55d7aiiAsZVIJP1STbWsyANWEISIOrRZl4sl9RiYYcFNTe31yDe06boUvDWzro82DrWyGl6OEgF9910/UTsNP31o9B0SLVlMgtjL3ILKMsFX4WY0Xr7mRyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726607724; c=relaxed/simple;
	bh=zpfX7R0xbMhgeVk4lgIC6aXqZcqFwAYj2Y5K8yNZjdc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YvG4LFiN8xxMqkAqMoH6WwlrK36rTDM61elZlMQLVx0kOk81gnVRgJqCkqm/HIWoW6l7iZgPsGgRDXFybiC3a7DK2+rlGOVsVDYc86E7Ytvz9DmUkUPblN+67fjDoS0BDfumOcFckTh+0GMAe/Amm8uPPFcDN5K3RTNNbPN+2ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=oGMHFMqB; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="oGMHFMqB"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 759182822D;
	Tue, 17 Sep 2024 17:15:21 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=zpfX7R0xbMhgeVk4lgIC6aXqZcqFwAYj2Y5K8y
	NZjdc=; b=oGMHFMqBtq56esVYiQOepAkO4jsJTJ/hFYSkbe9RmQpOc7vhhQjoz+
	qwQVqNJQqZ5vSS8CeABpILJ1/vDuszU+Q+/rWbwmAxLBArEB/T7zphSWmt6vXTeW
	NVpp0P9JBx36nXJeJMTH8JsbBqGeAeP2UmdjL4HyCMk0dBciFdjuE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 6D9782822C;
	Tue, 17 Sep 2024 17:15:21 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D3BAE2822B;
	Tue, 17 Sep 2024 17:15:20 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: Eric Wong <e@80x24.org>,  git@vger.kernel.org,  Jeff King
 <peff@peff.net>,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 02/10] packfile: allow content-limit for cat-file
In-Reply-To: <ZulVmP3pBEEajjr5@nand.local> (Taylor Blau's message of "Tue, 17
	Sep 2024 06:10:32 -0400")
References: <20240823224630.1180772-1-e@80x24.org>
	<20240823224630.1180772-3-e@80x24.org> <xmqqcylvky69.fsf@gitster.g>
	<20240827202359.M464972@dcvr> <ZulVmP3pBEEajjr5@nand.local>
Date: Tue, 17 Sep 2024 14:15:19 -0700
Message-ID: <xmqq5xquj82g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 F233BB1A-7539-11EF-A2F8-9B0F950A682E-77302942!pb-smtp2.pobox.com

Taylor Blau <me@ttaylorr.com> writes:

> I don't have a huge problem with "content_limit" as a name, but perhaps
> "content_size_limit", "streaming_limit", or "streaming_threshold" (with
> a vague preference towards the latter) might be more descriptive? I
> dunno.

Your statement does highlight the second point that should have been
pointed out, but I failed to.  The "limit" is about "maximum content
size" (as opposed to content type or color or smell), but also it is
important to avoid sounding like we are forbidding a blob to exist
if it is larger than that limit.  The limit is only about whether
the contents are prefetched through the contentp pointer (and
anything larger than the limit must be obtained via a separate API
call to obtain the contents).

We can flip the polarity to say "minimum content size to stream"
(i.e., anything larger than this threshold will be streamed out
instead of held in core at once), and it may certainly be a better
way to explain what is going on than "maximum content size to be
held in-core via contentp".

Thanks.
