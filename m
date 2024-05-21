Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32FC53816
	for <git@vger.kernel.org>; Tue, 21 May 2024 20:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716324051; cv=none; b=TuZ94ArDpJ3nzgEXkwCFezd366Ipc1PlC2uaqcdRZAwoip+3o1rOE7dDOUkzWCH/heyoY33IOcTWnrEv7D1TwhIGOdKYzUeyT+HTk1lVgL9ZthUeHbpT0VzT2i+sfnc1pl0ip2erF3F59Amvu8ZGdFFDMtPAhqI0V8/yi+XooRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716324051; c=relaxed/simple;
	bh=DJM71vt+fEvfw/okqR03ojlCkwpWUlrsA0YqXTGzJRM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ENou5JO44aCIBSFYwkJKqN9nu5m+Od5WjMHHFcKZXgs3H5dMD10hDOwKSL3bXYZcmJGzqNKO0rxnOqUfll6Khew7PXvYz7G5hnE3EPqfcaa6D2N8Wd91oXDAz6izT5o/1qRPPvT1IDXUADg5M+LtA+yZvOzx5bY8f8etf9rLVB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=KSIttIM2; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="KSIttIM2"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 927232265E;
	Tue, 21 May 2024 16:40:48 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=DJM71vt+fEvfw/okqR03ojlCkwpWUlrsA0YqXT
	GzJRM=; b=KSIttIM2y6gzYGcCT+cvre6ccP0gGNIcl3mAcHboNbtIYWV/gWKsCf
	l5w7ECUG0kLVBxUyVOJOZqisiCQgfPM9vFeyZeujb/vix2OW418JMspuizHovMjM
	fs7WRYYEqK0TIPvW/EfcM7t6XfZ84swUV+HIXWAw03HfNOguv9ai0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 88F152265D;
	Tue, 21 May 2024 16:40:48 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E60402265C;
	Tue, 21 May 2024 16:40:47 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Ondrej Pohorelsky <opohorel@redhat.com>,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>,  Konstantin Ryabitsev
 <konstantin@linuxfoundation.org>
Subject: Re: git-daemon doesn't work as expected in v2.45.1 and friends
In-Reply-To: <xmqq5xv7chud.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
	21 May 2024 08:20:10 -0700")
References: <CA+B51BGonS2DDTBQ2RsipW4Cyg5pRv0U71RAN9M1pcPjACtJ4A@mail.gmail.com>
	<20240521-evasive-mindful-stoat-c58b31@meerkat>
	<xmqq5xv7chud.fsf@gitster.g>
Date: Tue, 21 May 2024 13:40:46 -0700
Message-ID: <xmqq7cfmaofl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 677BDA78-17B2-11EF-8633-25B3960A682E-77302942!pb-smtp2.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> Reverting f4aa8c8b may not be easy to do mechanically, as it
> introduces the die_upon_dubious_ownership(), but 1204e1a8 uses an
> identical copy of the same function introduced by 8c9c051b (setup.c:
> introduce `die_upon_dubious_ownership()`, 2024-04-15), and reverting
> f4aa8c8b mechanically out of the merged result in v2.45.1 would
> likely to remove the function that is still in use, which would need
> to be retained.

Well the result can be seen at

    https://lore.kernel.org/git/20240521195659.870714-1-gitster@pobox.com/

but I am inclined to say that its [12/12] (partial reversion of
f4aa8c8b) is highly questionable, after thinking about it a bit
more.  It is true that you can run git-daemon as 'nobody', let it
peek into repositories owned by real users, feeling safe that
'nobody' would not be able to harm these repositories at all.  

But unless this is a tightly controlled hosting environment where no
repository owned by "real users" have malicious hooks and config
files, a "real user" could attack "nobody", and the safe.directory
mechanism that is over-agressive in denying things may alleviate the
problem.  At places like k.org where the repository data including
its hooks and configuration files are trusted, setting up the
configuration safe.directory in the ~nobody/.gitconfig to cover the
real user repositories would probably be a simple enough workaround.


