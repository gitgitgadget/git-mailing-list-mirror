From: Jan Hudec <bulb@ucw.cz>
Subject: Re: [PATCH 07/16] git-read-tree: take --submodules option
Date: Fri, 25 May 2007 22:35:05 +0200
Message-ID: <20070525203505.GB4493@efreet.light.src>
References: <20070518220826.GM942MdfPADPa@greensroom.kotnet.org> <20070518224209.GG10475@steel.home> <7vd50x1n0r.fsf@assigned-by-dhcp.cox.net> <20070519130542.GR942MdfPADPa@greensroom.kotnet.org> <7v4pm8y8tf.fsf@assigned-by-dhcp.cox.net> <20070520155407.GC27087@efreet.light.src> <7vbqgfmjki.fsf@assigned-by-dhcp.cox.net> <20070521165938.GA4118@efreet.light.src> <20070521211133.GD5412@admingilde.org> <7viraixeme.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KFztAG8eRSV9hGtP"
Cc: Martin Waitz <tali@admingilde.org>, skimo@liacs.nl,
	Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri May 25 22:35:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrgVI-0001ag-0B
	for gcvg-git@gmane.org; Fri, 25 May 2007 22:35:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753033AbXEYUfJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 May 2007 16:35:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755664AbXEYUfJ
	(ORCPT <rfc822;git-outgoing>); Fri, 25 May 2007 16:35:09 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:46169 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753033AbXEYUfH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 May 2007 16:35:07 -0400
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id 1FAD1576E8;
	Fri, 25 May 2007 22:35:06 +0200 (CEST)
Received: from bulb by efreet.light.src with local (Exim 4.67)
	(envelope-from <bulb@ucw.cz>)
	id 1HrgV7-0001q3-G8; Fri, 25 May 2007 22:35:05 +0200
Content-Disposition: inline
In-Reply-To: <7viraixeme.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48411>


--KFztAG8eRSV9hGtP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 24, 2007 at 11:26:01 -0700, Junio C Hamano wrote:
> Martin Waitz <tali@admingilde.org> writes:
> > On Mon, May 21, 2007 at 06:59:38PM +0200, Jan Hudec wrote:
> [...]
>=20
> I was hoping that we can start from an initial cut that supports
> only a superproject that had its subprojects in their places
> from its initial commit, and did not have to worry about this
> from day one, and deal with this kind of "more advanced" stuff
> incrementally.  Unfortunately it's more fun to talk about more
> advanced stuff than starting with small but solid stuff.
>=20
> And we would need to make sure whatever we do as the "small but
> solid" initial round can later support more advanced
> arrangements later, so we would need to think about the issues
> now anyway to a certain degree.
>=20
> How about doing something like this, instead?

It's almost exactly what I had in mind, except much better described, so
I definitely support this. It seems that it can work.

>  (1) superproject .gitmodules (in-tree) and .git/config (local
>      repository) use the three-level naming in $gmane/47567.
>      Namely, (1a) .gitmodules says which subdirectory has a
>      checkout of what project, and names the project in
>      logical/abstract terms, not with a URL (e.g. "kernel26");
>      (1b) .gitmodules also associates a set of suggested URLs
>      for each of the logical/abstract project name; (1c)
>      .git/config records which project are of interest.
>=20
>  (2) In superproject .git/, we would have a bare repository for
>      each project used by the superproject.
>=20
> 	.git/subproject/kernel26/{objects,refs,...}
>=20
>      This is created by making a bare clone from the upstream
>      URL, decided by the user with the help from suggested URL
>      described in the superproject .gitmodules.
>=20
>      The idea is to use this repository as a long-term
>      subproject state across branch switching.
>=20
>  (3) When we need to check out a revision of superproject whose
>      .gitmodules has "kernel-src/ -> kernel26", and when we
>      haven't done so (perhaps we are doing an initial checkout,
>      perhaps we are switching from a different revision of the
>      superproject that did not have "kernel26" project at
>      kernel-src/ directory), we rm -f kernel-src/ and then
>      "git-clone -l -s" from the repository we keep in (2) to
>      populate kernel-src/ directory.

If the "clone" could also share the refs, config and everything except HEAD,
it would make it completely (or almost so) transparent to the user. Making =
it
non-transparent will work well enough though and should not require any new
changes.

The problem is, that than the HEAD could get out of sync with the refs
(because they are linked from other repo), so it would have to remember both
the commit name and the symbolic ref. I would behave as symref only if the
commit name in it and the target are the same and as hard ref otherwise.

>  (4) Before performing the above step (3), we need to make sure
>      we are not losing anything in kernel-src/ if exists.  Three
>      cases plus one:
>=20
>      (4a) The path kernel-src/ in the old checkout was not a
>      subproject (either it did not exist, it was a blob, or it
>      was a directory with files that are tracked as part of the
>      superproject).  The usual "don't lose local modification"
>      rule we use try to carry local changes forward across
>      branch switching, but in this case we shouldn't do so.
>=20
>      (4b) It has the same logical/abstract project checked out;
>      the commit recorded in the superproject tree may or may not
>      be the same as what its HEAD points at.  In this case we do
>      not have to worry about swapping the git repository at
>      kernel-src/ directory, although we would need to check out
>      the correct revision, and worry about what to do with any
>      local modification (I think the usual "don't lose local
>      modification but carry them forward" rule would be Ok in
>      this case).
>=20
>      (4c) It has a different project checked out; we need to be
>      careful to keep local changes, and also we need to make
>      sure the local changes in this subproject repository are
>      pushed back to (2).  It could be that automated "git push"
>      after making sure everything is committed is sufficient and
>      have the user handle failure cases.
>=20
>      (4d) This applies not just "before step (3)", but in cases
>      where we need to replace a checked out subproject directory
>      with something else (e.g. blob or directory that belong to
>      the superproject, or noneness).  We would need to make sure
>      no local change is lost, and the repository is synched up
>      with (2).
>=20
> I think an arrangement like this would solve "symlink is a bitch
> for MinGW" problem Johannes Sixt brought up today with Sven's
> RFC as well.

It would also solve (rare) case when for some reason the same subproject
should be checked out twice (different revisions).

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--KFztAG8eRSV9hGtP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGV0h5Rel1vVwhjGURAtxxAKDM0RSalYCh2A4/x22ILRtAz+eh2ACfQUN+
tvSRwf9261j4Lu+7OGqzhGY=
=QP5p
-----END PGP SIGNATURE-----

--KFztAG8eRSV9hGtP--
