Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9FC154BE9
	for <git@vger.kernel.org>; Wed,  3 Apr 2024 18:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712170721; cv=none; b=a0gG8/5XNI2Rtq9Uu07TWxhI1MYNDza+7azY9GQ2LTAFJuhcJ3loKuZF2MFQ9ZbjuJSKzeRP8uW6OyGTe/aI/Izcjj1UkES7qYf87AJ4Xq4eHcjRl9Q+Tsjrsy4cocZy9uBtv63OCPwwpI1/FeAfR9HWHwTtF8rdjaLlTxCbec8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712170721; c=relaxed/simple;
	bh=UPfzMq7Wsg8AHSS38N3KsJdMFhuf3OfobUUSJ5NZjL4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RYI+DQMhsLZN6bRh1OhesglF9tRSI0jnB0j0HvaftjtRsEETBoKxqomlOaydNyBR9rwYOUNE8dq2E+3/AHs2E1Qb02/tJLfdq6LKRoaN4FCMddqidE4/fIMzRhT7U7Is/q70H6FjupXkRL/eNfhKYv28arJWNhTWjq8QoiIcniI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=vGH/1BYD; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="vGH/1BYD"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BDB0D1DC563;
	Wed,  3 Apr 2024 14:58:38 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=UPfzMq7Wsg8AHSS38N3KsJdMFhuf3OfobUUSJ5
	NZjL4=; b=vGH/1BYDP3Uldq5PEIKJw19AsDg6R0edAHXvDqRUFcn4Yb6RCPkd3r
	PprtGxSPRZ+0svPFUd+Pf702liND10uCjyuN8DJBJZZoEJ8juKGJI27wEcd3fQbU
	sQQinoLeES9EhOEDZjkyy7gdTAMtGW5aY5TdkKm/SIgzTgmqWmhfY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B5FEA1DC562;
	Wed,  3 Apr 2024 14:58:38 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 21A181DC55C;
	Wed,  3 Apr 2024 14:58:38 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 4/9] refs/reftable: don't recompute committer ident
In-Reply-To: <a9a6795c025b23035bfdd3e23b0113df9f6c5e4b.1712078736.git.ps@pks.im>
	(Patrick Steinhardt's message of "Tue, 2 Apr 2024 19:30:04 +0200")
References: <cover.1712078736.git.ps@pks.im>
	<a9a6795c025b23035bfdd3e23b0113df9f6c5e4b.1712078736.git.ps@pks.im>
Date: Wed, 03 Apr 2024 11:58:36 -0700
Message-ID: <xmqqedbm6zoj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 2E02482C-F1EC-11EE-BE36-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> In order to write reflog entries we need to compute the committer's
> identity as it becomes encoded in the log record itself. In the reftable
> backend, computing the identity is repeated for every single reflog
> entry which we are about to write in a transaction. Needless to say,
> this can be quite a waste of effort when writing many refs with reflog
> entries in a single transaction.

It would have been nice to mention which caller benefits from this
rewrite in the above.

There are four callers of the fill_reftable_log_record() function.
The patch moves the split_ident() call from the callee to these four
callers.  The write_transaction_table() function calls it in a loop,
which should give us a big boost.  For other three callers, they
call it at most twice (i.e. write_copy_table() when deleting the old
one), so their contribution to the boost should be minimal.

Makes sense.

