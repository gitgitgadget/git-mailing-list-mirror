From: Jeff King <peff@peff.net>
Subject: Re: Fix up ugly open-coded "alloc_nr()" user in object.c
Date: Sat, 16 Jun 2007 18:37:39 -0400
Message-ID: <20070616223738.GA19076@coredump.intra.peff.net>
References: <alpine.LFD.0.98.0706161024220.14121@woody.linux-foundation.org> <20070616182134.GA22003@coredump.intra.peff.net> <20070616221506.GA78651@dspnet.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Olivier Galibert <galibert@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 17 00:37:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hzgtu-0005E9-Vz
	for gcvg-git@gmane.org; Sun, 17 Jun 2007 00:37:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756456AbXFPWhl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Jun 2007 18:37:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756399AbXFPWhl
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Jun 2007 18:37:41 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2316 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756226AbXFPWhl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jun 2007 18:37:41 -0400
Received: (qmail 1338 invoked from network); 16 Jun 2007 22:37:55 -0000
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 16 Jun 2007 22:37:55 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 16 Jun 2007 18:37:39 -0400
Content-Disposition: inline
In-Reply-To: <20070616221506.GA78651@dspnet.fr.eu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50321>

On Sun, Jun 17, 2007 at 12:15:06AM +0200, Olivier Galibert wrote:

> > +	ALLOC_GROW(array->objects, array->nr, array->alloc);
> 
> Unless the ALLOC_GROW semantics are weird, shouldn't that be:
>   ALLOC_GROW(array->objects, array->nr+1, array->alloc);

The semantics are weird. They never seemed so to me before, since it was
replacing some "grow by 1" areas where it is natural to assume that you
need just one spot more. But the way Junio commented it and tweaked it,
it can handle arbitrary growth (which is much better), but that means we
are overly conservative about when to grow.

Junio, patch is below (call-sites using bare 'nr' need to be 'nr+1', but
I will fix those up in a separate patch since they are in next and this
is in master).

-- >8 --
fix ALLOC_GROW off-by-one

The ALLOC_GROW macro will never let us fill the array completely,
instead allocating an extra chunk if that would be the case. This is
because the 'nr' argument was originally treated as "how much we do have
now" instead of "how much do we want". The latter makes much more
sense because you can grow by more than one item.

This off-by-one never resulted in an error because it meant we were
overly conservative about when to allocate. Any callers which passed
"how we have now" need to be updated, or they will fail to allocate
enough.

Signed-off-by: Jeff King <peff@peff.net>
---
 cache.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/cache.h b/cache.h
index c914c1c..ed83d92 100644
--- a/cache.h
+++ b/cache.h
@@ -234,7 +234,7 @@ extern void verify_non_filename(const char *prefix, const char *name);
  */
 #define ALLOC_GROW(x, nr, alloc) \
 	do { \
-		if ((nr) >= alloc) { \
+		if ((nr) > alloc) { \
 			if (alloc_nr(alloc) < (nr)) \
 				alloc = (nr); \
 			else \
