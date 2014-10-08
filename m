From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 03/16] object_array: factor out slopbuf-freeing logic
Date: Wed, 8 Oct 2014 04:55:06 -0400
Message-ID: <20141008085506.GA16314@peff.net>
References: <20141003202045.GA15205@peff.net>
 <20141003202222.GC16293@peff.net>
 <5433CDC2.6000908@alum.mit.edu>
 <20141008073658.GC25250@peff.net>
 <5434F863.5080303@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Oct 08 10:55:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xbn1i-0003Xu-2v
	for gcvg-git-2@plane.gmane.org; Wed, 08 Oct 2014 10:55:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754192AbaJHIzL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Oct 2014 04:55:11 -0400
Received: from cloud.peff.net ([50.56.180.127]:56131 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752640AbaJHIzJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Oct 2014 04:55:09 -0400
Received: (qmail 8189 invoked by uid 102); 8 Oct 2014 08:55:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 08 Oct 2014 03:55:09 -0500
Received: (qmail 13221 invoked by uid 107); 8 Oct 2014 08:55:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 08 Oct 2014 04:55:09 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 08 Oct 2014 04:55:06 -0400
Content-Disposition: inline
In-Reply-To: <5434F863.5080303@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 08, 2014 at 10:40:03AM +0200, Michael Haggerty wrote:

> > The intent of this function is freeing memory, not clearing it for sane
> > reuse.  I think I'd be more in favor of a comment clarifying that. It is
> > a static function used only internally by the object-array code.
> 
> I guess the name reminded me of strbuf_release(), which returns the
> strbuf to its newly-initialized state (contrary to what api-strbuf.txt
> says, I just noticed). You're right that your function does no such
> thing, so it is self-consistent for it not to set ent->name to NULL.

Yeah, I had the same thought while writing it (and ended up with the
same analysis you do below).

> Functions *_clear() and clear_*():

I think these ones very clearly are about reinitializing to empty (and
it looks like we follow that rule, which is good).

If we were designing it now, I think strbuf_release() should probably be
called strbuf_clear(). Or maybe that would be too confusing, as it might
imply it is the same thing as strbuf_reset(). Yeesh. Naming is hard.

> Functions *_free() and free_*():
> 
> * Almost all of these free their arguments plus anything that their
> arguments point at.

Yes, that's the rule I think we try to follow.

> * Confusingly, free_ref_list() and free_pathspec() don't free their
> arguments, but rather only the things that their arguments points at.
> (Perhaps they should be renamed.)

Yeah, I would almost say free_pathspec should be called clear_pathspec.
Except it _only_ NULLs the array. It leaves "nr" set, which means that
anybody looking at it will still dereference a bogus pointer (but at
least it's NULL and not freed memory!).

The free_ref_list() function is on my todo list to get rid of as part of
the for-each-ref/branch/tag merger I'd like to do. But somehow that
keeps slipping further down my todo list rather than actually getting
finished. :(

> So while three out of four *_release() functions completely reinitialize
> their arguments, there is one that doesn't. And I couldn't find enough
> other functions that just free referenced memory without reinitializing
> their whole argument to establish a naming pattern. So I guess your
> function name is OK too.

I'm open to suggestions for totally new names for this concept (free
associated memory, do not reinitialize, but do not free the passed
pointer). But in the absence of one, I think release() is the least-bad.

-Peff
