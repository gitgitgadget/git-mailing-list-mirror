Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31A41A277
	for <git@vger.kernel.org>; Sat,  6 Jul 2024 06:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720246734; cv=none; b=fns2cxYtuRvzQBD0DD/GOX7eOauwlU783J0fmwYnsG7FtSrTrqJsszhOloB9E0ZB0IF0p/wZuu3ib5z9oVCjxJtr5eNoCncr90VQQ7fjlZH2/i5s/dvwuq3gB/Zl8iLfs1b6ptUSG/+Ze+7cMrM1MBlZVhO7ceLZWXpClOckI+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720246734; c=relaxed/simple;
	bh=EFaJD00dKah7q+1G+I9l6F9oGsrlZEM1ErmWwwONeRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K8agZeuSEKpXB0tnSiE/Ezu4VBClvqBfUiiRem/OjFkrTzVkFunYyqbCPyhj3kQqxPSatGMD1B9eVLAhFcH9NenBxkhYaTc7BnIe6rQ3A1lEjjr/Whcx7k6U6aQeSmvuLXBxvLxy5WL4dWEPLVSCDqrKz0vWXAmUil3BYakZZkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 23555 invoked by uid 109); 6 Jul 2024 06:18:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 06 Jul 2024 06:18:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31308 invoked by uid 111); 6 Jul 2024 06:18:49 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 06 Jul 2024 02:18:49 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 6 Jul 2024 02:18:50 -0400
From: Jeff King <peff@peff.net>
To: =?utf-8?B?UnViw6lu?= Justo <rjusto@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] test-lib: fix GIT_TEST_SANITIZE_LEAK_LOG
Message-ID: <20240706061850.GB700645@coredump.intra.peff.net>
References: <f4ae6e2a-218a-419c-b6c4-59a08be247a0@gmail.com>
 <xmqqv81ovp9l.fsf@gitster.g>
 <bda01080-1231-476a-9770-88b62a75ffe2@gmail.com>
 <72b69a20-3f51-4f51-8ebc-ead20e3eebcb@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <72b69a20-3f51-4f51-8ebc-ead20e3eebcb@gmail.com>

On Wed, Jul 03, 2024 at 11:44:33PM +0200, Rubén Justo wrote:

> > Explicitly indicating that the error is being forced due to
> > "GIT_TEST_SANITIZE_LEAK_LOG=true", for a test that doesn't fail when run
> > normally or even when run with just
> > "GIT_TEST_PASSING_SANITIZE_LEAK=yes", could save us some confusion.
> > 
> > So, I dunno.
> > 
> > Anyway, I agree that this can be addressed later.
> > 
> > Thanks.
> 
> Maybe what we should do is integrate "GIT_TEST_SANITIZE_LEAK_LOG" into
> "GIT_TEST_PASSING_SANITIZE_LEAK" because I'm not sure what value we get
> by keeping them separate (test performance?).  But that's another topic,
> even further out of scope of this patch :-)

I don't think we want to integrate them, but I'd suggest that
SANITIZE_LEAK_LOG should be the default/only option.

Without it, you are potentially missing leaks in programs whose failing
exit codes do not trigger a test failure. So there is no point in
running PASSING_SANITIZE_LEAK=check without also checking the logs. But
it is still useful to set SANITIZE_LEAK_LOG just for normal runs to look
for leaks.

I don't know of any reason we couldn't always check the logs (for a
leak-checking build), and I didn't see anything in the history. I think
it was written that way only because there is otherwise no affirmative
action by the user to say "and btw, look for leaks" (and if we are not
looking for leaks, there might not be any logs!).

But really, if you have done a leak-checking build, then every run of
the tests is looking for leaks, whether you check the logs or not. So we
should able to just check that $SANITIZE_LEAK is set. And then there
would be one less thing for people checking for leaks to remember to
set.

-Peff
