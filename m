Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF2713B59F
	for <git@vger.kernel.org>; Fri, 21 Jun 2024 19:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718999138; cv=none; b=fs3wI83150ohdnRMtt5yAPjr5xXRsDdrvIFOuIxHc9MK4pp2m6ZYpA3a4V1ZGlieYOCDdSdDwkYiP7jDXYlWbM1NT3nIoGrFqQGv26FcWKQrAskXlUDjGA9mD8n5G5VBRwMhjoY7vBAj4AllVrOYDrkM1jqpTj/ZjuV7TqjV4jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718999138; c=relaxed/simple;
	bh=/CBybil5eCfvnkIwKFrhZzm52yH+eiWqM7tiDPIDo4c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Q1Qcvd1qMvh/+YGCJv5XSsWxqYmAa+SPkteXmVvbwsIAhCULYqMRh6GM/xMid+fpwbgqyzBXZmc1HhxWQQHPxOGNU/GkoqOguwl2Oaj95nmMjavKAY/pjDlwZvv+2jnwyGdMfZ7CsAQusqFoZv9NXPLFJUu4LEUHsjfPG9Ci6Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=JhPheowp; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="JhPheowp"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 78BAF225CE;
	Fri, 21 Jun 2024 15:45:30 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=/CBybil5eCfvnkIwKFrhZzm52yH+eiWqM7tiDP
	IDo4c=; b=JhPheowpc4ZEPo0lmpKStbTGj62RvxyWH80mirSDClW+V4O2s0ny0R
	VGEFOfPSLae0CFENJvjHRWAWiXG06EQaQqPnqIabZFI8/6t3aJxzjQgcsptKfAlK
	r7k7ojGd85ZGSgjBa/K3Z2NZgX7xFQzDIIzfunwj99twy064Tsw+k=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 70958225CD;
	Fri, 21 Jun 2024 15:45:30 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CFCD3225CC;
	Fri, 21 Jun 2024 15:45:29 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Wong <e@80x24.org>
Cc: Jeff King <peff@peff.net>,  git@vger.kernel.org
Subject: Re: [PATCH] cat-file: reduce write calls for unfiltered blobs
In-Reply-To: <20240621194221.M879537@dcvr> (Eric Wong's message of "Fri, 21
	Jun 2024 19:42:21 +0000")
References: <20240621020457.1081233-1-e@80x24.org>
	<20240621062915.GA2105230@coredump.intra.peff.net>
	<20240621194221.M879537@dcvr>
Date: Fri, 21 Jun 2024 12:45:28 -0700
Message-ID: <xmqqiky2jd0n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 D08E1B22-3006-11EF-BFEC-965B910A682E-77302942!pb-smtp2.pobox.com

Eric Wong <e@80x24.org> writes:

> Cool, I'll look into it and probably combining the approaches.
> Optimizations often have a snowballing effect :)
>
>> But anyway, that's a much bigger improvement than what you've got here.
>> It does still require two write() calls, since you'll get the object
>> contents as a separate buffer. But it might be possible to teach
>> object_oid_info_extended() to write into a buffer of your choice (so you
>> could reserve some space at the front to format the metadata into, and
>> likewise you could reuse the buffer to avoid malloc/free for each).
>
> Yeah, that sounds like a good idea.
>
>> I don't know that I'll have time to revisit it in the near future, but
>> if you like the direction feel free to take a look at the patch and see
>> if you can clean it up. (It was written years ago, but I rebase my
>> topics forward regularly and merge them into a daily driver, so it
>> should be in good working order).
>
> Thanks.  I'll try to take a look at it soon.

Thanks, that's an exciting direction to go in.

