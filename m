From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 3/2] merge-trees script for Linus git
Date: Fri, 15 Apr 2005 23:26:17 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504152256520.7211@ppc970.osdl.org>
References: <Pine.LNX.4.58.0504140201130.7211@ppc970.osdl.org>
 <7vvf6pr4oq.fsf@assigned-by-dhcp.cox.net> <20050414121624.GZ25711@pasky.ji.cz>
 <7vll7lqlbg.fsf@assigned-by-dhcp.cox.net> <20050414193507.GA22699@pasky.ji.cz>
 <7vmzs1osv1.fsf@assigned-by-dhcp.cox.net> <20050414233159.GX22699@pasky.ji.cz>
 <7v7jj4q2j2.fsf@assigned-by-dhcp.cox.net> <20050414223039.GB28082@64m.dyndns.org>
 <7vfyxsmqmk.fsf@assigned-by-dhcp.cox.net> <20050415062807.GA29841@64m.dyndns.org>
 <7vfyxsi9bq.fsf@assigned-by-dhcp.cox.net> <7vaco0i3t9.fsf_-_@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0504151138490.7211@ppc970.osdl.org> <7vmzrzhkd3.fsf@assigned-by-dhcp.cox.net>
 <7vfyxrhfsw.fsf_-_@assigned-by-dhcp.cox.net> <7vmzrzfwe4.fsf_-_@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0504151755590.7211@ppc970.osdl.org> <7v7jj3fjky.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0504152152580.7211@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 16 08:21:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMgg2-0001HR-Tg
	for gcvg-git@gmane.org; Sat, 16 Apr 2005 08:21:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261436AbVDPGYm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Apr 2005 02:24:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262650AbVDPGYl
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Apr 2005 02:24:41 -0400
Received: from fire.osdl.org ([65.172.181.4]:16596 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261436AbVDPGYZ (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 16 Apr 2005 02:24:25 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3G6OJs4018240
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 15 Apr 2005 23:24:20 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3G6OI7w004016;
	Fri, 15 Apr 2005 23:24:19 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <Pine.LNX.4.58.0504152152580.7211@ppc970.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Fri, 15 Apr 2005, Linus Torvalds wrote:
> 
> Actually, it turns out that I have a cunning plan.

Damn, my cunning plan is some good stuff. 

Or maybe it is _so_ cunning that I just confuse even myself. But it looks 
like it is actually working, and that it allows pretty much instantaenous 
merges.

The plan goes like this:

 - each "index" entry has two bits worth of "stage" state. stage 0 is the 
   normal one, and is the only one you'd see in any kind of normal use.

 - however, when you do "read-tree" with multiple trees, the "stage" 
   starts out at 0, but increments for each tree you read. And in 
   particular, the old "-m" flag (which used to be "merge with old state")  
   has a new meaning: it now means "start at stage 1" instead.

 - this means that you can do

	read-tree -m <tree1> <tree2> <tree3>

   and you will end up with an index with all of the <tree1> entries in 
   "stage1", all of the <tree2> entries in "stage2" and all of the <tree3>
   entries in "stage3".

 - furthermore, "read-tree" has this special-case logic that says: if you 
   see a file that matches in all respects in all three states, it 
   "collapses" back to "stage0".

 - write-tree refuses to write a nonsensical tree, so write-tree will 
   complain about unmerged entries if it sees a single entry that is not
   stage 0".

Ok, this all sounds like a collection of totally nonsensical rules, but
it's actually exactly what you want in order to do a fast merge. The 
differnt stages represent the "result tree" (stage 0, aka "merged"), the 
original tree (stage 1, aka "orig"), and the two trees you are trying to 
merge (stage 2 and 3 respectively).

In fact, the way "read-tree" works, it's entirely agnostic about how you
assign the stages, and you could really assign them any which way, and the
above is just a suggested way to do it (except since "write-tree" refuses
to write anything but stage0 entries, it makes sense to always consider
stage 0 to be the "full merge" state).

So what happens? Try it out. Select the original tree, and two trees to 
merge, and look how it works:

 - if a file exists in identical format in all three trees, it will 
   automatically collapse to "merged" state by the new read-tree.

 - a file that has _any_ difference what-so-ever in the three trees will 
   stay as separate entries in the index. It's up to "script policy" to 
   determine how to remove the non-0 stages, and insert a merged version. 
   But since the index is always sorted, they're easy to find: they'll be
   clustered together.

 - the index file saves and restores with all this information, so you can 
   merge things incrementally, but as long as it has entries in stages
   1/2/3 (ie "unmerged entries") you can't write the result.

So now the merge algorithm ends up being really simple:

 - you walk the index in order, and ignore all entries of stage 0, since 
   they've already been done.
 - if you find a "stage1", but no matching "stage2" or "stage3", you know 
   it's been removed from both trees (it only existed in the original 
   tree), and you remove that entry.
 - if you find a matching "stage2" and "stage3" tree, you remove one of 
   them, and turn the other into a "stage0" entry. Remove any matching
   "stage1" entry if it exists too.
  .. all the normal trivial rules ..

NOTE NOTE NOTE! I could make "read-tree" do some of these nontrivial 
merges, but I ended up deciding that only the "matches in all three 
states" thing collapses by default. Why? Because even though there are 
other trivial cases ("matches in both merge trees but not in the original 
one"), those cases might actually be interesting for the merge logic to 
know about, so I thought I'd leave all that information around. I expect 
it to be fairly rare anyway, so writing out a few extra index entries to 
disk so that others can decide to annotate the merge a bit more sounded 
like a fair deal.

I should make "ls-files" have a "-l" format, which shows the index and the 
mode for each file too. Right now it's very hard to see what the contents 
of the index is. But all my tests seem to say that not only does this 
work, it's pretty efficient too. And it's dead _simple_, thanks to having 
all the merge information in just one place, the same index we always use 
anyway.

Btw, it also means that you don't even have to have a separate 
subdirectory for this. All the information literally is in the index file, 
which is a temporary thing anyway. We don't need to worry about what is in 
the working directory, since we'll never show it, and we'll never need to 
use it.

Damn, I'm good.

(On the other hand, it is Friday evening at 11PM, and I'm sitting in front
of the computer. I'm a sad case. I will now go take a beer, and relax. I
think this is another of my "Really Good Ideas" (tm), and is worth the
beer.  This "feels" right).

		Linus
