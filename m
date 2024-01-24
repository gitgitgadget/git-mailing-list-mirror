Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1344686144
	for <git@vger.kernel.org>; Wed, 24 Jan 2024 17:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706117689; cv=none; b=Kwj+ZuIsdpPZr8Lj2BuLsvAcbsEWTk7eDUdWnR00d9jvIntQrsC7L11odXRWRzilHIoT3jELeFlaYaufUcThOWTs6vpR8xZIkSS/3tXi/mPVUCqP27JSP2/ZAuLHa3XNhI2lckRUlUYD6ankJnbkDoT/blilWbvwg96ID8hF+SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706117689; c=relaxed/simple;
	bh=ntj7OdkRh1/sIsqjdHUo6wMBmNaU4fIAgMFgmciyVcA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=V4oj2rRH95NJLShMs8rjJAi4lZ0UAaCQ+3LRFb5cZDcrrmTvyWUVLgvA5UZCAsBV05AgzL/EhFNXTDktgRGFztfViGkLetWNQ92pPtf49FNYDqM2h/WKa+HQDptPW1LNjgnA3kd/sgP77ACL54QLFL9GNuJXMc6iX5Tv+lzRNio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=El1I8sNN; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="El1I8sNN"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C5D4D1D9FB6;
	Wed, 24 Jan 2024 12:34:46 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=ntj7OdkRh1/sIsqjdHUo6wMBmNaU4fIAgMFgmc
	iyVcA=; b=El1I8sNNZVt/qwH7b+KBxDZrfHr3euVJ6txMJvHIWYa/OUsxgaf6o0
	3eSD7z8S/h3OlsRj7awKIoifgFGpmkHGXXVKvemUBhyJ0K9Nz8QPIr9jpxeny3qE
	vSqzcBCRHl0SHPbauZMMj1+mvuEaE+hHzJjdP34kGJnng3tvtVLYs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id BB6721D9FB5;
	Wed, 24 Jan 2024 12:34:46 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 234981D9FB4;
	Wed, 24 Jan 2024 12:34:46 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>
Cc: Michael Lohmann <mi.al.lohmann@gmail.com>,  git@vger.kernel.org,
  phillip.wood123@gmail.com,  Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v3 2/2] revision: Implement `git log --merge` also for
 rebase/cherry_pick/revert
In-Reply-To: <CABPp-BE4zqRX=wd5EBj96hzCS8V73QpdN-2pCpv7qMdkpkX93w@mail.gmail.com>
	(Elijah Newren's message of "Tue, 23 Jan 2024 23:06:08 -0800")
References: <xmqqzfxa9usx.fsf@gitster.g>
	<20240117081405.14012-1-mi.al.lohmann@gmail.com>
	<20240117081405.14012-2-mi.al.lohmann@gmail.com>
	<CABPp-BE4zqRX=wd5EBj96hzCS8V73QpdN-2pCpv7qMdkpkX93w@mail.gmail.com>
Date: Wed, 24 Jan 2024 09:34:45 -0800
Message-ID: <xmqqr0i6fxe2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 DDCAE7B8-BADE-11EE-972B-25B3960A682E-77302942!pb-smtp2.pobox.com

Elijah Newren <newren@gmail.com> writes:

> I had to go look up previous versions to see the discussion of why
> this was useful for things other than merge.  I agree with Phillip
> from https://lore.kernel.org/git/648774b5-5208-42d3-95c7-e0cba4d6a159@gmail.com/,
> that the commit message _needs_ to explain this, likely using some of
> Junio's explanation.

Please note that I am not very happy with that "explanation" myself.
The only thing I can still agree to in that message myself is that
it is sensible for "log --merge" to go down all the way to the root
of the histories leading to MERGE_HEAD and HEAD in the "merging two
unrelated histories" scenario.  Treating CHERRY_PICK_HEAD and others
the same way, to me, almost sounds as if we are saying "all the
commits behind the commits involved in the conflicted operation are
worth looking at", which is not a very useful or productive thing.

> Also, what about cases where users do a cherry-pick in the middle of a
> rebase, so that both REBASE_HEAD and CHERRY_PICK_HEAD exist?  What
> then?

;-)
