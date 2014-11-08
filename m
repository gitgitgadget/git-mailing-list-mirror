From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git_connect: allow passing arguments to ssh in
 GIT_SSH_ARGS
Date: Sat, 8 Nov 2014 06:09:58 -0500
Message-ID: <20141108110958.GB20750@peff.net>
References: <20141108104439.GA89717@melamine.cuivre.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Thomas Quinot <thomas@quinot.org>
X-From: git-owner@vger.kernel.org Sat Nov 08 12:10:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xn3uG-0006HG-2p
	for gcvg-git-2@plane.gmane.org; Sat, 08 Nov 2014 12:10:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753600AbaKHLKB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Nov 2014 06:10:01 -0500
Received: from cloud.peff.net ([50.56.180.127]:37944 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753519AbaKHLKA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Nov 2014 06:10:00 -0500
Received: (qmail 3701 invoked by uid 102); 8 Nov 2014 11:10:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 08 Nov 2014 05:10:00 -0600
Received: (qmail 3517 invoked by uid 107); 8 Nov 2014 11:10:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 08 Nov 2014 06:10:08 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 08 Nov 2014 06:09:58 -0500
Content-Disposition: inline
In-Reply-To: <20141108104439.GA89717@melamine.cuivre.fr.eu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 08, 2014 at 11:44:39AM +0100, Thomas Quinot wrote:

> It may be impractical to install a wrapper script for ssh
> when additional parameters need to be passed. Provide an
> alternative way of specifying these by means of the GIT_SSH_ARGS
> environment variable. Arguments are whitespace delimited following
> usual shell conventions; embedded whitespace can be enclosed
> in quotes, or escaped with a backslash.

This has bugged me before, too. Almost every sub-program invoked by git
is done so using a shell, so you can put in arbitrary arguments or even
snippets of shell code. But not GIT_SSH.

I think the original reason was to match other programs with similar
variables. At this point, we can't just change it on a whim; the quoting
requirements are different and it would break people's setups. So your
approach of adding a new variable is good (the other option is figuring
out a long-term transition plan).

However, I'm not sure adding a separate variable for options is the best
we can do. Besides being a bit clunky, it has two big shortcomings:

  1. It's not consistent with other git variables that use the shell
     (e.g., GIT_PAGER).

  2. It's not as flexible as a shell; you can't specify "$HOME/bin/ssh"
     or other even more esoteric things, like dynamically tweaking
     the options based on the environment.

What do you think of adding an alternate variable that is not ssh
_arguments_, but rather just a full shell command for running ssh?
I'm not sure what it could be called (GIT_SSH_SH is probably too
confusing).

> I hope I won't stray too far away from established procedures
> with my first contribution to git. This patch adds support
> for a GIT_SSH_ARGS environment variable, providing a way
> of specifying ssh arguments without having to create a
> wrapper script.

The formatting and whatnot of your submission looks fine to me. The
patch itself looks reasonable, though I didn't look too closely after
making my comments above. :)

-Peff
