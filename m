Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BAE713BAFB
	for <git@vger.kernel.org>; Fri, 10 May 2024 22:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715379633; cv=none; b=A/UVd5av2esdePZ6fd6t8cs6FW4nTCmvgNnyHIhUK4kRHNJkNVrgBPwq9kRpcjcaT1YUvu6O0jcrn+6oYStWFVgvcU6PjJAlQ6fRSV/GNOiSovHkyg3/rDJaS7qCKZqgaPZutct9saMuWQabyo9cbAjYveDxWlIKDrM8ki/W19g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715379633; c=relaxed/simple;
	bh=cBILBrwO5HQUfpI6x5SnYUQjdu04u1c23Ncv0T62nO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qdJBPVISnBc9SncAZG6Rn+DL4DTscWQrWVmvS57kX3om7KiNNd0LTESB+3MG96XOSJNS4OMSqG4+GhkWb4slJfFe8MkaXzNgkaUGM6J7/kAoIL5k9aWsRU2wLU1Ws+hDMf3RR0/934LXUXQd8pJQ+ZJf4nHvWMxA4ckn/qRMtDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 19649 invoked by uid 109); 10 May 2024 22:20:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 10 May 2024 22:20:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14249 invoked by uid 111); 10 May 2024 22:20:32 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 10 May 2024 18:20:32 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 10 May 2024 18:20:30 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Emily Shaffer <nasamuffin@google.com>, git@vger.kernel.org,
	git@jeffhostetler.com
Subject: Re: [PATCH] trace2: intercept all common signals
Message-ID: <20240510222030.GD1962678@coredump.intra.peff.net>
References: <20240510172243.3529851-1-emilyshaffer@google.com>
 <xmqqv83l4i86.fsf@gitster.g>
 <CAJoAoZmvzZaLN6cQkH4XeD9-=OwWFjT1adRA1oFHaUVyVWwLXQ@mail.gmail.com>
 <xmqqle4h4d99.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqle4h4d99.fsf@gitster.g>

On Fri, May 10, 2024 at 01:34:42PM -0700, Junio C Hamano wrote:

> Emily Shaffer <nasamuffin@google.com> writes:
> 
> > While I'm at it, since you pointed out ! instead of test_must_fail, I
> > wondered if I should change "! test_grep" as well - but when I grep t/
> > it looks like it's not usual to use `test_must_fail test_grep`, but
> > instead to use `test_grep ! <omitted pattern> <file>`. I'll change
> > that too.
> 
> "! test_grep" is an anti-pattern.  We should have a documentation
> somewhere in t/README or nearby (if we don't, somebody please add
> one).

Better than documentation, maybe something like:

diff --git a/t/check-non-portable-shell.pl b/t/check-non-portable-shell.pl
index b2b28c2ced..7de2c30aa0 100755
--- a/t/check-non-portable-shell.pl
+++ b/t/check-non-portable-shell.pl
@@ -51,6 +51,7 @@ sub err {
 		err q(quote "$val" in 'local var=$val');
 	/^\s*([A-Z0-9_]+=(\w*|(["']).*?\3)\s+)+(\w+)/ and exists($func{$4}) and
 		err '"FOO=bar shell_func" assignment extends beyond "shell_func"';
+	/! test_grep/ and err 'do not invert test_* functions';
 	$line = '';
 	# this resets our $. for each file
 	close ARGV if eof;

There's at least one other case already. If you shorten it to just "!
test_" to catch more functions, you can see there are a lot of wrong
test_cmp invocations, too (maybe not quite as bad because we don't
produce a specific message, but we'd yield a confusing diff output).

But I think we can't cover everything; there are some like
test_have_prereq which obviously are invertible.

-Peff
