Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A622D39B
	for <git@vger.kernel.org>; Thu,  8 Aug 2024 00:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723077158; cv=none; b=bfnPDB7cgJ1FRWxPPmIatkcOaRfeJ4CH6XWBjybOxptlf9sdnAWSoidc98qGgDA4COWHVAPijKk53CNRRHNiS/DIHc7d+eSX2axFY3V71jBabmn8JALlHhIATiH1bNT+DMiYI1AaihN1qFWeUD7sCnn51Hwr4uyTa+8tjQA3N+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723077158; c=relaxed/simple;
	bh=2kkYTQBHTV+zkhi7ezoVx9KA+eyvJw8SeWfctdfGSFU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qFM/8f3irM6htMss0lkUW86HH30l2l6AOUDRz0sKLc6kZZuwMLR1m4tnRh2PL3A9nzJnqaiY8opr6VO4umYi6a5CL14JaP7+AiIKJbgmkTRGfCIh3hcRe9fr43/UzH4Tmp/dbjGERDDJmqEWArHQ3vQP2XOgDTNFOyHNxGYEg9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=diTZ3wpo; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="diTZ3wpo"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 62B9E1C26F;
	Wed,  7 Aug 2024 20:32:35 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=2kkYTQBHTV+zkhi7ezoVx9KA+eyvJw8SeWfctd
	fGSFU=; b=diTZ3wpojbAZQ3qdbGGn7hNzQIjX+kOZv6mL5Z3Aibgq3w8VyaWfCi
	kp+evAv36IeuRDIZstMmmPgRV9dLLnt278qRHHclCKTcqEn74dPxl2oVtH2Eanza
	n0XkfsQTdYKVhVdnYWR4UlcXdd3IB0odZO5FnFt6bFH8GJgaPKNB0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 5B4B91C26E;
	Wed,  7 Aug 2024 20:32:35 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BEF3A1C268;
	Wed,  7 Aug 2024 20:32:34 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 00/22] Memory leak fixes (pt.4)
In-Reply-To: <ZrOo0DuiPeSp9E0b@ncase> (Patrick Steinhardt's message of "Wed, 7
	Aug 2024 19:03:12 +0200")
References: <cover.1722933642.git.ps@pks.im> <xmqqy158nu9w.fsf@gitster.g>
	<ZrOo0DuiPeSp9E0b@ncase>
Date: Wed, 07 Aug 2024 17:32:33 -0700
Message-ID: <xmqqo763n9b2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 B4D40194-551D-11EF-854D-9B0F950A682E-77302942!pb-smtp2.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> On Wed, Aug 07, 2024 at 09:59:39AM -0700, Junio C Hamano wrote:
>> Patrick Steinhardt <ps@pks.im> writes:
>> 
>> > The series is built on top of 406f326d27 (The second batch, 2024-08-01)
>> > with ps/leakfixes-part-3 at f30bfafcd4 (commit-reach: fix trivial memory
>> > leak when computing reachability, 2024-08-01) merged into it.
>> 
>> A quick question.  Is it on your radar that transport_get() leaks
>> the helper name when "foo::bar" is given as a remote?
>> 
>>   https://github.com/git/git/actions/runs/10274435719/job/28431161208#step:5:893
>> 
>> If not, I'll handle it separately, whose fix should look something
>> like the attached.
>> 
>> Thanks.
>
> Yeah, it's in part 5 [1], 97613b9cb9 (transport-helper: fix leaking
> helper name, 2024-05-27). Feel free to handle it separately though, I'll
> wait for part 4 to land first anyway, which likely takes a couple of
> days.

OK, will do, as this seems to break CI.
