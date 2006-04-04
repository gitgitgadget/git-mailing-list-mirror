From: Keith Packard <keithp@keithp.com>
Subject: Re: parsecvs tool now creates git repositories
Date: Mon, 03 Apr 2006 20:51:49 -0700
Message-ID: <1144122709.2303.153.camel@neko.keithp.com>
References: <1143956188.2303.39.camel@neko.keithp.com>
	 <46a038f90604031538x3c94d86ap9f1400427513a3a7@mail.gmail.com>
	 <1144116459.2303.129.camel@neko.keithp.com>
	 <46a038f90604031916r4651b572lb9bae4c5a3d47bc9@mail.gmail.com>
	 <1144117473.2303.132.camel@neko.keithp.com>
	 <46a038f90604031942w779894b8p5ef221482a70a301@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-6s13FM04MAtaXrZxX1wD"
Cc: keithp@keithp.com, Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 04 05:52:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FQcac-0007mF-Il
	for gcvg-git@gmane.org; Tue, 04 Apr 2006 05:52:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964820AbWDDDwS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Apr 2006 23:52:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751464AbWDDDwS
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Apr 2006 23:52:18 -0400
Received: from home.keithp.com ([63.227.221.253]:39432 "EHLO keithp.com")
	by vger.kernel.org with ESMTP id S1751440AbWDDDwR (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Apr 2006 23:52:17 -0400
Received: from localhost (localhost [127.0.0.1])
	by keithp.com (Postfix) with ESMTP id 2CC9E13001F;
	Mon,  3 Apr 2006 20:52:16 -0700 (PDT)
Received: from keithp.com ([127.0.0.1])
	by localhost (keithp.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 09637-02; Mon, 3 Apr 2006 20:52:15 -0700 (PDT)
Received: by keithp.com (Postfix, from userid 1033)
	id B504513001E; Mon,  3 Apr 2006 20:52:15 -0700 (PDT)
Received: from neko.keithp.com (localhost [127.0.0.1])
	by keithp.com (Postfix) with ESMTP id AA9BE14001;
	Mon,  3 Apr 2006 20:52:15 -0700 (PDT)
Received: by neko.keithp.com (Postfix, from userid 1488)
	id DDFA76B428A; Mon,  3 Apr 2006 20:51:51 -0700 (PDT)
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90604031942w779894b8p5ef221482a70a301@mail.gmail.com>
X-Mailer: Evolution 2.4.2.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18374>


--=-6s13FM04MAtaXrZxX1wD
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2006-04-04 at 14:42 +1200, Martin Langhoff wrote:

> Cool. What's the matter with the Pg repo? (Where can I get hold of that r=
epo?)

As usual, the detection of branch locations is messed up.

The postgresql CVS tree is available at:

        rsync anoncvs.postgresql.org::pgsql-cvs/* postgresql.cvs

It's a fairly hefty 300M.

> > > Does it run incrementally? Can it discover non-binary files and pass =
-kk?
> >
> > It doesn't run incrementally, and it unconditionally passes -kk. It's
>=20
> I thought that the .git-cvs directory it created was to be able to run
> incrementally (btw, I think it's fair game to create subdirs inside
> .git for this kind of status-tracking). And passing -kk uncoditionally
> is destructive in some cases (I know... git-cvsimport does it, and I
> want to fix that). If you can ask rcs about the mode if the file and
> not pass -kk for binary files...

nah, the .git-cvs directory is purely for debugging; I leave the various
command outputs there so I can see what went wrong.

I don't really have a good idea of how we'd do this process
incrementally; that's not something I am personally interested in
either, I want to run screaming from CVS as fast as I can at this point.

> > currently using rcs to check out versions of the files, so it should
> > deal with binary content as well as rcs does. Is there something magic =
I
> > need to do here? Like for DOS?
>=20
> We'll let DOS take care of itself ;)

I did discover that rcs has less sophisticated keyword substitution than
cvs; not having any ability to customize stuff.

I guess we need to figure out when to pass -ko and when to pass -kk. The
other alternative I'd like to get around to trying is to directly
generate all of the revision contents from the ,v file.

I've just changed parsecvs to generate blobs for every revision in
each ,v file right after they're read in; putting the necessary code
right into parsecvs should be reasonably straightforward; we don't need
the multi-patch logic as we do want to compute each intermediate version
of the file.

With the blobs all generated, the rest of the operation is a simple
matter of building suitable indices and creating commits out of them.
That's a reasonably fast operation now as it doesn't manipulate any file
contents. Plus, I can do all of the index operations using a single
git-update-index command, so I eliminate a pile of forking.

Doing the file revision generation in-line would allow us to eliminate
most of the remaining forks; we'd run one git-hash-object per file (or
so), then a git-update-index, git-write-tree and git-commit-tree per
resulting commit.

--=20
keith.packard@intel.com

--=-6s13FM04MAtaXrZxX1wD
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBEMe1VQp8BWwlsTdMRAqJdAKDb3fbul84pP9Ik2UaSoPRjndhTwwCfYpwl
UE+hziPbeo6fRx81u+kLuGA=
=DjKJ
-----END PGP SIGNATURE-----

--=-6s13FM04MAtaXrZxX1wD--
