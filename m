Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E0712AAC9
	for <git@vger.kernel.org>; Wed, 24 Jan 2024 17:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706116975; cv=none; b=mYL2FTRpLIIVD4rc0z1prvnZRBe8oesr0drSS02nlKKKhTzLqCJzzXmTEhQWFR6IXXVg3Us1HMen0nhQRNoGdpWJ+cM3NU7mDSNWWlT3U5bhsker0N67OYFbCWOvo3brvthrJ8+yh9Kd4/3xDtN14sbvrTEpvteNMYmLL+zYDz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706116975; c=relaxed/simple;
	bh=9AhbXjP3WJb3NmDSPt6dchdTikHMYk3kw90IuA4Hlrw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=n5yEDZ7i8BpU0q0isjkZ4qjf0mEVnhNjGqBvH15Rz4DsVWhlSReiRucXKox8jXcLPP+ATIAEwLizI8OmeuOvdDg12If8GOT4Gpru3IRkXZdtUcdIVq9SYgXkPE/VNya9Ccn8L7r4ZhSJhVOotI5jdcM2h5GQdCu/B4RwTcwKw8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZxtFBoYR; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZxtFBoYR"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id D12AF23D5B;
	Wed, 24 Jan 2024 12:22:53 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=9AhbXjP3WJb3NmDSPt6dchdTikHMYk3kw90IuA
	4Hlrw=; b=ZxtFBoYRsgh+2+/ExqTEe+jCCsozX2O3k1AaVl37NzHfeV2nxWPFR6
	1KaJaDG0NOckq42JD8FichBOeVG4d66v4WaWgCefdHrcrv/zIkoCoVSGxbbGqZpF
	UIwr2DIhBEcS4A+FpSP+c2cSIjv9cGmLlvICccIhZJ6UsZIEwjMoI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id C965923D5A;
	Wed, 24 Jan 2024 12:22:53 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 510CA23D57;
	Wed, 24 Jan 2024 12:22:50 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: John Cai via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  John Cai <johncai86@gmail.com>
Subject: Re: [PATCH] reftable: honor core.fsync
In-Reply-To: <ZbDNVouHgr-J2ptC@tanuki> (Patrick Steinhardt's message of "Wed,
	24 Jan 2024 09:41:58 +0100")
References: <pull.1654.git.git.1706035870956.gitgitgadget@gmail.com>
	<xmqq34unn8x4.fsf@gitster.g> <xmqqsf2nlnxv.fsf@gitster.g>
	<ZbDNVouHgr-J2ptC@tanuki>
Date: Wed, 24 Jan 2024 09:22:48 -0800
Message-ID: <xmqq4jf2hcif.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 3322356A-BADD-11EE-9A4F-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

>> The part about using NULL as the value to say "do not use any flusher"
>> still stands, though.  You do not have to expose noop_flush into the
>> global namespace that way.
>
> One benefit of explicitly using the `noop_flush()` function is that we
> make sure that all callsites that should provide a proper flushing
> function indeed do. A `noop_flush` in production code may raise some
> eyebrows, whereas a `NULL` value could easily be overlooked.

Very true.  Another benefit is that at runtime we do not need any
conditional deep inside the logic that calls the .flush method of
the writer object.
