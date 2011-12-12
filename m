From: Jeff King <peff@peff.net>
Subject: Re: best way to fastforward all tracking branches after a fetch
Date: Mon, 12 Dec 2011 03:25:26 -0500
Message-ID: <20111212082526.GC16511@sigill.intra.peff.net>
References: <hbf.20111211x512@bombur.uio.no>
 <1kc5m38.m71ik21ytxkhbM%lists@haller-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Hallvard B Furuseth <h.b.furuseth@usit.uio.no>,
	Gelonida N <gelonida@gmail.com>, git@vger.kernel.org
To: Stefan Haller <lists@haller-berlin.de>
X-From: git-owner@vger.kernel.org Mon Dec 12 09:25:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ra1CX-0002az-C8
	for gcvg-git-2@lo.gmane.org; Mon, 12 Dec 2011 09:25:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751803Ab1LLIZ2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Dec 2011 03:25:28 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:48050
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751036Ab1LLIZ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 03:25:28 -0500
Received: (qmail 30717 invoked by uid 107); 12 Dec 2011 08:32:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 12 Dec 2011 03:32:08 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Dec 2011 03:25:26 -0500
Content-Disposition: inline
In-Reply-To: <1kc5m38.m71ik21ytxkhbM%lists@haller-berlin.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186890>

On Mon, Dec 12, 2011 at 08:33:15AM +0100, Stefan Haller wrote:

> > Local branches can track each other.  So the script needs to toposort
> > the branches, or to loop until either nothing was done or an error
> > happened.  (The latter to prevent an eternal loop on error.)
> 
> Is this just theoretical, or are there real use cases for this? What
> would be a workflow with such a local tracking branch?

I use this all the time.

In git.git, we use a topic branch workflow (i.e., every feature gets its
own topic branch, and topics graduate independently to master as they
are deemed stable). And we use a patch-submission workflow, which means
it's OK for me to rebase my topics locally, because the end-product is a
series of patches sent to the list.

Typically I branch off of "origin/master", so the topic is independent
of anything else. For example, the "jk/credentials" branch in my git
repo is branched from "origin/master" (Junio's master).  But sometimes
there is a topic that depends on another topic, but should not be part
of the same series (because the the first topic can graduate to master,
but the second one may still need more time for discussion and cooking).
In that case, I'll set the upstream to the other local topic branch. An
example of this is the "jk/prompt" series, which depends on
"jk/credentials" for infrastructure, but is really a separate issue.

Having the upstream set is convenient, because I can get _just_ the
commits in jk/prompt with "git log @{u}..". Or I can rebase _just_ the
commits in that topic with "git rebase -i". If my upstream were set to
origin, I would accidentally also rebase all of the commits pulled in
from jk/credentials, too.

While my topics are still in development (i.e., before they have even
hit "next"), I tend to rebase them aggressively (so that I keep them up
to date with git development), using a script that is something like[1]:

  for i in `topics`; do
    git rebase $i@{u} $i
  done

And I do topo-sort my topics for exactly the reason mentioned.

-Peff

[1] https://github.com/peff/git/blob/meta/rebase
