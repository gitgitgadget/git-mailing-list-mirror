From: Jeff King <peff@peff.net>
Subject: Re: "prune" prone to clock skew (Re: t3306 failure with v1.7.5-rc1)
Date: Fri, 8 Apr 2011 12:30:22 -0400
Message-ID: <20110408163021.GB32709@sigill.intra.peff.net>
References: <4D9ECF7C.6010709@drmicha.warpmail.net>
 <4D9EB406.5080302@viscovery.net>
 <4D9EB57D.1060402@drmicha.warpmail.net>
 <4D9EBC41.4080501@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Apr 08 18:30:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q8EZv-0008JD-U1
	for gcvg-git-2@lo.gmane.org; Fri, 08 Apr 2011 18:30:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757589Ab1DHQab (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Apr 2011 12:30:31 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:50067
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757586Ab1DHQaa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Apr 2011 12:30:30 -0400
Received: (qmail 1346 invoked by uid 107); 8 Apr 2011 16:31:17 -0000
Received: from 205.158.58.41.ptr.us.xo.net (HELO sigill.intra.peff.net) (205.158.58.41)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 08 Apr 2011 12:31:17 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 08 Apr 2011 12:30:22 -0400
Content-Disposition: inline
In-Reply-To: <4D9EBC41.4080501@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171134>

On Fri, Apr 08, 2011 at 09:41:53AM +0200, Michael J Gruber wrote:

> EXPLANATION:
> 
> I guess "prune" looks at some file time stamps (rather than parsing the
> commit time proper) so that it is prone to the same client/server clock
> skew problems when the repo is not on the local file system.

Of course. Remember that prune is removing all sorts of objects, not
just commits. In the case of a tree or blob, we have nothing else to go
on besides the filesystem timestamp.

> PROBLEM (?):
> 
> I really hope this does not go both ways - imagine a messed server
> turning it's clock a few weeks back by accident, and running "git prune"
> on the client, or a messed client turning the clock forward... Do we do
> proper checks before removing something?

I don't think anybody has ever cared. These things are, after all,
unreferenced by either current refs or the reflog. I think the purpose
of the 2-week grace period is more to prevent prune from deleting
objects from an in-progress operation before that operation has had a
chance to write its refs.

So one problem scenario is that the prune on the machine with the bad
clock would delete objects from something like a push in progress.

But I think it's just so unlikely to happen that your repo is on a
remote server, _and_ the client and server clocks are skewed by more
than two weeks, _and_ you're running prune, _and_ somebody is pushing
into the repo simultaneously, that nobody has really bothered to try to
do better.

Note that if you access the same repo over a filesystem share by two
clients with different clocks, you can also expire reflog entries
prematurely. But that is a 90-day window.

So I don't know that it's worth fixing, nor do I know what your "proper
checks" would be. We could open up commits we're about to prune and
check their timestamps for age. That wouldn't help blobs and trees. For
them, we could make a guess as to their age by seeing if they're
connected to any dangling commits, and using the commit timestamp. But
that will only cover some objects, and it is also still vulnerable to
certain types of clock skew (though it is more robust, since you would
need a client and server with one type writing the objects, and then
another skewed client doing the prune, which is even less likely).

-Peff
