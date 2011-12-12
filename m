From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/3] test-terminal: give the child an empty stdin TTY
Date: Mon, 12 Dec 2011 14:16:02 -0500
Message-ID: <20111212191602.GA14061@sigill.intra.peff.net>
References: <b97d14da67bd6097e5b04f6ae3057c0f1d536a0b.1323713230.git.trast@student.ethz.ch>
 <7vfwgp4niu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 12 20:16:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RaBMD-0000v4-AC
	for gcvg-git-2@lo.gmane.org; Mon, 12 Dec 2011 20:16:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753501Ab1LLTQJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Dec 2011 14:16:09 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:48273
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753438Ab1LLTQH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 14:16:07 -0500
Received: (qmail 3545 invoked by uid 107); 12 Dec 2011 19:22:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 12 Dec 2011 14:22:45 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Dec 2011 14:16:02 -0500
Content-Disposition: inline
In-Reply-To: <7vfwgp4niu.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186936>

On Mon, Dec 12, 2011 at 11:07:21AM -0800, Junio C Hamano wrote:

> > Because of the latter, t7006.58ff cause unexpected results if you do:
> >
> >   git rev-list <range> |
> >   while read sha; do
> >     git checkout sha
> >     make test
> >   done
> 
> In the above, lack of dollar-sign in "git checkout $sha" is obvious ;-)
> but I think it is a bug that you are not running make with its stdin
> redirected from /dev/null in the first place.
> 
> Perhaps "make test" should do that for all tests, not just this terminal
> related one? Doing it this way we do not have to worry about other tests
> reading from the standard input by mistake.

That was my thought, as well. We want the test environment to be as
sterile and predictable as possible, so connecting stdin to /dev/null
seems like a sensible thing.

> diff --git a/Makefile b/Makefile
> index ed82320..7a85237 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2239,7 +2239,7 @@ export NO_SVN_TESTS
>  ### Testing rules
>  
>  test: all
> -	$(MAKE) -C t/ all
> +	$(MAKE) -C t/ all </dev/null

Is this right place to do it?

It doesn't catch "cd t && make".  I would expect at the least for it to
happen in t/Makefile. But I actually wonder if it should be in
test-lib.sh, as it is as much about cleaning up the test script's
environment as it is about protecting people running "make test" in a
loop. I.e., something like:

diff --git a/t/test-lib.sh b/t/test-lib.sh
index bdd9513..5a38505 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -198,6 +198,9 @@ else
 	exec 4>/dev/null 3>/dev/null
 fi
 
+exec 6<&0
+exec 0</dev/null
+
 test_failure=0
 test_count=0
 test_fixed=0

One downside of that approach is that it makes it harder to insert
questionable debugging statements into test scripts. E.g., sometimes I
will temporarily throw a "gdb" or even a "bash" invocation into a test
script to investigate a failure. But that would still be possible by
redirecting from "<6".

-Peff
