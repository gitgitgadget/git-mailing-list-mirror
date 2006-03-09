From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Add git-imap-send.
Date: Thu, 9 Mar 2006 10:21:50 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0603091017530.18022@g5.osdl.org>
References: <440C3499.9080000@codeweavers.com> <7vacbz7vod.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0603091227560.20277@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0603090836030.18022@g5.osdl.org> <7vmzfz5w2k.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Mike McCormack <mike@codeweavers.com>
X-From: git-owner@vger.kernel.org Thu Mar 09 19:24:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FHPmG-0001u0-Ps
	for gcvg-git@gmane.org; Thu, 09 Mar 2006 19:22:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750859AbWCISWH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Mar 2006 13:22:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751028AbWCISWH
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Mar 2006 13:22:07 -0500
Received: from smtp.osdl.org ([65.172.181.4]:58585 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750859AbWCISWF (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Mar 2006 13:22:05 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k29ILqDZ018585
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 9 Mar 2006 10:21:52 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k29ILokx007700;
	Thu, 9 Mar 2006 10:21:51 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vmzfz5w2k.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-3 required=5 tests=PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17432>



On Thu, 9 Mar 2006, Junio C Hamano wrote:
>
> Linus Torvalds <torvalds@osdl.org> writes:
> 
> > it's entirely possible that it will load bytes from "string" _past_ the 
> > end of the string because of an unrolled inner loop that does things 
> > multiple bytes at a time. They won't be used in the eventual result, but 
> > just the fact that they are loaded from memory can mean that your program 
> > takes a SIGSEGV, for example, becaue it turns out "string" was just a 
> > single NUL byte at the end of a page, and there's nothing after it.
> 
> Funny.  I've seen this exact bug in memcmp and strcmp in earlier
> SunOS (pre Solaris) libc when I was working on something like
> Valgrind in my previous life.

Well, Valgrind actually can complain for no good reason.

System libraries often take advantage of knowing how the CPU and the 
system memory layout works. For example, just from knowing that pages are 
always aligned to a certain (largish) boundary, you can know that it's 
perfectly safe to do certain optimizations and prefetch past the end of an 
object, as long as it's in the same page (and the easiest way to verify 
that is to just do it when something is aligned).

So Valgrind will sometimes complain about perfectly bug-free code, just 
because the bug-free code accesses outside the "strictly allowable" 
region because it knows it can. 

Valgrind can be taught about system libraries like that, but especially if 
it's an early port to a new architecture or OS, valgrind will often 
complain unnecessarily.

			Linus
