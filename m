From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: New features in gitk
Date: Thu, 1 Nov 2007 09:21:01 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0711010910090.3342@woody.linux-foundation.org>
References: <18211.59478.188419.397886@cargo.ozlabs.ibm.com>
 <alpine.LFD.0.999.0710272229430.30120@woody.linux-foundation.org>
 <18212.13862.637991.30536@cargo.ozlabs.ibm.com>
 <alpine.LFD.0.999.0710280943090.30120@woody.linux-foundation.org>
 <18217.47744.621850.100789@cargo.ozlabs.ibm.com>
 <alpine.LFD.0.999.0711010844260.3342@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Thu Nov 01 17:21:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IncnL-0007Y1-Nc
	for gcvg-git-2@gmane.org; Thu, 01 Nov 2007 17:21:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753250AbXKAQVH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2007 12:21:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753160AbXKAQVG
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Nov 2007 12:21:06 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:43696 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752077AbXKAQVF (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Nov 2007 12:21:05 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lA1GL2dq008837
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 1 Nov 2007 09:21:03 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lA1GL2tf004812;
	Thu, 1 Nov 2007 09:21:02 -0700
In-Reply-To: <alpine.LFD.0.999.0711010844260.3342@woody.linux-foundation.org>
X-Spam-Status: No, hits=-2.732 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62979>



On Thu, 1 Nov 2007, Linus Torvalds wrote:
> 
> The hot-cache numbers are already pretty damn good. But try this:
> 
> 	echo 3 > /proc/sys/vm/drop_caches
> 	gitk

Actually, do the above with a path limiter, to make it more obvious.

So try this on the kernel, and you'll see the difference even with a fast 
disk, and even if it's fully packed:

	echo 3 > /proc/sys/vm/drop_caches
	time git rev-list HEAD drivers/scsi | head -10

and now try it with --topo-order.

I get ten seconds with --topo-order (because it has to traverse the 
*whole* history even to just generate the first ten lines), while the 
non-topo-order case is *three*times* faster.

On my laptop, it's even more noticeable. I don't know quite why, but the 
non-topo-order case is actually faster on my laptop than on my desktop 
(will have to see what's up, but I suspect it's a result of they being at 
different points in history, and just bad luck wrt the top-of-history 
having happened to change drivers/scsi or not):

	[torvalds@t40 linux]$ time git rev-list HEAD drivers/scsi | head -10
	..
	real    0m0.688s

but with --topo-order it's much slower:

	[torvalds@t40 linux]$ time git rev-list --topo-order HEAD drivers/scsi | head -10
	..
	real    0m17.458s

See? You shouldn't care about CPU usage, you should care about IO costs! 
Those are the first-order effects.

In other words, if you can be incremental, we're talking about performance 
differences that are orders-of-magnitude. Not ten percent or something 
piddling like that! And the performance improvemens come for the cases 
that are the _problem_, rather than the cases that already work perfectly 
well.

				Linus
