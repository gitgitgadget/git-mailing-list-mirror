From: Martin Waitz <tali@admingilde.org>
Subject: Re: Notes on Using Git with Subprojects
Date: Wed, 27 Sep 2006 10:06:52 +0200
Message-ID: <20060927080652.GA8056@admingilde.org>
References: <45196628.9010107@gmail.com> <Pine.LNX.4.64.0609261629160.9789@iabervon.org> <20060926213003.GA8177@spearce.org> <4519AACD.7020508@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J2SCkAp4GZ/dPZZf"
Cc: Shawn Pearce <spearce@spearce.org>,
	Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 27 10:07:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSURb-0008K3-VH
	for gcvg-git@gmane.org; Wed, 27 Sep 2006 10:07:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932181AbWI0IG6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Sep 2006 04:06:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932229AbWI0IG6
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Sep 2006 04:06:58 -0400
Received: from agent.admingilde.org ([213.95.21.5]:55939 "EHLO
	mail.admingilde.org") by vger.kernel.org with ESMTP id S932181AbWI0IG5
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Sep 2006 04:06:57 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1GSURQ-0002Zw-Nt; Wed, 27 Sep 2006 10:06:52 +0200
To: A Large Angry SCM <gitzilla@gmail.com>
Content-Disposition: inline
In-Reply-To: <4519AACD.7020508@gmail.com>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27889>


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Tue, Sep 26, 2006 at 03:33:49PM -0700, A Large Angry SCM wrote:
> So, for each subproject of a parent project, you want to record branch,=
=20
> version (commit ID), and directory location. Not quite as easy to do in=
=20
> a makefile but do-able.

I've been playing with this kind of subprojects a little bit.

My current approach is like this:

 * create a .gitmodules file which lists all the directories
   which contain a submodule.
 * the .git/refs/heads directory of the submodule gets stored in
   .gitmodule/<modulename> inside the parent project
 * both things above should be tracked in the parent project.
   This way you always store the current state of each submodule
   in each commit of the parent project.  And you don't have to
   create a new parent commit for each change.  You can commit
   to the parent project when you think that all your modules are
   in a good state.
 * When checking out a project, all submodules listen in .gitmodules
   get checked out, too.
 * If there is a merge conflict in the module list or its refs/heads,
   this is handled specially, e.g. by triggering a new merge inside
   the submodule.
 * The object directory is shared between the parent and all modules.
   To make fsck-objects happy, the parent gets a refs/module link
   pointing to .gitmodule/ and all submodules get a refs/parent
   link pointing to the refs directory of the parent.

The concept is similiar to the gitlink objects which have been floating
around, but it is easier to prototype as no new git object type has to
be created.  If it works well we can later move the information stored
in .gitmodule* into an object type of its own.

By storing the complete refs/heads directory for each submodule instead
of only one head, it is possible to track multiple branches of a
subproject.  I'm don't know yet how this works out in praktice but I
think that it can be nice to be able to atomically commit to several
branches of one submodule (perhaps one branch per customer, per
hardware platform, whatever).

So, what have I done up to now? Not much. I created a little
script to set up a submodule as described above:
http://git.admingilde.org/?p=3Dtali/git.git;a=3Dblob;f=3Dgit-init-module.sh=
;h=3D0108873fd3aa8a42035039b19e8555513c075fca;hb=3Dmodule

Next steps would be to modify clone and checkout to actually be able
to work in such a setup.  If this works then merging of subprojects
has to be done (the most complex part I guess).

--=20
Martin Waitz

--J2SCkAp4GZ/dPZZf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFGjEcj/Eaxd/oD7IRAs1iAJwJy8IaY7h5o9P0GF5zfKfV4J6a/QCfW9BS
ddmEXu2iR5CYzY84Br55B2Y=
=6mhP
-----END PGP SIGNATURE-----

--J2SCkAp4GZ/dPZZf--
