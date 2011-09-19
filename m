From: Jeff King <peff@peff.net>
Subject: Re: how to remove unreachable objects?
Date: Mon, 19 Sep 2011 15:53:36 -0400
Message-ID: <20110919195335.GA31930@sigill.intra.peff.net>
References: <20110919110831.ewq03vnqos4w8cs8@webmail.edis.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: dieter@schoen.or.at
X-From: git-owner@vger.kernel.org Mon Sep 19 21:53:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R5juR-0002Xm-Kh
	for gcvg-git-2@lo.gmane.org; Mon, 19 Sep 2011 21:53:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753986Ab1ISTxi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Sep 2011 15:53:38 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:37565
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752879Ab1ISTxh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Sep 2011 15:53:37 -0400
Received: (qmail 8257 invoked by uid 107); 19 Sep 2011 19:58:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 19 Sep 2011 15:58:36 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 19 Sep 2011 15:53:36 -0400
Content-Disposition: inline
In-Reply-To: <20110919110831.ewq03vnqos4w8cs8@webmail.edis.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181696>

On Mon, Sep 19, 2011 at 11:08:31AM +0200, dieter@schoen.or.at wrote:

> this is my use case:
> i create a repository and produce several commits on master.
> then i go back to a certain tag and create a new branch, where i also
> commit.
> then i switch back to master and delete (-D) the other branch.
> it should now be unreachable from within git (to prove its existence,
> i remember a commit SHA1 on the dead branch).

It will still be referenced by the HEAD reflog, won't it?

> git checkout master
> git branch -D $DEAD
> git show $dead_commit
> git fsck --unreachable --full --verbose

This shows it reachable, because it is connected from the HEAD reflog.

> git fsck --unreachable HEAD \
>                     $(git for-each-ref --format="%(objectname)" refs/heads)

And this shows it as unreachable, because you are asking git to only
look at the branch tips and HEAD (by default, it looks at all refs and
reflogs).

I suspect you copied this straight from the git-fsck manpage. That
advice is a bit outdated, I think. It blames (in some form) all the way
back to the original documentation added in c64b9b8 (2005-05-05, only a
few weeks after git was born). A few weeks later, fsck learned to
default to looking at all refs (1024932, 2005-05-18). And then other
sane defaults like reflogs got tacked on later (reflogs came around the
1.4.x era, in 2006).

> git fsck --lost-found
> git prune -v $dead_commit
> git prune $(git rev-parse --all)
> git repack
> git prune-packed
> git gc --prune=now
> git gc --aggressive
> git show $dead_commit

If you really want to make it unreachable, you should expire the
reflogs, too:

  git reflog expire --expire=now --all
  # will now report unreachable
  git fsck --unreachable
  # will now actually delete objects
  git prune -v
  # gives "bad object ..."
  git show $dead_commit

git-gc will do this for you, but of course the default expiration time
is much longer (I think something like 90 days).

-Peff
