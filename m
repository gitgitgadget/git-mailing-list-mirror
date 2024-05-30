Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699CA142E7C
	for <git@vger.kernel.org>; Thu, 30 May 2024 07:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717053723; cv=none; b=f+C2xl4sGnuVOufW06nkfAwMK3lJqNOGNGKbUyA14T8bb5yITV2YjyueCQTRmQuAtsgi+/bWrqSFdmXAkm5eURCZYJvNWZc7tb9Hx/un5xy6xONdAuaua48Snuhd4fKjOgujxKPh4bst4t8dZPwHkFh0uRoNIskCO9Pp1cH18Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717053723; c=relaxed/simple;
	bh=mVOBekN17Ath+p+EBSHD64uzXGHmLjA2nHojtWdS3/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G4mRcV+zg8MH02Ud+QVR6AwFDuiu2ky4V6Pgmp4MUqVxhdTQ/oYF/YnMObfEAnglb07dd+7JyrdADgtQBaIzSzn6aswYlSvUJk9fmdBSEZ1yULwqL5F8vVYMgV7Z8hpdz2ZCtBxidESwDs2AQaAY//kE71nQDKviE1Ohqmt+tZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 17003 invoked by uid 109); 30 May 2024 07:22:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 30 May 2024 07:22:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28206 invoked by uid 111); 30 May 2024 07:21:58 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 30 May 2024 03:21:58 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 30 May 2024 03:21:59 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH 3/5] mv: move src_dir cleanup to end of cmd_mv()
Message-ID: <20240530072159.GF1949834@coredump.intra.peff.net>
References: <20240530063857.GA1942535@coredump.intra.peff.net>
 <20240530064422.GC1949704@coredump.intra.peff.net>
 <Zlgk_MMDGlphfO9U@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zlgk_MMDGlphfO9U@tanuki>

On Thu, May 30, 2024 at 09:04:28AM +0200, Patrick Steinhardt wrote:

> > But if the actual move queues any errors in only_match_skip_worktree,
> > that can cause us to jump straight to the "out" label to clean up,
> > skipping the free() and leaking the array.
> > 
> > Let's push the free() down past the "out" label so that we always clean
> > up (the array is initialized to NULL, so this is always safe). We'll
> > hold on to the memory a little longer than necessary, but clarity is
> > more important than micro-optimizing here.
> [...]
> 
> Ouf of curiosity, did you check whether this makes any additional tests
> pass with SANITIZE=leak?

No, I didn't. I think you can only trigger it with a sparse index, at
which point it seemed like diminishing returns to try to reproduce.

But running in "check" mode is not too hard...

...time passes...

Looks like no. The obvious candidate would be t7002-mv-sparse-checkout,
but it looks like the sparse-checkout code has minor leaks itself.

-Peff
