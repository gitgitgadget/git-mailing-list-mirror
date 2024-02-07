Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C250535C9
	for <git@vger.kernel.org>; Wed,  7 Feb 2024 22:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707344345; cv=none; b=qgg5451iQRNJn+uNfDZSEYwMOP6/mEVV0JbaEzwVS454FCFAfq1Mt499zIZRJe+5nYvdwUdvxKtLTgmUEDBBMLWtP/GooFN9ekHfprMEKBsUDYwVgVqtxQvB81Sqk0SZJMLWG9Mr50bbfDTWKYDuo7NgTiZ+0f86W7aH14CrO6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707344345; c=relaxed/simple;
	bh=lGP3h/Nf7MVpSjhEBF4BQjB3SnGU4bIhRigm1xqiov0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rdZUfLPysRKSEwp/mFnQQpK7fB/seoCFTqQXJ27CG8CTSdAe0Al7c3HDDEzsrGnl2IJvs6bKt4SPX9TLyNp1wwXpQKPwdtA2N7C1JHGPySbjTH7MHxdfR1qO+KvG52Q/SyPhvwLbLrIuFFEkZlsiarNYeaXHzbLmYd+pS4mEIFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=fPR5Afdu; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="fPR5Afdu"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id B95E02C257;
	Wed,  7 Feb 2024 17:19:03 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=lGP3h/Nf7MVpSjhEBF4BQjB3SnGU4bIhRigm1x
	qiov0=; b=fPR5Afdu2FX62O4U17AcAhKwxyUZJ1/Hagj9W97NQ4buc66wAsRk1/
	29EU6MzUj6I/PFi3pPc2hwyo/7ZEcucyR7/oxC/c6AQ+C81p7qDt2G2DkB2mhqP7
	vGQ57OYyaIpcIjD7ZxsiQFQxjWEdJTR7HFyrMXpqDWXBmRzoWKW30=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 9FD312C255;
	Wed,  7 Feb 2024 17:19:03 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 556D42C24B;
	Wed,  7 Feb 2024 17:19:00 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: <git@vger.kernel.org>
Cc: "Eric W. Biederman" <ebiederm@gmail.com>,  "brian m. carlson"
 <sandals@crustytoothpaste.net>,  Eric Sunshine <sunshine@sunshineco.com>,
  "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH v2 00/30] initial support for multiple hash functions
In-Reply-To: <878r8l929e.fsf@gmail.froward.int.ebiederm.org> (Eric
	W. Biederman's message of "Sun, 01 Oct 2023 21:39:09 -0500")
References: <87jzsbjt0a.fsf@gmail.froward.int.ebiederm.org>
	<878r8l929e.fsf@gmail.froward.int.ebiederm.org>
Date: Wed, 07 Feb 2024 14:18:58 -0800
Message-ID: <xmqqv86z5359.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 E4AC4E86-C606-11EE-B1C4-A19503B9AAD1-77302942!pb-smtp21.pobox.com

"Eric W. Biederman" <ebiederm@gmail.com> writes:

> This addresses all of the known test failures from v1 of this set of
> changes.  In particular I have reworked commit_tree_extended which
> was flagged by smatch, -Werror=array-bounds, and the leak detector.
>
> One functional bug was fixed in repo_for_each_abbrev where it was
> mistakenly displaying too many ambiguous oids.
>
> I am posting this so that people review and testing of this patchset
> won't be distracted by the known and fixed issues.

We haven't seen any reviews on this second round, and have had it
outside 'next' for too long.  I am tempted to say that we merge it
to 'next' and see if anybody screams at this point.

Thanks.
