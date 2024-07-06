Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A71D1B285
	for <git@vger.kernel.org>; Sat,  6 Jul 2024 06:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720248938; cv=none; b=VOVsR3eL+VfFPYMYeuPeJsgou4JNlb3jixBpKjCigwwrds4kMkGeYpuy9qRqfdAbJRQa9R240rT5N/W21P1dBbF0pUAaRSZRzLmjo5ZJ3RFCsJB+XuVmCg7zeGCxzoEl62kqbDrt+/ouh5W3KoD/s+lVvaLvu0s4TJKT9eT+t0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720248938; c=relaxed/simple;
	bh=nUlhfwWPqedfIAtw5iZW+jt+4UPoBBqS4yWfEXfzYbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dsb6kQRnSVJvqF4SkMGBzL+Z0mSBRydNMpCrqVLTe5umgY+p7L/Y1Ez8bWtnQPwfq4adZM+23gydOXj2LWrI9Ka7f79rymmJeWU20f3doEI7+YeC3ptYBgrKOn3VRXLNJdgOsHV4NoONFhGpFTIVrEC9zOe4LHwz5ePecDIHhk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 24420 invoked by uid 109); 6 Jul 2024 06:55:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 06 Jul 2024 06:55:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31614 invoked by uid 111); 6 Jul 2024 06:55:33 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 06 Jul 2024 02:55:33 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 6 Jul 2024 02:55:34 -0400
From: Jeff King <peff@peff.net>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 1/2] test-lib: allow test snippets as here-docs
Message-ID: <20240706065534.GB702300@coredump.intra.peff.net>
References: <20240701220815.GA20293@coredump.intra.peff.net>
 <20240701220840.GA20631@coredump.intra.peff.net>
 <CAPig+cQdioTBinkacLFb7yktm168oB+qyP9MpZtTRE=1aBz5yg@mail.gmail.com>
 <20240702005144.GA27170@coredump.intra.peff.net>
 <CAPig+cQ6PLZA=s6D1XsdcFeeg-=ffib9QZGFLycsHWLZZ1ibCg@mail.gmail.com>
 <20240706053105.GB698153@coredump.intra.peff.net>
 <CAPig+cQnZjMBPooBqMJjPY78EiCEXQOSSyHBm4GtLcbsSqZKrw@mail.gmail.com>
 <CAPig+cTSAaZmoKHRPiVkV=Jc9z_JZWmGn_JZj+Atsc4DdC7XeQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPig+cTSAaZmoKHRPiVkV=Jc9z_JZWmGn_JZj+Atsc4DdC7XeQ@mail.gmail.com>

On Sat, Jul 06, 2024 at 02:47:57AM -0400, Eric Sunshine wrote:

> On Sat, Jul 6, 2024 at 2:11 AM Eric Sunshine <sunshine@sunshineco.com> wrote:
> > So, the above example simply can't work correctly given the way
> > ScriptParser::parse_cmd() calls ScriptParser::check_test() as soon as
> > it encounters a `test_expect_success/failure` invocation since it
> > doesn't know if the heredocs have been latched at that point. To make
> > it properly robust, rather than immediately calling check_test(), it
> > would have to continue consuming commands, and saving the ones which
> > match `test_expect_success/failure` invocation, until it finally hits
> > a `\n`, and only then call check_test() with each command it saved.
> > But that's probably overkill at this point considering that we never
> > write code like the above, so the submitted patch[2] is probably good
> > enough for now.
> 
> Of course, the more I think about it, the more I dislike relying upon
> what is effectively an accident of implementation; i.e. that in the
> typical case, the heredoc will already have been latched by the time
> ScriptParser::parse_cmd() has identified a `test_expect_success`
> command, due to the fact that ShellParser::parse_cmd() has that
> special case which peeks for `\n` immediately following some other
> command terminator. As such, fixing ScriptParser::parse_cmd() to only
> call check_test() once it is sure that a '\n' has been encountered is
> becoming more appealing, though it is of course a more invasive and
> fundamental change than the posted patch.

Rats, I just agreed with your earlier email. ;) I am OK with the
slightly hacky version we've posted (modulo the fixes I discussed
elsewhere). But if you want to take a little time to explore the more
robust fix, I am happy to review it.

-Peff
