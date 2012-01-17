From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/4] Remove a user of extra_refs in clone
Date: Tue, 17 Jan 2012 01:35:11 -0500
Message-ID: <20120117063511.GA27770@sigill.intra.peff.net>
References: <1326779434-20106-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>
To: mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Tue Jan 17 07:35:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rn2dg-0002ZX-2T
	for gcvg-git-2@lo.gmane.org; Tue, 17 Jan 2012 07:35:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751743Ab2AQGfR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jan 2012 01:35:17 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:40946
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750916Ab2AQGfQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jan 2012 01:35:16 -0500
Received: (qmail 24160 invoked by uid 107); 17 Jan 2012 06:42:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 17 Jan 2012 01:42:12 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 17 Jan 2012 01:35:11 -0500
Content-Disposition: inline
In-Reply-To: <1326779434-20106-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188692>

On Tue, Jan 17, 2012 at 06:50:30AM +0100, mhagger@alum.mit.edu wrote:

> When cloning, write_remote_refs() creates local packed refs from the
> refs read from the remote repository.  It does this by creating extra
> refs for the references then calling pack_refs() to bake the extra
> refs into the packed-refs file, then calling clear_extra_refs().
> 
> This is silly and relies on the kludgy extra_refs mechanism, which I
> want to get rid of.  Instead, add a function call add_packed_ref() to
> the refs API, and use it to create packed refs (in the memory cache)
> directly.  Then call pack_refs() as before to write the packed-refs
> file.

I certainly approve of the goal.

> Because the new add_packed_ref() function allows references (perhaps
> many of them) to be added to an existing ref_array, it would be
> inefficient to re-sort the list after every addition.  So instead,
> append new entries to the end of the ref_array and note that the array
> is unsorted.  Then, before the ref_array is used, check if it is
> unsorted and sort it if necessary.

Makes sense.

> A side effect of this change is that the new packed references are
> left in the in-memory packed reference cache after the return from
> write_remote_refs() (whereas previously, the refs were stored as
> temporary extra refs that were purged before return from the
> function).  I can't see any place in the following code where this
> would make a difference, but there is quite a bit of code there so it
> is hard to audit.  Confirmation that this is OK would be welcome.

Actually, I think you may be fixing an extremely minor bug with this.

If later code in clone tries to resolve one of the refs in
refs/remotes/<origin>/, the current code will see that it doesn't exist
as a ref file (because we wrote it packed) and call get_packed_ref. That
checks the cached refs list, which will claim that did_packed is true,
but the "packed" array will be empty. Which is wrong; we _do_ have that
ref, and our cache is stale. After writing the packed list, the current
code probably ought to be calling invalidate_ref_cache(). It was only
the fact that most of the remaining code didn't care that this wasn't a
bug in the first place.

Your code makes more sense, in that it will keep the packed_refs list up
to date, and later calls to resolve_ref will properly find those refs.

The only place where I can detect a change in behavior is in the reflog
creation. When we write the refs/remotes/<origin>/HEAD ref, we call
create_symref, which in turn will decide whether to write a reflog entry
or not based on whether the pointed-to ref exists (because if we are
making a symref to something that doesn't exist, we have no sha1 to
write in the reflog entry). So before, we got no reflog for
refs/remotes/<origin>/HEAD (because we erroneously thought that
refs/remotes/origin/master (or whatever) did not exist). With your
patches, the reflog entry is created.

I doubt anyone ever noticed, but now that code is at least working as
intended.

> Michael Haggerty (4):
>   pack_refs(): remove redundant check
>   ref_array: keep track of whether references are sorted
>   add_packed_ref(): new function in the refs API.
>   write_remote_refs(): create packed (rather than extra) refs

I won't respond to each patch individually. All of them looked good to
me. Thanks for a very pleasant read.

-Peff
