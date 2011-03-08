From: Jeff King <peff@peff.net>
Subject: Re: rsync busy non-bare git repo 'source' to quiet
Date: Tue, 8 Mar 2011 16:39:59 -0500
Message-ID: <20110308213959.GB5786@sigill.intra.peff.net>
References: <il66rd$46u$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Neal Kreitzinger <neal@rsss.com>
X-From: git-owner@vger.kernel.org Tue Mar 08 22:40:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Px4dV-00079R-QD
	for gcvg-git-2@lo.gmane.org; Tue, 08 Mar 2011 22:40:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756773Ab1CHVkA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Mar 2011 16:40:00 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:49536
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756122Ab1CHVkA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Mar 2011 16:40:00 -0500
Received: (qmail 4882 invoked by uid 107); 8 Mar 2011 21:40:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 08 Mar 2011 16:40:26 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 08 Mar 2011 16:39:59 -0500
Content-Disposition: inline
In-Reply-To: <il66rd$46u$1@dough.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168703>

On Tue, Mar 08, 2011 at 03:25:00PM -0600, Neal Kreitzinger wrote:

> Does anyone have an example of an rsync bash script that will make a good 
> copy of a non-bare git repo (including the working tree) while the "source" 
> git repo is busy and the "destination" git repo is quiet?

Don't copy the working tree. It's redundant with the repo data (assuming
your working tree is clean), so you are probably faster to sync .git and
then "reset --hard". And then you don't have to worry about fetching an
inconsistent working tree state.

For syncing the repo, I think you would need to do:

  1. Copy the refs to a local temp space.

  2. Copy the object db.

  3. Install your temp refs into place.

That way, for any updates in progress you will either not copy them
(because the refs weren't in place in step 1, though you may have some
of their objects), or if you do copy them, you are guaranteed to have
all of the necessary objects (because git will not update the ref until
all objects are in place).

But I really have to wonder why you don't simply use git to do the
fetch? It already does the right thing with respect to updates, and it
will be way more efficient than rsync in the face of repacking (or if
you really do want to use rsync, there is even an rsync transport for
git already). It sounds like:

> This would make it very easy for us to refresh our "beta" livebox to emulate 
> the current "gold" livebox using a single rsync instead of a combination of 
> rsync and git-clone/pull due to the pieces that git does not replicate (ie, 
> hooks) and the non-git components of our git based change control menu 
> system (which is written in bash scripts on linux).

You just don't want to do a pull in addition to an rsync. But I don't
think this solution will be any less complex.

-Peff
