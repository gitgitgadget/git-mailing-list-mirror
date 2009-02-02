From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] builtin-remote: make rm operation safer in mirrored
	repository
Date: Mon, 2 Feb 2009 08:29:09 -0500
Message-ID: <20090202132909.GD8487@sigio.peff.net>
References: <76718490902010652w7a332550w5e0658a390c7dea9@mail.gmail.com> <1233503309-40144-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 02 14:30:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTysg-0008CB-Gr
	for gcvg-git-2@gmane.org; Mon, 02 Feb 2009 14:30:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751311AbZBBN27 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Feb 2009 08:28:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751188AbZBBN26
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Feb 2009 08:28:58 -0500
Received: from peff.net ([208.65.91.99]:51613 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751050AbZBBN26 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Feb 2009 08:28:58 -0500
Received: (qmail 8642 invoked by uid 1000); 2 Feb 2009 13:29:09 -0000
Content-Disposition: inline
In-Reply-To: <1233503309-40144-1-git-send-email-jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108084>

On Sun, Feb 01, 2009 at 10:48:29AM -0500, Jay Soffian wrote:

> "git remote rm <repo>" is happy to remove non-remote branches (and their
> reflogs). This may be okay if the repository truely is a mirror, but if the
> user had done "git remote add --mirror <repo>" by accident and was just
> undoing their mistake, then they are left in a situation that is difficult to
> recover from.
> 
> After this commit, "git remote rm" skips over non-remote branches and instead
> advises the user on how to remove such branches using "git branch -d", which
> itself has nice safety checks wrt to branch removal lacking from "git remote
> rm".

I think this is sensible. The point of "git remote rm" removing tracking
branches is just to clean up cruft in a repository that has otherwise
interesting stuff. Blowing away a mirror implies getting rid of all
refs. At which point I have to wonder why you would want to do that
versus just removing the repo entirely. I.e., the common use case for
"git remote rm" on a mirror would seem to be "oops, I did this wrong"
and not "I really want to get rid of all my refs".

So I think a safety valve is reasonable.  I wonder if would be simpler
still to just not delete _any_ refs for a mirrored remote. On the other
hand, your safety valve also protects against unusual refspecs that
might touch refs not in refs/remotes (e.g., if I didn't use
remote.foo.mirror, but I had a manually-written refspec that touched
some subset of refs/heads/). In that case, your safety valve makes more
sense.

>  builtin-remote.c |    7 +++++++
>  1 files changed, 7 insertions(+), 0 deletions(-)

Tests?

-Peff
