Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B0B146A84
	for <git@vger.kernel.org>; Wed, 22 May 2024 21:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716415103; cv=none; b=j253SH0XSfYLXIvqFaycWJbnU9TcG56ljUxIwjUgAhTp/eGMVvhq8kyD9X7hq+vfJIH40L20PrjxtfTF6UjaLeNQtu4LnSCbJrREHnACBCvVrQSlz1q+XHRpYy7uTHVtQ/UFcbC9EubJdO4SzTAFZAEJFgqy6TrKPD/zF5XrHEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716415103; c=relaxed/simple;
	bh=OIyXNSxXNXgdWv6dG2HdMus0oB0wHMPw+MWWYrPXeiM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OmOU8uy2rB1PmdzYPsyTY/jwutxbNPgxKepIKVqFGzBzfQ5YDi1cHjxk5AW92aU6/HKz57ikiCzePBkxKopL/XYZA54LGwu52VUSgqxfsk2dgE/IfexOgVCMfAt6cxC+zNTSo1BS+Wb6sBymJ5f9NBWWWctr+mLAW70VcZsHzng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=hKeuKfaV; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="hKeuKfaV"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 6446E2B766;
	Wed, 22 May 2024 17:58:21 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=OIyXNSxXNXgdWv6dG2HdMus0oB0wHMPw+MWWYr
	PXeiM=; b=hKeuKfaVgZmfwg6M4dxY5y5PM+eXuGEmdkIcWQdawLBoLYgDC2HmSb
	iwau3OIRnvO2mHJXcla4uzLEcwRmVzf8/byhexX4EG8KKre3nVNvgilD6/xyDSa9
	QG0WAKHuRFeAlzA65DuWi8e7Stu9FD7G27anfZ7ZWirfraaP6KjOw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 5C23B2B765;
	Wed, 22 May 2024 17:58:21 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AD3B62B763;
	Wed, 22 May 2024 17:58:20 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Tom Hughes <tom@compton.nu>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2] push: don't fetch commit object when checking existence
In-Reply-To: <8f2ebf1b-050f-476a-92d4-dfb06ad04f8d@compton.nu> (Tom Hughes's
	message of "Wed, 22 May 2024 22:46:16 +0100")
References: <xmqq8r014pyn.fsf@gitster.g>
	<20240522201559.1677959-1-tom@compton.nu> <xmqqed9t36sn.fsf@gitster.g>
	<8f2ebf1b-050f-476a-92d4-dfb06ad04f8d@compton.nu>
Date: Wed, 22 May 2024 14:58:19 -0700
Message-ID: <xmqqbk4x1pc4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 672A1D94-1886-11EF-BBB8-25B3960A682E-77302942!pb-smtp2.pobox.com

Tom Hughes <tom@compton.nu> writes:

>>> +	test_must_fail git -C client push 2>err &&
>> We try to overwrite it.  We expect it to fail with "not a fast
>> forward".
>
> Well that is what it would fail with at the moment, but it's not
> what would happen with a non-partial clone - a non-partial clone
> would fail with "fetch first" instead.

Oh, don't get me wrong.  I wasn't trying to split hairs between the
two error modes and their phrasing.  The "fetch-first" from
set_ref_status_for_push() is done before we even initiate the
transfer to stop the operation, with a cheap check, that will
eventually lead to "not a fast forward" error.  IOW, in my mind,
they are the same errors, just diagnosed at two different places in
the code and their messages phrased differently.

> So here we are testing that it's a "fetch first" and rather
> than "not a fast forward".

I think that is being overly specific, but that is fine.  As I said,
to the end users, these two errors mean the same thing (they would
need to fetch first and then integrate their changes before pushing
it out again), so it is plausible that we may in the future decide
that we want to use the same message.  When it happens, this test
must change, which may even be a good thing (it makes it clear what
the fallout from such a change looks like).

>>> +	git -C client rev-list --objects --missing=print "$COMMIT" >objects &&
>>> +	grep "^[?]$COMMIT" objects
>>> +'
>> OK.
>
> and also that it hasn't fetched the new commit.

Yes, and this is a good check that will stand the test of time, even
across a change to rephrase the error message.

Thanks.

