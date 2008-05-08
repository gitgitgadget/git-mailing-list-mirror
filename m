From: David Bryson <david@statichacks.org>
Subject: Re: how to git-archive ignore some files?
Date: Thu, 8 May 2008 10:04:42 -0700
Message-ID: <20080508170442.GK9562@eratosthenes.sbcglobal.net>
References: <1210097731.5238.3.camel@omicron.ep.petrobras.com.br>
Reply-To: David Bryson <david@statichacks.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7phR3qVEw/4Cnor3"
Cc: git@vger.kernel.org
To: Victor Bogado da Silva Lins <victor@bogado.net>
X-From: git-owner@vger.kernel.org Thu May 08 19:17:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ju9jQ-0002pa-QB
	for gcvg-git-2@gmane.org; Thu, 08 May 2008 19:16:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758420AbYEHRPr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2008 13:15:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757554AbYEHRPr
	(ORCPT <rfc822;git-outgoing>); Thu, 8 May 2008 13:15:47 -0400
Received: from cryptobackpack.org ([64.105.32.74]:47498 "EHLO
	mail.cryptobackpack.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755570AbYEHRPp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2008 13:15:45 -0400
X-Greylist: delayed 652 seconds by postgrey-1.27 at vger.kernel.org; Thu, 08 May 2008 13:15:45 EDT
Received: by mail.cryptobackpack.org (Postfix, from userid 1000)
	id 8D1E510D04C2; Thu,  8 May 2008 10:04:50 -0700 (PDT)
X-Spam-Checker-Version: SpamAssassin 3.2.1-gr1 (2007-05-02) on
	ptolemy.cryptobackpack.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.1-gr1
Received: from eratosthenes.statichacks.org (heliosphan.cryptobackpack.org [10.6.6.6])
	by mail.cryptobackpack.org (Postfix) with ESMTP id 74BEB10D04C2;
	Thu,  8 May 2008 10:04:43 -0700 (PDT)
Received: by eratosthenes.statichacks.org (Postfix, from userid 1000)
	id A217214456; Thu,  8 May 2008 10:04:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1210097731.5238.3.camel@omicron.ep.petrobras.com.br>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81540>


--7phR3qVEw/4Cnor3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Victor,

On Tue, May 06, 2008 at 03:15:31PM -0300 or thereabouts, Victor Bogado da S=
ilva Lins wrote:
> I want to use git-archive to create source packages, but my git
> repository has a .gitignore that I don't want to be pushed into the
> archive. So is it possible to keep the .gitignore file in the repository
> and create an archive(*) without it?=20
>=20
> *) using git-archive, off course.=20

Others already discussed the --delete method with tar, and I do something
similar except slightly more flexible.  I have for example, a git repo
that checks out directories from CVS, and of course I don't want these
CVS directories in my 'release'.  So put a executable '.release' file in
each repo that tells my release script how to fix up the tarball to be
production ready.

Here is my release script, modeled after some lines Linus put in the git
documentation.  It is meant to be run, reviewed for mistakes, and then
have the commands run via cut-paste.

#!/bin/bash=20
stable=3D"$1"
last=3D"$2"
new=3D"$3"
chip=3D"$4"
rel=3D`pwd | cut -d'/' -f6 | sed -e 's/\.git//'`

if [ -z $chip ]; then
	reldir=3D$rel
else
	reldir=3D$rel-$chip
fi

reldir=3D"$reldir-$new"
tarfile=3D"$reldir.tar"

if [ -d $reldir ]; then
	echo "release directory $reldir already exists, please remove" 1>&2
	exit 1
fi

if [ -f "../$reldir.tar" ]; then
	echo "Release file ../$reldir.tar already exists, please remove" 1>&2
	exit 1
fi

if [ -f "../$reldir.tar.gz" ]; then
	echo "Release file ../$reldir.tar.gz already exists, please remove" 1>&2
	exit 1
fi

echo "#git tag v$new"
echo "Tagging new release v$new" 1>&2
echo "git archive --prefix=3D$reldir/ v$new > ../$tarfile"
echo "mkdir $reldir"
#echo "git diff v$stable v$new | gzip -9 > ../patch-$new.gz"
echo "git log --no-merges v$new ^v$last > $reldir/ChangeLog-$new"
echo "git shortlog --no-merges v$new ^v$last > $reldir/ShortLog"
echo "git diff --stat --summary -M v$last v$new > $reldir/diffstat-$new"
echo "tar -rf ../$tarfile $reldir/*"
=2E/.release $reldir ../$tarfile
if [ $? !=3D 0 ]; then
	echo ".release script failed! removing generated files" 1>&2
	echo "rm -rf $reldir ../$tarfile"
	exit 1
fi
echo "gzip -9 < ../$tarfile > ../$tarfile.gz"
echo "rm -rf $reldir ../$tarfile"
echo "New release at ../$tarfile.gz" 1>&2

And an example .release file

#!/bin/bash
dirlist=3D"make foo_include scripts"
excludes=3D"--exclude CVS --exclude '*.o' --exclude '*.swp' --exclude '*.d'=
 --exclude '*.a'"
reldir=3D$1
tarfile=3D$2
#echo "make doc && make -C doc/latex pdf"
echo "cp -a $dirlist $reldir"
echo "cp Makefile.release $reldir/Makefile"
echo "tar $excludes -rf $tarfile $reldir/*"

# write over the makefile
echo "cp Makefile.release $reldir/Makefile"
echo "tar -u -f $tarfile $reldir/Makefile"
echo "tar --delete --file=3D$tarfile $reldir/Makefile.release"

# delete the doxygen file
echo "cp Doxyfile $reldir"
echo "tar --delete --file=3D$tarfile $reldir/Doxyfile"

# remove traces of the release file
echo "tar --delete --file=3D$tarfile $reldir/.release"


--7phR3qVEw/4Cnor3
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFIIzKqLfsM4nS2FiARAhVmAJ4/DSz2n9I7XhUPr13803626ptLTwCfXqaW
iOn79tH8yaw1mlK5s0Gg7qw=
=YY3D
-----END PGP SIGNATURE-----

--7phR3qVEw/4Cnor3--
