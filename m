Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6E210A0C
	for <git@vger.kernel.org>; Wed,  5 Jun 2024 16:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717604530; cv=none; b=Sg+ppaob4i/qINODztCFgUAbF88j0SDGq60zTqrQ5LIR3qovrTm2eMkX12IeDq4NUDovS1MFiNMXo2vD6vWs4XGdg5NwaV1B4euh+dBmf/1ts3f772pszhOwyXNQI4f0wE4mCXM1HPeJBrlqezMaZKi6ey55DI7qwKFnY3EuzlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717604530; c=relaxed/simple;
	bh=EtiAZwcf6jmTRxYL653CA+DiOHvFKcN3uYNO5yAH6Yw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=buUZsM+RduWdhQeJNy8zYFieO991pGCduiu4Wck2sGoqLvbEWC+UjXZss7US7DEOrnqG58A+COEGv5Xx+1QqosQQRSpb48Cx0kQUbrvhg+64q0u5uSe5+QIwkrxd6KoQzrYmmnXA9uwtpdcXJBsUbjiZ45vx+iEYtL7FZHsFRXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Qc1Ggy8T; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Qc1Ggy8T"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B03431E0DF;
	Wed,  5 Jun 2024 12:22:06 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=EtiAZwcf6jmTRxYL653CA+DiOHvFKcN3uYNO5y
	AH6Yw=; b=Qc1Ggy8TqZbiijoRV6Wgb1HuHMwczpzzR8vTMJNexZ+B/jnoGBpSwK
	qDEjp/WB+GJ8vPQb5BnIrtRRV3TPkcPDVlpQxJumqzE/EenQlXU3yN2i0Fh3rbR4
	L4QWBCnS/K0qfUJID1ohx+snq+XG7r3uTfbsoDZV+0FV0w/xu4Wo8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A68201E0DE;
	Wed,  5 Jun 2024 12:22:06 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id F311B1E0DD;
	Wed,  5 Jun 2024 12:22:05 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Karthik Nayak <karthik.188@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH v3 3/6] update-ref: add support for 'symref-delete' command
In-Reply-To: <ZmAbgGfNpZzU76pd@tanuki> (Patrick Steinhardt's message of "Wed,
	5 Jun 2024 10:02:08 +0200")
References: <20240514124411.1037019-1-knayak@gitlab.com>
	<20240530120940.456817-4-knayak@gitlab.com> <ZmAbgGfNpZzU76pd@tanuki>
Date: Wed, 05 Jun 2024 09:22:04 -0700
Message-ID: <xmqqv82nuzpv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 BFE21C76-2357-11EF-AF17-6488940A682E-77302942!pb-smtp2.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

>> +	test_expect_success "stdin $type symref-delete fails with wrong old value" '
>> +		format_command $type "symref-delete refs/heads/symref" "$m" >stdin &&
>> +		test_must_fail git update-ref --stdin $type --no-deref <stdin 2>err &&
>> +		grep "fatal: verifying symref target: ${SQ}refs/heads/symref${SQ}: is at $a but expected refs/heads/main" err &&
>> +		git symbolic-ref refs/heads/symref >expect &&
>> +		echo $a >actual &&
>> +		test_cmp expect actual
>> +	'
>> +
>> +	test_expect_success "stdin $type symref-delete works with right old value" '
>> +		format_command $type "symref-delete refs/heads/symref" "$a" >stdin &&
>> +		git update-ref --stdin $type --no-deref <stdin &&
>> +		test_must_fail git rev-parse --verify -q refs/heads/symref
>> +	'
>> +
>> +	test_expect_success "stdin $type symref-delete works with empty old value" '
>> +		git symbolic-ref refs/heads/symref $a >stdin &&
>> +		format_command $type "symref-delete refs/heads/symref" "" >stdin &&
>> +		git update-ref --stdin $type --no-deref <stdin &&
>> +		test_must_fail git rev-parse --verify -q $b
>> +	'
>> +
>> +	test_expect_success "stdin $type symref-delete succeeds for dangling reference" '
>> +		test_must_fail git symbolic-ref refs/heads/nonexistent &&
>> +		git symbolic-ref refs/heads/symref2 refs/heads/nonexistent &&
>> +		format_command $type "symref-delete refs/heads/symref2" "refs/heads/nonexistent" >stdin &&
>> +		git update-ref --stdin $type --no-deref <stdin &&
>> +		test_must_fail git symbolic-ref -d refs/heads/symref2
>> +	'
>> +
>
> Not sure whether I overlooked it, but one test I missed was when trying
> to delete a non-symbolic-ref.

Hmph, so we want to see an attempt to run symref-delete of
refs/heads/main when refs/heads/main is *not* a symref to fail?
That is a reasonable test to have.

When you invent a shiny new toy, it is hard to make sure you covered
cases where it should not kick in or positively diagnose a failure.
A review with a sharp eye to spot missing tests is very much
appreciated.

THanks.
