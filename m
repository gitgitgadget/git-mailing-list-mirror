From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] builtin/push.c: make push_default a static variable
Date: Tue, 17 Feb 2015 13:23:25 -0500
Message-ID: <20150217182324.GA12816@peff.net>
References: <20150216054550.GA24611@peff.net>
 <20150216054754.GB25088@peff.net>
 <20150217104628.GA25978@peff.net>
 <xmqqsie4300s.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Dave Olszewski <cxreg@pobox.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 17 19:23:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YNmnz-0001dg-Vv
	for gcvg-git-2@plane.gmane.org; Tue, 17 Feb 2015 19:23:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753759AbbBQSX2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2015 13:23:28 -0500
Received: from cloud.peff.net ([50.56.180.127]:50031 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753272AbbBQSX1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2015 13:23:27 -0500
Received: (qmail 5180 invoked by uid 102); 17 Feb 2015 18:23:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 17 Feb 2015 12:23:27 -0600
Received: (qmail 10164 invoked by uid 107); 17 Feb 2015 18:23:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 17 Feb 2015 13:23:35 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 17 Feb 2015 13:23:25 -0500
Content-Disposition: inline
In-Reply-To: <xmqqsie4300s.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263974>

On Tue, Feb 17, 2015 at 09:45:07AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > If we wanted to implement "@{push}" (or "@{publish}") to mean "the
> > tracking ref of the remote ref you would push to if you ran git-push",
> > then this is a step in the wrong direction.
> 
> Is that because push_default variable needs to be looked at from
> sha1_name.c when resolving "@{push}", optionally prefixed with the
> name of the branch?

Yes, exactly.

> I wonder if that codepath should know the gory details of which ref at
> the remote the branch is pushed to and which remote-tracking ref we
> use in the local repository to mirror that remote ref in the first
> place?

I think that was one of the ugly bits from the series; that we had to
reimplement "where would we push" and "what would it be called if we
pushed and then fetched"? The former cares about push_default, and the
latter has to apply push and then fetch refspecs.

If you want to peek at it again, it's at:

  https://github.com/peff/git/commit/8859afb1af63cb3cb0bc4cc8c1719c2011f406c9

(but note that it should not be called @{publish}, as per earlier
discussions).

> What do we do for the @{upstream} side of the things---it calls
> branch_get() and when the branch structure is returned, the details
> have been computed for us so get_upstream_branch() only needs to use
> the information already computed.  The interesting parts of the
> computation all happen inside remote.c, it seems.
> 
> So we probably would do something similar to @{push} side, which
> would mean that push_default variable and the logic needs to be
> visible to remote.c if we want to have the helper that is similar to
> set_merge() that is used from branch_get() to support @{upstream}.

Sure, we could go that way. But I don't think it changes the issue for
_this_ patch series, which is that the variable needs visibility outside
of builtin/push.c (and we need to load the config for programs besides
git-push).

> Hmmm, I have a feeling that "with default configuration, where does
> 'git push' send this branch to?" logic should be contained within
> the source file whose name has "push" in it and exposed as a helper
> function, instead of exposing just one of the lowest level knob
> push_default to outside callers and have them figure things out.
> 
> Viewed from that angle, it might be the case that remote.c knows too
> much about what happens during fetch and pull, but I dunno.

Yeah, it would be nice if there were a convenient lib-ified set of
functions for getting this information, and "fetch" and "push" commands
were built on top of it. I don't know how painful that would be, though.
The existing code has grown somewhat organically.

But even with that change, the lib-ified code needs to hook into
git_default_config (or do its own config lookup) so that we get the
proper value no matter who the caller is.

-Peff
