X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Thoughts about memory requirements in traversals [Was: Re: [RFC]
 Submodules in GIT]
Date: Sat, 2 Dec 2006 18:25:29 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0612021814530.3476@woody.osdl.org>
References: <20061130170625.GH18810@admingilde.org>
 <Pine.LNX.4.64.0612021242080.3476@woody.osdl.org>
 <Pine.LNX.4.64.0612021252380.3476@woody.osdl.org> <200612030307.26429.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Sun, 3 Dec 2006 02:25:57 +0000 (UTC)
Cc: Martin Waitz <tali@admingilde.org>, sf <sf-gmane@stephan-feder.de>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <200612030307.26429.Josef.Weidendorfer@gmx.de>
X-MIMEDefang-Filter: osdl$Revision: 1.161 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33086>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gqh38-0001f4-93 for gcvg-git@gmane.org; Sun, 03 Dec
 2006 03:25:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1424733AbWLCCZr (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 2 Dec 2006
 21:25:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759616AbWLCCZr
 (ORCPT <rfc822;git-outgoing>); Sat, 2 Dec 2006 21:25:47 -0500
Received: from smtp.osdl.org ([65.172.181.25]:39562 "EHLO smtp.osdl.org") by
 vger.kernel.org with ESMTP id S1759614AbWLCCZr (ORCPT
 <rfc822;git@vger.kernel.org>); Sat, 2 Dec 2006 21:25:47 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kB32PUjQ005084
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Sat, 2
 Dec 2006 18:25:30 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kB32PTwk003769; Sat, 2 Dec
 2006 18:25:29 -0800
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Sender: git-owner@vger.kernel.org



On Sun, 3 Dec 2006, Josef Weidendorfer wrote:
> 
> Thinking about this...
> You have to make very sure to always update the caching layer containing
> the backlinks on every addition of a further object. You can do this
> because you always reached this new object by some other object, which
> exactly is the backpointer.

You're missing the big issue.

The issue is that a cache like that would ABSOLUTELY SUCK.

You could speed up the non-common operations with it, but:

 - any changes would become a LOT more expensive to do, because they all 
   need to update every single object they add (ie a "commit" would now 
   have to add backpointers TO EVERY SINGLE BLOB).

   Imagine what this does to something like the kernel, where a commit 
   reaches 22,000 files!

   You can do it at a finer granularity (ie do just the direct backlinks 
   and only do the "tree->blob" and "tree->tree" things rather than the 
   full commit reachability, but it's still going to be MUCH more painful 
   than what we do now.

 - the cache would be a lot bigger than the current pack-files, and it 
   would be fragile as hell to boot. Because it needs to get rewritten for 
   every operation, it gets corrupted much more easily, and that's 
   ignoring things like race conditions, so it would now need a ton of 
   locking that git simply doesn't do at all.

 - everything would basically slow down.

 - you couldn't do shared object databases AT ALL, because backpointers 
   wouldn't work. The whole _reason_ you can share object databases is the 
   same reason we can't have backpointers: objects are immutable and never 
   change depending on circustances.

The _only_ downside of the current situation is literally the 24 or 28 
bytes per object that we look at. For most operations, we don't even look 
at that many objects, so it's really the worst-case things.

> In fact, this "cache" can be created with a usual object traversal
> (which has the original memory requirement), but as long as we do
> not add objects to the database, further traversals would only need
> a fraction of memory.

Right. If the project is totally read-only, the cache would work well.

For real development, it would SUCK. It would make things like "git reset" 
very expensive indeed, for example (you'd have to unwind the whole cache: 
either regenerating it - which would take minutes - or being very careful 
indeed and being able to always remove objects properly and keeping track 
of them 100%).

IOW, it's nasty nasty nasty. And it doesn't really even help anything but 
a case that we actually already handle really well (I spent a lot of 
effort on making the memory footprint minimal).

But it does mean that you do NOT want to traverse a hundred different 
project "as if" they were one. That's really the only thing it means.

And since you can do submodules as independent projects, and you SHOULD do 
them that way for tons of other reasons _anyway_, even that isn't a reason 
to screw up all the _wonderful_ properties of the git object database.

So what I'm trying to say is that the immutable non-backpointer nature of 
the git database is what makes it so WONDERFUL. It's efficient, it's 
dense, it's stable, and it allows us all the clever things we do. But it 
means that we do end up alway spending 28 bytes per object, and we can 
never throw those 28 bytes away during a single "traversal" run.

