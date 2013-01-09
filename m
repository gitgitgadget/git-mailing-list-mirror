From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] avoid SIGPIPE warnings for aliases
Date: Wed, 9 Jan 2013 15:51:16 -0500
Message-ID: <20130109205116.GA24605@sigill.intra.peff.net>
References: <20130104124756.GA402@sigill.intra.peff.net>
 <7vr4lu3wx7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Bart Trojanowski <bart@jukie.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 09 21:51:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tt2cp-0003KZ-Ry
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jan 2013 21:51:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934048Ab3AIUvV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jan 2013 15:51:21 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:51144 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933823Ab3AIUvS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2013 15:51:18 -0500
Received: (qmail 1431 invoked by uid 107); 9 Jan 2013 20:52:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 09 Jan 2013 15:52:32 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 09 Jan 2013 15:51:16 -0500
Content-Disposition: inline
In-Reply-To: <7vr4lu3wx7.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213102>

On Wed, Jan 09, 2013 at 12:48:20PM -0800, Junio C Hamano wrote:

> >   $ git lg -p
> >   [user hits 'q' to exit pager]
> >   error: git lgbase --more-options died of signal 13
> >   fatal: While expanding alias 'lg': 'git lgbase --more-options': Success
> >
> > Many users won't see this, because we execute the external
> > command with the shell, and a POSIX shell will silently
> > rewrite the signal-death exit code into 128+signal, and we
> > will treat it like a normal exit code. However, this does
> > not always happen:
> 
> So... with the "flip the sign of the exit code when caught a signal"
> patch applied to 'next', do people still see this issue?

They see half. The patch you've applied clears up the "While
expanding...: Success" message.

But we still say "error: ... died of signal 13", because that comes from
inside wait_or_whine. So it is a separate issue whether or not
wait_or_whine should be silent on SIGPIPE (we already are on SIGINT and
SIGQUIT, as of some recent patches).

The upside is that it is noise in this case that we would no longer see.
The downside is that we may be losing a clue when debugging server
problems, which do not expect to die from SIGPIPE.  Should it be an
optional run-command flag?

-Peff
