Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B644199FB3
	for <git@vger.kernel.org>; Tue, 10 Sep 2024 15:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725981281; cv=none; b=EjTbPXuNGOQUZhfpSWUyauIf/tI31fXa831jy5Iw80CzsoS5oeNDTNLYLifhmmi3k+XcOAoCFYQszPq0g30QByYNrIBGc0FA75r2T737xClE0hXa/w8joFA75w240HoD+i0rQhznWgKN3//jc9f62lAkmnfiV68eDsvvVV5yJfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725981281; c=relaxed/simple;
	bh=xMnAgEFhtYVvI6D8ktDCgQIzpoDu8JBJ+ViKIWk9uc4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kDQ8WQL3wjaL0yrwdPrOBzJ3fgUJfJ8O7d/I9ysej327MMhxqyv0T1MJZF4YhLHW2yYXLIRq6wunIH4HTdJXayEUXPkkaeN5rcx5SmjxA7WO7MAznF8e0XfIB7bNArNSPRk7P3L92nyGdpBa3RHSdmnevk3kCSxIvd2zhtUGfOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Ik52zg8i; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ik52zg8i"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D162D38259;
	Tue, 10 Sep 2024 11:14:29 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=xMnAgEFhtYVvI6D8ktDCgQIzpoDu8JBJ+ViKIW
	k9uc4=; b=Ik52zg8itzlYP19DvxKCbEX6jwn4EUPMLuzOWunGzcK0n2MdiSbQi3
	7EyROxDWfNsCq04zMLC40lbPhfIVHt/vyk2hi/U+9e3XqFCsRmYGrcQdEt8k2Bie
	/9f3VBUp9sLn0xlFfJAijwNxmmOgn4P9ZoaT7RPbXJdWBHPzoHD8M=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C905438258;
	Tue, 10 Sep 2024 11:14:29 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3C00838257;
	Tue, 10 Sep 2024 11:14:29 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Taylor Blau <me@ttaylorr.com>,  git@vger.kernel.org,  "brian m. carlson"
 <sandals@crustytoothpaste.net>,  Elijah Newren <newren@gmail.com>,
  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v3 3/9] finalize_object_file(): implement collision check
In-Reply-To: <20240910065333.GF1459778@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 10 Sep 2024 02:53:33 -0400")
References: <cover.1725206584.git.me@ttaylorr.com>
	<cover.1725651952.git.me@ttaylorr.com>
	<0feee5d1d4fc1e0aa1ca5d98f2f404ecdbb2f6b6.1725651952.git.me@ttaylorr.com>
	<xmqqh6asv4nn.fsf@gitster.g>
	<20240910065333.GF1459778@coredump.intra.peff.net>
Date: Tue, 10 Sep 2024 08:14:27 -0700
Message-ID: <xmqqr09rmtgs.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 5FF02CFA-6F87-11EF-AF06-9B0F950A682E-77302942!pb-smtp2.pobox.com

Jeff King <peff@peff.net> writes:

> Now thinking on it more, that view is probably dumb. fstat() is really
> cheap, and byte-wise comparisons are really expensive, so if it has even
> a tiny chance of helping, it might be worth doing.

If we see too many "yikes we need to check for collision" cases,
then yes, but I agree that it should be rare to matter.

> Though again, I'd hope this will trigger pretty rarely in practice,
> because it's probably a sign that we could have skipped work earlier
> (i.e., by realizing we were just going to generate an identical file,
> and not generated it in the first place).

Yes, exactly.
