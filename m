From: bdowning@lavos.net (Brian Downing)
Subject: Re: [PATCH] apply delta depth bias to already deltified objects
Date: Thu, 12 Jul 2007 10:20:16 -0500
Message-ID: <20070712152016.GB19073@lavos.net>
References: <alpine.LFD.0.999.0707120049120.32552@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu Jul 12 17:20:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I90T5-0006oD-HJ
	for gcvg-git@gmane.org; Thu, 12 Jul 2007 17:20:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758470AbXGLPU0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jul 2007 11:20:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758467AbXGLPU0
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jul 2007 11:20:26 -0400
Received: from gateway.insightbb.com ([74.128.0.19]:25613 "EHLO
	asav03.insightbb.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757765AbXGLPU0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jul 2007 11:20:26 -0400
Received: from 74-134-246-243.dhcp.insightbb.com (HELO mail.lavos.net) ([74.134.246.243])
  by asav03.insightbb.com with ESMTP; 12 Jul 2007 11:20:25 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AutRAH3jlUZKhvbzRmdsb2JhbACBS4VfiAgBAQE+
Received: by mail.lavos.net (Postfix, from userid 1000)
	id B2130309F31; Thu, 12 Jul 2007 10:20:16 -0500 (CDT)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.999.0707120049120.32552@xanadu.home>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52298>

On Thu, Jul 12, 2007 at 02:38:30AM -0400, Nicolas Pitre wrote:
> This apparently makes BRian's patological case worse (although better 
> than before his same-size-shallower patch), but I think that the 
> improvement in the general case is worth it.  Even Brian's pack gets 
> smaller so...

I've found why this makes my case worse, and I think it's correctable
and will benefit everything when fixed:

Let's say we've currently got a delta match of 11 bytes at depth 5.
So trg_entry->delta_size = 11 and trg_entry->depth = 5.  max_depth is
100.

Now let's say the next object we're comparing against is at depth 2
(src_entry->depth = 2).  Even if we can find a delta of the same size
we should take it.

Now, with Nico's new patch:

		max_size = trg_entry->delta_size * max_depth /
				(max_depth - trg_entry->depth + 1);

max_size is now 11.  So far so good.

Now, however, the other bias happens:

	max_size = max_size * (max_depth - src_entry->depth) / max_depth;

    max_size = 11 * (100 - 2) / 100;
    max_size = 1078 / 100;
    max_size = 10;

This was okay when max_size was always (trg_size/2 - 20) here, but now
it's cutting it off too much.  max_size is now 10, and we can't make
a better depth match of the same size anymore.

I think the second bias equation should be scaled so as not to take
effect unless (src_entry->depth [+ 1?] > trg_entry->depth).

Other than this flaw I think this patch looks great.

-bcd
