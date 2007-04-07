From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [RFC] git pull and importers
Date: Sat, 7 Apr 2007 13:24:09 -0700
Message-ID: <20070407202409.GA5107@muzzle>
References: <Pine.LNX.4.64.0704062239420.27922@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sat Apr 07 23:02:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HaHSJ-00087X-A9
	for gcvg-git@gmane.org; Sat, 07 Apr 2007 22:24:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966328AbXDGUYM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Apr 2007 16:24:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966330AbXDGUYM
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Apr 2007 16:24:12 -0400
Received: from hand.yhbt.net ([66.150.188.102]:50033 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966328AbXDGUYL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Apr 2007 16:24:11 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id C25C67DC091;
	Sat,  7 Apr 2007 13:24:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0704062239420.27922@iabervon.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43981>

Daniel Barkalow <barkalow@iabervon.org> wrote:
> There's an SVN project I'm trying to track with git-svn. "git svn fetch" 
> fetches and imports the commits perfectly, but I can't figure out a way to 
> merge upstream commits into my branch automatically.

I don't suggest using merge with git-svn since it can generate
non-linear history.  Non-linear history does not map well to SVN.

"git svn rebase" (in 1.5.1) is handy for getting upstream commits into
your branch (it's a wrapper around "git rebase")

> It seems like the right solution should be:
> 
> [remote "origin"]
> 	importer = svn
> 	url = svn://ixion.tartarus.org/main
> 	fetch = puzzles:refs/remotes/puzzles
> [branch "master"]
> 	remote = origin
> 	merge = puzzles

git-svn in 1.5.1 already allows you to define:

[svn-remote "svn"]
	url = svn://ixion.tartarus.org/main
	fetch = puzzles:refs/remotes/puzzles

And then "git svn rebase" should automatically be able to figure out to
rebase against refs/remotes/puzzles without needing a [branch "master"]
section.

I don't think having the "importer = svn" in [remote "..."] is a good
idea since it would be incompatible with older versions of git and the
documentation would confuse users who don't track the latest version.

> Which would mean that it would use "git svn fetch" instead of "git fetch" 
> for that remote, and "git svn fetch" would use that config section instead 
> of its current config section.

Here's what I'd like git-fetch to do someday[1]:

When git-fetch is called without any remote arguments, it would look for
[remote "origin"] as it does now.  However, if no [remote "..."]
sections are found (as is common with importer-created repos), it would
try other importers: [svn-remote "svn"], (and hopefully one day
[cvs-remote "cvs"], [arch-remote "arch"], ...).

Of course, git-fetch would also be able to handle --svn (and later
--cvs/--arch/...) flags if the [*remote "..."] section names are
ambiguous.

I intentionally named the default svn-remote section "svn" instead of
"origin" for this reason, too; I didn't want to confuse git-fetch.

[1] - patches would be very much welcome (*nudge*nudge*wink*wink),
      I have a lot on my plate and this isn't a high priority.

-- 
Eric Wong
