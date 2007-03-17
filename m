From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: cleaner/better zlib sources?
Date: Sat, 17 Mar 2007 12:40:14 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0703171232180.4964@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0703151747110.3816@woody.linux-foundation.org>
 <45F9EED5.3070706@garzik.org> <Pine.LNX.4.64.0703151822490.3816@woody.linux-foundation.org>
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
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Sat Mar 17 20:40:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HSelf-0000G4-1q
	for gcvg-git@gmane.org; Sat, 17 Mar 2007 20:40:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753823AbXCQTke (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Mar 2007 15:40:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753824AbXCQTke
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Mar 2007 15:40:34 -0400
Received: from smtp.osdl.org ([65.172.181.24]:42770 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753823AbXCQTkd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Mar 2007 15:40:33 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l2HJeFcD008767
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 17 Mar 2007 12:40:15 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l2HJeEIY008730;
	Sat, 17 Mar 2007 11:40:14 -0800
In-Reply-To: <Pine.LNX.4.64.0703171044550.4964@woody.linux-foundation.org>
X-Spam-Status: No, hits=-0.479 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42448>



On Sat, 17 Mar 2007, Linus Torvalds wrote:
> 
> So the cache doesn't need to be "complete". It will get good hit-rates 
> even from being very simple. I think I have a very simple and cunning 
> plan, I'll try it out asap.

Ok, got distracted by guests coming to look at the new puppy, so it took 
longer than it should have, but the following is a simple two-patch series 
that improves path-following by a factor of almost 2.5 for me.

The cache is *really* simple. It's just a 256-entry hashed cache of the 
last few base entries, and it brings down my test-case of

	git log drivers/usb/ > /dev/null

from 2.5s to just over 1s. I have *not* tuned or tweaked this at all, and 
maybe there are better ways to do this, but this was simple as hell and 
obviously quite effective.

It also speeds up "git blame", for all the same reasons. Before (best 
times out of a run of five):

	[torvalds@woody linux]$ time git blame drivers/char/Makefile > /dev/null
	real    0m1.585s
	user    0m1.576s
	sys     0m0.004s

after:

	[torvalds@woody linux]$ time ~/git/git blame drivers/char/Makefile > /dev/null
	real    0m0.763s
	user    0m0.644s
	sys     0m0.120s

so it's a factor of two there too (just a random file, I'm not at all 
going to guarantee that this is really consistent - it should get more 
testing etc).

The first patch just does some obvious re-factoring and setting up (no 
real code changes). The second patch just uses the new functions to 
actually add a cache.

		Linus
