X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git and bzr
Date: Tue, 28 Nov 2006 19:51:19 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0611281906520.3395@woody.osdl.org>
References: <45357CC3.4040507@utoronto.ca> <20061021130111.GL75501@over-yonder.net>
 <453F2FF8.2080903@op5.se> <200610251146.06116.jnareb@gmail.com>
 <a7e835d40610250308v5d577482m139742e7fe1db185@mail.gmail.com>
 <87slhcz8zh.wl%cworth@cworth.org> <a7e835d40610260152k658aeaf0hb900cb63870c04e4@mail.gmail.com>
 <7vu01ro20b.fsf@assigned-by-dhcp.cox.net> <a7e835d40610260257r5f05ea4gc934f1c1cc267977@mail.gmail.com>
 <20061026101038.GA13310@coredump.intra.peff.net> <877iyne4dm.fsf@alplog.fr>
 <Pine.LNX.4.64.0610260753090.3962@g5.osdl.org> <456B7C6A.80104@webdrake.net>
 <Pine.LNX.4.64.0611271834090.30076@woody.osdl.org> <456CEF31.8080600@webdrake.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Wed, 29 Nov 2006 03:51:49 +0000 (UTC)
Cc: git@vger.kernel.org, bazaar-ng@lists.canonical.com
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <456CEF31.8080600@webdrake.net>
X-MIMEDefang-Filter: osdl$Revision: 1.161 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32611>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpGTy-0000bK-Am for gcvg-git@gmane.org; Wed, 29 Nov
 2006 04:51:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1757957AbWK2Dv1 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 28 Nov 2006
 22:51:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758042AbWK2Dv1
 (ORCPT <rfc822;git-outgoing>); Tue, 28 Nov 2006 22:51:27 -0500
Received: from smtp.osdl.org ([65.172.181.25]:206 "EHLO smtp.osdl.org") by
 vger.kernel.org with ESMTP id S1757957AbWK2Dv1 (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 28 Nov 2006 22:51:27 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kAT3pLix009895
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Tue, 28
 Nov 2006 19:51:22 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kAT3pJe7006540; Tue, 28 Nov
 2006 19:51:19 -0800
To: Joseph Wakeling <joseph.wakeling@webdrake.net>
Sender: git-owner@vger.kernel.org



On Wed, 29 Nov 2006, Joseph Wakeling wrote:
> 
> So ... if I understand correctly, I can get patches from somewhere else,
> but in the branch history, I will not be able to tell the difference
> from having simply newly created them?

Think of it this way: if the _patch_ looks like it's a code movement, then 
"git blame" will show it as a code movement. Ie, if the patch (to a human) 
looks like it's moving a function from one file into another (which in a 
patch will obviously be a question of removing it from one file, and 
adding it to another), then git will also see it that way, and then "git 
blame" will also follow its history as it moved.

But if somebody sends you a patch that just adds a new function that 
didn't exist in that context at all, then "git blame" won't ever realize 
that that new function was taken from another branch entirely.

> With regards to git blame/pickaxe/annotate, the idea of tracking *code*
> rather than files was one thing that really excited me when I read about
> it in the earlier discussion, and is probably the main reason I'm trying
> out git.  I'd like to understand this properly so is there a simple
> exercise I can do to demonstrate its capabilities?  I tried an
> experiment where I created one file with two lines, then cut one of the
> lines, pasted it into a new file, and committed both changes at the same
> time.  But git blame -C on the second file just gives me the
> time/date/sha1 of its creation, and no indication that the line was
> taken from elsewhere.

Actually, I think you found a bug.

Now, with small changes, "git blame -C" will just ignore copies entirely, 
so your particular test might not have even been supposed to work, but 
trying with a new git repo with two bigger files checked in at the initial 
commit, I'm actually not seeing "git blame -C" do the right thing even for 
real code movement.

And the problem seems to go to the "root commit": if the file existed in 
the root, the logic in "git blame" to diff against the (nonexistent) 
parent of the root commit won't do the right thing, and that just confuses 
git blame entirely.

I think Junio screwed up at some point. I'll send him a bug-report once 
I've triaged this a bit more, but I can recreate your breakage if I start 
a new git database and create two files in the root, and move data between 
them in the second commit (but if I instead create the second file in the 
second commit, and do the movement in the third commit, git blame -C works 
again ;).

> Back to the more basic queries ... one more difference I've observed
> from bzr, after playing around for a while, involves the commands to
> undo changes and commits.  It looks like git reset combines the
> capabilities of both bzr uncommit and bzr revert: I can undo changes
> since the last commit by resetting to HEAD, and I can undo commits by
> resetting to HEAD^ or earlier.

I'm not quite sure what "bzr revert" does. Git does have a "revert" too, 
but it will append a _new_ commit that actually undoes the commit you're 
asking to revert. If you want to just "undo history" (whether it's one 
commit or many - I don't see why it would be different) then yes, "git 
reset" is the thing to use.

I _suspect_ that bzr people use "uncommit" to undo a commit in order to 
fix it up. In git, you could do that with "git reset" and a new commit, 
but the normal thing to do is just to fix it up, and then do 

	git commit --amend

instead (which amends the last commit to include whatever fixups you did).

> Some things here I'm not quite sure about:
> (1) the difference between git reset --soft and git reset --mixed,
> probably because I don't understand the way the index works, the
> difference between changed, updated and committed.

You'd generally not want to use "--soft" unless you know what the index 
really is. Once you do know about all the index issues, you'll know why 
it's different from "--mixed", but in general, no normal person would ever 
use _either_ --soft (because not changing the index is too confusing if 
you don't know about it) or --mixed (because it's the default).

So in reality, you should use

	git reset

to reset everything but the actual working tree (and it will talk about 
the files that no longer match the state you are resetting _to_, if any 
such files exist), or

	git reset --hard

to reset everything.

Any other usage is strictly for hardcore people only, and if you don't 
know you want to use it, you shouldn't even consider it.

In fact, I'm pretty hardcore, and I don't think I've ever really used 
"--soft". It's largely been replaced by "git commit --amend", because 
amending a commit used to be the only reason to use "--soft", really.

So it might even be worthwhile just dropping "--soft" and "--mixed" 
altogether, but in the meantime, you might as well just ignore them.

> (2) How to remove changes made to an individual file since the last commit.

"git checkout file"


> Last, could someone explain the git merge command?

I argued that we should never teach people to use it at all (because "git 
pull" really does everything it can do), but people on the git list said 
people are used to merging, so it exists, and these days the syntax is 
more usable than it used to be.

> git pull seems to do many things which I would need to use bzr merge 
> for---I can "pull" between branches which have diverged, for example.  
> I don't understand quite what git merge does that's different, and when 
> to use one or the other.

Heh. I'm with you. I'm in the "don't use 'git merge' at all" camp, but it 
was argued that people coming from non-git backgrounds would find it 
too confusing to just use "git pull" for merging ;)

