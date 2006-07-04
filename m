From: Keith Packard <keithp@keithp.com>
Subject: Re: git-fetch per-repository speed issues
Date: Mon, 03 Jul 2006 21:30:41 -0700
Message-ID: <1151987441.4723.110.camel@neko.keithp.com>
References: <1151949764.4723.51.camel@neko.keithp.com>
	 <Pine.LNX.4.64.0607031603290.12404@g5.osdl.org>
	 <1151973438.4723.70.camel@neko.keithp.com>
	 <Pine.LNX.4.64.0607032008590.12404@g5.osdl.org>
	 <7vsllinj1m.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.64.0607032039010.12404@g5.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-E/fzj+r6mCelXAF8nC2z"
Cc: keithp@keithp.com, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 04 06:31:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FxcYt-0007rB-OZ
	for gcvg-git@gmane.org; Tue, 04 Jul 2006 06:31:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750942AbWGDEaq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Jul 2006 00:30:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750861AbWGDEap
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Jul 2006 00:30:45 -0400
Received: from home.keithp.com ([63.227.221.253]:7428 "EHLO keithp.com")
	by vger.kernel.org with ESMTP id S1750830AbWGDEap (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Jul 2006 00:30:45 -0400
Received: from localhost (localhost [127.0.0.1])
	by keithp.com (Postfix) with ESMTP id 6DE8F13001F;
	Mon,  3 Jul 2006 21:30:44 -0700 (PDT)
Received: from keithp.com ([127.0.0.1])
	by localhost (keithp.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id RG4RvcI4IsFN; Mon,  3 Jul 2006 21:30:44 -0700 (PDT)
Received: by keithp.com (Postfix, from userid 1033)
	id 05B3C13001E; Mon,  3 Jul 2006 21:30:43 -0700 (PDT)
Received: from neko.keithp.com (localhost [127.0.0.1])
	by keithp.com (Postfix) with ESMTP id EC75B14001;
	Mon,  3 Jul 2006 21:30:43 -0700 (PDT)
Received: by neko.keithp.com (Postfix, from userid 1488)
	id 1A9FC6AC24A; Mon,  3 Jul 2006 21:30:42 -0700 (PDT)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0607032039010.12404@g5.osdl.org>
X-Mailer: Evolution 2.6.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23248>


--=-E/fzj+r6mCelXAF8nC2z
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2006-07-03 at 20:40 -0700, Linus Torvalds wrote:

>     "And, it's painfully slow, even when the repository is up to date"
>=20
> and gave a 17-second time.

It's faster this evening, down to 8 seconds using ssh and 4 seconds
using git. I clearly need to force use of the git protocol. Anyone else
like the attached patch?

---
 connect.c |   18 ++++++++++++++----
 1 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/connect.c b/connect.c
index 9a87bd9..e74eddc 100644
--- a/connect.c
+++ b/connect.c
@@ -303,6 +303,7 @@ enum protocol {
 	PROTO_LOCAL =3D 1,
 	PROTO_SSH,
 	PROTO_GIT,
+	PROTO_GIT_SSH,
 };
=20
 static enum protocol get_protocol(const char *name)
@@ -312,9 +313,9 @@ static enum protocol get_protocol(const=20
 	if (!strcmp(name, "git"))
 		return PROTO_GIT;
 	if (!strcmp(name, "git+ssh"))
-		return PROTO_SSH;
+		return PROTO_GIT_SSH;
 	if (!strcmp(name, "ssh+git"))
-		return PROTO_SSH;
+		return PROTO_GIT_SSH;
 	die("I don't handle protocol '%s'", name);
 }
=20
@@ -572,6 +573,14 @@ static void git_proxy_connect(int fd[2],
 	close(pipefd[1][0]);
 }
=20
+/* returns whether the specified command can be interpreted by the
daemon */
+int git_is_daemon_command (const char *prog)=20
+{
+	if (!strcmp("git-upload-pack", prog))
+		return 1;
+	return 0;
+}
+
 /*
  * Yeah, yeah, fixme. Need to pass in the heads etc.
  */
@@ -641,7 +650,8 @@ int git_connect(int fd[2], char *url, co
 		*ptr =3D '\0';
 	}
=20
-	if (protocol =3D=3D PROTO_GIT) {
+	if (protocol =3D=3D PROTO_GIT ||=20
+	    (protocol =3D=3D PROTO_GIT_SSH && git_is_daemon_command (prog))) {
 		/* These underlying connection commands die() if they
 		 * cannot connect.
 		 */
@@ -678,7 +688,7 @@ int git_connect(int fd[2], char *url, co
 		close(pipefd[0][1]);
 		close(pipefd[1][0]);
 		close(pipefd[1][1]);
-		if (protocol =3D=3D PROTO_SSH) {
+		if (protocol =3D=3D PROTO_SSH || protocol =3D=3D PROTO_GIT_SSH) {
 			const char *ssh, *ssh_basename;
 			ssh =3D getenv("GIT_SSH");
 			if (!ssh) ssh =3D "ssh";
--=20
1.4.1.g8fced-dirty

--=20
keith.packard@intel.com

--=-E/fzj+r6mCelXAF8nC2z
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBEqe7xQp8BWwlsTdMRAhYmAKCEPBJr1GVtX4A97kL2tMldDT1W+wCffUyE
zQ1D49nOhFcS90i/kJXLTEY=
=a+dM
-----END PGP SIGNATURE-----

--=-E/fzj+r6mCelXAF8nC2z--
