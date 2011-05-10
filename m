From: Jeff King <peff@peff.net>
Subject: Re: Separate default remotes for pulling and pushing
Date: Tue, 10 May 2011 16:17:16 -0400
Message-ID: <20110510201716.GE14456@sigill.intra.peff.net>
References: <1FDDE878-C81A-4318-836B-7F8BED51A981@gmail.com>
 <BANLkTinJDUa7sXjKHo81bG7KbnspxZ88oA@mail.gmail.com>
 <20110509081708.GA5871@sigill.intra.peff.net>
 <7viptjq0ua.fsf@alter.siamese.dyndns.org>
 <20110509220459.GA3719@sigill.intra.peff.net>
 <7vaaevo5l0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	David Lee <davidomundo@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 10 22:17:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJtMx-0001vu-Ba
	for gcvg-git-2@lo.gmane.org; Tue, 10 May 2011 22:17:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752321Ab1EJURS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2011 16:17:18 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:34449
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752234Ab1EJURS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2011 16:17:18 -0400
Received: (qmail 25737 invoked by uid 107); 10 May 2011 20:19:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 10 May 2011 16:19:15 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 10 May 2011 16:17:16 -0400
Content-Disposition: inline
In-Reply-To: <7vaaevo5l0.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173357>

On Mon, May 09, 2011 at 03:46:19PM -0700, Junio C Hamano wrote:

> > Interesting. Is your fetch from "ko" a no-op, or are you using it to
> > syncrhonize development between different machines?
> 
> Preformatted html and man pages are made when I push the integrated source
> branches out, triggered from the post-update hook at kernel.org.  I do not
> format them on my box.

Ah, that makes sense.

> > I think it is important to note that calling them both "origin" is
> > definitely the wrong thing. The proposal is instead that "git push"
> > without a remote would default to something besides "origin". For people
> > who publish multiple places, it might even make sense for it to be an
> > iterative push to each place.
> 
> Either we add branch.<name>.pushremote or push.defaultremote then?

I don't think most people would want just branch.<name>.pushremote. They
are more likely to want to always push to some place, so
push.defaultremote is a better choice.

But that has weird precedence problems. We auto-create branch.*.remote,
so if branch-specific config takes precedence, their push.defaultremote
will almost never be used. And if branch-specific config _doesn't_ take
precedence, then that is weird and unlike almost every other part of
git.

Another option is to mark the remote with an explicit "don't push here,
push to this other remote instead" config, like:

  $ git remote add my-fork host:project.git
  $ git config remote.origin.pushremote my-fork
  $ git push ;# acts as if you did "git push my-fork"

And then when we default to a remote, either because it is "origin" or
because it is in branch.*.remote, then we will end up pushing to the
right place.

I'm unsure what should happen in the case of:

  $ git config remote.origin.pushremote my-fork
  $ git push origin

In the workflow we described, "origin" is simply not a push-able remote,
so it is a slight convenience to intercept all pushes for it and
transparently rewrite them to "my-fork". And it makes the concept of
that config slightly simpler. It basically becomes the equivalent of
remote.*.pushurl, except that we are clear that it is a totally separate
remote with different tracking branches.

But it does eliminate any workflow where "origin" is _sometimes_
pushable, but you almost always want to push somewhere else instead.
Because you have no way to push to "origin" now. I don't know of any
such workflow, but I hate to be restrictive for no good reason.

If it just handles "use this remote instead only in the case of a
default selection", then the name should probably be like
"defaultpushremote" or something.

-Peff
