From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] avoid SIGPIPE warnings for aliases
Date: Thu, 10 Jan 2013 05:49:30 -0500
Message-ID: <20130110104930.GA21993@sigill.intra.peff.net>
References: <20130104124756.GA402@sigill.intra.peff.net>
 <7vr4lu3wx7.fsf@alter.siamese.dyndns.org>
 <20130109205116.GA24605@sigill.intra.peff.net>
 <7vehhu3u2y.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Bart Trojanowski <bart@jukie.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 10 11:50:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TtFhy-0003Ag-3q
	for gcvg-git-2@plane.gmane.org; Thu, 10 Jan 2013 11:50:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753470Ab3AJKtm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jan 2013 05:49:42 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:53390 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751796Ab3AJKtl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jan 2013 05:49:41 -0500
Received: (qmail 6421 invoked by uid 107); 10 Jan 2013 10:50:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 10 Jan 2013 05:50:55 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 10 Jan 2013 05:49:30 -0500
Content-Disposition: inline
In-Reply-To: <7vehhu3u2y.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213132>

On Wed, Jan 09, 2013 at 01:49:41PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > But we still say "error: ... died of signal 13", because that comes from
> > inside wait_or_whine. So it is a separate issue whether or not
> > wait_or_whine should be silent on SIGPIPE (we already are on SIGINT and
> > SIGQUIT, as of some recent patches).
> >
> > The upside is that it is noise in this case that we would no longer see.
> > The downside is that we may be losing a clue when debugging server
> > problems, which do not expect to die from SIGPIPE.  Should it be an
> > optional run-command flag?
> 
> Do we know if we are upstream of a pager that reads from us through
> a pipe (I think we should, especially in a case where we are the one
> who processed the "git -p $alias" option)?  Is there any other case
> where we would want to ignore child's death by SIGPIPE?  If the
> answers are yes and no, then perhaps we can ask pager_in_use() to
> decide this?

The answer to the first is unfortunately no. Consider an alias like
"[alias]foo = !git log" (which yes, you could implement as just "log",
but there are cases where you want to manipulate the environment and we
do not allow it).

Your process tree for running "git foo" looks like:

  git foo               (A)
    git log             (B)
      less              (C)

The user hits 'q', which kills process C. Process B then dies due to
SIGPIPE, and process A sees that the alias command died due to a signal.
But process A has no clue that a pager is in effect; only process B,
which spawned the pager, can know that. So A cannot see death-by-SIGPIPE
and make a decision on whether a pager was in use.

If anything, it is process B's responsibility to say "Oops, I was killed
by SIGPIPE. But that's OK, it's not a big deal to me". Which it could do
by installing a SIGPIPE handler that just calls exit(0).

-Peff
