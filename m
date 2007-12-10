From: Nicolas Pitre <nico@cam.org>
Subject: Re: Something is broken in repack
Date: Mon, 10 Dec 2007 14:56:21 -0500 (EST)
Message-ID: <alpine.LFD.0.99999.0712101434560.555@xanadu.home>
References: <9e4733910712071505y6834f040k37261d65a2d445c4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 10 20:56:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1ok8-0007IH-Im
	for gcvg-git-2@gmane.org; Mon, 10 Dec 2007 20:56:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753453AbXLJT4X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Dec 2007 14:56:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752568AbXLJT4X
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Dec 2007 14:56:23 -0500
Received: from relais.videotron.ca ([24.201.245.36]:55373 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752033AbXLJT4W (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Dec 2007 14:56:22 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JSU004FONDV3MQ0@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 10 Dec 2007 14:56:20 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <9e4733910712071505y6834f040k37261d65a2d445c4@mail.gmail.com>
User-Agent: Alpine 0.99999 (LFD 814 2007-11-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67749>

On Fri, 7 Dec 2007, Jon Smirl wrote:

> Using this config:
> [pack]
>         threads = 4
>         deltacachesize = 256M
>         deltacachelimit = 0
> 
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
> 
> Starting from a highly compressed pack greatly aggravates the problem.
> Starting with a 2GB pack of the same data my process size only grew to
> 3GB with 2GB of mmaps.

You said having reproduced the issue, albeit not as severe, with the 
Linux kernel repo.  I did just that:

# to get the default pack:
$ git repack -a -f -d

# first measurement with a repack from a default pack
$ /usr/bin/time git repack -a -f --window=256 --depth=256
2572.17user 5.87system 22:46.80elapsed 188%CPU (0avgtext+0avgdata 0maxresident)k
15720inputs+356640outputs (71major+264376minor)pagefaults 0swaps

# do it again to start from a highly packed pack
$ /usr/bin/time git repack -a -f --window=256 --depth=256
2573.53user 5.62system 22:45.60elapsed 188%CPU (0avgtext+0avgdata 0maxresident)k
29176inputs+356664outputs (210major+274887minor)pagefaults 0swaps

This is with pack.threads=2 on a P4 with HT, and I'm using the machine 
for other tasks as well, but all measured time is sensibly the same for 
both cases.  Virtual memory allocation never reached 700MB in both cases 
either.


Nicolas
