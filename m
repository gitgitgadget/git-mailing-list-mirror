Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649DB1EB31
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 17:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718125404; cv=none; b=SbubsRBuQBuQ9jtshgY2yBozdzuvBI8zqypsHdTCeu2kQXORran9089owGj+jZKpuH2KjU6pWq6pmfxAMrlI4GHSE+9+Ov/qauQJd/Ov1sQZSldUppi1KuJoD3x7DpHnUbo/Ti0h1FGcCmpRwivEEMpCQrzMHZOu/omAt0taqb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718125404; c=relaxed/simple;
	bh=j37gSjcTe6A3Frcj+xeWHhE8yd7dh9npnpRl6+9Rcf4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ROxJayXHQ9b/UjPgwmTFBo+SO4NZX3EBuKcG48wcfeHOtWHtBnz1MASycD3uoYFCGOeahN+YOwOPQTGbG9jNmjV5/ju5DVF1zA0WLH4m5gOPCH4Phs2HyMs6+f0lB3XqC9Cvq2wGO0REnbOeW6DjOu80FqWQ3oCyZBkkRNZheGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=p3Nh0hOJ; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="p3Nh0hOJ"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id DD7AE26629;
	Tue, 11 Jun 2024 13:03:16 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=j37gSjcTe6A3Frcj+xeWHhE8yd7dh9npnpRl6+
	9Rcf4=; b=p3Nh0hOJKW0uKmpUcLnu0dPo3ByRPAJKv6iESTuIv6BzqfeprXLRnV
	i1peHywW+hWDVW6ZYQVSGjVwrbe/9vzmVgPIVqPCTFNqNo35RfybWmQnmhAs+IPY
	C4kiW9YMqim6iIPfCnLIIl91own0GgpUsT8TG/ZbFErehucy6/F7s=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id D49F026628;
	Tue, 11 Jun 2024 13:03:16 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 732A826624;
	Tue, 11 Jun 2024 13:03:12 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Taylor Blau <me@ttaylorr.com>,  git@vger.kernel.org,  Kyle Lippincott
 <spectral@google.com>,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 2/3] pack-bitmap.c: avoid uninitialized `pack_int_id`
 during reuse
In-Reply-To: <20240611091102.GL3248245@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 11 Jun 2024 05:11:02 -0400")
References: <4aceb9233ed24fb1e1a324a77b665eea2cf22b39.1717946847.git.me@ttaylorr.com>
	<cover.1718050244.git.me@ttaylorr.com>
	<a3c28f12020712818060bd50d1483507c9b11556.1718050244.git.me@ttaylorr.com>
	<20240611091102.GL3248245@coredump.intra.peff.net>
Date: Tue, 11 Jun 2024 10:03:10 -0700
Message-ID: <xmqqy17bwgxd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 7C7E3264-2814-11EF-930F-C38742FD603B-77302942!pb-smtp20.pobox.com

Jeff King <peff@peff.net> writes:

> On Mon, Jun 10, 2024 at 04:10:53PM -0400, Taylor Blau wrote:
>
>> Avoid the uninitialized read by ensuring that the pack_int_id field is
>> set in the single-pack reuse case by setting it to either the MIDX
>> preferred pack's pack_int_id, or '0', in the case of single-pack
>> bitmaps.  In the latter case, we never read the pack_int_id field, so
>> the choice of '0' is arbitrary.
>
> Could we set it to some sentinel value for the single-pack case? If we
> set it to "-1", then the BUG() added in patch 3 would trigger if we did
> accidentally try to feed it to the midx code. Assuming you do not have
> 2^32-1 packs, of course. ;)

Yeah, I had exactly the same reaction.
