From: Nicolas Pitre <nico@cam.org>
Subject: Re: Packfile can't be mapped
Date: Mon, 28 Aug 2006 13:19:31 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0608281244380.3683@localhost.localdomain>
References: <9e4733910608271804j762960a8ud83654c78ebe009a@mail.gmail.com>
 <20060828024720.GD24204@spearce.org>
 <Pine.LNX.4.64.0608280014190.3683@localhost.localdomain>
 <20060828164222.GA22451@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 28 19:20:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GHkm0-00055a-Fz
	for gcvg-git@gmane.org; Mon, 28 Aug 2006 19:19:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750726AbWH1RTc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 Aug 2006 13:19:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750753AbWH1RTc
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Aug 2006 13:19:32 -0400
Received: from relais.videotron.ca ([24.201.245.36]:61578 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1750726AbWH1RTc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Aug 2006 13:19:32 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0J4P00CYLXGJL530@VL-MO-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 28 Aug 2006 13:19:31 -0400 (EDT)
In-reply-to: <20060828164222.GA22451@spearce.org>
X-X-Sender: nico@localhost.localdomain
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26167>

On Mon, 28 Aug 2006, Shawn Pearce wrote:

> Nicolas Pitre <nico@cam.org> wrote:
> > On Sun, 27 Aug 2006, Shawn Pearce wrote:
> > 
> > > I'm going to try to get tree deltas written to the pack sometime this
> > > week. That should compact this intermediate pack down to something
> > > that git-pack-objects would be able to successfully mmap into a
> > > 32 bit address space.  A complete repack with no delta reuse will
> > > hopefully generate a pack closer to 400 MB in size.  But I know
> > > Jon would like to get that pack even smaller.  :)
> > 
> > One thing to consider in your code (if you didn't implement that 
> > already) is to _not_ attempt any delta on any object whose size is 
> > smaller than 50 bytes, and then limit the maximum delta size to 
> > object_size/2 - 20 (use that for the last argument to diff-delta() and 
> > store the undeltified object when diff-delta returns NULL).  This way 
> > you'll avoid creating delta objects that are most likely to end up being 
> > _larger_ than the undeltified object.
> 
> So I added Nico's suggestions to fast-import and ran it on a small
> subset of the Mozilla repository (3424 blobs):
> 
>   naive always delta: 6652 KiB
>   Nico's suggestion:  6842 KiB

Hmmm...

> So Nico's suggestion of limiting delta size to (orig_len/2)-20 or
> not using deltas on blobs < 50 bytes actually added 190 KB to the
> output pack.  Since this sample is probably fairly representative
> of the rest of the repository's blobs I'm thinking we may see a 2.8%
> increase in size over the current 930 MB blob pack.  That's another
> 26 MB in our intermediate pack.  I don't think this suggestion is
> really worth including in fast-import right now...

The above is based on the assumption that undeltified blobs usually 
deflates to 50% the undeflated size or more, and that pure object data 
deflates better than delta data.  Then there is the 20 byte base object 
reference overhead for any deltas.  The 20 bytes is a hard fact.  The 
50% factor is a wild guess.  What I forgot to consider in the above 
formula is the fact that delta data gets deflated as well so the /2 
divisor is probably a bit too much (you could try orig_len*2/3 - 20, or 
orig-len - 20, and adjust the initial treshold so the limit value 
doesn't go negative).

If you are IO bound (I recall Jon mentioning something to that effect) 
then you could probably use some CPU cycles to always deflate the 
object, deflate the resulting delta, and pick the smallest between the 
two (don't forget the additional 20 bytes in the delta case).  Maybe the 
increased CPU usage won't justify this solution though.


Nicolas
