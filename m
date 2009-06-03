From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [Patch] Prevent cloning over http from spewing
Date: Wed, 3 Jun 2009 12:32:06 -0700
Message-ID: <20090603193205.GM3355@spearce.org>
References: <20090602174229.GA14455@infidigm.net> <m3vdnda9f7.fsf@localhost.localdomain> <7vmy8p8947.fsf@alter.siamese.dyndns.org> <20090603191050.GB29564@coredump.intra.peff.net> <20090603191555.GL3355@spearce.org> <20090603192420.GA29610@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>, sparse@infidigm.net,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 03 21:32:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBwC7-0002us-89
	for gcvg-git-2@gmane.org; Wed, 03 Jun 2009 21:32:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753271AbZFCTcH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2009 15:32:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752581AbZFCTcF
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jun 2009 15:32:05 -0400
Received: from george.spearce.org ([209.20.77.23]:48078 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751985AbZFCTcE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2009 15:32:04 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 16402381D1; Wed,  3 Jun 2009 19:32:06 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20090603192420.GA29610@coredump.intra.peff.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120631>

Jeff King <peff@peff.net> wrote:
> On Wed, Jun 03, 2009 at 12:15:55PM -0700, Shawn O. Pearce wrote:
> 
> > What we could do is try to organize the fetch queue by object type,
> > get all commits, then all trees, then blobs.  The blobs are the
> > bulk of the data, and by the time we hit them, we should be able
> > to give some estimate on progress because we have all of the ones
> > we need to fetch in our fetch queue.  But its only a "object count"
> > sort of thing, not a byte count.
> 
> That's clever, and I think an "object count" would be fine (after all,
> that is all that git:// fetching provides). However, I'm not sure how it
> would work in practice. When we follow a walk to a commit in a pack, do
> we really want to try to pull _just_ that commit?

No, we pull the whole pack.  So the progress meter would have to
switch to do a content-length thing for the pack pull, then go back
to the object queue.

If that means we just pulled *all* of the blobs we have queued up,
great, we can probably actually whack them out of the queue once
the pack is down.  Actually, that's really smart to do, because
then we don't build up a massive list of objects when cloning a
very large repository like Gentoo.

By delaying trees/blobs, I meant delaying them for loose object
fetch only, not pack based fetch.

-- 
Shawn.
