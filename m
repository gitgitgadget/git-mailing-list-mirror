From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/3] retain reflogs for deleted refs
Date: Fri, 20 Jul 2012 11:07:26 -0400
Message-ID: <20120720150726.GA2862@sigill.intra.peff.net>
References: <20120719213225.GA20311@sigill.intra.peff.net>
 <20120719213311.GA20385@sigill.intra.peff.net>
 <7vy5mftm3q.fsf@alter.siamese.dyndns.org>
 <20120720144337.GA31946@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Alexey Muranov <alexey.muranov@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 20 17:07:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SsEnm-0003g1-2U
	for gcvg-git-2@plane.gmane.org; Fri, 20 Jul 2012 17:07:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752019Ab2GTPH3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jul 2012 11:07:29 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:56522 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751297Ab2GTPH2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jul 2012 11:07:28 -0400
Received: (qmail 11355 invoked by uid 107); 20 Jul 2012 15:07:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 20 Jul 2012 11:07:27 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 20 Jul 2012 11:07:26 -0400
Content-Disposition: inline
In-Reply-To: <20120720144337.GA31946@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201771>

On Fri, Jul 20, 2012 at 10:43:37AM -0400, Jeff King wrote:

> > I think the work-around indicates the need for regular users to be
> > able to also discover, prune and delete these logs.  Do we have
> > "prune reflog for _this_ ref (or these refs), removing entries that
> > are older than this threshold"?  If so the codepath would need to
> > know about the graveyard and the implementation detail of the tilde
> > suffix so that the end users do not need to know about them.
> 
> We do have it: "git reflog expire --expire=now deleted-branch" is the
> right way to do it. Unfortunately, it does not work with my patch. The
> dwim_log correctly notes that a reflog exists (because it checks that
> the "graveyard" version of the ref exists), but then expire_reflog does
> not correctly fallback when opening the log (it usually has to do the
> _reverse_ translation, because it gets the graveyard log name from
> for_each_reflog, and has to find the correct lock).
> 
> I'll fix it in my re-roll, and then have t7701 use it.

I noticed I ignored the "discover" and "delete" parts of your paragraph.
As far as deletion goes, I think we can ignore it; expiring all entries
is equivalent.

Discovery is harder. Certainly these should not show up in normal
ref-listing output. I'd be content to leave them slightly hidden as a
first step, and people who know they are looking for the pre-deletion
contents of the "foo" branch can access it by name. Probably a second
step would be a fancier interface to help with listing and resurrecting
dead branches, possibly including branch config.

In other words, I want to focus on getting the ref-level plumbing right,
and then we can care about the porcelain later.

-Peff
