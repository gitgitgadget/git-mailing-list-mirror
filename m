X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFC] Submodules in GIT
Date: Sat, 25 Nov 2006 10:57:59 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0611251037000.6991@woody.osdl.org>
References: <20061120215116.GA20736@admingilde.org> <ejt9dh$kfm$1@sea.gmane.org>
 <7v7ixp20za.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0611201501230.3338@woody.osdl.org>
 <20061121223130.GA24909@nan92-1-81-57-214-146.fbx.proxad.net>
 <Pine.LNX.4.64.0611211437430.3338@woody.osdl.org>
 <20061121235429.GH5443@nan92-1-81-57-214-146.fbx.proxad.net>
 <20061122034056.GB23856@spearce.org> <20061123232313.GB24909@nan92-1-81-57-214-146.fbx.proxad.net>
 <20061125065338.GC4528@spearce.org> <20061125111235.GO5443@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Sat, 25 Nov 2006 18:59:35 +0000 (UTC)
Cc: Shawn Pearce <spearce@spearce.org>,
	Junio C Hamano <junkio@cox.net>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061125111235.GO5443@nan92-1-81-57-214-146.fbx.proxad.net>
X-MIMEDefang-Filter: osdl$Revision: 1.160 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32298>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Go2kE-000140-Jo for gcvg-git@gmane.org; Sat, 25 Nov
 2006 19:59:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966359AbWKYS7L (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 25 Nov 2006
 13:59:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967097AbWKYS7K
 (ORCPT <rfc822;git-outgoing>); Sat, 25 Nov 2006 13:59:10 -0500
Received: from smtp.osdl.org ([65.172.181.25]:32207 "EHLO smtp.osdl.org") by
 vger.kernel.org with ESMTP id S966359AbWKYS7J (ORCPT
 <rfc822;git@vger.kernel.org>); Sat, 25 Nov 2006 13:59:09 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kAPIw1ix028975
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Sat, 25
 Nov 2006 10:58:06 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kAPIvx6S009666; Sat, 25 Nov
 2006 10:58:00 -0800
To: Yann Dirson <ydirson@altern.org>
Sender: git-owner@vger.kernel.org



On Sat, 25 Nov 2006, Yann Dirson wrote:
> 
> > This lets you then perform a bisect within the
> > submodule when you identify the supermodule commit which caused
> > the breakage.
>  
> That is, first bisect the supermodule (which naturally bisects the
> submodule with rough granularity, assuming there are many submodule
> commits for at least some supermodule commits), then bisect the submodule
> between the two commits identified at supermodule level, right ?

Right. That is how you _must_ do it.

The reason is:

 - the supermodule will not track every release of the submodule. One of 
   the biggest reasons for using submodules in the first place is that the 
   submodules have their own development _independently_ of the 
   supermodule, and usually the supermodule will import new versions of 
   submodules only occasionally (eg the supermodule might choose to track 
   only major releases of the submodule, for example)

   (And yes, I realize that this is not necessarily the only submodule 
   usage: sometimes the submodules are literally _only_ developed as 
   submodules, and you'd never develop them independently. It depends on 
   the situation)

 - As a resule of the above, you MUST NOT do bisection at the submodule 
   level at first: it's entirely possible that the supermodule never ever 
   actually used the submodule state at a finer granularity, and 
   "bisecting" into such state would be idiotic (it's really no different 
   from "bisecting" a regular commit by splitting up a commit into patches 
   against individual files - sure, it's a smaller granularity, but it's a 
   granularity that never _existed_, and was never tested or intended to 
   work!)

So yes, you should expect that

 (a) submodule changes "jump around" in the supermodule - even to the 
     point of going backwards in time as far as the submodule is concerned 
     (ie the supermodule might have tested a new release of a submodule, 
     committed that, found a problem, and decided to just go back to an 
     earlier version of the submodule again, and committed that again)

 (b) This implies very much that there can be a n:m relationship between 
     submodule and supermodule commits. A supermodule commit does _not_ 
     imply a commit in the submodule (it might commit changes to the 
     top-level makefile or to _another_ submodule), but equally, a 
     submodule commit does _not_ imply a commit in the supermodule 
     (because the submodule might be independently changed in some other 
     repository where it's the _primary_ development, not a submodule)

So you shouldn't expect submodules to be very "tightly" coupled, and I 
don't think you even want the workflow to _be_ that tight. I think it's ok 
if submodules show up as such, and that "git diff" etc don't try to make 
it all "seamless".

It often _shouldn't_ be seamless: you should be able to commit to a 
supermodule without committing the submodule state: it's really no 
different from committing individual files (it migth be somethign that is 
_discouraged_ as a workflow for some project, the same way you might 
discourage using "git commit one/file" over "git commit -a", and for the 
same reason: you're committing some state that doesn't match what your 
tree actually looks like).

Similarly, doing a "git commit -a" within a submodule should really just 
commit _that_ submodule, and not even _try_ to know about supermodules 
etc, because the submodule really should be a totally independent git 
repository.

[ Side note: you may well want to set up submodules so that they share the 
  object store with the supermodule: that may be the simplest way to make 
  operations that traverse things recursively work out, since it means 
  that you can do object lookups for everythign you traverse without 
  having to even think about it.

  On the other hand, this could equally easily be done by just making 
  every submodule an "alternates" directory in the supermodule: that keeps 
  the object databases separate, but means that anybody in the supermodule 
  will always be able to look up all the objects in the submodules. So 
  even here, we certainly _can_ keep things separated, without even 
  introducing any new concepts. ]

So I actually think that submodules should at least start out as something 
rather independent, where a "commit -a" in the supermodule will _only_ 
commit the supermodule itself - and if you haven't committed the submodule 
yet, you'll just get the current HEAD state of the submodule.

Add some trivial help in "git status" to _warn_ about the fact that 
submodules haven't been committed and are dirty, but I really think that 
it should be a very explicit thing where you really do see things as 
submodules, not as "one big module".

