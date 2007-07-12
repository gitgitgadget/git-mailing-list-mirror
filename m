From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 3/5] Add pack-objects window memory usage limit
Date: Thu, 12 Jul 2007 00:25:54 -0400 (EDT)
Message-ID: <alpine.LFD.0.999.0707112356330.32552@xanadu.home>
References: <11842100581060-git-send-email-bdowning@lavos.net>
 <11842100582887-git-send-email-bdowning@lavos.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Brian Downing <bdowning@lavos.net>
X-From: git-owner@vger.kernel.org Thu Jul 12 06:26:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8qG4-0007Lm-RS
	for gcvg-git@gmane.org; Thu, 12 Jul 2007 06:26:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753924AbXGLE0A (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jul 2007 00:26:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751231AbXGLE0A
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jul 2007 00:26:00 -0400
Received: from relais.videotron.ca ([24.201.245.36]:16162 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753912AbXGLEZ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jul 2007 00:25:56 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JL100NX4TN72SC0@VL-MO-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 12 Jul 2007 00:25:55 -0400 (EDT)
In-reply-to: <11842100582887-git-send-email-bdowning@lavos.net>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52242>

On Wed, 11 Jul 2007, Brian Downing wrote:

> +		while (window_memory_limit &&
> +		       window_memory_usage > window_memory_limit &&
> +		       count > 1) {
> +			uint32_t tail = idx - count;
> +			if (tail > idx) {
> +				tail += window + 1;
> +				tail %= window;
> +			}
> +			free_unpacked(array + tail);
> +			count--;
> +		}

This is bogus.  Suppose window = 10 and only array entries 8, 9, 0, 1 
and 2 are populated.  In that case idx = 2 and count should be 4 (not 
counting the current entry yet).  You want to evict entry 8.

	-- tail = 2 - 4 = -2 (or a big uint32_t value)

	-- tail > idx is true

	-- tail += window + 1 -> -2 + 10 + 1 = 9

	-- tail %= window is useless

	-- you free entry 9 instead of entry 8.

Instead, you should do:

	tail = idx - count;
	if (tail > idx)
		tail += window;

or even:

	tail = (idx + window - count) % window;

>  		next:
>  		idx++;
> +		if (count < window)
> +			count++;

And of course you want:

	if (count + 1 < window)
		count++;

So not to count the new entry when the window gets full.


Nicolas
