From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 2/2] Implement a simple delta_base cache
Date: Sat, 17 Mar 2007 15:44:54 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0703171521180.4964@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0703151747110.3816@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703151848090.3816@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703151941090.4998@alien.or.mcafeemobile.com>
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
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>, Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Sat Mar 17 23:45:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HSheX-0002vd-30
	for gcvg-git@gmane.org; Sat, 17 Mar 2007 23:45:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752076AbXCQWpO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Mar 2007 18:45:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752095AbXCQWpO
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Mar 2007 18:45:14 -0400
Received: from smtp.osdl.org ([65.172.181.24]:48360 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752076AbXCQWpM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Mar 2007 18:45:12 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l2HMitcD013502
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 17 Mar 2007 15:44:55 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l2HMisu2011192;
	Sat, 17 Mar 2007 14:44:54 -0800
In-Reply-To: <Pine.LNX.4.64.0703171242180.4964@woody.linux-foundation.org>
X-Spam-Status: No, hits=-0.978 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42456>



On Sat, 17 Mar 2007, Linus Torvalds wrote:
> 
> This trivial 256-entry delta_base cache improves performance for some 
> loads by a factor of 2.5 or so.

Btw, final comment on this issue:

I was initially a bit worried about optimizing for just the "git log" with 
pathspec or "git blame" kind of behaviour, and possibly pessimizing some 
other load.

But the way the caching works, this is likely to be faster (or at least 
not slower) even for something that doesn't ever need the cache (which in 
turn is likely to be because it's a smaller footprint query and only works 
on one version).

Because the way the cache works, it doesn't really do any extra work: it 
basically just delays the "free()" on the buffer we allocated. So for 
really small footprints it just avoids the overhead of free() (let the OS 
reap the pages for it at exit), and for bigger footprints (that end up 
replacing the cache entries) it will just do the same work a bit later.

Because it's a simple direct-mapped cache, the only cost is the (trivial) 
hash of a few instructions, and possibly the slightly bigger D$ footprint. 
I would strongly suspect that even on loads where it doesn't help by 
reusing the cached objects, the delayed free'ing on its own is as likely 
to help as it is to hurt.

So there really shouldn't be any downsides.

Testing on some other loads (for example, drivers/scsi/ has more activity 
than drivers/usb/), the 2x performance win seems to happen for other 
things too. For drivers/scsi, the log generating went down from 3.582s 
(best) to 1.448s.

"git blame Makefile" went from 1.802s to 1.243s (both best-case numbers 
again: a smaller win, but still a win), but there the issue seems to be 
that with a file like that, we actually spend most of our time comparing 
different versions.

For the "git blame Makefile" case *all* of zlib combined is just 18%, 
while the ostensibly trivial "cmp_suspect()" is 23% and another 11% is 
from "assign_blame()" - so for top-level entries the costs would seem to 
tend to be in the blame algorithm itself, rather than in the actual object 
handling.

(I'm sure that could be improved too, but the take-home message from this 
is that zlib wasn't really the problem, and our stupid re-generation of 
the same delta base was.

			Linus
