From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Make tests independent of global config files
Date: Wed, 6 Feb 2008 03:38:17 -0500
Message-ID: <20080206083817.GA19710@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Feb 06 09:38:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMfnw-0004Eb-67
	for gcvg-git-2@gmane.org; Wed, 06 Feb 2008 09:38:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759277AbYBFIiU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2008 03:38:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759247AbYBFIiU
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Feb 2008 03:38:20 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2704 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758482AbYBFIiT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2008 03:38:19 -0500
Received: (qmail 27145 invoked by uid 111); 6 Feb 2008 08:38:18 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 06 Feb 2008 03:38:18 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 06 Feb 2008 03:38:17 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72771>

On Thu, Feb 15, 2007 at 11:43:56AM +0100, Johannes Schindelin wrote:

> This was done by setting $HOME to somewhere bogus. A better method is
> to reuse $GIT_CONFIG, which was invented for ignoring the global
> config file explicitely.
> 
> Technically, setting GIT_CONFIG=.git/config could be wrong, but it
> passes all the tests, and we can keep the tests that way.

[Yes, this is a reply to an ancient message, but your "could be wrong"
turned out to be true.]

I ran across a bug in the test suite today, and it is caused by this
change. The problem is that setting GIT_CONFIG=.git/config means that if
we change directories, then we may silently fail to read the config
file. Oops.

In particular, this is covering up an incorrect test in t1500. One of
the things it does is more or less this:

  cd .git && git rev-parse --is-bare-repository

and expects it to say "true". The test passes. All fine and dandy,
except that it _isn't_ a bare repository, and if you run the test by
hand, it returns "false."

The problem is that it's looking for .git/.git/config and doesn't find
it, meaning that it never sees the "core.bare = false" setting, and
makes a guess from its location inside the git dir.

We could set GIT_CONFIG=$(pwd)/.git/config, but then that fails if the
test creates other repos.

We could go back to setting HOME to something bogus, but then we have no
way to suppress the reading of /etc/gitconfig (the only way to do so, I
think, is to set GIT_CONFIG).

So I think we are stuck adding in some environment magic to suppress the
reading of ETC_GITCONFIG, and doing something like:

unset GIT_CONFIG
GIT_ETC_CONFIG=$(pwd)/.git/nonexistant
GIT_LOCAL_CONFIG=$(pwd)/.git/nonexistant

Thoughts?

-Peff
