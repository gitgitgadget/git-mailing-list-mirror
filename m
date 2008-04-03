From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Achieving efficient storage of weirdly structured repos
Date: Thu, 3 Apr 2008 14:11:04 -0700 (PDT)
Message-ID: <alpine.LFD.1.00.0804031402530.14670@woody.linux-foundation.org>
References: <7BE3E865-C30D-49B8-A1D9-898109514990@sun.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Roman Shaposhnik <rvs@Sun.COM>
X-From: git-owner@vger.kernel.org Thu Apr 03 23:12:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JhWj5-0006mU-Q4
	for gcvg-git-2@gmane.org; Thu, 03 Apr 2008 23:12:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757428AbYDCVLU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Apr 2008 17:11:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757408AbYDCVLU
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Apr 2008 17:11:20 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:34546 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757344AbYDCVLT (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Apr 2008 17:11:19 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m33LBHrL009763
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 3 Apr 2008 14:11:18 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m33LB4WS022684;
	Thu, 3 Apr 2008 14:11:11 -0700
In-Reply-To: <7BE3E865-C30D-49B8-A1D9-898109514990@sun.com>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-3.386 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78780>



On Thu, 3 Apr 2008, Roman Shaposhnik wrote:
> 
> The repository was created using hg2git (the one based on git-fast-import)
> and it was GC'ed and REPACK'ed just in case.

Before going any further - exactly _how_ was it repacked?

In particular, when using importers that do partial packing on their own 
(and any "git-fastimport" user is that by definition - and I think 
hg2git does that), at the end of it all you have to make sure to repack in 
a way where the repacking will totally discard the import-time packfiles.

IOW, that's one of the very few times you should use "-f" to git repack.

It's usually also a good place to make sure that since you ignore the old 
packing information, it's best to also make sure that the new packing info 
is good by using a bigger window (and perhaps a bigger depth). That makes 
the packing much slower, of course, but this is meant to be a one-time 
event.

So try something like

	git repack -a -d -f --depth=100 --window=100

if you have a good CPU and plenty of memory.

> The last item (trees) also seem to take the most space and the most 
> reasonable explanation that I can offer is that NetBeans repository has 
> a really weird structure where they have approximately 700 (yes, seven 
> hundred!) top-level subdirectories there. They are clearly 
> Submodules-shy, but that's another issue that I will need to address 
> with them.

Trees taking the biggest amount of space is not unheard of, and it may 
also be that the name heuristics (for finding good packing partners) could 
be failign, which would result in a much bigger pack than necessary. 

So if you already did an aggressive repack like the above, I'd happily 
take a look at whether maybe it's bad heuristics for finding tree objects 
to pair up for delta-compression. Do you have a place where you can put 
that repo for people to clone and look at? 

			Linus
