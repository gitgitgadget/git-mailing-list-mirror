From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] pack-objects: re-validate data we copy from elsewhere.
Date: Sun, 3 Sep 2006 15:16:47 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0609031510330.27779@g5.osdl.org>
References: <20060829165811.GB21729@spearce.org> <20060829175819.GE21729@spearce.org>
 <9e4733910608291155g782953bbv5df1b74878f4fcf1@mail.gmail.com>
 <20060829190548.GK21729@spearce.org> <9e4733910608291252q130fc723r945e6ab906ca6969@mail.gmail.com>
 <20060829232007.GC22935@spearce.org> <9e4733910608291807q9b896e4sdbfaa9e49de58c2b@mail.gmail.com>
 <20060830015122.GE22935@spearce.org> <9e4733910608291958l45c0257dla6e5ebd4176f7164@mail.gmail.com>
 <20060830031029.GA23967@spearce.org> <Pine.LNX.4.64.0608300124550.9796@xanadu.home>
 <7vzmdmh2lu.fsf@assigned-by-dhcp.cox.net> <44F871BA.3070303@gmail.com>
 <Pine.LNX.4.64.0609011129270.27779@g5.osdl.org> <7vveo741tc.fsf_-_@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0609011721390.27779@g5.osdl.org> <7vd5ae3ox2.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0609021138500.27779@g5.osdl.org> <7vslj8tydc.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0609031456520.27779@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 04 00:18:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GK0Ie-000574-Lp
	for gcvg-git@gmane.org; Mon, 04 Sep 2006 00:18:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751040AbWICWST (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 3 Sep 2006 18:18:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751117AbWICWSS
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Sep 2006 18:18:18 -0400
Received: from smtp.osdl.org ([65.172.181.4]:10958 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750869AbWICWQw (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 3 Sep 2006 18:16:52 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k83MGmnW019985
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 3 Sep 2006 15:16:48 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k83MGl3l032234;
	Sun, 3 Sep 2006 15:16:47 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <Pine.LNX.4.64.0609031456520.27779@g5.osdl.org>
X-Spam-Status: No, hits=-2.479 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.146 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26388>



On Sun, 3 Sep 2006, Linus Torvalds wrote:
> 
> Ok. Is it less painful if it just checks the zlib CRC (and that the SHA1 
> _exists_ for a delta - although I guess we check that indirectly by just 
> accepting the delta in the first place)? That combination should still be 
> a fairly strong check, of course.

Thinking some more about it, doing the stupid "apply full delta chain and 
check the final SHA1" is horribly inefficient, because if you have a repo 
that packs well, you'd expect to have a lot of things with a 10-deep delta 
chain.

And doing it the silly way means that you'll do each object independently, 
ie for a 10-deep chain you'd unpack the base object ten times, and apply 
the first delta 9 times, the second one 8 times etc etc. And each time 
you'd deflate everything, since we don't keep a cache of actual object 
contents.

So I'd expect that with full SHA1 checking, you'd end up doing ~45 
deflates for the ten-object chain, instead of doing just 10.

So it should hopefully be _much_ cheaper to just check the zlib CRC, not 
because the "apply delta" and "calculate sha1" are necessarily all that 
expensive, but because the unoptimized chain-unpacking is doing so much 
unnecessary work.

			Linus

-- 
VGER BF report: U 0.5
