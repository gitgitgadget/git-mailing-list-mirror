From: Martin Sivak <mars@nomi.cz>
Subject: [PATCH] GIT_SSH alternate ssh name or helper
Date: Wed, 3 Aug 2005 17:15:42 +0200
Message-ID: <20050803151542.GA6655@medusa>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PNTmBPCT7hxwcZjr"
X-From: git-owner@vger.kernel.org Wed Aug 03 17:15:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E0Kve-0003HP-Km
	for gcvg-git@gmane.org; Wed, 03 Aug 2005 17:13:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262311AbVHCPNA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 Aug 2005 11:13:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262295AbVHCPNA
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Aug 2005 11:13:00 -0400
Received: from r72s12p17.home.nbox.cz ([83.240.5.75]:10881 "EHLO
	r72s12p17.home.nbox.cz") by vger.kernel.org with ESMTP
	id S262320AbVHCPMz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2005 11:12:55 -0400
Received: by r72s12p17.home.nbox.cz (Postfix, from userid 1000)
	id D5E8FAC687; Wed,  3 Aug 2005 17:15:42 +0200 (CEST)
To: git@vger.kernel.org
Content-Disposition: inline
X-Operating-System: Linux medusa 2.6.11.8
X-PGP-Key: http://montik.net/mars.asc
User-Agent: Mutt/1.5.8i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This patch make possible to use alternate ssh binary or ssh helper
script. The script can be used to give additional parameters to ssh
binary (like private key, protocol version, ...).

Example script could look like this:

#!/bin/sh
ssh -1 -i myprivatekey.key "$@"

The patch itself is realy very simple:

diff -uNr git-current/connect.c git-current-mars@nomi.cz/connect.c
--- git-current/connect.c  2005-08-03 15:00:04.000000000 +0200
+++ git-current-mars@nomi.cz/connect.c 2005-08-03 16:32:36.000000000 +0200
@@ -166,6 +166,9 @@
   int pipefd[2][2];
   pid_t pid;
   enum protocol protocol;
+  char *sshprog;
+
+  sshprog =3D getenv("GIT_SSH") ? : "ssh";

   host =3D NULL;
   path =3D url;
@@ -205,7 +208,7 @@
      close(pipefd[1][0]);
      close(pipefd[1][1]);
      if (protocol =3D=3D PROTO_SSH)
-        execlp("ssh", "ssh", host, command, NULL);
+        execlp(sshprog, "ssh", host, command, NULL);
      else
         execlp("sh", "sh", "-c", command, NULL);
      die("exec failed");
diff -uNr git-current/rsh.c git-current-mars@nomi.cz/rsh.c
--- git-current/rsh.c   2005-08-03 15:00:04.000000000 +0200
+++ git-current-mars@nomi.cz/rsh.c  2005-08-03 16:26:39.000000000 +0200
@@ -17,6 +17,7 @@
   char command[COMMAND_SIZE];
   char *posn;
   int i;
+  char *prog;=20

   if (!strcmp(url, "-")) {
      *fd_in =3D 0;
@@ -24,6 +25,8 @@
      return 0;
   }

+  prog =3D getenv("GIT_SSH") ? : "ssh";
+ =20
   host =3D strstr(url, "//");
   if (host) {
      host +=3D 2;
@@ -59,7 +62,7 @@
      close(sv[1]);
      dup2(sv[0], 0);
      dup2(sv[0], 1);
-     execlp("ssh", "ssh", host, command, NULL);
+     execlp(prog, "ssh", host, command, NULL);
   }
   close(sv[0]);
   *fd_in =3D sv[1];


Signed-off-by: Martin Sivak <mars@nomi.cz>

--=20
Martin Sivak
mars@nomi.cz


--PNTmBPCT7hxwcZjr
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFC8N+eLtuY88yhq1wRAj7eAJ9gr5Z3S6U9Vt9AkK/25XhEOKv5MgCdHN+g
wgyTO3fY/Hl+uGoUsFVR9d0=
=mAlZ
-----END PGP SIGNATURE-----

--PNTmBPCT7hxwcZjr--
