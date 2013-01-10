From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] avoid SIGPIPE warnings for aliases
Date: Thu, 10 Jan 2013 16:39:37 -0500
Message-ID: <20130110213937.GB26138@sigill.intra.peff.net>
References: <20130104124756.GA402@sigill.intra.peff.net>
 <7vr4lu3wx7.fsf@alter.siamese.dyndns.org>
 <20130109205116.GA24605@sigill.intra.peff.net>
 <7vehhu3u2y.fsf@alter.siamese.dyndns.org>
 <20130110001844.GC21054@google.com>
 <20130110112655.GB21993@sigill.intra.peff.net>
 <7vbocw23fq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Bart Trojanowski <bart@jukie.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 10 22:40:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TtPqy-0006aD-P8
	for gcvg-git-2@plane.gmane.org; Thu, 10 Jan 2013 22:40:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754684Ab3AJVjl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jan 2013 16:39:41 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:54325 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754437Ab3AJVjk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jan 2013 16:39:40 -0500
Received: (qmail 12570 invoked by uid 107); 10 Jan 2013 21:40:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 10 Jan 2013 16:40:55 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 10 Jan 2013 16:39:37 -0500
Content-Disposition: inline
In-Reply-To: <7vbocw23fq.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213155>

On Thu, Jan 10, 2013 at 12:22:49PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Maybe the right rule is "if we are using the shell to execute, do not
> > mention SIGPIPE"? It seems a little iffy at first, but:
> >
> >   1. It tends to coincide with direct use of internal tools versus
> >      external tools.
> >
> >   2. We do not reliably get SIGPIPE there, anyway, since most shells
> >      will convert it into exit code 141 before we see it.
> >
> > I.e., something like:
> 
> Hmph.  That may be a good heuristics, but I wonder if we also want
> to special case WIFEXITED(status) && WEXITSTATUS(status) == 141 to
> pretend as if nothing went wrong, when ignore_sigpipe is in effect?

We could, but I don't see much point. There is very little to gain (because
nobody is complaining about the exit code, only the message), and we
might possibly fail to propagate an error condition (unlikely, but more
serious consequences). To be honest, I am having doubts about touching
it at all. I had to really work to provoke the error without setting
SHELL_PATH=zsh, so I am worried that we are getting worked up over
something that just doesn't happen in practice. And I am not sure that
setting SHELL_PATH=zsh is a sane thing (I only knew about it because
Bart mentioned it he was using zsh).

Bart, do you actually set up SHELL_PATH like that? Is /bin/sh on your
system zsh? If the latter, I wonder if this is actually a bug in zsh.

-Peff
