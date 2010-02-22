From: Jelmer Vernooij <jelmer@samba.org>
Subject: Re: Storing (hidden) per-commit metadata
Date: Mon, 22 Feb 2010 14:44:49 +0100
Message-ID: <1266846289.4575.69.camel@ganieda>
References: <1266599485.29753.54.camel@ganieda>
	 <1266687636-sup-7641@ben-laptop>
	 <32541b131002201057t31fc8a6aydb0942171fe1b8c8@mail.gmail.com>
	 <20100221063433.GA2840@coredump.intra.peff.net>
	 <1266754646.12035.23.camel@ganieda>
	 <20100222051748.GB10191@dpotapov.dyndns.org>
	 <1266832607.31769.37.camel@ganieda>
	 <20100222112845.GE10191@dpotapov.dyndns.org>
	 <1266839972.4575.38.camel@ganieda>
	 <20100222130836.GG10191@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-GBAeYd/XAxzz27JyKuiK"
Cc: Jeff King <peff@peff.net>, Avery Pennarun <apenwarr@gmail.com>,
	Ben Gamari <bgamari@gmail.com>, git <git@vger.kernel.org>
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 22 14:45:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NjYap-0007re-Rr
	for gcvg-git-2@lo.gmane.org; Mon, 22 Feb 2010 14:45:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753240Ab0BVNoz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2010 08:44:55 -0500
Received: from gwenhwyvar.vernstok.nl ([92.243.4.181]:36818 "EHLO
	gwenhwyvar.vernstok.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753079Ab0BVNoy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2010 08:44:54 -0500
Received: from ganieda (localhost [127.0.0.1])
	by gwenhwyvar.vernstok.nl (Postfix) with ESMTP id 831E7265F8;
	Mon, 22 Feb 2010 13:46:18 +0000 (UTC)
Received: by ganieda (Postfix, from userid 1000)
	id AB8B6140BB1; Mon, 22 Feb 2010 14:44:49 +0100 (CET)
In-Reply-To: <20100222130836.GG10191@dpotapov.dyndns.org>
X-Mailer: Evolution 2.28.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140683>


--=-GBAeYd/XAxzz27JyKuiK
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2010-02-22 at 16:08 +0300, Dmitry Potapov wrote:
> On Mon, Feb 22, 2010 at 12:59:32PM +0100, Jelmer Vernooij wrote:
> > We'd like to have the extra metadata in Git so that we can push Bazaar
> > commits into a Git repository losslessly. If we can't do this losslessl=
y
> > then the identity of the commit changes just like it does in git if you
> > aren't able to produce the same tree, blob and commit objects.
> but the problem is that you may want to add some information when you
> import some Git to Bazaar. For instance, Git does not record file
> renames explicitly and relies on content of files to detect renames
> automatically. So, when I use gitk, I can see that what file is renamed.
> If you work in Bazaar, you probably also want to see renames, but this
> requires that you add this information when you import commits to
> Bazaaar. But if you do that, the export to Git will produce a different
> commit just because you added this Bazaar-specific data.
We can already do the other way around - Bazaar allows storing arbitrary
revision properties, so we use that to some things that can not be
represented in Bazaar but exist in Git. An example of this are  the
unusual file modes created by older versions of git or non-utf8 commit
messages. Those extra revision properties are set at the moment that the
Bazaar revision is imported into Git, not afterwards and there is no
need to update them later.

The fact that we have this extra metadata allows us to reproduce the
original Git commit bit for bit so we can actually extract the same
revision that went in, with the same git sha1.

> > > > Having a bzr/master ref means that the extra metadata will not alwa=
ys be
> > > > copied around (unless git is patched), so if I push my work from Ba=
zaar
> > > > into Git, somebody works on it in Git and pushes a derived branch a=
nd
> > > > then somebody else clones that derived Git branch into Bazaar again=
, I
> > > > will not be able to communicate with that person's branch.
> > > No matter how many times a branch was cloned, it is exactly same bran=
ch
> > > (i.e. it consists of commits having exactly the same id). So, if you =
can
> > > work with the original branch, you can work with any cloned branch. S=
o,
> > > I see no need to copy this data around for people who do not work wit=
h
> > > Bazaar directly.
> > The original branch is a Bazaar branch here, so that's not true. You ca=
n
> > only work with any cloned branch if the matching bzr/ branch is also
> > around. If it isn't then you won't be able to find the original commit.=
=20
> Obviously bzr/ branch should be around somewhere, but it does not have
> to be in any cloned repo. It is sufficient to have it in one place,
> because it refers to commit-id, which does not change when you clone it.
If some other Bazaar user clones that repo, they end up without the
Bazaar specific metadata and thus with different Bazaar commits. If they
then try to communicate with the Bazaar user that pushed the revisions
in, their histories appear unrelated.

> > hg-git already does something similar by putting a --HG-- line followed
> > by hg-git specific metadata in the commit message when it pushes into
> > Git. I'd like to find a place to put this data that's not as intruisive
> > for users.
> I still think it is wrong to hide some information in the commit object.
What exactly is the problem with doing so? "encoding" is already there
and as far as I can tell not displayed directly to the user.

> I am not sure that the commit object is the right place to store that
> metadata, but hidding this information is even more problematic. Let's
> suppose that someone cherry-pick your Bazaar originated commit. Now when
> you try to synchronize with Bazaar, your synchronizer will see that it
> has some Bazaar revision ID and branch name, but, in fact, it is new
> commit on a completely different branch...
I don't see how the fact that the bzr-git/hg-git data is being hidden is
the problem in the scenario you mention.

It'd be nice if this sort of information was discarded by "git rebase",
but that's another good reason to treat it in a different way from the
commit message instead.

Cheers,

Jelmer

--=-GBAeYd/XAxzz27JyKuiK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABAgAGBQJLgopQAAoJEACAbyvXKaRX6o8QAIb4xyQr/VkZV9x8SfgOgMba
RT+PLDrh9HedlPYUvHuVwvQ7A2X6T1PrqHLFoWkhEuCXcS3Dx2miq2a85b/qYO0E
MnkVnBa78SK3JaK4esb6zziE9ifoRu40jvKZDHUAdGr9Z8cZqCzC8AL1V9cpklw0
DuoUBhqAKgSfbjCIX2a090e66k3Mczs1jf0a5sueTOY2M9YiE2GXbVCqmT/hSipn
Ih/8pF/7xp/FQGaoUlS+72RUeDaAIjGCl9BxyNBIIhViaSCSM1Sh1jkTwjB08eCU
jc1JzxwAZhLn4WUD/Y0BiQZHpedwQOaYbY279iGjStoor0v+sknG6wsR53vgSMmo
H/o5EgnF0mS93Vy6XkgncUstIJfRUwgAhVm5VOFmeXalSIQDLxuzv2Xun21JT9Jm
aeAFilsIlHNCrHHk7N7XW6J0Ewy/njss4jOTY8W77sYDL7hczOsyAB9edr5mcIwH
U0udMoUWf+ihJOy53tvF8BWdzJcftpu6VDhxKDbWuhrcrX+a/oQl+VowzrAy/WXh
x4pD1ISuC2ILgLkbJRmfMZM/CQijUL2ZO4u54unH8ysjVI/rak2O59Z5XpRrUgur
8zT+tMDfxoWFeMXQZpWznQ9Olzu6LYaJnZQ5SYddpJql38YTmUwu4rIflNioeGqR
JVcLc4xlJ75nwFH28kbD
=+HbW
-----END PGP SIGNATURE-----

--=-GBAeYd/XAxzz27JyKuiK--
