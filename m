From: Nicolas Pitre <nico@cam.org>
Subject: Re: Something is broken in repack
Date: Wed, 12 Dec 2007 10:48:12 -0500 (EST)
Message-ID: <alpine.LFD.0.99999.0712120743040.555@xanadu.home>
References: <9e4733910712071505y6834f040k37261d65a2d445c4@mail.gmail.com>  <9e4733910712101825l33cdc2c0mca2ddbfd5afdb298@mail.gmail.com>  <alpine.LFD.0.99999.0712102231570.555@xanadu.home>  <9e4733910712102125w56c70c0cxb8b00a060b62077@mail.gmail.com>  <9e4733910712102129v140c2affqf2e73e75855b61ea@mail.gmail.com>  <9e4733910712102301p5e6c4165v6afb32d157478828@mail.gmail.com>  <alpine.LFD.0.99999.0712110832251.555@xanadu.home>  <alpine.LFD.0.99999.0712110951070.555@xanadu.home>  <alpine.LFD.0.99999.0712111117440.555@xanadu.home>  <9e4733910712110821o7748802ag75d9df4be8b2c123@mail.gmail.com>  <alpine.LFD.0.99999.0712112057390.555@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>, gcc@gcc.gnu.org,  Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: gcc-return-142934-gcc=m.gmane.org@gcc.gnu.org Wed Dec 12 16:49:50 2007
Return-path: <gcc-return-142934-gcc=m.gmane.org@gcc.gnu.org>
Envelope-to: gcc@gmane.org
Received: from sourceware.org ([209.132.176.174])
	by lo.gmane.org with smtp (Exim 4.50)
	id 1J2TpT-0002xZ-WA
	for gcc@gmane.org; Wed, 12 Dec 2007 16:49:00 +0100
Received: (qmail 5163 invoked by alias); 12 Dec 2007 15:48:40 -0000
Received: (qmail 5155 invoked by uid 22791); 12 Dec 2007 15:48:40 -0000
X-Spam-Check-By: sourceware.org
Received: from relais.videotron.ca (HELO relais.videotron.ca) (24.201.245.36)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Wed, 12 Dec 2007 15:48:29 +0000
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca  (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))  with ESMTP id <0JSY00LSQ18FT8G0@VL-MH-MR001.ip.videotron.ca> for  gcc@gcc.gnu.org; Wed, 12 Dec 2007 10:48:16 -0500 (EST)
In-reply-to: <alpine.LFD.0.99999.0712112057390.555@xanadu.home>
User-Agent: Alpine 0.99999 (LFD 814 2007-11-14)
Mailing-List: contact gcc-help@gcc.gnu.org; run by ezmlm
Precedence: bulk
List-Id: <gcc.gcc.gnu.org>
List-Unsubscribe: <mailto:gcc-unsubscribe-gcc=m.gmane.org@gcc.gnu.org>
List-Archive: <http://gcc.gnu.org/ml/gcc/>
List-Post: <mailto:gcc@gcc.gnu.org>
List-Help: <http://gcc.gnu.org/ml/>
Sender: gcc-owner@gcc.gnu.org
Delivered-To: mailing list gcc@gcc.gnu.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68054>

On Wed, 12 Dec 2007, Nicolas Pitre wrote:

> Add memory fragmentation to that and you have a clogged system.
> 
> Solution: 
> 
> 	pack.deltacachesize=1
> 	pack.windowmemory=16M
> 
> Limiting the window memory to 16MB will automatically shrink the window 
> size when big objects are encountered, therefore keeping much fewer of 
> those objects at the same time in memory, which in turn means they will 
> be processed much more quickly.  And somehow that must help with memory 
> fragmentation as well.

OK scrap that.

When I returned to the computer this morning, the repack was 
completed... with a 1.3GB pack instead.

So... The gcc repo apparently really needs a large window to efficiently 
compress those large objects.

But when those large objects are already well deltified and you repack 
again with a large window, somehow the memory allocator is way more 
involved, probably even 
more so when there are several threads in parallel amplifying the issue, 
and things probably get to a point of no return with regard to memory 
fragmentation after a while.

So... my conclusion is that the glibc allocator has fragmentation issues 
with this work load, given the notable difference with the Google 
allocator, which itself might not be completely immune to fragmentation 
issues of its own.  And because the gcc repo requires a large window of 
big objects to get good compression, then you're better not using 4 
threads to repack it with -a -f.  The fact that the size of the source 
pack has such an influence is probably only because the increased usage 
of the delta base object cache is playing a role in the global memory 
allocation pattern, allowing for the bad fragmentation issue to occur.

If you could run one last test with the mallinfo patch I posted, without 
the pack.windowmemory setting, and adding the reported values along with 
those from top, then we could formally conclude to memory fragmentation 
issues.

So I don't think Git itself is actually bad.  The gcc repo most 
certainly constitute a nasty use case for memory allocators, but I don't 
think there is much we can do about it besides possibly implementing our 
own memory allocator with active defragmentation where possible (read 
memcpy) at some point to give glibc's allocator some chance to breathe a 
bit more.

In the mean time you might have to use only one thread and lots of 
memory to repack the gcc repo, or find the perfect memory allocator to 
be used with Git.  After all, packing the whole gcc history to around 
230MB is quite a stunt but it requires sufficient resources to 
achieve it. Fortunately, like Linus said, such a wholesale repack is not 
something that most users have to do anyway.


Nicolas
