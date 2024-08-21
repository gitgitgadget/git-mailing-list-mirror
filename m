Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1626714F138
	for <git@vger.kernel.org>; Wed, 21 Aug 2024 16:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724258367; cv=none; b=anbjH+9dsshQtJ6KfI4End2y2ZQwnlSd9oCi09qWOd5SNCDJznFJSmvqBmCPaK5vMwSaAp23WUiYupOCvONWgZrX8WcYS/C6NibO/TcBOUiQ6QSA0B0boH+VkdcMb64jUyh17kGnuq+ULAkQBQfMeMUalKyTD9o9osUboV7ling=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724258367; c=relaxed/simple;
	bh=+7LnBQ+2T9paOzx70pe9+6aSve7W6oGjKcBONZrsTNU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bMDTva99j2bUFkrhFPxN1D5YFjqxV66fNMcd4HCX9GVbcvo2FbY9TIOjl+okcjzqHTAcvbj674eJJa5N0B8sXln0+NbTD5MKYYrgVvmzQLInXUk/ktRA8dGCMUCAOnSBV+Ny1NtdyQDpGgrnWp6MWqrFjSDMzrJ+QMBYxDfPPTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ocJePQcK; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ocJePQcK"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 6A3072F624;
	Wed, 21 Aug 2024 12:39:25 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=+7LnBQ+2T9paOzx70pe9+6aSve7W6oGjKcBONZ
	rsTNU=; b=ocJePQcKIT5/peQWu/EEaenthQydrFmnSDm7WBI1BtWclpxtPe9z12
	78xZ57H4/01gbWJxu/NuFjgRpLzNlkMI+ySqcWdq3CYMdRAj2yxua7Wy507lO9RI
	nMPhOP0P6BVr5zdiAlPaYt4JRA0M21fVKtDZQ0hdstIIOCkecwpUY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 624F62F623;
	Wed, 21 Aug 2024 12:39:25 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E97242F622;
	Wed, 21 Aug 2024 12:39:21 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Johannes.Schindelin@gmx.de,  ps@pks.im,
  james@jamesliu.io,  Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 0/7] [RFC] advice: refuse to output if stderr not TTY
In-Reply-To: <20240821154001.GA506216@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 21 Aug 2024 11:40:01 -0400")
References: <pull.1776.git.1724238152.gitgitgadget@gmail.com>
	<20240821154001.GA506216@coredump.intra.peff.net>
Date: Wed, 21 Aug 2024 09:39:20 -0700
Message-ID: <xmqq7cc925l3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 EB2B19E4-5FDB-11EF-8ED6-E92ED1CD468F-77302942!pb-smtp21.pobox.com

Jeff King <peff@peff.net> writes:

> Playing devil's advocate for a moment: what about programs that read
> stderr but intend to relay the output to the user?
>
> For example, programs running on the server side of a push are spawned
> by receive-pack with their stderr fed into a muxer that ships it to the
> client, who then dumps it to the user's terminal. Would we ever want to
> see their advice?
>
> My guess is "conceivably yes", though I don't know of a specific example
> (and in fact, I've seen the "your hook was ignored because it's not
> executable" advice coming from a server, which was actually more of an
> annoyance on the client side).

Ah, I should have waited to think about the topic before reading
what you wrote.  Yes, this is a huge downside.

> Looking over patch 7, I think the escape hatch for all of these cases
> would be setting GIT_ADVICE=1. Which isn't too bad, but it does require
> some action. I'm not sure if it is worth it (but then, I am not all that
> sympathetic to the script you mentioned that was trying to be too clever
> about parsing stderr).

This too.
