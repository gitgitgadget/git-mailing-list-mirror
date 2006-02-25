From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] diff-delta: produce optimal pack data
Date: Fri, 24 Feb 2006 16:45:23 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602241637480.22647@g5.osdl.org>
References: <Pine.LNX.4.64.0602212043260.5606@localhost.localdomain>
 <7v4q2pf8fq.fsf@assigned-by-dhcp.cox.net> <20060224174422.GA13367@hpsvcnb.fc.hp.com>
 <Pine.LNX.4.64.0602241252300.31162@localhost.localdomain>
 <20060224183554.GA31247@hpsvcnb.fc.hp.com> <Pine.LNX.4.64.0602241350190.31162@localhost.localdomain>
 <20060224192354.GC387@hpsvcnb.fc.hp.com> <Pine.LNX.4.64.0602241152290.22647@g5.osdl.org>
 <7vpslc8oni.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0602241613030.31162@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Carl Baldwin <cnb@fc.hp.com>
X-From: git-owner@vger.kernel.org Sat Feb 25 01:54:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FCnhc-0004nV-22
	for gcvg-git@gmane.org; Sat, 25 Feb 2006 01:54:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964828AbWBYAyX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Feb 2006 19:54:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964829AbWBYAyX
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Feb 2006 19:54:23 -0500
Received: from smtp.osdl.org ([65.172.181.4]:38307 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964828AbWBYAyW (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Feb 2006 19:54:22 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k1P0jUDZ026184
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 24 Feb 2006 16:45:30 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k1P0jOpr016328;
	Fri, 24 Feb 2006 16:45:26 -0800
To: Nicolas Pitre <nico@cam.org>
In-Reply-To: <Pine.LNX.4.64.0602241613030.31162@localhost.localdomain>
X-Spam-Status: No, hits=-3 required=5 tests=PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16749>



On Fri, 24 Feb 2006, Nicolas Pitre wrote:
> 
> Currently, diff-delta takes blocks of data in the reference file and 
> hash them.  When the target file is scanned, it uses the hash to match 
> blocks from the target file with the reference file.
> 
> If blocks are hashed evenly the cost of  producing a delta is at most 
> O(n+m) where n and m are the size of the reference and target files 
> respectively.  In other words, with good data set the cost is linear.

Assuming the hash is good, of course.

I think this was the problem with you trying something simpler than 
adler32..

> But if many blocks from the reference buffer do hash to the same bucket 
> then for each block in the target file many blocks from the reference 
> buffer have to be tested against, making it tend towards O(n^m) which is 
> pretty highly exponential.
> 
> The solution I'm investigating is to put a limit on the number of 
> entries in the same hash bucket so to bring the cost back to something 
> more linear.  That means the delta might miss on better matches that 
> have not been hashed but still benefit from a limited set.

Sounds fair enough.

However, you migt also want to consider another approach..

One of the biggest costs for the xdelta algorithm is probably just the 
"delta_prepare()", but at the same time, that is constant wrt the source 
buffer.

Now, the sad part is that when I wrote pack-objects, I didn't really 
understand the diff-delta algorithm, I just plugged it in. Which means 
that when I did it, I made the (obvious and simple) decision to keep the 
_result_ that we are looking at constant, and try to delta against 
different sources.

HOWEVER.

I suspect you already see where this is going..

We _could_ switch the "pack-objects" window handling around, and instead 
of looking at the object we want to pack, and looking at the ten (or 
"window") previous objects to delta against, we could do it the other way 
around: keep the object we delta against constant, and see what deltas we 
could prepare for the ten next objects.

And since the source would now be constant, you'd need to do the 
"delta_prepare()" just _once_ per window, instead of every single time.

Now, I haven't done any profiling on the diff-delta code, and maybe my 
guess that delta_prepare() is a pretty expensive part is wrong, and maybe 
it wouldn't help to switch the window probing around. But I thought I'd 
mention it as one thing to explore..

		Linus
