From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] send-email: die if CA path doesn't exist
Date: Tue, 24 Nov 2015 14:58:43 -0500
Message-ID: <20151124195842.GA7174@sigill.intra.peff.net>
References: <27f354a4edb166e42006b0c1f778827a3dfd58ac.1447798206.git.john@keeping.me.uk>
 <20151120111848.GC11198@sigill.intra.peff.net>
 <20151120194651.GC21488@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Tue Nov 24 20:58:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a1Jjk-0006S6-KT
	for gcvg-git-2@plane.gmane.org; Tue, 24 Nov 2015 20:58:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753661AbbKXT6q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Nov 2015 14:58:46 -0500
Received: from cloud.peff.net ([50.56.180.127]:33370 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752375AbbKXT6p (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Nov 2015 14:58:45 -0500
Received: (qmail 19103 invoked by uid 102); 24 Nov 2015 19:58:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 24 Nov 2015 13:58:45 -0600
Received: (qmail 17635 invoked by uid 107); 24 Nov 2015 19:58:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 24 Nov 2015 14:58:44 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 24 Nov 2015 14:58:43 -0500
Content-Disposition: inline
In-Reply-To: <20151120194651.GC21488@serenity.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281624>

On Fri, Nov 20, 2015 at 07:46:51PM +0000, John Keeping wrote:

> > For people who know their systems are broken and want to proceed anyway,
> > what is the appropriate work-around? Obviously it involves disabling
> > peer verification, but would we want to include instructions for doing
> > so (either in the error message, or perhaps mentioning it in the commit
> > message)?
> 
> The documentation already says:
> 
> 	Set it to an empty string to disable certificate verification.
> 
> It's a bit lost in the middle of a paragraph but I think that is the
> best place for the detail of how to disable verification.
> 
> Having revisted the patch, I do think the message might be a bit terse,
> but I can't think of a reasonably concise way to point at the
> --smtp-ssl-cert-path argument as being the culprit.

Hrm. I was thinking that somebody might not have any clue that
--smtp-ssl-cert-path exists, and with this patch their setup would
suddenly go from working (well, insecure but passing mail) to broken.
They need to know where to look to find that documentation.

But it looks like this code path only triggers if you have set
smtp-ssl-cert-path to something bogus. So anybody who does so at least
knows about the option.

Which makes me wonder what happens when the cert path isn't defined by
Git. The code says:

        if (!defined $smtp_ssl_cert_path) {
                # use the OpenSSL defaults
                return (SSL_verify_mode => SSL_VERIFY_PEER());
        }

What does OpenSSL do when there is no cert? Hopefully it reports a
verification failure (and in that sense your patch is making our code
consistent with that, which is a good thing).

> Maybe we shouldn't worry too much about that, but should instead put the
> invalid path into the error message:
> 
> 	die "CA path \"$smtp_ssl_cert_path\" does not exist.";

Given what I wrote above, yeah, I'd agree that is sufficient (and I do
think mentioning the path is helpful).

-Peff
