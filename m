From: Jeff King <peff@peff.net>
Subject: Re: git-apply that handles rejects like merge conflicts
Date: Tue, 8 Nov 2011 16:00:45 -0500
Message-ID: <20111108210045.GA18666@sigill.intra.peff.net>
References: <4EB85768.1060508@avtalion.name>
 <20111107225508.GB28188@sigill.intra.peff.net>
 <7v4nyf1opf.fsf@alter.siamese.dyndns.org>
 <20111108054643.GC29643@sigill.intra.peff.net>
 <4EB9962B.8060809@avtalion.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Ori Avtalion <ori@avtalion.name>
X-From: git-owner@vger.kernel.org Tue Nov 08 22:00:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNsms-0001My-1d
	for gcvg-git-2@lo.gmane.org; Tue, 08 Nov 2011 22:00:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933318Ab1KHVAt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Nov 2011 16:00:49 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:37157
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932486Ab1KHVAs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Nov 2011 16:00:48 -0500
Received: (qmail 8095 invoked by uid 107); 8 Nov 2011 21:00:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 08 Nov 2011 16:00:49 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 08 Nov 2011 16:00:45 -0500
Content-Disposition: inline
In-Reply-To: <4EB9962B.8060809@avtalion.name>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185111>

On Tue, Nov 08, 2011 at 10:50:51PM +0200, Ori Avtalion wrote:

> In answer to your first question
> >   1. Should am's 3-way fallback be made more easily available to users
> >      of regular "apply"?
> 
> git-am is never part of this workflow as I'm trying to move patches
> between separate repositories with no shared root.

Isn't git-am the right tool for that? You format-patch out your commits
in one repo, and then apply them in the other. No shared history is
required; just the ability of the patches to actually be applied.

It _helps_ if you have the common base objects (the actual files, not
the commits), since the git diffs carry the pre- and post-image file
sha1s, which is what allows us to do a real 3-way merge. In that case,
it is just a matter of making the objects from the first repo available
to git during the moment you are applying in the second repo. You could
do it by fetching the history of the first into a side-branch of the
second, or even just by sharing object databases via the "alternates"
mechanism.

> <rant>
> And, personally, I don't think git-am is named correctly as the only
> use-case I have for it is applying+committing single patches produced by
> format-patch and sent as individual files over some medium which isn't
> mboxes (I'm not that old-school). I never understood why git-apply can't
> do the commit and I have to instead use a tool with 'mail' in its name
> (Let's ignore the historical reasons) -- Shouldn't git-am be an
> mbox-reading wrapper around some more basic patch-applying tool?
> </rant>

git-am _is_ an mbox-reading wrapper around some more basic
patch-applying tool. That tool is "git apply". I think what you are
missing is that a single patch (or multiple patches) produced by
format-patch _is_ an mbox. There is nothing wrong with:

  cd repo1 &&
  git format-patch -1 --stdout >../my.patch &&
  cd ../repo2 &&
  git am ../my.patch

There is no standard for representing commit metadata in the diff
format. So git had to invent its own. It used rfc822 messages and
mailboxes because it was simple and convenient, it mapped to what some
people were already doing, and it means we don't need a separate tool
for applying local commits versus ones that were emailed.

So the "m" is really for mbox, which happens to be git's format for
storing one or more commits, including metadata. If you just forget that
it's associated with mail, then I think you will be happy. :)

-Peff
