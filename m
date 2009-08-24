From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: [PATCH] fix simple deepening of a repo
Date: Mon, 24 Aug 2009 23:30:46 +0100 (BST)
Message-ID: <alpine.LNX.2.00.0908242212260.26869@reaper.quantumfyre.co.uk>
References: <alpine.LFD.2.00.0908220106470.6044@xanadu.home> <alpine.LFD.2.00.0908232320410.6044@xanadu.home> <7vocq5q0j7.fsf@alter.siamese.dyndns.org> <alpine.LNX.2.00.0908240144530.28290@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, Nicolas Pitre <nico@cam.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Tue Aug 25 00:32:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mfi5g-0007vF-4d
	for gcvg-git-2@lo.gmane.org; Tue, 25 Aug 2009 00:32:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753869AbZHXWcV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Aug 2009 18:32:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753854AbZHXWcT
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Aug 2009 18:32:19 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:56303 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753794AbZHXWcR (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Aug 2009 18:32:17 -0400
Received: from neutron.quantumfyre.co.uk (neutron.quantumfyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id 51607693E6
	for <git@vger.kernel.org>; Mon, 24 Aug 2009 23:32:18 +0100 (BST)
Received: (qmail 19120 invoked by uid 103); 24 Aug 2009 23:30:46 +0100
Received: from reaper.quantumfyre.co.uk by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-2.05st 
 (clamdscan: 0.94.2/9729. spamassassin: 3.2.1. perlscan: 2.05st.  
 Clear:RC:1(212.159.54.234):. 
 Processed in 0.026281 secs); 24 Aug 2009 22:30:46 -0000
Received: from reaper.quantumfyre.co.uk (212.159.54.234)
  by neutron.quantumfyre.co.uk with SMTP; 24 Aug 2009 23:30:46 +0100
X-X-Sender: jp3@reaper.quantumfyre.co.uk
In-Reply-To: <alpine.LNX.2.00.0908240144530.28290@iabervon.org>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126978>

On Mon, 24 Aug 2009, Daniel Barkalow wrote:

> On Sun, 23 Aug 2009, Junio C Hamano wrote:
>
>> But it makes me wonder if this logic to filter refs is buying us anything.
>>
>>>  	for (rm = refs; rm; rm = rm->next) {
>>> +		nr_refs++;
>>>  		if (rm->peer_ref &&
>>>  		    !hashcmp(rm->peer_ref->old_sha1, rm->old_sha1))
>>>  			continue;
>> 		ALLOC_GROW(heads, nr_heads + 1, nr_alloc);
>> 		heads[nr_heads++] = rm;
>> 	}
>>
>> What is the point of not asking for the refs that we know are the same?
>
> This code is part of the original C implementation of fetch; I suspect the
> optimization was somehow in the shell version and made sense there,
> perhaps because there wasn't a quickfetch in the shell version or that
> there was some non-negligable per-ref cost in the code around there, since
> it was calling helper programs and such.

I don't remember copying it from the shell version but my memory is 
terrible, so I could easily be wrong.  The relevant commit message was:

"git-fetch2: remove ref_maps that are not interesting

Once we have the full list of ref_maps, remove any where the local
and remote sha1s are the same - as we don't need to do anything for
them."

So that doesn't help.  I was very concerned about performance though 
(which was why I wanted fetch in C in the first place), so may have added 
it to speed up fetches that have only updated a few refs - and I assume 
that quickfetch was something that came along later after you absorbed the 
work into the transport series?

> Anyway, I think it makes sense to remove the filtering from
> transport_fetch_refs(), like your patch does.
>
> If it makes a difference for the actual protocol, fetch_refs_via_pack()
> could filter them at that stage.

I think it would certainly be worth investigating the performance aspects 
... no time tonight, but maybe tomorrow.

-- 
Julian

  ---
Some circumstantial evidence is very strong, as when you find a trout in
the milk.
 		-- Thoreau
