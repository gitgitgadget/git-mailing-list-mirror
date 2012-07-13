From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] revision: avoid work after --max-count is reached
Date: Fri, 13 Jul 2012 17:20:50 -0400
Message-ID: <20120713212050.GB10767@sigill.intra.peff.net>
References: <20120713075023.GA31618@sigill.intra.peff.net>
 <7v7gu78izl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, git-dev@github.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 13 23:21:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SpnIV-00048j-LN
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jul 2012 23:21:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758260Ab2GMVUz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jul 2012 17:20:55 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:59078
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758160Ab2GMVUw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jul 2012 17:20:52 -0400
Received: (qmail 6503 invoked by uid 107); 13 Jul 2012 21:20:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 13 Jul 2012 17:20:51 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 13 Jul 2012 17:20:50 -0400
Content-Disposition: inline
In-Reply-To: <7v7gu78izl.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201424>

On Fri, Jul 13, 2012 at 02:10:54PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > There's no need to make this get_revision_1 call when our
> > counter runs out. If we are not in --boundary mode, we will
> > just throw away the result and immediately return NULL. If
> > we are in --boundary mode, then we will still throw away the
> > result, and then start showing the boundary commits.
> >
> > However, as git_revision_1 does not impact the boundary
> > list, it should not have an impact.
> 
> We used to reset 'c' to NULL ("throw away the result"), run
> create_boundary_commit_list(), and ask ourselves to pop the boundary
> it computed.
> 
> Now we don't call get_revision_1() and leave 'c' to NULL as
> initialized ("avoid work"), and do the same.

Right.

> The state create_boundary_commit_list() sees would slightly be
> different, as we used to dig one level deeper, smudging more commits
> with bits, but the only bits that may be smudged by this digging
> that may matter in create_commit_list() is CHILD_SHOWN and SHOWN,
> but by definition the commits around the commit the extra call to
> get_revision_1() would have returned are marked with neither during
> that extra call, so I think this conversion does not affect the
> boundary list.

Yeah, this was my analysis, too. Though reading get_revision-1, it seems
like we can actually set SHOWN, but I wasn't able to trigger any change
of behavior in practice. I think it is because we must set both SHOWN
and BOUNDARY to have an effect, and we do not do so.

So the only questionable thing would be: are there commits with BOUNDARY
set but not SHOWN that could be affected by calling get_revision_1? For
that matter, if such a commit existed, would the current behavior even
be correct? We would not have actually shown the commit, so if such a
case did exist, I wonder if we would be fixing a bug.

-Peff
