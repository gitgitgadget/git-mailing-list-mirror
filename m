From: Jeff King <peff@peff.net>
Subject: Re: [Patch] Prevent cloning over http from spewing
Date: Wed, 3 Jun 2009 15:24:20 -0400
Message-ID: <20090603192420.GA29610@coredump.intra.peff.net>
References: <20090602174229.GA14455@infidigm.net> <m3vdnda9f7.fsf@localhost.localdomain> <7vmy8p8947.fsf@alter.siamese.dyndns.org> <20090603191050.GB29564@coredump.intra.peff.net> <20090603191555.GL3355@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>, sparse@infidigm.net,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Jun 03 21:24:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBw4h-0007BM-Hr
	for gcvg-git-2@gmane.org; Wed, 03 Jun 2009 21:24:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753050AbZFCTY1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2009 15:24:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752527AbZFCTY0
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jun 2009 15:24:26 -0400
Received: from peff.net ([208.65.91.99]:39779 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752058AbZFCTY0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2009 15:24:26 -0400
Received: (qmail 25319 invoked by uid 107); 3 Jun 2009 19:24:34 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 03 Jun 2009 15:24:34 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Jun 2009 15:24:20 -0400
Content-Disposition: inline
In-Reply-To: <20090603191555.GL3355@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120630>

On Wed, Jun 03, 2009 at 12:15:55PM -0700, Shawn O. Pearce wrote:

> What we could do is try to organize the fetch queue by object type,
> get all commits, then all trees, then blobs.  The blobs are the
> bulk of the data, and by the time we hit them, we should be able
> to give some estimate on progress because we have all of the ones
> we need to fetch in our fetch queue.  But its only a "object count"
> sort of thing, not a byte count.

That's clever, and I think an "object count" would be fine (after all,
that is all that git:// fetching provides). However, I'm not sure how it
would work in practice. When we follow a walk to a commit in a pack, do
we really want to try to pull _just_ that commit?

For one thing, we would need the server to support partial fetches (and
it is my assumption that we don't bother with that at all now).  I don't
know how widespread that is these days (and of course we would still
need to fall back to fetching the full pack). But even if we _could_,
would we get killed by http protocol overhead for each object? Certainly
it would be no worse than fetching a totally unpacked repo, but I kind
of assume such a fetch would be painful.

Or given that the packs should be organized by type, are you proposing
to fetch just the "commit part" as a single entity, then "tree part",
then the "blob part"? I'm a little hesitant to rely too much on what is
basically a performance heuristic for the pack organization (and god
forbid packv4 ever gets finished ;) ).

-Peff
