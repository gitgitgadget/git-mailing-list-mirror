From: Jeff King <peff@peff.net>
Subject: Re: git alias always chdir to top
Date: Thu, 4 Dec 2008 07:34:02 -0500
Message-ID: <20081204123402.GA23740@coredump.intra.peff.net>
References: <20081203160852.GA3773@osc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Thu Dec 04 13:35:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L8DQV-0001yy-5K
	for gcvg-git-2@gmane.org; Thu, 04 Dec 2008 13:35:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751999AbYLDMeJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2008 07:34:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751993AbYLDMeH
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Dec 2008 07:34:07 -0500
Received: from peff.net ([208.65.91.99]:4247 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751903AbYLDMeG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Dec 2008 07:34:06 -0500
Received: (qmail 31700 invoked by uid 111); 4 Dec 2008 12:34:04 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 04 Dec 2008 07:34:04 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 04 Dec 2008 07:34:02 -0500
Content-Disposition: inline
In-Reply-To: <20081203160852.GA3773@osc.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102338>

On Wed, Dec 03, 2008 at 11:08:52AM -0500, Pete Wyckoff wrote:

> It looks like handle_alias() uses setup_git_directory_gently() to
> find the .git, which chdir()s up until it gets there.  Is there a
> way to do this without changing the process current working
> directory instead?  I could even handle an environment variable
> saving the original cwd, but that's ickier.

There has been some discussion of refactoring the setup to _not_ do that
chdir until later, which should fix your problem. And other problems,
too, since aliases can get confused about whether or not we're in a
worktree (try "git config alias.st status && cd .git && git st") as a
result of the startup sequence.  Ideally the _only_ thing to happen
before running an alias would be to look at the config to see how to run
the alias, and everything else would be "as if" you had just run the
alias manually.

So no, there's no way to do it correctly right now. The git commands
internally do know the original prefix, but I don't think it is exposed
via the environment.

I hope this will get fixed eventually, but refactoring this code is
unpleasant enough and I have been busy enough that it hasn't happened
yet. You are of course welcome to volunteer. ;)

-Peff
