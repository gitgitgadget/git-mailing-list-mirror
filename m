Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686EA4405
	for <git@vger.kernel.org>; Sun,  9 Jun 2024 18:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717959319; cv=none; b=TTssTxUo/SUmd4bjJn9slMOGxYNmbiM3iWylxxOg4KfplhciE7rYqW1Ti5WRJgyq9MaPyCX09QlAod3Ns1vR6A7jMoSbbKlirJwM8p2Yw/fTJroK7ViySb+QQQm07NyuP/l1cZtjdRhAwhY+bWWIm6vq0E6W6j/Qaz3ehNYRKv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717959319; c=relaxed/simple;
	bh=WbVyZXCZJMoTzLj02sP5CiaQ/BT1XJ5VzuUGJnWLvrQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MkxXMJpPxBd1CuNxpC5CbS8Xybu0SWiuv5DOIDZw7Awo7njdLKXKTBzW282L6mCpiWoEMhuqHlCQmzzPp5VVy2JwI2j88Ldg6W66R4VrMRzlZHKuyugu3hGrYvo9qMFdM6zC5rIzM47L9xuSh0YgaMGTgHJWNNHWnvDBGYE+z4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=w3pAHs8s; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="w3pAHs8s"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D55A628543;
	Sun,  9 Jun 2024 14:55:10 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=WbVyZXCZJMoTzLj02sP5CiaQ/BT1XJ5VzuUGJn
	WLvrQ=; b=w3pAHs8spVNV+ebD3rI1rc9kigpk+lcbxcqIyFfWW5rpwEkILgT2vd
	IO7OQEsJjPDzAIUgVJO82SPDDQaEQZCh2HjT7bIXZAQEwqz6ut9ktjpYUEyXGDDa
	xwYFv5SnRpO32ki2ehgVZxThZJd0YZbq0nd/eLw8jrpsZXrqizJd8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CD90428541;
	Sun,  9 Jun 2024 14:55:10 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2119C2853F;
	Sun,  9 Jun 2024 14:55:09 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: Jeff King <peff@peff.net>,  Kyle Lippincott <spectral@google.com>,  Git
 Mailing List <git@vger.kernel.org>
Subject: Re: MSan failures in pack-bitmap
In-Reply-To: <ZmXKzJ9CpbYTmTwC@nand.local> (Taylor Blau's message of "Sun, 9
	Jun 2024 11:31:24 -0400")
References: <CAO_smVjSy6j7jpSxHNsxzJfxnHwjLphsqu5jwd8TBhMLp72XPw@mail.gmail.com>
	<20240608081855.GA2390433@coredump.intra.peff.net>
	<ZmXKzJ9CpbYTmTwC@nand.local>
Date: Sun, 09 Jun 2024 11:55:07 -0700
Message-ID: <xmqqmsnuaqus.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 CB1C838C-2691-11EF-BF9F-B84BEB2EC81B-77302942!pb-smtp1.pobox.com

Taylor Blau <me@ttaylorr.com> writes:

> Unfortunately, the regression happened in 795006fff4, so this is in a
> released version of Git. But this is all behind a configuration option,
> so affected users can reasonably work around this issue.

Can you elaborate a bit about "reasonably work around"?

I am imagining that you are saying that the user can say "do not use
bitmap, because it may be corrupted due to an earlier regression" in
some configuration, so that a corrupt bitmap data is not used to
further spread the damage, but how does a user find out that on-disc
midx is broken and a workaround needs to be employed in the first
place?  After working around the issue by avoiding to use the
corrupt on-disc data while waiting for a fixed version of Git to
come, what does the user need to do to start using the now-corrected
feature again?  Does the fixed code notice there is an existing
breakage caused by the regression and remove the broken file
automatically?

Thanks.
