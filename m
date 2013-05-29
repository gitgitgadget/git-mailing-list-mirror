From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] patch-ids: check modified paths before calculating
 diff
Date: Wed, 29 May 2013 02:20:07 -0400
Message-ID: <20130529062007.GA11955@sigill.intra.peff.net>
References: <a7088a74742b71a01423f3ddc1a6c7fd89474ed8.1368969438.git.john@keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Kevin Bracey <kevin@bracey.fi>,
	Junio C Hamano <gitster@pobox.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Wed May 29 08:20:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhZkA-00034l-1f
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 08:20:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759465Ab3E2GUL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 May 2013 02:20:11 -0400
Received: from cloud.peff.net ([50.56.180.127]:36184 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756378Ab3E2GUL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 02:20:11 -0400
Received: (qmail 13845 invoked by uid 102); 29 May 2013 06:20:50 -0000
Received: from c-71-62-74-146.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.62.74.146)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 29 May 2013 01:20:50 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 29 May 2013 02:20:07 -0400
Content-Disposition: inline
In-Reply-To: <a7088a74742b71a01423f3ddc1a6c7fd89474ed8.1368969438.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225752>

On Sun, May 19, 2013 at 02:17:35PM +0100, John Keeping wrote:

> When using "git cherry" or "git log --cherry-pick" we often have a small
> number of commits on one side and a large number on the other.  In
> revision.c::cherry_pick_list we store the patch IDs for the small side
> before comparing the large side to this.
> 
> In this case, it is likely that only a small number of paths are touched
> by the commits on the smaller side of the range and by storing these we
> can ignore many commits on the other side before unpacking blobs and
> diffing them.

There are two observations that make your scheme work:

  1. For something like --cherry-pick, we do not even care about the
     actual patch-ids, only whether there are matches from the left and
     right sides.

  2. Comparing the sets of paths touched by two commits is often
     sufficient to realize they do not have the same patch-ids.

But I think those observations mean we can do even better than
calculating the real patch-id for the small side at all.

Imagine we have both "loose" and "strict" patch-ids, where the loose one
is much faster to compute, and has that property that a match _might_
mean we have the same strict patch-id, but a non-match means we
definitely do not have the same strict patch-id.

I think such a loose patch-id could just be a hash of the filenames that
were changed by the patch (e.g., the first 32-bits of the sha1 of the
concatenated filenames). Computing that should be about as expensive as
a tree-diff. Per observation 2 above, if two commits do not have the
same loose id, we know that they cannot possibly have the same strict
id.

Then we can forget about the smaller-side and bigger-side entirely, and
just do something like:

  1. Make a sorted list (or hash table) of loose ids for one side.

  2. For each commit on the other side, calculate its loose id and look
     that up in the sorted list. If no hits, we know that there is no
     match. For any hits, lazily calculate (and cache) the strict patch
     id for both sides and compare as usual.

In the best case, we compute no patch-ids at all. And even for the
average case, I'd expect our lazy calculation to only have to compute a
handful of ids.

-Peff
