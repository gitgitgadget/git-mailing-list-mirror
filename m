From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: 'git gc --aggressive' effectively unusable
Date: Mon, 05 Apr 2010 17:07:32 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1004051615070.7232@xanadu.home>
References: <201004030005.35737.elendil@planet.nl>
 <p2gb4087cc51004031433xc57e52bbq733d1d3c5f37f238@mail.gmail.com>
 <201004040123.06877.elendil@planet.nl> <87oci0m5v4.fsf@catnip.gol.com>
 <87zl1js248.fsf@troilus.org> <20100404203850.GA8798@coredump.intra.peff.net>
 <20100404214944.GA15104@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Michael Poole <mdpoole@troilus.org>, Miles Bader <miles@gnu.org>,
	Michael Witten <mfwitten@gmail.com>,
	Frans Pop <elendil@planet.nl>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Apr 05 23:07:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NytWG-0003KL-N3
	for gcvg-git-2@lo.gmane.org; Mon, 05 Apr 2010 23:07:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756630Ab0DEVHg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Apr 2010 17:07:36 -0400
Received: from relais.videotron.ca ([24.201.245.36]:18988 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756589Ab0DEVHe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Apr 2010 17:07:34 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0L0F00H4W9CKJO60@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 05 Apr 2010 17:07:33 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20100404214944.GA15104@coredump.intra.peff.net>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144066>

On Sun, 4 Apr 2010, Jeff King wrote:

> On Sun, Apr 04, 2010 at 04:38:50PM -0400, Jeff King wrote:
> 
> > I packed Frans' sample kernel repo with "git gc --aggressive" last
> > night. It did finish after about 9 hours. I didn't take memory usage
> > measurements, but here's what time said:
> > 
> >   real    535m38.898s
> >   user    216m46.437s
> >   sys     0m24.186s
> > 
> > That's 3.6 hours of CPU time over almost 9 hours (on a dual-core
> > machine). The non-agressive pack was about 680M, and the result was
> > 480M. The machine has 2G of RAM, and not much else running. So I would
> > really not expect there to be much disk I/O required, but clearly we
> > were waiting quite a bit.
> > 
> > I'll try tweaking a few of the pack memory limits and try again.
> 
> Hmm, this may be relevant:
> 
>   http://thread.gmane.org/gmane.comp.version-control.git/67791/focus=94797
> 
> In my experiments, memory usage is increasing but valgrind doesn't
> leaks. So perhaps it is fragmentation in the memory allocator.

To verify this, simply try with pack.threads = 1.  That should help the 
memory allocator not to fragment memory allocation across threads 
randomly.

Also, going multithreaded _may_ be faster only if you can afford the 
increased memory usage.  Especially with gc --aggressive, each thread is 
adding its own share of memory usage in the delta window.

First thing to try for the biggest possible improvement is 
pack.threads=1.  On a quad core machine this means repacking 4 times 
slower, but this is certainly much faster than 100 times slower when the 
system starts swapping. That might even make the resulting pack a tad 
tighter due to delta windows not being fragmented across different 
threads.

If that is not enough, then try:

	pack.deltaCacheSize = 1
	core.packedGitWindowSize = 16m
	core.packedGitLimit = 128m

This should reduce Git's memory usage while making it slower without 
affecting the packing outcome.  Again "slower" could mean "much faster" 
if by reducing memory usage then swapping is completely avoided.

If that still doesn't help much, then the next tweaks will affect the 
packing result:

	pack.windowMemory = 256m

Here 256m is arbitrary and must be guessed from the size of the objects 
being packed.  The idea is to let smallish objects completely fill the 
search window (it has 250 entries by default with --aggressive) while 
not letting that many huge objects completely eat up all memory.  If 
there is still swapping going on then you can try 64m instead.  That 
means that if you have a large set of 1MB objects then the delta search 
window will be scaled down to less than 64 entries in that case.  This 
is why packing might be less optimal as there are fewer delta 
combinations being considered.

If this still doesn't prevent swapping then you should really consider 
installing more RAM.  There are fundamental object accounting structures 
that can hardly be shrunk such as struct object_entry in 
builtin/pack-objects.c, and one instance of such structure is needed for 
each object.  On a 64-bit machine this structure occupies 120 bytes, 
meaning 2M objects requires 240MB of RAM just for that.  The data set 
also has to fit in the file cache to avoid IO trashing.  So if your 
repository is larger than the available RAM then some trashing is almost 
unavoidable.  Sometimes a badly packed repository may require 2GB of 
disk space in the .git directory alone while the fully packed version is 
only a few hundred megabytes.  Such repositories may need to be repacked 
on a big machine first, before machines with less RAM are able to handle 
it afterwards.

Hope this helps.


Nicolas
