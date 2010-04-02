From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 6/7] diff: cache textconv output
Date: Fri, 2 Apr 2010 03:38:32 -0400
Message-ID: <20100402073832.GB2111@sigill.intra.peff.net>
References: <20100402000159.GA15101@coredump.intra.peff.net>
 <20100402001215.GF16462@coredump.intra.peff.net>
 <7vpr2il3mt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 02 09:38:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NxbSi-0002ZW-Hu
	for gcvg-git-2@lo.gmane.org; Fri, 02 Apr 2010 09:38:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759287Ab0DBHig (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Apr 2010 03:38:36 -0400
Received: from peff.net ([208.65.91.99]:57835 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759275Ab0DBHie (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Apr 2010 03:38:34 -0400
Received: (qmail 10290 invoked by uid 107); 2 Apr 2010 07:39:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Fri, 02 Apr 2010 03:39:09 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 02 Apr 2010 03:38:32 -0400
Content-Disposition: inline
In-Reply-To: <7vpr2il3mt.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143788>

On Fri, Apr 02, 2010 at 12:23:06AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Running a textconv filter can take a long time. It's
> > particularly bad for a large file which needs to be spooled
> > to disk, but even for small files, the fork+exec overhead
> > can add up for something like "git log -p".
> 
> Another reason that "log -p" gets benefit from caching is that you would
> typically end up running textconv twice on the same blob, once when you
> compare $commit:$path with $commit~1:$path, and again when you compare
> $commit~$n-1:$path with $commit~$n:$path (assuming that the $path didn't
> change between $commit~$n-1 and $commit~1).

Yep. I pointed out in one of my timing tests a slight slowdown in "git
show" when generating the cache. But for revision walking, it should
actually be faster, since you see each blob twice but cache after the
first time.

> It _might_ give you even better performance characteristics if you noice
> that you are walking history running many textconv, and cache the textconv
> result from the "older" (i.e. "one" side) tree in-core, until it is used
> in a "newer" (i.e. "two" side) tree, at which time you would evict it.

I doubt it is worth the effort. We are already caching the sha1 in-core
due to the notes mechanism. So we could really only save one object
retrieval. Which is already what a non-textconv diff will need to do, so
we should have performance on par with regular diffs at this point.

In fact, your optimization could be applied to all diff revision
walking, not just textconv, and you can halve the number of object
retrievals. The problem is that you may have blobs sitting in the
in-core cache as you walk many revisions, waiting for them to be changed
again. Depending on the locality of changes and the size of your
project, you won't be able to fit it all comfortably in memory, and will
end up discarding entries.

And all of that to save a few object retrievals, which are something
that git does very quickly already. Not to mention the ugly code that
would be involved.

-Peff
