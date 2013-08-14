From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: duplicate objects in packfile
Date: Wed, 14 Aug 2013 14:50:01 -0400 (EDT)
Message-ID: <alpine.LFD.2.03.1308141425110.14472@syhkavp.arg>
References: <20130814181718.GA7911@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Aug 14 20:50:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V9g9A-0004di-9j
	for gcvg-git-2@plane.gmane.org; Wed, 14 Aug 2013 20:50:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932891Ab3HNSuG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Aug 2013 14:50:06 -0400
Received: from relais.videotron.ca ([24.201.245.36]:26295 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932840Ab3HNSuD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Aug 2013 14:50:03 -0400
Received: from xanadu.home ([70.83.209.44]) by VL-VM-MR001.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0MRJ00G6WAZDWXV2@VL-VM-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 14 Aug 2013 14:50:01 -0400 (EDT)
In-reply-to: <20130814181718.GA7911@sigill.intra.peff.net>
User-Agent: Alpine 2.03 (LFD 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232309>

On Wed, 14 Aug 2013, Jeff King wrote:

>   1. Is sha1_entry_pos wrong to barf on duplicate items in the index? If
>      so, do we want to fix it, or simply retire GIT_USE_LOOKUP?

I'd think that sha1_entry_pos should be more lenient here, especially if 
this doesn't compromize the overall git behavior.

>      Related, should we consider duplicate items in a packfile to be a
>      bogus packfile (and consequently notice and complain during
>      indexing)? I don't think it _hurts_ anything (aside from the assert
>      above), though it is of course wasteful.

This should indeed be considered a bogus pack file.  But we have a lot 
of code to be able to cope with bogus/corrupted pack files already.  
Handling this case as well would not hurt.

More importantly we should make sure the code we have doesn't generate 
such packs.

>   2. How can duplicate entries get into a packfile?
> 
>      Git itself should not generate duplicate entries (pack-objects is
>      careful to remove duplicates). Since these packs almost certainly
>      were pushed by a client, I wondered if "index-pack --fix-thin"
>      might accidentally add multiple copies of an object when it is the
>      preferred base for multiple objects, but it specifically avoids
>      doing so.

It is probably simpler than that.  An alternative pack-objects 
implementation could stream multiple copies of an object upon a push, 
and index-pack on the receiving end would simply store what's been 
received to disk as is without a fuss.

> Given the dates on the packs and how rare this is, I'm pretty much
> willing to chalk it up to a random bug (in git or otherwise) that does
> not any longer exist.

Possibly.  Given this is not compromizing the validity of the pack, and 
a simple repack "fixes" it, I would not worry too much about it.


Nicolas
