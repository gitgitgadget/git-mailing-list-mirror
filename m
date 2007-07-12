From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] apply delta depth bias to already deltified objects
Date: Thu, 12 Jul 2007 12:27:02 -0400 (EDT)
Message-ID: <alpine.LFD.0.999.0707121146550.32552@xanadu.home>
References: <alpine.LFD.0.999.0707120049120.32552@xanadu.home>
 <20070712152016.GB19073@lavos.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Brian Downing <bdowning@lavos.net>
X-From: git-owner@vger.kernel.org Thu Jul 12 18:27:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I91VV-0008UM-Gb
	for gcvg-git@gmane.org; Thu, 12 Jul 2007 18:27:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764750AbXGLQ1G (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jul 2007 12:27:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764504AbXGLQ1F
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jul 2007 12:27:05 -0400
Received: from relais.videotron.ca ([24.201.245.36]:25103 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764175AbXGLQ1D (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jul 2007 12:27:03 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JL200LEZR12CAE0@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 12 Jul 2007 12:27:03 -0400 (EDT)
In-reply-to: <20070712152016.GB19073@lavos.net>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52302>

On Thu, 12 Jul 2007, Brian Downing wrote:

> On Thu, Jul 12, 2007 at 02:38:30AM -0400, Nicolas Pitre wrote:
> > This apparently makes BRian's patological case worse (although better 
> > than before his same-size-shallower patch), but I think that the 
> > improvement in the general case is worth it.  Even Brian's pack gets 
> > smaller so...
> 
> I've found why this makes my case worse, and I think it's correctable
> and will benefit everything when fixed:
> 
> Let's say we've currently got a delta match of 11 bytes at depth 5.
> So trg_entry->delta_size = 11 and trg_entry->depth = 5.  max_depth is
> 100.
> 
> Now let's say the next object we're comparing against is at depth 2
> (src_entry->depth = 2).  Even if we can find a delta of the same size
> we should take it.
> 
> Now, with Nico's new patch:
> 
> 		max_size = trg_entry->delta_size * max_depth /
> 				(max_depth - trg_entry->depth + 1);
> 
> max_size is now 11.  So far so good.
> 
> Now, however, the other bias happens:
> 
> 	max_size = max_size * (max_depth - src_entry->depth) / max_depth;
> 
>     max_size = 11 * (100 - 2) / 100;
>     max_size = 1078 / 100;
>     max_size = 10;

Hmmm... Integer truncation errors.

In theory, the allowed max_size should be slightly higher than what we 
got in the depth 5 case because this case is less deep.  So...

    max_size = trg_entry->delta_size * max_depth /
                    (max_depth - trg_entry->depth + 1);
    max_size = 11 * 100 / (100 - 5 + 1) = 11.4583

    max_size = max_size * (max_depth - src_entry->depth) / max_depth;
    max_size = 11.4583 * (100 - 2) / 100 = 11.2292

So the max_size, because the depth is less, is slightly higher.

> This was okay when max_size was always (trg_size/2 - 20) here, but now
> it's cutting it off too much.  max_size is now 10, and we can't make
> a better depth match of the same size anymore.
> 
> I think the second bias equation should be scaled so as not to take
> effect unless (src_entry->depth [+ 1?] > trg_entry->depth).

Better yet, the integer truncation error should be compensated for, with 
this:

    max_size =
        (trg_entry->delta_size * max_depth + max_depth - trg_entry->depth) /
                    (max_depth - trg_entry->depth + 1);


Nicolas
