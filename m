From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 2/2] Implement a simple delta_base cache
Date: Sat, 17 Mar 2007 16:54:18 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0703171638000.4964@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0703151747110.3816@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703151955440.3816@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703151955150.4998@alien.or.mcafeemobile.com>
 <Pine.LNX.4.64.0703160913361.3816@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703160920030.13402@alien.or.mcafeemobile.com>
 <Pine.LNX.4.64.0703160934070.3816@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703161216510.13732@alien.or.mcafeemobile.com>
 <Pine.LNX.4.64.0703161636520.3910@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703161722360.3910@woody.linux-foundation.org>
 <alpine.LFD.0.83.0703162257560.18328@xanadu.home>
 <Pine.LNX.4.64.0703171044550.4964@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703171232180.4964@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703171242180.4964@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703171420420.4964@woody.linux-foundation.org>
 <7vfy83qyxh.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0703171557360.4964@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nicolas Pitre <nico@cam.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Mar 18 00:55:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HSijq-0005QC-5n
	for gcvg-git@gmane.org; Sun, 18 Mar 2007 00:55:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752450AbXCQXyg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Mar 2007 19:54:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752474AbXCQXyg
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Mar 2007 19:54:36 -0400
Received: from smtp.osdl.org ([65.172.181.24]:49643 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752450AbXCQXyf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Mar 2007 19:54:35 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l2HNsJcD015113
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 17 Mar 2007 16:54:20 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l2HNsI7n012157;
	Sat, 17 Mar 2007 15:54:19 -0800
In-Reply-To: <Pine.LNX.4.64.0703171557360.4964@woody.linux-foundation.org>
X-Spam-Status: No, hits=-0.978 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42461>



On Sat, 17 Mar 2007, Linus Torvalds wrote:
> 
>  (a) it probably doesn't really matter a lot (but I don't have the 
>      numbers)

Well, to some degree I obviously *do* have the numbers.

I have the numbers that we used to re-generate the object data over five 
*hundred* times per object for some cases, and that I got the average 
such delta-base usage down from 20x to 1.1-1.3x depending on cache size.

In contrast, the "use delta-base also for non-delta queries" fairly 
obviously cannot touch those kinds of numbers. We migth avoid a *few* 
object generation cases, but we're not looking at factors of 20 for any 
kind of sane cases.

So I do think that a higher-level caching approach can work too, but it's 
going to be more effective in other areas:

 - get rid of some ugly hacks (like the "save_commit_buffer" thing I 
   mentioned)
 - possibly help some insane loads (eg cases where we really *do* end up 
   seeing the same object over and over again, perhaps simply because some 
   idiotic automated commit system ends up switching between a few states 
   back-and-forth).

I really think the "insane loads" thing is unlikely, but I could construct 
some crazy usage scenario where a cache of objects in general (and not 
just delta bases) would work. I don't think it's a very realistic case, 
but who knows - people sometimes do really stupid things.

		Linus
