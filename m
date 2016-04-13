From: Jeff King <peff@peff.net>
Subject: Re: credentials are being erased from credential manager via git
 credential-wincred erase command
Date: Wed, 13 Apr 2016 18:00:54 -0400
Message-ID: <20160413220054.GB8712@sigill.intra.peff.net>
References: <58eced84663c4ef38a63811d3367acf2@USNAEXCP1.pc.cognex.com>
 <CAGyf7-FJcJyP_CdRZLO7Eh6DoWp8XRU2CNczCdaYJO_MS6rnmw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "O'Connell, Ken" <Ken.O'Connell@cognex.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Bryan Turner <bturner@atlassian.com>
X-From: git-owner@vger.kernel.org Thu Apr 14 00:01:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqSqM-0004T3-1c
	for gcvg-git-2@plane.gmane.org; Thu, 14 Apr 2016 00:01:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753296AbcDMWA6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Apr 2016 18:00:58 -0400
Received: from cloud.peff.net ([50.56.180.127]:49090 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753151AbcDMWA5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2016 18:00:57 -0400
Received: (qmail 6174 invoked by uid 102); 13 Apr 2016 22:00:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 13 Apr 2016 18:00:56 -0400
Received: (qmail 23033 invoked by uid 107); 13 Apr 2016 22:01:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 13 Apr 2016 18:01:02 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 13 Apr 2016 18:00:54 -0400
Content-Disposition: inline
In-Reply-To: <CAGyf7-FJcJyP_CdRZLO7Eh6DoWp8XRU2CNczCdaYJO_MS6rnmw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291496>

On Wed, Apr 13, 2016 at 01:12:06PM -0600, Bryan Turner wrote:

> From the credentials code in Git (which I could be mis-reading; I'm
> sure others on the list will correct me if I'm wrong), it appears the
> erase is done after a cached credential is rejected by the server.
> That implies that, periodically, authentication with your Stash server
> is failing and that that failed authentication results in Git clearing
> the "bad" credential. That's likely why you see this happen on
> seemingly random builds.

Yes, that's right. For HTTP, Git will erase the credential only for an
HTTP 401 (or a 407 for the proxy credential). So an intermittent failure
shouldn't cause us to erase the credential there.

But it's possible that a server whose credentials are backed by
something more complicated than a password file (e.g., LDAP or
something) may return a 401 intermittently when the backend process
fails (e.g., connection to the LDAP server fails). And I agree with your
second paragraph (that I snipped) that finding the intermittent failure
is the best first step.

We could potentially teach Git _not_ to erase credentials in such a case
(with a config option). But the downside would be that the user would
then have to manually erase and re-populate the credentials if they do
change.

IMHO, that responsibility really lies with the credential helpers
themselves. Helpers like git-credential-wincred are meant to
transparently cache and update credentials. I think for an automated
process like this, what the user really wants is more like "I'll stick
some credentials in a secure place, and I want Git _only_ to access
them, never update them".

You can hack together something like that today with:

  git config credential.helper '!f() {
    case "$1" in
      get|store) git credential-wincred "$@" ;;
    esac
  }; f'

and then you can populate it with:

  echo url=https://example.com |
  git credential fill |
  git credential approve

The "fill" will prompt you and generate the proper response to feed to
"approve", which will actually store it in your helper of choice. Or you
can just do a "fetch" from the repository in question, and it will
happen automatically.

If this pattern is something a lot of people want to use, I think we
could wrap that shell snippet into a "git credential-static" or
something that chained to another helper, and you'd configure it like:

  git config credential.helper 'static wincred'

or something.

-Peff
