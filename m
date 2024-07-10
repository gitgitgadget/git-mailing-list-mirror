Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3859C522E
	for <git@vger.kernel.org>; Wed, 10 Jul 2024 07:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720595213; cv=none; b=infrS1mLN7pLzX5NLU1EXvGZWBwXKN8ZsRx+7Wpe9bEwR39fRPXRvgnyMseq8ZuL3STdBnuFoDUSSyneN0NJ9V3J4ButwM7X+iD6kFe6/JD4A+PVBsJfFA7tuNj6O9k1+lrWv4HeUj1mKGEnLcfQiIPIPTg4uVpC+9R1GawJFY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720595213; c=relaxed/simple;
	bh=6toBjWrE45XWxb96zF3StOl1i6gsNlj2xwX6Bwjpzxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u1iSs2wOPzFqY+DokLcbwtUxeF4ah94CDENwP3JI77V4S0ncT1IW4PWEHIg9Igdm4JhL4Xm/Q26JVpt7Cbk8IUzTRVuk3UNSJhgeXxUb8LzHnkMDFJkOriaiMLko276aXuV/n0mzyYSy1cssoo+kAiE6JtJQuvxGMiInWnaq5SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 790 invoked by uid 109); 10 Jul 2024 07:06:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 10 Jul 2024 07:06:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9835 invoked by uid 111); 10 Jul 2024 07:06:45 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 10 Jul 2024 03:06:45 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 10 Jul 2024 03:06:47 -0400
From: Jeff King <peff@peff.net>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <ericsunshine@charter.net>, git@vger.kernel.org,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH] chainlint.pl: recognize test bodies defined via heredoc
Message-ID: <20240710070647.GA2048777@coredump.intra.peff.net>
References: <20240701220815.GA20293@coredump.intra.peff.net>
 <20240702235034.88219-1-ericsunshine@charter.net>
 <20240706060143.GD698153@coredump.intra.peff.net>
 <xmqqr0c6makb.fsf@gitster.g>
 <20240706231128.GA746087@coredump.intra.peff.net>
 <CAPig+cTv-DaGRmwWWCk8b33MKzV25vfP2zPKd2VOAEOtz4FZ2A@mail.gmail.com>
 <20240708090837.GD819809@coredump.intra.peff.net>
 <20240710010927.GA1529709@coredump.intra.peff.net>
 <CAPig+cRXkOesS_ctvxY2X=rwesTzgrBB0=5fvQLQsG3hZVY9TQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPig+cRXkOesS_ctvxY2X=rwesTzgrBB0=5fvQLQsG3hZVY9TQ@mail.gmail.com>

On Tue, Jul 09, 2024 at 11:02:01PM -0400, Eric Sunshine wrote:

> On Tue, Jul 9, 2024 at 9:09 PM Jeff King <peff@peff.net> wrote:
> > The chainlint.pl parser chokes on CRLF line endings. So Windows CI
> > produces:
> >
> >   runneradmin@fv-az1390-742 MINGW64 /d/a/git/git/t
> >   # perl chainlint.pl chainlint/for-loop.test
> >   'nternal error scanning character '
> 
> As far as I understand, chainlint is disabled in the Windows CI. Did
> you manually re-enable it for testing? Or are you just running it
> manually in the Windows CI?

Neither. As far as I can tell, we still run the "check-chainlint" target
as part of "make test", and that's what I saw fail. For instance:

  https://github.com/peff/git/actions/runs/9856301557/job/27213352807

Every one of the "win test" jobs failed, with the same outcome: running
check-chainlint triggered the "internal scanning error".

> Assuming you manually re-enabled chaintlint in the Windows CI for this
> testing or are running it manually, it may be the case that
> chainlint.pl has never been run in the Windows CI. Specifically,
> chainlint in Windows CI was disabled by a87e427e35 (ci: speed up
> Windows phase, 2019-01-29) which predates the switchover from
> chainlint.sed to chainlint.pl by d00113ec34 (t/Makefile: apply
> chainlint.pl to existing self-tests, 2022-09-01). So, it's quite
> possible that chainlint.pl has never run in Windows CI. But, perhaps
> I'm misunderstanding or missing some piece of information.

I think that commit would prevent it from running as part of the actual
test scripts. But we'd still do check-chainlint to run the chainlint
self-tests. And because it only sets "--no-chain-lint" in GIT_TEST_OPTS
and not GIT_TEST_CHAIN_LINT=0, I think that the bulk run of chainlint.pl
by t/Makefile is still run (and then ironically, when that is run the
Makefile manually suppresses the per-script runs, so that
--no-chain-lint option is truly doing nothing).

And I think is true even with the ci/run-test-slice.sh approach that the
Windows tests use. They still drive it through "make", and just override
the $(T) variable.

> >   - why doesn't "PERLIO=:crlf make check-chainlint" work? It seems that
> >     perl spawned from "make" behaves differently. More mingw weirdness?
> 
> That could indeed be an msys2 issue. It will automatically convert
> colon ":" to semicolon ";" in environment variables since the PATH
> separator on Windows is ";", not ":" as it is on Unix. Moreover, the
> ":" to ";" switcheroo logic is not restricted only to PATH since there
> are other PATH-like variables in common use, so it's applied to all
> environment variables.

Ah, good thinking. I'm not sure if that's it, though. Just PERLIO=crlf
should behave the same way (the ":" is technically a separator, and it
is only a style suggestion that you prepend one). Likewise a space is
supposed to be OK, too, so PERLIO="unix crlf" should work. But neither
seems to work for me. So I'm still puzzled.

> > I'm tempted to just do this:
> >
> >         while (my $path = $next_script->()) {
> >                 $nscripts++;
> >                 my $fh;
> > -               unless (open($fh, "<", $path)) {
> > +               unless (open($fh, "<:unix:crlf", $path)) {
> >
> > It feels like a hack, but it makes the parser's assumptions explicit,
> > and it should just work everywhere.
> 
> Yep, if this makes it work, then it seems like a good way forward,
> especially since I don't think there's any obvious way to work around
> the ":" to ";" switcheroo performed by msys2.

OK, I'll add that to my series, then. The fact that we weren't really
_intending_ to run chainlint there makes me tempted to just punt and
disable it. But AFAICT we have been running it for a while, and it could
benefit people on Windows (though it is a bit funky that we do a full
check-chainlint in each slice). And I suspect disabling it reliably
might be a trickier change than what I wrote above anyway. ;)

-Peff
