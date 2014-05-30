From: Jeff King <peff@peff.net>
Subject: Re: [RFC PATCH] git log: support "auto" decorations
Date: Thu, 29 May 2014 21:58:55 -0400
Message-ID: <20140530015855.GG28683@sigill.intra.peff.net>
References: <alpine.LFD.2.11.1405291523520.8270@i7.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri May 30 03:59:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WqC61-0003pv-7O
	for gcvg-git-2@plane.gmane.org; Fri, 30 May 2014 03:59:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754150AbaE3B65 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 May 2014 21:58:57 -0400
Received: from cloud.peff.net ([50.56.180.127]:33858 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751538AbaE3B65 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 May 2014 21:58:57 -0400
Received: (qmail 3010 invoked by uid 102); 30 May 2014 01:58:57 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 29 May 2014 20:58:57 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 29 May 2014 21:58:55 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.11.1405291523520.8270@i7.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250428>

On Thu, May 29, 2014 at 03:31:58PM -0700, Linus Torvalds wrote:

> From: Linus Torvalds <torvalds@linux-foundation.org>
> Date: Thu, 29 May 2014 15:19:40 -0700
> Subject: [RFC PATCH] git log: support "auto" decorations

I will spare you the usual lecture on having these lines in the message
body. ;)

> I actually like seeing decorations by default, but I do *not* think our 
> current "log.decorate" options make sense, since they will change any 
> random use of "git log" to have decorations. I much prefer the 
> "ui.color=auto" behavior that we have for coloration. This is a trivial 
> patch that tries to approximate that.

Yeah, I think this makes a lot of sense. I do use log.decorate=true, and
it is usually not a big deal. However, I think I have run into
annoyances once or twice when piping it. I'd probably use
log.decorate=auto if we had it.

> It's marked with RFC because
> 
>  (a) that "isatty(1) || pager_in_use()" test is kind of hacky, maybe we 
>      would be better off sharing something with the auto-coloration?

The magic for this is in color.c, want_color() and check_auto_color().

The color code checks "pager_use_color" when the pager is in use, but I
do not think that makes any sense here.  It also checks that $TERM is
not "dumb", but that also does not make sense here.

So I think your check is fine. It would be nice to share with the color
code, but I doubt it will end up any more readable, because of
conditionally dealing with those two differences.

>  (b) I also think it would be nice to have the equivalent for 
>      "--show-signature", but there we don't have any preexisting config 
>      file option.

Potentially yes, though there is a real performance impact for "log
--show-signature" if you actually have a lot of signatures. Even on
linux.git, a full "git log" is 15s with --show-signature, and 5s
without. Maybe that is acceptable for interactive use (and certainly it
is not a reason to make it an _option_, if somebody wants to turn it
on).

>  (c) maybe somebody would like a way to combine "auto" and "full", 
>      although personally that doesn't seem to strike me as all that useful 
>      (would you really want to see the full refname when not scripting it)

Yeah, "full/short" is really orthogonal to "true/false/auto". If we were
starting from scratch, I think putting "full/short" into
log.decorateStyle would make more sense, but it is probably not worth
changing now. I agree that "full auto" is probably not something useful,
and we can live without it.

-Peff
