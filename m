From: martin f krafft <madduck@debian.org>
Subject: Re: [topgit] tg update error
Date: Thu, 12 Feb 2009 22:41:06 +0100
Organization: The Debian project
Message-ID: <20090212214106.GC26573@piper.oerlikon.madduck.net>
References: <cc723f590902120009w432f5f61xd6550409835cdbb7@mail.gmail.com> <20090212084811.GA14261@piper.oerlikon.madduck.net> <20090212092558.GB21074@skywalker> <20090212125621.GB5397@sigill.intra.peff.net> <7veiy3l689.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eHhjakXzOLJAF9wJ"
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
	Aneesh Kumar <aneesh.kumar@gmail.com>, git@vger.kernel.org,
	pasky@suse.cz
X-From: git-owner@vger.kernel.org Thu Feb 12 22:43:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXjKr-00067Z-8f
	for gcvg-git-2@gmane.org; Thu, 12 Feb 2009 22:43:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758783AbZBLVlh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2009 16:41:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758674AbZBLVlh
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Feb 2009 16:41:37 -0500
Received: from clegg.madduck.net ([193.242.105.96]:42422 "EHLO
	clegg.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753456AbZBLVlg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2009 16:41:36 -0500
Received: from wall.oerlikon.madduck.net (wall.oerlikon.madduck.net [IPv6:2001:41e0:ff12::1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wall.oerlikon.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTPS id AC7F71D409B;
	Thu, 12 Feb 2009 22:41:07 +0100 (CET)
Received: from piper.oerlikon.madduck.net (piper.oerlikon.madduck.net [IPv6:2001:41e0:ff12:0:211:2fff:fe6b:c869])
	by wall.oerlikon.madduck.net (Postfix) with ESMTPS id 64FE49F13D;
	Thu, 12 Feb 2009 22:41:06 +0100 (CET)
Received: by piper.oerlikon.madduck.net (Postfix, from userid 1000)
	id 1D8964463; Thu, 12 Feb 2009 22:41:06 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7veiy3l689.fsf@gitster.siamese.dyndns.org>
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux 5.0 kernel 2.6.26-1-amd64 x86_64
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Virus-Scanned: ClamAV 0.94.2/8984/Thu Feb 12 15:24:21 2009 on clegg.madduck.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109665>


--eHhjakXzOLJAF9wJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Junio C Hamano <gitster@pobox.com> [2009.02.12.2201 +0100]:
> It would be nice to hear TopGit people defend why setting HEAD to outside
> refs/heads/ is justified, why doing so should not break other things, and
> why it was needed.

As far as I understand it, TopGit does not /need/ to set HEAD to
refs/top-bases/foo, but it currently does so as part of its
algorithm:

When tg-update updates a depending branch, it first merges the
dependent branch into the base of the topic branch, which is pointed
to by the corresponding top-base (refs/top-bases/foo). It then
merges the top-base into the topic branch, "foo" in this case.

The result is the same as if the base branch had been merged into
"foo", and refs/top-bases/foo updated to point to the head of the
base branch.

This stops working, however, as soon as you have a topic branch
depending on more than one base branches. Since you need to track
the base of a topic branch (e.g. in order to be able to get the diff
represented by the TopGit branch), you now have a problem: which of
the base branches is the base to diff against?

TopGit addresses this requirement by creating a "virtual" branch
into which it merges all the bases (into the top-base) first, and
then merging this "virtual" branch into the topic branch. The result
is a merge commit combining all bases, which is a parent of the
merge commit into the topic branch, and can thus serve as the origin
of a diff calculation.

TopGit right now does all of this while HEAD is detached: it points
into the refs/top-bases/* namespace -- the "virtual" branch. Here,
it does the merges of the bases, and then checks out the topic
branch to merge this combined ("virtual") base.

To work around the new restriction in Git, TopGit would need to make
a proper branch, merge the bases into it, merge that branch into the
topic branch, and the probably delete the branch pointer, as it's no
longer needed and would only pollute the refs/heads/* namespace. It
could certainly do this (with a minor performance impact), but it
seems like jumping through hoops and around Git's restrictions,
without any real benefit.

Point being: I understand the reason behind the restriction, and
I wouldn't mind if it were default, but maybe there could be
a controlled way to circumvent it for cases like the one described
above, where it is safe to assume that the user^W^W the tool "knows"
what it is doing.

--=20
 .''`.   martin f. krafft <madduck@d.o>      Related projects:
: :'  :  proud Debian developer               http://debiansystem.info
`. `'`   http://people.debian.org/~madduck    http://vcs-pkg.org
  `-  Debian - when you have better things to do than fixing systems
=20
in the beginning was the word,
and the word was content-type: text/plain

--eHhjakXzOLJAF9wJ
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkmUl3EACgkQIgvIgzMMSnUF3QCg535/jZJ1Z4ey07nS9MAZFL9D
6L8AnjvQuFA11JiXuW/Hh3rItF33LmfD
=nlAM
-----END PGP SIGNATURE-----

--eHhjakXzOLJAF9wJ--
