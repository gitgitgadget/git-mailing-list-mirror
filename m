From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: On data structures and parallelism
Date: Sun, 17 May 2009 10:46:29 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0905171038320.3301@localhost.localdomain>
References: <20090517152335.GC11543@zakalwe.fi> <alpine.LFD.2.01.0905170950230.3301@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Heikki Orsila <shdl@zakalwe.fi>
X-From: git-owner@vger.kernel.org Sun May 17 19:49:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M5kTv-0008CE-9a
	for gcvg-git-2@gmane.org; Sun, 17 May 2009 19:49:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752037AbZEQRqd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 May 2009 13:46:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751377AbZEQRqd
	(ORCPT <rfc822;git-outgoing>); Sun, 17 May 2009 13:46:33 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:58130 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751101AbZEQRqc (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 May 2009 13:46:32 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n4HHkTeM016162
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 17 May 2009 10:46:30 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n4HHkTqW019298;
	Sun, 17 May 2009 10:46:29 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <alpine.LFD.2.01.0905170950230.3301@localhost.localdomain>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.464 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119403>



On Sun, 17 May 2009, Linus Torvalds wrote:
> 
> That said, on my laptops, CPU time really _never_ is the issue. Every 
> single time something is slow, the issue is a slow 4200rpm disk that may 
> get 25MB/s off it for linear things in the best case, but seeks take 
> milliseconds and any kind of random access will just kill performance.

Side note - I've several times desperately tried to see if IO parallelism 
helps. It doesn't. Some drives do better if they get many independent 
reads and can just do them concurrently. Sadly, that's pretty rare for 
reads on rotational media, and impossible with legacy IDE drives (that 
don't have the ability to do tagged queueing). 

So when I try to do IO in parallel (which git does support for many 
operations), that just makes the whole system come to a screeching halt 
because it now seeks around the disk a lot more. A similar issue that 
often kill parallelism on CPU's (bad cache behavior, and lots of 
outstanding memory requests) kills parallelism on disks too - disk 
performance simply is much _better_ if you do serial things than if you 
try to parallelize the same work.

It would be different if I had a fancy high-end RAID system with tagged 
queueing and lots of spare bandwidth that could be used in parallel. But 
that's not what the git usage scenario often is. All the people pushing 
multi-core seem to always ignore the big issues, and always working on 
nice trivial problems with a small and well-behaved "kernel" that has no 
IO and preferably didn't cache well even when single-threaded (ie 
"streaming" data).

			Linus
