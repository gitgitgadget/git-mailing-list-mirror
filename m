From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: fact-import: failed to apply delta
Date: Tue, 10 Feb 2009 15:09:50 -0800
Message-ID: <20090210230950.GX30949@spearce.org>
References: <alpine.LNX.1.00.0902101226580.19665@iabervon.org> <20090210191220.GT30949@spearce.org> <alpine.LNX.1.00.0902101427300.19665@iabervon.org> <20090210201203.GU30949@spearce.org> <alpine.LNX.1.00.0902101520240.19665@iabervon.org> <20090210212539.GV30949@spearce.org> <alpine.LNX.1.00.0902101628140.19665@iabervon.org> <20090210213612.GW30949@spearce.org> <7vprhqkjrr.fsf@gitster.siamese.dyndns.org> <7vfxillxiu.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 11 00:11:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LX1l8-0000QR-EO
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 00:11:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756060AbZBJXJv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 18:09:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755909AbZBJXJv
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 18:09:51 -0500
Received: from george.spearce.org ([209.20.77.23]:34357 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755593AbZBJXJu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 18:09:50 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 2035B38210; Tue, 10 Feb 2009 23:09:50 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7vfxillxiu.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109337>

Junio C Hamano <gitster@pobox.com> wrote:
> 
> On second thought, I think fast-import is the only program that plays
> funny games of feeding a packed_git that is *not* part of the real list of
> packed_git installed in the system to unpack_entry(), so probably your
> patch is a better idea.

Right, that was my thought.
 
> We really need a better comment in the codepath from gfi_unpack_entry() to
> unpack_entry() that there is a very unusual thing going on.

That whole code is hairy.  It already has more comments than code.
What more can I really say here other than maybe this?

diff --git a/fast-import.c b/fast-import.c
index 03b13e0..7bfb563 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1204,6 +1204,12 @@ static void *gfi_unpack_entry(
 		 */
 		p->pack_size = pack_size + 20;
 	}
+	/* DANGER, WILL ROBINSON DANGER !!!!
+	 *
+	 * unpack_entry() wasn't meant to be called the way we are
+	 * about to call it right here.  Be very careful, any sort
+	 * of assumption is probably wrong.
+	 */
 	return unpack_entry(p, oe->offset, &type, sizep);
 }
 
 
> By the way, strictly speaking, you need to release the delta_base_cache
> entries that is based on pack_data and nothing else, no?

Right.

But the hiccup of a checkpoint in terms of overall performance is
such a huge amount (due to needing to re-read the entire pack to
compute its final checksum) that the loss of the delta_base_cache
is pretty much a drop in the bucket here.

I can go back and add in a struct packed_git* and filter to only
those entries in the cache, but it doesn't seem worth it to me.

-- 
Shawn.
