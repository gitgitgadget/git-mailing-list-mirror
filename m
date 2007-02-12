From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: how to speed up "git log"?
Date: Sun, 11 Feb 2007 20:20:43 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702112009440.8424@woody.linux-foundation.org>
References: <200702111252.28393.bruno@clisp.org>
 <Pine.LNX.4.63.0702111745170.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <200702120041.27419.bruno@clisp.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Bruno Haible <bruno@clisp.org>
X-From: git-owner@vger.kernel.org Mon Feb 12 05:20:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGSgS-0006uJ-0U
	for gcvg-git@gmane.org; Mon, 12 Feb 2007 05:20:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932926AbXBLEUw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Feb 2007 23:20:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932942AbXBLEUw
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Feb 2007 23:20:52 -0500
Received: from smtp.osdl.org ([65.172.181.24]:40586 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932926AbXBLEUw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Feb 2007 23:20:52 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l1C4KiUI025495
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 11 Feb 2007 20:20:44 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l1C4KhDc021975;
	Sun, 11 Feb 2007 20:20:44 -0800
In-Reply-To: <200702120041.27419.bruno@clisp.org>
X-Spam-Status: No, hits=-0.434 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.116__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39358>



On Mon, 12 Feb 2007, Bruno Haible wrote:

> Hello Johannes,
> 
> Thanks for the helpful answer.
> 
> > Yes, because there were only 147 commits which changed the file. But git 
> > looked at all commits to find that.
> 
> Ouch.

This should become a FAQ.

Git simply DOES NOT HAVE per-file history. And having it is actually a 
BUG in other systems.

Not having per-file history is what allows git to do

	git log directory-or-file-set

ratehr than being able to track just one file. You can't do it sanely 
with per-file history (because to tie the per-file histories back 
together in a logical sequence, you need the global history to sort it 
again!)

So:

 - git is "slow" on single-file things, because such things DON'T EVEN 
   EXIST in git!

   When you do "git log <path-limiter>", itreally always ends up being a 
   full git log. 

 - but this is fundamentally what allows you to track multiple directories 
   well. It's what makes things like "gitk drivers/scsi/" actually work, 
   where you really can see the history for a random *collection* of 
   files. Nobody else can do it, afaik, and git just considers a single 
   filename to be a case of the "random collection of files".

The example I gave to corecode was to do

	gitk builtin-rev-list.c
	gitk builtin-rev-parse.c
	gitk builtin-rev-parse.c builtin-rev-list.c

adn realize that doing the history for two files together is NOT AT ALL 
EQUIVALENT to doing the history for those files individually and stitching 
it together.

(The reason the above is a great example is that both of the files alone 
have a very simple linear history, but when you look at the *combined* 
history you actually see concurrent development, and merges: you see 
merge commits that simply don't "exist" when only looking at the history 
of one of them separately).

> Is there some other concept or command that git offers? I'm in the situation
> where I know that 'tr' in coreutils version 5.2.1 had a certain bug and
> version 6.4 does not have the bug, and I want to review all commits that
> are relevant to this. I know that the only changes in tr.c are relevant
> for this, and I'm interested in a display of the minimum amount of relevant
> commit messages. If "git log" is not the right command for this question,
> which command is it?

Do

	git log v5.2.1..v6.4 -- tr.c

(or whatever your tag-names for releases are) where you can limit the log 
generation cost by giving the beginning commit. But yeah, it *will* look 
at the whole history in between, so if there is a long long history 
between v5.2.1 and v6.4, you'll still end up using reasonable amounts of 
CPU.

> > Probably the mmap() problem. Does it go away when you use git 1.5.0-rc4?
> 
> No, it became even worse: git-1.5.0-rc4 is twice as slow as git-1.4.4 for
> this command:
>   git-1.4.4: 25 seconds real time, 24 seconds of CPU time (12 user, 12 system)
>   git-1.5.0: 50 seconds real time, 39 seconds of CPU time (20 user, 19 system)

That's an interesting fact in itself. Do you have the repo available 
somewhere?

Yes, some of the operations can be improved upon by not wasting quite so 
much time uncompressing stuff, so we could at least help this a bit. But 
that's a long-term thing. The slowdown is bad, and that probably has some 
simple explanation.

		Linus
