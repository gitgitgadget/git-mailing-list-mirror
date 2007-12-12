From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Something is broken in repack
Date: Wed, 12 Dec 2007 08:37:10 -0800 (PST)
Message-ID: <alpine.LFD.0.9999.0712120826440.25032@woody.linux-foundation.org>
References: <9e4733910712071505y6834f040k37261d65a2d445c4@mail.gmail.com> <9e4733910712101825l33cdc2c0mca2ddbfd5afdb298@mail.gmail.com> <alpine.LFD.0.99999.0712102231570.555@xanadu.home> <9e4733910712102125w56c70c0cxb8b00a060b62077@mail.gmail.com>  <9e4733910712102129v140c2affqf2e73e75855b61ea@mail.gmail.com> <9e4733910712102301p5e6c4165v6afb32d157478828@mail.gmail.com> <alpine.LFD.0.99999.0712110832251.555@xanadu.home> <alpine.LFD.0.99999.0712110951070.555@xanadu.home> <alpine.LFD.0.99999.0712111117440.555@xanadu.home>  <9e4733910712110821o7748802ag75d9df4be8b2c123@mail.gmail.com> <alpine.LFD.0.99999.0712112057390.555@xanadu.home> <alpine.LFD.0.99999.0712120743040.555@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jon Smirl <jonsmirl@gmail.com>, Junio C Hamano <gitster@pobox.com>,         gcc@gcc.gnu.org, Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>
X-From: gcc-return-142937-gcc=m.gmane.org@gcc.gnu.org Wed Dec 12 17:38:37 2007
Return-path: <gcc-return-142937-gcc=m.gmane.org@gcc.gnu.org>
Envelope-to: gcc@gmane.org
Received: from sourceware.org ([209.132.176.174])
	by lo.gmane.org with smtp (Exim 4.50)
	id 1J2Ub1-0000rz-7M
	for gcc@gmane.org; Wed, 12 Dec 2007 17:38:07 +0100
Received: (qmail 9332 invoked by alias); 12 Dec 2007 16:37:48 -0000
Received: (qmail 9322 invoked by uid 22791); 12 Dec 2007 16:37:47 -0000
X-Spam-Check-By: sourceware.org
Received: from smtp2.linux-foundation.org (HELO smtp2.linux-foundation.org) (207.189.120.14)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Wed, 12 Dec 2007 16:37:37 +0000
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55]) 	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lBCGbB5i020321 	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO); 	Wed, 12 Dec 2007 08:37:12 -0800
Received: from localhost (localhost [127.0.0.1]) 	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lBCGbAYC019123; 	Wed, 12 Dec 2007 08:37:10 -0800
In-Reply-To: <alpine.LFD.0.99999.0712120743040.555@xanadu.home>
X-MIMEDefang-Filter: lf$Revision: 1.188 $
Mailing-List: contact gcc-help@gcc.gnu.org; run by ezmlm
Precedence: bulk
List-Id: <gcc.gcc.gnu.org>
List-Unsubscribe: <mailto:gcc-unsubscribe-gcc=m.gmane.org@gcc.gnu.org>
List-Archive: <http://gcc.gnu.org/ml/gcc/>
List-Post: <mailto:gcc@gcc.gnu.org>
List-Help: <http://gcc.gnu.org/ml/>
Sender: gcc-owner@gcc.gnu.org
Delivered-To: mailing list gcc@gcc.gnu.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68072>



On Wed, 12 Dec 2007, Nicolas Pitre wrote:
> 
> So... my conclusion is that the glibc allocator has fragmentation issues 
> with this work load, given the notable difference with the Google 
> allocator, which itself might not be completely immune to fragmentation 
> issues of its own. 

Yes.

Note that delta following involves patterns something like

   allocate (small) space for delta
   for i in (1..depth) {
	allocate large space for base
	allocate large space for result
	.. apply delta ..
	free large space for base
	free small space for delta
   }

so if you have some stupid heap algorithm that doesn't try to merge and 
re-use free'd spaces very aggressively (because that takes CPU time!), you 
might have memory usage be horribly inflated by the heap having all those 
holes for all the objects that got free'd in the chain that don't get 
aggressively re-used.

Threaded memory allocators then make this worse by probably using totally 
different heaps for different threads (in order to avoid locking), so they 
will *all* have the fragmentation issue.

And if you *really* want to cause trouble for a memory allocator, what you 
should try to do is to allocate the memory in one thread, and free it in 
another, and then things can really explode (the freeing thread notices 
that the allocation is not in its thread-local heap, so instead of really 
freeing it, it puts it on a separate list of areas to be freed later by 
the original thread when it needs memory - or worse, it adds it to the 
local thread list, and makes it effectively totally impossible to then 
ever merge different free'd allocations ever again because the freed 
things will be on different heap lists!).

I'm not saying that particular case happens in git, I'm just saying that 
it's not unheard of. And with the delta cache and the object lookup, it's 
not at _all_ impossible that we hit the "allocate in one thread, free in 
another" case!

		Linus
