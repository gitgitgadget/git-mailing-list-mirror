From: Jeff King <peff@github.com>
Subject: Re: [RFC/PATCH 2/2] stash: drop dirty worktree check on apply
Date: Tue, 5 Apr 2011 18:50:38 -0400
Message-ID: <20110405225038.GB7358@sigill.intra.peff.net>
References: <20110405212025.GA3579@sigill.intra.peff.net>
 <20110405212314.GA3613@sigill.intra.peff.net>
 <7vvcysl5pz.fsf@alter.siamese.dyndns.org>
 <20110405221827.GA4123@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Brian Lopez <brian@github.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 06 00:50:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7F5E-0004Gs-IQ
	for gcvg-git-2@lo.gmane.org; Wed, 06 Apr 2011 00:50:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754068Ab1DEWum (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Apr 2011 18:50:42 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:37941
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753264Ab1DEWul (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Apr 2011 18:50:41 -0400
Received: (qmail 30054 invoked by uid 107); 5 Apr 2011 22:51:27 -0000
Received: from 70-36-146-44.dsl.dynamic.sonic.net (HELO sigill.intra.peff.net) (70.36.146.44)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 05 Apr 2011 18:51:27 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 05 Apr 2011 18:50:38 -0400
Content-Disposition: inline
In-Reply-To: <20110405221827.GA4123@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170933>

On Tue, Apr 05, 2011 at 06:18:28PM -0400, Jeff King wrote:

> > I _think_ the reason we originally insisted on clean working tree was that
> > while merge-resolve has always had an acurate check, merge-recursive's
> > check was not very good, especially when renames are involved.  So
> > probably this part of your comment ...
> > 
> > > I'm not sure if the check was perhaps even required when git-stash was
> > > written, and has simply since become useless as merge-recursive became
> > > more careful.
> > 
> > ... may need to be used to rewrite bullet 2. above.
> 
> That makes sense to me. I'd be a lot more comfortable if I could find
> the actual place where merge-recursive got more accurate. I'll see if
> it's simple to bisect.

Hmm, no such luck. In v1.5.0, before stash even existed, "git merge"
will properly fail on this case (though the error message isn't as
pretty):

-- >8 --
#!/bin/sh

rm -rf repo

mkdir repo &&
cd repo &&
git init-db &&
echo base >file &&
git add file &&
git commit -m base &&
echo master >>file &&
git commit -a -m master &&
git checkout -b other HEAD^
echo other >>file &&
git commit -a -m other &&
echo more >>file &&
git merge master
-- 8< --

which leads me to believe there is a more complex case that
merge-recursive wasn't handling at the time, and which may or may not be
handled better today. What that case would be, I have no clue.

-Peff
