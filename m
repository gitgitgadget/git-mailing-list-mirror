X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFC] Submodules in GIT
Date: Sat, 2 Dec 2006 13:22:22 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0612021252380.3476@woody.osdl.org>
References: <20061130170625.GH18810@admingilde.org> <4570AF8F.1000801@stephan-feder.de>
 <Pine.LNX.4.64.0612011505190.3695@woody.osdl.org> <200612020036.08826.Josef.Weidendorfer@gmx.de>
 <Pine.LNX.4.64.0612011540010.3695@woody.osdl.org> <20061202201826.GR18810@admingilde.org>
 <Pine.LNX.4.64.0612021242080.3476@woody.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Sat, 2 Dec 2006 21:22:51 +0000 (UTC)
Cc: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>,
	sf <sf-gmane@stephan-feder.de>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.64.0612021242080.3476@woody.osdl.org>
X-MIMEDefang-Filter: osdl$Revision: 1.161 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33054>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GqcJl-0007Bu-DK for gcvg-git@gmane.org; Sat, 02 Dec
 2006 22:22:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1162489AbWLBVWf (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 2 Dec 2006
 16:22:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162490AbWLBVWf
 (ORCPT <rfc822;git-outgoing>); Sat, 2 Dec 2006 16:22:35 -0500
Received: from smtp.osdl.org ([65.172.181.25]:33207 "EHLO smtp.osdl.org") by
 vger.kernel.org with ESMTP id S1162489AbWLBVWf (ORCPT
 <rfc822;git@vger.kernel.org>); Sat, 2 Dec 2006 16:22:35 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kB2LMNjQ025024
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Sat, 2
 Dec 2006 13:22:24 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kB2LMMGh029333; Sat, 2 Dec
 2006 13:22:23 -0800
To: Martin Waitz <tali@admingilde.org>
Sender: git-owner@vger.kernel.org



On Sat, 2 Dec 2006, Linus Torvalds wrote:
> 
> And watch the memory usage.

Btw, just in case you don't understand _why_ this is true, the fact is, in 
a git repository, quite fundamentally, because we don't have "backlinks" 
at any stage at all, we don't know - and fundamentally _cannot_ know - 
whether we're goign to see the same object in the future.

So operations like "git-rev-list --objects" (or, these days, more commonly 
anything that just does the equivalent of that internally using the 
library interfaces - ie "git pack-objects" and friends) VERY FUNDAMENTALLY 
have to hold on to the object flags for the whole lifetime of the whole 
operation.

And you should realize that this is really really fundamental. You can't 
fix it with "smarter memory management". You can't fix it with "garbage 
collection". This is _not_ a result of the fact that we use C and malloc, 
and we don't free those objects, like some people sometimes seem to 
believe.

So garbage collection will never help this kind of situation. It flows 
_directly_ from the fact that our objects are immutable: because they are 
immutable, they don't have any backpointers, because we cannot (and must 
not) add backpointers to an old existing object when a new object is 
created that points to it.

So this really isn't a memory management issue. You could somewhat work 
around it by adding a "caching layer" on top of git, and allow that 
caching layer to modify their cache of old objects (so that they can 
contain back-pointers), but for 99% of all users that would actually make 
performance MUCH WORSE, and it would also be a serious problem for 
coherency issues (one of the things that immutable objects cause is that 
there are basically never any race conditions, while a "caching layer" 
like this would have some serious issues about serialization).

So: the very fundamental nature and choices that were made in git also 
means that when you have something like git-pack-objects that wants to 
walk the whole repo, you will end up with something that remembers EVERY 
SINGLE OBJECT it walked. 

And while I've worked very hard to make the memory footprint of individual 
objects as small as possible, and this means that this all works fine even 
for fairly large databases (especially since very few operations actually 
do this "traverse the whole friggin tree" thing), it does mean that 
there's a very fundamental limit to scalability. You can't just make a 
whole repository a hundred times bigger - because the operations that 
traverse the whole thing will require a hundred times more memory!

Now, in "real" projects, this is not a problem. I can pretty much 
_guarantee_ that memory sizes and hardware will grow faster than projects 
grow. I'm not AT ALL worried about the fact that in ten years, the linux 
kernel repository will likely be two or three times the size it is now. 
Because I'm absolutely convinced that in ten years, the machines we have 
now will be obsolete.

So on any "individual project" basis, the fact that memory requirements 
scale roughly as O(n) in the total repository size is simply not a 
problem. In fact, O(n) is pretty damn good, especially since the constant 
is pretty small (basically 28 bytes per object - and 20 of those bytes 
are the SHA1 that you simply cannot avoid).

But it does mean that supermodules really should NOT be so seamless that 
doing a "git clone" on a supermodule does one _large_ clone. Because it's 
simply going to be better to:

 - when you clone the supermodule, track the commits you need on all 
   submodules (this _may_ be a reason in itself for the "link" object, 
   just so that you can traverse the supermodule object dependencies and 
   know what subobject you are looking at even _without_ having to look at 
   the path you got there from)

 - clone submodules one-by-one, using the list of objects you gathered.

Maybe there are other solutions, but quite frankly, I doubt it. Yes, 
you'll end up "traversing" exactly as many objects either way, but the 
"globe subobjects one by one" is going to be a _hell_ of a lot more 
memory-efficient, and quite frankly, "memory usage" == "performance"  
under many loads (notably, any load that uses too much memory will _suck_ 
performance-wise, either because of swapping or simply because it will 
throw out caches that "many small invocations" would not have thrown out).

So I guarantee that it's going to be better to do five clones of five 
small repositories over one clone of one big one. If only because you need 
less memory to do the five smaller clones.

