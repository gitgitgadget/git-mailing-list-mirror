From: Nicolas Pitre <nico@cam.org>
Subject: Re: A look at some alternative PACK file encodings
Date: Thu, 07 Sep 2006 13:20:21 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0609071228560.18635@xanadu.home>
References: <20060907084158.25725.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: gitzilla@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 07 19:20:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GLNYA-00066i-VP
	for gcvg-git@gmane.org; Thu, 07 Sep 2006 19:20:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422636AbWIGRUX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Sep 2006 13:20:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422637AbWIGRUX
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Sep 2006 13:20:23 -0400
Received: from relais.videotron.ca ([24.201.245.36]:32618 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1422636AbWIGRUW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Sep 2006 13:20:22 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0J58007ZSG5XHXX0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 07 Sep 2006 13:20:21 -0400 (EDT)
In-reply-to: <20060907084158.25725.qmail@science.horizon.com>
X-X-Sender: nico@xanadu.home
To: linux@horizon.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26644>

On Thu, 7 Sep 2006, linux@horizon.com wrote:

> A few notes:
> 
> 
> Re: base-128 encodings, it's a pet peeve of mine that meny people, even
> while trying to save space, waste it by allowing redundant encodings.
> The optimal way, assming msbit=1 means "more", is
> 
> 	0x00 -> 0		0x01 -> 1
> 	0x7f -> 127		0x80 0x00 -> 128
> 	0x80 0x7f -> 255	0x81 0x00 -> 256
> 	0xfe 0x7f -> 16383	0xff 0x00 -> 16384
> 	0xff 0x7f -> 16511	0x80 0x00 0x00 -> 16512

Indeed.  But...

Since we already use 3 bit of object type and that most objects are 
larger than 15 bytes this means with 2 bytes we have 11 bits or up to 
2047.  With your encoding that would mean 2175.  So a byte would be 
saved only for objects whose size is between 2048 and 2175.  I don't 
know what is the proportion of objects that fall into that range in the 
average pack, but even for those objects that means a reduction of less 
than 0.1% with an average deflate rate of 50%.

And we can forget about cases where the size would require a fourth byte 
or more since saving a byte in those cases is even less significant.

So I don't think we would gain that much using that encoding 
unless/until the pack format is made completely incompatible due to 
other changes, and that's something we should try to avoid as much as 
possible anyway.


Nicolas
