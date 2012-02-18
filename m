From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-send-email: allow overriding smtp-encryption config
 to 'none'
Date: Sat, 18 Feb 2012 01:24:19 -0500
Message-ID: <20120218062418.GA3818@sigill.intra.peff.net>
References: <1329342178-14540-1-git-send-email-computersforpeace@gmail.com>
 <20120215220629.GA17672@sigill.intra.peff.net>
 <CAN8TOE_BnkOcMQRTY-GWrHozYD0+0giWn2LtjB8AVnP_DzA+Sg@mail.gmail.com>
 <20120216004903.GA21170@sigill.intra.peff.net>
 <CAN8TOE-vek=ooq4DRcNF0iCg+rJMt6SUhMi4+_dOWaRJ44KLLA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Brian Norris <computersforpeace@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 18 07:24:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rydic-0005vv-Uk
	for gcvg-git-2@plane.gmane.org; Sat, 18 Feb 2012 07:24:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751836Ab2BRGYV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Feb 2012 01:24:21 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:41373
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751116Ab2BRGYV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Feb 2012 01:24:21 -0500
Received: (qmail 15302 invoked by uid 107); 18 Feb 2012 06:24:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 18 Feb 2012 01:24:20 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 18 Feb 2012 01:24:19 -0500
Content-Disposition: inline
In-Reply-To: <CAN8TOE-vek=ooq4DRcNF0iCg+rJMt6SUhMi4+_dOWaRJ44KLLA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190995>

On Fri, Feb 17, 2012 at 09:27:44PM -0800, Brian Norris wrote:

> > Overriding the smtp user from the config is a separate issue, and I
> > don't think that is currently possible. The usual way to spell an option
> > like that in git is "--no-smtp-user", but it seems that we use perl's
> > GetOptions, which does not understand that syntax. So you'd have to add
> > a "--no-smtp-user" by hand.
> 
> I think the "--no-smtp-user" is what I really wanted. I've written a
> different patch that actually targets the user name properly, but I've
> also found a current solution that can work for scripting purposes:
> just redirect the $GIT_CONFIG environment variable to /dev/null
> temporarily.

Just FYI, the fact that doing so works is somewhat accidental. Long ago,
GIT_CONFIG was respected everywhere as an override to stop reading any
other config. Later, it was dropped, but retained its meaning only for
the git-config command, mostly for historical reasons (although these
days one would do better to use "git config -f $file" instead).

So the reason it works for git-send-email is that send-email in turn
calls git-config to actually look at config values, because send-email
is a perl script and not a C program. In other words, the fact that
GIT_CONFIG is respected is a coincidence of some implementation
decisions, not an intended behavior.

I don't think we have any plans for those implementation details to
change in the near future.  So by all means, use it if you like for the
time being. But know that it's not a behavior which is guaranteed not to
change in future versions.

> Perhaps I'll send my new patch sometime, but it's not pressing and I'm
> not sure what kind of use it would actually get.

I think the ideal case would be a patch that teaches the send-email
option parsing code to understand a "--no-*" counterpart for every
option, without having to modify each option individually. I haven't
looked at how easy or hard that would be, though.

-Peff
