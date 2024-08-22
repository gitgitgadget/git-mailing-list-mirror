Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560F528389
	for <git@vger.kernel.org>; Thu, 22 Aug 2024 16:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724342815; cv=none; b=byRp4C/cG+vQ7r/b0OXVN70n6FZVeo0XJ+IbzEV5+8KvpRicTdr6j//OO0xQ9Ia9MWAMvLV6cooR8SrFNFmIKcopV5qig7G0V2h5vgRT9hxwlC0u+SBvY21hRIQiDXtL1h0ejubHBfFGzFftIqjAIGX2jBlO1hKWajBIrQYXXgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724342815; c=relaxed/simple;
	bh=0lLsbeEUib7lCp0zcdEI2+shBa8mRpljo8yw7HZtKME=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EPlko1I3yYGxQn8duP71wZU/w7hvsVVYmLbxqHi5Nhw5LJZOT6FRhLzCdiBqaw710ZrWdJshpLDyQu2qaoZC9dD+sCwayBHuvn0JorrylP5YnC3Hx9YoCX+dTUhtM9J02jk8WniScoZNTjxniZ28yK8rhgyFF1gJV3xi5CHT8wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=dg1EpSH5; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="dg1EpSH5"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id CBFE52E407;
	Thu, 22 Aug 2024 12:06:46 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=0lLsbeEUib7lCp0zcdEI2+shBa8mRpljo8yw7H
	ZtKME=; b=dg1EpSH5FxYh0izeR8lJjTscZxd5haBAtFXCcqNH7Yxs71GliXu9rs
	podPnYMJEsKxnYkVD6l2P92NBCyItINcemc8hLrjjINFACw1JFiGg7xy6B4i4CDl
	1WqziR4+2H9LuzqHpH+AuHrJnUJUl+LIUHhstklfEGFqZbGqfdXN8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C3FE82E404;
	Thu, 22 Aug 2024 12:06:46 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 338002E403;
	Thu, 22 Aug 2024 12:06:46 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 19/20] transport: fix leaking arguments when fetching
 from bundle
In-Reply-To: <Zsb0qU-G4kdlxrWa@tanuki> (Patrick Steinhardt's message of "Thu,
	22 Aug 2024 10:19:53 +0200")
References: <cover.1724159575.git.ps@pks.im>
	<b72f7d1ee394291a018061c91222ea17a99c2e53.1724159575.git.ps@pks.im>
	<xmqqseuxyck4.fsf@gitster.g> <Zsb0qU-G4kdlxrWa@tanuki>
Date: Thu, 22 Aug 2024 09:06:45 -0700
Message-ID: <xmqq8qwotucq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 87DDAA76-60A0-11EF-92D3-9B0F950A682E-77302942!pb-smtp2.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> Yes we do, because there is an early return in case `verify_bundle()`
> fails. I didn't notice that we have it in `unbundle()` though.

Ah, I missed that one.

> I'd argue it's bad practice to have `unbundle()` clear the caller
> provided args for us and somewhat surprising.

I was surprised so it makes it at least two of us.  In some call
patterns, having the callee _consume_ what the caller fed it may
be natural, but not in this code path.

Thanks.
