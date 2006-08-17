From: Nicolas Pitre <nico@cam.org>
Subject: Re: Huge win, compressing a window of delta runs as a unit
Date: Thu, 17 Aug 2006 12:33:21 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0608171220260.11359@localhost.localdomain>
References: <9e4733910608161020s6855140bs68aaab6e1bbd3bad@mail.gmail.com>
 <20060817040719.GC18500@spearce.org>
 <Pine.LNX.4.63.0608170943470.28360@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.63.0608171003020.28360@wbgn013.biozentrum.uni-wuerzburg.de>
 <9e4733910608170736y4863e0ebr55c6c822ae548cca@mail.gmail.com>
 <Pine.LNX.4.63.0608171738490.28360@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Jon Smirl <jonsmirl@gmail.com>, Shawn Pearce <spearce@spearce.org>,
	git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Aug 17 18:33:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GDkoA-0006QQ-9p
	for gcvg-git@gmane.org; Thu, 17 Aug 2006 18:33:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965059AbWHQQdX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Aug 2006 12:33:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965063AbWHQQdX
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Aug 2006 12:33:23 -0400
Received: from relais.videotron.ca ([24.201.245.36]:59722 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S965059AbWHQQdW
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Aug 2006 12:33:22 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0J4500ILSHZLBI60@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 17 Aug 2006 12:33:21 -0400 (EDT)
In-reply-to: <Pine.LNX.4.63.0608171738490.28360@wbgn013.biozentrum.uni-wuerzburg.de>
X-X-Sender: nico@localhost.localdomain
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25591>

On Thu, 17 Aug 2006, Johannes Schindelin wrote:

> Hi,
> 
> On Thu, 17 Aug 2006, Jon Smirl wrote:
> 
> > On 8/17/06, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > > At least, the delta-chains should be limited by size (_not_ by number of
> > > deltas: you can have huge deltas, and if you have to unpack 5 huge deltas
> > > before getting to the huge delta you really need, it takes really long).
> > 
> > This is not an obvious conclusion.
> 
> The big win is bought by having _one_ zlib stream for multiple deltas, 
> right?
> 
> So, everytime you want to access the _last_ delta in the chain, you unpack 
> _all_ of them.

This is the case whether deltas are separately deflated or not.

> This quite obvious conclusion is obviously your reason to 
> propose two packs, one for the archive of "old" objects, and one for the 
> "new" objects.

Old objects are usually further down the delta chain and also stored 
further from the beginning of the pack.  Hence "new" objects could still 
have quick access since even if a delta chain is all in the same zlib 
stream, it is likely that inflating the whole of the zlib stream to get 
"new" objects won't be necessary, just like it is done now where only 
the needed deltas are inflated.

> > As for public servers there is an immediate win in shifting to the new
> > pack format.  Three hour downloads vs one hour, plus the bandwidth
> > bills. Are the tools smart enough to say this is a newer pack format,
> > upgrade? It takes far less than two hours to upgrade your git install.
> 
> Have you thought about a non-upgraded client? The server has to repack in 
> that case, and if the client wants a clone, you might not even have the 
> time to kiss your server good-bye before it goes belly up.

Nah.  The only overhead for a server to feed an "old" pack format from a 
"new" pack file is to inflate and deflate some data.  That is not _that_ 
costly.


Nicolas
