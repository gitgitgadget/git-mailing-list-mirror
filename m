From: Nicolas Pitre <nico@cam.org>
Subject: Re: Subject: [PATCH] git-merge-pack
Date: Thu, 06 Sep 2007 22:32:01 -0400 (EDT)
Message-ID: <alpine.LFD.0.9999.0709062220450.21186@xanadu.home>
References: <alpine.LFD.0.999.0709042355030.19879@evo.linux-foundation.org>
 <20070905074206.GA31750@artemis.corp> <87odgh0zn6.fsf@hades.wkstn.nix>
 <46DEF1FA.4050500@midwinter.com> <877in50y7p.fsf@hades.wkstn.nix>
 <alpine.LFD.0.9999.0709051438460.21186@xanadu.home>
 <7vr6lcj2zi.fsf@gitster.siamese.dyndns.org>
 <Pine.LNX.4.64.0709061651550.28586@racer.site>
 <7vk5r3adlx.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.0.999.0709061906010.5626@evo.linux-foundation.org>
 <7v1wdb9ymf.fsf_-_@gitster.siamese.dyndns.org>
 <alpine.LFD.0.9999.0709061942320.21186@xanadu.home>
 <7v7in38ce6.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Nix <nix@esperi.org.uk>, Steven Grimm <koreth@midwinter.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 07 04:32:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITTdk-0005YX-EF
	for gcvg-git@gmane.org; Fri, 07 Sep 2007 04:32:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932705AbXIGCcG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Sep 2007 22:32:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932704AbXIGCcG
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Sep 2007 22:32:06 -0400
Received: from relais.videotron.ca ([24.201.245.36]:16177 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932685AbXIGCcE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2007 22:32:04 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JNZ0025O8DD1F80@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 06 Sep 2007 22:32:02 -0400 (EDT)
In-reply-to: <7v7in38ce6.fsf@gitster.siamese.dyndns.org>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57964>

On Thu, 6 Sep 2007, Junio C Hamano wrote:

> Nicolas Pitre <nico@cam.org> writes:
> 
> > I wonder if this is the best way to go.  In the context of a really fast 
> > repack happening automatically after (or during) user interactive 
> > operations, the above seems a bit heavyweight and slow to me.
> 
> Honestly, I do not believe in that mode of operation that much.
> 
> "While the user is waiting for the EDITOR"?
> 
> Because you do not know how much time you will be given before
> you start, unless
> 
>  (1) your process can be snapshotted and you can restart at the
>      next chance; or
> 
>  (2) it is so cheap and you can afford to abort and start over
>      from scratch at the next chance; or
> 
>  (3) it is so quick that you can simply have the user wait until
>      you are done without adding too much latency to be annoying,
>      when you cannnot finish before the EDITOR come back;

I think we have to aim for #3.  "Automatic" certainly doesn't imply "can 
be slow".  It should be reasonably instantaneous, otherwise it'll become 
annoying quickly enough.  If it can't be (almost) instantaneous in 99% 
of normal cases, then I think it simply should be remain asynchronously 
througha manual invokation of 'git gc' and we only need to teach/remind 
people about it more strongly.

> >> An obvious next steps that can be done in parallel by interested
> >> parties would be:
> >> 
> >>  (1) come up with a way to give "name" aka "clustering cue" (I
> >>      think this is very hard);
> >
> > It is, and IMHO not worth it.  If you do it separately from the usual 
> > pack-objects process you'll perform extra IO and decompression when 
> > walking tree objects just to reconstruct those paths, becoming really 
> > slow by the context definition I provided above.
> 
> Well, I said "name" in quotes because you do _NOT_ have to give
> the real name.  I was not thinking about doing the actual tree
> traversal at all.  What you need to do is to come up with a
> token that is the same for the objects in the same deltification
> chain so that they cluster together, and that should be doable
> by looking at the delta chain patterns inside a packfile.

Obviously!  Sorry for being slow.

But I still think that a single repack pass should already be able to 
pick loose objects and selected (small) packs, and produce a pack with 
them all.  No need for a separate merge-pack I'd say.


Nicolas
