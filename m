From: Jeff King <peff@peff.net>
Subject: Re: Unstaging during a merge conflict
Date: Wed, 3 Oct 2012 18:01:22 -0400
Message-ID: <20121003220122.GE4484@sigill.intra.peff.net>
References: <CAHUDv6qM37nua2uB6TDOmf1a5L_TUFz=0q=v5W=9MrpEmWoShg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Matt McClellan <mcclellan.mj@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 05 00:01:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJtKm-0001DP-KR
	for gcvg-git-2@plane.gmane.org; Thu, 04 Oct 2012 23:51:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753603Ab2JCWBZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2012 18:01:25 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:39508 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753119Ab2JCWBY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2012 18:01:24 -0400
Received: (qmail 13351 invoked by uid 107); 3 Oct 2012 22:01:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 03 Oct 2012 18:01:55 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Oct 2012 18:01:22 -0400
Content-Disposition: inline
In-Reply-To: <CAHUDv6qM37nua2uB6TDOmf1a5L_TUFz=0q=v5W=9MrpEmWoShg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206951>

On Mon, Oct 01, 2012 at 08:13:21PM -0500, Matt McClellan wrote:

> We had an issue at our organization where changes were reverted when a
> user was merging his local repo with the remote repo changes.  The
> merge conflicted and he unstaged all the changes that were not a
> conflict, he then resolved the conflict and added just the conflicted
> file and committed.  The end result was that he reverted every change
> from his last pull of the remote to his merge point.  The problem I'm
> having how hard it is to see this problem as both git show and git log
> on the merge commit do not show any reverted files.  It was found by
> diffing his commit to each of the parents and seeing the opposite of
> what we expected in the patch output.
> 
> Anybody have ideas how we can prevent these mistakes?  While we are
> going to do more training, a hard stop that wouldn't even let these
> make it to remote would be preferred.

The problem is that from the remote's perspective, it is too late. These
unstaged paths look exactly as if they were simply resolved in favor of
the "ours" side of the merge. The remote does not even see that they had
conflicts, but only that the path from one side was taken over the
other.  If it wanted to be careful, it could recreate the merge and
notice that they did not, but even that will lead to some errors. For
example, resolving another conflict may result in a situation where a
change in another file becomes unwanted and is dropped.

So I think any kind of receive hook to prevent these mistakes from being
propagated is going to run afoul of legitimate cases. You'd do much
better to work on the UI of the resolution workflow to prevent the
mistake from happening in the first place.

> I've done this using git add --interactive then reverting a files
> changes, though the actual crime was done using egit staging tool.  It
> seems the command line won't let you unstage changes but gui tools and
> interactive tools seem to allow it.

You can do "git checkout HEAD <path>" from the command-line. But I would
hope that the results of doing so are sufficiently obvious. Doing
something like "git reset" is much more subtle, but it is reasonably
well-known as a dangerous command, and I hope we are not encouraging it
to new people.

Doing a full revert of a path during merge resolution is probably fishy.
It might make sense for "git add -i" to warn about it (I haven't used
egit's staging tool, but presumably the same thing would apply).

Another place to catch your issue (assuming that an unstaging tool was
used, leaving the modified contents in the working tree) would be to
notice unstaged changes in the working tree when committing a merge.
The problem with forbidding it is that it is also a legitimate thing to
do (e.g., because you carry some local modification to a file that you
do not want to commit), so it is not necessarily indicative of an error.
But in theory you would see a giant list of unstaged changes in the
commit message template. I wonder if that is less obvious when
committing via egit.

-Peff
