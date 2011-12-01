From: Jeff King <peff@peff.net>
Subject: Re: git merge strange result
Date: Thu, 1 Dec 2011 13:50:32 -0500
Message-ID: <20111201185032.GA2873@sigill.intra.peff.net>
References: <alpine.LFD.2.02.1112011733070.32682@mail.embedromix.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: "Catalin(ux) M. BOIE" <catab@embedromix.ro>
X-From: git-owner@vger.kernel.org Thu Dec 01 19:50:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RWBiS-0006ey-2H
	for gcvg-git-2@lo.gmane.org; Thu, 01 Dec 2011 19:50:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755805Ab1LASuf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Dec 2011 13:50:35 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:59222
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755660Ab1LASue (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Dec 2011 13:50:34 -0500
Received: (qmail 18858 invoked by uid 107); 1 Dec 2011 18:57:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 01 Dec 2011 13:57:09 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 01 Dec 2011 13:50:32 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.02.1112011733070.32682@mail.embedromix.ro>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186183>

On Thu, Dec 01, 2011 at 05:36:00PM +0200, Catalin(ux) M. BOIE wrote:

> Below is a script that reproduce what a coleague of mine found.
> Seems that if in a branch we have a commit that is cherry-picked be
> master, than revert that commit in branch and merge branch in master,
> the revert is ignored. Is it normal?

Yes, it's by design. When doing a merge, we look at three points: the
tip of the current branch, the tip of the branch to be merged, and the
point at which history diverged (the "merge base"). We don't look
individually at the commits that happened between the merge base and
each tip.

The non-conflicting case for a 3-way merge is that one side makes some
change, but the other side does nothing. In this case, we include the
change in the merge result. But remember that we are only looking at
endpoints. So what the actual merge code sees is that one side's version
of a file is identical to the merge base's version, and that the other
side's version is now different.

In your case, one side makes the change, but then restores the original
state. So from the perspective of the merge code, no change happened at
all on that side.

-Peff
