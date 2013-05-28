From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-remote-mediawiki: better error message when HTTP(S)
 access fails
Date: Tue, 28 May 2013 14:07:27 -0400
Message-ID: <20130528180727.GB21210@sigill.intra.peff.net>
References: <1369339503-12426-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Tue May 28 20:07:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhOJ4-0007t9-Ae
	for gcvg-git-2@plane.gmane.org; Tue, 28 May 2013 20:07:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964945Ab3E1SHa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 May 2013 14:07:30 -0400
Received: from cloud.peff.net ([50.56.180.127]:57894 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964934Ab3E1SHa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 May 2013 14:07:30 -0400
Received: (qmail 9558 invoked by uid 102); 28 May 2013 18:08:09 -0000
Received: from c-71-62-74-146.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.62.74.146)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 28 May 2013 13:08:09 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 May 2013 14:07:27 -0400
Content-Disposition: inline
In-Reply-To: <1369339503-12426-1-git-send-email-Matthieu.Moy@imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225678>

On Thu, May 23, 2013 at 10:05:03PM +0200, Matthieu Moy wrote:

> My use-case is an invalid SSL certificate. Pulling from the wiki with a
> recent version of libwww-perl fails, and git-remote-mediawiki gave no
> clue about the reason. Give the mediawiki API detailed error message, and
> since it is not so informative, hint the user about an invalid SSL
> certificate on https:// urls.

This is definitely an improvement, but it seems like it just the tip of
the iceberg.

The call in get_mw_tracked_categories already uses die() with the MW
error code and detailed string. Good. The call you fix here prints a
guess to stderr and exits 1, and your patch improves that. But the call
in get_mw_first_pages does the same broken thing, and is not fixed.
Ditto for get_all_mediafiles. Other calls do not even seem to error
check the result at all, and assume the result is not undef (which I
suspect would produce a perl runtime error).

I wonder if we can do something like:

  our $mw_operation;
  $mediawiki->{config}->{on_error} = sub {
          my $err = "fatal: ";
          if (defined $mw_operation) {
                  $err .= "unable to $mw_operation: ";
          }
          err .= $mediawiki->{error}->{details};
          die "$err\n";
  };

and then callers do not have to worry about error-checking at all. If
they want a nicer human-readable indication of where the error occured,
they can do:

  local $mw_operation = "get the list of remote wiki pages";
  my $mw_pages = $mediawiki->list(...);

-Peff
