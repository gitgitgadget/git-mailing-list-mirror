From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Excessive memory consumption.
Date: Mon, 17 Mar 2008 10:04:50 -0700 (PDT)
Message-ID: <alpine.LFD.1.00.0803170956430.3020@woody.linux-foundation.org>
References: <20080317154353.GA9062@old.davidb.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: David Brown <git@davidb.org>
X-From: git-owner@vger.kernel.org Mon Mar 17 18:06:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JbImr-0002kR-FA
	for gcvg-git-2@gmane.org; Mon, 17 Mar 2008 18:06:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752004AbYCQRFd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Mar 2008 13:05:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751974AbYCQRFd
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Mar 2008 13:05:33 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:57639 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751456AbYCQRFc (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Mar 2008 13:05:32 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m2HH60up023531
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 17 Mar 2008 10:06:01 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m2HH4oha021909;
	Mon, 17 Mar 2008 10:04:51 -0700
In-Reply-To: <20080317154353.GA9062@old.davidb.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-103.32 required=5 tests=AWL,BAYES_00,USER_IN_WHITELIST
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77447>



On Mon, 17 Mar 2008, David Brown wrote:
> 
> phase, git-pack-objects quickly grows to 3 or more GB in size.  I've tried
> setting  pack.windowMemory = 512m, and pack.deltaCacheLimit = 512m.  Any
> other suggested things to try?

This *might* be the malloc() fragmentation issue. If you have lots of 
large files with deltas in between them, you might well end up with a lot 
of the allocations having been 'free()'d, but even if you have "only" one 
gig in active use, there might be lots of holes in the allocation patterns 
with "free" memory.

Does lowering the limits more aggressively make any difference (ie try 
with those limits set to just a few tens of megs?) It will cause much 
worse deltas (since now the delta machinery won't work well on those big 
tar-files), so you probably don't want to do this for real, but as a test 
of whether it's those allocations or soemthing else it would still be 
interesting.

But using valgrind (--tool=massif) to show the real allocations might also 
give an even better view. Maybe valgrind tells you only 1 gig is used, and 
then yes, it would be about some kind of fragmentation issue. Or maybe 
valgrind points out some other memory user entirely..

		Linus
