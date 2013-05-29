From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-remote-mediawiki: better error message when HTTP(S)
 access fails
Date: Wed, 29 May 2013 11:22:16 -0400
Message-ID: <20130529152216.GA9072@sigill.intra.peff.net>
References: <1369339503-12426-1-git-send-email-Matthieu.Moy@imag.fr>
 <20130528180727.GB21210@sigill.intra.peff.net>
 <vpqzjvej8p4.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed May 29 17:22:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhiCn-0005vP-Vo
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 17:22:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753393Ab3E2PWV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 May 2013 11:22:21 -0400
Received: from cloud.peff.net ([50.56.180.127]:39849 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751451Ab3E2PWV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 11:22:21 -0400
Received: (qmail 6669 invoked by uid 102); 29 May 2013 15:23:00 -0000
Received: from c-71-62-74-146.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.62.74.146)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 29 May 2013 10:23:00 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 29 May 2013 11:22:16 -0400
Content-Disposition: inline
In-Reply-To: <vpqzjvej8p4.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225834>

On Wed, May 29, 2013 at 02:01:59PM +0200, Matthieu Moy wrote:

> > I wonder if we can do something like:
> >
> >   our $mw_operation;
> >   $mediawiki->{config}->{on_error} = sub {
> > [...]
> >           die "$err\n";
> >   };
> 
> Probably, but that would hardcode the fact that mediawiki errors are
> fatal, while in an ideal world, some errors should be recoverable, and
> some would require some cleanups before die-ing.

Fortunately this is perl, not C. We can catch and re-throw die
exceptions like:

  my $mw_pages = eval { $mediawiki->list(...) };
  if (!$mw_pages) {
    # possibly continue to something else, or even...
    clean_up();
    die; # propagate $@
  }

but it would require checking all of the call-sites. Another alternative
would be a wrapper function that each caller could opt into. But I
suspect the norm will be to die, so the exception model should make the
code cleaner.

> Also, an error during the first mediawiki operation should not
> necessarily have the same diagnosis hint as the others: if I just
> did a successfull querry, and the next fails, it can hardly be an SSL
> certificate error.

Yeah, my error template was just a sketch; I didn't look too carefully
at all of the callers, but the concept should be extensible.

> I'll send a v2 that covers a bit more (at least, push and pull with an
> invalid certificate both give the message).

Thanks.

-Peff
