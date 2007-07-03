From: Jeff King <peff@peff.net>
Subject: Re: pushing a project started in git back to a subversion
	repository...
Date: Tue, 3 Jul 2007 00:37:33 -0400
Message-ID: <20070703043733.GC4007@coredump.intra.peff.net>
References: <e2a1d0aa0707021329p29242393ua10817c85ca7422a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Patrick Doyle <wpdster@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 03 06:37:53 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5a98-0000Yw-DA
	for gcvg-git@gmane.org; Tue, 03 Jul 2007 06:37:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751473AbXGCEhh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Jul 2007 00:37:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751062AbXGCEhg
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jul 2007 00:37:36 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4982 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751383AbXGCEhg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2007 00:37:36 -0400
Received: (qmail 26049 invoked from network); 3 Jul 2007 04:37:56 -0000
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 3 Jul 2007 04:37:56 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Jul 2007 00:37:33 -0400
Content-Disposition: inline
In-Reply-To: <e2a1d0aa0707021329p29242393ua10817c85ca7422a@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51453>

On Mon, Jul 02, 2007 at 04:29:11PM -0400, Patrick Doyle wrote:

> Here is what I did:
> 1) packed up the existing git repository with "git-pack-objects"
> [...]
> 2) Used git-rev-list to find the name of first and last commits in my repo.
> [...]
> 3) Cloned the SVN repository, which I had previously created with an
> empty directory into which I wanted to import my new project
> [...]
> 4) unpacked the packfile into the new .git repo
> [...]

That's a bit complex. How about:
  1) clone the svn repository as in your step 3
  2) fetch the old master into a local branch

     git-fetch ../path/to/original master:original

> 5) Created a .git/info/grafts file with the first commit from my old
> .git repo grafted onto the single (empty directory) commit of this new
> repo
>
> $ echo XXX YYY > .git/info/grafts

So you are grafting onto a totally uninteresting commit? That seems like
a hack to base your commits on something that is "in" git-svn. I suspect
there is a way to do it more elegantly, but I've never used git-svn, so
I can't comment.

You could of course now do the graft as:

  echo "`git-rev-parse original` `git-rev-parse master`" >.git/info/grafts

> 6) Here's the scary part -- I overwrote .git/refs/heads/master with
> [...]
> 7) Fetched the files into my empy directory

You could also do this (while on the master branch):

  git reset --hard original

which will set master's sha1 to the same as your "original" branch, and
update the working tree to have all of the files from that commit
(because we used --hard).

At this point you can clean up the original branch:

  git-branch -d original

> **** 2nd question: ****
> How many of you cringed when I said I did this?  If so, why?

I cringed a little. It's actually not all that different than what
git-reset does, but git-reset will do nice things like locking and
putting an entry in the reflog.

> **** Last question: ****
> What happened to all of those objects I imported from the pack file?

They were placed in the second repository's object database.

> I can still see them in the .git/objects/*/* directories, but they
> don't show up in git-ls-revs.  git-fsck doesn't report any errors.

There is no git-ls-revs. Not sure what you mean here. There are no
errors because all of the objects are referenced (by your new master
branch).

> I'm also curious what experts would think of my fumbling efforts to
> transfer this git-managed project into a git/svn-managed project,
> maintaining the initial history.  Did I go tremendously out of my way
> to do something that was a one-line command?

More or less. ;)

Presumably you could take your _existing_ repository, point it at your
svn upstream (look in the .git/config of your svn-cloned repo, and there
is presumably some svn config), and do the dcommit. Unfortunately, I
have the privilege of never having used svn or git-svn, so I can't
comment further.

-Peff
