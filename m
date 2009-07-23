From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Performance issue of 'git branch'
Date: Thu, 23 Jul 2009 09:19:21 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0907230913230.21520@localhost.localdomain>
References: <20090722235914.GA13150@Pilar.aei.mpg.de> <alpine.LFD.2.01.0907221714300.3352@localhost.localdomain> <20090723012207.GA9368@Pilar.aei.mpg.de> <alpine.LFD.2.01.0907221850000.3352@localhost.localdomain> <alpine.LFD.2.01.0907221921570.3352@localhost.localdomain>
 <7vtz146mgr.fsf@alter.siamese.dyndns.org> <20090723160740.GA5736@Pilar.aei.mpg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: "Carlos R. Mafra" <crmafra2@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 23 18:20:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MU11b-0001O6-Iu
	for gcvg-git-2@gmane.org; Thu, 23 Jul 2009 18:20:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754368AbZGWQT6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jul 2009 12:19:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754321AbZGWQT6
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Jul 2009 12:19:58 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:52948 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752581AbZGWQT5 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Jul 2009 12:19:57 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n6NGJMXP008149
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 23 Jul 2009 09:19:23 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n6NGJLpv027186;
	Thu, 23 Jul 2009 09:19:22 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <20090723160740.GA5736@Pilar.aei.mpg.de>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.46 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123877>



On Thu, 23 Jul 2009, Carlos R. Mafra wrote:
> 
> Having learned about .git/packed-refs last night, today I tried
> this (with cold cache),
> 
> [mafra@Pilar:linux-2.6]$ time awk '{print $2}' .git/packed-refs |grep heads| awk -F "/" '{print $3}'
> 0.00user 0.00system 0:00.12elapsed 0%CPU (0avgtext+0avgdata 0maxresident)k
> 0inputs+0outputs (3major+311minor)pagefaults 0swaps
> 27-stable
> 28-stable
> 29-stable
> 30-stable
> dev-private
> master
> option
> sparse
> stern
> 
> and notice how that makes my pitiful harddisc look like Linus' SSD! And the
> result is the same. 

The result is the same, yes, but it doesn't do error checking.

What "git branch" does over and beyond just looking at the heads is to 
also look at the commits those heads point to. And the reason it sucks for 
you is that the commits are pretty spread out (particularly in the index 
file, but also in the pack-file) on disk. So each "verify this head" will 
likely involve at least one seek, and possibly four or five. 

And on your disk, five seeks is a tenth of a second. You can run hdparm, 
and it will probably say that you get 30MB/s off that laptop drive - but 
when doing small random reads you'll probably get performance in the order 
of a few tens of kilobytes, not megabytes. (With read-ahead and 
read-around it's probably going to be mostly ~64kB IO's and you'll 
probably get hundreds of kB per second, but you're going to care about 
just a few kB total of those).

So we _could_ make 'git branch' not actually read and verify the commits. 
It doesn't strictly _need_ to, unless you use 'git branch -v' or 
something. That would speed it up further, but the verification is nice, 
and as long as performance isn't _horrible_ I think we're better off doing 
it.

After all, you'll see the problem only once.

			Linus
