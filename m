From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH] don't use mmap() to hash files
Date: Mon, 15 Feb 2010 00:05:37 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1002142328310.1946@xanadu.home>
References: <20100211234753.22574.48799.reportbug@gibbs.hungrycats.org>
 <37fcd2781002131409r4166e496h9d12d961a2330914@mail.gmail.com>
 <20100213223733.GP24809@gibbs.hungrycats.org>
 <20100214011812.GA2175@dpotapov.dyndns.org>
 <alpine.DEB.1.00.1002140249410.20986@pacific.mpi-cbg.de>
 <20100214024259.GB9704@dpotapov.dyndns.org>
 <alpine.DEB.1.00.1002141908150.20986@pacific.mpi-cbg.de>
 <37fcd2781002141106v761ce6e0kc5c5bdd5001f72a9@mail.gmail.com>
 <alpine.DEB.1.00.1002142021100.20986@pacific.mpi-cbg.de>
 <alpine.DEB.1.00.1002142025160.20986@pacific.mpi-cbg.de>
 <37fcd2781002141156n7e2b9673s1eb6c12869facdb2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Zygo Blaxell <zblaxell@esightcorp.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Thomas Rast <trast@student.ethz.ch>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 15 06:05:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ngt9V-0001MZ-Hb
	for gcvg-git-2@lo.gmane.org; Mon, 15 Feb 2010 06:05:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751729Ab0BOFFk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2010 00:05:40 -0500
Received: from relais.videotron.ca ([24.201.245.36]:31447 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751202Ab0BOFFj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2010 00:05:39 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KXV00MN4A5D2HH0@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 15 Feb 2010 00:05:37 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <37fcd2781002141156n7e2b9673s1eb6c12869facdb2@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139975>

On Sun, 14 Feb 2010, Dmitry Potapov wrote:

> 1. to introduce a configuration parameter that will define whether to use
> mmap() to hash files or not. It is a trivial change, but the real question
> is what default value for this option (should we do some heuristic based
> on filesize vs available memory?)

I don't like such kind of heuristic.  They're almost always wrong, and 
any issue is damn hard to reproduce. I tend to believe that mmap() works 
better by letting the OS paging in and out memory as needed while 
reading data into allocated memory is only going to force the system 
into swap.

> 2. to stream files in chunks. It is better because it is faster, especially on
> large files, as you calculate SHA-1 and zip data while they are in CPU
> cache. However, it may be more difficult to implement, because we have
> filters that should be apply to files that are put to the repository.

So?  "More difficult" when it is the right thing to do is no excuse not 
to do it and satisfy ourselves with an half solution.  Barely replacing 
mmap() with read() has drawbacks while the advantages aren't that many.  
Gaining a few speed percentage while making it less robust when memory 
is tight isn't such a great compromize to me.  BUT if you were to 
replace mmap() with read() and make the process chunked then you do 
improve both speed _and_ memory usage.

As to huge file: we have that core.bigFileThreshold variable now, and 
anything that crosses it should be considered "stream in / stream out" 
without further considerations.  That means no diff, no rename 
similarity estimates, no delta, no filter, no blame, no fancies.  If you 
have source code files that big then you do have a bigger problem 
already anyway.  Typical huge files are rarely manipulated, and when 
they do it is pretty unlikely to be compared with other versions using 
diff, and then that also means that you have the storage capacity and 
network bandwidth to deal with them.  Hence repository tightness is not 
your top concern in that case, but repack/checkout speed most likely is.

So big files should be streamed to a pack of their own at "git add" 
time.  Then repack will simply "reuse pack data" without delta 
compression attempts, meaning that they will be streamed into a 
single huge pack with no issue (this particular case is already 
supported in the code).

> 3. to improve Git to support huge files on computers with low memory.

That comes for free with #2.


Nicolas
