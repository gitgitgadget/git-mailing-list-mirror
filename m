From: Jeff King <peff@peff.net>
Subject: Re: Git hangs at =?utf-8?B?4oCcV3JpdGlu?=
 =?utf-8?B?ZyBvYmplY3RzOiAxMSXigJ0=?=
Date: Thu, 24 May 2012 20:51:56 -0400
Message-ID: <20120525005156.GC11300@sigill.intra.peff.net>
References: <EF4D4C5F-2D6B-46F2-B5A4-9DB1BA55BB6B@att.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Timothy Normand Miller <theosib@att.net>
X-From: git-owner@vger.kernel.org Fri May 25 02:52:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXilA-0007j5-Te
	for gcvg-git-2@plane.gmane.org; Fri, 25 May 2012 02:52:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759450Ab2EYAv7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 May 2012 20:51:59 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:54675
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751357Ab2EYAv6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2012 20:51:58 -0400
Received: (qmail 2928 invoked by uid 107); 25 May 2012 00:52:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 24 May 2012 20:52:25 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 May 2012 20:51:56 -0400
Content-Disposition: inline
In-Reply-To: <EF4D4C5F-2D6B-46F2-B5A4-9DB1BA55BB6B@att.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198456>

On Thu, May 24, 2012 at 05:40:41PM -0400, Timothy Normand Miller wrote:

> I've run into a problem that I cannot debug.  I've talked with people
> at length on IRC, I've made ample use of Google.  I'm getting nowhere.
> I'm not even getting any attention on stackexchange (where usually,
> questions are answered with surprising alacrity).  
> 
> This is not the common scenario of Windows and git-daemon that I have
> seen answered elsewhere. This is Linux to Linux, using ssh. On both
> the client and server, git version is 1.7.8.6.

I'd first start with trying to remove as many variables as possible.
Does the problem only happen over ssh, or does it also happen when
pushing across a pipe to a repo on the local machine? If so, does it
also happen during a fetch of the same data?

If you can reproduce it at will (which it sounds like you can), you
could also try some older or newer git versions to see if they work any
better. If you can find a working version, it might be worth trying to
bisect and find the commit that introduces the breakage.

If the problem still exists in the latest version, then I'd start by
stracing as much as possible. On the client side, you can use "strace
-f" to see what all of the processes are doing; you'll probably also
want to pass:

  --receive-pack='strace -f -o foo.out git-receive-pack'

to git-push to ask the remote side to strace. There's a reasonable
chance you'll simply see that the client side is waiting on the server
side for I/O, so you'll want to know what the server side is doing.

I see you posted an strace snippet of a process waiting in select() on
stack overflow. It's hard to tell what's going on from there, though,
because we can't see which processes are which (we see the pids, but we
don't know which programs they're running, or where the commands go). A
full strace log would help a lot (if it's long and you need a place to
post it, try something like https://gist.github.com).

And finally, if the repo is something you can make public, I can try to
reproduce on my machine. That might tell us if the problem is with your
repo, or something else about your machines or setup.

-Peff
