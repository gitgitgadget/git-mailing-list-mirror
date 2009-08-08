From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: git failing to create new branches, depending on the name
Date: Sat, 8 Aug 2009 13:35:47 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0908081312140.2147@iabervon.org>
References: <4A7D9AA7.1030709@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Artur Skawina <art.08.09@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 08 19:35:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZppj-0001gC-8U
	for gcvg-git-2@gmane.org; Sat, 08 Aug 2009 19:35:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752597AbZHHRfr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Aug 2009 13:35:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752553AbZHHRfr
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Aug 2009 13:35:47 -0400
Received: from iabervon.org ([66.92.72.58]:43564 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752516AbZHHRfr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Aug 2009 13:35:47 -0400
Received: (qmail 9955 invoked by uid 1000); 8 Aug 2009 17:35:47 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 8 Aug 2009 17:35:47 -0000
In-Reply-To: <4A7D9AA7.1030709@gmail.com>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125293>

On Sat, 8 Aug 2009, Artur Skawina wrote:

> One of my build scripts, which takes a 'work' git tree, clones it to
> make a build tree, then creates an unique branch there and goes on
> to do the rest of the work, started mysteriously failing recently
> .
> Turns out git doesn't like the branch names that my script is
> choosing and git-checkout fails with a misleading fatal error.
> I don't remember changing the script recently and it used to work
> for months, something must have changed.
> 
> This is what i did while trying to find why the checkout is failing:
> 
> + git --version
> git version 1.6.4
> + rm -rf /tmp/build-tree
> + git clone -l -s -n -o askern --reference /tmp/work-tree /tmp/work-tree /tmp/build-tree
> Initialized empty Git repository in /tmp/build-tree/.git/
> + cd /tmp/build-tree
> + git branch -a | grep g90bc1a6 
> + git checkout -f -b branch-g90bc1a6 askern/release
> fatal: git checkout: branch branch-g90bc1a6 already exists
> # WTF?

Perhaps it shouldn't say "branch branch-g90bc1a6", but...

> + (
> +  cd /tmp/work-tree
> +  git branch -a | grep g90bc1a6
> + )
> # nothing in parent repo either.
> + git checkout -f branch-g90bc1a6 
> Checking out files: 100% (29109/29109), done.

"branch-g90bc1a6" does already exist, in the sense that you can already 
check it out. It's probably a bad idea, from the point of view of having 
your repository make sense, to have a branch whose name is a valid name 
for a different commit (or, in any case, a commit not specified by the 
current value of the branch).

The check was added (restored, actually; it had been lost in the 
conversion to C) in order to prevent people from accidentally making local
branches named things like "origin/master" when there's a remote branch 
named that.

> Note: moving to 'branch-g90bc1a6' which isn't a local branch
> If you want to create a new branch from this checkout, you may do so
> (now or later) by using -b with the checkout command again. Example:
>   git checkout -b <new_branch_name>
> HEAD is now at 90bc1a6... Merge branch 'upstream' of git://ftp.linux-mips.org/pub/scm/upstream-linus
> # so where is coming from?

The official documentaion on specifying revisions is in the man page for 
git-rev-parse (it's referenced for a bunch of places, although this is 
obviously not the first place you'd think to look).

The error message should probably be improved to not imply that what's 
already using that name is a branch.

	-Daniel
*This .sig left intentionally blank*
