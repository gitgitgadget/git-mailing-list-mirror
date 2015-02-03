From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 4/4] apply: do not touch a file beyond a symbolic link
Date: Mon, 2 Feb 2015 21:04:42 -0500
Message-ID: <20150203020440.GA4917@peff.net>
References: <1422919650-13346-1-git-send-email-gitster@pobox.com>
 <1422919650-13346-5-git-send-email-gitster@pobox.com>
 <20150203011139.GC31946@peff.net>
 <xmqq61bjsqoo.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 03 03:04:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YISrD-00080W-EX
	for gcvg-git-2@plane.gmane.org; Tue, 03 Feb 2015 03:04:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753059AbbBCCEr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Feb 2015 21:04:47 -0500
Received: from cloud.peff.net ([50.56.180.127]:44359 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751568AbbBCCEq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Feb 2015 21:04:46 -0500
Received: (qmail 31797 invoked by uid 102); 3 Feb 2015 02:04:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 02 Feb 2015 20:04:46 -0600
Received: (qmail 5051 invoked by uid 107); 3 Feb 2015 02:04:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 02 Feb 2015 21:04:43 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 02 Feb 2015 21:04:42 -0500
Content-Disposition: inline
In-Reply-To: <xmqq61bjsqoo.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263302>

On Mon, Feb 02, 2015 at 05:56:55PM -0800, Junio C Hamano wrote:

> > I think this means we'll be
> > overly cautious with a patch that does:
> >
> >   1. add foo as a symlink
> >
> >   2. remove foo
> >
> >   3. add foo/bar
> >
> > which is perfectly OK
> 
> No, such a patchset is broken.
> 
> A valid "git apply" input must *not* depend on the order of patches
> in it.  The consequence is that "an input to 'git apply' must not
> mention the fate of each path at most once."

Ah, right, I forgot we covered this already in the earlier discussion
(but thanks for elaborating; I think the reason I forgot is that I did
not really understand all of the implications).  If we do not have to
worry about that, then it's not a problem.

> >> +	/*
> >> +	 * An attempt to read from or delete a path that is beyond
> >> +	 * a symbolic link will be prevented by load_patch_target()
> >> +	 * that is called at the beginning of apply_data().  We need
> >> +	 * to make sure that the patch result is not deposited to
> >> +	 * a path that is beyond a symbolic link ourselves.
> >> +	 */
> >> +	if (!patch->is_delete && path_is_beyond_symlink(patch->new_name))
> >> +		return error(_("affected file '%s' is beyond a symbolic link"),
> >> +			     patch->new_name);
> >
> > Do we need to check the patch->is_delete case here (with patch->old_name)?
> 
> > I had a suspicion that the new patch 3/4 to check the reading-side might
> > help with that, but the comment here sounds like we do need to check
> > here, too
> 
> Hmm, the comment above was meant to tell you that we do not have to
> worry about the deletion case (because load_patch_target() will try
> to read the original to verify we are deleting what we expect to
> delete at the beginning of apply_data(), and it will notice that
> old_name is beyond a symbolic link), but we still need to check the
> non-deletion case.  Strictly speaking, modify-in-place case does not
> have to depend on this code (the same load_patch_target() check will
> catch it because it wants to check the preimage).
> 
> May need rephrasing to clarify but I thought it was clear enough.

Ah, OK. I totally misread it, thinking that load_patch_target was what
set up the symlink-table, and that was what you were referring to.  It
might be more clear after "...that is called at the beginning of
apply_data()" to add "...so we do not have to worry about that case
here".

-Peff
