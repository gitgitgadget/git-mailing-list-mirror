From: Jeff King <peff@peff.net>
Subject: Re: Clone hangs when done over http with --reference
Date: Thu, 14 May 2015 15:52:26 -0400
Message-ID: <20150514195226.GA10205@peff.net>
References: <20150513210436.GA7407@gmail.com>
 <20150514004724.GA3059@peff.net>
 <5554D69E.20307@linuxfoundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
X-From: git-owner@vger.kernel.org Thu May 14 21:52:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YszBK-00051U-Dc
	for gcvg-git-2@plane.gmane.org; Thu, 14 May 2015 21:52:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965152AbbENTwa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2015 15:52:30 -0400
Received: from cloud.peff.net ([50.56.180.127]:58767 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S964932AbbENTw3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2015 15:52:29 -0400
Received: (qmail 22593 invoked by uid 102); 14 May 2015 19:52:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 14 May 2015 14:52:28 -0500
Received: (qmail 26916 invoked by uid 107); 14 May 2015 19:52:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 14 May 2015 15:52:28 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 May 2015 15:52:26 -0400
Content-Disposition: inline
In-Reply-To: <5554D69E.20307@linuxfoundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269077>

On Thu, May 14, 2015 at 01:08:46PM -0400, Konstantin Ryabitsev wrote:

> Two questions:
> 
> 1. Does this mean there are potential problems with other git operations
> that involve ref negotiation, not just when doing git clone --reference?
> Is there a chance to run in to this deadlock by doing an operation like
> "git remote update"?

Yes. From the server's perspective, a "clone --reference" is really no
different than a fetch in which the client happened to have all of those
refs already. I didn't try it, but you should be able to reproduce the
problem with:

  cd first-repo.git
  git fetch https://.../second-repo.git refs/*:refs/remotes/foo/*

which should have to do the exact same ref negotiation ("I have these
commits, I want these other commits").

> 2. If we configure the webserver to serve some files directly, without
> passing them to http-backend, e.g. doing the recommended apache magic:
> 
> > AliasMatch ^/git/(.*/objects/[0-9a-f]{2}/[0-9a-f]{38})$          /var/lib/git/$1
> > AliasMatch ^/git/(.*/objects/pack/pack-[0-9a-f]{40}.(pack|idx))$ /var/lib/git/$1
> > AliasMatch ^/git/(.*/refs/heads/.*)$                             /var/lib/git/$1
> 
> Will that make the spooling less of a problem, since it won't involve
> the super-huge files?

No, that won't help. Once git is doing the smart protocol, it will never
ask for arbitrary files. So you would have to disable smart-http
entirely, which I don't recommend.

Besides which, it's not the size of the objects or packs that is an
issue here. It's the relationship of the tips in the second repo to the
tips in the first. That is, the "big" data here is the client and server
finding the common commits between the two (and it's not even _that_
big; it's just big by "stuffing into a pipe buffer" standards; as you
noticed, the git protocol handles it just fine).

-Peff
