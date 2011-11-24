From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: Re: git fetch overwriting local tags
Date: Thu, 24 Nov 2011 08:07:28 +0100
Message-ID: <20111124070728.GR19986@pengutronix.de>
References: <20111123090821.GL19986@pengutronix.de>
 <20111123221658.GA22313@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, John Kacur <jkacur@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Nov 24 08:07:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RTTPD-0006H8-2J
	for gcvg-git-2@lo.gmane.org; Thu, 24 Nov 2011 08:07:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752192Ab1KXHHa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Nov 2011 02:07:30 -0500
Received: from metis.ext.pengutronix.de ([92.198.50.35]:46706 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751230Ab1KXHHa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Nov 2011 02:07:30 -0500
Received: from dude.hi.pengutronix.de ([2001:6f8:1178:2:21e:67ff:fe11:9c5c])
	by metis.ext.pengutronix.de with esmtp (Exim 4.72)
	(envelope-from <ukl@pengutronix.de>)
	id 1RTTP6-0006kq-Vy; Thu, 24 Nov 2011 08:07:28 +0100
Received: from ukl by dude.hi.pengutronix.de with local (Exim 4.77)
	(envelope-from <ukl@pengutronix.de>)
	id 1RTTP6-0005Qt-1a; Thu, 24 Nov 2011 08:07:28 +0100
Content-Disposition: inline
In-Reply-To: <20111123221658.GA22313@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:21e:67ff:fe11:9c5c
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185892>

Hi Jeff,

On Wed, Nov 23, 2011 at 05:16:58PM -0500, Jeff King wrote:
> On Wed, Nov 23, 2011 at 10:08:21AM +0100, Uwe Kleine-K=F6nig wrote:
>=20
> > John and I wondered about git fetch overwriting local tags. I was s=
ure
> > enough to claim that git fetch won't overwrite local tags with remo=
te
> > tags having the same name. But after John pointed me to
> >=20
> > 	http://www.pythian.com/news/9067/on-the-perils-of-importing-remote=
-tags-in-git/
> >=20
> > I tested that (using Debian's 1.7.7.3) and really, git does overwri=
te
> > local tags.
> >=20
> > Here is my test script:
> > [...]
> > 	git fetch --tags ../a
> > [...]
> > Is this intended?
>=20
> Sort of.
>=20
> By default, "git fetch" will "auto-follow" tags; if you fetch a commi=
t
> which is pointed to by a tag, then git will fetch that tag, too. So
> generally, you shouldn't need to specify "--tags" at all, because you
> will already be getting the relevant tags.
Hmm, if I do:

        mkdir a
        cd a
        echo some content > some_file
        git init
        git add some_file
        git commit -m 'some commit log'
        git tag some_tag

        cd ..

        mkdir b
        cd b
        echo some different content > another_file
        git init
        git add another_file
        git commit -m 'another commit log'

	git fetch ../a

I don't get the tag. That's why I added --tags. I guess that's because
some_tag is a lightweight tag. Hmm, but even if I change the command to
create the tag to

	git tag -a -m 'tag desc' some_tag

I don't get it without --tags?!

> The "--tags" option, however, is a short-hand for saying "fetch all o=
f
> the tags", and is equivalent to providing the refspec:
>=20
>   git fetch ../a refs/tags/*:refs/tags/*
>=20
> Which of course will update your local tags with similarly-named ones
> from the remote.  So in that sense, there is no bug, and it is workin=
g
> as intended; the problem is that the author's intent was not the same=
 as
> your intent. :)
>=20
> I'm not sure why you're using "--tags" in the first place. That might
> help us figure out if there's another way to do what you want that is
> safer.
>=20
> That being said, it would be nice if "--tags" wasn't so surprising.
> Three things that I think could help are:
>=20
>   1. We usually require a "+" on the refspec (or "--force") to update
>      non-fast-forward branches. But there is no such safety on tags
>      (which generally shouldn't be updated at all). Should we at leas=
t
>      be enforcing the same fast-forward rules on tag fetches (or even
>      something more strict, like forbidding tag update at all unless
>      forced)?
That sounds fine for me.

>   2. We don't keep a reflog on tags. Generally there's no point. But
>      it wouldn't be very expensive (since they don't usually change),
>      and could provide a safety mechanism here.
I prefer 1, but that would be better than the current situation at
least.
=20
>   3. Keeping tags from remotes in separate namespaces, but collating
>      them at lookup time. This has been discussed, and I think is
>      generally a fine idea, but nobody has moved forward with code.
That's something that John said in our discussion, too. That's the
suggestion I like the most.

Best regards and thanks for your time,
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
