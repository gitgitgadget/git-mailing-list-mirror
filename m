From: Nicolas Pitre <nico@cam.org>
Subject: Re: Something is broken in repack
Date: Tue, 11 Dec 2007 08:49:32 -0500 (EST)
Message-ID: <alpine.LFD.0.99999.0712110832251.555@xanadu.home>
References: <9e4733910712071505y6834f040k37261d65a2d445c4@mail.gmail.com>
 <9e4733910712101825l33cdc2c0mca2ddbfd5afdb298@mail.gmail.com>
 <alpine.LFD.0.99999.0712102231570.555@xanadu.home>
 <9e4733910712102125w56c70c0cxb8b00a060b62077@mail.gmail.com>
 <9e4733910712102129v140c2affqf2e73e75855b61ea@mail.gmail.com>
 <9e4733910712102301p5e6c4165v6afb32d157478828@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>, gcc@gcc.gnu.org,
	Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 11 14:49:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J25Uh-0005DP-PI
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 14:49:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752753AbXLKNte (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 08:49:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752719AbXLKNte
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 08:49:34 -0500
Received: from relais.videotron.ca ([24.201.245.36]:50294 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752473AbXLKNtd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 08:49:33 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JSW00D0712KNYH0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 11 Dec 2007 08:49:32 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <9e4733910712102301p5e6c4165v6afb32d157478828@mail.gmail.com>
User-Agent: Alpine 0.99999 (LFD 814 2007-11-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67855>

On Tue, 11 Dec 2007, Jon Smirl wrote:

> Switching to the Google perftools malloc
> http://goog-perftools.sourceforge.net/
> 
> 10%   30  828M
> 20%   15  831M
> 30%   10  834M
> 40%   50  1014M
> 50%   80  1086M
> 60%   80  1500M
> 70% 200  1.53G
> 80% 200  1.85G
> 90% 260  1.87G
> 95% 520  1.97G
> 100% 1335 2.24G
> 
> Google allocator knocked 600MB off from memory use.
> Memory consumption did not fall during the write out phase like it did with gcc.
> 
> Since all of this is with the same code except for changing the
> threading split, those runs where memory consumption went to 4.5GB
> with the gcc allocator must have triggered an extreme problem with
> fragmentation.

Did you mean the glibc allocator?

> Total CPU time 196 CPU minutes vs 190 for gcc. Google's claims of
> being faster are not true.
> 
> So why does our threaded code take 20 CPU minutes longer (12%) to run
> than the same code with a single thread? Clock time is obviously
> faster. Are the threads working too close to each other in memory and
> bouncing cache lines between the cores? Q6600 is just two E6600s in
> the same package, the caches are not shared.

Of course there'll always be a certain amount of wasted cycles when 
threaded.  The locking overhead, the extra contention for IO, etc.  So 
12% overhead (3% per thread) when using 4 threads is not that bad I 
would say.

> Why does the threaded code need 2.24GB (google allocator, 2.85GB gcc)
> with 4 threads? But only need 950MB with one thread? Where's the extra
> gigabyte going?

I really don't know.

Did you try with pack.deltacachesize set to 1 ?

And yet, this is still missing the actual issue.  The issue being that 
the 2.1GB pack as a _source_ doesn't cause as much memory to be 
allocated even if the _result_ pack ends up being the same.

I was able to repack the 2.1GB pack on my machine which has 1GB of ram. 
Now that it has been repacked, I can't repack it anymore, even when 
single threaded, as it start crowling into swap fairly quickly.  It is 
really non intuitive and actually senseless that Git would require twice 
as much RAM to deal with a pack that is 7 times smaller.


Nicolas (still puzzled)
