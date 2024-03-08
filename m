Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D358139F
	for <git@vger.kernel.org>; Fri,  8 Mar 2024 00:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709858450; cv=none; b=d+IYCyUXl3xK5U+9TX9BOomwTah91p0pdVcuPNV92iSsI96t94GQyiddbXk5wbTgOi4ZnDwMkooNMyPn4SbUVJsbYVDr7ur0/S5Fk1sPFs25vf05LTbXPYQwvbkXWcotzPFYUFUGhHNQ8nO2FZ1G1f0zSQZA2dbYko9UZS/mLtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709858450; c=relaxed/simple;
	bh=77BYhLg+gnWsWlJr5QkmfGt/4RxTFNN986XVXVv+1Gs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DQTFoUi7mPzFxz68toq2K2XFIDyG91UDyMPk3xHJvFmo+FcEhO0Rye44vkVHm5J/neqGsy4FBn2RdVg5zScDflerZrv+ozwr4VRLHg7kIENehJLVuQ46n1T4S7qNtEYaLnTJuSc4dc9ogtSvryo178s4kAuBUIKwvqoBg/AQQb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=is1std4P; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="is1std4P"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0D7F91D93B4;
	Thu,  7 Mar 2024 19:40:48 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=77BYhLg+gnWsWlJr5QkmfGt/4RxTFNN986XVXV
	v+1Gs=; b=is1std4PdmnVo52K6OrS6NuNEZzkn2ayoiIRKfo4DhR1Qf0qpKWfxw
	iVKQUC29NILcu/OrcO6O1eg6laYmcsfjphlvgsV6ypnMUm19rHyEcXQIjYXV4EZp
	OBtFquX+9rCgFinfHOYiyOoYbecz3R1v4gRrZO4R1eaH9DjuFYB/Q=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 05D951D93B3;
	Thu,  7 Mar 2024 19:40:48 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7191A1D93B2;
	Thu,  7 Mar 2024 19:40:47 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 2/2] reftable/block: fix binary search over restart
 counter
In-Reply-To: <xmqq7cidk4e4.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
	07 Mar 2024 15:29:07 -0800")
References: <a4312698cceab5f2438c9dd34465da21d719e256.1709825186.git.ps@pks.im>
	<cover.1709843663.git.ps@pks.im>
	<370b608f9007abe9c0562d76894e2475d19867a1.1709843663.git.ps@pks.im>
	<xmqq7cidk4e4.fsf@gitster.g>
Date: Thu, 07 Mar 2024 16:40:46 -0800
Message-ID: <xmqq34t1k12p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 8149B83E-DCE4-11EE-9648-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> Patrick Steinhardt <ps@pks.im> writes:
>
>> The consequence is that `binsearch()` essentially always returns 0,
>> indicacting to us that we must start searching right at the beginning of
>> the block. This works by chance because we now always do a linear scan
>> from the start of the block, and thus we would still end up finding the
>> desired record. But needless to say, this makes the optimization quite
>> useless.

>> Fix this bug by returning whether the current key is smaller than the
>> searched key. As the current behaviour was correct it is not possible to
>> write a test. Furthermore it is also not really possible to demonstrate
>> in a benchmark that this fix speeds up seeking records.
>
> This is an amusing bug.  

Having said all that.

I have to wonder if it is the custom implementation of binsearch()
the reftable/basic.c file has, not this particular comparison
callback.  It makes an unusual expectation on the comparison
function, unlike bsearch(3) whose compar(a,b) is expected to return
an answer with the same sign as "a - b".

I just checked the binary search loops we have in the core part of
the system, like the one in hash-lookup.c (which takes advantage of
the random and uniform nature of hashed values to converge faster
than log2) and ones in builtin/pack-objects.c (both of which are
absolute bog-standard).  Luckily, we do not use such an unusual
convention (well, we avoid overhead of compar callbacks to begin
with, so it is a bit of apples-to-oranges comparison).

