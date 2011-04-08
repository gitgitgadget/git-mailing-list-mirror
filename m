From: Jeff King <peff@peff.net>
Subject: Re: New to git
Date: Fri, 8 Apr 2011 16:10:25 -0400
Message-ID: <20110408201024.GA15964@sigill.intra.peff.net>
References: <BANLkTimy-95OJGxU9XzcaR=0jTJWXOwsDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Marco Maggesi <marco.maggesi@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 08 22:10:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q8I0o-0000ez-2y
	for gcvg-git-2@lo.gmane.org; Fri, 08 Apr 2011 22:10:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757833Ab1DHUK2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Apr 2011 16:10:28 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:60144
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757777Ab1DHUK1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Apr 2011 16:10:27 -0400
Received: (qmail 4563 invoked by uid 107); 8 Apr 2011 20:11:15 -0000
Received: from 70-36-146-44.dsl.dynamic.sonic.net (HELO sigill.intra.peff.net) (70.36.146.44)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 08 Apr 2011 16:11:15 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 08 Apr 2011 16:10:25 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTimy-95OJGxU9XzcaR=0jTJWXOwsDg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171155>

On Fri, Apr 08, 2011 at 09:43:09PM +0200, Marco Maggesi wrote:

> Now I would like to setup a repository on a server and use it as a
> central point of distribution for a few other computers.
> As far as I can understand, the default mechanism for push / pull
> requires that git is installed on every machine, including the server.

Yes, it's the default, but there are other mechanisms that don't require
server support. For example, rsync, and dumb http and ftp support.
They're not as efficient, but they do work.

For pushing, they are not as convenient. The dumb http push support goes
over DAV, so you must have a DAV server set up. Similarly, the rsync
support does not (as far as I know) do rsync-over-ssh, but expects to
connect to the rsync daemon directly.

But if you are just using the server as a distribution point for a
single repository, it can be much simpler. For example, if you always
just want to push and overwrite what is on the server (i.e., like a
mirror), you can just use plain rsync outside of git. To avoid mirror
lag, you do want to update the objects before the refs. So this:

  LOCAL=/path/to/repo.git
  REMOTE=server:path/to/repo.git
  rsync -a $LOCAL/objects/ $REMOTE/objects/
  rsync -a $LOCAL $REMOTE

would work. And then expose repo.git on the server via http or ftp, and
clients can clone directly from it.

> My problem is that I can hardly install git on the server for several
> reasons that I will not explain here (also I'm not the administrator
> of the server).

You didn't list your reasons, so I'll assume they're good. But note that
you don't need to be the administrator to accept a git push. You can
build it as a regular user, and have git connect over ssh and run the
server side.

> For the moment I came only to the following idea: mount the remote
> repository via fuse-ssh and use the local installation of git to push
> / pull changes.
> Surely it is inefficient but I don't care too much (my repositories
> are small enough I think).
> Can you see other drawbacks of this solution?

That is inefficient, but I think it would work OK. If you are doing
that, though, you are probably better off just rsyncing the whole result
as I showed above. It's less inefficient and easier to set up (if you
have rsync on the server, of course).

-Peff
