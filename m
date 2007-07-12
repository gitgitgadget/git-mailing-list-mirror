From: bdowning@lavos.net (Brian Downing)
Subject: Re: [PATCH 3/5] Add pack-objects window memory usage limit
Date: Thu, 12 Jul 2007 05:02:51 -0500
Message-ID: <20070712100251.GT4087@lavos.net>
References: <11842100581060-git-send-email-bdowning@lavos.net> <11842100582887-git-send-email-bdowning@lavos.net> <alpine.LFD.0.999.0707112356330.32552@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu Jul 12 12:03:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8vVu-0003wk-OE
	for gcvg-git@gmane.org; Thu, 12 Jul 2007 12:03:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759059AbXGLKDH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jul 2007 06:03:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758983AbXGLKDG
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jul 2007 06:03:06 -0400
Received: from gateway.insightbb.com ([74.128.0.19]:47839 "EHLO
	asav09.insightbb.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758388AbXGLKDF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jul 2007 06:03:05 -0400
Received: from 74-134-246-243.dhcp.insightbb.com (HELO mail.lavos.net) ([74.134.246.243])
  by asav09.insightbb.com with ESMTP; 12 Jul 2007 06:03:03 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AutRADCZlUZKhvbzRmdsb2JhbACBS4VfiAgBAQE+
Received: by mail.lavos.net (Postfix, from userid 1000)
	id 0283B309F31; Thu, 12 Jul 2007 05:02:52 -0500 (CDT)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.999.0707112356330.32552@xanadu.home>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52263>

On Thu, Jul 12, 2007 at 12:25:54AM -0400, Nicolas Pitre wrote:
> On Wed, 11 Jul 2007, Brian Downing wrote:
> 
> > +		while (window_memory_limit &&
> > +		       window_memory_usage > window_memory_limit &&
> > +		       count > 1) {
> > +			uint32_t tail = idx - count;
> > +			if (tail > idx) {
> > +				tail += window + 1;
> > +				tail %= window;
> > +			}
> > +			free_unpacked(array + tail);
> > +			count--;
> > +		}
> 
> This is bogus.  Suppose window = 10 and only array entries 8, 9, 0, 1 
> and 2 are populated.  In that case idx = 2 and count should be 4 (not 
> counting the current entry yet).  You want to evict entry 8.

The current idx has already been depopulated by the time that code is
run, and count is probably one higher than you are expecting, so this
does actually work.

However, looking at it again, I think if the window hasn't been saturated
yet in my current code count will be what you expect in this situation
and it will screw up as you describe.

Besides, it is admittedly clumsy as hell (a common affliction when
dealing with circular buffers for me it seems).  I'll see if I can get
something better that works.

Thanks,
-bcd
