From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Effective difference between git-rebase and git-resolve
Date: Fri, 24 Mar 2006 20:23:04 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0603242014160.15714@g5.osdl.org>
References: <20060325035423.GB31504@buici.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Mar 25 05:23:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FN0J7-0003Wr-NT
	for gcvg-git@gmane.org; Sat, 25 Mar 2006 05:23:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750784AbWCYEXL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Mar 2006 23:23:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750786AbWCYEXL
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Mar 2006 23:23:11 -0500
Received: from smtp.osdl.org ([65.172.181.4]:14222 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750784AbWCYEXJ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Mar 2006 23:23:09 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k2P4N4DZ017039
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 24 Mar 2006 20:23:05 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k2P4N4Zv011571;
	Fri, 24 Mar 2006 20:23:04 -0800
To: Marc Singer <elf@buici.com>
In-Reply-To: <20060325035423.GB31504@buici.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17953>



On Fri, 24 Mar 2006, Marc Singer wrote:
>
> The process I've been using to keep my patches current with the latest
> development is this:
> 
>   git checkout linus && git pull linus
>   git checkout work

You'd be much more efficient if you just did

	git fetch linus

which avoids switching back-and-forth (and speeds up the pull too, since 
it doesn't need to update any working directories).

> When I'm ready to merge,
> 
>   git resolve work linus "Update with head"

No, don't do this.

"git resolve" is the _old_ stupid merger, which isn't very helpful at all. 
So please use

	git merge "Merge with Linus" work linus

instead, which will use the proper "recursive" merge functionality.

> Then, I found git-rebase which seems to be more what I'd like to use
> since it moves my patches along on top of the main development line.
> 
>   git rebase linus
> 
> This time, almost everything merged without a hitch except for the
> thorny file from before.  I edited the file, removing the conflict
> markers, and started a build.  But what I found was that some of the
> changes I'd made were no longer present.

Yeah, "git rebase" is not _nearly_ as intuitive as doing a real merge.

What happened was that you resolved the thorny merge, but the rebase had 
stopped when it hit it, so it never actually did the rest of the rebase. 
Which explains why some of your changes are no longer present: they are 
still in the "rebase queue".

>   1) Am I using rebase correctly?

Yes, but you missed the fact that unlike "git merge", rebasing really is a 
"move one commit at a time" thing, and it stopped on the middle.

>   4) Should I prefer rebase over resolve?

You should never do "resolve", it's very oldfashioned. If you want to 
merge, just use "git merge", which will do the right thing.

As to rebase, it often is very nice, but on the other hand, it leaves 
things in a total mess when it fails, which is a pity. Maybe there's a 
nice way to just continue, but I end up just doing a

	git reset --hard ORIG_HEAD

to undo the failed rebase.

Junio, is there some magic to restart a rebase after you've fixed up the 
conflicts?

		Linus
