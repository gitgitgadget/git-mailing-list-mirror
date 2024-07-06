Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C06B1C696
	for <git@vger.kernel.org>; Sat,  6 Jul 2024 06:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720248879; cv=none; b=hyvtsk0gxGnWrHuhK52TWvQMfTWU6QKXt37wQ4e/B0EGwIGqKFjM4eZu1xVLMCXNgIbAkp7BsAWCgU/x9TVnom3nagg5gR/dKBIfSmrY4Do2BbxvQKgoFjyKS7HU9RM3YTgJVCvh4jbzgmws0Q3NpoM77VLw+bC729zRWLMnqWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720248879; c=relaxed/simple;
	bh=aqL38RnVFF4RbmFFQ95Ho/GNbRjvDBqU/VZgQHObIBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LLuXVOaOMIE8pUe13IiBczFrgzYEpb46s6JP5VtiuLHaxrRYtEPqam7zarcyvwaT2X6Kr7Wgtz+xHjg7PSNa3m3D8bmSAQmO8eTOeuLx+dF03+G4C3wr33S0NXmt41NTrUkDAdPhfQ7jLgcmOR42cBXhsU4m7NxN4xScIeJTzA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 24404 invoked by uid 109); 6 Jul 2024 06:54:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 06 Jul 2024 06:54:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31590 invoked by uid 111); 6 Jul 2024 06:54:33 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 06 Jul 2024 02:54:33 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 6 Jul 2024 02:54:34 -0400
From: Jeff King <peff@peff.net>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 1/2] test-lib: allow test snippets as here-docs
Message-ID: <20240706065434.GA702300@coredump.intra.peff.net>
References: <20240701220815.GA20293@coredump.intra.peff.net>
 <20240701220840.GA20631@coredump.intra.peff.net>
 <CAPig+cQdioTBinkacLFb7yktm168oB+qyP9MpZtTRE=1aBz5yg@mail.gmail.com>
 <20240702005144.GA27170@coredump.intra.peff.net>
 <CAPig+cQ6PLZA=s6D1XsdcFeeg-=ffib9QZGFLycsHWLZZ1ibCg@mail.gmail.com>
 <20240706053105.GB698153@coredump.intra.peff.net>
 <CAPig+cQnZjMBPooBqMJjPY78EiCEXQOSSyHBm4GtLcbsSqZKrw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cQnZjMBPooBqMJjPY78EiCEXQOSSyHBm4GtLcbsSqZKrw@mail.gmail.com>

On Sat, Jul 06, 2024 at 02:11:13AM -0400, Eric Sunshine wrote:

> > >     cat <<EOFA && x=$(cat <<EOFB &&
> > >     A body
> > >     EOFA
> > >     B body
> > >     EOFB
> [...]
> In retrospect, I think my claim is bogus in the context of
> ScriptParser::parse_cmd(). Specifically, ScriptParser::parse_cmd()
> calls its parent ShellParser::parse_cmd() to latch one command.
> ShellParser::parse_cmd() stops parsing as soon as it encounters a
> command terminator (i.e. `;`, `&&`, `||`, `|`, '&', '\n') and returns
> the command. Moreover, by definition, given the language
> specification, the lexer only consumes the heredocs upon encountering
> `\n`. Thus, if someone writes:
> 
>     test_expect_success title - <<\EOT && whatever &&
>     ...test body...
>     EOT
> 
> then ScriptParser::parse_cmd() will receive the command
> `test_expect_success title -` from ShellParser::parse_cmd() but the
> heredoc will not yet have been consumed by the lexer since it hasn't
> yet encountered the newline[1].
> 
> So, the above example simply can't work correctly given the way
> ScriptParser::parse_cmd() calls ScriptParser::check_test() as soon as
> it encounters a `test_expect_success/failure` invocation since it
> doesn't know if the heredocs have been latched at that point.

Ah, yeah, I think you're right. I had parsed your example in my mind as:

  cat <<EOFA $(cat <<EOFB)

without an intervening "&&" (taking the second here-doc as an argument
to the original command). Which _does_ work with your patch.

> To make it properly robust, rather than immediately calling
> check_test(), it would have to continue consuming commands, and saving
> the ones which match `test_expect_success/failure` invocation, until
> it finally hits a `\n`, and only then call check_test() with each
> command it saved.  But that's probably overkill at this point
> considering that we never write code like the above, so the submitted
> patch[2] is probably good enough for now.

Yep, I'd agree with all of that.

-Peff
