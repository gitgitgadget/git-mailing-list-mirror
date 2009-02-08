From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: gc considered dangerous
Date: Sun, 8 Feb 2009 21:10:43 +0100
Message-ID: <200902082110.44151.robin.rosenberg.lists@dewire.com>
References: <200902080347.25970.robin.rosenberg.lists@dewire.com> <alpine.DEB.1.00.0902081551290.10279@pacific.mpi-cbg.de> <7vhc34y9za.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git ML <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 08 21:12:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWG0l-0000hA-Dy
	for gcvg-git-2@gmane.org; Sun, 08 Feb 2009 21:12:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753440AbZBHUKt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Feb 2009 15:10:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753413AbZBHUKt
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Feb 2009 15:10:49 -0500
Received: from mail.dewire.com ([83.140.172.130]:20454 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753321AbZBHUKs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 Feb 2009 15:10:48 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id E5E11147E89C;
	Sun,  8 Feb 2009 21:10:46 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cr8tL-pa1aS6; Sun,  8 Feb 2009 21:10:46 +0100 (CET)
Received: from sleipner.localnet (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 2F0F7A149A4;
	Sun,  8 Feb 2009 21:10:46 +0100 (CET)
User-Agent: KMail/1.10.4 (Linux/2.6.27-11-generic; KDE/4.1.4; i686; ; )
In-Reply-To: <7vhc34y9za.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109009>

s=F6ndag 08 februari 2009 21:00:57 skrev Junio C Hamano:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>=20
> > My preliminary guess is that this code in pack-write.c needs to use=
 the=20
> > lock file paradigm:
> >
> >         if (!index_name) {
> > 		[...]
> >         } else {
> >                 unlink(index_name);
> >                 fd =3D open(index_name, O_CREAT|O_EXCL|O_WRONLY, 06=
00);
> >         }
>=20
> Whoa.  That particular code has been (and is still) correct.
>=20
> When repacking we should pack into a temporary pack and idx file and =
then
> replace the real ones after both new pack and its idx are successfull=
y
> written, and I thought that is how we've been doing this all the time=
=2E
> Maybe the caller has been broken at some point?  Sigh...
>=20
I intend to test something like this (as of yet completely untested)

-- robin

commit 25a77c80efeb221d165db0bef66b4498aacfac96
Author: Robin Rosenberg <robin.rosenberg@dewire.com>
Date:   Sun Feb 8 20:59:30 2009 +0100

    Make repack more fail-safe
   =20
    If renaming an old pack fails try to restore halfway renames
    befor failing. The basis is the assumption that this occurs
    because a files is locked for reading on Windows.

diff --git a/git-repack.sh b/git-repack.sh
index 458a497..e816997 100755
--- a/git-repack.sh
+++ b/git-repack.sh
@@ -94,14 +94,25 @@ for name in $names ; do
 	chmod a-w "$PACKTMP-$name.idx"
 	mkdir -p "$PACKDIR" || exit
=20
-	for sfx in pack idx
-	do
-		if test -f "$PACKDIR/pack-$name.$sfx"
-		then
-			mv -f "$PACKDIR/pack-$name.$sfx" \
-				"$PACKDIR/old-pack-$name.$sfx"
-		fi
-	done &&
+	if test -f "$PACKDIR/pack-$name.pack"
+	then
+		mv -f "$PACKDIR/pack-$name.pack" \
+			"$PACKDIR/old-pack-$name.pack"
+	fi &&
+	if test -f "$PACKDIR/pack-$name.idx"
+	then
+		mv -f "$PACKDIR/pack-$name.idx" \
+			"$PACKDIR/old-pack-$name.idx" ||
+		(
+			mv -f $PACKDIR/old-pack-$name.pack" \
+			"$PACKDIR/pack-$name.pack" || (
+			echo >&2 "Failed to restore after a failure to rename pack-$name to=
 old-$pack"
+			echo >&2 "Please aquire advice on how to recover from this"
+			echo >&2 "situation before you proceed."
+			false
+			)
+		)
+	fi &&
 	mv -f "$PACKTMP-$name.pack" "$PACKDIR/pack-$name.pack" &&
 	mv -f "$PACKTMP-$name.idx"  "$PACKDIR/pack-$name.idx" &&
 	test -f "$PACKDIR/pack-$name.pack" &&
@@ -109,6 +120,8 @@ for name in $names ; do
 		echo >&2 "Couldn't replace the existing pack with updated one."
 		echo >&2 "The original set of packs have been saved as"
 		echo >&2 "old-pack-$name.{pack,idx} in $PACKDIR."
+		echo >&2 "Please aquire advice on how to recover from this situation=
"
+		echo >&2 "before you proceed."
 		exit 1
 	}
 	rm -f "$PACKDIR/old-pack-$name.pack" "$PACKDIR/old-pack-$name.idx"
