Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC19E14387B
	for <git@vger.kernel.org>; Mon,  7 Oct 2024 06:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728281297; cv=none; b=C1opONy5DAYAnUE3lwk0cXkthT9yXnWGYyvZvZj6J1lxrTj1IIVzfBeC4E8wGg71xdzFZIvTYrk8wgHdpGBX9SBGAR7yE2tGFSxyrafwQDxIry5KXq4Jp1klTSblv7BR8/iyuFj26WGN+SK8VR91EAf7PzyUnvPJ/qqR40zJiMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728281297; c=relaxed/simple;
	bh=Ihw1GzHcNTexwDxt1xd2xsqvBX41rkIxIX8U/tHj90k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QJLlcEqwc/NCRduGf7n8nq7ZHPkBubGuX0a+Y7+Lm1oVs0cyQ4uyER8JOP6sg9aVzA5ZTDRxFuyk7tYAnn2tcaCUrODG5ZYlItDvz/rQILg8Vs/+kNmLg8xmdZZGsHrxfrd9xALR9Ss7OppaXa1F/S0ta495yr/Z5etK8zGASDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=UJRXcCS5; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="UJRXcCS5"
Received: (qmail 31585 invoked by uid 109); 7 Oct 2024 06:08:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=Ihw1GzHcNTexwDxt1xd2xsqvBX41rkIxIX8U/tHj90k=; b=UJRXcCS5Dq408t6AFXqMklP6Qv1RZp3vjHx9U9NVOFQo/NNeBKA/DmoqpuKF/QBBCkpsxplfIQr/WGv/wG5FT2xsGKcWn31now2KoMurG2uknwA9W890NA6mlwjcQlY0kGW4GFiYcz3FV4je3bTL9jOF7iT+v1FjyzHK9LdLThNDMKN67vU8Kc91etmmldhwsQDZNPf5OKorUMBWbLBHNGm0/mK5PpnoyJDpZHESg2dHm8bMUT8MaPUUwQVrgbd6TxN5hHnSMAKhvNd5X0zjTTEL+rFkAMaQJtPqZ7azuqMg/BNCCJTM1DCzDJLQu1fOUSPlafjdG7UXyRgsEi/3sw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 07 Oct 2024 06:08:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3469 invoked by uid 111); 7 Oct 2024 06:08:14 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 07 Oct 2024 02:08:14 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 7 Oct 2024 02:08:13 -0400
From: Jeff King <peff@peff.net>
To: Koji Nakamaru via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Koji Nakamaru <koji.nakamaru@gree.net>
Subject: Re: [PATCH] fsmonitor: fix hangs by delayed fs event listening
Message-ID: <20241007060813.GA34827@coredump.intra.peff.net>
References: <pull.1804.git.1727862424713.gitgitgadget@gmail.com>
 <20241007055821.GA34037@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241007055821.GA34037@coredump.intra.peff.net>

On Mon, Oct 07, 2024 at 01:58:21AM -0400, Jeff King wrote:

> I think your patch has one small bug, which is that you don't
> pthread_mutex_destroy() at the end of fsmonitor_run_daemon(). But other
> than that I think it should work OK (I haven't tried it in practice yet;
> I assume you did?).

I just checked your patch in our CI, using the sleep(1) you suggested
earlier to more predictably lose the race(). It does work reliably (and
I confirmed with some extra trace statements that it does spin on the
sleep_millisec() loop).

I had also previously checked my suggested solution. So I do think
either is a valid solution to the problem.

-Peff
