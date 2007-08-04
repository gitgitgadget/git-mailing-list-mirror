From: Theodore Tso <tytso@mit.edu>
Subject: Re: Terminology question about remote branches.
Date: Sat, 4 Aug 2007 18:56:55 -0400
Message-ID: <20070804225655.GD11150@thunk.org>
References: <854pjfin68.fsf@lola.goethe.zz> <20070804120243.GB9716@coredump.intra.peff.net> <85tzrfh3yg.fsf@lola.goethe.zz> <8c5c35580708040607ya186edcg89fbc90587b64d68@mail.gmail.com> <85r6mjdyl8.fsf@lola.goethe.zz> <Pine.LNX.4.64.0708041804260.13596@beast.quantumfyre.co.uk> <85hcnfdvtr.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Julian Phillips <julian@quantumfyre.co.uk>,
	Lars Hjemli <lh@elementstorage.no>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Sun Aug 05 00:57:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHSYt-0000tB-5a
	for gcvg-git@gmane.org; Sun, 05 Aug 2007 00:57:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932997AbXHDW5L (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Aug 2007 18:57:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932993AbXHDW5K
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Aug 2007 18:57:10 -0400
Received: from thunk.org ([69.25.196.29]:57365 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932170AbXHDW5I (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Aug 2007 18:57:08 -0400
Received: from root (helo=tinytim.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1IHSgr-0003Le-Dp; Sat, 04 Aug 2007 19:05:46 -0400
Received: from tytso by tinytim.thunk.org with local (Exim 4.63)
	(envelope-from <tytso@thunk.org>)
	id 1IHSYJ-0003av-S3; Sat, 04 Aug 2007 18:56:55 -0400
Content-Disposition: inline
In-Reply-To: <85hcnfdvtr.fsf@lola.goethe.zz>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54918>

On Sat, Aug 04, 2007 at 08:00:00PM +0200, David Kastrup wrote:
> 
> I think I am going to cry.  So I need to rebase my branches, pull out
> the resulting patch sets, scrap my repository, clone it new from
> upstream, reapply my branches, in order to have a system where the
> documentation is somewhat in synch with the actual behavior?

... or you can you use "git remote" to create the remote tracking
branches.  The important thing to realize is that 99% of what "git
remote" does is purely by editing the config file.  (The last 1% is
running "git fetch" if you specify the -f option.)  So understanding
what gets placed in the .git/config file after doing an initial clone
from a URL for a pre-1.5 git and what gets placed in .git/config file
and how the branches are set up post 1.5 is key to understanding what
is going on.

> No, it would seem that I can just
> git-clone -l
> my repository and be set up in the new order of things.  Nice.

Be careful, not really.  A git-clone -l will set up a new repository
where origin/master is your original repository, i.e.:

[remote "origin"]
        url = /usr/projects/e2fsprogs/base
        fetch = +refs/heads/*:refs/remotes/origin/*
[branch "master"]
        remote = origin
        merge = refs/heads/master

In contrast, if you had done a git-clone of remote repository, you
might see something like this instead:

[remote "origin"]
        url = git://git.kernel.org/pub/scm/fs/ext2/e2fsprogs.git
        fetch = +refs/heads/*:refs/remotes/origin/*
[branch "master"]
        remote = origin
        merge = refs/heads/master

In contrast, if you are using git 1.4, after a clone, "origin" and
"master" are by default set to the "master" branch in the source
repository, and in git 1.4 (and in git 1.5 if you don't have any of
the above configuration opions in your .git/config file), the "origin"
branch is magical and works like the remote tracking branch of
origin/master of git 1.5 for the purposes of "git fetch", and then the
implied merge done by "git pull" merges from "origin" branch to the
"master" branch.

> However, it would appear from my experiments up to now that the
> --track option _can't_ be made to work with a 1.4 repository.  I think
> that is worth mentioning in the docs.

Well, there really is no such thing as a "1.4 repository".  The only
real difference is the default configuration which is dropped into the
.config file when you do a "git clone", and whether the head of the
master branch created after the "git clone" is called "origin", with
some magic special casing so that works like a remote tracking branch
of the remote repo's master branch, or whether it is called
"origin/master", with explicit configuration rules in .git/config.

The real issue is that a "1.4 repository" (that is a repository
created by "git clone" from git 1.4 and where the config file hasn't
been updated either by hand-editing the config file or by use of "git
config" or "git remote" to have remote branches) doesn't have any
remote branches, and git branch -track only has significance if you
are creating a new (local) branch from a remote tracking branch.

Regards,

						- Ted
