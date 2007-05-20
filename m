From: Jan Hudec <bulb@ucw.cz>
Subject: Re: [PATCH 07/16] git-read-tree: take --submodules option
Date: Sun, 20 May 2007 17:54:07 +0200
Message-ID: <20070520155407.GC27087@efreet.light.src>
References: <11795163053812-git-send-email-skimo@liacs.nl> <11795163061588-git-send-email-skimo@liacs.nl> <20070518215312.GB10475@steel.home> <20070518220826.GM942MdfPADPa@greensroom.kotnet.org> <20070518224209.GG10475@steel.home> <7vd50x1n0r.fsf@assigned-by-dhcp.cox.net> <20070519130542.GR942MdfPADPa@greensroom.kotnet.org> <7v4pm8y8tf.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GZVR6ND4mMseVXL/"
Cc: skimo@liacs.nl, Alex Riesen <raa.lkml@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun May 20 17:54:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hpnji-0002md-4L
	for gcvg-git@gmane.org; Sun, 20 May 2007 17:54:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756770AbXETPyQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 May 2007 11:54:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757119AbXETPyP
	(ORCPT <rfc822;git-outgoing>); Sun, 20 May 2007 11:54:15 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:2796 "EHLO mail.bluetone.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756770AbXETPyP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2007 11:54:15 -0400
Received: from ([85.207.119.145])
	by mail.bluetone.cz with ESMTP  id 5203017.409616;
	Sun, 20 May 2007 17:54:07 +0200
Received: from bulb by efreet.light.src with local (Exim 4.67)
	(envelope-from <bulb@ucw.cz>)
	id 1HpnjT-0000Xz-L2; Sun, 20 May 2007 17:54:07 +0200
Content-Disposition: inline
In-Reply-To: <7v4pm8y8tf.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-esp: ESP<0>=
	RBL:<0> 
	SHA:<0> 
	UHA:<0> 
	BAYES:<0> 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47847>


--GZVR6ND4mMseVXL/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 19, 2007 at 11:20:12 -0700, Junio C Hamano wrote:
> Sven Verdoolaege <skimo@kotnet.org> writes:
>=20
> > Does everyone agree that we should fetch (possibly after asking
> > for confirmation from the use) _during_ the checkout ?
> > I now only fetch submodules during a fetch of the supermodule
> > (actually, in my current patch set, I only fetch a submodule
> > the first time I see it, but that's a bug), but if there is
> > a consensus on this, I can switch to fetching during checkout.
>=20
> I think fetching of subproject during fetch or clone of
> superproject would not make much sense.  Making it part of
> superproject checkout would probably be the way we will end up
> going.  The detail of "which part of the checkout" would need to
> be defined, and I tend to agree with Alex that checkout itself
> would need to be multi-phased, but I think that is a minor
> implementation detail we can discuss after how the overall flows
> should look like.

IMHO it makes more sense to fetch during fetch of superproject:

 - If you don't fetch the superproject, it won't start refering to
   unavailable commit of subproject. So should only need to fetch subproject
   after fetching superproject.

 - If you fetch from more than one location, you want to fetch subproject
   from location corresponding to where you fetch superproject from.
  =20
   Let's have a repository of project P with remotes PA and PB. Let it have
   a subproject S with remotes SA and SB.

   Whenever I pull P from PA, it might refer to commit of S, that is only
   available from SA (because that's what PA owner uses). Whenever I pull
   P from PB, it might refer to commit of S, that is only available from SB
   (again because that's what PB owner uses).

   Now checkout does not know, whether I pulled the target revision from PA
   or PB, so:
    - Either it has to fetch both. But say the commit I want is in SB and SA
      contains a lot of new stuff, which will slow the thing down, though
      I don't need it.
    - Or it has to guess by looking whether any heads in remotes/PA or
      remotes/PB are descendants of the commit being checked out. But that
      feels rather hacky.

   I see several options:
    - Fetch will recurse. This should work ok and is IMHO least magic. We c=
an
      also add some way to specify refspecs for the subproject, giving user
      control over what is fetched.
    - Fetch will store a "pending fetch from" note in the subproject and
      checkout, if it does not find the revision, will try fetching from all
      sources pointed to by those notes. There is still a problem with what
      exactly to fetch (user can specify in config).
    - Checkout will ask all subproject repositories whether they have given
      commit and pull the first one that does. This would get the needed
      commit most certainly. It would be slower though, because it would ne=
ed
      to ask all the repositories whether they have the particular object.
      It also leaves the tracking branches in subproject in somewhat random
      state (maybe both repositories had the commit, so it pulled from the
      other one that user would etc.).

> > As to the key to use to lookup the URL in the config, right
> > now I simply use the directory name where it is attached
> > (which seems like a useful default to me).

The extra level of indirection has the advantage, that you can describe
moving the same subproject to a different directory.

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--GZVR6ND4mMseVXL/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGUG8fRel1vVwhjGURAgQgAJ9ySCFFJMbYEcfBuYKlwURd1KvwfQCfRo0N
qGmZ3Bc4Ec99x5FSyClzLm4=
=Ih/G
-----END PGP SIGNATURE-----

--GZVR6ND4mMseVXL/--
