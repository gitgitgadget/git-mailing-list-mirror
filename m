Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104102C853
	for <git@vger.kernel.org>; Sun, 21 Apr 2024 19:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713727586; cv=none; b=hloVtGkzvscaTLdgi6ripSN1Pz02OIjpGixAnQVP7jCJHKAlzgsFS736+6c5WRliddnC7Id01xnc08dGYce391F4HIsyzZpDNu9GY6Fq9Mz2ry14TxXFBG2w/VaZFvOVjBIu7CDPA/MKeiEp38mq4Ac+ypNkkyGsAwku/NY8MKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713727586; c=relaxed/simple;
	bh=IijJk8ej/DbSM4ELygMg4FrT0MKm5chA9qqKKgaxjxA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hN7LGnuYfHIkDG9ophizrKouH7GhD0iWlJ3AvzJBRYb1VY6g2yuHIoW6dZYjjR6n5EV41jKAWRrXiOygn+utGiiCAYmTs2p5jiJXKQcoC1V3fhxuHntOj9+EW824kNLq5ZTpo8vuIKWQZ0FEcQ0/fJllB/FcaQ2GggOhkK4ctvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=bjXtypAx; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="bjXtypAx"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 01D8E1EFA05;
	Sun, 21 Apr 2024 15:26:24 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=IijJk8ej/DbS
	M4ELygMg4FrT0MKm5chA9qqKKgaxjxA=; b=bjXtypAxzcXBNJNuhDtIdMR95KYv
	WTqg02Mr2SKsfkot989RF7hJvbsjnA06+KxsmS7t5uSfDSBPke3qwsCf4uUjD5wt
	CJFk4s+b+id5PoXjyazmYtdqaUOtdSA38mrmE1cER6G9MJMIUGWnRVsdTtlYNSSn
	ENaHwnZ8L6Txuvw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id ED3031EFA04;
	Sun, 21 Apr 2024 15:26:23 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 66A161EFA03;
	Sun, 21 Apr 2024 15:26:23 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>,  Jeff King <peff@peff.net>
Subject: Re: [PATCH] don't report vsnprintf(3) error as bug
In-Reply-To: <ea752a2b-9b74-4a59-a037-4782abf7161e@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
	message of "Sun, 21 Apr 2024 14:40:28 +0200")
References: <ea752a2b-9b74-4a59-a037-4782abf7161e@web.de>
Date: Sun, 21 Apr 2024 12:26:22 -0700
Message-ID: <xmqqa5lm1pr5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 0A07D90A-0015-11EF-A185-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> strbuf_addf() has been reporting a negative return value of vsnprintf(3=
)
> as a bug since f141bd804d (Handle broken vsnprintf implementations in
> strbuf, 2007-11-13).  Other functions copied that behavior:
>
> 7b03c89ebd (add xsnprintf helper function, 2015-09-24)
> 5ef264dbdb (strbuf.c: add `strbuf_insertf()` and `strbuf_vinsertf()`, 2=
019-02-25)
> 8d25663d70 (mem-pool: add mem_pool_strfmt(), 2024-02-25)
>
> However, vsnprintf(3) can legitimately return a negative value if the
> formatted output would be longer than INT_MAX.  Stop accusing it of
> being broken and just report the fact that formatting failed.

""" ... function returns the number of characters that would have
been written had n been sufficiently large, not counting the
terminating null character, or a negative value if an encoding error
occurred. Thus, the null-terminated output has been completely
written if and only if the returned value is nonnegative and less
than n.""" is what I read in some versions of ISO/IEC 9899.  It is
curious that it does not say anything about the consequence of a
parameter error arising from int (the type snprintf family of
functions returns) being narrower than size_t (the type of the
parameter n), but your point still stands that vsnprintf() can
legitimately fail, and it is not a programming error.

Thanks, will queue.
