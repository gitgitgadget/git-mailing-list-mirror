From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [ANNOUNCE] Example Cogito Addon - cogito-bundle
Date: Wed, 18 Oct 2006 14:17:42 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610181358200.3962@g5.osdl.org>
References: <200610180057.25411.jnareb@gmail.com> <Pine.LNX.4.64.0610171610270.3962@g5.osdl.org>
 <20061018053647.GA3507@coredump.intra.peff.net> <Pine.LNX.4.64.0610180739230.3962@g5.osdl.org>
 <20061018185225.GU20017@pasky.or.cz> <20061018185907.GV20017@pasky.or.cz>
 <7vy7rd1m4q.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0610181510510.1971@xanadu.home>
 <20061018191834.GA18829@spearce.org> <Pine.LNX.4.64.0610181525410.1971@xanadu.home>
 <20061018204626.GA19194@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nicolas Pitre <nico@cam.org>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 18 23:18:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GaInX-0005zH-DN
	for gcvg-git@gmane.org; Wed, 18 Oct 2006 23:17:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422970AbWJRVRy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Oct 2006 17:17:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422973AbWJRVRy
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Oct 2006 17:17:54 -0400
Received: from smtp.osdl.org ([65.172.181.4]:3775 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422970AbWJRVRw (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Oct 2006 17:17:52 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k9ILHhaX016908
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 18 Oct 2006 14:17:43 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k9ILHgta018524;
	Wed, 18 Oct 2006 14:17:42 -0700
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20061018204626.GA19194@spearce.org>
X-Spam-Status: No, hits=-0.97 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.95__
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29267>



On Wed, 18 Oct 2006, Shawn Pearce wrote:
>
> I guess its my turn then to work in the mmap window code, huh?  :-)

There are bigger reasons to _never_ allow packs to contain deltas to 
outside of themselves:

 - there's no point. 

   If you have many small packs, you're doing something wrong. The whole 
   _point_ of packs is to put things into the same file, so that you can 
   avoid the filesystem overhead. And once packs are big and few, the 
   advantage of having deltas to outside the pack is basically zero.

 - it's a bad design. 

   Self-sufficient packs means that a pack is a "safe" thing. When the 
   index says that it contains an object, then it damn well contains it.

   In contrast, if you had packs that only contained a delta, and the pack 
   needed some _other_ pack (or loose object) to actually generate that 
   object, then it's not safe any more. You could end up with a situation 
   where you get two packs from two different sources, and they contain 
   deltas to _each_other_, and you have no way of actually generating the 
   object itself any more.

   (Or you end up having to have rules to figure out when you have a loop,
   and stop looking just in the packed files, and start looking for loose 
   objects instead)

   In other words, it has potentially _serious_ downsides.

So DAMMIT! Stop looking to make the data structures worse. The fact is, 
the git data structures are FINE. They are well-designed. They work well. 
There's no _point_ in changing them, especially since changing them seems 
to be all about making things less reliable for dubious gain.

One of the advantages of git is that you can explain things with object 
relationships, and that the file format is stable as _hell_. Thats a GOOD 
thing. Please realize that if you want to change the file formats, you'd 
have a hell of a better reason for it that "just because I can".

Please. Really.

So next time somebody suggests a new pack-format, ask yourself:

 - does it save disk-space by 50% or more?

 - does it drop memory usage by 50% or more?

 - does it improve performance by 50% of more?

 - does it make something possible that really fundamentally isn't 
   possible right now?

And if the answer to those questions is "no", then JUST DON'T DO IT.

It really needs to be _damn_ spectacular to be worthy of a new format. 
Really. We've had a few of those, so it clearly does happen:

 - The "compress _after_ SHA1". The original object format was just 
   broken, and the SHA1 name depended on how things compressed. I fixed 
   it. It needed fixing. We couldn't have done a lot of the things we did 
   without switching compression and SHA1-hashing around.

 - the pack-file in the first place: this saved orders of magnitude both 
   in diskspace _and_ performance. Not "10%". More like "factors of 100".

   THAT was worthy of a major format change.

 - the "make loose object contents look the same as packed objects". This 
   was not just a cleanup, it allows us to create pack-files much faster. 

   That said, we're still defaulting to the legacy format, and maybe it 
   wasn't really worth it. 

My personal suspicion is that we'll want to have a 64-bit index file some 
day, and THAT is worthy of a format change. That day is not now, btw. It's 
probably not even very close. Even the mozilla repo that was pushing the 
limit was only doing so until it was optimized better, and now it's 
apparently nowhere _near_ that limit.

But even then, we might well want to update _just_ the index file format.

Because in an SCM, stability and trustworthiness is more important than 
just about _anything_ else. 

			Linus
