From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 1/2] git_connect: set ssh shell command in GIT_SSH_CMD
Date: Sun, 9 Nov 2014 04:51:56 -0500
Message-ID: <20141109095155.GB17369@peff.net>
References: <20141108104439.GA89717@melamine.cuivre.fr.eu.org>
 <20141108110958.GB20750@peff.net>
 <20141108123554.GA90057@melamine.cuivre.fr.eu.org>
 <20141108142753.GA28652@melamine.cuivre.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Thomas Quinot <thomas@quinot.org>
X-From: git-owner@vger.kernel.org Sun Nov 09 10:52:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XnPAB-0003Ea-KF
	for gcvg-git-2@plane.gmane.org; Sun, 09 Nov 2014 10:52:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751655AbaKIJv7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Nov 2014 04:51:59 -0500
Received: from cloud.peff.net ([50.56.180.127]:38222 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751642AbaKIJv6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Nov 2014 04:51:58 -0500
Received: (qmail 27535 invoked by uid 102); 9 Nov 2014 09:51:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 09 Nov 2014 03:51:58 -0600
Received: (qmail 18357 invoked by uid 107); 9 Nov 2014 09:52:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 09 Nov 2014 04:52:07 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 09 Nov 2014 04:51:56 -0500
Content-Disposition: inline
In-Reply-To: <20141108142753.GA28652@melamine.cuivre.fr.eu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 08, 2014 at 03:27:53PM +0100, Thomas Quinot wrote:

> It may be impractical to install a wrapper script for GIT_SSH
> when additional parameters need to be passed. Provide an alternative
> way of specifying a shell command to be run, including command line
> arguments, by means of the GIT_SSH_CMD environment variable, which
> behaves like GIT_SSH but is passed to the shell.

Thanks, I like this much better. The name GIT_SSH_CMD is not too bad.
Personally, of the two (GIT_SSH and GIT_SSH_CMD) I would expect the
"_CMD" form to be the one that does not use the shell. But I do not
really have a better suggestion for the name, so perhaps it's OK.

> Note that with this first patch only, the special processing for PuTTY/plink
> looks at the whole command in that case. I deliberately left it that way,
> even though one might imagine a case where this would cause a false positive,
> e.g. if the user's login name includes the string 'plink':
>    GIT_SSH_CMD="ssh -l fooplink"
> 
> The work-around in this case would be to write:
>    GIT_SSH_CMD="ssh -l foop''link"

I'd be tempted to say that the "plink" magic does not need to kick in at
all for GIT_SSH_CMD. There are simply too many corner cases in trying to
guess what the shell is going to run. For example:

> A second patch, coming in a followup message, pre-splits $GIT_SSH_CMD
> and ensures that we look for "plink"/"tortoiseplink" only in the argv[0]
> element.

I don't think you can pre-split accurately. Since we promise to pass the
result to the shell, the user gets to write whatever they want. Even:

  GIT_SSH_CMD='f() {
    if test "$(hostname)" = "some-machine"; then
      some-special-ssh "$@"
    else
      ssh "$@"
  }
  f'

Parsing complications aside, you cannot even know in git which ssh is
going to be run until the shell code is executed. I think either we have
to leave the responsibility for munging "-p" into "-P" on the side of
the user's shell snippet (and remember that they can still use GIT_SSH
as usual, so we are not making anything _worse_ for them here), or we
have to provide some unambiguous way for them to signal which calling
convention we want ($GIT_SSH_CMD_IS_PLINK or something).

-Peff
