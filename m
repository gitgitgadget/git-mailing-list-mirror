Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16668184132
	for <git@vger.kernel.org>; Thu, 18 Apr 2024 19:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713469002; cv=none; b=QLPdo0Pmd/qviGcp1wZs/1duamODkjcUZ3Hww7XRN4aabk5zfrACeTS8cyYgTmhCZK36ek62ekrQUS8VwANaNGltBhjz76sbflLklbu1dVw8FTBcQmMHdG3y1abEIYCKzfgaMLHskghM46lQ+6yrU5z+X521esO7Lit1L0A931w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713469002; c=relaxed/simple;
	bh=IYtvmpdlTNyC8c8CdJFNNelq+3UJ4DK7gV4CHJy+CFI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HJ8j3RWv9/Cs72y1DyzLyiWbqrmPPMwNOsvKEb9G9pfaRMpmjrQlAXM1qaJBBidXZNIEZZmhoJwE44yHxR/rfHcQrqlU4HDJPPQBEJ8YsszVgxYXnBrDOBI8ylSXrpVfAAKE+CQSnJatT/XqK//UYn8T51Ec+vpyNrre5wFYVUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=AOjqUTu2; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="AOjqUTu2"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 693611E6DC7;
	Thu, 18 Apr 2024 15:36:34 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=IYtvmpdlTNyC8c8CdJFNNelq+3UJ4DK7gV4CHJ
	y+CFI=; b=AOjqUTu2hiq4DPe0uM9sSr/3kQkLCK7rYd4f1O1bKILzWuvt7tYVQS
	H3Sa7k79vbzMTYGxgaKKHbpDVWog2YAq6hvN9WImD0G1k1UBnLEy4gBU5FDaCiS7
	fTy+HOww36AeaOFhBeCY+F+KHSi5Zl65G3xio5HDlOdo/xKxksjYY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 602D21E6DC6;
	Thu, 18 Apr 2024 15:36:34 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BFF0B1E6DC4;
	Thu, 18 Apr 2024 15:36:33 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Karthik Nayak <karthik.188@gmail.com>,  Phillip
 Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 0/6] global: drop `the_index` variable
In-Reply-To: <cover.1713442061.git.ps@pks.im> (Patrick Steinhardt's message of
	"Thu, 18 Apr 2024 14:14:04 +0200")
References: <cover.1713180749.git.ps@pks.im> <cover.1713442061.git.ps@pks.im>
Date: Thu, 18 Apr 2024 12:36:32 -0700
Message-ID: <xmqq34ritqdb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 F6993D8E-FDBA-11EE-9816-25B3960A682E-77302942!pb-smtp2.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> this is the second version of my patch series that aims to drop
> `the_index`.
>
> Changes compared to v1:
>
>   - This version goes a bit further now and completely drops the
>     static `the_index` variable, as well. The repository's index gets
>     allocated dynamically now, like all the other sub-structures like
>     the ODB.
>
>   - This also allows this series to remove `initialize_the_repository()`
>     now. Instead, callers call `initialize_repository()` now.
>
> There is still quite an ugly hack in `initialize_repository()` which
> requires us to treat `the_repository` specially. This is because
> `the_hash_algo` maps to `the_repository->hash_algo`, and we rely on it
> being initialized to SHA1. So we need call `repo_set_hash_algo()` on
> `the_repository`. On the other hand, we cannot set the hash algo on
> repos which are not `the_repository`, because that breaks stuff, as
> well.
>
> I'm currently prepping another patch series that builds on top of this
> series and cleans up this mess. It surfaces several bugs that got masked
> by our setup, like for example `git rev-parse --short=` not working
> correctly with SHA256 because we always truncate to the maximum length
> of SHA1.

I'll take a look, and may even comment on them later, but let me
otherwise place this series on the back burner, not because I am in
love with the_index (I am not) and not because I think the "index"
member in the repository struct is a mistake (I suspect it is, but I
am not convinced either way), but because I'd prefer to see our tree
to be quiescent when we apply a tree-wide patch like [2/6], but
we'll be in -rc period soonish, during which time we'd want to be
able to concentrate on fixing regressions without having to worry
about being able to reapply such tree-wide changes to keep 'next'
and 'seen' building.

Thanks.
