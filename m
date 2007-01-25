From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Question about fsck-objects output
Date: Thu, 25 Jan 2007 12:01:06 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0701251144290.25027@woody.linux-foundation.org>
References: <45B8F575.5050106@lightspeed.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Larry Streepy <larry@lightspeed.com>
X-From: git-owner@vger.kernel.org Thu Jan 25 21:01:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAAml-0007Yd-H6
	for gcvg-git@gmane.org; Thu, 25 Jan 2007 21:01:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030536AbXAYUBX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 Jan 2007 15:01:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030537AbXAYUBX
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jan 2007 15:01:23 -0500
Received: from smtp.osdl.org ([65.172.181.24]:51104 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030536AbXAYUBW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jan 2007 15:01:22 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l0PK17gP032678
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 25 Jan 2007 12:01:07 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l0PK16al023910;
	Thu, 25 Jan 2007 12:01:06 -0800
In-Reply-To: <45B8F575.5050106@lightspeed.com>
X-Spam-Status: No, hits=-0.581 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.109__
X-MIMEDefang-Filter: osdl$Revision: 1.172 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37754>


[ Maybe this should be a FAQ answer in some git documentation? Feel free 
  to edit up this email and use it as a base.. ]

On Thu, 25 Jan 2007, Larry Streepy wrote:

> Sorry to ask such a basic question, but I can't quite decipher the output of
> fsck-objects.  When I run it, I get this:
> 
>  git fsck-objects
> dangling commit 2213f6d4dd39ca8baebd0427723723e63208521b
> dangling commit f0d4e00196bd5ee54463e9ea7a0f0e8303da767f
> dangling blob 6a6d0b01b3e96d49a8f2c7addd4ef8c3bd1f5761
> 
> 
> Even after a "repack -a -d" they still exist.  The man page has a short
> explanation, but, at least for me, it wasn't fully enlightening. :-)
> 
> The man page says that dangling commits could be "root" commits, but since my
> repo started as a clone of another repo, I don't see how I could have any root
> commits.  Also, the page doesn't really describe what a dangling blob is.
> 
> So, can someone explain what these artifacts are and if they are a problem
> that I should be worried about?

The most common situation is that you've rebased a branch (or you have 
pulled from somebody else who rebased a branch, like the "pu" branch in 
the git.git archive itself).

What happens is that the old head of the original branch still exists, as 
does obviously everything it pointed to. The branch pointer itself just 
doesn't, since you replaced it with another one.

However, there are certainly other situations too that cause dangling 
objects. For example, the "dangling blob" situation you have tends to be 
because you did a "git add" of a file, but then, before you actually 
committed it and made it part of the bigger picture, you changed something 
else in that file and committed that *updated* thing - the old state that 
you added originally ends up not being pointed to by any commit/tree, so 
it's now a dangling blob object.

Similarly, when the "recursive" merge strategy runs, and finds that there 
are criss-cross merges and thus more than one merge base (which is fairly 
unusual, but it does happen), it will generate one temporary midway tree 
(or possibly even more, if you had lots of criss-crossing merges and 
more than two merge bases) as a temporary internal merge base, and again, 
those are real objects, but the end result will not end up pointing to 
them, so they end up "dangling" in your repository.

Generally, dangling objects aren't anything to worry about. They can even 
be very useful: if you screw something up, the dangling objects can be how 
you recover your old tree (say, you did a rebase, and realized that you 
really didn't want to - you can look at what dangling objects you have, 
and decide to reset your head to some old dangling state).

For commits, the most useful thing to do with dangling objects tends to be 
to do a simple

	gitk <dangling-commit-sha-goes-here> --not --all

which means exactly what it sounds like: it says that you want to see the 
commit history that is described by the dangling commit(s), but you do NOT 
want to see the history that is described by all your branches and tags 
(which are the things you normally reach). That basically shows you in a 
nice way what the danglign commit was (and notice that it might not be 
just one commit: we only report the "tip of the line" as being dangling, 
but there might be a whole deep and complex commit history that has gotten 
dropped - rebasing will do that).

For blobs and trees, you can't do the same, but you can examine them. You 
can just do

	git show <dangling-blob/tree-sha-goes-here>

to show what the contents of the blob were (or, for a tree, basically what 
the "ls" for that directory was), and that may give you some idea of what 
the operation was that left that dangling object.

Usually, dangling blobs and trees aren't very interesting. They're almost 
always the result of either being a half-way mergebase (the blob will 
often even have the conflict markers from a merge in it, if you have had 
conflicting merges that you fixed up by hand), or simply because you 
interrupted a "git fetch" with ^C or something like that, leaving _some_ 
of the new objects in the object database, but just dangling and useless.

Anyway, once you are sure that you're not interested in any dangling 
state, you can just prune all unreachable objects:

	git prune

and they'll be gone. But you should only run "git prune" on a quiescent 
repository - it's kind of like doing a filesystem fsck recovery: you don't 
want to do that while the filesystem is mounted.

(The same is true of "git-fsck-objects" itself, btw - but since 
git-fsck-objects never actually *changes* the repository, it just reports 
on what it found, git-fsck-objects itself is never "dangerous" to run. 
Running it while somebody is actually changing the repository can cause 
confusing and scary messages, but it won't actually do anything bad. In 
contrast, running "git prune" while somebody is actively changing the 
repository is a *BAD* idea).

			Linus
