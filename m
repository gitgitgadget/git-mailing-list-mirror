From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: 'git status' is not read-only fs friendly
Date: Sat, 10 Feb 2007 09:37:58 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702100913020.8424@woody.linux-foundation.org>
References: <e5bfff550702091125j202620cfqb2450a3ee69ed421@mail.gmail.com>
 <Pine.LNX.4.63.0702101517360.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <e5bfff550702100631w1b6243e7i44039ceaa8d3fe93@mail.gmail.com>
 <Pine.LNX.4.63.0702101536090.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <e5bfff550702100648p6db5fc67vb5e4a04d40771922@mail.gmail.com>
 <Pine.LNX.4.63.0702101554170.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0702101049480.1757@xanadu.home> <7vr6syj7uw.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0702101131070.1757@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Marco Costalba <mcostalba@gmail.com>,
	GIT list <git@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Sat Feb 10 18:38:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFwBM-00021D-4S
	for gcvg-git@gmane.org; Sat, 10 Feb 2007 18:38:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751439AbXBJRih (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Feb 2007 12:38:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751399AbXBJRih
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Feb 2007 12:38:37 -0500
Received: from smtp.osdl.org ([65.172.181.24]:53081 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751439AbXBJRig (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Feb 2007 12:38:36 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l1AHbxUI019637
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 10 Feb 2007 09:37:59 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l1AHbwW0017813;
	Sat, 10 Feb 2007 09:37:58 -0800
In-Reply-To: <Pine.LNX.4.64.0702101131070.1757@xanadu.home>
X-Spam-Status: No, hits=-0.435 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.116__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39246>



On Sat, 10 Feb 2007, Nicolas Pitre wrote:
> > >
> > > Because git-status itself is conceptually a read-only operation, and 
> > > having it barf on a read-only file system is justifiably a bug.
> > 
> > I do not 100% agree that it is conceptually a read-only operation.
> 
> It is.

It really isn't. 

It's not even a "technical issue". It's a fundamental optimization. Sure, 
you can call optimizations just "technical issues", but the fact is, it's 
one of the things that makes git so _usable_ on large archives. At some 
point, an "optimization" is no longer just about making things slightly 
faster, it's about something much bigger, and has real semantic meaning.

So the fact is, "git status" _needs_ to refresh the index. Because if it 
doesn't, you'll see every file that doesn't match the index as "dirty", 
and that is not just a "technical issue".

And yes, doing an "internal" refresh, like Junio's patch does, hides the 
issue, but it hides it BY MAKING THE OPTIMIZATION POINTLESS!

I suspect Marco is testing some reasonably small git archive. With 
something like git itself, with less than a thousand files (and most of 
them fairly small, so rehashing them all is quick), the optimization may 
_feel_ like just a small technical detail.

Now, try the same thing on the Linux kernel or somethign similar, 
especially with cold caches or not a huge amount of memory.

That "technical issue" is what makes "git status" take less than a second 
for me, and only a bit longer if things aren't cached - because we don't 
actually have to read all the file data. 

Now, it so happens that _if_ things are cached, at least under Linux, 
cached IO is so _incredibly_ fast that you won't even realize how 
expensive an operation you missed. I can SHA1 every file in the kernel 
archive (21432 files right now - 8 million LOC, and 230MB of data) in less 
than a couple of seconds. But that's only because it's all cached for me 
anyway, because I tend to run with lots of RAM, and I do things like "git 
grep so-and-so" which brings it all into cache.

But try the same thing without caches.

Here's something you can do under linux:

	sudo sh -c "echo 3 > /proc/sys/vm/drop_caches"
	git read-tree HEAD
	time git update-index --refresh

and it takes me *40* seconds. That's with quite a fast disk too - it would 
take a whole lot longer on a laptop.

Then, try it _without_ having to actually read all files, because the 
index is already up-to-date:

	sudo sh -c "echo 3 > /proc/sys/vm/drop_caches"
	time git update-index --refresh

and not it took *4* seconds. That's because it didn't actually need to 
read any file data, it could just do the stats.

Then, cached:

	# bring it all in again
	git grep something-or-other

	# invalidate the index cache
	git read-tree HEAD
	time git update-index --refresh

and I can do it under *2* seconds - because Linux is just damn good at 
cached IO, so I can read all those 21-thousand files and 235MB of data 
from the kernel cache in less than a second.

But finally, do it with caches _and_ the index in place:

	time git update-index --refresh

and it now takes 0.06 seconds. It's what allows me to do "git diff" on the 
kernel tree in a tenth of a second.

THIS IS NOT "JUST A TECHNICAL ISSUE". 

When the difference is 40 seconds vs 4 (uncached), or 2 seconds vs 0.06, 
it's not about "just an optimization" any more. At that point, it's about 
"unusable vs usable".

And yeah, waiting 40 seconds for a global "diff" for a big project may be 
something that a person coming from CVS considers to be just par for the 
course. Maybe I'm just unreasonable. But I think it's a _bug_ if I can't 
get a small diff in about a tenth of a second. It needs to be so fast that 
I never even _think_ about it.

And the index is what makes it so. 

And that's why it's important to keep the index up-to-date. If we have 
operations that allow the index to just *stay* non-coherent, like the 
suggested "git runstatus --refresh" that doesn't actually write it back, 
then that's a *bad* thing. 

I think it would be much better if "git status" always wrote the refreshed 
index file. It could then choose to ignore any errors if they happen, 
because if you have a broken setup like the NTFS read-only thing, then 
tough, it's broken, but git can't do anythign about it. But people should 
be aware that yes, "git status" absolutely _needs_ to write the index 
file. 

It is *not* a read-only operation. The index is too important to be 
considered "just a technical issue". 

		Linus
