From: Jeff King <peff@peff.net>
Subject: Re: Separate default remotes for pulling and pushing
Date: Mon, 9 May 2011 04:17:08 -0400
Message-ID: <20110509081708.GA5871@sigill.intra.peff.net>
References: <1FDDE878-C81A-4318-836B-7F8BED51A981@gmail.com>
 <BANLkTinJDUa7sXjKHo81bG7KbnspxZ88oA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: David Lee <davidomundo@gmail.com>, git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 09 10:17:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJLeg-0001qt-GS
	for gcvg-git-2@lo.gmane.org; Mon, 09 May 2011 10:17:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753621Ab1EIIRQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 May 2011 04:17:16 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:39594
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753639Ab1EIIRL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2011 04:17:11 -0400
Received: (qmail 6147 invoked by uid 107); 9 May 2011 08:19:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 09 May 2011 04:19:07 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 09 May 2011 04:17:08 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTinJDUa7sXjKHo81bG7KbnspxZ88oA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173207>

On Sat, May 07, 2011 at 11:50:35AM +0200, Sverre Rabbelier wrote:

> On Sat, May 7, 2011 at 10:10, David Lee <davidomundo@gmail.com> wrote:
> > I want to set up different default remotes for pushing and pulling
> 
> See 'git remote set-url --push' [0].
> 
> [0] http://www.kernel.org/pub/software/scm/git/docs/git-remote.html

That probably doesn't quite do what David wants. It's useful when the
URL for pushing and pulling a particular repository are different.

But if I understand it correctly, David has two _separate_ repositories.
And using remote.*.pushurl for that has some unwanted side effects,
because the tracking ref namespace (i.e., "remotes/origin/*") is shared
by both, even though their refs may not be at the same position.

For example, when pushing "refs/heads/master" to the remote, git will
update "refs/remotes/origin/master" to the pushed value. But that ref is
supposed to reflect the value of the last fetch from his "original"
repository, and now it doesn't. The ref value will flip back and forth
between what's in the two repositories as he pushes and fetches.

I don't think there is currently a way to do what he wants. I think it
would be useful for certain workflows. As I see it, there are a few
pretty common setups for remotes:

  1. Centralized; you push and pull from a single repo, shared with
     other developers. In this case, you call it "origin" and everything
     is easy.

  2. Decentralized, you're the maintainer; you pull from other people or
     apply patches via email. When you push, you push out to some
     publishing point. You'd probably call your publishing point
     "origin" (though I think Junio calls kernel.org "ko" and just types
     "git push ko"). You never pull from some single place all the time,
     so you don't care about a shorthand for it.

  3. Decentralized, you're a developer with a patch-based workflow; you
     fetch from the maintainer, then develop and submit patches via a
     mailing list. You call the maintainer's repo "origin" and pull from
     it automatically.  You never push, so it doesn't matter that
     there's no shorthand.

  4. Decentralized, you're a developer that publishes work via git. You
     call the upstream maintainer "origin", so fetches are convenient
     (and git does this for you at clone, after all). But pushing, even
     though you probably always push to the same central, does not have
     a convenient shorthand.

     This is David's case (and mine, and I suspect some other git
     developers who do enough work that they want to make it publicly
     available via git, or even just have backups). It's also encouraged
     by sites like github, where you might clone the upstream's
     repository, but then pushes your changes up to a personal "fork"
     to let others see and merge them.

So I think part of the reason we don't have such an option is that cases
1-3 are so common. But it would be a nice convenience for people in case
4.

-Peff
