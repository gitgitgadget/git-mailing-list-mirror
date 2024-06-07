Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E681514C3
	for <git@vger.kernel.org>; Fri,  7 Jun 2024 15:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717774819; cv=none; b=VY9gte4Nlw+S/I/fCm98nMelrp9TUUHKBUVuyEihSoWevsWdyiqz11w94vR6muf8v/miM+iNZgOfqB1k/59K9TzhbfPGaPP6cV3mDGHTC9mO++HWqTMmzw2fmhw6g8rbvO2kKhpEnnw/jUTU3M6x2IySWwkc/blsl9b9CBRNp08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717774819; c=relaxed/simple;
	bh=VfYVHKP2M3/725tWnM7Ksn/OMVxc+YvExC/f3E7U/4w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hm5s0YVDlwJq6oIWnTc6CdtJi00jNS4VDM0PeirDmYfYLQdNj3fRFxUcd7pp/wFlN+wblKv3iGUPacI1xOLgz5fjXKVe8t9x0jU+1zrQlA4o11eCgvbX+lcBG4HycdzXsBeaC/5g2rugcbvYAGSD9KA8e6ddmfCcuznemxJeb0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=tIbIPn5n; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="tIbIPn5n"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 3F34436945;
	Fri,  7 Jun 2024 11:40:12 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=VfYVHKP2M3/725tWnM7Ksn/OMVxc+YvExC/f3E
	7U/4w=; b=tIbIPn5nj+P/Mh7Rkqi6PNHfRC6PIzQLLng1g4JS6ZRVcxhQABjezO
	nv/xp0aaO2qgWB1XCzxLUa1Hwen4zyuus8KsAGuXvD1bLIJyRpDFrUx8xdAUI3LW
	th3BWk4mq3Q4Ul5UnyCcbUObuzut+4E7pSXILsedvLeiuBlFOQTYs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 3772C36944;
	Fri,  7 Jun 2024 11:40:12 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 593A636940;
	Fri,  7 Jun 2024 11:40:09 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Elijah Newren
 <newren@gmail.com>
Subject: Re: [PATCH 0/2] commit-graph/server-info: use tempfile.h in more
 places
In-Reply-To: <cover.1717712358.git.me@ttaylorr.com> (Taylor Blau's message of
	"Thu, 6 Jun 2024 18:19:21 -0400")
References: <cover.1717712358.git.me@ttaylorr.com>
Date: Fri, 07 Jun 2024 08:40:07 -0700
Message-ID: <xmqq4ja4hico.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 38AD8B3A-24E4-11EF-B6EE-8F8B087618E4-77302942!pb-smtp21.pobox.com

Taylor Blau <me@ttaylorr.com> writes:

> This pair of patches addresses two issues (in the commit-graph and
> update-server-info areas, respectively), where temporary files are
> created outside of the tempfile.h API and thus survive abnormal process
> death.
>
> The commit-graph one is more prevalent, and has been the cause of some
> minor headaches (for e.g. automated tooling to detect repository cruft
> at GitHub complaining about unknown tmp_graph_XXXXXX files left around).

;-)  

I'd be very surprised if a stale "update-server-info" product causes
any harm, but we unfortunately cannot remove it until we fully
remove the suport for HTTP walkers.

> The fixes in both instances are relatively straightforward conversions
> to use the tempfile.h API.

> Looking at the remaining uses of mkstemp(), the remaining class of
> callers that don't use the tempfile.h API are for creating temporary
> .idx, .rev files, and similar. My personal feeling is that we should
> apply similar treatment there, since these files are generated based on
> .pack data, and thus keeping around temporary copies is unnecessary when
> they can be regenerated.

Absolutely.

I wouldn't be surprised by .idx as it and .pack are so old, dating
back to 2005, but anything newer like .rev I am mildly surprised
that we haven't done this conversion.
