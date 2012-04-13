From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] fetch: Only call a new ref a "branch" if it's under
 refs/heads/.
Date: Fri, 13 Apr 2012 03:04:23 -0400
Message-ID: <20120413070423.GA16292@sigill.intra.peff.net>
References: <1334154569-26124-1-git-send-email-marcnarc@xiplink.com>
 <20120412055216.GC27369@sigill.intra.peff.net>
 <4F8737C8.1020501@web.de>
 <4F873CD0.4050204@xiplink.com>
 <4F873E2C.6080808@web.de>
 <20120412210542.GD21018@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Marc Branchaud <marcnarc@xiplink.com>, git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Fri Apr 13 09:05:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SIaZ2-0006aW-TS
	for gcvg-git-2@plane.gmane.org; Fri, 13 Apr 2012 09:05:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755401Ab2DMHE0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Apr 2012 03:04:26 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:33019
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752561Ab2DMHE0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Apr 2012 03:04:26 -0400
Received: (qmail 5224 invoked by uid 107); 13 Apr 2012 07:04:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 13 Apr 2012 03:04:32 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 13 Apr 2012 03:04:23 -0400
Content-Disposition: inline
In-Reply-To: <20120412210542.GD21018@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195404>

On Thu, Apr 12, 2012 at 05:05:42PM -0400, Jeff King wrote:

> > Am 12.04.2012 22:36, schrieb Marc Branchaud:
> > > I assumed it was an optimization of some sort -- that since tags are normally
> > > only fetched when they're part of a requested branch's history (right?),
> > > there was no point in doing submodule recursion on the fetched tags since
> > > those tagged tree-ishes had already been submodule-recursed.
> > 
> > If that is the case the patch I just sent is pointless, but adding a comment
> > there explaining that would be a good thing ;-)
> 
> That is often the case, but not always (I might explicitly fetch a tag,
> or have refs/tags/ in my refspec). So I think you want to handle both to
> cover all cases. I haven't looked at the submodule recursion code, but I
> would hope that it would eliminate duplicates (so if I get a branch and
> a tag that is on the branch, we would look at the commit in question
> only once).

OK, I checked. Yes, we handle this just fine. After my 6859de4, we
collect the ref tips before and after the fetch and run only a single
rev-list. So processing the tags will result in just an extra
interesting commit, which was either:

  1. accessible by another fetched branch, in which case it was going to
     be processed as interesting anyway

  2. not accessible, in which case we have fixed a bug. :)

So I think we should check all incoming refs, including tags.

-Peff
