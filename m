From: Jeff King <peff@peff.net>
Subject: Re: Document clone of clone loosing branches?
Date: Sat, 14 Jun 2008 10:31:17 -0400
Message-ID: <20080614143117.GA8640@sigill.intra.peff.net>
References: <20080614.150548.71104932.hanzl@noel.feld.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Vaclav Hanzl <hanzl@noel.feld.cvut.cz>
X-From: git-owner@vger.kernel.org Sat Jun 14 16:33:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7WoD-0001NF-D3
	for gcvg-git-2@gmane.org; Sat, 14 Jun 2008 16:32:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753622AbYFNObX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Jun 2008 10:31:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754660AbYFNObW
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jun 2008 10:31:22 -0400
Received: from peff.net ([208.65.91.99]:2349 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752928AbYFNObW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jun 2008 10:31:22 -0400
Received: (qmail 10263 invoked by uid 111); 14 Jun 2008 14:31:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Sat, 14 Jun 2008 10:31:19 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 14 Jun 2008 10:31:17 -0400
Content-Disposition: inline
In-Reply-To: <20080614.150548.71104932.hanzl@noel.feld.cvut.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85015>

On Sat, Jun 14, 2008 at 03:05:48PM +0200, Vaclav Hanzl wrote:

> I wander whether man git-clone is correct when it says "creates
> remote-tracking branches for each branch in the cloned repository".
> 
> IMHO remote-tracking branches in the original repository _are_
> branches and they are _not_ cloned (when using git-clone with no
> options) - maybe this is worth noting very explicitly?

The new repository has remote tracking branches of the _regular_
branches that are in the original repository. So the statement is
correct; git-clone creates remote-tracking branches, and it makes one
such branch for each branch in the cloned repository.

Unless you are complaining that it makes one for each non-remote branch
in the cloned repository. But I think it is the general pattern to refer
to things in refs/heads/ as simply unadorned "branch". If you want to
say "all refs, including remote-tracking branches", you would typically
say "refs" (which would also include tags).

> When git newby like me converts a CVS repository, containing just few
> short old branches (stable release bug fixes) and then clones it
> around, with naive belief that clone is a 1:1 copy or something close,
> nasty surprise can happen:

In that sense, clone is a bit of a misnomer, because the two _are_
different. The cloned repo has its origin pointing to the original repo,
and the origin of the original repo (and its associated tracking
branches) are forgotten.

>  - converted repository has those branches, OK
>  - clone of it also has them, but as a remote tracking branches
>  - clone of clone has it as dangling objects only (can go away later)

The clone of clone does not have dangling objects; either it sees a ref
(because it is a branch in the clone) and it grabs the objects, or it
does not see it, in which case it does not download those objects.

> Trying to play it safe, I used git-clone many times while starting
> with git, and I got really nervous when I first discovered that my old
> stable release bug fix branch is not visible in some repositories :-)

Yes, this is sometimes annoying if what you _really_ want is another
clone of the clone's origin. For me, this happens because I want to
clone Junio's git.git (to do some experimentation that might trash the
repo), but:

  - I am too lazy to type Junio's git URL
  - I want the hard-link space-saving of cloning my local repo

So I do something like:

  ref=/path/to/my/git/repo
  git clone --reference $ref `cd $ref && git config remote.origin.url`

which you can easily put in an alias.

-Peff
