From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Fix extraneous lstat's in 'git checkout -f'
Date: Mon, 13 Jul 2009 21:18:04 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0907132107130.13838@localhost.localdomain>
References: <alpine.LFD.2.01.0907132040530.13838@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 14 06:19:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MQZTy-0007hh-89
	for gcvg-git-2@gmane.org; Tue, 14 Jul 2009 06:19:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752590AbZGNESo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jul 2009 00:18:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751440AbZGNESn
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Jul 2009 00:18:43 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:38850 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751248AbZGNESn (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Jul 2009 00:18:43 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n6E4I4wT020387
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 13 Jul 2009 21:18:05 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n6E4I4Mm014632;
	Mon, 13 Jul 2009 21:18:04 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <alpine.LFD.2.01.0907132040530.13838@localhost.localdomain>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.466 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123219>



On Mon, 13 Jul 2009, Linus Torvalds wrote:
> 
> But if both CE_UPTODATE is set, and CE_VALID is clear, then we know that 
> the lstat() will always match the cache entry information, and there's no 
> point in doing another one.

Perf data on the kernel tree and my machine with index preloading:

 - run-of-ten "git checkout -f" before:
	real	0m0.131s
	real	0m0.130s
	real	0m0.128s
	real	0m0.127s
	real	0m0.129s
	real	0m0.135s
	real	0m0.129s
	real	0m0.126s
	real	0m0.128s
	real	0m0.127s

 - run-of-ten "git checkout -f" after:
	real	0m0.105s
	real	0m0.098s
	real	0m0.098s
	real	0m0.116s
	real	0m0.099s
	real	0m0.104s
	real	0m0.097s
	real	0m0.107s
	real	0m0.105s
	real	0m0.101s

so this makes about a 25% performance difference.

HOWEVER! Without preloading, there is bsically no difference what-so-ever, 
because the index won't have been preloaded (duh), so the CE_UPTODATE bit 
won't be set, so we'll do the lstat() in that oneway_merge() function 
regardless.

S for that non-preloading case, I get

 - run-of-ten "git checkout -f" without preloading:
	real	0m0.115s
	real	0m0.116s
	real	0m0.117s
	real	0m0.118s
	real	0m0.120s
	real	0m0.116s
	real	0m0.110s
	real	0m0.110s
	real	0m0.119s
	real	0m0.117s

so what happens is that with that patch the preloading is finally actually 
faster, because now it really helps do the lstat() in parallel (and I have 
lots of cores).

Before the patch, it would do the lstat first in parallel, but then it 
would do _another_ lstat() in the serial code anyway due to the silly 
oneway_merge() thing wasting time on the lstat() even if it didn't need 
to.

I guess I should have made this issue with preloading clear in the commit 
message. 

In other words - the patch should be _much_ more noticeable if you're 
doing something like NFS and are using core.preloadindex=true. My numbers 
above are all hot-cache, so there's no IO, just the fast multi-core CPU.

			Linus
