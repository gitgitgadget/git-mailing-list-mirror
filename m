From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Remove various dead assignments and dead increments
 found by the clang static analyzer
Date: Sat, 26 Sep 2009 17:36:02 -0400
Message-ID: <20090926213602.GA3756@coredump.intra.peff.net>
References: <87ab0hepcn.fsf@master.homenet>
 <alpine.DEB.1.00.0909261756510.4985@pacific.mpi-cbg.de>
 <871vltefdj.fsf@master.homenet>
 <fabb9a1e0909261134qd90dba1n9637fe4adc253fc1@mail.gmail.com>
 <87ske9cya9.fsf@master.homenet>
 <20090926204604.GA2960@coredump.intra.peff.net>
 <3f4fd2640909261403n78a7e45cm3d2cd48408b5ff52@mail.gmail.com>
 <20090926211220.GA3387@coredump.intra.peff.net>
 <3f4fd2640909261420h2588df4cld8dd3e49f9654e9e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Giuseppe Scrivano <gscrivano@gnu.org>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Reece Dunn <msclrhd@googlemail.com>
X-From: git-owner@vger.kernel.org Sat Sep 26 23:36:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mrew9-0000UE-Mu
	for gcvg-git-2@lo.gmane.org; Sat, 26 Sep 2009 23:36:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753140AbZIZVgE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Sep 2009 17:36:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753090AbZIZVgD
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Sep 2009 17:36:03 -0400
Received: from peff.net ([208.65.91.99]:43513 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753123AbZIZVgB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Sep 2009 17:36:01 -0400
Received: (qmail 17146 invoked by uid 107); 26 Sep 2009 21:39:26 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 26 Sep 2009 17:39:26 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 26 Sep 2009 17:36:02 -0400
Content-Disposition: inline
In-Reply-To: <3f4fd2640909261420h2588df4cld8dd3e49f9654e9e@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129182>

On Sat, Sep 26, 2009 at 10:20:18PM +0100, Reece Dunn wrote:

> > I suspect nobody has cared about this before, though, because the stderr
> > channel for the hook is also directed to the user. So if
> > update-server-info (or whatever) fails, presumably it is complaining to
> > stderr and the user sees that. Adding an additional "by the way, your
> > hook failed" is just going to be noise in most cases.
> 
> It could be used to return an error status from main if it is used in
> a chained command in a script. Other than that, I agree.

I'm not sure that's a good idea. Your push _did_ happen, and the remote
repo was updated. So you have no way of knowing from an error exit code
that changes were in fact made, and it was simply the post-update hook
failing.

Of course, you can argue that the current behavior is similarly broken:
on success, you have no idea if the post-update hook failed or not. But
I would argue that whether the push itself happened is more important
than whether the hook succeeded or not. If you really care, you should
either:

  1. Use some sort of side channel to report hook status.

  2. Use the pre-receive hook, which can abort the push if it wants to.

But all of that is "if we were designing this hook from scratch". At
this point, it doesn't make sense to change the semantics. People may be
relying on the current behavior, and in fact it is documented (in
githooks(5)):

  This hook is meant primarily for notification, and cannot
  affect the outcome of git-receive-pack.

> > There is exactly one caller, and it doesn't care about the return code
> > for the reasons mentioned above.
> 
> Including being called from a script?

I suppose people can be scripting around "git receive-pack" itself,
though I find it pretty unlikely. I find it much more likely for them to
script around "git push", which calls receive-pack on the remote end,
and may or may not get the actual status (without checking, I imagine
the exit code is lost anyway for git:// pushes, but probably passed back
along for pushes over ssh).

At any rate, even if we assume that people are scripting around it, and
that they can in fact see the exit status, I think we would want to keep
it the same for compatibility reasons, as mentioned above.

-Peff
