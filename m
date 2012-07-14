From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] revision: avoid work after --max-count is reached
Date: Sat, 14 Jul 2012 04:10:33 -0400
Message-ID: <20120714081033.GA32547@sigill.intra.peff.net>
References: <20120713075023.GA31618@sigill.intra.peff.net>
 <7v7gu78izl.fsf@alter.siamese.dyndns.org>
 <20120713212050.GB10767@sigill.intra.peff.net>
 <7vwr2771k0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, git-dev@github.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 14 10:11:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SpxRa-00089p-Pi
	for gcvg-git-2@plane.gmane.org; Sat, 14 Jul 2012 10:11:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757024Ab2GNILC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Jul 2012 04:11:02 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:59329
	"EHLO peff.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752486Ab2GNIK4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jul 2012 04:10:56 -0400
Received: (qmail 11259 invoked by uid 107); 14 Jul 2012 08:10:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 14 Jul 2012 04:10:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 14 Jul 2012 04:10:33 -0400
Content-Disposition: inline
In-Reply-To: <7vwr2771k0.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201435>

On Fri, Jul 13, 2012 at 03:12:47PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Yeah, this was my analysis, too. Though reading get_revision-1, it seems
> > like we can actually set SHOWN, but I wasn't able to trigger any change
> > of behavior in practice. I think it is because we must set both SHOWN
> > and BOUNDARY to have an effect, and we do not do so.
> 
> In principle, SHOWN is only given when get_revision_internal gives
> the commit back to be shown, and the parents of the returned commit
> are painted CHILD_SHOWN.  This should be the only place to paint
> commit as CHILD_SHOWN.
> 
> A handful of places set the bit to commits that would be shown if
> some options that further limit what is shown by topological
> property (e.g. --left-only, --cherry-pick), which may cause that a
> parent of a commit that was omitted due to these conditions may
> later be marked incorrectly as a boundary inside
> create_boundary_commit_list().

I think what confused me is that I thought I saw get_revision_1 setting
SHOWN in the reflog case. But of course it is _clearing_ the flag, since
the reflog walker may show the commit multiple times. And no other code
paths in get_revision_1 set it (nor should they, since as you say, it is
about us actually handing back the commit to be shown).

> BOUNDARY is only given in create_boundary_commit_list() using
> CHILD_SHOWN and SHOWN, and that should happen only once when
> get_revision_1() runs out of the commits.

Yeah, agreed.

> By the way, cherry_pick_list() pays attention to BOUNDARY, but I
> think it is written overly defensively to protect itself from future
> callsites.  With the current code structure, it is only called from
> limit_list() and get_revision_*() functions are never called until
> limit_list() returns (and again create_boundary_commit_list() that
> is called from get_revision_internal() is the only place that sets
> BOUNDARY, so the commits cherry_pick_list() sees would never have
> that bit set.

I think we wouldn't be impacting it even so, because the commits that
make it to create_boundary_commit_list (and therefore get marked with
BOUNDARY) should be identical. We only put items into the
boundary_commits list when we are about to return them from
get_revision_internal, and with my patch that will not change (because
prior to my patch, we would have thrown away the commit after checking
max_count anyway).

So I think after looking again that this change is the right
thing to do, and there shouldn't be any side effects. Thanks for the
careful review.

-Peff
