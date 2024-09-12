Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6130019048C
	for <git@vger.kernel.org>; Thu, 12 Sep 2024 20:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726173652; cv=none; b=H5P2Q6XUUDRW6ZiA/N+678GLXcVME/fy6urB6i6lTUI3aW0Hhdm7rECYlqooNEkFInIOFoRoFvm0i/3utG67O/WN8+JzZdAR7PasY/rGK+ysN/kA/ttserEp63sE7CjreGMON4KCj0EXtxoLK59l64aybEvtn0ygWmecPdmRvmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726173652; c=relaxed/simple;
	bh=QOnLHlxQPQ5MOYW3aDIaBwDt7zX0IynRnGQtiBnI2IE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PP4lwbnYk3d3neTXz7baJusLCveZza4LtMplIM5Fy1yDbQCKup08/IWHqj7xiyt+ZxAl/C+JvHW4MiRK6DhD477DAFqQ3lkj75cs7suptelkd3DcwWeXW/vlheLeE6Pv3TBm4vHPYBqgSHDs04d+zYoSuqwoENPK4XXJUVdnt3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=UZkAAdQG; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="UZkAAdQG"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 2CB3737586;
	Thu, 12 Sep 2024 16:40:49 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=QOnLHlxQPQ5MOYW3aDIaBwDt7zX0IynRnGQtiB
	nI2IE=; b=UZkAAdQGz3v7Yx+HK1IDfZKe4jq2B6w2OpltSofoCu46spHKJ5B+yg
	769ritiqD+kpZ/h3UPORbIyxHFAUnPEExWFE6R4C2ffYq9msZGoelmT2oZ60w/uj
	hVQpIGXPtdhXomkjXKTM7qghugoNz87EHJkjNqFYUb2fB9Qp2Jbm8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 24BD937585;
	Thu, 12 Sep 2024 16:40:49 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 849F637584;
	Thu, 12 Sep 2024 16:40:48 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Calvin Wan <calvinwan@google.com>,  Justin Tobler
 <jltobler@gmail.com>,  karthik nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v3 00/21] environment: guard reliance on `the_repository`
In-Reply-To: <cover.1726139990.git.ps@pks.im> (Patrick Steinhardt's message of
	"Thu, 12 Sep 2024 13:29:21 +0200")
References: <cover.1724923648.git.ps@pks.im> <cover.1726139990.git.ps@pks.im>
Date: Thu, 12 Sep 2024 13:40:47 -0700
Message-ID: <xmqqseu438s0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 4AEF6AD4-7147-11EF-97E1-9B0F950A682E-77302942!pb-smtp2.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> this is the third version of my patch series which guards functions and
> variables in the environment subsystem that rely on `the_repository`
> with the `USE_THE_REPOSITORY_VARIABLE` define.
>
> Changes compared to v2:
>
>   - Adapt BUG messages in the first 5 commits to better match the new
>     semantics of this function.
>
>   - Adapt commit message to mention that we don't only move over
>     `odb_mkstemp()`, but also `odb_pack_keep()`.
>
>   - Explain why setting REF_FORCE_CREATE_REFLOG is equivalent to setting
>     LOG_REFS_NORMAL.

Looking good.  Let me mark the topic for 'next' soonish.

Thanks, all.
