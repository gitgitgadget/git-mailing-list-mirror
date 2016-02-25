From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] run-command: fix an 'different modifiers' sparse warning
Date: Thu, 25 Feb 2016 16:39:35 -0500
Message-ID: <20160225213935.GA3612@sigill.intra.peff.net>
References: <56CF576B.4020401@ramsayjones.plus.com>
 <xmqqfuwgo83n.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 25 22:39:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZ3dP-0001Gc-7n
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 22:39:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751494AbcBYVjj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 16:39:39 -0500
Received: from cloud.peff.net ([50.56.180.127]:49403 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750763AbcBYVji (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2016 16:39:38 -0500
Received: (qmail 26015 invoked by uid 102); 25 Feb 2016 21:39:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 25 Feb 2016 16:39:37 -0500
Received: (qmail 25305 invoked by uid 107); 25 Feb 2016 21:39:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 25 Feb 2016 16:39:46 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 25 Feb 2016 16:39:35 -0500
Content-Disposition: inline
In-Reply-To: <xmqqfuwgo83n.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287441>

On Thu, Feb 25, 2016 at 12:20:12PM -0800, Junio C Hamano wrote:

> Ramsay Jones <ramsay@ramsayjones.plus.com> writes:
> 
> > Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> > ---
> >
> > Hi Jeff,
> >
> > If you need to re-roll your 'jk/epipe-in-async' branch, could you
> > please squash this into the relevant patch. (ie. "write_or_die:
> > handle EPIPE in async threads", 24-02-2016).
> >
> > Thanks!
> 
> I actually was planning to merge this to 'next' today, so I'll
> squash it in without waiting for a reroll.

I am OK with that. But I do find it interesting that we must mark
NORETURN in both the declaration and the definition, but we don't for
__attribute__((format)).

> By the way, doesn't it bother anybody to give two different types to
> the same function depending on NO_PTHREAD?  It is not a new issue
> added by this series, but async_exit() that claims to return int
> does not (naturally) return anything, and sparse does not seem to
> care (neither do we).

It would have bothered me if I had noticed. :)

It is simply a bug, and sparse (and the compiler) do not notice it
because it only shows up if you compile with NO_PTHREADS=1. And I think
it is added by this series:

> > @@ -675,7 +675,7 @@ int in_async(void)
> >  	return process_is_async;
> >  }
> >  
> > -int async_exit(int code)
> > +int NORETURN async_exit(int code)

The return value on this one should be "void", too, of course.

-Peff
