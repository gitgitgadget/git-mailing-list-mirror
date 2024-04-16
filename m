Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBD039FCF
	for <git@vger.kernel.org>; Tue, 16 Apr 2024 22:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713307158; cv=none; b=Ci0RtZ6/JP42X9YFK1+bqJxtK+E7WIi364Ly4DSE8Ufwt39fAVXIOlMAJ2zYNeYWgC/PjPf14G6JGNh33Nmfq206ksF0bix3Vx7saJgvtVY5yJqN0TykHn7kGtbYTdQsTcwpv6lR43ys9J3LOxKiIDji8PrYQQSEeaNV6X9fVjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713307158; c=relaxed/simple;
	bh=Qrw5EWLDH0GAyi56niFj6ZIrbPJzR5NFaz/dE73Ak2Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NzF5Dwfh5RoWjND5yPBSA7+utzCDhaH8SMS3ePzPNxu+4496wO4Vnjeb657iCM/Pt8TFN5WYFybNXUiaQBoVkYrCoPLc+pF8wTid5tB0XgHGOeCMysKn0wclE2clOb5kJJX+NUlpQsfolMH4XMfzi3gFlCzbBVY8YGKc6unniJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=q8A37MU7; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="q8A37MU7"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 6B1D51D35CF;
	Tue, 16 Apr 2024 18:39:16 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Qrw5EWLDH0GA
	yi56niFj6ZIrbPJzR5NFaz/dE73Ak2Y=; b=q8A37MU7QTTFA6n6xtg1/ayZ9wYu
	AVK0X40jgzvYBL/Q1xQP29zgTUJ83HWNDVyDQQXb7L4YpnBDf8smrqyh6Sn8c+l/
	EWZ9hCSbsXq5zY0+JV5gztArZ97/WEVOuEOH1uC3k1yQowBU8qjig9+2UcKldecj
	r+l39mpQabki+LM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 627B51D35CE;
	Tue, 16 Apr 2024 18:39:16 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C96471D35CD;
	Tue, 16 Apr 2024 18:39:15 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH] apply: avoid using fixed-size buffer in
 write_out_one_reject()
In-Reply-To: <a93cd243-cb17-4ad5-8d23-30768dc5213b@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
	message of "Tue, 16 Apr 2024 22:16:05 +0200")
References: <a93cd243-cb17-4ad5-8d23-30768dc5213b@web.de>
Date: Tue, 16 Apr 2024 15:39:14 -0700
Message-ID: <xmqqr0f5c4q5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 27A7F39A-FC42-11EE-97F5-25B3960A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Take care to work around (arguably buggy) implementations of free(3)
> that change errno by calling it only after using the errno value.

;-).

The "do everything including giving an error message, jump to the
exit label where resources are released just before returning"
pattern naturally gives us that, which is very nice.

Will queue.  Thanks.
