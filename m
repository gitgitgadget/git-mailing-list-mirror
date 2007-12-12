From: Nicolas Pitre <nico@cam.org>
Subject: Re: Something is broken in repack
Date: Wed, 12 Dec 2007 00:12:57 -0500 (EST)
Message-ID: <alpine.LFD.0.99999.0712112057390.555@xanadu.home>
References: <9e4733910712071505y6834f040k37261d65a2d445c4@mail.gmail.com>
 <9e4733910712101825l33cdc2c0mca2ddbfd5afdb298@mail.gmail.com>
 <alpine.LFD.0.99999.0712102231570.555@xanadu.home>
 <9e4733910712102125w56c70c0cxb8b00a060b62077@mail.gmail.com>
 <9e4733910712102129v140c2affqf2e73e75855b61ea@mail.gmail.com>
 <9e4733910712102301p5e6c4165v6afb32d157478828@mail.gmail.com>
 <alpine.LFD.0.99999.0712110832251.555@xanadu.home>
 <alpine.LFD.0.99999.0712110951070.555@xanadu.home>
 <alpine.LFD.0.99999.0712111117440.555@xanadu.home>
 <9e4733910712110821o7748802ag75d9df4be8b2c123@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>, gcc@gcc.gnu.org,
	Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 12 06:13:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2JuP-0003zX-K4
	for gcvg-git-2@gmane.org; Wed, 12 Dec 2007 06:13:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752323AbXLLFNB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2007 00:13:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752275AbXLLFNA
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Dec 2007 00:13:00 -0500
Received: from relais.videotron.ca ([24.201.245.36]:50010 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752198AbXLLFM7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2007 00:12:59 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JSX00FRD7TL1G10@VL-MO-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 12 Dec 2007 00:12:58 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <9e4733910712110821o7748802ag75d9df4be8b2c123@mail.gmail.com>
User-Agent: Alpine 0.99999 (LFD 814 2007-11-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67992>

On Tue, 11 Dec 2007, Jon Smirl wrote:

> On 12/11/07, Nicolas Pitre <nico@cam.org> wrote:
> > On Tue, 11 Dec 2007, Nicolas Pitre wrote:
> >
> > > OK, here's something else for you to try:
> > >
> > >       core.deltabasecachelimit=0
> > >       pack.threads=2
> > >       pack.deltacachesize=1
> > >
> > > With that I'm able to repack the small gcc pack on my machine with 1GB
> > > of ram using:
> > >
> > >       git repack -a -f -d --window=250 --depth=250
> > >
> > > and top reports a ~700m virt and ~500m res without hitting swap at all.
> > > It is only at 25% so far, but I was unable to get that far before.
> >
> > Well, around 55% memory usage skyrocketed to 1.6GB and the system went
> > deep into swap.  So I restarted it with no threads.
> >
> > Nicolas (even more puzzled)
> 
> On the plus side you are seeing what I see, so it proves I am not imagining it.

Well... This is weird.

It seems that memory fragmentation is really really killing us here.  
The fact that the Google allocator did manage to waste quite less memory 
is a good indicator already.

I did modify the progress display to show accounted memory that was 
allocated vs memory that was freed but still not released to the system.  
At least that gives you an idea of memory allocation and fragmentation 
with glibc in real time:

diff --git a/progress.c b/progress.c
index d19f80c..46ac9ef 100644
--- a/progress.c
+++ b/progress.c
@@ -8,6 +8,7 @@
  * published by the Free Software Foundation.
  */
 
+#include <malloc.h>
 #include "git-compat-util.h"
 #include "progress.h"
 
@@ -94,10 +95,12 @@ static int display(struct progress *progress, unsigned n, const char *done)
 	if (progress->total) {
 		unsigned percent = n * 100 / progress->total;
 		if (percent != progress->last_percent || progress_update) {
+			struct mallinfo m = mallinfo();
 			progress->last_percent = percent;
-			fprintf(stderr, "%s: %3u%% (%u/%u)%s%s",
-				progress->title, percent, n,
-				progress->total, tp, eol);
+			fprintf(stderr, "%s: %3u%% (%u/%u) %u/%uMB%s%s",
+				progress->title, percent, n, progress->total,
+				m.uordblks >> 18, m.fordblks >> 18,
+				tp, eol);
 			fflush(stderr);
 			progress_update = 0;
 			return 1;

This shows that at some point the repack goes into a big memory surge.  
I don't have enough RAM to see how fragmented memory gets though, since 
it starts swapping around 50% done with 2 threads.

With only 1 thread, memory usage grows significantly at around 11% with 
a pretty noticeable slowdown in the progress rate.

So I think the theory goes like this:

There is a block of big objects together in the list somewhere.  
Initially, all those big objects are assigned to thread #1 out of 4.  
Because those objects are big, they get really slow to delta compress, 
and storing them all in a window with 250 slots takes significant 
memory.

Threads 2, 3, and 4 have "easy" work loads, so they complete fairly 
quicly compared to thread #1.  But since the progress display is global 
then you won't notice that one thread is actually crawling slowly.

To keep all threads busy until the end, those threads that are done with 
their work load will steal some work from another thread, choosing the 
one with the largest remaining work.  That is most likely thread #1.  So 
as threads 2, 3, and 4 complete, they will steal from thread 1 and 
populate their own window with those big objects too, and get slow too.

And because all threads gets to work on those big objects towards the 
end, the progress display will then show a significant slowdown, and 
memory usage will almost quadruple.

Add memory fragmentation to that and you have a clogged system.

Solution: 

	pack.deltacachesize=1
	pack.windowmemory=16M

Limiting the window memory to 16MB will automatically shrink the window 
size when big objects are encountered, therefore keeping much fewer of 
those objects at the same time in memory, which in turn means they will 
be processed much more quickly.  And somehow that must help with memory 
fragmentation as well.

Setting pack.deltacachesize to 1 is simply to disable the caching of 
delta results entirely which will only slow down the writing phase, but 
I wanted to keep it out of the picture for now.

With the above settings, I'm currently repacking the gcc repo with 2 
threads, and memory allocation never exceeded 700m virt and 400m res, 
while the mallinfo shows about 350MB, and progress has reached 90% which 
has never occurred on this machine with the 300MB source pack so far.


Nicolas
