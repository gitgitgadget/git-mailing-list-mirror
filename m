From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 7/3] Make index preloading check the whole path to the
 file
Date: Fri, 10 Jul 2009 20:04:05 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0907101957200.3552@localhost.localdomain>
References: <20090707000500.GA5594@dpotapov.dyndns.org> <alpine.LFD.2.01.0907081936470.3352@localhost.localdomain> <alpine.LFD.2.01.0907081940220.3352@localhost.localdomain> <alpine.LFD.2.01.0907081942380.3352@localhost.localdomain> <7vskh646bw.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.01.0907090832200.3352@localhost.localdomain> <7vws6h3ji4.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.01.0907091011280.3352@localhost.localdomain> <alpine.LFD.2.01.0907091013540.3352@localhost.localdomain> <7vab3d3dpc.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.01.0907091153130.3352@localhost.localdomain> <alpine.LFD.2.01.0907091344340.3352@localhost.localdomain> <alpine.LFD.2.01.0907091344530.3352@localhost.localdomain> <alpine.LFD.2.01.0907091347080.3352@localhost.localdomain>
 <alpine.LFD.2.01.0907091348490.3352@localhost.localdomain> <7v8wixw7s0.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.01.0907092028480.3352@localhost.localdomain> <7veisorkux.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Dmitry Potapov <dpotapov@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Kjetil Barvik <barvik@broadpark.no>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 11 05:04:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MPSt4-0002VS-0N
	for gcvg-git-2@gmane.org; Sat, 11 Jul 2009 05:04:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752770AbZGKDEQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jul 2009 23:04:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752176AbZGKDEQ
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Jul 2009 23:04:16 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:50158 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751556AbZGKDEP (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Jul 2009 23:04:15 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n6B345jc028516
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 10 Jul 2009 20:04:06 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n6B345va025488;
	Fri, 10 Jul 2009 20:04:05 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <7veisorkux.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.967 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123093>



On Fri, 10 Jul 2009, Junio C Hamano wrote:
> 
> I actually was hoping to hear "Didn't you notice that this is the first
> function run by the pthread and its stack is zeroed by thread creation" or
> something clever like that ;-)

It's probably true that it is often zero in practice. I certainly saw no 
problems in my testing, even though I do have preloading on (partly for 
testing, partly because it actually helps a bit on my machine).

I also suspect that the way the whole 'cache_def' thing works, even if 
it's initialized with random crud, you'll probably never notice. There are 
all those safety rules that check that 'cache->track_flags' has to match 
the new value etc in order for the cache to be used. And even when it is 
used, it has no pointers in it, it has that static array and the lengths.

So I don't think you really even need to have the "it was zeroed by 
accident" explanation. It's probably as simple as "even if it is totally 
uninitialized, that will basically never trigger anything odd in 
practice".

Not to mention that the whole new index preloading addition was just a new 
safety feature that we didn't even use to have before - and one that only 
impacted an _optimization_ that didn't change semantics. So in the end: 
even in the really unlikely situation that the cache would have triggered, 
and returned an incorrect return value, the worst that would have happened 
would be that the preloading wasn't quite as efficient.

End result: you did well by noticing the lack of initializers, but I 
_really_ don't think it could probably ever possibly have mattered in 
practice.

			Linus
