Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7F417FD
	for <git@vger.kernel.org>; Wed, 10 Jul 2024 00:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720572500; cv=none; b=jZVOHJvvUWRMXHsP+ZSeGikasWvktHHGkXIX8tnHUfk4hWCNXeG6HDQpyus4sdbsX4+WNGtmowovVnDFMzGAv3re49YCL/O2TozH35nZclTpfPwAmmVVQ3he7D/hVb43hO80E1eE2Mk7tWHcdm3U94utSJ6kT6bQRagDYr95/I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720572500; c=relaxed/simple;
	bh=dflYroRseuOZ8PKza4D7SzvzgT/QLoLVVqTPOYEizBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tTUVkX8f5sFN/3NpdAJVzYJfWc1kPDbPseS6F5HCzsZgWuKuVAgsjzjdAG/7XOGDopqn/OjQmL7CIE54SH4ALQ9g7Nh7rBFuUNYZNpc+qSITjL1V8EQya8UpmrbTn6CfItJR/QJAB91OFqoowblDiShK356vkVxrRnnq/rdLv6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 31153 invoked by uid 109); 10 Jul 2024 00:48:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 10 Jul 2024 00:48:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6706 invoked by uid 111); 10 Jul 2024 00:48:16 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 09 Jul 2024 20:48:16 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 9 Jul 2024 20:48:17 -0400
From: Jeff King <peff@peff.net>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Eric Sunshine <ericsunshine@charter.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH] chainlint.pl: recognize test bodies defined via heredoc
Message-ID: <20240710004817.GB1526498@coredump.intra.peff.net>
References: <20240701220815.GA20293@coredump.intra.peff.net>
 <20240702235034.88219-1-ericsunshine@charter.net>
 <20240706060143.GD698153@coredump.intra.peff.net>
 <CAPig+cRUOSHuNezZfVUT43JGT5BWA3LTbQvKCkD37DxXn=L6Jg@mail.gmail.com>
 <20240708090530.GC819809@coredump.intra.peff.net>
 <CAPig+cTFZuU7zM7poqk4HeK09zn8bFrO37eUZiaGmeJ0yecpiw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPig+cTFZuU7zM7poqk4HeK09zn8bFrO37eUZiaGmeJ0yecpiw@mail.gmail.com>

On Mon, Jul 08, 2024 at 04:06:47PM -0400, Eric Sunshine wrote:

> One thing we may want to measure is how much extra time we're wasting
> for the (very) common case of latching heredoc bodies only to then
> ignore them. In particular, we may want to add a flag to ShellParser
> telling it whether or not to latch heredoc bodies, and enable that
> flag in subclass ScriptParser, but leave it disabled in subclass
> TestParser since only ScriptParser currently cares about the heredoc
> body.

I doubt it's much to hold on to a few extra small buffers. But it should
be easy to measure. Here are hyperfine results for checking all of our
test scripts both before (old.pl) and after (new.pl) your chainlint.pl,
with threading disabled:

  Benchmark 1: perl old.pl t[0-9]*.sh
    Time (mean ± σ):      4.215 s ±  0.052 s    [User: 4.187 s, System: 0.028 s]
    Range (min … max):    4.124 s …  4.288 s    10 runs
  
  Benchmark 2: perl new.pl t[0-9]*.sh
    Time (mean ± σ):      4.295 s ±  0.060 s    [User: 4.264 s, System: 0.031 s]
    Range (min … max):    4.229 s …  4.419 s    10 runs
  
  Summary
    perl old.pl t[0-9]*.sh ran
      1.02 ± 0.02 times faster than perl new.pl t[0-9]*.sh

So it does seem to make a small difference, but we're within the noise.

> In the long run, I think we probably want to build a full parse tree,
> attach relevant information (such as a heredoc body) to each node, and
> then walk the tree, rather than trying to perform on-the-fly lints and
> other operations on the token stream as is currently the case.
> [...]

Yeah, all of that sounds very sensible long term, but probably not worth
worrying about for this topic.

-Peff
