Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D0616190B
	for <git@vger.kernel.org>; Wed, 21 Aug 2024 12:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724242506; cv=none; b=hVVUlAlQuk00vvP7iVZCHCSoxDp/ODxoUlMXGHqlUzQkK0DLFO3J+wK5c2oXMLHqFuqsxTi9Qp+p0Ty87HMv8ZKdJj09bzFyi2UKijxNn42UKR0KWi1qo2HMQdAxAUaTdT9KnSOLZW9qar4ntDzoCFUPWJanzUCYIo6BQCuazmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724242506; c=relaxed/simple;
	bh=UmlIT7oHHi2bWSreRHqx3wH1R0/iXurw5sN6X5Fmz90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hPTwpfnng0T20w0DHnksHK45tF8bfxAQ/H2aSScAcjzYwF2NEXtcO4YGTiZCylOLoIXGvRe/ZpG3b42szRWcRY4mV8Wid10h3jxZ0D3v5LtQQZOmyv8lnWjKF76Aj2yoC3h2qkVqjED1rKK4fF19JmTFc7RJ2wVtWTBJwhtPLRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 26532 invoked by uid 109); 21 Aug 2024 12:14:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 21 Aug 2024 12:14:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12054 invoked by uid 111); 21 Aug 2024 12:14:55 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 21 Aug 2024 08:14:55 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 21 Aug 2024 08:14:54 -0400
From: Jeff King <peff@peff.net>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v2 5/9] chainlint.pl: check line numbers in expected
 output
Message-ID: <20240821121454.GA498761@coredump.intra.peff.net>
References: <20240710083416.GA2060328@coredump.intra.peff.net>
 <20240710083755.GE2060601@coredump.intra.peff.net>
 <CAPig+cTACjostXvjJMnLEpgbnfat9cjM63pLXwNJm1=2P3gq8g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cTACjostXvjJMnLEpgbnfat9cjM63pLXwNJm1=2P3gq8g@mail.gmail.com>

On Wed, Aug 21, 2024 at 03:00:05AM -0400, Eric Sunshine wrote:

> > +for my $script (@ARGV) {
> > +       print $expect "# chainlint: $script\n";
> > +
> > +       open(my $expect_in, '<', "chainlint/$script.expect")
> > +               or die "unable to open chainlint/$script.expect: $!";
> > +       while (<$expect_in>) {
> > +               s/^\d+/$& + $offset/e;
> > +               print $expect $_;
> > +       }
> > +
> > +       open(my $test_in, '<', "chainlint/$script.test")
> > +               or die "unable to open chainlint/$script.test: $!";
> > +       while (<$test_in>) {
> > +               /^# LINT: / and next;
> > +               print $tests $_;
> > +               $offset++;
> > +       }
> > +}
> 
> I'm surprised that we're not closing the two file handles opened on
> each iteration of this loop. Is that intentional? Or am I forgetting
> my Perl and they are somehow getting closed anyhow (for instance, by
> the <...> operator hitting EOF)?

They're scoped to the loop with "my", so they'll both be closed for each
iteration of the outer loop when the handles go out of scope.

You can verify with something like:

  touch foo bar baz
  strace -e openat,write,close \
  perl -e '
	for my $script (@ARGV) {
		syswrite(STDOUT, "opening $script");
		open(my $in, "<", $script);
		syswrite(STDOUT, "finished $script");
	}
  ' foo bar baz >/dev/null

which should show:

  write(1, "opening foo", 11)             = 11
  openat(AT_FDCWD, "foo", O_RDONLY|O_CLOEXEC) = 3
  write(1, "finished foo", 12)            = 12
  close(3)                                = 0
  write(1, "opening bar", 11)             = 11
  [...etc...]

-Peff
