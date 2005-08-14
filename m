From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: sending changesets from the middle of a git tree
Date: Sat, 13 Aug 2005 22:16:02 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0508132204050.3553@g5.osdl.org>
References: <42FEBC16.9050309@austin.rr.com> <Pine.LNX.4.58.0508132155100.3553@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 14 07:16:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E4Ar2-0003mr-6k
	for gcvg-git@gmane.org; Sun, 14 Aug 2005 07:16:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932456AbVHNFQG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 14 Aug 2005 01:16:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932457AbVHNFQG
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Aug 2005 01:16:06 -0400
Received: from smtp.osdl.org ([65.172.181.4]:11980 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932456AbVHNFQF (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Aug 2005 01:16:05 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j7E5G3jA026469
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 13 Aug 2005 22:16:04 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j7E5G2e2012217;
	Sat, 13 Aug 2005 22:16:03 -0700
To: Steve French <smfrench@austin.rr.com>
In-Reply-To: <Pine.LNX.4.58.0508132155100.3553@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.44__
X-MIMEDefang-Filter: osdl$Revision: 1.114 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sat, 13 Aug 2005, Linus Torvalds wrote:

> That's correct. Same things apply: you can move a patch over, and create a 
> new one with a modified comment, but basically the _old_ commit will be 
> immutable.

Let me clarify.

You can entirely _drop_ old branches, so commits may be immutable, but
nothing forces you to keep them. Of course, when you drop a commit, you'll 
always end up dropping all the commits that depended on it, and if you 
actually got somebody else to pull that commit you can't drop it from 
_their_ repository, but undoing things is not impossible.

For example, let's say that you've made a mess of things: you've committed
three commits "old->a->b->c", and you notice that "a" was broken, but you
want to save "b" and "c". What you can do is

	# Create a branch "broken" that is the current code
	# for reference
	git branch broken

	# Reset the main branch to three parents back: this 
	# effectively undoes the three top commits
	git reset HEAD^^^
	git checkout -f

	# Check the result visually to make sure you know what's
	# going on
	gitk --all

	# Re-apply the two top ones from "broken"
	#
	# First "parent of broken" (aka b):
	git-diff-tree -p broken^ | git-apply --index
	git commit --reedit=broken^

	# Then "top of broken" (aka c):
	git-diff-tree -p broken | git-apply --index
	git commit --reedit=broken

and you've now re-applied (and possibly edited the comments) the two
commits b/c, and commit "a" is basically gone (it still exists in the
"broken" branch, of course).

Finally, check out the end result again:

	# Look at the new commit history
	gitk --all

to see that everything looks sensible.

And then, you can just remove the broken branch if you decide you really 
don't want it:

	# remove 'broken' branch
	rm .git/refs/heads/broken

	# Prune old objects if you're really really sure
	git prune

And yeah, I'm sure there are other ways of doing this. And as usual, the 
above is totally untested, and I just wrote it down in this email, so if 
I've done something wrong, you'll have to figure it out on your own ;)

			Linus
