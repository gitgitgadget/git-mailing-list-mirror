From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git Tutorial?
Date: Fri, 24 Jun 2005 09:37:06 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506240910040.11175@ppc970.osdl.org>
References: <Pine.LNX.4.50.0506231808560.721-100000@monsoon.he.net>
 <Pine.LNX.4.58.0506232344431.11175@ppc970.osdl.org>
 <Pine.LNX.4.50.0506240842090.24799-100000@monsoon.he.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 24 18:29:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dlr39-0007wr-64
	for gcvg-git@gmane.org; Fri, 24 Jun 2005 18:29:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263115AbVFXQf0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Jun 2005 12:35:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263119AbVFXQf0
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Jun 2005 12:35:26 -0400
Received: from smtp.osdl.org ([65.172.181.4]:17035 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S263115AbVFXQfE (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Jun 2005 12:35:04 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j5OGZ1jA014576
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 24 Jun 2005 09:35:01 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j5OGZ0W3031332;
	Fri, 24 Jun 2005 09:35:00 -0700
To: Patrick Mochel <mochel@digitalimplant.org>
In-Reply-To: <Pine.LNX.4.50.0506240842090.24799-100000@monsoon.he.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



[ git-list cc'd, since these example things might be useful to others ]

On Fri, 24 Jun 2005, Patrick Mochel wrote:
> 
> I've been able to make my away around a bit so far. And, as long as
> everything is cached in memory, it's pretty damn fast.

Indeed. It can be slow if things aren't in cache, but even then it's 
usually not really slower than something like CVS would be.

> The handy things I've noticed missing are the equivalents of
> 
> - bk changes -u<user> (Great for tracking down a change one did)

You can script it (and if you do so nicely, feel free to send me a 
patch). Here's the magic long-hand version that does something fairly 
close to it:

	git-rev-list --header HEAD |
		grep -z author.*torvalds |
		tr '\0\n' '\n:' |
		cut -d: -f1 |
		git-diff-tree --pretty --stdin -p |
		less -S

(That's really hacky, because "cut" and other standard unix tools don't 
like using '\0' as a record separator, but hey, whatever works..)

The above gives the result in "git-whatchanged" format, ie you get the
patch too. If you don't want to see the patch, give the "-s" flag to
git-diff-tree instead of the "-p" flag, but if you script it, I'd suggest
allowing the user to give that as an option to the script.

> - bk undo (Good for fixing a quick screw up)

Same deal. No nice script, but it's easy to do:

 - find the top-of-tree you want to go back to. If you know this is the 
   parent of the current HEAD, you can use the git-rev-parse helper:

	target=$(git-rev-parse HEAD^)

   to find that.

 - do a "fast-forward" from the current HEAD to the head you want to go 
   to. Never mind that it's a "fast-backward" in this case, that's 
   symmetrical:

	git-read-tree -m -u HEAD $target &&
		(echo $target > .git/HEAD)

   This magic line just says "merge (-m) while keeping the working 
   directory up-to-date with the changes (-u) from my current position 
   (HEAD) to my new position ($target), and if that worked, write the new 
   position into the HEAD file"

 - If you then want to get _rid_ of the old HEAD stuff (ie you know you 
   don't want to go back to it) you can then follow up with a "git prune", 
   which will prune away all the unreachable objects. Be careful, though, 
   that really _will_ throw it all away, and it's gone, gone, gone. Before 
   you did "git prune", you could still get your old data back by just 
   looking for unconnected commits (git-fsck-cache and git-cat-file will
   help you) and doing the above in reverse.

And that was it. You can make it even nicer when scripting by using 
something like this

	#!/bin/sh

	# get the thing to undo to (default the first parent of the
	# last commit, regardless of whether it was a merge or a
	# regular commit
	# 
	default_target=$(git-rev-parse HEAD^)
	target=$(git-rev-parse --default $default_target --revs-only "$@")

	# Check that it's a valid commit
	git-cat-file commit "$target" > /dev/null || exit 1

	# Do it
	git-read-tree -m -u HEAD $target &&
		(echo $target > .git/HEAD)

and then you can add some fancy flags or whatever.

> - bk export -tpatch -r<rev>

This one is trivial.

	git-diff-tree --pretty $rev

does exactly that: it shows a single revision, with a pretty changelog.

And if you want to get diffs or ranges, use

	git diff rev1..rev2

or similar.

		Linus
