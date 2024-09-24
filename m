Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042A71B85D1
	for <git@vger.kernel.org>; Tue, 24 Sep 2024 17:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727197298; cv=none; b=HdDz6qBLxsgYJgoaOg3eVTKVGqxC/2cTqFRB9k595GJ+JlBDaAqdA6dRTIE9JRT+a44nJWEv7R12DUEUQt2oyTOcNOLr/k0ltgox6YpB2tMLhRN5Xq6P1BhDdA0DZGi0+mZO9BnEEeZbGa5Ia1tFwfK04N3WjzwAVbDXfJSoKYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727197298; c=relaxed/simple;
	bh=hPKpceZ+6GYJ+y3iM66KVWrS3Y+ZXQ/QrZXyXCW/3wM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eBhUc4xYc3bYIXuIYsWvvguyH7q8BukZEn9a2GCYX7TlErajV73TGJmnk9UPOBdcRTMvzflOru2AGSndaEUWK4aiIfgHGwJ2UyXxsp/sXp5XykOGY/0eGxGWfbd3+7zbsAJAWV68pFB8qSxlvtqKti3wYLxtOnBMchiz9r9cGqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=kMNN7ewC; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="kMNN7ewC"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C464F360F8;
	Tue, 24 Sep 2024 13:01:35 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=hPKpceZ+6GYJ+y3iM66KVWrS3Y+ZXQ/QrZXyXC
	W/3wM=; b=kMNN7ewC9+5ywLYnWozJti0b1yUv/elGq/QRsd6Teg+mbaMWbk1Ff/
	Zv/+1TKGydIAoyprQHG40hKIf7LyWAaJV1fv0WVPkq3/+KqXtEigdgcIyDlGImR0
	dDZrCvSHMXan5zFTEDSvglUpQNVwnImtVU/OxlH0ZpxvsGRzqfzTc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BD10D360F7;
	Tue, 24 Sep 2024 13:01:35 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E4214360F6;
	Tue, 24 Sep 2024 13:01:34 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/3] cache-tree: detect mismatching number of index entries
In-Reply-To: <ZvJgnqSwANCXmj0G@pks.im> (Patrick Steinhardt's message of "Tue,
	24 Sep 2024 08:48:04 +0200")
References: <cover.1726556195.git.ps@pks.im>
	<595693a6420b2571aabd51ed989bedfa0cfa62e2.1726556195.git.ps@pks.im>
	<xmqqttec8ly0.fsf@gitster.g> <ZvJgnqSwANCXmj0G@pks.im>
Date: Tue, 24 Sep 2024 10:01:33 -0700
Message-ID: <xmqqed59ugsy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 A7BB103A-7A96-11EF-A0BE-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

>> I guess as long as "it" is not folded, it does not matter how other
>> paths from different directories in active_cache[] are sparsified or
>> expanded, as long as "pos" keeps track of the current position
>> correctly.
>
> It seems like we end up calling `ensure_full_index()` for a sparse
> index, which does cause us to signal to the caller that they should
> restart verification. So for all I understand, this function shouldn't
> act on a sparsely-populated index.

OK.  That sounds sensible and safe.

