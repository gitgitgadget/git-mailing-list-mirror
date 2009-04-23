From: Nicolas Pitre <nico@cam.org>
Subject: Re: dangling commits and blobs: is this normal?
Date: Thu, 23 Apr 2009 14:51:08 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0904231438280.6741@xanadu.home>
References: <450196A1AAAE4B42A00A8B27A59278E70ACE0502@EXCHANGE.trad.tradestation.com>
 <20090422152719.GA12881@coredump.intra.peff.net>
 <W0cjdA0pSHr_AbT2c-k5hDf7LyNvwkc38qIIhTtJJRwFnGBxaBsEiw@cipher.nrlssc.navy.mil>
 <alpine.LFD.2.00.0904221331450.6741@xanadu.home>
 <FcecxnoVg4H8G3MKjZgl2T6zCGDer4yYyScIgaweFTNgDCKG65Xiig@cipher.nrlssc.navy.mil>
 <alpine.LFD.2.00.0904221548310.6741@xanadu.home>
 <20090422200502.GA14304@coredump.intra.peff.net>
 <064C9132-2E72-4665-A44D-A2F4194DAC2B@adacore.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Jeff King <peff@peff.net>, Brandon Casey <casey@nrlssc.navy.mil>,
	John Dlugosz <JDlugosz@TradeStation.com>, git@vger.kernel.org
To: Geert Bosch <bosch@adacore.com>
X-From: git-owner@vger.kernel.org Thu Apr 23 20:53:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lx42z-0007rl-PR
	for gcvg-git-2@gmane.org; Thu, 23 Apr 2009 20:53:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752901AbZDWSvq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Apr 2009 14:51:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752674AbZDWSvq
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Apr 2009 14:51:46 -0400
Received: from relais.videotron.ca ([24.201.245.36]:60982 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751632AbZDWSvq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Apr 2009 14:51:46 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KIK00M7KHP8G7E0@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 23 Apr 2009 14:51:08 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <064C9132-2E72-4665-A44D-A2F4194DAC2B@adacore.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117362>

On Thu, 23 Apr 2009, Geert Bosch wrote:

> 
> On Apr 22, 2009, at 16:05, Jeff King wrote:
> > The other tradeoff, mentioned by Matthieu, is not about speed, but about
> > rollover of files on disk. I think he would be in favor of a less
> > optimal pack setup if it meant rewriting the largest packfile less
> > frequently.
> > 
> > However, it may be reasonable to suggest that he just not manually "gc"
> > then. If he is not generating enough commits to warrant an auto-gc, then
> > he is probably not losing much by having loose objects. And if he is,
> > then auto-gc is already taking care of it.
> 
> For large repositories with lots of large files, git spends too much
> time copying large packs for relatively little gain. This is obvious when
> you include a few dozen large objects in any repository.
> Currently, there is no limit to the number of times this data may
> be copied. In particular, the average amount of I/O needed for
> changes of size X depends linearly on the size of the total repository.
> So, the mere presence of a couple of large objects has an large distributed
> overhead.

You can put a limit on the number of times this data is copied, and even 
set the limit to zero.  Just add a .keep file to your .pack file and 
that data will remain in stone.  Any further repack will consider only 
those newly added objects you may have.

> Wouldn't it be better to have a maximum of N packs, named
> pack_0 .. pack_(N - 1),  in the repository with each pack_i being
> between 2^i and 2^(i+1)-1 bytes large? We could even dispense
> completely with loose objects and instead have each git operation
> create a single new pack.

I suggested that already for large enough objects.  For small objects 
this makes no sense as you may accumulate too many of them and each one 
would need to be opened in order to find if it contains the desired 
object whereas currently you need a simple directory lookup.

> number of packs in the way described is useful and will lead to significant
> speedups, especially during large imports that currently require frequent
> repacking of the entire repository.

Others commented on that issue already.


Nicolas
