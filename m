From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 0/4] Honor core.deltaBaseCacheLimit during index-pack
Date: Tue, 15 Jul 2008 02:47:41 +0000
Message-ID: <20080715024741.GB1700@spearce.org>
References: <20080713011512.GB31050@spearce.org> <1216001267-33235-1-git-send-email-spearce@spearce.org> <alpine.LFD.1.10.0807132220570.12484@xanadu.home> <20080714031242.GA14542@spearce.org> <alpine.LSU.1.00.0807141216390.32392@wbgn129.biozentrum.uni-wuerzburg.de> <m31w1wu1hc.fsf@localhost.localdomain> <487B439F.8040902@op5.se> <alpine.DEB.1.00.0807141322140.8950@racer> <487B4BD8.5030208@op5.se> <alpine.LFD.1.10.0807142203530.12484@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Andreas Ericsson <ae@op5.se>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Stephan Hennig <mailing_list@arcor.de>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Jul 15 04:48:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIaau-0002l0-0K
	for gcvg-git-2@gmane.org; Tue, 15 Jul 2008 04:48:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756518AbYGOCrn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2008 22:47:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756391AbYGOCrn
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jul 2008 22:47:43 -0400
Received: from george.spearce.org ([209.20.77.23]:60124 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756253AbYGOCrm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2008 22:47:42 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id AB95E3836B; Tue, 15 Jul 2008 02:47:41 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0807142203530.12484@xanadu.home>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88502>

Nicolas Pitre <nico@cam.org> wrote:
> 
> Those delta chains aren't simple chained lists.  They are trees of 
> deltas where one object might be the base for an unlimited number of 
> deltas of depth 1, and in turn each of those deltas might constitute the 
> base for an unlimited number of deltas of depth 2, and so on.
> 
> So what the code does is to find out which objects are not deltas but 
> are the base for a delta.  Then, for each of them, all deltas having 
> given object for base are found and they are recursively resolved so 
> each resolved delta is then considered a possible base for more deltas, 
> etc.  In other words, those deltas are resolved by walking the delta 
> tree in a "depth first" fashion.
> 
> If we discard previous delta bases, we will have to recreate them each 
> time a delta sibling is processed.  And if those delta bases are 
> themselves deltas then you have an explosion of delta results to 
> re-compute.

Yes, it would be horrible if we had to recompute 10 deltas in order
to recover a previously discarded delta base in order to visit new
siblings.

But its even more horrible that we use 512M of memory in our working
set size on a 256M machine to process a pack that is only 300M in
size, due to long delta chains on large objects.  In such a case
the system will swap and perform fairly poorly due to the huge disk
IO necessary to keep moving the working set around.

We're better off keeping our memory usage low and recomputing
the delta base when we need to return to it to process a sibling.

Please.  Remember that index-pack, unlike unpack-objects, does not
hold the unresolved deltas in memory while processing the input.
It assumes the total size of the unresolved deltas may exceed
the available memory for our working set and writes them to disk,
to be read back in later during the resolving phase.

At some point it is possible for the completely inflated delta
chain to exceed the physical memory of the system.  As soon as you
do that you are committed to some form of swapping.  We can probably
do that better from the packfile by reinflating the super compressed
deltas than letting the OS page in huge tracts of the virtual address
space off the swap device.  Plus the OS does not need to expend disk
IO to swap out the pages, we have already spent that cost when we
wrote the pack file down to disk as part of our normal operation.

I don't like adding code either.  But I think I'm right.  We really
need to not allow index-pack to create these massive working sets
and assume the operating system is going to be able to handle
it magically.  Memory is not infinite, even if the Turing machine
theory claims it is.

-- 
Shawn.
