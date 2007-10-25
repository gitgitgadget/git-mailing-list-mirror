From: Theodore Tso <tytso@mit.edu>
Subject: Re: best git practices, was Re: Git User's Survey 2007 unfinished
	summary continued
Date: Thu, 25 Oct 2007 09:24:01 -0400
Message-ID: <20071025132401.GA22103@thunk.org>
References: <20071024203335.GJ29830@fieldses.org> <471FB3D0.4040800@op5.se> <20071024212854.GB6069@xp.machine.xx> <05B279A2-98A3-45F1-9661-AB361F7CAA37@zib.de> <Pine.LNX.4.64.0710242258201.25221@racer.site> <008A7EF9-6F58-47AE-9AA0-B466797F6B1D@zib.de> <Pine.LNX.4.64.0710250021430.25221@racer.site> <47204297.5050109@op5.se> <Pine.LNX.4.64.0710251112390.25221@racer.site> <472070E5.4090303@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Steffen Prohaska <prohaska@zib.de>,
	Peter Baumann <waste.manager@gmx.de>,
	"J. Bruce Fields" <bfields@fieldses.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Federico Mena Quintero <federico@novell.com>,
	git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Thu Oct 25 15:24:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Il2hd-00082y-Fy
	for gcvg-git-2@gmane.org; Thu, 25 Oct 2007 15:24:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753903AbXJYNYg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2007 09:24:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753902AbXJYNYg
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Oct 2007 09:24:36 -0400
Received: from thunk.org ([69.25.196.29]:33628 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753878AbXJYNYf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2007 09:24:35 -0400
Received: from root (helo=closure.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1Il2r9-0002HC-2C; Thu, 25 Oct 2007 09:34:39 -0400
Received: from tytso by closure.thunk.org with local (Exim 4.67)
	(envelope-from <tytso@thunk.org>)
	id 1Il2gr-0006uo-Eo; Thu, 25 Oct 2007 09:24:01 -0400
Content-Disposition: inline
In-Reply-To: <472070E5.4090303@op5.se>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62319>

On Thu, Oct 25, 2007 at 12:33:09PM +0200, Andreas Ericsson wrote:
> Because it's convenient, ofcourse. Don't you have 'maint', 'next'
> and 'master' in your clone of git.git? I'm guessing at least 99% of
> the people on this list have those branches lying around in their
> clones, even if they only ever use 'next' and/or 'master'.

I find it just as easy to say: "git checkout origin/maint" or "git
checkout origin/next" when I want to examine some other branch.

If I want to make a change against maint, then I follow up "git
checkout origin/maint" with a "git checkout -b <topic-name>".  Part of
the reason though, why I *want* to keep the topic branch around is
precisely because I don't get to push to the central repository.  So I
want to keep it around so either (a) the central maintainer can pull
from me, and I delete it only after he's done the pull, or (b) so I
can use git-chery so I can see when patches that I created and sent
via git-format-patch and git-send-email have been accepted.

You're using a diferent workflow, and with users who aren't interested
in learning the fine points of git.  But main issue is that git isn't
optimized for what you want to do.  So I can suggest a couple of
different approaches.  One is to simply do things the 'hg' way.
Explicitly set up different repos for the different branches.  It's
more inefficient, but it does work.  And if the bulk of your users
are, ah, "aggressive ignorant" about git --- and many developers don't
care about learning the fine points of their tools, and a successful
software company needs to learn how to leverage the skills of such
mid-level engineers (only at a startup or if you are at Google can you
insist only only hiring the best and brightest) --- then it might be
that the 'hg' approach is easier.  Certainly that was the approach
Larry McVoy has always used with BitKeeper, and he is focused on
meeting the needs of his corporate customers.

Another would be to set up a wrapper script for "git-clone" that
creates a separate local working directory for each branch.  So for
example, it might do something like this:

#!/bin/sh
# Usage: get-repo <URL> [dir]
URL=$1
dir=$2
branches=`git-ls-remote --heads $URL | sed -e 's;.*/;;'`
if [ "$dir"x = "x" ]; then dir=`basename $URL`; fi
git clone $URL .temp-repo
mkdir $dir
cd $dir
for i in $branches; do
    mkdir $i
    cd $i
    git init
    git remote add -t $i origin $URL
    echo ref: refs/heads/$i > .git/HEAD
    git fetch ../../.temp-repo refs/remotes/origin/$i:refs/remotes/origin/$i
    # do it a second time to get the tags (bug in fetch?)
    git fetch ../../.temp-repo refs/remotes/origin/$i:refs/remotes/origin/$i
    git merge origin/$i
    git config remote.origin.push $i:$i
    cd ..
done
cd ..
rm -rf .temp-repo

For bonus points, this script could be made smarter so that each of
the branches shared a common git object database, and some error
checking would be nice, but hopefully this gets the basic idea across.

This way, the "basic git users" get a separate working directory for
each branch, where "git pull" updates that particular branch, and "git
push" updates changes to the remote branch.  

Does this do what you want?

							- Ted

P.S.  Note by the way that if you are having everyone own access to
push into a single central repository, having a "next" branch probably
doesn't make seense.  You're probably way better off just simply
having "master" (which would be your devel branch), and "maint" for
bug fixes.
