From: Jeff King <peff@peff.net>
Subject: Re: Git-Mediawiki : cloning a set of pages
Date: Wed, 8 Jun 2011 11:19:40 -0400
Message-ID: <20110608151940.GD7805@sigill.intra.peff.net>
References: <BANLkTim1hOi0JdWZPR=Vw-S+9jTxqQ-=Tw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Sylvain Boulme <Sylvain.Boulme@imag.fr>,
	"matthieu.moy" <Matthieu.Moy@grenoble-inp.fr>
To: Claire Fousse <claire.fousse@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Wed Jun 08 17:19:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUKXu-0003ai-A3
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 17:19:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756420Ab1FHPTo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 11:19:44 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:37053
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756399Ab1FHPTn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 11:19:43 -0400
Received: (qmail 31067 invoked by uid 107); 8 Jun 2011 15:19:51 -0000
Received: from c-76-21-13-32.hsd1.ca.comcast.net (HELO sigill.intra.peff.net) (76.21.13.32)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 08 Jun 2011 11:19:51 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 08 Jun 2011 11:19:40 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTim1hOi0JdWZPR=Vw-S+9jTxqQ-=Tw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175382>

On Wed, Jun 08, 2011 at 01:19:38PM +0200, Claire Fousse wrote:

> The problem is not the feature in itself but the way you call it.
> Just so you remember, here is the command  to clone the mediawiki :
> git clone mediawiki::http://yourwiki.com
> 
> As it is now, git clone does not implement a way to define a set of pages.
> The 2 solutions we think of are :
> 	* git clone mediawiki::http://yourwiki.com$$page1$$page2 ...
> 	Where $$ is a separator still to be determined. It should not be
> something which could appear in the title of a page.
> 	It is a simple way to proceed but it becomes horrible when you want
> to clone many pages.

Ick, yeah, that is kind of ugly. I think this is a general problem with
the clone and remote helper interface that we are going to need to
solve. It seems like clone should allow transport-specific options to
pass through the command line and make it to the transport.

Something like:

  git clone -c option=value mediawiki::http://...

where the "option" is up to the transport to interpret.  It could be
implemented as a set of in-core options that get passed to the remote
helper over the pipe. But that leaves the helper with probably having to
store the options for future runs.

Maybe it would be even simpler and more flexible to give clone a "-c"
flag that writes specific config variables in the newly-created
repository. Like:

  git clone -c mediawiki.page=page1 \
            -c mediawiki.page=page2 \
            http://...

Then the remote helper can just consult the git config. As a bonus, it
also lets you do things like:

  git clone -c core.ignorecase=true git://...

which is currently awkward (you either have to have set such variable in
your ~/.gitconfig, or you must use init+config+fetch to do a clone
manually.

Getting back to mediawiki, that gives us a slightly nicer syntax, but
we're still specifying each page on the command line (and now it's even
more verbose!). I would think two things could help:

  1. Some kind of globbing, like mediawiki.page="foo_*". The usefulness
     of this will depend on how well pages in the wiki are named,
     though.

  2. Have a config option to point to a file containing page entries,
     one per line.

> 	* write a git-mw-clone script which asks the user to enter a set
> 	of pages  and may store this set of titles in the git config.
> 	This script should then call git-clone which will call the
> 	remote-mediawiki functions.  git-mw-clone would clone the entire
> 	wiki and git-mw-clone --pages would ask the user to enter their
> 	set.  The problem here is that a not git-like command is
> 	required.

Yeah, I like this less because you lose a lot of the seamlessness of the
remote helper solution.

-Peff
