From: Jeff King <peff@github.com>
Subject: Re: [RFC/PATCH 2/2] stash: drop dirty worktree check on apply
Date: Tue, 5 Apr 2011 19:02:45 -0400
Message-ID: <20110405230245.GA7631@sigill.intra.peff.net>
References: <20110405212025.GA3579@sigill.intra.peff.net>
 <20110405212314.GA3613@sigill.intra.peff.net>
 <7vvcysl5pz.fsf@alter.siamese.dyndns.org>
 <20110405221827.GA4123@sigill.intra.peff.net>
 <20110405225038.GB7358@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Brian Lopez <brian@github.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 06 01:02:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7FGw-0002Sv-HZ
	for gcvg-git-2@lo.gmane.org; Wed, 06 Apr 2011 01:02:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754808Ab1DEXCt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Apr 2011 19:02:49 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:45646
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754432Ab1DEXCt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Apr 2011 19:02:49 -0400
Received: (qmail 30379 invoked by uid 107); 5 Apr 2011 23:03:34 -0000
Received: from 70-36-146-44.dsl.dynamic.sonic.net (HELO sigill.intra.peff.net) (70.36.146.44)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 05 Apr 2011 19:03:34 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 05 Apr 2011 19:02:45 -0400
Content-Disposition: inline
In-Reply-To: <20110405225038.GB7358@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170935>

On Tue, Apr 05, 2011 at 06:50:38PM -0400, Jeff King wrote:

> > > I _think_ the reason we originally insisted on clean working tree was that
> > > while merge-resolve has always had an acurate check, merge-recursive's
> > > check was not very good, especially when renames are involved.  So
> > > probably this part of your comment ...
> [...]
> > That makes sense to me. I'd be a lot more comfortable if I could find
> > the actual place where merge-recursive got more accurate. I'll see if
> > it's simple to bisect.
> 
> Hmm, no such luck. In v1.5.0, before stash even existed, "git merge"
> will properly fail on this case (though the error message isn't as
> pretty):
> [...]
> which leads me to believe there is a more complex case that
> merge-recursive wasn't handling at the time, and which may or may not be
> handled better today. What that case would be, I have no clue.

Hmm. I think that code is due to your comment on the original git-stash
(then "git-save") here:

  http://article.gmane.org/gmane.comp.version-control.git/50749

  > +function restore_save () {
  > +     save=$(git rev-parse --verify --default saved "$1")
  > +     h_tree=$(git rev-parse --verify $save:base)
  > +     i_tree=$(git rev-parse --verify $save:indx)
  > +     w_tree=$(git rev-parse --verify $save:work)
  > +
  > +     git-merge-recursive $h_tree -- HEAD^{tree} $w_tree
  > +}

  The same "robustness" comments for the save_work function apply
  here.  You probably do not want to restore on a dirty tree; the
  intended use case is "stash away, pull, then restore", so I
  think it is Ok to assume that you will only be restoring on a
  clean state (and it would make the implementation simpler).

So perhaps there is no broken case at all, and it was just a matter of
being overly conservative from the beginning.

-Peff
