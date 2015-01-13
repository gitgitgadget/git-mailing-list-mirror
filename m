From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t1050-large: replace dd by test-genrandom
Date: Tue, 13 Jan 2015 16:47:33 -0500
Message-ID: <20150113214733.GA16582@peff.net>
References: <54B5579B.4080607@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Tue Jan 13 22:47:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YB9JM-00007z-Ts
	for gcvg-git-2@plane.gmane.org; Tue, 13 Jan 2015 22:47:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751670AbbAMVrg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jan 2015 16:47:36 -0500
Received: from cloud.peff.net ([50.56.180.127]:34082 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751233AbbAMVrg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jan 2015 16:47:36 -0500
Received: (qmail 18077 invoked by uid 102); 13 Jan 2015 21:47:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 13 Jan 2015 15:47:35 -0600
Received: (qmail 30531 invoked by uid 107); 13 Jan 2015 21:47:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 13 Jan 2015 16:47:56 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 13 Jan 2015 16:47:33 -0500
Content-Disposition: inline
In-Reply-To: <54B5579B.4080607@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262355>

On Tue, Jan 13, 2015 at 06:36:27PM +0100, Johannes Sixt wrote:

> For some unknown reason, the dd on my Windows box segfaults every now
> and than, but since recently, it does so much more often than it used
> to, which makes running the test suite burdensome.
> 
> Get rid of four invocations of dd and use test-genrandom instead.

There are a dozen other uses of dd in the test suite. Do they all need
to go?

> The new code does change some properties of the generated files:
> 
>  - They are a bit smaller.
>  - They are not sparse anymore.
>  - They do not compress well anymore.

This is unfortunate, as it means other platforms will be slower. I
measured a best-of-five on running t1050 going from 0.780s to 1.750s.
That's on an SSD. Doing it on a RAM disk the numbers are 0.600s and
1.394s. Better, but not great.

One second on the test suite probably isn't breaking the bank, but these
sorts of things do add up. I wonder if we can shrink the test size. We
use 2000k files with a 200k core.bigfilethreshold, and a 1500k
GIT_ALLOC_LIMIT.  Skimming through the history, the sizes seem fairly
arbitrary. We can't go _too_ low, or GIT_ALLOC_LIMIT will prevent us
from even allocating heap memory for non-objects.

I tried dropping it by a factor of 10, but sadly that hits several
cases. The commit-slab code wants 512k chunks (which seems like rather a
lot to me), and pack-objects starts at just over 150k for the set of
objects. It would be nice to have a finer-grained tool than
GIT_ALLOC_LIMIT that applied only to objects, but I guess then we would
not be as sure of catching stray code paths (each caller would have to
annotate "this is for an object").

-Peff
