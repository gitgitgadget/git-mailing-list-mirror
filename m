From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: cogito - how to drop a commit
Date: Sat, 6 Aug 2005 17:42:14 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0508061727000.3258@g5.osdl.org>
References: <20050806223436.GA6495@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 07 02:43:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E1ZFZ-00086E-Mk
	for gcvg-git@gmane.org; Sun, 07 Aug 2005 02:42:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261387AbVHGAm0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 6 Aug 2005 20:42:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261386AbVHGAm0
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Aug 2005 20:42:26 -0400
Received: from smtp.osdl.org ([65.172.181.4]:44754 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261387AbVHGAmZ (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Aug 2005 20:42:25 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j770gFjA018120
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 6 Aug 2005 17:42:16 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j770gEbt006646;
	Sat, 6 Aug 2005 17:42:15 -0700
To: Sam Ravnborg <sam@ravnborg.org>
In-Reply-To: <20050806223436.GA6495@mars.ravnborg.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.113 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sun, 7 Aug 2005, Sam Ravnborg wrote:
>
> I accidently commited too many files to my tree today, and now I want to
> drop the commit so I have logically separate commits.
> 
> What is the right way to do this - in cogito hopefully.

Not cogito, and this needs to be scripted, but if what you _want_ to do is
undo the commit (in order to re-do it as several commits), here are the
raw git commands necessary (you could make this "git-fix-script", and then
"git fix"  basically does the git equivalent of what "bk fix -C" did)

	# Set up
	#
	. git-sh-setup-script || die "Not a git archive"

	# Figure out the parent.
	#
	parent=$(git-rev-parse --verify HEAD^) || exit

	#
	# Update the index to be at that point in time and make HEAD 
	# point to it, but don't update the working tree contents (ie
	# the changes remain in the working tree, to be re-committed).
	#
	git-read-tree -f -m $parent && echo $parent > .git/HEAD

NOTE! The commit still _exists_, but the HEAD reference to it is now lost.  
If you want to save that as a broken branch, you can precede this with

	git branch broken-branch

which means that the broken point got saved off as "broken-branch".

And if you didn't do that (or if you _did_ do that, and later end up 
deciding to throw that branch away with a

	rm .git/refs/heads/broken-branch

or similar) then you can get rid of the stale and unreachable objects with
a simple "git prune".

Be careful! "git prune" _will_ throw away all the objects that it can't 
find references to. You might want to run "git-fsck-cache --full 
--unreachable" first to get an idea of what it's going to throw away.

			Linus
