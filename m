Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20383B66C
	for <git@vger.kernel.org>; Sat, 17 Aug 2024 16:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723912932; cv=none; b=TX2bhOpBBboZ5ZZ42b2ewlRMnbg2HkdbOY6B0s83thpT3V3tzA+eYziKOi2F1zgmi5UAy9KW3XPOcDmMBmr46EUCx8q0KuX0Bwj3pDs+xCa+4tLwKh6N8oweG/ZoXJeWm0w09OCWiR9Q+iF8mrLcJj8O6cqWCjD3+VxT1bEhkDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723912932; c=relaxed/simple;
	bh=SVBcfU8uMDSDJg9ID4bzIEhr6P1hWLGpa0FFrR1ZrLo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=C5CQHWz2FsG8HK08dr2Lvm7mCspg8wGejE+XfMvg036HDRy+c9B8FP/tYwKgkzbMmxdsX+79JIaZdQLQ9GkQVbv6rbfKsVIjJUu9EBA7buiiba/ZohCWDI3whSedJMQKyPsCY5vjycBeovIJ50t2tOL4wfmiMtcifcsVAOm0l/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=sicKPdW0; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="sicKPdW0"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 468A61863A;
	Sat, 17 Aug 2024 12:42:03 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=SVBcfU8uMDSDJg9ID4bzIEhr6P1hWLGpa0FFrR
	1ZrLo=; b=sicKPdW0MqsaITT4qsS7tMLfQVHZhL1ayq41AN0bHQk0CR4Rv8uh4Y
	QBhOd6nQuzFMhLHSS7Svxwt7pdEeVgJbOcQEIVDmVfrls3zpBzEt/DC7xa5Qmsw6
	l+9GUXO3LqN6dsTPX/2cg7nxHBHCk7no0+fGUqr508ayDHEHc1PAU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 3F16918639;
	Sat, 17 Aug 2024 12:42:03 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A81EE18638;
	Sat, 17 Aug 2024 12:42:02 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Taylor Blau <me@ttaylorr.com>,  git@vger.kernel.org
Subject: Re: [PATCH 5/8] pack-bitmap-write.c: select pseudo-merges even for
 small bitmaps
In-Reply-To: <20240817103401.GB551779@coredump.intra.peff.net> (Jeff King's
	message of "Sat, 17 Aug 2024 06:34:01 -0400")
References: <cover.1723743050.git.me@ttaylorr.com>
	<0fea7803d86ca17451af408e1bf93c32690edc44.1723743050.git.me@ttaylorr.com>
	<20240817103401.GB551779@coredump.intra.peff.net>
Date: Sat, 17 Aug 2024 09:42:01 -0700
Message-ID: <xmqq8qwvhzja.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 A1524FBC-5CB7-11EF-9B14-9B0F950A682E-77302942!pb-smtp2.pobox.com

Jeff King <peff@peff.net> writes:

>> Select pseudo-merges even for bitmaps with fewer than 100 commits to
>> make such testing easier. In practice, this should not make a difference
>> to non-testing bitmaps, as they are unlikely to be used when a
>> repository has so few commits to begin with.
>
> I think you could argue that if there are fewer than 100 commits in the
> history that pseudo-merge bitmaps are overkill, so it does not matter
> much either way. But I think being consistent with our behavior (i.e.,
> generating them if asked) is important for testing and debugging.

OK.  I had an opposite reaction to this change, i.e. "eh, are we
lifting the safety that protected the users from asking for a
suboptimal way to pack, only to make it easier to write this test?",
but I do buy "the user tells us to do the suboptimal thing, we do
that thing."
