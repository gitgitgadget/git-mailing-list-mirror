From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] Correct pack memory leak causing git gc to try to exceed
 ulimit
Date: Thu, 10 Jul 2008 01:37:25 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0807100119360.12484@xanadu.home>
References: <20080709071007.GA31974@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Jul 10 07:38:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGorI-0004xW-CB
	for gcvg-git-2@gmane.org; Thu, 10 Jul 2008 07:38:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751413AbYGJFh1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2008 01:37:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750902AbYGJFh1
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jul 2008 01:37:27 -0400
Received: from relais.videotron.ca ([24.201.245.36]:10466 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751306AbYGJFh0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2008 01:37:26 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K3R00450ZMDVW30@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 10 Jul 2008 01:37:25 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20080709071007.GA31974@spearce.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87940>

On Wed, 9 Jul 2008, Shawn O. Pearce wrote:

> When recursing to unpack a delta base we must unuse_pack() so that
> the pack window for the current object does not remain pinned in
> memory while the delta base is itself being unpacked and materialized
> for our use.
> 
> On a long delta chain of 50 objects we may need to access 6 different
> windows from a very large (>3G) pack file in order to obtain all
> of the delta base content.  If the process ulimit permits us to
> map/allocate only 1.5G we must release windows during this recursion
> to ensure we stay within the ulimit and transition memory from pack
> cache to standard malloc, or other mmap needs.
> 
> Inserting an unuse_pack() call prior to the recursion allows us to
> avoid pinning the current window, making it available for garbage
> collection if memory runs low.
> 
> This has been broken since at least before 1.5.1-rc1, and very
> likely earlier than that.  Its fixed now.  :)

Well well...  I suspect this might have been the cause of our strange 
out-of-memory issue when trying to repack the gcc repository a while 
ago.

I updated my copy of git://git.infradead.org/gcc.git and re-attempted a 
full repack with window=500 and depth=500, and this time it worked for 
me on a 32-bit machine!  Took about 6h30 single-threaded, and produced a 
mere 331MB pack file containing 1254664 objects across 142328 commits.


Nicolas
