Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B095318BC05
	for <git@vger.kernel.org>; Tue,  3 Sep 2024 17:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725384464; cv=none; b=U9zNRq7PiGCkpiEM8x7rs3Yb1LqBBQofek8H6MkZFsKVVFPB13ssFrX1NKLEhQ/7yN+d0XI+mGpklZPpaBM5ba4j17VBQZ7bZCnEvQfWRndtzjKodauKwiWdZt5z3v+0agZariMsJA3+O2FN02jyDBNDh7mNvLZbnuYEv/N11Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725384464; c=relaxed/simple;
	bh=hraS6mmv+xpwYM+SBZTTw6cZAZDZAxKl8IebcKuxryE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TI2X49LBN/NS2lzjmERpuUDR9O5uwUG6Nrputl63yOrI+bn6Xq71FxiDr3GsYLbC7O0CTErqsgn0uqcyOKBpfjSpcTQhbsvUcFhxNYChHVAv4STTng0+XJ+Ph+9tB6DN18c78svHSlgOlU10sxA4zEqvOEnnidBWDFvlOiePdkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=kZkF9zdb; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="kZkF9zdb"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 86FBC273B6;
	Tue,  3 Sep 2024 13:27:41 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=hraS6mmv+xpwYM+SBZTTw6cZAZDZAxKl8IebcK
	uxryE=; b=kZkF9zdbWmYenkUbthvmT2qf+xSNbwrY8OtfSlqQi9EEdt07kyryjw
	79W+Z7R5NtCWeDm39wg/YChUe0KtVH1OAMWada2YZonnikVU6qMnhc7UG7sYlIkD
	UE9cc66oCmA8YFASPnngCb6xKweOdER8395gvoodLwINfAFafHc8k=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7F321273B5;
	Tue,  3 Sep 2024 13:27:41 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E1C0F273B4;
	Tue,  3 Sep 2024 13:27:40 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Taylor Blau <me@ttaylorr.com>,  git@vger.kernel.org,  Jeff King
 <peff@peff.net>,  "brian m. carlson" <sandals@crustytoothpaste.net>,
  Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 2/4] hash.h: scaffolding for _fast hashing variants
In-Reply-To: <ZtXAhP69zu7cDnsA@tanuki> (Patrick Steinhardt's message of "Mon,
	2 Sep 2024 15:41:24 +0200")
References: <cover.1725206584.git.me@ttaylorr.com>
	<6ac6f934c32bdc600cdb8d2a08d4aa390c1f2994.1725206584.git.me@ttaylorr.com>
	<ZtXAhP69zu7cDnsA@tanuki>
Date: Tue, 03 Sep 2024 10:27:39 -0700
Message-ID: <xmqqh6awlkac.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 D2755494-6A19-11EF-BF9F-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> While the property we care about in the context of this patch series
> indeed is that the second hash is faster, I think the more important
> property is that it's insecure. If I were seeing two APIs, one labelled
> fast and one labelled slow, I would of course pick the fast one. So I
> wonder whether we should rename things accordingly so that developers
> aren't intrigued to pick the fast one without thinking, and also to have
> a more useful signal that stands out to reviewers.

I do not think this topic is going in the direction it set out to,
but if we are to resurrect it by 

 (1) first to ensure that we won't overwrite existing on-disk files
     and other things as needed to safely swap the tail sum to a
     cryptographically insecure hash function;

 (2) devise a transition plan to use a hash function that computes a
     value that is different from SHA-1 (or SHA-256 for that
     matter); and

 (3) pick a hash function that computes a lot faster but is insecure
     and transition to it.

we will need to clearly label the two hash functions as such.

We may also need to consider similar points if we need to name
pseudo random numbers we use, to clarify the requirement of the
caller (e.g., can a caller that wants security use it?).

Thanks.




