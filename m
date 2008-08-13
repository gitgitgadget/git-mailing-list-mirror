From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: pack operation is thrashing my server
Date: Wed, 13 Aug 2008 07:59:44 -0700
Message-ID: <20080813145944.GB3782@spearce.org>
References: <a6b6acf60808101247r4fea978ft6d2cdc53e1f99c0e@mail.gmail.com> <20080811030444.GC27195@spearce.org> <a6b6acf60808110043t76dc0ae6l428c5da473d79c71@mail.gmail.com> <87vdy71i6w.fsf@basil.nowhere.org> <1EE44425-6910-4C37-9242-54D0078FC377@adacore.com> <alpine.LFD.1.10.0808131024460.4352@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Geert Bosch <bosch@adacore.com>, Andi Kleen <andi@firstfloor.org>,
	Ken Pratt <ken@kenpratt.net>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed Aug 13 17:01:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTHqj-0007JH-Qa
	for gcvg-git-2@gmane.org; Wed, 13 Aug 2008 17:01:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752986AbYHMO7q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2008 10:59:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752998AbYHMO7p
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Aug 2008 10:59:45 -0400
Received: from george.spearce.org ([209.20.77.23]:53647 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752978AbYHMO7p (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2008 10:59:45 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 818D538375; Wed, 13 Aug 2008 14:59:44 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0808131024460.4352@xanadu.home>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92225>

Nicolas Pitre <nico@cam.org> wrote:
> You'll have memory usage issues whenever such objects are accessed, 
> loose or not.  However, once those big objects are packed once, they can 
> be repacked (or streamed over the net) without really "accessing" them.  
> Packed object data is simply copied into a new pack in that case which 
> is less of an issue on memory usage, irrespective of the original pack 
> size.

And fortunately here we actually do stream the objects we have
chosen to reuse from the pack.  We don't allocate the entire thing
in memory.  Its probably the only place in all of Git where we can
handle a 16 GB (after compression) object on a machine with only
2 GB of memory and no swap.

Where little memory systems get into trouble with already packed
repositories is enumerating the objects to include in the pack.
This can still blow out their physical memory if the number of
objects to pack is high enough.  We need something like 160 bytes
of memory (my own memory is fuzzy on that estimate) per object.
Have 500k objects and its suddenly something quite real in terms
of memory usage.

-- 
Shawn.
