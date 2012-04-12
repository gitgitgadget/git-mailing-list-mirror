From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v5 2/5] http: handle proxy proactive authentication
Date: Thu, 12 Apr 2012 16:58:36 -0400
Message-ID: <20120412205836.GB21018@sigill.intra.peff.net>
References: <4F5F53CA.7090003@seap.minhap.es>
 <7v398cvb30.fsf@alter.siamese.dyndns.org>
 <7vsjgcs8pq.fsf@alter.siamese.dyndns.org>
 <7vwr5leyj5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>,
	git@vger.kernel.org, sam@vilain.net, spearce@spearce.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 12 22:58:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SIR6K-0003YU-0V
	for gcvg-git-2@plane.gmane.org; Thu, 12 Apr 2012 22:58:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762744Ab2DLU6j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Apr 2012 16:58:39 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:60355
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755582Ab2DLU6i (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Apr 2012 16:58:38 -0400
Received: (qmail 31017 invoked by uid 107); 12 Apr 2012 20:58:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 12 Apr 2012 16:58:44 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 12 Apr 2012 16:58:36 -0400
Content-Disposition: inline
In-Reply-To: <7vwr5leyj5.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195369>

On Thu, Apr 12, 2012 at 08:54:22AM -0700, Junio C Hamano wrote:

> >> I haven't formed an opinion on what the proper solution should be, but
> >> either the credential_from_url() function needs to be updated to accept
> >> the scp style [user@]<host>:<port> argument, or this specific caller
> >> should take the responsibility to do special case the syntax.
> >
> > Well, calling the above "scp" style is a mistake (it is not scp style at
> > all), but the patch to teach the credentail_from_url() to handle the proxy
> > specification may look like this:
> 
> Jeff, do you have an opinion on this?  I briefly wondered if we also want
> to teach the traditional [user@]host:/path/to/repo to this function (it is
> not a URL in RFC1738 sense, but it is in the remote.$name.url sense), but
> because SSH does its own thing interacting with agents, perhaps it may not
> help to teach our credential layer to store and supply cached passphrases
> (or passwords, if the authentication is done by merely sending password
> over the encrypted channel).

My first instinct was "that is not a URL, and should be handled outside
this function". In particular, it has no protocol field, and that is an
important part of the credential-matching process. It would be up to the
caller to supply something sane in the protocol portion. In this case,
it would probably be "http" (unless we want to distinguish http proxies
from http end-points in the credential store, but I doubt that is
useful). But for an ssh-style URL, it would be "ssh". So already the
abstraction is a little bit leaky.

As far as parsing ssh goes, I'm not sure that is unambiguous with the
proxy syntax. If you see "127.0.0.1:1234", is that short for
"http://127.0.0.1:1234/" (what the proxy code wants), or for
"ssh://127.0.0.1/1234" (what ssh code would want)? The former seems less
odd to me, as it really is just a URL missing some components. The
latter is a true alternative syntax.

Like you said, I don't think we will ever want to handle ssh
credentials, though. There is already a solution for people who don't
want to input ssh passwords, and it is much more advanced and
well-supported within the community than what we would provide.

> A safer approach might be to keep externally visible API to this function
> as before, but add another function only for the use of http_proxy and
> friends (whose kosher format is "host:address" without the "<scheme>://"
> part), and call it from the codepath broken by the patch.

I think that would be cleaner conceptually, but it also means
reimplementing the user/password-parsing logic. And given that I don't
think we want to handle ssh, and that the semantics in your patch are
the only sane ones to me, it is not so bad. The caller just needs to be
aware of filling in the "protocol" field. Perhaps we could have an
alternate version that supplies a "default protocol" parameter. The
presence of that parameter would activate this code-path and
automatically fill in the protocol field.

-Peff
