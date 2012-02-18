From: Jeff King <peff@peff.net>
Subject: Re: SIGPIPE handling (Re: [PATCH v3 0/3])
Date: Sat, 18 Feb 2012 05:24:40 -0500
Message-ID: <20120218102439.GA17263@sigill.intra.peff.net>
References: <7v7gzmxw78.fsf@alter.siamese.dyndns.org>
 <cover.1329472405.git.trast@student.ethz.ch>
 <7v62f5v1d1.fsf@alter.siamese.dyndns.org>
 <7vk43lqbt8.fsf@alter.siamese.dyndns.org>
 <20120218005148.GA1940@sigill.intra.peff.net>
 <7v8vk0r481.fsf@alter.siamese.dyndns.org>
 <20120218085221.GA13922@sigill.intra.peff.net>
 <20120218100517.GA8998@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Jehan Bing <jehan@orb.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 18 11:24:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RyhTL-0000mw-5y
	for gcvg-git-2@plane.gmane.org; Sat, 18 Feb 2012 11:24:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752451Ab2BRKYr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Feb 2012 05:24:47 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:42446
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752310Ab2BRKYq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Feb 2012 05:24:46 -0500
Received: (qmail 17674 invoked by uid 107); 18 Feb 2012 10:24:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 18 Feb 2012 05:24:45 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 18 Feb 2012 05:24:40 -0500
Content-Disposition: inline
In-Reply-To: <20120218100517.GA8998@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191003>

On Sat, Feb 18, 2012 at 04:06:07AM -0600, Jonathan Nieder wrote:

> Jeff King wrote:
> 
> > Less robust than that is to just ignore SIGPIPE in most git programs
> > (which don't benefit from it, and where it is only a liability), but
> > then manually enable it for the few that care
> 
> This seems backwards.  Aren't the only places where it is just a
> liability places where git is writing to a pipe that git has created?

Yes. But the problem is that those spots are buried deep within library
code, and are an implementation detail that the caller shouldn't need to
know about.

But more importantly, I see SIGPIPE as an optimization. The program on
the generating side of a pipe _could_ keep making output and dumping it
nowhere. So the optimization is about telling it early that it can stop
bothering. But that optimization is affecting correctness in some cases.
And in cases of correctness versus optimization, it's nice if we can be
correct by default and then optimize in places where it matters most and
where we've verified that correctness isn't harmed.

I also think it's simply easier to list the places that benefit from
SIGPIPE than those that are harmed by it. But if we wanted to go the
other way (allow by default and turn it off in a few programs), at the
very least all of the network programs (receive-pack.  upload-pack, etc)
should start ignoring it completely.

> We could keep the benefits of SIGPIPE (including simpler error
> handling and lack of distracting EPIPE message) in most code, and only
> switch to SIGPIPE-ignored semantics where the signal has a chance to
> cause harm.  Maybe run_command should automatically ignore SIGPIPE
> when creating a pipe for the launched command's standard input (with a
> flag to ask not to), as a rough heuristic.

That's a reasonable heuristic, but not foolproof. If I have a
long-running subprocess with a pipe, then SIGPIPE will be off for a long
time, meaning the code you thought was protected by it is not. In
practice, I think it would work OK with our current code-base, as we
tend to have short-lived subprocesses. You'd have to special case the
starting of the pager, of course, but that's not too hard.

> There's a subtlety I'm glossing over here, which is that for commands
> that produce a lot of output (think: "git fetch --all"), output may
> still not the primary goal.  I think even they should not block
> SIGPIPE, to follow the principle of least surprise in the following
> interaction:
> 
> 	git fetch --all 2>&1 | less
> 	... one page later, get bored ...
> 	q (to quit)
> 
> Most Unix programs would be killed by SIGPIPE after such a sequence,
> so I would expect git to be, too.

But it's quite non-deterministic whether or when git-fetch will be
killed. It may have written all data to the pipe. You may quit, but
fetch still runs for a while before producing output. If you want it
killed, you are much better off to do so by sending it SIGINT.

-Peff
