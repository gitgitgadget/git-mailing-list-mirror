From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Disable OpenSSL SHA1 implementation by default
Date: Fri, 26 Feb 2010 04:36:33 -0500
Message-ID: <20100226093633.GA9609@coredump.intra.peff.net>
References: <20100222110814.GA3247@progeny.tock>
 <20100222112326.GA21929@coredump.intra.peff.net>
 <ca433831002252011r3d3459a2xca7535300cd6630f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Nicolas Pitre <nico@fluxnic.net>,
	Robert Shearman <robertshearman@gmail.com>,
	Ben Walton <bwalton@artsci.utoronto.ca>
To: Mark Lodato <lodatom@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 26 10:37:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nkwd2-0004hD-FG
	for gcvg-git-2@lo.gmane.org; Fri, 26 Feb 2010 10:37:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935767Ab0BZJgi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2010 04:36:38 -0500
Received: from peff.net ([208.65.91.99]:56417 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935764Ab0BZJgg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Feb 2010 04:36:36 -0500
Received: (qmail 30053 invoked by uid 107); 26 Feb 2010 09:36:52 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 26 Feb 2010 04:36:52 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 26 Feb 2010 04:36:33 -0500
Content-Disposition: inline
In-Reply-To: <ca433831002252011r3d3459a2xca7535300cd6630f@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141117>

On Thu, Feb 25, 2010 at 11:11:59PM -0500, Mark Lodato wrote:

> For what it's worth, here are my numbers from running git-fsck on my
> x86-64 machine.  It appears that BLK-SHA1 is slightly faster.  If you
> know a better benchmark to run, let me know.  Perhaps it would be good
> to write some sort of suite to test this, and let people post their
> results to some website.
> 
> make git-fsck
> ./git-fsck  66.75s user 0.28s system 99% cpu 1:07.17 total
> ./git-fsck  66.70s user 1.28s system 99% cpu 1:08.06 total
> ./git-fsck  66.77s user 0.63s system 99% cpu 1:07.42 total
> 
> make BLK_SHA1=1 git-fsck
> ./git-fsck  65.60s user 0.65s system 99% cpu 1:06.26 total
> ./git-fsck  65.39s user 0.65s system 99% cpu 1:06.06 total
> ./git-fsck  65.24s user 1.36s system 100% cpu 1:06.60 total
> 
> Core 2 Duo E6300 1.86 GHz (2MB L2 cache), 2GB memory
> Ubuntu 9.10 x86-64, gcc 4.4.1, git v1.7.0-90-g251a495

Thanks for the numbers. I get the opposite results:

  openssl, ./git-fsck (best of 3):
  62.29user 2.08system 1:04.43elapsed 99%CPU

  blk-sha1, ./git-fsck (best of 3):
  65.57user 1.33system 1:07.19elapsed 99%CPU

So about a 5% slow-down to use blk-sha1. But that is only half the
story. Dropping the openssl link dependency gives:

  stock, make -j4 test (best of 3):
  57.43user 74.60system 1:09.48elapsed 190%CPU

  NO_OPENSSL=TooSlow, make -j4 test (best of 3):
  50.64user 68.74system 1:03.48elapsed 188%CPU

Which is almost a 12% speedup by dropping openssl.

Now, a few qualifiers on what this means.

git-fsck is not a particularly good test of what users experience. They
just don't do it very often. We use it here because it's sha1-heavy. The
other heavy sha1 operation would be "git add" on large files. But it
means we are singling out pure sha1 performance, which is a relatively
small part of what users do.

The "make -j4 test" is also skewed a bit. Notice how we kept the dual
CPUs almost pegged by running a bunch of tests in parallel. In terms of
actual latency to the user, any small git speedup in the couple of git
commands somebody is running may be lost in the noise (e.g., just
invoking perl once destroys any git startup cost). The place that gets
the most benefit is going to be shell scripts which invoke git many
times.

And on top of that, there is the question of where users perceive
slowness. Even a 1000% speedup in the startup code of git may not be
noticeable to me if the different is .002 seconds to .02 seconds. But if
my gigantic "git add" takes 4 seconds instead of 4.5, I might notice it.

So I don't think there is any objective winner. But, I am willing to
assume that:

  1. As many people actually see blk-sha1 _faster_, let's assume my
     numbers for its slowdown are among the worst case (i.e., we do not
     need to do a massive campaign to collect more speed results).

  2. Most people don't care about large "git add" or "fsck". The sha-1
     performance for them falls into the "if it's not .02 instead of .002,
     I don't care" realm.

which argues for dropping openssl as the default.

In other words, the reverse of what I said in my previous message (well,
not the reverse; what I really wanted was for somebody to generate
actual numbers so we could base the decision on data).

-Peff
