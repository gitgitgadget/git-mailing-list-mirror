From: Jeff King <peff@peff.net>
Subject: Re: Syntax check via update hook?
Date: Sat, 9 May 2009 10:47:12 -0400
Message-ID: <20090509144711.GA3926@sigill.intra.peff.net>
References: <wsprejtm71.fsf@usg.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Mark Plaksin <happy@usg.edu>
X-From: git-owner@vger.kernel.org Sat May 09 16:47:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2nq3-0006uA-JD
	for gcvg-git-2@gmane.org; Sat, 09 May 2009 16:47:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754546AbZEIOrQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 May 2009 10:47:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754218AbZEIOrP
	(ORCPT <rfc822;git-outgoing>); Sat, 9 May 2009 10:47:15 -0400
Received: from peff.net ([208.65.91.99]:52240 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752621AbZEIOrP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 May 2009 10:47:15 -0400
Received: (qmail 3731 invoked by uid 107); 9 May 2009 14:47:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Sat, 09 May 2009 10:47:33 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 09 May 2009 10:47:12 -0400
Content-Disposition: inline
In-Reply-To: <wsprejtm71.fsf@usg.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118658>

On Fri, May 08, 2009 at 03:43:30PM -0400, Mark Plaksin wrote:

> What's the best way to make the update hook do a syntax check?
> 
> We want to switch our Puppet [1] config repository from SVN to Git.  Our
> SVN repository has a pre-commit hook that does a syntax check.  The hook
> runs Puppet to check the syntax of the file(s) being committed and if the
> check fails, the commit fails.  With SVN that hook runs on the server so
> it's easy to have (the correct version of) the puppet binary there for
> the hook to use.
> 
> Once Puppet config changes are committed to to our SVN repository they
> are automatically pushed into our production Puppet config.  We want to
> do something similar with Git--once commits are successfully pushed to
> the master repository they are automatically pulled and become our
> production Puppet config.

That sounds like a reasonable goal. In the hook itself, you can do one
of:

  1. Look at the diff to the original version to make sure you're not
     introducing anything bogus. This is sufficient for syntax issues on
     single lines, etc, and is obviously pretty efficient. But it won't
     cover "does this whole thing build?" types of checks, which I think
     is what you want.

  2. Check out the whole tree to a temp directory and run your full
     syntax check there. The simplest way would be by using "git
     archive" to generate the tree. You can make this a bit more
     efficient by keeping the temp directory between runs and using
     git to just update the changed files. Off the top of my head, that
     would look something like:

        $ cat <<EOF >.git/hooks/update
        #!/bin/sh
        GIT_INDEX_FILE=/path/to/tempdir/index; export GIT_INDEX_FILE
        cd /path/to/tempdir/tree &&
        mkdir -p tree &&
        git read-tree "$3" &&
        git checkout-index &&
        your_syntax_check
        EOF
        $ chmod +x .git/hooks/update

-Peff
