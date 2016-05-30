From: Jeff King <peff@peff.net>
Subject: Re: How to cut extra liftime of expired loose objects
Date: Mon, 30 May 2016 14:24:06 -0400
Message-ID: <20160530182405.GA17253@sigill.intra.peff.net>
References: <574C6D9B.1080200@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Mon May 30 20:24:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7RrL-0006Ka-FU
	for gcvg-git-2@plane.gmane.org; Mon, 30 May 2016 20:24:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161841AbcE3SYK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 May 2016 14:24:10 -0400
Received: from cloud.peff.net ([50.56.180.127]:46116 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1161330AbcE3SYJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 May 2016 14:24:09 -0400
Received: (qmail 27751 invoked by uid 102); 30 May 2016 18:24:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 30 May 2016 14:24:08 -0400
Received: (qmail 16244 invoked by uid 107); 30 May 2016 18:24:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 30 May 2016 14:24:15 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 30 May 2016 14:24:06 -0400
Content-Disposition: inline
In-Reply-To: <574C6D9B.1080200@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295918>

On Mon, May 30, 2016 at 06:43:07PM +0200, Johannes Sixt wrote:

> I think there is logic somewhere in git gc or its minions that gives expired
> objects that have been packed a two weeks extra life time as loose objects.
> 
> That is, reachable loose objects are moved to a pack, but those objects that
> were packed, but become unreachable due to expired reflogs, are evicted from
> the pack and live for another two weeks or so as loose objects.

Sort of. The loose objects should get the mtime of the pack, which is
likely newer than 2 weeks. So it's not a 2-week extension, but it may
take up to 2 weeks for them to go away (and if the pack is already more
than 2 weeks old, the objects are dropped without even loosening).

> As a consequence of this, I always have a few thousand loose objects in my
> busy repositories, no matter how often I collect garbage. Is there a knob
> that removes the extra lease of life of objects without reducing the usual
> expiration times of reflogs etc?

gc.pruneExpire should do this.

I have run into this, too, and it interacts annoyingly with the
background-gc (which complains "you have too many objects; run
git-prune", leaves that in a .lock file, and then every subsequent
auto-gc spews it at me).

I think we should consider dropping the default time to something more
like 1 day. The 2-week period predates reflogs, I believe (OTOH, it does
save objects which you might have used with "git add" but never actually
committed).

-Peff
