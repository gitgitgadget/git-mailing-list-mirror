From: Wolfram Gloger <wmglo@dent.med.uni-muenchen.de>
Subject: Re: Something is broken in repack
Date: 14 Dec 2007 16:12:36 -0000
Message-ID: <20071214161236.3080.qmail@md.dent.med.uni-muenchen.de>
References: <alpine.LFD.0.9999.0712120826440.25032@woody.linux-foundation.org>
Cc: nico@cam.org, jonsmirl@gmail.com, gitster@pobox.com,
	gcc@gcc.gnu.org, git@vger.kernel.org
To: torvalds@linux-foundation.org
X-From: git-owner@vger.kernel.org Fri Dec 14 17:13:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3D9p-0005CZ-8V
	for gcvg-git-2@gmane.org; Fri, 14 Dec 2007 17:13:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756778AbXLNQMi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Dec 2007 11:12:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754947AbXLNQMi
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Dec 2007 11:12:38 -0500
Received: from md.dent.med.uni-muenchen.de ([138.245.179.2]:56362 "HELO
	md.dent.med.uni-muenchen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1756241AbXLNQMi (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Dec 2007 11:12:38 -0500
Received: (qmail 3081 invoked by uid 211); 14 Dec 2007 16:12:36 -0000
In-reply-to: <alpine.LFD.0.9999.0712120826440.25032@woody.linux-foundation.org>
	(message from Linus Torvalds on Wed, 12 Dec 2007 08:37:10 -0800 (PST))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68314>

Hi,

> Note that delta following involves patterns something like
> 
>    allocate (small) space for delta
>    for i in (1..depth) {
> 	allocate large space for base
> 	allocate large space for result
> 	.. apply delta ..
> 	free large space for base
> 	free small space for delta
>    }
> 
> so if you have some stupid heap algorithm that doesn't try to merge and 
> re-use free'd spaces very aggressively (because that takes CPU time!),

ptmalloc2 (in glibc) _per arena_ is basically best-fit.  This is the
best known general strategy, but it certainly cannot be the best in
every case.

> you 
> might have memory usage be horribly inflated by the heap having all those 
> holes for all the objects that got free'd in the chain that don't get 
> aggressively re-used.

It depends how large 'large' is -- if it exceeds the mmap() threshold
(settable with mallopt(M_MMAP_THRESHOLD, ...))
the 'large' spaces will be allocated with mmap() and won't cause
any internal fragmentation.
It might pay to experiment with this parameter if it is hard to
avoid the alloc/free large space sequence.

> Threaded memory allocators then make this worse by probably using totally 
> different heaps for different threads (in order to avoid locking), so they 
> will *all* have the fragmentation issue.

Indeed.

Could someone perhaps try ptmalloc3
(http://malloc.de/malloc/ptmalloc3-current.tar.gz) on this case?

Thanks,
Wolfram.
