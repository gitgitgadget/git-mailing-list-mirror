From: Jeff King <peff@peff.net>
Subject: Re: glibc mutex deadlock in signal handler
Date: Fri, 4 Sep 2015 09:04:48 -0400
Message-ID: <20150904130448.GB25501@sigill.intra.peff.net>
References: <s5hfv2vn4wq.wl-tiwai@suse.de>
 <xmqqvbbrjrs9.fsf@gitster.mtv.corp.google.com>
 <s5h7fo7wb3e.wl-tiwai@suse.de>
 <87y4gn5ijr.fsf@igel.home>
 <s5hy4gmvii2.wl-tiwai@suse.de>
 <20150904092355.GA524@sigill.intra.peff.net>
 <s5hzj12jzlu.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Andreas Schwab <schwab@linux-m68k.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
X-From: git-owner@vger.kernel.org Fri Sep 04 15:05:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXqfn-0004zs-Tr
	for gcvg-git-2@plane.gmane.org; Fri, 04 Sep 2015 15:04:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759148AbbIDNEv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Sep 2015 09:04:51 -0400
Received: from cloud.peff.net ([50.56.180.127]:54934 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758812AbbIDNEv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Sep 2015 09:04:51 -0400
Received: (qmail 16580 invoked by uid 102); 4 Sep 2015 13:04:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 04 Sep 2015 08:04:50 -0500
Received: (qmail 21430 invoked by uid 107); 4 Sep 2015 13:04:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 04 Sep 2015 09:04:55 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 04 Sep 2015 09:04:48 -0400
Content-Disposition: inline
In-Reply-To: <s5hzj12jzlu.wl-tiwai@suse.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277304>

On Fri, Sep 04, 2015 at 11:35:57AM +0200, Takashi Iwai wrote:

> > Hmm, is there is any reason to just pass an "in_signal" flag to
> > wait_for_pager(), to avoid duplicating the logic?
> 
> Just because wait_for_pager() itself is an atexit hook that can't take
> an argument, so we'd need to split to a new function.  I don't mind
> either way.  The revised patch is below.

Ah, right. That's unfortunate, but I think I prefer adding the extra
wrapper to duplicating the contents of the function.

> -- 8< --
> From: Takashi Iwai <tiwai@suse.de>
> Subject: [PATCH v2] pager: don't use unsafe functions in signal handlers
> [...]

This looks good to me. Do you plan on fixing any of the other handlers
(you don't have to; I just want to know if somebody is planning to work
on it).

The pattern of atexit and signal handlers is repeated in several places,
and it seems like we will have to add the same in_signal boilerplate in
each instance. I wonder if we should provide a global "register_cleanup"
that takes a "void (*func)(int in_signal))" function pointer, and:

  1. Adds it to a list (ideally in a way that is atomic if we get
     interrupted while adding to the list).

  2. If not already run, registers an atexit() handler and
     sigchain_push_common for a meta-handler which runs through the list
     and runs each handler.

It's not a _huge_ amount of boilerplate code we'd be saving, but at
least conforming to the "in_signal" function template would make people
think twice about what they're doing inside the cleanup function. :)

-Peff
