From: Luke Mewburn <luke@mewburn.net>
Subject: [PATCH] reduce progress updates in background
Date: Mon, 13 Apr 2015 23:48:50 +1000
Message-ID: <20150413134850.GC23475@mewburn.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="d8Lz2Tf5e5STOWUP"
Cc: Nicolas Pitre <nico@fluxnic.net>, Luke Mewburn <luke@mewburn.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 13 15:54:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YheoS-0003Vz-3P
	for gcvg-git-2@plane.gmane.org; Mon, 13 Apr 2015 15:54:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932231AbbDMNyD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Apr 2015 09:54:03 -0400
Received: from home.mewburn.net ([121.127.199.9]:36115 "EHLO home.mewburn.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754108AbbDMNyB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Apr 2015 09:54:01 -0400
X-Greylist: delayed 308 seconds by postgrey-1.27 at vger.kernel.org; Mon, 13 Apr 2015 09:54:00 EDT
Received: by home.mewburn.net (Postfix, from userid 1001)
	id 53AEE61592; Mon, 13 Apr 2015 23:48:50 +1000 (AEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-12-10)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267079>


--d8Lz2Tf5e5STOWUP
Content-Type: multipart/mixed; boundary="OROCMA9jn6tkzFBc"
Content-Disposition: inline


--OROCMA9jn6tkzFBc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I've noticed that when a long-running git operation that generates
progress output is suspended and converted to a background process,
the terminal still gets spammed with progress updates (to stderr).

Many years ago I fixed a similar issue in the NetBSD ftp progress
bar code (which I wrote).

I've experimented around with a couple of different solutions, including:
1. suppress all progress output whilst in the background
2. suppress "in progress" updates whilst in the background,
   but display the "done" message even if in the background.

In both cases, warnings were still output to the terminal.

I've attached a patch that implements (2) above.

If the consensus is that all progress messages should be suppressed,
I can provide the (simpler) patch for that.

I've explicitly separated the in_progress_fd() function
so that it's easier to (a) reuse elsewhere where appropriate,
and (b) make any portability changes to the test if necessary.
I also used getpgid(0) versus getpgrp() to avoid portability
issues with the signature in the latter with pre-POSIX.

A minor optimisation could be to pass in struct progress *
and to cache getpgid(0) in a member of struct progress
in start_progress_delay(), since this value shouldn't change
during the life of the process.

regards,
Luke.

--OROCMA9jn6tkzFBc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="0001-progress-no-progress-in-background.patch"
Content-Transfer-Encoding: quoted-printable

=46rom 843a367bac87674666dafbaf7fdb7d6b0e1660f7 Mon Sep 17 00:00:00 2001
=46rom: Luke Mewburn <luke@mewburn.net>
Date: Mon, 13 Apr 2015 23:30:51 +1000
Subject: [PATCH] progress: no progress in background

Disable the display of the progress if stderr is not the
current foreground process.
Still display the final result when done.

Signed-off-by: Luke Mewburn <luke@mewburn.net>
---
 progress.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/progress.c b/progress.c
index 412e6b1..8094404 100644
--- a/progress.c
+++ b/progress.c
@@ -72,9 +72,15 @@ static void clear_progress_signal(void)
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
+	const int is_foreground =3D is_foreground_fd(fileno(stderr));
=20
 	if (progress->delay) {
 		if (!progress_update || --progress->delay)
@@ -98,16 +104,21 @@ static int display(struct progress *progress, unsigned=
 n, const char *done)
 		unsigned percent =3D n * 100 / progress->total;
 		if (percent !=3D progress->last_percent || progress_update) {
 			progress->last_percent =3D percent;
-			fprintf(stderr, "%s: %3u%% (%u/%u)%s%s",
-				progress->title, percent, n,
-				progress->total, tp, eol);
-			fflush(stderr);
+			if (is_foreground || done) {
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
+		if (is_foreground || done) {
+			fprintf(stderr, "%s: %u%s%s",
+				progress->title, n, tp, eol);
+			fflush(stderr);
+		}
 		progress_update =3D 0;
 		return 1;
 	}
--=20
2.3.5.dirty


--OROCMA9jn6tkzFBc--

--d8Lz2Tf5e5STOWUP
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)

iEYEARECAAYFAlUryUIACgkQpBhtmn8zJHL8rQCaAwzuxOGjNyKS8tgICp0JSEI7
PAEAoK28xPS43mg2mwZt2Uuj4w+kAL18
=xHfA
-----END PGP SIGNATURE-----

--d8Lz2Tf5e5STOWUP--
