From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] fix simple deepening of a repo
Date: Mon, 24 Aug 2009 20:18:45 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0908242001250.6044@xanadu.home>
References: <alpine.LFD.2.00.0908220106470.6044@xanadu.home>
 <alpine.LFD.2.00.0908232320410.6044@xanadu.home>
 <7vocq5q0j7.fsf@alter.siamese.dyndns.org>
 <alpine.LNX.2.00.0908240144530.28290@iabervon.org>
 <alpine.LNX.2.00.0908242212260.26869@reaper.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Tue Aug 25 02:19:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MfjkZ-0007Ml-3X
	for gcvg-git-2@lo.gmane.org; Tue, 25 Aug 2009 02:18:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753988AbZHYASt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Aug 2009 20:18:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753934AbZHYASt
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Aug 2009 20:18:49 -0400
Received: from relais.videotron.ca ([24.201.245.36]:50738 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753878AbZHYASt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Aug 2009 20:18:49 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KOW00G6WOV9UZG0@VL-MO-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 24 Aug 2009 20:18:45 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <alpine.LNX.2.00.0908242212260.26869@reaper.quantumfyre.co.uk>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126983>

On Mon, 24 Aug 2009, Julian Phillips wrote:

> On Mon, 24 Aug 2009, Daniel Barkalow wrote:
> 
> > On Sun, 23 Aug 2009, Junio C Hamano wrote:
> > 
> > > What is the point of not asking for the refs that we know are the same?
> > 
> > This code is part of the original C implementation of fetch; I suspect the
> > optimization was somehow in the shell version and made sense there,
> > perhaps because there wasn't a quickfetch in the shell version or that
> > there was some non-negligable per-ref cost in the code around there, since
> > it was calling helper programs and such.
> 
> I don't remember copying it from the shell version but my memory is terrible,
> so I could easily be wrong.  The relevant commit message was:
> 
> "git-fetch2: remove ref_maps that are not interesting
> 
> Once we have the full list of ref_maps, remove any where the local
> and remote sha1s are the same - as we don't need to do anything for
> them."
> 
> So that doesn't help.  I was very concerned about performance though (which
> was why I wanted fetch in C in the first place), so may have added it to speed
> up fetches that have only updated a few refs - and I assume that quickfetch
> was something that came along later after you absorbed the work into the
> transport series?

Well... Johan Herland says he has to deal with repositories containing 
around 50000 refs.  So in that case it is certainly a good idea not to 
send the whole 50000 refs back if only one or two (or a hundred) need to 
be updated.  And quickfetch() won't help in that case since its purpose 
is only to determine if there is anything at all to update.

> > Anyway, I think it makes sense to remove the filtering from
> > transport_fetch_refs(), like your patch does.
> > 
> > If it makes a difference for the actual protocol, fetch_refs_via_pack()
> > could filter them at that stage.
> 
> I think it would certainly be worth investigating the performance aspects ...
> no time tonight, but maybe tomorrow.

50000 refs * 45 bytes each = 2.25 MB.  That's all wasted bandwidth if 
only one ref needs updating.


Nicolas
