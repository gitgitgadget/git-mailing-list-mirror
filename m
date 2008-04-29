From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/7] limit the usage of the default remote "origin" to
	the minimum
Date: Tue, 29 Apr 2008 15:35:36 -0400
Message-ID: <20080429193536.GA19340@sigill.intra.peff.net>
References: <4812DA50.3000702@gnu.org> <cover.1209391614.git.bonzini@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, spearce@spearce.org, gitster@pobox.com,
	johannes.schindelin@gmx.de, srb@cuci.nl
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Tue Apr 29 21:36:32 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jqvcp-0006E2-SF
	for gcvg-git-2@gmane.org; Tue, 29 Apr 2008 21:36:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752299AbYD2Tfj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2008 15:35:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752582AbYD2Tfj
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Apr 2008 15:35:39 -0400
Received: from peff.net ([208.65.91.99]:4967 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752299AbYD2Tfi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2008 15:35:38 -0400
Received: (qmail 8605 invoked by uid 111); 29 Apr 2008 19:35:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 29 Apr 2008 15:35:37 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Apr 2008 15:35:36 -0400
Content-Disposition: inline
In-Reply-To: <cover.1209391614.git.bonzini@gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80720>

On Mon, Apr 28, 2008 at 05:23:53PM +0200, Paolo Bonzini wrote:

> Patches 1 to 4 deal with "git push".  The problem here is that the
> "magic" default operation ("git push sends to origin all refs that
> are already present there"), as of new, cannot be explained in the
> configuration, and this is fixed by patches 1 and 2.  Patch 1 adds a
> special push refspec meaning "consider all refs already on the remote",
> and patch 2 makes git-clone add one such line when it creates the
> origin remote.

I like patches 1 and 2. The principle of "remove defaults from code, and
put them into the automatically generated config file" makes sense to
me. It gives users an easy place to look to understand and change such
behavior. So even without the rest of the patches, I think this is an
improvement.

> Patch 3 could also be split out of this series.  It adds to "git-remote
> add" a new --push option, that sets up a push refspec for the newly
> created remote.

This feels a little wrong, since we treat push and fetch lines
differently. That is, I can add just a fetch ("git remote add"), or both
("git remote add --push"), but not just a push. It seems like the
concepts should be orthogonal to "git remote" (as they are in the config
file).

> Patch 4 is a reworking of my previous patch.  Instead of having "git
> push" push to "all mirrors plus the magic origin branch", it will
> push to "all remotes having a push refspec".  In the future, this
> will always include the origin branch because of patch 2, while
> right now the origin branch is still used if no remote has a
> push refspec (for backwards compatibility -- more discussion in the
> patch log message).
>
> This patch may cause incompatibilities to be warned about in
> the release notes.  Luckily, these incompatibilities only affect
> users that already know their way in .git/config, because no porcelain
> command creates push refspecs.

I think you understand the compatibility issues, but I think it needs to
be not "warned in the release notes" but "warned in the release notes,
followed by a period of adjustment, and then the change". And maybe it
would even make sense to wait for a larger-number version change (like
1.6.0).

> Patches 5 and 6 affect "git pull".  Pulling uses the magic origin branch
> less often, because branch.*.remote already establishes a saner default.
> Therefore, here we can actually warn and deprecate the misfeature for
> real (patch 6).  Patch 5 however is still needed, so that "git pull"
> itself decides when to use the magic "origin" branch instead of making
> the decision in "git fetch".

I agree that patch 5 is a reasonable cleanup, regardless.

I'm not sure about patch 6. What are the cases that can trigger this? I
assume people still with ancient .git/remotes files? Are those actually
deprecated?

> Finally, patch 7 affects "git fetch".  As hinted earlier, I chose to
> duplicate the functionality already present in "git remote update"
> (for the case where remotes are not grouped), but the code is much
> simpler so there is no incentive (at least for now) in borrowing code
> from "git remote update" into "git fetch"---actually, as a cleanup
> it is maybe possible to borrow code in the other direction.

Again, I like this behavior just fine, but it probably needs a warning
period and a major version bump.

> "BTW, I find myself decreasingly using "git fetch" in favor of "git
>  remote update" which handles fetching from multiple remotes."
> 	The series remove the need to switch from "git fetch" to
> 	"git remote update" as one learns the power of DVCS.

This was from me, and I do like this behavior better.

-Peff
