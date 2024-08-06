Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D2313A26F
	for <git@vger.kernel.org>; Tue,  6 Aug 2024 20:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722976704; cv=none; b=l61HNpuAs9cXxXpsadLiZQQ16BXNsb9kRTSkbSehQVKL+ta/SxsJpcTP/AJpbOo9hTNbL1L1sr6PHbex03vZtv9byuL1cJWFkinfgJmYqlQJ8+Key1KgpXDV/RXTZql78hMNYHWNNV48LbuJDN6y2Wg66K6gW3pB+9/Esa/Hi9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722976704; c=relaxed/simple;
	bh=XefXHv7gD+ky3tl7s1pOBjt+ccCBF7s8KB7XYjvctEc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=S6QrbikxaUD8OKFvl2yc2W6+IkOlzgOsH8FjlVenInIB/oIC2e16ybjVGrsu+hWykRwzAG8CwhOQZY6Gaujev/hiQoJY7A4qEUIe8WnfXghTqVICLH+9T6DOuGXYOHsVBEYq580NeRtvG5OxdCwGMU0qQcH3h9suVWOORLrLhg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=CDX20RlB; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="CDX20RlB"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 7FEE624D2A;
	Tue,  6 Aug 2024 16:38:22 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=XefXHv7gD+ky3tl7s1pOBjt+ccCBF7s8KB7XYj
	vctEc=; b=CDX20RlB/QEcMqATMTa+bVURBJcn9GYJ4/DITv3VA1j4H1LOEmMBaQ
	2Rxw7ALrF5dDsjyNUVgKr6q4JdXMebElgJvPJc1bj/03bwdteG8Bp/Bebv6VRQMf
	CDpoK2vQUNeYJGwZu5/WQnincNXHYZVpXu2hn7ZgIPWJMFCNP3CQU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 7828724D29;
	Tue,  6 Aug 2024 16:38:22 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 6A9CC24D28;
	Tue,  6 Aug 2024 16:38:18 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Chandra Pratap <chandrapratap3519@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Christian Couder
 <chriscool@tuxfamily.org>
Subject: Re: [GSoC][PATCH 0/6] t: port reftable/stack_test.c to the unit
 testing framework
In-Reply-To: <20240806142020.4615-1-chandrapratap3519@gmail.com> (Chandra
	Pratap's message of "Tue, 6 Aug 2024 19:43:36 +0530")
References: <20240806142020.4615-1-chandrapratap3519@gmail.com>
Date: Tue, 06 Aug 2024 13:38:16 -0700
Message-ID: <xmqqed71s7yf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 D02DE2EC-5433-11EF-9136-E92ED1CD468F-77302942!pb-smtp21.pobox.com

Chandra Pratap <chandrapratap3519@gmail.com> writes:

> The reftable library comes with self tests, which are exercised
> as part of the usual end-to-end tests and are designed to
> observe the end-user visible effects of Git commands. What it
> exercises, however, is a better match for the unit-testing
> framework, merged at 8bf6fbd0 (Merge branch 'js/doc-unit-tests',
> 2023-12-09), which is designed to observe how low level
> implementation details, at the level of sequences of individual
> function calls, behave.
>
> Hence, port reftable/stack_test.c to the unit testing framework and
> improve upon the ported test. The first patch in the series moves
> the test to the unit testing framework, and the rest of the patches
> improve upon the ported test.

However, reftable/stack_test.c currently is a moving target because
there is an in-flight topic that improves the table compaction and
that topic wants to add more tests there.  So let's wait until the
dust from the other topic settles before doing the first step of
this topic to move the file to t/unit-tests/ hiearchy.

Thanks.

> Mentored-by: Patrick Steinhardt <ps@pks.im>
> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
>
> ---
> CI/PR: https://github.com/gitgitgadget/git/pull/1762
>
> Chandra Pratap(6):
> t: move reftable/stack_test.c to the unit testing framework
> t: harmonize t-reftable-stack.c with coding guidelines
> t-reftable-stack: use Git's tempfile API instead of mkstemp()
> t-reftable-stack: use reftable_ref_record_equal() to compare ref records
> t-reftable-stack: add test for non-default compaction factor
> t-reftable-stack: add test for stack iterators
>
> Makefile                                                 |   2 +-
> reftable/reftable-tests.h                                |   1 -
> t/helper/test-reftable.c                                 |   1 -
> reftable/stack_test.c => t/unit-tests/t-reftable-stack.c | 600 +++++++++++++++++++--------------
> 4 files changed, 355 insertions(+), 249 deletions(-)
