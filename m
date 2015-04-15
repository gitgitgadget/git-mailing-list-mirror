From: Luke Mewburn <luke@mewburn.net>
Subject: [PATCH] progress: no progress in background
Date: Wed, 15 Apr 2015 19:34:18 +1000
Message-ID: <20150415093418.GH23475@mewburn.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rPgHZmYkQ+bUEpVC"
Cc: git@vger.kernel.org, Luke Mewburn <luke@mewburn.net>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Apr 15 11:34:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YiJiF-0000hF-3K
	for gcvg-git-2@plane.gmane.org; Wed, 15 Apr 2015 11:34:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754134AbbDOJeX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Apr 2015 05:34:23 -0400
Received: from home.mewburn.net ([121.127.199.9]:40487 "EHLO home.mewburn.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753828AbbDOJeV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Apr 2015 05:34:21 -0400
Received: by home.mewburn.net (Postfix, from userid 1001)
	id DC8336159A; Wed, 15 Apr 2015 19:34:18 +1000 (AEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-12-10)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267193>


--rPgHZmYkQ+bUEpVC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Disable the display of the progress if stderr is not the
current foreground process.
Still display the final result when done.

Signed-off-by: Luke Mewburn <luke@mewburn.net>
Acked-by: Nicolas Pitre <nico@fluxnic.net>
---
 progress.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/progress.c b/progress.c
index 412e6b1..43d9228 100644
--- a/progress.c
+++ b/progress.c
@@ -72,6 +72,11 @@ static void clear_progress_signal(void)
 	progress_update =3D 0;
 }
=20
+static int is_foreground_fd(int fd)
+{
+	return getpgid(0) =3D=3D tcgetpgrp(fd);
+}
+
 static int display(struct progress *progress, unsigned n, const char *done)
 {
 	const char *eol, *tp;
@@ -98,16 +103,21 @@ static int display(struct progress *progress, unsigned=
 n, const char *done)
 		unsigned percent =3D n * 100 / progress->total;
 		if (percent !=3D progress->last_percent || progress_update) {
 			progress->last_percent =3D percent;
-			fprintf(stderr, "%s: %3u%% (%u/%u)%s%s",
-				progress->title, percent, n,
-				progress->total, tp, eol);
-			fflush(stderr);
+			if (is_foreground_fd(fileno(stderr)) || done) {
+				fprintf(stderr, "%s: %3u%% (%u/%u)%s%s",
+					progress->title, percent, n,
+					progress->total, tp, eol);
+				fflush(stderr);
+			}
 			progress_update =3D 0;
 			return 1;
 		}
 	} else if (progress_update) {
-		fprintf(stderr, "%s: %u%s%s", progress->title, n, tp, eol);
-		fflush(stderr);
+		if (is_foreground_fd(fileno(stderr)) || done) {
+			fprintf(stderr, "%s: %u%s%s",
+				progress->title, n, tp, eol);
+			fflush(stderr);
+		}
 		progress_update =3D 0;
 		return 1;
 	}
--=20
2.3.5.1.g63ef1a0


--rPgHZmYkQ+bUEpVC
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)

iEYEARECAAYFAlUuMJoACgkQpBhtmn8zJHLC1ACfUjktmSWGw2SaoBw68lAQChD4
B6sAoLoaOdOeyuhEvoE+/irrAKg+Tx2V
=Esoq
-----END PGP SIGNATURE-----

--rPgHZmYkQ+bUEpVC--
