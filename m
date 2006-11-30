X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git and bzr
Date: Thu, 30 Nov 2006 08:45:42 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0611300808570.3513@woody.osdl.org>
References: <45357CC3.4040507@utoronto.ca> <20061021130111.GL75501@over-yonder.net>
 <453F2FF8.2080903@op5.se> <200610251146.06116.jnareb@gmail.com>
 <a7e835d40610250308v5d577482m139742e7fe1db185@mail.gmail.com>
 <87slhcz8zh.wl%cworth@cworth.org> <a7e835d40610260152k658aeaf0hb900cb63870c04e4@mail.gmail.com>
 <7vu01ro20b.fsf@assigned-by-dhcp.cox.net> <a7e835d40610260257r5f05ea4gc934f1c1cc267977@mail.gmail.com>
 <20061026101038.GA13310@coredump.intra.peff.net> <877iyne4dm.fsf@alplog.fr>
 <Pine.LNX.4.64.0610260753090.3962@g5.osdl.org> <456B7C6A.80104@webdrake.net>
 <456ED047.3030102@ableton.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Thu, 30 Nov 2006 16:46:11 +0000 (UTC)
Cc: Joseph Wakeling <joseph.wakeling@webdrake.net>,
	git@vger.kernel.org, bazaar-ng@lists.canonical.com
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <456ED047.3030102@ableton.com>
X-MIMEDefang-Filter: osdl$Revision: 1.161 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32774>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gpp2u-0006dk-Mg for gcvg-git@gmane.org; Thu, 30 Nov
 2006 17:46:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1759262AbWK3Qp5 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 30 Nov 2006
 11:45:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759268AbWK3Qp5
 (ORCPT <rfc822;git-outgoing>); Thu, 30 Nov 2006 11:45:57 -0500
Received: from smtp.osdl.org ([65.172.181.25]:57569 "EHLO smtp.osdl.org") by
 vger.kernel.org with ESMTP id S1759262AbWK3Qp4 (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 30 Nov 2006 11:45:56 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kAUGjijQ028786
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Thu, 30
 Nov 2006 08:45:45 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kAUGjgZm011117; Thu, 30 Nov
 2006 08:45:43 -0800
To: Nicholas Allen <allen@ableton.com>
Sender: git-owner@vger.kernel.org



On Thu, 30 Nov 2006, Nicholas Allen wrote:
>
> Does this mean if I have, for example, a large C++ file with a bunch of
> methods in it and I move one of the methods from the bottom of the file to the
> top and in another branch someone makes a change to that method that when I
> merge their changes git will merge their changes into the method at the top of
> the file where I have moved it?

Right now (and in the near future), nope. "git blame" will track the 
changes (so the pure movement wasn't just an addition of new code, but 
you'll see it track it all the way down to the original), but "git merge" 
is still file-based.

In other words, "git merge" does uses a data similarity analysis that 
could be used for smaller chunks than a whole file, but at least for now 
it does it on a file granularity only (and then passes it off to the 
standard RCS three-way merge on a file-by-file basis).

That said, if the movement happens _within_ a file, then just about any 
SCM could do what you ask for, by just using something smarter than the 
standard 3-way merge. So that part isn't even about tracking data across 
files - it's just about a per-file merge strategy.

The "track data, not files" thing becomes more interesting when you factor 
out a file into two or more files, and can continue to merge across such a 
code re-filing event. Git can do it for "annotate", but doesn't do it for 
anything else.

> If so that would be really quite impressive!

Indeed, and it's one of the potential future goals that was discussed very 
early in the git design phase. The point of _not_ doing file ID tracking 
is exactly that you can actually do better than that by just tracking the 
data.

So some day, we may do it. And not just within one file, but even between 
files. Because file renames really is just a very specific special case of 
data movement, and I don't think it's even the most common case.

That said, there are several reasons why you might not actually _ever_ 
want it in practice, and why I say "potential future goal" and "we may do 
it". I think this is going to be both a matter of not just writing the 
code (which we haven't done), but also deciding if it's really worth it.

Because merges are things where you may not want too much smarts:

 - Quite often, a failed merge that needs manual fixup may even be 
   _preferable_ to a successful merge that did the merge "technically 
   correctly", but in an unexpected way.

 - There's a _big_ difference between "merging code" and "examining code". 
   It makes much more sense to try to track where code came from and what 
   the "deep history" was when you examine code, because the reason you're 
   doing so is generally exactly because you're looking for what went 
   wrong, and who to blame.

   When going "merging", the history of the code is arguably a lot less 
   important. What is the most important part is that the two branches you 
   merge have been (hopefully) verified in their _current_ state. The 
   history may be full of bugs, and they may have been fixed differently, 
   and even trying to be really clever may not actually be a good idea at 
   all.

   Code may have moved or may have been copied, but what is much more 
   important than the original code and where it came from is the state it 
   was in _after_ the move, because that's the tested working state, and 
   in many ways the history of how it came to be really shouldn't matter 
   as much at all.

In other words, "annotate" and "merge" have almost entirely opposite 
interests. An annotation is supposed to find the history in order to maybe 
help find bugs, while a merge is supposed to use the _current_ state, and 
very arguably, if the two current states don't match _so_ obviously that 
there is no question about what you should do, then the merge should make 
that very very very clear to the user.

So my personal opinion has always been that a merge should be extremely 
simpleminded. I think all teh VCS people who concentrate on smart merging 
absolutely have their heads up their arses, and do exactly the wrong 
thing. A merge should not do anything "clever" at all. It should be just 
_barely_ smart enough to do the obvious thing, and even then we all know 
that it will still occasionally do the wrong thing.

So I actually think that a bog-standard and totally stupid three-way merge 
is simply not far from the right thing to do. And the git "recursive" 
thing basically repeats that stupid merge (a) in time (ie the criss-cross 
merge thing causes a recursive three-way merge to take place) and (b) in 
the metadata space (ie you can see the rename following basically as just 
a "3-way merge in filenames").

And yes, this is probably some mental deficiency and hang-up, but I think 
that's sufficient, and that where the real "clever" stuff should be is to 
then help people resolve conflicts (and maybe also help you find 
mis-merges even with the totally stupid and simple merge). Because 
conflicts _will_ happen, regardless of your merge strategy, and you do 
need people to look at them, but you can make it _easier_ for people to 
say "ok, that's obviously the right merge".

So me personally, I'd rather have the "real merge" be what git already 
does, and then have something like a graphical "resolution helper" 
application that tries to resolve the remaining things with user help. And 
that "resolution helper" is where I'd put all the magic code movement 
logic, not in the merge itself.

So you could look at a failed hunk, and press a "show me a best guess" 
button, and at that point the thing would say "that code might fit here, 
does that look sane to you? <Ok>, <Next guess>, <Cancel>".

THAT is what a good VCS should do, in my opinion. Not do "smart merges".

Btw, git doesn't do the above kind of smart graphical thing, but git 
_does_ do something very much in that direction. Unlike a lot of things, 
git doesn't just leave the "conflict marker" turds in the working tree. 
No, the index will contain the three-way merge base and both of the actual 
files you were trying to merge, and a "git diff" will actually show you a 
three-way diff of the working tree (and you can say "git diff --ours" to 
see the diff just against our old head, and "--theirs" to see a regular 
two-way diff against the _other_ side that you tried to merge).

So git already very much embodies this concept of "don't be overly smart 
when merging, but try to help the user out when resolving the merge". It 
may not be pretty GUI etc, and it mostly helps with regular bog-standard 
data conflicts, but boy is it pleasant to use for those once you get used 
to it.

So we get NONE of those horrible "you just get conflict turds, you figure 
it out" things. It gives you the turds (because people, including me, are 
used to them, and you want _something_ in the working tree that shows both 
versions at the same time, of course), but then you can edit them to your 
hearts content, and even _after_ you've edited them, you can do the above 
three-way (or two-way against either branch) diffs, and it will show what 
you edited and its relationship to the two branches you merged.

THAT is what merging is all about. Not smart merges. Stupid merges with 
good tools to help you do the right thing when the right thing isn't _so_ 
obvious that you can just leave it to the machine.

