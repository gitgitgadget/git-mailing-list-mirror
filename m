From: Jeff King <peff@peff.net>
Subject: Re: t5561 failing after make PROFILE=GEN
Date: Wed, 23 Sep 2015 21:41:35 -0400
Message-ID: <20150924014135.GA6442@sigill.intra.peff.net>
References: <5601E283.2030507@gmx.net>
 <20150923232443.GA21755@sigill.intra.peff.net>
 <56034232.6030100@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Thu Sep 24 03:41:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZevXb-0006Gr-05
	for gcvg-git-2@plane.gmane.org; Thu, 24 Sep 2015 03:41:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932208AbbIXBli (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Sep 2015 21:41:38 -0400
Received: from cloud.peff.net ([50.56.180.127]:35496 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932095AbbIXBlh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Sep 2015 21:41:37 -0400
Received: (qmail 25344 invoked by uid 102); 24 Sep 2015 01:41:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 23 Sep 2015 20:41:37 -0500
Received: (qmail 21759 invoked by uid 107); 24 Sep 2015 01:41:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 23 Sep 2015 21:41:49 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 23 Sep 2015 21:41:35 -0400
Content-Disposition: inline
In-Reply-To: <56034232.6030100@gmx.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278526>

On Thu, Sep 24, 2015 at 02:22:10AM +0200, Stephan Beyer wrote:

> I only checked for profile builds and first tried to bisect the issue,
> which went terribly wrong because using older Git commits (unluckily I
> can't say now how far you should go back in history), the test failed or
> succeeded randomly. So it always found different (and always unrelated)
> commits using "git bisect run".
> However, in the latest versions, it *always* fails for a profile build
> (and *never* for a non-profile build, at least here).
> 
> Maybe this needs some more investigation?

I don't think so. The tests have always been pretty solid, but I think
the profile-build code was broken for a long while.

> Hmm, but why is the profile build of http-backend "slower"? (Or am I
> getting it wrong?)

Remember that there are two phases to the profile build: first we build
with profile-recording on, run the tests, and then build the optimized
version with the output written during the test-run. And it's this first
build that is failing the tests. I don't know exactly how the
profile-recording is implemented, but I imagine that it records counters
as it runs, and then after we call exit() it dumps the counters to a
file.

So the profile-generation version probably _is_ slower overall, but it
is really the pause between exit() and the process actually ending that
is the problem here (because the client thinks we are done and proceeds,
but apache is waiting for the CGI to exit).

> > Touching the apache logfile ourselves is inherently racy.
> 
> It would not be racy if we started/stopped apache before/after each test
> (and only append to the logfile after each apache shutdown). But that
> would slow it down a lot.

True, though that would be really slow (it may also still be racy; I
don't know if Apache would flush out the log if it gets a shutdown
signal or not).

> That's a very good idea. (I just sent a patch with a possible realization.)

Thanks, I'll give it a look.

-Peff
