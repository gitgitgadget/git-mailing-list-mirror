From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] refs.c: get_ref_cache: use a bucket hash
Date: Fri, 13 Nov 2015 19:01:18 -0500
Message-ID: <20151114000118.GB18260@sigill.intra.peff.net>
References: <20150316142026.GJ7847@inner.h.apk.li>
 <xmqq1tkosvpi.fsf@gitster.dls.corp.google.com>
 <20150316184040.GA8902@inner.h.apk.li>
 <20150317024005.GA26313@peff.net>
 <xmqqd248p4o9.fsf@gitster.dls.corp.google.com>
 <20150317054759.GA16860@peff.net>
 <20151113152915.GC16219@inner.h.apk.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Git Mailing List <git@vger.kernel.org>
To: Andreas Krey <a.krey@gmx.de>
X-From: git-owner@vger.kernel.org Sat Nov 14 01:01:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZxOHn-0002Y5-A6
	for gcvg-git-2@plane.gmane.org; Sat, 14 Nov 2015 01:01:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751143AbbKNABW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Nov 2015 19:01:22 -0500
Received: from cloud.peff.net ([50.56.180.127]:57356 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750908AbbKNABV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Nov 2015 19:01:21 -0500
Received: (qmail 19665 invoked by uid 102); 14 Nov 2015 00:01:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 13 Nov 2015 18:01:21 -0600
Received: (qmail 30006 invoked by uid 107); 14 Nov 2015 00:01:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 13 Nov 2015 19:01:51 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 13 Nov 2015 19:01:18 -0500
Content-Disposition: inline
In-Reply-To: <20151113152915.GC16219@inner.h.apk.li>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281277>

On Fri, Nov 13, 2015 at 04:29:15PM +0100, Andreas Krey wrote:

> > Likewise, I think dir.c:remove_dir_recurse is in a similar boat.
> > Grepping for resolve_gitlink_ref, it looks like there may be others,
> > too.
> 
> Can't we handle this in resolve_gitlink_ref itself? As I understand it,
> it should resolve a ref (here "HEAD") when path points to a submodule.
> When there isn't one it should return -1, so:

I'm not sure. I think part of the change to git-clean was that
is_git_directory() is a _better_ check than "can we resolve HEAD?"
because it covers empty repos, too.

> diff --git a/refs.c b/refs.c
> index 132eff5..f8648c5 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -1553,6 +1553,10 @@ int resolve_gitlink_ref(const char *path, const char *refname, unsigned char *sh
>  	if (!len)
>  		return -1;
>  	submodule = xstrndup(path, len);
> +	if (!is_git_directory(submodule)) {
> +		free(submodule);
> +		return -1;
> +	}
>  	refs = get_ref_cache(submodule);
>  	free(submodule);
> 
> I'm way too little into the code to see what may this may get wrong.

I don't think it produces wrong outcomes, but I think it's sub-optimal.
In cases where we already have a ref cache, we'll hit the filesystem for
each lookup to re-confirm what we already know. That doesn't affect your
case, but it does when we actually _do_ have a submodule.

So if we were to follow this route, I think it would go better in
get_ref_cache itself (right after we determine there is no existing
cache, but before we call create_ref_cache()).

> But this, as well as the old hash-ref-cache patch speeds me
> up considerably, in this case a git ls-files -o from half a
> minute of mostly user CPU to a second.

Right, that makes sense to me.

> > All of these should be using the same test, I think. Doing that with
> > is_git_directory() is probably OK. It is a little more expensive than we
> > might want for mass-use (it actually opens and parses the HEAD file in
> > each directory),
> 
> This happens as well when we let resolve_gitlink_ref run its old course.
> (It (ls-files) even seems to try to open .git and then .git/HEAD, even
> if the former fails with ENOENT.)

Yes, I think my earlier comment that you are quoting was just misguided.
We only do the extra work if the directory actually does look like a
gitdir, and the many-directories case we are optimizing here is the
opposite of that.

So summing up, I think:

  1. We could get by with teaching get_ref_cache not to auto-create ref
     caches for non-git-directories.

  2. But for a little more work, pushing the is_git_directory() check
     out to the call-sites gives us probably saner semantics overall.

-Peff
