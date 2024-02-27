Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC03249F5
	for <git@vger.kernel.org>; Tue, 27 Feb 2024 17:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709053444; cv=none; b=occYzeS7alz1JHMwP/8JIcDB4rQsFDaoK1XMqK2Q9IJVlayW7CO4XjYTGNk9SLZPWsR9OGPyoF9vMQAODx2Sqsv5+qseK7WN6XPtMa6IHuy66PIQe5WLNdLWXY3Xam+4hsR7eBgXsvlzCtS+N8NwdeUOT8DxF4o/piSK5Mrufg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709053444; c=relaxed/simple;
	bh=RE+3UL8mL1XuQCaifJwN8uyt6unqtdCgSSVeu5QiP1A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gXMCqiemsmE4kubsxlukicR/lpHSXMbsEjNA/Z+AkMPqwOyYpZmLWRl8XLkCmx4OicNmVqQqBpGYaj3nmrm26qMSeVE7gZqjatpOX71oLOhDyT4ointkfbmA8IQu9EmBsWiSGZ5QrxAjuKxyShbUFiqsmpTQgoN9WSnGRbwLB84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=x4sR+KE+; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="x4sR+KE+"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 4859924115;
	Tue, 27 Feb 2024 12:03:56 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=RE+3UL8mL1XuQCaifJwN8uyt6unqtdCgSSVeu5
	QiP1A=; b=x4sR+KE+j9tFLC3bcaBKXC3sB51UCWZjP7ePIL05N8/c8svGP29ix1
	d3rAiA8j/vDL4SLBnRFeXhPs1q3B5a+BzZ4N3v+WQD2JCyOASnSBp6FZkBZLdtSj
	oTnyd+fgLOUSfjPt179d6R3ES2gKbOjYLQ4GCEYGqILMb8zKvxvxw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 4026424114;
	Tue, 27 Feb 2024 12:03:56 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 5F0B624112;
	Tue, 27 Feb 2024 12:03:52 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Patrick Steinhardt <ps@pks.im>,  Yasushi SHOJI
 <yasushi.shoji@gmail.com>,  Denton Liu <liu.denton@gmail.com>,  Git
 Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 3/3] read_ref_at(): special-case ref@{0} for an empty
 reflog
In-Reply-To: <20240227080501.GF3263678@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 27 Feb 2024 03:05:01 -0500")
References: <20240226100010.GA1214708@coredump.intra.peff.net>
	<20240226100803.GC2685600@coredump.intra.peff.net>
	<xmqqmsrncf3r.fsf@gitster.g>
	<20240227080501.GF3263678@coredump.intra.peff.net>
Date: Tue, 27 Feb 2024 09:03:50 -0800
Message-ID: <xmqqil29vnyh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 2EE972AE-D592-11EE-87CC-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Jeff King <peff@peff.net> writes:

> Let me try to lay out my thinking. If you _do_ have a reflog and the
> request (whether time or count-based) goes too far back, read_ref_at()
> will give you the oldest entry and return "1". And then in
> get_oid_basic():
> ...
>   - what we _could_ do (but this series does not), and what would be the
>     true counterpart to the @{20.years.ago} case, is to allow @{9999}
>     for a reflog with only 20 entries, returning the old value from 20
>     (or the new value if it was a creation!?) and issuing a warning
>     saying "well, it only went back 20, but here you go".

Ah, I wasn't drawing *that* similarity.  My thinking was more like

 - When you have two entries in reflog, ref@{0} will use and find
   the latest entry whose value is the same as the ref itself.

 - When you have one entry, @{0} will use and find the latest entry
   whose value is the same as the ref itself.

 - When you have zero entry, @{0} can do the same by taking
   advantage of the fact that its value is supposed to be the same
   as the ref itself anyway.

that happens near the youngest end of a reflog, contrasting with the
@{20.years.ago} that happens near the oldest end.

> I'm not so sure about that last one. It is pretty subjective, but
> somehow asking for timestamps feels more "fuzzy" to me, and Git
> returning a fuzzy answer is OK. Whereas asking for item 9999 in a list
> with 20 items and getting back an answer feels more absolutely wrong. I
> could be persuaded if there were a concrete use case, but I can't really
> think of one. It seems more likely to confuse and hinder a user than to
> help them.

I do not think anybody misses @{9999} not giving the oldest
available, simply because "oldest" is a concept that fits better
with time-based queries than count-based queries.
