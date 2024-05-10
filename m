Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD1613B5AE
	for <git@vger.kernel.org>; Fri, 10 May 2024 22:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715379130; cv=none; b=gdCNdLoBLmynX1wati2zEzav7ZbTG8mq98zl89HovGv3zndo7LmzaQ0Dw0q5+yQ7JqssPUIfSw2lszxBj9Dp1oS06kLsom/Sj6TDFauT5Xz550JaLcyYr0EUyf7SUREqfe9lhgIkVV+8a+NgIVoSN4zrBnu5RzoSBu4P9xjUM6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715379130; c=relaxed/simple;
	bh=1qtPAkslTcmnrLPo5jTzchFg7HQ0i+HbfVaYVTGnjWE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AdCzgMNfFnaVrjXi6jbUNN2LtJctPc1ZwNr/wpolVNajXK3n7smJVRlI9ClJgp3m0eHOrp47Twsp/8g5gXzxL30Rrjc7+AulKArL71btqRRxNjETc5TnTO1ITCyqlPI1Xk9/aPkFUu8ufxnouBjAzpZJIogGqJPLNA2cj58VjfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=fnthUAPa; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="fnthUAPa"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2769E342BF;
	Fri, 10 May 2024 18:12:07 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=1qtPAkslTcmnrLPo5jTzchFg7HQ0i+HbfVaYVT
	GnjWE=; b=fnthUAPapqsBdLg0wsJNGeMvr3+Ow3AxzGycFkxyEc/sur06e/15Ot
	6q1sLqjK4bCkwppu4pLwdnGEhiIrb8p2krWm7loi5jf4RJ1Vyl+mPR45k5DdQhii
	FUA5AjVYbQjga8bC3U3zQZml19L+bpajFdUAaOLPcBO5iBZFgPCsQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EDADF342BE;
	Fri, 10 May 2024 18:12:06 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A6ED4342BB;
	Fri, 10 May 2024 18:12:04 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Karthik Nayak <karthik.188@gmail.com>,  Justin
 Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v2 10/11] reftable: make the compaction factor configurable
In-Reply-To: <9d4c1f034038df2ae232b6665a0d9d7ee5833c5f.1715336798.git.ps@pks.im>
	(Patrick Steinhardt's message of "Fri, 10 May 2024 12:30:05 +0200")
References: <cover.1714630191.git.ps@pks.im> <cover.1715336797.git.ps@pks.im>
	<9d4c1f034038df2ae232b6665a0d9d7ee5833c5f.1715336798.git.ps@pks.im>
Date: Fri, 10 May 2024 15:12:03 -0700
Message-ID: <xmqqy18h1fm4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 5556030A-0F1A-11EF-8C6F-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> When auto-compacting, the reftable library packs references such that
> the sizes of the tables form a geometric sequence. The factor for this
> geometric sequence is hardcoded to 2 right now. We're about to expose
> this as a config option though, so let's expose the factor via write
> options.

Hmph.  It is unclear if having this as uint8_t gives us a useful
enhancement, but perhaps in the future hosters may find a more
aggressive geometric sequence is better for their workload or
something and raise it to 3 or 4?  I was actually wondering if a
base smaller than 2 (e.g. fibonacci) may work better.

Anyway, making it configurable is a good first step.  Allowing a bit
finer grained setting than just integral values can be done later if
it proves necessary.
