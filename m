Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E96012C55E
	for <git@vger.kernel.org>; Mon, 26 Feb 2024 17:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708968335; cv=none; b=Y3ZE+ZXvNgbS2xGTG0CaTccUCt2r44yIOwaPNvtgg8euduLB1XlYjltvt2Y0IOswqLZCkRTZHLnUqLjr41c9YG4a1u0oCmVtLYkSLULska5aCwIZI5DPC6depH/THQDhRE2ChDctKQwteS8iNCofjOUfemNp+92dUTQH/tYD5jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708968335; c=relaxed/simple;
	bh=QhqTzOLn4A9DwIrafoIxLoQblvIqJITeXVt3PePvZYQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YPsu144JmHhuKkmIHJyOR4+PhIOzuk60H2D0ApXTnurkDmhJPHZHIZ+qQyIfhZCU45CQfXH3y2BHHUxjmPolH5YmjHU2kY5gtxDtVBRTj3uP/Jdt3FQmi0Sn5OV2R6E5rCuNI6OaGSKeVJr/Plg7KWe1xoWZ+cVoFWvwGi58/vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=YOxFz+kI; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="YOxFz+kI"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 6DC311AE77;
	Mon, 26 Feb 2024 12:25:33 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=QhqTzOLn4A9DwIrafoIxLoQblvIqJITeXVt3Pe
	PvZYQ=; b=YOxFz+kIftLzyW6pOSR2lBQpUQFJKjANt5tdAY9+K4nPFFgTOU39z8
	6wYXNCU80wf4dbiIV5LFM0OGFa3e110dLx23rAUOl9MVNsAV4ujVAULVOCwrQcNO
	+NqzFDayW1B8oPx52FSXMjE3wYw0CNlW4hLhGkvPHXpEtCTJRrrHk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 5897E1AE76;
	Mon, 26 Feb 2024 12:25:33 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E26961AE75;
	Mon, 26 Feb 2024 12:25:29 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Patrick Steinhardt <ps@pks.im>,  Yasushi SHOJI
 <yasushi.shoji@gmail.com>,  Denton Liu <liu.denton@gmail.com>,  Git
 Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 3/3] read_ref_at(): special-case ref@{0} for an empty
 reflog
In-Reply-To: <20240226100803.GC2685600@coredump.intra.peff.net> (Jeff King's
	message of "Mon, 26 Feb 2024 05:08:03 -0500")
References: <20240226100010.GA1214708@coredump.intra.peff.net>
	<20240226100803.GC2685600@coredump.intra.peff.net>
Date: Mon, 26 Feb 2024 09:25:28 -0800
Message-ID: <xmqqmsrncf3r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 09E43E10-D4CC-11EE-AA8C-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Jeff King <peff@peff.net> writes:

>  	if (!cb.reccnt) {
> +		if (cnt == 0) {

Style "if (!cnt)" ?  In this particular case I do not think it
actually is an improvement, though, simply because zero is really
special in this logic.

> +			/*
> +			 * The caller asked for ref@{0}, and we had no entries.
> +			 * It's a bit subtle, but in practice all callers have
> +			 * prepped the "oid" field with the current value of
> +			 * the ref, which is the most reasonable fallback.
> +			 *
> +			 * We'll put dummy values into the out-parameters (so
> +			 * they're not just uninitialized garbage), and the
> +			 * caller can take our return value as a hint that
> +			 * we did not find any such reflog.
> +			 */
> +			set_read_ref_cutoffs(&cb, 0, 0, "empty reflog");
> +			return 1;
> +		}

The dummy value I 100% agree with ;-).

You mentioned the convenience special case for time-based reflog
query for a time older than (e.g. @{20.years.ago}) the reflog
itself, and perhaps this one should be treated as its counterpart,
that is only useful for count-based access.

