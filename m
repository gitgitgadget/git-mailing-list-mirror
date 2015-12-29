From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/4] create_symref: use existing ref-lock code
Date: Tue, 29 Dec 2015 00:02:30 -0500
Message-ID: <20151229050230.GA13253@sigill.intra.peff.net>
References: <20151220072637.GA22102@sigill.intra.peff.net>
 <20151220073414.GD30662@sigill.intra.peff.net>
 <568104AF.102@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Dec 29 06:02:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aDmQh-0004Ew-PZ
	for gcvg-git-2@plane.gmane.org; Tue, 29 Dec 2015 06:02:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753211AbbL2FCf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Dec 2015 00:02:35 -0500
Received: from cloud.peff.net ([50.56.180.127]:46475 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753199AbbL2FCd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Dec 2015 00:02:33 -0500
Received: (qmail 11546 invoked by uid 102); 29 Dec 2015 05:02:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 28 Dec 2015 23:02:33 -0600
Received: (qmail 17957 invoked by uid 107); 29 Dec 2015 05:02:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 29 Dec 2015 00:02:45 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Dec 2015 00:02:30 -0500
Content-Disposition: inline
In-Reply-To: <568104AF.102@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283064>

On Mon, Dec 28, 2015 at 10:45:19AM +0100, Michael Haggerty wrote:

> > +static int create_ref_symlink(struct ref_lock *lock, const char *target)
> [...]
> > +	char *ref_path = get_locked_file_path(lock->lk);
> > +	unlink(ref_path);
> > +	ret = symlink(target, ref_path);
> [...]
> 
> This function is racy. A reader might see no reference at all in the
> moment between the `unlink()` and the `symlink()`. Moreover, if this
> process is killed at that moment, the symbolic ref would be gone forever.
> 
> I think that the semantics of `rename()` would allow this race to be
> fixed, though, since `symlink()` doesn't have the analogue of
> `O_CREAT|O_EXCL`, one would need a lockfile *and* a second temporary
> filename under which the new symlink is originally created.
> 
> However, this race has always been here, and symlink-based symrefs are
> obsolete, so it's probably not worth fixing.

Yeah. In the commit message I wrote:

> >  - the legacy prefer_symlink_refs path did not do any
> >    locking at all. Admittedly, it is not atomic from a
> >    reader's perspective (and it cannot be; it has to unlink
> >    and then symlink, creating a race), but at least it
> >    cannot conflict with other writers now.

but I think you are right that we could do tricks with rename() on the
symlink. That is in POSIX, though I wouldn't be surprised if it
misbehaves on some obscure systems. Given that using symlinks is only
triggered by an undocumented (!) option that presumably very few people
use, I'm inclined to leave it as-is.

I was actually tempted to rip it out, as the option is mostly a hack
from 2006:

  http://article.gmane.org/gmane.comp.version-control.git/19402

It was done to let people bisect old kernel trees whose build system
_depends_ on .git/HEAD being a symlink. My thought is:

  - people are a lot less likely to bisect back that far anymore

  - ...and if they do, their build system will be totally broken by the
    new ref-backend stuff

  - ...and the right solution is not to put a hack in git, but for the
    bisecting user to "fix up" the tree before testing (by munging the
    symlink themselves, or applying a patch to the build system to use
    `git rev-parse`). This matches what people have to do for every
    other type of weird "the old version doesn't quite build"
    incompatibility that has nothing to do with git.

But that should probably come as a separate patch (it affects this only
in that it makes this patch simpler to do that cleanup first :) ).

> > +	if (adjust_shared_perm(lock->lk->tempfile.filename.buf))
> > +		return error("unable to fix permissions on %s: %s",
> > +			     lock->lk->tempfile.filename.buf, strerror(errno));
> 
> You can skip this step. lock_file() already calls adjust_shared_perm().

Thanks, fixed.

> > +	/* no error check; commit_ref will check ferror */
> > +	fprintf(lock->lk->tempfile.fp, "ref: %s\n", target);
> > +	if (commit_ref(lock) < 0)
> > +		return error("unable to write symref for %s: %s", ref,
> > +			     strerror(errno));
> > +	update_symref_reflog(lock, ref, target, logmsg);
> 
> Here is another problem that didn't originate with your changes:
> 
> The reflog should be written while holding the reference lock, to
> prevent two processes' trying to write new entries at the same time.
> 
> I think the problem would be solved if you move the call to
> update_symref_reflog() above the call to commit_ref().
> 
> Granted, this could case a reflog entry to be written for a reference
> update whose commit fails, but that's also a risk for non-symbolic
> references. Fixing this residual problem would require the ability to
> roll back reflog changes.

Thanks, I agree with your reasoning (and especially that we should err
on the same side that normal ref-writing does). I'll do it in a
follow-on patch, though, to make it more clear what is going on.

-Peff
