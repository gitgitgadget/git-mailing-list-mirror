Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEAA248CE0
	for <git@vger.kernel.org>; Fri, 10 May 2024 19:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715370393; cv=none; b=I0aghtUmo+2ka3cjI/0GmLiTujHQHCK6uevutiCzZHdywlRBKe1rm9wMMS1HFocUPwkwBZHx8ePsWssozOKNYhluFC3kOHi8MM/1ANfkAwWvh2mw77AqnE7zN9YyZQEq7c76qS0hBLwr3x/AhIpM5hbp72y/OCnDszR67tyhssM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715370393; c=relaxed/simple;
	bh=aWi5uGFqxu+ZwbScj4rFdj2T3oJf/fDPFXxnw6EtNxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=roUOkPy6m/HCdbuBBwIMjZ3ndtLseMJz5y0PSDMihDO8kh/fwj3/vj4nyMqlrJI8DRY11MI9BFvU/DVmDpRpnZASRtAMsPDobjJZhCsfOB8G5c3uvJE5mXyGqCW+XZG5u4vZgpZbnQjq74kkVhDwBpZHS0HQMXMNkoEo+fgTnVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 18906 invoked by uid 109); 10 May 2024 19:46:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 10 May 2024 19:46:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11863 invoked by uid 111); 10 May 2024 19:46:32 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 10 May 2024 15:46:32 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 10 May 2024 15:46:30 -0400
From: Jeff King <peff@peff.net>
To: Emily Shaffer <nasamuffin@google.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	git@jeffhostetler.com
Subject: Re: [PATCH] trace2: intercept all common signals
Message-ID: <20240510194630.GB1954863@coredump.intra.peff.net>
References: <20240510172243.3529851-1-emilyshaffer@google.com>
 <xmqqv83l4i86.fsf@gitster.g>
 <CAJoAoZmvzZaLN6cQkH4XeD9-=OwWFjT1adRA1oFHaUVyVWwLXQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJoAoZmvzZaLN6cQkH4XeD9-=OwWFjT1adRA1oFHaUVyVWwLXQ@mail.gmail.com>

On Fri, May 10, 2024 at 12:34:07PM -0700, Emily Shaffer wrote:

> Yes, it is because test_must_fail expects "natural" death. You can
> tell test_must_fail which signal you'd expect to receive, in theory,
> but I didn't get it to work (and it will be tricky to provide the
> correct signal in shell - I had originally hardcoded signal ints in
> sh, but then moved the signal enum->int resolution into
> helper/test-trace2.c because the alternative is doing some nasty
> grepping on other shell utility outputs, since the signal codes aren't
> platform/arch consistent).

We have test_match_signal(). Unfortunately it's not integrated with
test_expect_code(), so you have to do:

  { thing_which_fails; OUT=$?; } &&
  test_match_signal 15 "$OUT"

See 5263e22cba (t7006: simplify exit-code checks for sigpipe tests,
2021-11-21) for an example.

> I also wonder - do we want to capture SIGKILL as well? Some people may
> have muscle memory for `kill -9` (I do, for better or worse) instead
> of gentler `kill`. My intent was to notice any indication of user
> frustration resulting in manual termination, which would include `kill
> -9` too...

You can't catch SIGKILL; its whole purpose is to be un-catchable.

-Peff
