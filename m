From: =?utf-8?Q?=C3=98yvind_A=2E?= Holm <sunny@sunbase.org>
Subject: [RFC] Storing empty directories in Git
Date: Sun, 30 May 2010 16:29:11 +0200
Message-ID: <20100530142908.GA7180@triton>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WIyZ46R2i8wDzkSu"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 30 16:29:24 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OIjVw-0005AT-Hu
	for gcvg-git-2@lo.gmane.org; Sun, 30 May 2010 16:29:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754517Ab0E3O3P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 May 2010 10:29:15 -0400
Received: from smtp.domeneshop.no ([194.63.248.54]:43455 "EHLO
	smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754437Ab0E3O3P (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 May 2010 10:29:15 -0400
Received: from sfn-inkubator-70-227.hib.no ([158.37.70.227] helo=triton)
	by smtp.domeneshop.no with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71)
	(envelope-from <sunny@sunbase.org>)
	id 1OIjVp-0005dY-Km
	for git@vger.kernel.org; Sun, 30 May 2010 16:29:13 +0200
Mail-Followup-To: =?utf-8?Q?=C3=98yvind_A=2E?= Holm <sunny@sunbase.org>,
	git@vger.kernel.org
Content-Disposition: inline
OpenPGP: id=94A506E5; url=http://www.sunbase.org/pubkey.asc
X-Request-PGP: http://www.sunbase.org/pubkey.asc
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148006>


--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I sometimes need to store empty directories in Git, and instead of=20
putting empty .gitignore files everywhere as has been suggested, I=20
created two small shell scripts (git-store-dirs and git-restore-dirs) to=20
store all empty directories in a file named ".emptydirs" at the top of=20
the working tree. The directories are stored as null-separated strings=20
to avoid problems with wacky things like \n or semicolons in the=20
directory names.

Is this a viable method of fixing the emptydir problem? A default file=20
name like ".gitdirectories" could be used, or maybe it=E2=80=99s possible t=
o=20
store a file like this inside the .git/ area if we can come up with a=20
way to store this metadata properly.

The scripts are stored at http://gist.github.com/419015 , but I also=20
include them here:

### git-store-dirs {{{

#!/bin/sh

# git-store-dirs
# Store a list of all directories to $dirfile to be able to restore empty=
=20
# directories. The list is \0-separated in case there are some directory na=
mes=20
# containing (ugh) \n. Use git-restore-dirs(1) to recreate directories.

dirfile=3D.emptydirs
test -d .git/. || { echo $0: Has to be run from the toplevel of the working=
 tree >&2; exit 1; }
find -type d -empty -print0 | grep -E -v -z '/\.git(/|$)' | LC_ALL=3DC sort=
 -z >$dirfile
git add $dirfile

### }}}
### git-restore-dirs {{{

#!/bin/sh

# git-restore-dirs
# Restore empty directories created by git-store-dirs(1)

dirfile=3D.emptydirs
test -d .git/. || { echo $0: Has to be run from the toplevel of the working=
 tree >&2; exit 1; }
test -e $dirfile || { echo $0: No $dirfile file found >&2; exit 1; }
xargs -0 mkdir -p <$dirfile

### }}}

Cheers,
=C3=98yvind

+-| =C3=98yvind A. Holm <sunny@sunbase.org> - N 60.39548=C2=B0 E 5.31735=C2=
=B0 |-+
| OpenPGP: 0xFB0CBEE894A506E5 - http://www.sunbase.org/pubkey.asc |
| Fingerprint: A006 05D6 E676 B319 55E2  E77E FB0C BEE8 94A5 06E5 |
+------------| 06a9d9be-6bf2-11df-8623-90e6ba3022ac |-------------+

--WIyZ46R2i8wDzkSu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkwCdjQACgkQ+wy+6JSlBuUkogCffuNsvlmVEPblgR0OvUX2TvcJ
Ff0AoIhGpZl++bGZz297xVPmJX0vxkk0
=wv+F
-----END PGP SIGNATURE-----

--WIyZ46R2i8wDzkSu--
