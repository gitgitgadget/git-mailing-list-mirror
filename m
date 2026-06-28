Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38BC2E11B9
	for <git@vger.kernel.org>; Sun, 28 Jun 2026 07:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782633446; cv=none; b=i56PCrvPQGE8COJTGf7Ku2hiwNSI+ss2nldfmGRVXHDaK39K3f3ZdG3jaMy/lulqVJRufYGV6E5ctGwAeAJ1gNf/h2Z5wpiqk39Fr3axiuju312wAnGKlh5BT322VrMJUdGGoJLyxHrcMEaE/ZKfn3Tt7HArA+H2/0bRKWd7gv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782633446; c=relaxed/simple;
	bh=sIEKzt7P2gwS6rY8QACHEzkNEcc8T/QJIgO6gMn4wGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rdIKeHTgiUMvSComOOpjcB7H3d/fp5aXtcIEaa8nk63R14cupy1VqFAkrZHRJgDzd11hD3LarOdbHeYdn8RM8yp96a0jD7PoIIedc7464KPiJRcHguDGNVirMb7PXOwf7+6oD6GMNavo5jOcU6/VsRuJZb/9caNowV+W/2VaDKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=YvF46b7S; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="YvF46b7S"
Received: (qmail 52183 invoked by uid 106); 28 Jun 2026 07:57:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=sIEKzt7P2gwS6rY8QACHEzkNEcc8T/QJIgO6gMn4wGs=; b=YvF46b7SRacBtYp99pO9uxwoHTHIWCRR+5XLrwJLeWUcVfFa2WHW+/xJYdvQFsISYwRtxSHAE3MxKJ2nvV6JfKDIT9mVN+193s9avHCcjZK/q8QD0uwj+X+WJlhNLCqQKlnJ/Amc1jijjyAshRtmFAIodbQwus3nsYb6yopj9KJZWxIdb8a0q5ZXtl0sVhpbngMkHuuCdGcjFk0C3LUuJoLO/zyleE1+zrVx2yh87PcM2ZsASWc3xM5q7xUnu5omSXTIvd4qnUhJI59Po/cURYmASp6TS5KC1bKtCJnl8eM/ArXyLLSZBnrh4jjSWPwG+Uw4UcIZ5eD1bNnQgSk87Q==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 28 Jun 2026 07:57:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 111178 invoked by uid 111); 28 Jun 2026 07:57:16 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 28 Jun 2026 03:57:16 -0400
Authentication-Results: peff.net; auth=none
Date: Sun, 28 Jun 2026 03:57:16 -0400
From: Jeff King <peff@peff.net>
To: Michael Montalbo <mmontalbo@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/3] fixing expensive http test timeouts
Message-ID: <20260628075716.GA3525066@coredump.intra.peff.net>
References: <CAC2Qwm+9sh=ks1fuux415JGdDJ38Jq6eZrSH7-qzQxYCoy+Aug@mail.gmail.com>
 <20260621213407.GC2297179@coredump.intra.peff.net>
 <aji9MOE-NTHKXYqn@pks.im>
 <ajkEzhdqzmAePk_P@pks.im>
 <ajkGkB2ckf3p43QR@pks.im>
 <ajkOoRhqaAcy6gBg@pks.im>
 <CAC2QwmJA2TH6BmO0O61qRYvV2pqURUk0dTXpkJtb9e-TZNZDZQ@mail.gmail.com>
 <20260626051657.GB3138423@coredump.intra.peff.net>
 <aj5ZaZK7xylfs4Xw@pks.im>
 <CAC2QwmLkHUymvtYbjY8aQO9_VogvaSXdbb1_DSZtcBttGfN0tg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAC2QwmLkHUymvtYbjY8aQO9_VogvaSXdbb1_DSZtcBttGfN0tg@mail.gmail.com>

On Fri, Jun 26, 2026 at 04:26:28PM -0700, Michael Montalbo wrote:

> I think Peff and Patrick's suggestion to just increase the Apache timeout
> makes sense. I ran some experiments using a really long timeout with an
> artificially slowed down CI runner and all the jobs made progress
> (if slowly) without stalling, and eventually completed successfully:
> 
> https://github.com/mmontalbo/git/actions/runs/28267019651
> 
> I haven't spent a lot of time trying to figure out what the right timeout
> value should be. An hour definitely seems like overkill, with something
> on the order of 5-10 minutes seeming more reasonable, but I don't
> have a principled number.

Here are some patches to keep things moving along. I arbitrarily picked
10 minutes, because multiplying the 1-minute default by 10 felt right. ;)

The first one just bumps the timeout and should make our problems go
away. The other two are optimizations, but I'm on the fence on whether
the final patch is worth it.

Thanks again for all of the digging.

  [1/3]: t/lib-httpd: bump apache timeout
  [2/3]: t5551: put many-tags case into its own repo
  [3/3]: t5551: pack refs after creating many tags

 t/lib-httpd/apache.conf     |  1 +
 t/t5551-http-fetch-smart.sh | 10 ++++++----
 2 files changed, 7 insertions(+), 4 deletions(-)

-Peff
