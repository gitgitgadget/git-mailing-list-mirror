Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFDFC1DA3F
	for <git@vger.kernel.org>; Fri, 26 Jan 2024 16:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706286370; cv=none; b=fGOYJibj6bolEy2k7gEMHA1ttnVXBJUzPWH+7soYXfeeofCF+vqzgS2qgKZjHSNzuEjVKGFa2SpuLpZzyUV6ZWKPfBE5OFh5aUS+02DQFQPRL772eUsQhKbzatF0ityW38W1AhjzDdc1Klu3RatHBoVA46ZzEToGk+MaAhylTCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706286370; c=relaxed/simple;
	bh=NRsuuSlzX5ep15FKkHHRCI+LpshHDP4QP8oSMGebCJs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jjYL6vCSrOfMOmOBMHU1yhW6tKzeHovAPrb9tMzxG3k47yii1IB9F23/Dp7OAhzGo2O+A2EUIoq+jw1ash27QX8YNoVCK5x0fnIpDi8Kl+FTyqoPbXhoU14tnDkPU2PU3QbiBnv6wAk5eQKT7cA4U+kdfXhvTYfK3TsOPo19PxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=wox1EjRV; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="wox1EjRV"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 4726C1CD3F8;
	Fri, 26 Jan 2024 11:26:07 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=NRsuuSlzX5ep15FKkHHRCI+LpshHDP4QP8oSMG
	ebCJs=; b=wox1EjRVn6eT7LXxlDTDUEOOBnLNfwKlDaUGbkRATq5n+yrBmJJZOl
	4TtqnYFDQVjEPdbQGQ3YCajZM6O0UBuG5WyTRe4KLrKxL3lNGMuxqTgT45JOcptM
	iaSPfjtf0fyRRrX99zac3QLroNGojVkEeB6kHCWx2k9WU8DpsP0qI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 1449F1CD3F7;
	Fri, 26 Jan 2024 11:26:07 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B953E1CD3F4;
	Fri, 26 Jan 2024 11:26:05 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/5] reftable: fix writing multi-level indices
In-Reply-To: <cover.1706263918.git.ps@pks.im> (Patrick Steinhardt's message of
	"Fri, 26 Jan 2024 11:31:30 +0100")
References: <cover.1706263918.git.ps@pks.im>
Date: Fri, 26 Jan 2024 08:26:04 -0800
Message-ID: <xmqqy1ccnjs3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 9AAE7D16-BC67-11EE-8FD5-25B3960A682E-77302942!pb-smtp2.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> yesterday I noticed that writing reftables with more than 250,000 refs
> led to the last block of refs in the table not being seekable anymore.
> As it turns out, 250k refs was the boundary at which we start to write
> multi-level indices for refs.

Obviously one of the less exercised corners of the code ;-)

> The topic depends on Junio's jc/reftable-core-fsync at 1df18a1c9a
> (reftable: honor core.fsync, 2024-01-23) due to a semantic merge
> conflict in the newly added test.

Thanks for the note for the base.  John Cai's work is well done and
has been reviewed, so let's merge it down to 'next' soonish.

Thanks.
