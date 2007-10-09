From: martin f krafft <madduck@madduck.net>
Subject: Re: confused about a conflict during octopus merging
Date: Tue, 9 Oct 2007 10:47:48 +0100
Message-ID: <20071009094748.GA1158@lapse.madduck.net>
References: <20071009003156.GA30498@lapse.madduck.net> <alpine.LFD.0.999.0710081812200.4964@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qDbXVdCdHGoSgWSk"
Cc: Linus Torvalds <torvalds@linux-foundation.org>
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Oct 09 11:48:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfBhB-0003j2-3R
	for gcvg-git-2@gmane.org; Tue, 09 Oct 2007 11:48:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753276AbXJIJr7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Oct 2007 05:47:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753243AbXJIJr7
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Oct 2007 05:47:59 -0400
Received: from clegg.madduck.net ([82.197.162.59]:35839 "EHLO
	clegg.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753018AbXJIJr5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Oct 2007 05:47:57 -0400
Received: from lapse.madduck.net (absinthe.ifi.unizh.ch [130.60.75.58])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "lapse.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTP id 07DB1BE70;
	Tue,  9 Oct 2007 11:47:49 +0200 (CEST)
Received: by lapse.madduck.net (Postfix, from userid 1000)
	id 67D6C53CAC; Tue,  9 Oct 2007 10:47:47 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.999.0710081812200.4964@woody.linux-foundation.org>
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux lenny/sid kernel 2.6.22-2-686 i686
X-Spamtrap: madduck.bogus@madduck.net
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Virus-Scanned: ClamAV 0.91.2/4513/Tue Oct  9 05:22:11 2007 on clegg.madduck.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60377>


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Thanks, Linus, for taking your time to answer me. I truly appreciate
it.

also sprach Linus Torvalds <torvalds@linux-foundation.org> [2007.10.09.0221=
 +0100]:
> So when the octopus merge starts merging in "master" into the
> "merger" branch, it will *not* just fast-forward the branch to
> "master". Instead, if will generate a new tree that is basically
> the merged state: but that new tree is *not* the same as the
> master commit, it's literally a merge of the two branches - which
> in practice means that it has the same *content* as master, but
> it's not at that commit.

Okay, this makes perfect sense.

> And so now we have a half-way done octopus merge, with the first
> branch added. Now it merges in the second branch ("second"), and
> it *still* has the merge base being the original merge base,
> namely "merger".
>=20
> And from that standpoint, it really *is* a conflict.=20

I would have to agree with you: this is pretty exactly what's going
on.

Now, I think Git could do better though. Fast-forwarding
octopus merges, as you suggest, is one possible enhancement, but is
that the solution to my problem? Yes, but could we do better?

Couldn't Git just ignore any commit it has already seen in this
octopus merge? I think this is perfectly okay in terms of the
resulting ancestry, it's really all about applying a commit to the
worktree or not.

Recall the original tree:

  x -- master: d2
  | x -- second: b
  |/
  x  d1
  |
  x -- merger: a

Now after merging master, the tree is at the same state as it is at
the tip of master. The asterisk denotes that the commit is half-way
done:

  x  c* (a+d1+d2)
  |\
  | x -- master: d2
  | | x -- second: b
  | |/
  | x  d1
  |/
  x  a

Next, we merge second to create c2

  x_ c2*  ((a+d1+d2)+(d1+b))
  |\ \
  | | |
  | x-|- master: d2
  | | |
  | | x -- second: b
  | |/
  | x  d1
  |/
  x  a

(yay ASCII art!)

At this point, the conflict happens, when Git tries to re-apply d1
to the work tree. But since d1 is already in the ancestry of the
node into which we are merging, couldn't it just skip applying the
commit to the worktree?

  x_ c  (a+d1+d2+b)
  |\ \
  | | |
  | x-|- master: d2
  | | |
  | | x -- second: b
  | |/
  | x  d1
  |/
  x  a

If it does, then I think ordering of merges for an octopus becomes
relevant, but I'd say that's already the case.

And I guess this is identical to fast-forwarding the branches...
just seems like approaching it from another angle to me.

> If you think of octopus merges as a really stupid thing where git
> will mindlessly do a three-way merge based on the *current* state
> with all the branches you name, then you get the current octopus
> merge. You just expected it to be smarter than it is, probably
> because you compare it to the *real* merge.

No, Git just raised the bar for expectations half-way up to the
moon In other words: you spoiled me so far; now I won't settle for
less than perfection. :)

--=20
martin;              (greetings from the heart of the sun.)
  \____ echo mailto: !#^."<*>"|tr "<*> mailto:" net@madduck
=20
"however jewel-like the good will may be in its own right, there is
 a morally significant difference between rescuing someone from
 a burning building and dropping him from a twelfth-storey window
 while trying to rescue him."
                                                       -- thomas nagel
=20
spamtraps: madduck.bogus@madduck.net

--qDbXVdCdHGoSgWSk
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHC05EIgvIgzMMSnURApS6AJwPnBlG2Xt8xgEm0dwDu9HUL56HIwCfcnx2
U5Ebfj0RhO6mhq/OHgnBLbo=
=e7OF
-----END PGP SIGNATURE-----

--qDbXVdCdHGoSgWSk--
