Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D9127470
	for <git@vger.kernel.org>; Tue, 17 Sep 2024 20:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726606639; cv=none; b=Roij5Z23KDijJEl8K6e1wJE62mRJmtlMajTcTmGgIlAoZVfjPqe36Y2ANtX345Q3pqHjUI+ckNFR0HPA2te9KtksoHBaPmHzslHvwuNGv6f6Js0UXx1dJIwJ+/7z9SeNZFtDuhFRlH3wrjJE12rO4sImHAXjI1zcNHSppYRqeEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726606639; c=relaxed/simple;
	bh=ErLUMtFIV0Dwlo+DLtCf2VDtfQA49iQJcAQ6Td928Vk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ArChuVayf/ImR8ke0PBWW47V+Vcqk7maaOF1fVf88cX36CW6tDBTOdOx44OOUBkT9Ii4W0HHTmrgV1WBlWMomXQ69yOOdXOZdubGm7wFE72Y7FEpn4vAMyqeltDcVtHWAUWfTYBKw8bhUCcEF8NM+h2qwiCcF59DrGl3IM6q25E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=jwoKykVK; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="jwoKykVK"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 6D56E27E4E;
	Tue, 17 Sep 2024 16:57:17 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=ErLUMtFIV0Dwlo+DLtCf2VDtfQA49iQJcAQ6Td
	928Vk=; b=jwoKykVKm5DF0b8/wgA2/nInvGHyuYSPbgnhnFkbvPkUx4CaPfSvA2
	8XKxVGIW96FHCxsrUJCYdP/bwRRNIDwznaPEh6O2S7nNBp6uxjL5QUIlYUhUK6UQ
	6XLrB+8orelFZBVmxHTOhJo4058wk51FTOu53nF5pb8NWbw8akBlc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 63D4E27E4D;
	Tue, 17 Sep 2024 16:57:17 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CEDC527E4C;
	Tue, 17 Sep 2024 16:57:16 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2 0/6] apply: fix leaking buffer of `struct image`
In-Reply-To: <cover.1726567217.git.ps@pks.im> (Patrick Steinhardt's message of
	"Tue, 17 Sep 2024 12:07:48 +0200")
References: <cover.1726470385.git.ps@pks.im> <cover.1726567217.git.ps@pks.im>
Date: Tue, 17 Sep 2024 13:57:15 -0700
Message-ID: <xmqqy13qj8wk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 6C1330C6-7537-11EF-9F52-9B0F950A682E-77302942!pb-smtp2.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> this is the second version of my patch series that refactors lifecycle
> management of `struct image` in "apply.c" to plug a bunch of memory
> leaks.
>
> Changes compared to v1:
>  
>   - Fix two typos.
>
>   - Correct the statement that we don't loop around
>     `image_remove_first_line()`. No idea how I missed that loop.
>
>   - Split up an overly complex line into multiple lines.

Looking good.  Will queue.  Thanks.
