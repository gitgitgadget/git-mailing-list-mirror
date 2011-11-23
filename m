From: Jeff King <peff@peff.net>
Subject: Re: git fetch overwriting local tags
Date: Wed, 23 Nov 2011 17:16:58 -0500
Message-ID: <20111123221658.GA22313@sigill.intra.peff.net>
References: <20111123090821.GL19986@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, John Kacur <jkacur@gmail.com>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
X-From: git-owner@vger.kernel.org Wed Nov 23 23:20:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RTLB1-0005Zo-0s
	for gcvg-git-2@lo.gmane.org; Wed, 23 Nov 2011 23:20:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753024Ab1KWWRA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Nov 2011 17:17:00 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:49469
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750882Ab1KWWRA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Nov 2011 17:17:00 -0500
Received: (qmail 7022 invoked by uid 107); 23 Nov 2011 22:17:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 23 Nov 2011 17:17:09 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 23 Nov 2011 17:16:58 -0500
Content-Disposition: inline
In-Reply-To: <20111123090821.GL19986@pengutronix.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185882>

On Wed, Nov 23, 2011 at 10:08:21AM +0100, Uwe Kleine-K=C3=B6nig wrote:

> John and I wondered about git fetch overwriting local tags. I was sur=
e
> enough to claim that git fetch won't overwrite local tags with remote
> tags having the same name. But after John pointed me to
>=20
> 	http://www.pythian.com/news/9067/on-the-perils-of-importing-remote-t=
ags-in-git/
>=20
> I tested that (using Debian's 1.7.7.3) and really, git does overwrite
> local tags.
>=20
> Here is my test script:
> [...]
> 	git fetch --tags ../a
> [...]
> Is this intended?

Sort of.

By default, "git fetch" will "auto-follow" tags; if you fetch a commit
which is pointed to by a tag, then git will fetch that tag, too. So
generally, you shouldn't need to specify "--tags" at all, because you
will already be getting the relevant tags.

The "--tags" option, however, is a short-hand for saying "fetch all of
the tags", and is equivalent to providing the refspec:

  git fetch ../a refs/tags/*:refs/tags/*

Which of course will update your local tags with similarly-named ones
from the remote.  So in that sense, there is no bug, and it is working
as intended; the problem is that the author's intent was not the same a=
s
your intent. :)

I'm not sure why you're using "--tags" in the first place. That might
help us figure out if there's another way to do what you want that is
safer.

That being said, it would be nice if "--tags" wasn't so surprising.
Three things that I think could help are:

  1. We usually require a "+" on the refspec (or "--force") to update
     non-fast-forward branches. But there is no such safety on tags
     (which generally shouldn't be updated at all). Should we at least
     be enforcing the same fast-forward rules on tag fetches (or even
     something more strict, like forbidding tag update at all unless
     forced)?

  2. We don't keep a reflog on tags. Generally there's no point. But
     it wouldn't be very expensive (since they don't usually change),
     and could provide a safety mechanism here.

  3. Keeping tags from remotes in separate namespaces, but collating
     them at lookup time. This has been discussed, and I think is
     generally a fine idea, but nobody has moved forward with code.

-Peff
