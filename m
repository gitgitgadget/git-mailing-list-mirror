From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Something is broken in repack
Date: Mon, 10 Dec 2007 15:05:53 -0500
Message-ID: <9e4733910712101205q218152a2td14a8931e63d2610@mail.gmail.com>
References: <9e4733910712071505y6834f040k37261d65a2d445c4@mail.gmail.com>
	 <alpine.LFD.0.99999.0712101434560.555@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Nicolas Pitre" <nico@cam.org>
X-From: git-owner@vger.kernel.org Mon Dec 10 21:07:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1ouM-0003AQ-6Z
	for gcvg-git-2@gmane.org; Mon, 10 Dec 2007 21:07:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757531AbXLJUF4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Dec 2007 15:05:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757451AbXLJUFz
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Dec 2007 15:05:55 -0500
Received: from wa-out-1112.google.com ([209.85.146.180]:59663 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755207AbXLJUFy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Dec 2007 15:05:54 -0500
Received: by wa-out-1112.google.com with SMTP id v27so3538958wah
        for <git@vger.kernel.org>; Mon, 10 Dec 2007 12:05:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=4nGSE0l2Xusq9LPEhvgCbUkABDw+9a+JCCW8sHFX4Hc=;
        b=JW5BDyf1UFDdmVMnmnJDD1Up3qAwT5mj+L2nWElHnR8W9NhWQqTPOnp+o9RThjSztur4PxOEhgu4r6ZoYsj2en3E5r+sKF/sgPFhT6+usx1KBuYQUQLrvZbUsvGE/KBcwqFvB+3DxxPcxe6iDKoLaAfCBn7MtlYAe8k8sFDDWpY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nMme6S49+lWTQKHl70KiBFqrlqwTivOhsZDKVp0j4CGB1qhPEGkfjesvmUlFK1m+pba2eLPFFk4sNFnnbtuayNe8mCuBConaGqx5Egd0wmA4qvpAcHqgOi7klVVGl/Sh8GGu7+bZZX7dMeCQYRxOyRXgL3oF7lnRxp9lZxdCnj8=
Received: by 10.115.54.1 with SMTP id g1mr755631wak.1197317153360;
        Mon, 10 Dec 2007 12:05:53 -0800 (PST)
Received: by 10.114.208.17 with HTTP; Mon, 10 Dec 2007 12:05:53 -0800 (PST)
In-Reply-To: <alpine.LFD.0.99999.0712101434560.555@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67750>

On 12/10/07, Nicolas Pitre <nico@cam.org> wrote:
> On Fri, 7 Dec 2007, Jon Smirl wrote:
>
> > Using this config:
> > [pack]
> >         threads = 4
> >         deltacachesize = 256M
> >         deltacachelimit = 0
> >
> > And the 330MB gcc pack for input
> >  git repack -a -d -f  --depth=250 --window=250
> >
> > complete seconds RAM
> > 10%  47 1GB
> > 20%  29 1Gb
> > 30%  24 1Gb
> > 40%  18 1GB
> > 50%  110 1.2GB
> > 60%  85 1.4GB
> > 70%  195 1.5GB
> > 80%  186 2.5GB
> > 90%  489 3.8GB
> > 95%  800 4.8GB
> > I killed it because it started swapping
> >
> > The mmaps are only about 400MB in this case.
> > At the end the git process had 4.4GB of physical RAM allocated.
> >
> > Starting from a highly compressed pack greatly aggravates the problem.
> > Starting with a 2GB pack of the same data my process size only grew to
> > 3GB with 2GB of mmaps.
>
> You said having reproduced the issue, albeit not as severe, with the
> Linux kernel repo.  I did just that:
>
> # to get the default pack:
> $ git repack -a -f -d
>
> # first measurement with a repack from a default pack
> $ /usr/bin/time git repack -a -f --window=256 --depth=256
> 2572.17user 5.87system 22:46.80elapsed 188%CPU (0avgtext+0avgdata 0maxresident)k
> 15720inputs+356640outputs (71major+264376minor)pagefaults 0swaps
>
> # do it again to start from a highly packed pack
> $ /usr/bin/time git repack -a -f --window=256 --depth=256
> 2573.53user 5.62system 22:45.60elapsed 188%CPU (0avgtext+0avgdata 0maxresident)k
> 29176inputs+356664outputs (210major+274887minor)pagefaults 0swaps
>
> This is with pack.threads=2 on a P4 with HT, and I'm using the machine
> for other tasks as well, but all measured time is sensibly the same for
> both cases.  Virtual memory allocation never reached 700MB in both cases
> either.
>

This is the mail about the kernel pack, the one you quoted is a gcc run.

The kernel repo has the same problem but not nearly as bad.

Starting from a default pack
 git repack -a -d -f  --depth=1000 --window=1000
Uses 1GB of physical memory

Now do the command again.
 git repack -a -d -f  --depth=1000 --window=1000
Uses 1.3GB of physical memory

I suspect the gcc repo has much longer revision chains than the kernel
one since the kernel repo is only a few years old. The Mozilla repo
contained revision chains with over 2,000 revisions. Longer revision
chains result in longer delta chains.

So what is allocating the extra memory? Either a function of the
number of entries in the chain, or related to accessing the chain
since a chain with more entries will need to be accessed more times.

I have a 168MB kernel pack now after 15 minutes of four cores at 100%.

Here's another observation, the gcc objects are larger. Kernel has
650K objects in 190MB, gcc has 870K objects in 330MB. Average gcc
object is 30% larger. How should the average kernel developer
interpret this?



>
> Nicolas
>


-- 
Jon Smirl
jonsmirl@gmail.com
