From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] diff-delta: bound hash list length to avoid O(m*n) behavior
Date: Wed, 01 Mar 2006 02:38:46 -0800
Message-ID: <7vmzgajvpl.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0602272110320.25336@localhost.localdomain>
	<7vhd6kq8lc.fsf@assigned-by-dhcp.cox.net>
	<7vbqwrq4yi.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0602281017241.25336@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 01 11:39:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FEOjy-0002sb-7z
	for gcvg-git@gmane.org; Wed, 01 Mar 2006 11:39:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964908AbWCAKit (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Mar 2006 05:38:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964910AbWCAKit
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Mar 2006 05:38:49 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:59045 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S964908AbWCAKis (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Mar 2006 05:38:48 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060301103606.EEEE17006.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 1 Mar 2006 05:36:06 -0500
To: Nicolas Pitre <nico@cam.org>
In-Reply-To: <Pine.LNX.4.64.0602281017241.25336@localhost.localdomain>
	(Nicolas Pitre's message of "Tue, 28 Feb 2006 12:05:59 -0500 (EST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16970>

Nicolas Pitre <nico@cam.org> writes:

>> I tried an experimental patch to cull collided hash buckets
>> very aggressively.  I haven't applied your last "reuse index"
>> patch, though -- I think that is orthogonal and I'd like to
>> leave that to the next round.
>
> It is indeed orthogonal and I think you could apply it to the next 
> branch without the other patches (it should apply with little problems).  
> This is an obvious and undisputable gain, even more if pack-objects is 
> reworked to reduce memory usage by keeping only one live index for 
> multiple consecutive deltaattempts.

Umm.  The hash-index is rather huge, isn't it?  I did not
realize it was two-pointer structure for every byte in the
source material, and we typically delta from larger to smaller,
so we will keep about 10x the unpacked source.  Until we swap
the windowing around, that means about 100x the unpacked source
with the default window size.

Also, I am not sure which one is more costly: hash-index
building or use of that to search inside target.  I somehow got
an impression that the former is relatively cheap, and that is
what is being cached here.

> Let's suppose the reference buffer has:
>  
> ***********************************************************************/
>...
> One improvement might consist of counting the number of consecutive 
> identical bytes when starting a compare, and manage to skip as many hash 
> entries (minus the block size) before looping again with more entries in 
> the same hash bucket.

Umm, again.  Consecutive identical bytes (BTW, I think "* * *"
and "** ** **" patterns have the same collision issues without
being consecutive bytes, so such an optimization may be trickier
and cost more), when emitted as literals, would compress well,
wouldn't they?  At the end of the day, I think what matters is
the size of deflated delta, since going to disk to read it out
is more expensive than deflating and applying.  I think you made
a suggestion along the same line, capping the max delta used by
try_delta() more precisely by taking the deflated size into
account.
