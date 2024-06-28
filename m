Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AEA42139DB
	for <git@vger.kernel.org>; Fri, 28 Jun 2024 05:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719553856; cv=none; b=m89MZHZhD65bH2le5ZS6UDIp4a0AQ0ZGc5bt9W84WW/2VI4INeQk6GrNdrzUoAZPZhoC2jLMhWFH8+n2bYYmLbMjlTPA8sA5jJU1whlFrRmFUwi0M5mTY3/hTWDfKdryaVbmgDXaJFcGfq/MLZiAoKC+ezukfwmzK3yetzK3qFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719553856; c=relaxed/simple;
	bh=CwaCZG7VbXGdhYhuNLD5pVL1P5HV0zmjVhVeOadwxG8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EkV+Z/6bd4pOkhToxstuGFkic9dCPs0DLgyu3ra6f7NgMDy/IkBWpy8iyXaqfisOGQlEb++MSNPBWSV4J59S0wBYxqNJmUknYe8xyeli27fSLYnA4BZekCE0ihlQ8vfZIRkaTBZRwFAZDcyR/s0f+QBoQ4SkeYXc/9fB+WIBTCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=wcQlRUOL; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="wcQlRUOL"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 21BA02FFE3;
	Fri, 28 Jun 2024 01:50:54 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=CwaCZG7VbXGdhYhuNLD5pVL1P5HV0zmjVhVeOa
	dwxG8=; b=wcQlRUOLqQN1O2uY3PG17BUPVK14KWZR4obyZwuJ/mJcRbwaBIh6MJ
	k9wgPAyVQgWIWLqFvykU/93ZL5GD1vggoZvXDCsQeAu6s/Rpo5sXQWkFJ8D7NlcV
	9HjeVc/mwDmV2Oot6+eH08IqczrT66I/+60iWta5GkLtJtyxZowN8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 1A5002FFE2;
	Fri, 28 Jun 2024 01:50:54 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.219.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8BC782FFE1;
	Fri, 28 Jun 2024 01:50:53 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>
Cc: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  anh@canva.com,  Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 1/5] sparse-checkout: refactor skip worktree retry logic
In-Reply-To: <CABPp-BExeTYSpg0d-5F5cdwM8UZzU625A+6uaDhpWgBRjVrd7A@mail.gmail.com>
	(Elijah Newren's message of "Thu, 27 Jun 2024 17:51:00 -0700")
References: <pull.1754.git.1718899877.gitgitgadget@gmail.com>
	<pull.1754.v2.git.1719412192.gitgitgadget@gmail.com>
	<93d0baed0b0f435e5656cef04cf103b5e2e0f41a.1719412192.git.gitgitgadget@gmail.com>
	<xmqq7ceat83v.fsf@gitster.g>
	<CABPp-BExeTYSpg0d-5F5cdwM8UZzU625A+6uaDhpWgBRjVrd7A@mail.gmail.com>
Date: Thu, 27 Jun 2024 22:50:52 -0700
Message-ID: <xmqqpls1r4xv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 61A8A900-3512-11EF-89DE-965B910A682E-77302942!pb-smtp2.pobox.com

Elijah Newren <newren@gmail.com> writes:

>> restarts from the beginning.  I wonder if it would help, especially
>> if the S_ISSPARSEDIR entry comes very late in the index (e.g., by
>
> "the S_ISSPARSEDIR entry"?  Are you assuming there is only one?

No, but I was referring to the first one we encounter in the first
attempt loop that causes us to run the ensure_full() thing.  If the
first SPARSEDIR comes very late, there are many index entries before
that one that are already dealt with in the first attempt loop, and
for these early entries that are already handled, the second attempt
loop will do nothing but just skip.

> expected.  However, if "restart from there" is just passing the
> name of the relevant directory and we do some kind of binary search to
> find where the earliest entry under that directory would exist in the
> expanded index, then that seems like a reasonable additional
> optimization.

Perhaps.  I do not think it is known if it is worth doing, and I do
think it is better to finish this current round and then explore
further optimization opportunities on top after the dust settles.

Thanks.

