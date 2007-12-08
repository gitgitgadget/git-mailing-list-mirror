From: Nicolas Pitre <nico@cam.org>
Subject: Re: Something is broken in repack
Date: Fri, 07 Dec 2007 20:46:25 -0500 (EST)
Message-ID: <alpine.LFD.0.99999.0712072032410.555@xanadu.home>
References: <9e4733910712071505y6834f040k37261d65a2d445c4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 08 02:46:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0omI-0003Kg-5a
	for gcvg-git-2@gmane.org; Sat, 08 Dec 2007 02:46:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753682AbXLHBq1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Dec 2007 20:46:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754492AbXLHBq1
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Dec 2007 20:46:27 -0500
Received: from relais.videotron.ca ([24.201.245.36]:32233 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753650AbXLHBq0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Dec 2007 20:46:26 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JSP00GHRJLDNJK0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 07 Dec 2007 20:46:26 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <9e4733910712071505y6834f040k37261d65a2d445c4@mail.gmail.com>
User-Agent: Alpine 0.99999 (LFD 814 2007-11-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67494>

On Fri, 7 Dec 2007, Jon Smirl wrote:

> Using this config:
> [pack]
>         threads = 4
>         deltacachesize = 256M
>         deltacachelimit = 0

Since you have a different result according to the source pack used then 
those cache settings, even if there was a bug with them, are not 
significant.

> And the 330MB gcc pack for input
>  git repack -a -d -f  --depth=250 --window=250
> 
> complete seconds RAM
> 10%  47 1GB
> 20%  29 1Gb
> 30%  24 1Gb
> 40%  18 1GB
> 50%  110 1.2GB
> 60%  85 1.4GB
> 70%  195 1.5GB
> 80%  186 2.5GB
> 90%  489 3.8GB
> 95%  800 4.8GB
> I killed it because it started swapping
> 
> The mmaps are only about 400MB in this case.
> At the end the git process had 4.4GB of physical RAM allocated.

That's really bad.

> Starting from a highly compressed pack greatly aggravates the problem.

That is really interesting though.

> Starting with a 2GB pack of the same data my process size only grew to
> 3GB with 2GB of mmaps.

Which is quite reasonable, even if the same issue might still be there.

So the problem seems to be related to the pack access code and not the 
repack code.  And it must have something to do with the number of deltas 
being replayed.  And because the repack is attempting delta compression 
roughly from newest to oldest, and because old objects are typically in 
a deeper delta chain, then this might explain the logarithmic slowdown.

So something must be wrong with the delta cache in sha1_file.c somehow.


Nicolas
