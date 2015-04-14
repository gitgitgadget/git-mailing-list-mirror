From: Luke Mewburn <luke@mewburn.net>
Subject: [PATCH v2] reduce progress updates in background
Date: Tue, 14 Apr 2015 21:03:13 +1000
Message-ID: <20150414110312.GE23475@mewburn.net>
References: <20150413134850.GC23475@mewburn.net>
 <alpine.LFD.2.11.1504130954420.5619@knanqh.ubzr>
 <20150413144039.GD23475@mewburn.net>
 <alpine.LFD.2.11.1504131052090.5619@knanqh.ubzr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XjbSsFHOHxvQpKib"
Cc: Luke Mewburn <luke@mewburn.net>
To: Nicolas Pitre <nico@fluxnic.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 14 13:03:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yhyci-0003dy-Gq
	for gcvg-git-2@plane.gmane.org; Tue, 14 Apr 2015 13:03:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753578AbbDNLDQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Apr 2015 07:03:16 -0400
Received: from home.mewburn.net ([121.127.199.9]:38158 "EHLO home.mewburn.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751912AbbDNLDP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Apr 2015 07:03:15 -0400
Received: by home.mewburn.net (Postfix, from userid 1001)
	id 148F2610C8; Tue, 14 Apr 2015 21:03:13 +1000 (AEST)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.11.1504131052090.5619@knanqh.ubzr>
User-Agent: Mutt/1.5.20 (2009-12-10)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267128>


--XjbSsFHOHxvQpKib
Content-Type: multipart/mixed; boundary="IJFRpmOek+ZRSQoz"
Content-Disposition: inline


--IJFRpmOek+ZRSQoz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Updated patch where is_foreground_fd() is only called in display()
just before the output is to be displayed.

--IJFRpmOek+ZRSQoz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="0001-progress-no-progress-in-background.patch"
Content-Transfer-Encoding: quoted-printable

=46rom d87997509fc631b8cdc7db63f289102d6ddfe933 Mon Sep 17 00:00:00 2001
=46rom: Luke Mewburn <luke@mewburn.net>
Date: Mon, 13 Apr 2015 23:30:51 +1000
Subject: [PATCH] progress: no progress in background

Disable the display of the progress if stderr is not the
current foreground process.
Still display the final result when done.

Signed-off-by: Luke Mewburn <luke@mewburn.net>
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
2.3.5.1.gd879975


--IJFRpmOek+ZRSQoz--

--XjbSsFHOHxvQpKib
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)

iEYEARECAAYFAlUs8/AACgkQpBhtmn8zJHLU0gCfZJSNBZpVkL031qTn3+K+JAFF
lH4AoLgCVxND/GxTEPwInqhpxX12nZdp
=SDjL
-----END PGP SIGNATURE-----

--XjbSsFHOHxvQpKib--
