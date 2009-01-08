From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH/RFC] Allow writing loose objects that are corrupted in
 a pack file
Date: Wed, 7 Jan 2009 16:37:03 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0901071621340.3283@localhost.localdomain>
References: <20081209093627.77039a1f@perceptron>  <1231282320.8870.52.camel@starfruit>  <alpine.LFD.2.00.0901062005290.26118@xanadu.home>  <1231292360.8870.61.camel@starfruit>  <alpine.LFD.2.00.0901062026500.3057@localhost.localdomain>  <1231314099.8870.415.camel@starfruit>
  <alpine.LFD.2.00.0901070743070.3057@localhost.localdomain> <1231368935.8870.584.camel@starfruit> <alpine.LFD.2.00.0901071520330.3057@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nicolas Pitre <nico@cam.org>,
	=?ISO-8859-15?Q?Jan_Kr=FCger?= <jk@jk.gs>,
	Git ML <git@vger.kernel.org>
To: "R. Tyler Ballance" <tyler@slide.com>
X-From: git-owner@vger.kernel.org Thu Jan 08 01:39:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKivz-00066C-Sj
	for gcvg-git-2@gmane.org; Thu, 08 Jan 2009 01:39:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756484AbZAHAiS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jan 2009 19:38:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756289AbZAHAiS
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Jan 2009 19:38:18 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:52544 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756154AbZAHAiR (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Jan 2009 19:38:17 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n080b4g8017797
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 7 Jan 2009 16:37:05 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n080b3xH002068;
	Wed, 7 Jan 2009 16:37:04 -0800
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <alpine.LFD.2.00.0901071520330.3057@localhost.localdomain>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.949 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104858>



On Wed, 7 Jan 2009, Linus Torvalds wrote:
>
> >         > limit ~1.5GB -> corrupt file
> >         > limit ~3GB -> magically no longer corrupt.
> 
> That is interesting, although I also worry that there might be other 
> issues going on (ie since you've reported thigns magically fixing 
> themselves, maybe the ulimit tests just _happened_ to show that, even if 
> it wasn't the core reason).
> 
> BUT! This is definitely worth looking at.
> 
> For example, we do have some cases where we try to do "mmap()", and if it 
> fails, we try to free some memory and try again. In particular, in 
> xmmap(), if an mmap() fails - which may be due to running out of virtual 
> address space - we'll actually try to release some pack-file memory and 
> try again. Maybe there's a bug there - and it would be one that seldom 
> triggers for others.

Ho humm. We really do have some interesting things there. 

Is this a 64-bit machine? I didn't think OS X did that, but if there is 
some limited 64-bit support there, maybe "sizeof(void *)" is 8, then we 
default the default git pack-window to a pretty healthy 1GB.

I could easily see that if you have a virtual memory size limit of 1.5GB, 
and the pack window size is 1GB, we might have trouble. Because we could 
only keep one such pack window in memory at a time.

I have _not_ looked at the code, though. I'd have expected a SIGSEGV if we 
really had issues with the window handling.

Anyway, _if_ your system has 64-bit pointers, then _maybe_ something the 
default 1GB pack window causes problem.

If so, then adding a

	[core]
		packedgitwindowsize = 64M

might make a difference. It would certainly be very interesting to hear if 
there's any impact.

		Linus
