From: Jan Hudec <bulb@ucw.cz>
Subject: Re: [PATCH 07/16] git-read-tree: take --submodules option
Date: Tue, 22 May 2007 21:37:06 +0200
Message-ID: <20070522193706.GA4432@efreet.light.src>
References: <20070518215312.GB10475@steel.home> <20070518220826.GM942MdfPADPa@greensroom.kotnet.org> <20070518224209.GG10475@steel.home> <7vd50x1n0r.fsf@assigned-by-dhcp.cox.net> <20070519130542.GR942MdfPADPa@greensroom.kotnet.org> <7v4pm8y8tf.fsf@assigned-by-dhcp.cox.net> <20070520155407.GC27087@efreet.light.src> <7vbqgfmjki.fsf@assigned-by-dhcp.cox.net> <20070521165938.GA4118@efreet.light.src> <20070521211133.GD5412@admingilde.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XsQoSWH+UP9D9v3l"
Cc: Junio C Hamano <junkio@cox.net>, skimo@liacs.nl,
	Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Martin Waitz <tali@admingilde.org>
X-From: git-owner@vger.kernel.org Tue May 22 21:39:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HqaCb-00079F-WB
	for gcvg-git@gmane.org; Tue, 22 May 2007 21:39:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757430AbXEVTjV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 May 2007 15:39:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755678AbXEVTjV
	(ORCPT <rfc822;git-outgoing>); Tue, 22 May 2007 15:39:21 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:2956 "EHLO mail.bluetone.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755127AbXEVTjU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 May 2007 15:39:20 -0400
Received: from ([85.207.119.145])
	by mail.bluetone.cz with ESMTP  id 5203017.559648;
	Tue, 22 May 2007 21:37:07 +0200
Received: from bulb by efreet.light.src with local (Exim 4.67)
	(envelope-from <bulb@ucw.cz>)
	id 1HqaAM-0001Cv-R8; Tue, 22 May 2007 21:37:06 +0200
Content-Disposition: inline
In-Reply-To: <20070521211133.GD5412@admingilde.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-esp: ESP<0>=
	RBL:<0> 
	SHA:<0> 
	UHA:<0> 
	BAYES:<0> 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48113>


--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 21, 2007 at 23:11:34 +0200, Martin Waitz wrote:
> On Mon, May 21, 2007 at 06:59:38PM +0200, Jan Hudec wrote:
> > There would be:
> >  /
> >  /.git
> >  /subdir
> >  /.git/submodules/submodule-name.git
> >=20
> > This would require changes to the logic how git finds GIT_DIR (which wo=
uld be
> > really deep change), but it would provide place to store the submodule =
data
> > while the submodule is not being checked out.=20
>=20
> I agree that we need something like that.
>=20
> We don't have to move the entire subproject.git into the superproject,
> but we need to have all _referenced_ objects in the .git dir of the
> superproject.
>=20
> There are several possibilities to do so:
>=20
>  * move the entire .git dir
>  * move .git/objects
>  * explicitly copy all referenced objects

I believe we really need entire .git dir. When the superporject checks out
revision which does not reference that subproject, we still need to preserve
not only the objects of subproject, but also the refs and config.

> I have some experimental code to configure a per-subproject directory
> in the superproject/.git as alternate object store for the submodule
> to make the last two solutions possible.  Perhaps I should dig it out aga=
in
> and adapt it to current git.
>=20
> If there is a 1:1 relationship between subproject and object store then
> even efficient fsck and repack/prune are possible for the submodule witho=
ut
> loosing objects.
> But such a 1:1 relationship is bad when you move subprojects to another
> location (or include the same subproject several times in different
> locations of the tree).
> Perhaps the user should be able to choose which one he wants.

That's why there should be the extra level of indirection using .gitmodules.
It should map the directory name to the object store name, so you can
relocate the subproject.

Including the same project several times is indeed interesting. Maybe the
subprojects should be "light checkouts" (I believe something like this was
already discussed on the list sometime). Those would be .git dirs, that wou=
ld
only have HEAD and pointer to another .git dir with everything else.

> > > Not at all.  There is no reason to believe that the case that
> > > superproject and subproject come from related URLs is more
> > > common.  One of the reasons to do a separated project
> >=20
> > I definitely don't think it's more common. But it's the harder case and=
 it
> > might happen. Generally it will happen if some people work on both the
> > superproject and the subproject. Of course the argument is that than it
> > should not be separate projects, but maybe the teams just partly overla=
p.
>=20
> I think it will be _very_ common to store super and subprojects in
> related locations.  First to be independent from third-party servers
> while working on the superproject.
> Second (and I think more important) because many times there will
> be superproject related adaptations in the subproject.  Yes they
> are independent, and exactly for that reason the subproject upstream
> maintainers may not take every change which is needed to satisfy the
> superproject.  We _now_ see that in all Linux distributions already.
> So when you use superprojects to integrate several independent projects,
> then the superproject maintainer/administrator should really keep a
> clone of all subprojects handy on his site.

Yes, repositories with distribution-specific patches will add a large class
of cases requiring multiple sources support.

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--XsQoSWH+UP9D9v3l
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGU0ZiRel1vVwhjGURAtDDAKC5KAw+1iUpsa+tOF94lT1rdS5YUwCfcmwe
bjiUFHYzBWdeYtctp+Jx45c=
=VCtm
-----END PGP SIGNATURE-----

--XsQoSWH+UP9D9v3l--
