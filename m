X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Cleaning up git user-interface warts
Date: Wed, 15 Nov 2006 15:33:43 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0611151523290.3349@woody.osdl.org>
References: <Pine.LNX.4.64.0611150950170.3349@woody.osdl.org>
 <200611151858.51833.andyparkins@gmail.com> <Pine.LNX.4.64.0611151111250.3349@woody.osdl.org>
 <f2b55d220611151139v66fba16ax97ce6b9966b33ce7@mail.gmail.com>
 <Pine.LNX.4.64.0611151203450.3349@woody.osdl.org> <Pine.LNX.4.64.0611151516360.2591@xanadu.home>
 <Pine.LNX.4.64.0611151226590.3349@woody.osdl.org> <87velgs9hx.wl%cworth@cworth.org>
 <Pine.LNX.4.64.0611151339500.3349@woody.osdl.org> <87psbos4pb.wl%cworth@cworth.org>
 <20061115230252.GH24861@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Wed, 15 Nov 2006 23:34:27 +0000 (UTC)
Cc: Carl Worth <cworth@cworth.org>, Nicolas Pitre <nico@cam.org>,
	"Michael K. Edwards" <medwards.linux@gmail.com>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061115230252.GH24861@spearce.org>
X-MIMEDefang-Filter: osdl$Revision: 1.156 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31528>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkUGo-0000e5-9t for gcvg-git@gmane.org; Thu, 16 Nov
 2006 00:34:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1162066AbWKOXeP (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 15 Nov 2006
 18:34:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162048AbWKOXeP
 (ORCPT <rfc822;git-outgoing>); Wed, 15 Nov 2006 18:34:15 -0500
Received: from smtp.osdl.org ([65.172.181.4]:15293 "EHLO smtp.osdl.org") by
 vger.kernel.org with ESMTP id S1162066AbWKOXeO (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 15 Nov 2006 18:34:14 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kAFNXioZ008994
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Wed, 15
 Nov 2006 15:33:45 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kAFNXgFv002558; Wed, 15 Nov
 2006 15:33:43 -0800
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org



On Wed, 15 Nov 2006, Shawn Pearce wrote:
> 
> I've taught the same fetch first, then merge strategy.  Nobody I
> know in meat-space pulls from a remote URL and merges in one shot;

Actually, with different people involved it's _much_ better to do it in 
one shot.

Why? Because doing a separate "fetch to local space" + "merge from local 
space" actually loses the information on what you are merging.

It's a lot more useful to have a merge message like

	Merge branch 'for-linus' of git://one.firstfloor.org/home/andi/git/linux-2.6

than one like

	Merge branch 'for-linus'

which is what you get if you fetched it first.

Of course, in a situation like git itself, where most of the merges are 
stuff that Junio has had pending in his own tree ('maint' branch etc), 
things are different. But in a system where people actually use separate 
trees, there really is an advantage to consider the fundamental operation 
to be the "pull", not the "merge".

Again, the kernel really is more distributed than most projects, but this 
is another thing people should recognize: git has been designed for "true 
distributed development". Not the "fake" kind. Not the "I merge mainly my 
own branches" kind of thing. Truly distributed.

And in a truly distributed situation, "pull" is strictly more powerful 
than a separate "fetch" + separate "merge".

In other words, an SCM that does "pull" is _better_ than an SCM that does 
"merge". You can implement "merge" as a special case of "pull" (which we 
do), but you cannot conveniently do it the other way around without having 
to tie them together some other way (ie you could have a "remember the 
last place we fetched this branch from in order to tie the fetch and the 
merge together" - but please realize that that is exactly what "pull" 
_is_).

So I will generally do a "git pull" (possibly followed by a "git reset 
--hard ORIG_HEAD" if I decided it wasn't good) over a "git fetch" + "git 
merge". Exactly because the "pull" operation is actually more powerful.

Maybe people who aren't in my position don't always appreciate the _power_ 
of git. The reason "merge" is a second-class citizen is simply because IT 
SHOULD BE.

