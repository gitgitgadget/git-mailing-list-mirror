Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7E317BB2F
	for <git@vger.kernel.org>; Tue, 14 May 2024 15:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715702150; cv=none; b=PAhaHYmzSqPqMobZ1ahpmyKQHz9RqIr0+2zQnkGAudtucfvZCQQjqMsxbdXoo8nVjL7W8sbZZtvefz94YXMqa1Kwt596Pz/EABuQIpDiD1NVwrle8H9b+uoOl+gab1nlhyhhoyWUEj+ayLGCiYNdAZrBaKUB/fPtD0Zad4Ff11o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715702150; c=relaxed/simple;
	bh=zES7uBjwEuTGn/h7l87wbzOnVdTda8MWg0BSsCqBtyY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Gg1VGmO3723O97u1YM6tqnPkqv6/QXJ3Z945zrglAXcB7wT2gs2WNnnjzDIh5j3pqo7bFva7jPAzBqKt0L6R2/P1bKohiL5Spdl5Pt5XGlF0v75XQ9KzmmU5DeVpxkpYhftxil6/521K4y8mQanYSc3P0qPZfjBvBONYhb+SqVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=xx82h7hw; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="xx82h7hw"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 8D41E2F00F;
	Tue, 14 May 2024 11:55:47 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=zES7uBjwEuTGn/h7l87wbzOnVdTda8MWg0BSsC
	qBtyY=; b=xx82h7hwVb0yblopUy+SU6fXXOT8tlm96RsTvhg80gfqTi6rDwVmBb
	spivji1zXIXj0LKVJFeATe9fWQsi1NXfnrxh8v/djAsr7Wmj5UUEx6oqFQOxRLQr
	2z3CS/3cnCc8lK2n77dW64OeFe99ThzFmRd4Uu+HdSehgQ9BL6QiQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 84BC72F00E;
	Tue, 14 May 2024 11:55:47 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A9CFF2F00D;
	Tue, 14 May 2024 11:55:46 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v3 4/5] builtin/hash-object: fix uninitialized hash
 function
In-Reply-To: <ZkLpVSVv1XPz-D8v@tanuki> (Patrick Steinhardt's message of "Tue,
	14 May 2024 06:32:21 +0200")
References: <cover.1715582857.git.ps@pks.im>
	<20240513224127.2042052-1-gitster@pobox.com>
	<20240513224127.2042052-5-gitster@pobox.com>
	<xmqq7cfxcnlc.fsf@gitster.g> <ZkLpVSVv1XPz-D8v@tanuki>
Date: Tue, 14 May 2024 08:55:45 -0700
Message-ID: <xmqq8r0c5qwu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 6D74B70E-120A-11EF-A320-25B3960A682E-77302942!pb-smtp2.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> I'd prefer the latter -- always use SHA-1. As you say, it's easier to
> understand and doesn't create implicit mechanisms that we'll have to
> maintain going forward. Also, users didn't have a desire yet to pick a
> different algorithm than SHA-1, which probably also comes from the fact
> that SHA-256 repositories are still scarce.
> ...
> Eventually, we should then add a new option `--object-hash=` to
> git-hash-object(1) and other commands that may run outside of a Git
> repository to let the user pick their desired hash.

If we were planning to allow using something other than SHA-1 in the
future, then I do not think I agree with your argument.  We can use
the same GIT_DEFAULT_HASH mechanism to specify what hash to use without
later adding an extra option just fine.

