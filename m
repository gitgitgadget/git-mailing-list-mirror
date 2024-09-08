Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1BF1C01
	for <git@vger.kernel.org>; Sun,  8 Sep 2024 21:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725832446; cv=none; b=rVMVxOqdWL5byQY6yE926C1MvvtVSjZoON3r8L2/r1XLs9unYOoLDfXdmJEJ0Z+qyI4UHsg1mkvXIlRr3OqBPh/5vLTwpGjE8LXWKKG01JGSGPhX/0iz4ULo8CVj3rDqqdSRv95Tft8spnPvzobNwdDvdXoFFCr+JyLURtdto2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725832446; c=relaxed/simple;
	bh=y6FZ5PHROsXg3OvnkbXvUwkhnAnm2FPPdSIfLUiQYTk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=glEQsGuwAAoMOkCuziO3tfQ12SywQk5ZCEeLLYxVWNCwVqM1fNOmwv9AV6otLqnc44O/EWeVsoeLXVWVNhyPmX2bqDVEHxhqTQ59ob0Dc4YEUISd6d8Oay7gG1GjmN5Q4pTdw/tpUzhXXYraYomjnp1LM5IIPd6HXfiY7CJ7nAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=bptd7qja; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="bptd7qja"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1D2D832681;
	Sun,  8 Sep 2024 17:54:04 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=y6FZ5PHROsXg3OvnkbXvUwkhnAnm2FPPdSIfLU
	iQYTk=; b=bptd7qjaub/juVlBXfU82QiprsCMScBmjH1UMahh4NA18/Ydb3w8Rb
	Hcj6RFbKhxPBaZYcB6Zq2yrZCBr9Xr61IybdOwc5wMPhkR39WC8E/waZXwRHPwjV
	rXjsY07zXW04jSWUb5eaNr1y1eZTqSruJ3K+/haghJ7RMWV8zE3cs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 14E013267D;
	Sun,  8 Sep 2024 17:54:04 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6B26732678;
	Sun,  8 Sep 2024 17:54:03 -0400 (EDT)
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
Date: Sun, 08 Sep 2024 14:54:02 -0700
Message-ID: <xmqqwmjlvmkl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 DCD8A9F6-6E2C-11EF-99B1-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

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


