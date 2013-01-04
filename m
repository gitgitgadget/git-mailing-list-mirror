From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] avoid SIGPIPE warnings for aliases
Date: Fri, 4 Jan 2013 16:25:34 -0500
Message-ID: <20130104212534.GA2304@sigill.intra.peff.net>
References: <20130104124756.GA402@sigill.intra.peff.net>
 <50E70976.5040001@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Bart Trojanowski <bart@jukie.net>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Fri Jan 04 22:25:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TrEm3-00079p-KQ
	for gcvg-git-2@plane.gmane.org; Fri, 04 Jan 2013 22:25:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755028Ab3ADVZg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jan 2013 16:25:36 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:43171 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754519Ab3ADVZg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jan 2013 16:25:36 -0500
Received: (qmail 20607 invoked by uid 107); 4 Jan 2013 21:26:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 04 Jan 2013 16:26:48 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 04 Jan 2013 16:25:34 -0500
Content-Disposition: inline
In-Reply-To: <50E70976.5040001@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212643>

On Fri, Jan 04, 2013 at 05:55:18PM +0100, Johannes Sixt wrote:

> Am 04.01.2013 13:47, schrieb Jeff King:
> > I have two reservations with this patch:
> > 
> >   1. We are ignoring SIGPIPE all the time. For an alias that is calling
> >      "log", that is fine. But if pack-objects dies on the server side,
> >      seeing that it died from SIGPIPE is useful data, and we are
> >      squelching that. Maybe callers of run-command should have to pass
> >      an "ignore SIGPIPE" flag?
> 
> I am of two minds. On the one hand, losing useful debugging information
> is not something we should do lightly. On the other hand, the message is
> really noise most of the time, even on servers: when pack-objects dies
> on the server side, it is most likely due to a connection that breaks
> (voluntarily or involuntarily) half-way during a transfer, and is
> presumably a frequent event, and as such not worth noting most of the time.

Yeah. I'd mostly be worried about a case where pack-objects prints
nothing (because it dies due to pipe), and then the outer process is not
sufficiently verbose (it just says something like "pack-objects died
abnormally", and the user is left scratching their head. I.e., it _is_
uninteresting, but because we are too silent, the user does not even
know it is uninteresting.

Pack-objects is already careful to check all of its writes. I really
think it would be fine to just ignore SIGPIPE, and then it would produce
a useful error message on EPIPE. The downside is that if we accidentally
have an unchecked call, we won't notice the error (we'll probably notice
it later, but we might continue uselessly spewing data in the meantime).
Perhaps we should catch SIGPIPE in such programs and print an error
message.

> >   2. The die_errno in handle_alias is definitely wrong. Even if we want
> >      to print a message for signal death, showing errno is bogus unless
> >      the return value was -1. But is it the right thing to just pass the
> >      negative value straight to exit()? It works, but it is depending on
> >      the fact that (unsigned char)(ret & 0xff) behaves in a certain way
> >      (i.e., that we are on a twos-complement platform, and -13 becomes
> >      141). That is not strictly portable, but it is probably fine in
> >      practice. I'd worry more about exit() doing something weird on
> >      Windows.
> 
> It did something weird on Windows until we added this line to
> compat/mingw.h:
> 
> #define exit(code) exit((code) & 0xff)

Ah, makes sense. I think that hunk of my patch is probably good, then.

-Peff
