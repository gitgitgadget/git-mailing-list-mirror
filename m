From: Luciano Rocha <luciano@eurotux.com>
Subject: Re: New to git: sorry for obvious question.
Date: Mon, 4 Feb 2008 10:50:07 +0000
Message-ID: <20080204105006.GA15855@bit.office.eurotux.com>
References: <47A6E130.7090909@glidos.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Yylu36WmvOXNoKYn"
Cc: git@vger.kernel.org
To: Paul Gardiner <osronline@glidos.net>
X-From: git-owner@vger.kernel.org Mon Feb 04 11:57:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLz0y-0007uA-5q
	for gcvg-git-2@gmane.org; Mon, 04 Feb 2008 11:57:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751205AbYBDK4z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2008 05:56:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751238AbYBDK4z
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Feb 2008 05:56:55 -0500
Received: from os.eurotux.com ([216.75.63.6]:46380 "EHLO os.eurotux.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750848AbYBDK4y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2008 05:56:54 -0500
X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.kernel.org; Mon, 04 Feb 2008 05:56:54 EST
Received: (qmail 1879 invoked from network); 4 Feb 2008 10:50:11 -0000
Received: from nc.eurotux.com (HELO bit.office.eurotux.com) (luciano@81.84.255.161)
  by os.eurotux.com with AES256-SHA encrypted SMTP; 4 Feb 2008 10:50:11 -0000
Content-Disposition: inline
In-Reply-To: <47A6E130.7090909@glidos.net>
User-Agent: Mutt/1.5.14 (2007-03-31)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72489>


--Yylu36WmvOXNoKYn
Content-Type: multipart/mixed; boundary="Dxnq1zWXvFF0Q93v"
Content-Disposition: inline


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 04, 2008 at 09:56:00AM +0000, Paul Gardiner wrote:
>  Hi,
>=20
>  I've moved a project from CVS on sourceforge to git on repo.or.cz.  I
>  want a local mirror on my own home server, so that it appears amongst
>  the projects shown by my own gitweb set up, and so it gets caught by
>  my backup system.  I've created the mirror with
>=20
>    git clone --bare <remote-url> <local-dir>
>=20
>  and that seems fine.  But how do I now keep it up to date.  I was
>  guessing a cron job doing some sort of git pull, but pull doesn't
>  look to work on --bare proj.git type repositories.

You want git fetch. Git pull also updates the working copy, which you
don't have.

Also, git clone --bare doesn't set up the origin configuration, and I
have to do it by hand:
  git config remote.origin.url "$url"
  git config remote.origin.fetch "+refs/heads/*:refs/heads/*"

As for keeping clones up to date, I include a script I use daily for
that purpose.

--=20
Luciano Rocha <luciano@eurotux.com>
Eurotux Inform=E1tica, S.A. <http://www.eurotux.com/>

--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=update

#!/bin/bash

cd /media/stuff/src || exit 1

lockf=/tmp/.uprepo.lock
lockfile -60 -l 36000 -r 20 $lockf || exit 1

TL=$((20*60))

running()
{
	kill -0 $* &> /dev/null
}

tl()
{
	local max=$(($1+SECONDS))
	shift
	exec "$@" &
	while running $! &> /dev/null && [ $max -ge $SECONDS ]; do sleep 1; done
	if running $!; then
		kill $! &> /dev/null
		sleep 1
		kill -9 $! &> /dev/null
	fi
}

trap "rm -f $lockf" EXIT

shopt -s dotglob

for i in *.git */*.git; do
	[ -h "$i" ] && continue
	[ -d "$i" ] || continue

	d="${i%/.git}"

	echo $d
	if [ "$d" = "$i" ]; then
		(cd "$d" && tl $TL git fetch) 2>&1 | nocr
	elif [ -d "$i/svn" ]; then
		(cd "$d" && tl $TL git svn fetch) 2>&1 | nocr
	elif [ -e "$d/.cvsurl" ]; then
		(cd "$d" && tl $TL git cvsimport $(<.cvsurl)) 2>&1 | nocr
	elif [ -e "$d/.svnurl" ]; then
		(cd "$d" && tl $TL git svnimport -r $(<.svnurl)) 2>&1 | nocr
	else
		(cd "$d" && tl $TL git pull) 2>&1 | nocr
	fi
done

for i in */*.hg */*/*.hg; do
	[ -h "$i" ] && continue
	[ -d "$i" ] || continue

	d="${i%/.hg}"

	echo $d
	(cd "$d" && tl $TL hg pull)
done

for i in */*_darcs; do
	[ -h "$i" ] && continue
	[ -d "$i" ] || continue

	d="${i%/_darcs}"

	echo $d
	(cd "$d" && tl $TL darcs pull -aq)
done

for i in */.svn; do
	[ -h "$i" ] && continue
	[ -d "$i" ] || continue

	d="${i%/.svn}"

	echo $d
	(cd "$d" && tl $TL svn up -q)
done

for i in */CVS; do
	[ -h "$i" ] && continue
	[ -d "$i" ] || continue

	d="${i%/CVS}"

	echo $d
	(cd "$d" && tl $TL cvs -Q -z3 up -P)
done

--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=nocr

#!/usr/bin/perl
use warnings;
use strict;

-t && exec "/bin/cat";

undef $/;

my $in = <>;

$in =~ s/^.*\r(?!\n)//gm;

print $in;

--Dxnq1zWXvFF0Q93v--

--Yylu36WmvOXNoKYn
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFHpu3einSul6a7oB8RArpvAJ9zjbxlPLyQA9tkcUzfBY7Yu98amgCfeBSP
Im9RpXRNvjDrV9insd2x09o=
=oY2Z
-----END PGP SIGNATURE-----

--Yylu36WmvOXNoKYn--
