From: Jeff King <peff@peff.net>
Subject: Re: Plumbing version of 'git branch --contains' ?
Date: Thu, 23 Oct 2014 10:19:22 -0700
Message-ID: <20141023171921.GA25061@peff.net>
References: <B82B660D4887C042850326C2BC65FE035D58B11E@G9W0757.americas.hpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "Crabtree, Andrew" <andrew.crabtree@hp.com>
X-From: git-owner@vger.kernel.org Thu Oct 23 19:19:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XhM2z-0008JT-0g
	for gcvg-git-2@plane.gmane.org; Thu, 23 Oct 2014 19:19:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755545AbaJWRTc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Oct 2014 13:19:32 -0400
Received: from cloud.peff.net ([50.56.180.127]:32994 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754756AbaJWRTa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Oct 2014 13:19:30 -0400
Received: (qmail 18676 invoked by uid 102); 23 Oct 2014 17:19:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 23 Oct 2014 12:19:26 -0500
Received: (qmail 6410 invoked by uid 107); 23 Oct 2014 17:19:27 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.2)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 23 Oct 2014 13:19:27 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 23 Oct 2014 10:19:22 -0700
Content-Disposition: inline
In-Reply-To: <B82B660D4887C042850326C2BC65FE035D58B11E@G9W0757.americas.hpqcorp.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 22, 2014 at 08:19:07PM +0000, Crabtree, Andrew wrote:

> I need to get a list of refs that can reach a certain SHA in in a script.
> 
> git branch --contains SHA 
> 
> would be great (runs in ~2 seconds), but not my preferred option for scripting.
> 
> I tried
>  
> for br in $(git for-each-ref --format='%(refname:short)' refs/heads/)
> do
>     git merge-base --is-ancestor $1 ${br}
>     if [ $? -eq 0 ]
>     then
>             echo "${br}"
>     fi
> done
> 
> Which gives me perfect output, but takes 82 seconds to run in my environment.

Right. There's some setup work that happens in `git branch --contains`
that we end up repeating.

> Is there an alternative I'm missing to give me the run time
> performance of 'git branch --contains' but with stable output suitable
> for parsing?

Sadly, no, there isn't currently. The right tool would be `git
for-each-ref --contains`, but it doesn't exist yet. I was working
towards it, but got stopped on factoring out a `--contains` traversal
suitable for both `git tag` and `git branch` (they currently are
different and make performance tradeoffs based on the expected depth of
the merge bases, which is usually different between tags and
branches)[1].  That's work I'd love to resume, but I haven't gotten
around to it yet.

-Peff

[1] http://thread.gmane.org/gmane.comp.version-control.git/252472
