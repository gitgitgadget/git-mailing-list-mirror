From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] diff-delta: bound hash list length to avoid O(m*n)
 behavior
Date: Fri, 3 Mar 2006 22:21:43 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0603032217470.22647@g5.osdl.org>
References: <Pine.LNX.4.64.0602272110320.25336@localhost.localdomain>
 <7vhd6kq8lc.fsf@assigned-by-dhcp.cox.net> <7vbqwrq4yi.fsf@assigned-by-dhcp.cox.net>
 <7vfylzx7t3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 04 07:22:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FFQ9V-0007xF-Lt
	for gcvg-git@gmane.org; Sat, 04 Mar 2006 07:22:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751060AbWCDGV7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Mar 2006 01:21:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751239AbWCDGV7
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Mar 2006 01:21:59 -0500
Received: from smtp.osdl.org ([65.172.181.4]:60050 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751060AbWCDGV6 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Mar 2006 01:21:58 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k246LjDZ027949
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 3 Mar 2006 22:21:46 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k246Lhic009898;
	Fri, 3 Mar 2006 22:21:44 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vfylzx7t3.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-3 required=5 tests=PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17175>



On Fri, 3 Mar 2006, Junio C Hamano wrote:
> 
> 	The first round.  The set of objects packed were from
> today's Linus tip (everything down to epoch v2.6.12-rc2), 193309
> objects in total, on my Duron 750 with slow disks.
> 
> 	real		user		sys		bytes		savings
> master	11m17.121s	10m23.280s	0m47.290s       109045599	N/A
> nico	25m37.058s	23m0.770s       2m20.460s	104401392	4.25%
> jc	24m12.072s	21m45.120s	2m16.400s	104409761	4.25%

Ouch.

Btw, it's often worth using /usr/bin/time instead of the bash built-in 
time. Why? Because /usr/bin/time reports one absolutely _hugely_ important 
number (maybe more important than almost any of the other numbers in 
there).

Which one? It's the "minor pagefaults". That's a very good approximation 
of memory usage overhead. 

We've already had one person report that they ran out of memory when 
packing. So memory usage is actually a problem.

Anyway, it looks like the 16-byte window is the way to go, even regardless 
of any memory use issue.

		Linus
