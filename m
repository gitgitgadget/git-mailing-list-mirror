Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833E41C01
	for <git@vger.kernel.org>; Sun,  8 Sep 2024 21:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725832464; cv=none; b=dldKxeBvRLXEei9JO4b2/mhl8ggfgbChAjF1S6WQvC4q5VFbk6CaBeDn4K1cgUevW752/ch/dTPnWhcjqQTerR/kvAhk0AgNZhnxVDn9Ma/WEQV7spq2fknHxqmytdMHYfzsQpHzRc8KkzQn1BYWEkO2vCYpMXcrEIakIFPglZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725832464; c=relaxed/simple;
	bh=y6FZ5PHROsXg3OvnkbXvUwkhnAnm2FPPdSIfLUiQYTk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZWPoIqPq9DSfaSBOansucJJ5qgCKp6ARNqaUqunNyMwsLbS3WToo4FW1uXhFycNHY1Jg+V0TM+rf+uY6Wi2iKddZ9DUxWrsaQ26niV/Xp1PbbhknMJ1t28iQLphxbYGwzH51QEsG0NvsCCl+ayHD2PUnffaMf6myTeuJk2u9t1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=BxRBAcu+; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="BxRBAcu+"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 902A832689;
	Sun,  8 Sep 2024 17:54:22 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=y6FZ5PHROsXg3OvnkbXvUwkhnAnm2FPPdSIfLU
	iQYTk=; b=BxRBAcu+Px/ajJ2mxkBadRknzqaYadiNrStgf8IOVr1nrCERX+QykW
	lcsFIKOdhO9NbyXBHUgMWni3Ym/rt/IjraIxjv3z6uRdpmGsEa2HDcMxBzvBod/8
	LgSYnSGVlXgntkQ1h2iNO27hm1RTiElhOjEo0s1R2cTyldGIErkAk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 87CC132686;
	Sun,  8 Sep 2024 17:54:22 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F38D032685;
	Sun,  8 Sep 2024 17:54:21 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  Phillip Wood via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org,  Brian Lyles
 <brianmlyles@gmail.com>,  Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH] rebase: apply and cleanup autostash when rebase fails
 to start
In-Reply-To: <0ca8ce79-6c9f-4836-99d6-b2a86dfe4109@gmail.com> (Phillip Wood's
	message of "Thu, 15 Aug 2024 10:47:59 +0100")
References: <pull.1772.git.1723641747309.gitgitgadget@gmail.com>
	<ZrzA0yp45w9NuTp2@tanuki>
	<b676bd17-1cc8-4639-acb7-675dde32a1ae@gmail.com>
	<xmqq8qwzypz2.fsf@gitster.g>
	<0ca8ce79-6c9f-4836-99d6-b2a86dfe4109@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Sun, 08 Sep 2024 14:54:20 -0700
Message-ID: <xmqqv7z5vmk3.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 E7E83190-6E2C-11EF-9055-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

Phillip Wood <phillip.wood123@gmail.com> writes:

> ... This code is just doing what we do at
> the end of a successful rebase so I'm don't really understand what the
> issue is. Looking at finish_rebase() we don't even check the return
> value of apply_autostash() when applying the stash at the end of a
> successful rebase.

At that point we give control back the user, so if things are left
in conflicted or any other "unexpected" funny state, the user kill
keep the both halves.  As long as the user clearly understands why
the working tree is in such a funny state, we should be OK (and I
would imagine that we are giving messages like "applying preexisting
changes stashed away before rebasing" or something).

Thanks.


