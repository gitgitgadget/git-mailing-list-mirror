From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH/RFC] Allow writing loose objects that are corrupted in
 a pack file
Date: Wed, 7 Jan 2009 17:01:53 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0901071652490.3283@localhost.localdomain>
References: <20081209093627.77039a1f@perceptron>  <1231282320.8870.52.camel@starfruit>  <alpine.LFD.2.00.0901062005290.26118@xanadu.home>  <1231292360.8870.61.camel@starfruit>  <alpine.LFD.2.00.0901062026500.3057@localhost.localdomain>  <1231314099.8870.415.camel@starfruit>
  <alpine.LFD.2.00.0901070743070.3057@localhost.localdomain>  <1231368935.8870.584.camel@starfruit>  <alpine.LFD.2.00.0901071520330.3057@localhost.localdomain>  <alpine.LFD.2.00.0901071621340.3283@localhost.localdomain>
 <1231375780.8870.629.camel@starfruit>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nicolas Pitre <nico@cam.org>,
	=?ISO-8859-15?Q?Jan_Kr=FCger?= <jk@jk.gs>,
	Git ML <git@vger.kernel.org>
To: "R. Tyler Ballance" <tyler@slide.com>
X-From: git-owner@vger.kernel.org Thu Jan 08 02:04:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKjK0-0004TD-Af
	for gcvg-git-2@gmane.org; Thu, 08 Jan 2009 02:04:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752919AbZAHBDJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jan 2009 20:03:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751732AbZAHBDI
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Jan 2009 20:03:08 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:50199 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750905AbZAHBDH (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Jan 2009 20:03:07 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n0811s7p019306
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 7 Jan 2009 17:01:55 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n0811rJ0022556;
	Wed, 7 Jan 2009 17:01:53 -0800
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <1231375780.8870.629.camel@starfruit>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.949 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104864>



On Wed, 7 Jan 2009, R. Tyler Ballance wrote:
> 
> I was only mentioning OS X with regards to the Samba/NFS red herring,
> the rest of our operations are on 64-bit Linux machines.

Ahh, ok. Good. 

> > I could easily see that if you have a virtual memory size limit of 1.5GB, 
> > and the pack window size is 1GB, we might have trouble. Because we could 
> > only keep one such pack window in memory at a time.
> 
> The DEFAULT_PACKED_GIT_WINDOW_SIZE in our local builds is 256M, FWIW

Interesting. So you already had to lower it. However, now that you mention 
it, and now that I search for your emails about it on the mailing list (I 
don't normally read the mailing list except very occasionally), I see your 
patch that does

	#define DYNAMIC_WINDOW_SIZE_PERCENTAGE 0.85
	...
	packed_git_window_size = (unsigned int)(as->rlim_cur * DYNAMIC_WINDOW_SIZE_PERCENTAGE);

which is actually very bad.

It's bad for several reasons:

 - 85% of the virtual address space is actually pessimal.

   You need space for AT LEAST two full-sized windows, so you need less 
   than 50%.

 - the way that variable is used, it _has_ to be a multiple of the page 
   size. In fact, it needs to be a multiple of _twice_ the page size. So 
   just doing a random fraction of the rlimit is not correct.

Setting it in the .gitconfig does it right, though.

> > If so, then adding a
> > 
> > 	[core]
> > 		packedgitwindowsize = 64M
> > 
> > might make a difference. It would certainly be very interesting to hear if 
> > there's any impact.
> 
> I can try this still if you'd like, but it doesn't seem like that'd be
> the issue since we're already lowering the window size system-wide

Please do try, at least if your local git changes still match that patch I 
found, because that patch generates problems.

		Linus
