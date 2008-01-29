From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: fetch <repo> <branch>:<branch> fetches tags?
Date: Mon, 28 Jan 2008 23:19:29 -0500
Message-ID: <20080129041928.GL24004@spearce.org>
References: <479E9063.5000403@nrlssc.navy.mil> <7v3ashs5yg.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Brandon Casey <casey@nrlssc.navy.mil>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 29 05:20:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJhxF-0001vF-15
	for gcvg-git-2@gmane.org; Tue, 29 Jan 2008 05:20:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754523AbYA2ETf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2008 23:19:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754275AbYA2ETf
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jan 2008 23:19:35 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:54652 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753403AbYA2ETe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2008 23:19:34 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JJhwM-0006b5-Pl; Mon, 28 Jan 2008 23:19:18 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 8731A20FBAE; Mon, 28 Jan 2008 23:19:29 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7v3ashs5yg.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71946>

Junio C Hamano <gitster@pobox.com> wrote:
> Brandon Casey <casey@nrlssc.navy.mil> writes:
> >
> > But, I did not expect these to fetch tags:
> >
> >    git fetch <repo> <branch>:<branch>
> >    git pull <repo> <branch>:<branch>
> 
> Sigh... that matches my expectation.
> 
> Did we break it when we overhauled "git fetch", or was this an
> independent "improvement" that happened long before that?

I think during the git-fetch builtin marathon this got implemented,
but probably as a feature masquerading as a bug fix and we didn't
notice the regression.

The theory behind the expectation here is if we are fetching the
object to a tracking ref then we probably want to watch it in
the future.  If we want to watch it and tag following was allowed,
and we are missing a tag, we should follow the tag if we have the
object graph under the tag complete.

Now what should:

	git pull <repo> <branch1>:<branch1> <branch2>

do, especially if <branch2> is referring to an object that you don't
already have, that object also isn't reachable through <branch1>,
but <branch2>^0 is the target of a tag <tag2> that you don't have?
Should we get the tag anyway?

Personally I'd expect us to skip the tag pointing at <branch2>^0,
based upon my description above, but I have a feeling we'd follow
it anyway, as tag following was enabled and at least one item in
the fetchspec provided asked for storage to a tracking ref and we
have <tag2>^{} complete.


Of course even if we didn't follow that tag right away a future:

	git fetch <repo> <branch1>:<branch1>

might cause us to get the tag anyway, as <branch2>^0 is now reachable
through HEAD, due to the implicit git-merge we ran above.  ;-)

-- 
Shawn.
