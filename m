From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] refs: write packed_refs file using stdio
Date: Wed, 10 Sep 2014 07:39:48 -0400
Message-ID: <20140910113948.GA16224@peff.net>
References: <20140910100352.GA12164@peff.net>
 <54103437.2090305@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Sep 10 13:39:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XRgFf-0004EI-0F
	for gcvg-git-2@plane.gmane.org; Wed, 10 Sep 2014 13:39:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750899AbaIJLjv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Sep 2014 07:39:51 -0400
Received: from cloud.peff.net ([50.56.180.127]:46489 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750734AbaIJLjv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2014 07:39:51 -0400
Received: (qmail 22176 invoked by uid 102); 10 Sep 2014 11:39:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 10 Sep 2014 06:39:50 -0500
Received: (qmail 16243 invoked by uid 107); 10 Sep 2014 11:40:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 10 Sep 2014 07:40:10 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 10 Sep 2014 07:39:48 -0400
Content-Disposition: inline
In-Reply-To: <54103437.2090305@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256735>

On Wed, Sep 10, 2014 at 01:21:27PM +0200, Michael Haggerty wrote:

> > +	if (fclose(out))
> > +		die_errno("write error");
> > +	packed_ref_cache->lock->fd = -1;
> 
> It might be a minuscule bit safer to set `lock->fd = -1` *before*
> calling `fclose()`.

Yeah, I considered that. The worst case is a signal coming in between
the two calls (or a somebody calling die() between the two :) ). In that
case the lockfile code will close() the fd again, which should be a noop
(since nobody will have opened it in the interim...right?).

That "since" assumption is the dangerous part. But on the other hand, if
we unset the fd first, then the lockfile code may fail to close it if it
is called before the fclose() (definitely by a signal in this case). I
think there are platforms where that would cause us to fail to remove
the file, which is annoying.

So I dunno. We cannot be atomic here. I could go either way.

> TBH, it makes me uncomfortable having code outside of `lockfile.c`
> having this level of intimacy with lockfile objects.

I kind of agree.

> I think it would be better to have a
> 
>     FILE *fopen_lock_file(struct *lock_file, const char *mode);
> 
> that records the `FILE *` inside the `lockfile` instance, and to teach
> `commit_lock_file()` and its friends to call `fclose()` if the `FILE *`
> was created. I think that such a feature would encourage other lockfile
> users to use the more convenient and readable stdio API.

I was tempted by that. We could also do:

  if (fflush(out))
	die_errno("write error");
  if (commit_lock_file(...))
     ...

which sidesteps the issue. We do then have to _later_ call fclose(out)
to free the handle memory, which is going to want to close the fd again.
Putting us back in the "let's hope nobody opened it in the meantime"
case from above.

-Peff
