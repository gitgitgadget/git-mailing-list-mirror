Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E0D1429A
	for <git@vger.kernel.org>; Tue, 20 Aug 2024 15:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724169496; cv=none; b=cWzKYQouWbbp2uEO9HEIj8O03WVOYQocOURICOYvl91bPi8JczEUFvM/QJXC+Iz2xMzNcXgZ1uFcEkNYvns7xzjN8WVisXW5rd5LwcwAKiCESiFVyQEr8+cD8cToEQfFFbzjCJd2yowmI6Npddhe+IwXYDDjPXAy99DJxnFqaF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724169496; c=relaxed/simple;
	bh=akD2Fr+sqDEgDVWNqAKxZO49y6x8+0nt9PCUzxsP02U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=t0RGy5OwydpzdltuMvAu16Ss721D8YiYRrdPcgvWkrwfWJsj4x4KMBxuTsTdJFawPw7GEJZezifCQXWKsys6Yy1Jw39/3MSxMlvQyoW1bOH10Kx3VJyIIyQ9Y0WS8AONq1x+UbrnSt5J6919U5ZA029JVqKZnzfkTwQDbguJIXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=NXrmpJo8; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="NXrmpJo8"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 632B5245C2;
	Tue, 20 Aug 2024 11:58:14 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=akD2Fr+sqDEgDVWNqAKxZO49y6x8+0nt9PCUzx
	sP02U=; b=NXrmpJo8ZQ3jxBaXZa4Uy1fgWnRL3KNenrnOTOakcqv7MQeQ5ORDd0
	AG9rRyBWsSyTs7NhxvCn3/fF3rurHZupNEXXduRmTi7q0VFlR1TK+eSzrGpdvucB
	ElDfZTgTL7h9pu7ovvpnDOJHUSuIOFyAPDVp/rftSOQkuDEBh1mTc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 5C1CF245C1;
	Tue, 20 Aug 2024 11:58:14 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E2A90245C0;
	Tue, 20 Aug 2024 11:58:10 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Jeff King <peff@peff.net>,  git@vger.kernel.org,  Phillip Wood
 <phillip.wood123@gmail.com>,  phillip.wood@dunelm.org.uk,  James Liu
 <james@jamesliu.io>,  Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 3/3] builtin/maintenance: fix loose objects task
 emitting pack hash
In-Reply-To: <ZsRIHS0mFZaRHFVc@tanuki> (Patrick Steinhardt's message of "Tue,
	20 Aug 2024 09:39:09 +0200")
References: <ZsLjcjhgI8Wk2tIV@tanuki> <cover.1724053639.git.ps@pks.im>
	<c25b5333f60a5920c1fade06532e3379c6686908.1724053639.git.ps@pks.im>
	<20240819085522.GD2955268@coredump.intra.peff.net>
	<ZsMLZ3Tlhxsg6Qdr@tanuki>
	<20240819091715.GB2958552@coredump.intra.peff.net>
	<ZsMPqEWVOSLOi39o@tanuki>
	<20240819102602.GA2961332@coredump.intra.peff.net>
	<ZsRIHS0mFZaRHFVc@tanuki>
Date: Tue, 20 Aug 2024 08:58:09 -0700
Message-ID: <xmqqle0rb2zy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 FFE81BF4-5F0C-11EF-B277-E92ED1CD468F-77302942!pb-smtp21.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> I certainly appreciate the discussion, thanks for chiming in! I'm still
> not convinced that we should continue to couple auto-maintenance and
> backgrounding to each other. In my opinion, this behaviour was a mistake
> in the past and continues to surprise now, too. Making it an explicit
> option feels more natural to me.
>
> That being said, when others feel strongly about this, as well, then I'm
> of course happy to adapt.

FWIW, I find it is a sensible approach to have a separate "run in
the background" that is not strongly tied to "do your thing if you
think the repository really needs it".

Thanks.

