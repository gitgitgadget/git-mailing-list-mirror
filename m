From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [Patch] Prevent cloning over http from spewing
Date: Wed, 3 Jun 2009 12:15:55 -0700
Message-ID: <20090603191555.GL3355@spearce.org>
References: <20090602174229.GA14455@infidigm.net> <m3vdnda9f7.fsf@localhost.localdomain> <7vmy8p8947.fsf@alter.siamese.dyndns.org> <20090603191050.GB29564@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>, sparse@infidigm.net,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 03 21:16:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBvwS-0002ZB-67
	for gcvg-git-2@gmane.org; Wed, 03 Jun 2009 21:16:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754756AbZFCTPy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2009 15:15:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753685AbZFCTPx
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jun 2009 15:15:53 -0400
Received: from george.spearce.org ([209.20.77.23]:55328 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753229AbZFCTPx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2009 15:15:53 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 35AE6381D1; Wed,  3 Jun 2009 19:15:55 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20090603191050.GB29564@coredump.intra.peff.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120629>

Jeff King <peff@peff.net> wrote:
> On Wed, Jun 03, 2009 at 11:28:40AM -0700, Junio C Hamano wrote:
> > This is a toy patch; it hiccups for too long while getting each pack, and
> > it does not cleanly restore the display after it finishes, but I'll leave
> > it to interested readers as an exercise to properly do this using the
> > progress API.
> 
> This is much better, and I had roughly the same thought when I saw the
> original "stop http from spewing" patch. The output is confusing, but we
> need _some_ progress indicator.
> 
> Unfortunately, I don't think it's possible to give a "percent complete"
> because we are fetching as we walk, meaning we don't know where the end
> is until we get there (but I might be wrong, as I have never looked too
> closely at the http fetch code).

No, you are right Peff, you can't give a "percent complete" because
you don't know how much you need to fetch.

What we could do is try to organize the fetch queue by object type,
get all commits, then all trees, then blobs.  The blobs are the
bulk of the data, and by the time we hit them, we should be able
to give some estimate on progress because we have all of the ones
we need to fetch in our fetch queue.  But its only a "object count"
sort of thing, not a byte count.

When fetching a .idx or a .pack though, we should be able to show
progress... assuming the server sent us a Content-Length header.
If not, in the case of a pack, we could still show receive speed
like index-pack does.
 
>   1. summarize what we have fetched (N packs, N loose objects)
>   2. show what we are currently fetching (object or pack)
>   3. show the number of bytes retrieved for the current item
>   4. if the server provides content-length, show the percentage
>      completed for this object
>   5. show the current throughput

Yea.  My idea of sorting by type is also a lot more work... and
probably doesn't buy us any better output than what you just said.
:-)
 
-- 
Shawn.
