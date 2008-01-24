From: Aidan Van Dyk <aidan@highrise.ca>
Subject: Re: Trying to get GIT running on SCO OpenServer
Date: Thu, 24 Jan 2008 11:23:38 -0500
Message-ID: <20080124162338.GC17244@yugib.highrise.ca>
References: <20080123212613.GN2230@yugib.highrise.ca>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+HP7ph2BbKc20aGI"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 24 17:24:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JI4sD-0008Sz-BV
	for gcvg-git-2@gmane.org; Thu, 24 Jan 2008 17:24:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753044AbYAXQXk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jan 2008 11:23:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753039AbYAXQXk
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jan 2008 11:23:40 -0500
Received: from yugib.highrise.ca ([205.150.199.213]:44600 "EHLO
	yugib.highrise.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753044AbYAXQXj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jan 2008 11:23:39 -0500
Received: from localhost (yugib.highrise.ca [205.150.199.213])
	by yugib.highrise.ca (Postfix) with ESMTP id 89F20111E3A;
	Thu, 24 Jan 2008 11:23:38 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20080123212613.GN2230@yugib.highrise.ca>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71630>


--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

OK, piling hack upon hack to get things to work, I've got 4 tests that
don't pass:
	-rwxr-xr-x 1 aidan group  5733 Jan 23 20:57 t/t5302-pack-index.sh
	-rwxr-xr-x 1 aidan group  4204 Dec  4 15:21 t/t5400-send-pack.sh
	-rwxr-xr-x 1 aidan group  4321 Dec  4 15:21 t/t7003-filter-branch.sh
	-rwxr-xr-x 1 aidan group 16846 Jan 23 20:57 t/t9500-gitweb-standalone-no-e=
rrors.sh

git-pack-objects is segfaulting:
	~/software/git.git/t/trash$ git-pack-objects test < obj-list
	Counting objects: 102, done.
	Compressing objects: 100% (101/101), done.
	Segmentation Fault

Stack trace:
	SIGNALED 11 (segv code[SEGV_MAPERR] address[0xbff68008]) in p1
	184:    <no source text available>
	debug> stack
	Stack Trace for p1, Program git-pack-objec
	*[0] find_packed_object(presumed: 0, 0, 0xc)    [=EF=BF=BD\@builtin-pack-o=
bjects.c@184]
	 [1] write_one(presumed: 0xc, 0, 0)     [=EF=BF=BD\@builtin-pack-objects.c=
@512]
	 [2] write_pack_file(presumed: 0x8049364, 0, 0) [=EF=BF=BD\@builtin-pack-o=
bjects.c@628]
	 [3] cmd_pack_objects() [=EF=BF=BD\@builtin-pack-objects.c@2245]

Before I dig too deeply, does that look familiar to anyone?

Just FYI, my current stack of hacks is:
	HACK: BROKEN_FOPEN
	HACK: BROKEN_VSNPRINTF
	HACK: strtoul
	NO_RSYNC to avoid mkdtemp

An interesting one is the strtoul HACK:
	diff --git a/builtin-unpack-objects.c b/builtin-unpack-objects.c
	index 1e51865..2c2e187 100644
	--- a/builtin-unpack-objects.c
	+++ b/builtin-unpack-objects.c
	@@ -368,7 +368,11 @@ int cmd_unpack_objects(int argc, const char **argv, c=
onst char *prefix)
					hdr->hdr_version =3D htonl(strtoul(arg + 14, &c, 10));
					if (*c !=3D ',')
						die("bad %s", arg);
	-                               hdr->hdr_entries =3D htonl(strtoul(c + 1, =
&c, 10));
	+{      /* Another ugly SCO hack */
	+char*d;
	+                               hdr->hdr_entries =3D htonl(strtoul(c + 1, =
&d, 10));
	+c =3D d;
	+}
					if (*c)
						die("bad %s", arg);
					len =3D sizeof(*hdr);

Is this just a *completely* broken compiler?  With out this hack,
"c" is set to something farther ahead then the null at the end of the
"--pack-objects=3D2,10", and the if (*c) test obviously fails (and the
value read by the strtoul isn't correct either).

I've verified that the c *is* ",10" before entering that line... and I
can't see any reason why that wouldn't "just work", but hey, this is
SCO.

a.

--=20
Aidan Van Dyk                                             Create like a god,
aidan@highrise.ca                                       command like a king,
http://www.highrise.ca/                                   work like a slave.

--+HP7ph2BbKc20aGI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFHmLuKuVxNPsxNPScRAhXKAJ414El0o5FcptqV5JVujzcZG3N/kACfULwW
0uWl5QY5NyFCUiemeq3KyjQ=
=99mq
-----END PGP SIGNATURE-----

--+HP7ph2BbKc20aGI--
