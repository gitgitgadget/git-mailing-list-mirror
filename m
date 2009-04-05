From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 2/2] pack-objects: report actual number of threads to be
 used
Date: Sat, 04 Apr 2009 20:11:38 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0904042001540.6741@xanadu.home>
References: <1238864396-8964-1-git-send-email-dpmcgee@gmail.com>
 <1238864396-8964-2-git-send-email-dpmcgee@gmail.com>
 <20090404180601.GA14888@coredump.intra.peff.net>
 <449c10960904041120j38086192s25070912b0371c09@mail.gmail.com>
 <20090404232505.GA26906@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Dan McGee <dpmcgee@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Apr 05 02:13:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqFzC-0007na-6U
	for gcvg-git-2@gmane.org; Sun, 05 Apr 2009 02:13:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755057AbZDEALr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Apr 2009 20:11:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754454AbZDEALq
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Apr 2009 20:11:46 -0400
Received: from relais.videotron.ca ([24.201.245.36]:31490 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754105AbZDEALq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Apr 2009 20:11:46 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KHL00JHDPVE8330@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Sat, 04 Apr 2009 20:11:39 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20090404232505.GA26906@coredump.intra.peff.net>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115610>

On Sat, 4 Apr 2009, Jeff King wrote:

> On Sat, Apr 04, 2009 at 01:20:18PM -0500, Dan McGee wrote:
> 
> > > That makes sense to me, though I wonder if it may confuse and frustrate
> > > users who are expecting their awesome quad-core machine to be using 4
> > > threads when it only uses 2. Is it worth printing both values, or some
> > > indicator that we could have been using more?
> > 
> > I thought of this, but decided it wasn't really worth it. The default
> > window size of 10 makes it a very rare case that you will use fewer
> > than 4 threads. With the default, each thread needs a minimum of 20
> > objects, so even a 100-object repository would spawn the 4 threads.
> 
> Good point. Though by that logic, isn't your patch also not worth it
> (i.e., it is unlikely not to fill the threads, so the output will be the
> same with or without it)?
> 
> I still think yours is an improvement, though, however slight.

I don't think this is worth it at all.

This display is there mainly to confirm expected number of available 
threads.  The number of actually active threads is an implementation 
detail.  Sure if the number of objects is too low, or if the window size 
is too large, then the number of active threads will be lower.  But in 
practice it is also possible that with some patological object set you 
end up with 2 threads out of 4 completing very quickly and the other 2 
threads still busy with big objects and total remaining work set too 
small to split it further amongst idle threads, meaning that you'll end 
up with only 2 busy CPUs even though the display said 4 threads 
initially even with this patch.

In other words I don't think this patch is a good idea as we don't 
update the display with remaining active threads along the way.


Nicolas
