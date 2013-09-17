From: Jeff King <peff@peff.net>
Subject: Re: Locking files / git
Date: Tue, 17 Sep 2013 17:00:48 -0400
Message-ID: <20130917210047.GD16860@sigill.intra.peff.net>
References: <CACPGbcsB-ieZnS5maQgtnRTifFON9fEFpCGGdHtQ2ZjySdxDYA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Nicolas Adenis-Lamarre <nicolas.adenis.lamarre@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 17 23:01:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VM2OJ-0002Vm-GU
	for gcvg-git-2@plane.gmane.org; Tue, 17 Sep 2013 23:00:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753603Ab3IQVAz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Sep 2013 17:00:55 -0400
Received: from cloud.peff.net ([50.56.180.127]:47903 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753589Ab3IQVAz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Sep 2013 17:00:55 -0400
Received: (qmail 23749 invoked by uid 102); 17 Sep 2013 21:00:55 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 17 Sep 2013 16:00:55 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 17 Sep 2013 17:00:48 -0400
Content-Disposition: inline
In-Reply-To: <CACPGbcsB-ieZnS5maQgtnRTifFON9fEFpCGGdHtQ2ZjySdxDYA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234928>

On Tue, Sep 17, 2013 at 09:45:26PM +0200, Nicolas Adenis-Lamarre wrote:

> Ooops. It seems that each time somebody says these two words together,
> people hate him, and he is scorned by friends and family.

And strangers on mailing lists. :)

> However,
> - gitolite implement it (but gitolite is not git).

Yes, and I think that distinction is important.

Locking is fundamentally about having a centralized server. Even if you
have some decentralization (e.g., let's imagine two divisions of a
company that work as peers), the whole point of the lock is that
multiple people are communicating with the same lock server (so in that
same example, from the perspective of people in those divisions, there
is a central server for each division, and that would be the lock
server).

Git itself does not know know or care about your workflow, and whether
the remote you are pushing to is central or not. Having a lock server
would be unlike the rest of git.

Whereas gitolite, since it is about managing access to a centralized
repository, is a good place to handle locking.

In other words, I do not think locking is inherently bad. It is only
that it is useful for a subset of workflows that git provides. So I
don't think that git is the right place to implement it; rather it
should be built on top, either standalone or as part of other tools that
already assume some centralization.

> I want to explain how I could implement it.
> [...]

That all sounds like a reasonable workflow, but I think you could just
as easily implement it on top of git.

In particular, the protocol does not have any room to communicate this
data. So you are already going out-of-band over ssh, or something
similar. The only support you need from git is to auto-unlock the files
after a push. And I think you could do that using a post-receive hook.
And indeed, you would not want git itself to do it anyway, because the
rules for when to unlock are going to depend on your workflow (e.g.,
which branches a commit must hit to trigger an unlock).

-Peff
