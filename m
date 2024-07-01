Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8622916F8F7
	for <git@vger.kernel.org>; Mon,  1 Jul 2024 20:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719866559; cv=none; b=RLg/JNDRjF2P6c1bEyF28ouR0K5laVrlgLDsGKiSA4WsNr+OYCy4HpuuoogeQeswm72CTwH7mjB69Xu8BBwTxGZtM+2KlRTksbaFCSg2VUCQuSjq8Ko98SanJ3D5cswHn52qngVT9ICHVLiHVPAZQqiONbuQQfLbDg6ClUGPK54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719866559; c=relaxed/simple;
	bh=BT023mWPQ2ED6x5UI2+DkGboYXeQg4Jgzo439TZz1ss=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fiD48im4y9k7PZyldeIj+jzc4oINTK+7C/h7lBjUNG+FbBlWWkoM5wNhvjkt4mVqUSFAvwRlpbm2/4iQ1LjIT0ftiwYdK5+5X9tn7OSz7g5iWqN0G9V5HOh5hTIuaImIoaJcSQ3CkY0/v8uoDSxzcog8aCjfs8dj6720jpYug1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=mb+SsDvI; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="mb+SsDvI"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 0F4761E837;
	Mon,  1 Jul 2024 16:42:38 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=BT023mWPQ2ED6x5UI2+DkGboYXeQg4Jgzo439T
	Zz1ss=; b=mb+SsDvI2uvhenpbDJOLjMrIgRvFP4SVJGLgwsihUFkKh1hRHkV5lL
	EXajZvFiXoDXoouKySfXzT7wpn7kQ8g3VYQacuBhbLQKDQnl8Cu5+/m4tdvPUWTF
	82cBNoQwBFOSg3vljpXAnIoRCD9r4dN/H0enGOaivCy24tMRQU/Y4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 073861E836;
	Mon,  1 Jul 2024 16:42:38 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.219.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 929841E835;
	Mon,  1 Jul 2024 16:42:34 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
Cc: Jeff King <peff@peff.net>,  git@vger.kernel.org,  Alex Riesen
 <raa.lkml@gmail.com>,  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 2/1] do not pass "git -c foo=bar" params to transport
 helpers
In-Reply-To: <20100824064114.GA20724@burratino> (Jonathan Nieder's message of
	"Tue, 24 Aug 2010 01:41:14 -0500")
References: <7viq3119yn.fsf@alter.siamese.dyndns.org>
	<20100823183857.GA22386@coredump.intra.peff.net>
	<20100823191600.GA2523@coredump.intra.peff.net>
	<20100824064114.GA20724@burratino>
Date: Mon, 01 Jul 2024 13:42:32 -0700
Message-ID: <xmqqh6d8vo7b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 71FED362-37EA-11EF-AC60-C38742FD603B-77302942!pb-smtp20.pobox.com

Jonathan Nieder <jrnieder@gmail.com> writes:

> Like $GIT_CONFIG, $GIT_CONFIG_PARAMETERS needs to be suppressed by
> "git push" and its cousins when running local transport helpers to
> imitate remote transport well.
>
> Noticed-by: Jeff King <peff@peff.net>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
> Jeff King wrote:
>
>> Here's a first attempt. No idea if it has any bad side effects. :)
>
> Here's the transport boundary.

FYI: there is a follow-up discussion recently.

https://lore.kernel.org/git/20240701181916.GD3199@coredump.intra.peff.net/
