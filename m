From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git fsck messages - what to do about it?
Date: Sun, 18 Sep 2005 14:43:33 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509181435190.9106@g5.osdl.org>
References: <20050916101138.99906352682@atlas.denx.de>
 <Pine.LNX.4.58.0509161114540.26803@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 18 23:45:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EH6wq-00010G-Hh
	for gcvg-git@gmane.org; Sun, 18 Sep 2005 23:43:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932215AbVIRVnj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Sep 2005 17:43:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932216AbVIRVnj
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Sep 2005 17:43:39 -0400
Received: from smtp.osdl.org ([65.172.181.4]:32704 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932215AbVIRVni (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Sep 2005 17:43:38 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8ILhYBo019812
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 18 Sep 2005 14:43:34 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8ILhX0p032068;
	Sun, 18 Sep 2005 14:43:33 -0700
To: Wolfgang Denk <wd@denx.de>
In-Reply-To: <Pine.LNX.4.58.0509161114540.26803@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.115 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8813>



On Fri, 16 Sep 2005, Linus Torvalds wrote:
>
> > b) Is there any way to find out what I did wrong in the first place?
> 
> Well, it probably isn't even an error, but there are nice tools to check 
> it out. For example, you can just list the commits it lists to gitk, and 
> you'll get a nice graphical view of where they are in the tree. That 
> probably makes you go "Duh, yes, I did a 'git reset' to undo those".

Oh, btw, one final note on this problem.

The "--unreachable" flag is meant to show a list of all objects that 
aren't reachable from the refs (either the explicit ones, or the ones 
git-fsck-objects finds on its own). That's very useful for when you 
actually want to remove them, ie "git prune" uses that flag.

However, it's often not very interesting to see the full list of 
unreachable objects, because you are probably _not_ interested in the 
trees that are reachable from the unreachable commit - you're really 
interested in the "tips of unreachability".

And that's what git-fsck-object actually reports _without_ any flags, as 
"dangling" objects. 

So let's say that you have one commit that you've undone.

If you don't give any flags at all, git-fsck-objects will report

	dangling commit ...

but if you use "--unreachable" then you'll get the full list of objects, 
so you'll get

	unreachable tree ...
	unreachable blob ...
	unreachable commit ...
	unreachable blob ...

which is usually _not_ what you want.

Similarly, let's say that you undid a series of three commits. There is 
only one "dangling" commit (the "tip" of the series), but there are three 
unreachable commits (and any number of unreachable trees/blobs associated 
with those commits). Again, what a human tends to be interested in is the 
"dangling tip", not the whole collection of unreachable objects that can 
be reached through that tip.

So using "--unreachable" gives much more raw data, but it usually tends to
hide the real _information_, and the end result is thus much harder to
understand.

			Linus
