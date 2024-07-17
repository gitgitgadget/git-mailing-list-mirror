Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D262EAE5
	for <git@vger.kernel.org>; Wed, 17 Jul 2024 14:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721228185; cv=none; b=EX+rLKI9poFh8k5vCL83yWXdbwyV27qQuTodBIbackTg7qY8k5ceOlNYr/W4R5edfe8BAKoe6kmVsBeAW3If6tIBIulHb8UYHhl51H2c7xbIt5eqWxQmJojGY6LTLNxc+32AcHM3cw6gKIDiJW+2sl1ynrqA39yI4VfY9JcAeMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721228185; c=relaxed/simple;
	bh=qVd2LoiH9z6LNNCf16cWrv/m+33mHJF0XVaV0vzux1A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aVrLn5n9/hm5bFi9aB8Bp1DKjudq+eaxcHiDdy9jS1DFeCLykPbtGvAEFNAWpH/rFeBJi/UqDj0XVTTDbRd4GmM7wNJZXBBmNEVKC1YNGqnvzNy0Ow75ddT5Afrxyh3s+u1LixY4XFKnb5xDGUVpgJvRxIFafo/6PnUn7Dh9ULA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=EsIRt6ET; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="EsIRt6ET"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9ACE31FC84;
	Wed, 17 Jul 2024 10:56:22 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=qVd2LoiH9z6LNNCf16cWrv/m+33mHJF0XVaV0v
	zux1A=; b=EsIRt6ETROUWKUa96akpB39KZ+DKUN4FqsSNM1Rm3wzR/RaVTObCcM
	2EEoaAa+gD/gkUYoX+vTjSJjZrgN4FZdWRqYSnluUVenhxMqM603EQyL4XfH3LDK
	hajREVbpaKSRNI1vvmrxoITCG5DnyzTewEqIQ55Lh7/iB2w0GeCuc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 933231FC83;
	Wed, 17 Jul 2024 10:56:22 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 000751FC82;
	Wed, 17 Jul 2024 10:56:21 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org,  =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason
 <avarab@gmail.com>
Subject: Re: [PATCH] Revert "reflog expire: don't use
 lookup_commit_reference_gently()"
In-Reply-To: <20240717054555.GA547635@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 17 Jul 2024 01:45:55 -0400")
References: <xmqqv8156rh2.fsf@gitster.g>
	<20240717054555.GA547635@coredump.intra.peff.net>
Date: Wed, 17 Jul 2024 07:56:20 -0700
Message-ID: <xmqqy1605ap7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 BB2B7DBA-444C-11EF-A3A7-5B6DE52EC81B-77302942!pb-smtp1.pobox.com

Jeff King <peff@peff.net> writes:

> It does make me wonder if there other gaps for reflogs that point to
> non-commits. E.g., if I have a tag pointing to a blob, would we save its
> reflog entry if a reachable commit points to that blob?. I suspect not,
> as the full reachability check is very expensive.

reflog.c:should_expire_reflog_ent() says that anything that is not a
commit should be expired without doing the unreachable() check, and
the UE_ALWAYS flag used for that is set by the function in question.
This arrangement has stayed the same since daf1d828 (reflog expire:
don't use lookup_commit_reference_gently(), 2021-12-22).

Thanks.
