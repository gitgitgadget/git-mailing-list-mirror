Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8211C32
	for <git@vger.kernel.org>; Wed, 10 Jul 2024 01:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720573772; cv=none; b=GTEXnLNehUW18jwmUvKCLoGwy6cTKOcqCYauqBw6vMRAnLhej6+L1LNKf4ba/QsSRycXPRR7NVv1YL69ochPBPTkYBMZq7E4sdu1CiegCNgOxVAFOY6oca3eYa2u1qzPfe5chvdp3znhhHvibJqiwe1i2IuPYJVbcmIjowX5RdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720573772; c=relaxed/simple;
	bh=iQDVWocBKqnBuT7dP/HzBu/mRqPc31FCKvTziFUr/oQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZkTvPpzKf4HgCLHX8wJOdvzSHTWaWZV6+RihTlO7VxsISv/2ewosDnozv7XdEbGPwoPGtzn61v5TKXoszZ+BoUWvdP0v15C8pPOXAY/L04Gm3MVifpZJ/tk6Men06jUuvrdv/ERs/iIbow6+BNBtAjOBnN8awEnVQvXAoy6iUxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 31201 invoked by uid 109); 10 Jul 2024 01:09:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 10 Jul 2024 01:09:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6896 invoked by uid 111); 10 Jul 2024 01:09:26 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 09 Jul 2024 21:09:26 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 9 Jul 2024 21:09:27 -0400
From: Jeff King <peff@peff.net>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <ericsunshine@charter.net>, git@vger.kernel.org,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH] chainlint.pl: recognize test bodies defined via heredoc
Message-ID: <20240710010927.GA1529709@coredump.intra.peff.net>
References: <20240701220815.GA20293@coredump.intra.peff.net>
 <20240702235034.88219-1-ericsunshine@charter.net>
 <20240706060143.GD698153@coredump.intra.peff.net>
 <xmqqr0c6makb.fsf@gitster.g>
 <20240706231128.GA746087@coredump.intra.peff.net>
 <CAPig+cTv-DaGRmwWWCk8b33MKzV25vfP2zPKd2VOAEOtz4FZ2A@mail.gmail.com>
 <20240708090837.GD819809@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240708090837.GD819809@coredump.intra.peff.net>

On Mon, Jul 08, 2024 at 05:08:37AM -0400, Jeff King wrote:

> I took a look at running each test individually. It's surprisingly quite
> a bit slower! About 4s instead of 200ms. There's a bit of low-hanging
> fruit to get it down to ~1.7s (which I'll include in my series). But in
> the end I punted on that for now, but did add line-number checks. Each
> expect file just knows its own numbers, and I use a bit of perl to
> handle the running offset.

By the way, in case you are wondering why I haven't sent out the next
iteration of the series: I am stuck trying to figure out some Windows
line-ending nonsense.

The chainlint.pl parser chokes on CRLF line endings. So Windows CI
produces:

  runneradmin@fv-az1390-742 MINGW64 /d/a/git/git/t
  # perl chainlint.pl chainlint/for-loop.test
  'nternal error scanning character '

(the funny overwrite is because the invalid char is a CR). I tried a few
simple things to skip past this error, but the problem is pervasive. We
really just want to have perl handle the line endings on read. And doing
this works:

  # PERLIO=:crlf perl chainlint.pl chainlint/for-loop.test
  # chainlint: chainlint/for-loop.test
  # chainlint: for-loop
  [...etc, normal output...]

Which gives me all sorts of questions:

  - isn't crlf handling usually the default for perl builds on Windows?
    I guess this is probably getting into weird mingw vs native Windows
    distinctions that generally leave me perplexed.

  - why wasn't this a problem before? I'm guessing again in the "weird
    mingw stuff" hand-waving way that when we used "sed" to assemble
    everything, it stripped the CR's in the "chainlinttmp/tests" file.
    And in my series, that "cat" is replaced with a perl script (that
    writes the "tests" and "expect" files together).

  - why doesn't "PERLIO=:crlf make check-chainlint" work? It seems that
    perl spawned from "make" behaves differently. More mingw weirdness?

I'm tempted to just do this:

--- a/t/chainlint.pl
+++ b/t/chainlint.pl
@@ -779,7 +779,7 @@ sub check_script {
        while (my $path = $next_script->()) {
                $nscripts++;
                my $fh;
-               unless (open($fh, "<", $path)) {
+               unless (open($fh, "<:unix:crlf", $path)) {
                        $emit->("?!ERR?! $path: $!\n");
                        next;
                }

It feels like a hack, but it makes the parser's assumptions explicit,
and it should just work everywhere.

-Peff
