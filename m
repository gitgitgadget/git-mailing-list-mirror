From: Grant Olson <kgo@grant-olson.net>
Subject: Re: PATCH:  Less fragile lookup of gpg key
Date: Sun, 02 May 2010 19:39:52 -0400
Message-ID: <4BDE0D48.9060109@grant-olson.net>
References: <4BDC45EB.8090305@grant-olson.net> <4BDC561B.4030307@gmail.com> <7vhbmr5ym4.fsf@alter.siamese.dyndns.org> <4BDC63FB.7060202@grant-olson.net> <7v7hnn4cun.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------enigD0AE0FB0DB91B1BACC764EAE"
Cc: gitzilla@gmail.com, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 03 01:43:03 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8ioM-0006Fw-UT
	for gcvg-git-2@lo.gmane.org; Mon, 03 May 2010 01:42:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752684Ab0EBXkU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 May 2010 19:40:20 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:44640 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752414Ab0EBXkR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 May 2010 19:40:17 -0400
Received: by vws19 with SMTP id 19so1340423vws.19
        for <git@vger.kernel.org>; Sun, 02 May 2010 16:40:16 -0700 (PDT)
Received: by 10.220.108.34 with SMTP id d34mr9679115vcp.130.1272843615934;
        Sun, 02 May 2010 16:40:15 -0700 (PDT)
Received: from [192.168.1.178] (pool-71-182-218-69.pitbpa.east.verizon.net [71.182.218.69])
        by mx.google.com with ESMTPS id z17sm20897805vco.17.2010.05.02.16.40.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 02 May 2010 16:40:15 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.9) Gecko/20100423 Thunderbird/3.0.4
In-Reply-To: <7v7hnn4cun.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146207>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD0AE0FB0DB91B1BACC764EAE
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 05/01/2010 03:54 PM, Junio C Hamano wrote:
> Grant Olson <kgo@grant-olson.net> writes:
>>
>> Unless I'm mis-understanding you, the does the opposite of that.  It
>> finds your gpg key based on your git email, ignoring your git name, so=

>> that different spellings of the name between gpg and git become irrele=
vant.
>=20
> If I have two keys like these:
>=20
>     Junio C Hamano <gitster@pobox.com>
>     Junio Hamano <gitster@pobox.com>
>=20
> and I have the latter set in .git/config to use for the project I am
> working on, your patch picks one at random, making the process less
> reliable.
>=20
> AFAIU, ALASCM's suggestion was to first try the current method (which
> reliably picks what I told git to use by specifying user.name), and onl=
y
> if that fails, i.e. if I do not have neither of the above two keys but
> only have a key named like e.g.
>=20
>     Git Panda <gitster@pobox.com>
>=20
> then use only the e-mail as you wanted to, but do so purely as a
> fallback.
>=20
> Which I found quite reasonable.

Fair enough.  This version of the patch will try to gpg sign by email
address only, if (and only if) you try to sign a tag without explicitly
providing a key id (-s) and the lookup by "user.name <user.email>" fails.=


=46rom 791a110dc4d362b2cd11b19ae25a86bf91710e34 Mon Sep 17 00:00:00 2001
From: Grant Olson <kgo@grant-olson.net>
Date: Sun, 2 May 2010 19:33:41 -0400
Subject: [PATCH] Lookup gpg key by email address if user+email lookup
fails with -s

---
 builtin/tag.c |   67
+++++++++++++++++++++++++++++++++++++++++++++------------
 cache.h       |    1 +
 ident.c       |    9 +++++++
 3 files changed, 63 insertions(+), 14 deletions(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index d311491..45dd43d 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -156,22 +156,13 @@ static int verify_tag(const char *name, const char
*ref,
 	return 0;
 }

-static int do_sign(struct strbuf *buffer)
+static int do_gpg(struct strbuf *buffer)
 {
+	/* retval can be standard -1 for error, 0 for ok, or 1 for a warning
+	 * so that we can attempt to recover by running gpg again. */
 	struct child_process gpg;
 	const char *args[4];
-	char *bracket;
 	int len;
-	int i, j;
-
-	if (!*signingkey) {
-		if (strlcpy(signingkey, git_committer_info(IDENT_ERROR_ON_NO_NAME),
-				sizeof(signingkey)) > sizeof(signingkey) - 1)
-			return error("committer info too long.");
-		bracket =3D strchr(signingkey, '>');
-		if (bracket)
-			bracket[1] =3D '\0';
-	}

 	/* When the username signingkey is bad, program could be terminated
 	 * because gpg exits without reading and then write gets SIGPIPE. */
@@ -199,8 +190,56 @@ static int do_sign(struct strbuf *buffer)
 	len =3D strbuf_read(buffer, gpg.out, 1024);
 	close(gpg.out);

-	if (finish_command(&gpg) || !len || len < 0)
-		return error("gpg failed to sign the tag");
+	if(finish_command(&gpg))
+		{
+			warning("gpg failed to sign the tag");
+			return 1;
+		}
+
+	return 0;
+}
+
+static int do_sign(struct strbuf *buffer)
+{
+	char *bracket;
+	int i, j;
+	int uid_for_key =3D 0;
+	int err_ok_warning;
+
+	if (!*signingkey) {
+		if (strlcpy(signingkey, git_committer_info(IDENT_ERROR_ON_NO_NAME),
+				sizeof(signingkey)) > sizeof(signingkey) - 1)
+			return error("committer info too long.");
+		bracket =3D strchr(signingkey, '>');
+		if (bracket)
+			bracket[1] =3D '\0';
+		uid_for_key =3D 1;
+	}
+
+	err_ok_warning =3D do_gpg(buffer);
+
+	if(!err_ok_warning || err_ok_warning !=3D 1)
+		return -1;
+
+	if (err_ok_warning =3D=3D 1 || !buffer->len || buffer->len < 0)
+	{
+		if (uid_for_key)
+		{
+			warning("couldn't find key for '%s'...", signingkey);
+			warning("Trying key lookup by email address only.");
+
+			if (strlcpy(signingkey, git_committer_email(),
+				sizeof(signingkey)) > sizeof(signingkey) - 1)
+					return error("committer info too long.");
+
+				err_ok_warning =3D do_gpg(buffer);
+
+			if (err_ok_warning || !buffer->len || buffer-> len < 0)
+				return error("gpg failed to sign the tag");
+		} else {
+			return error("gpg failed to sign the tag");
+		}
+	}

 	/* Strip CR from the line endings, in case we are on Windows. */
 	for (i =3D j =3D 0; i < buffer->len; i++)
diff --git a/cache.h b/cache.h
index 5eb0573..90a3067 100644
--- a/cache.h
+++ b/cache.h
@@ -789,6 +789,7 @@ enum date_mode parse_date_format(const char *format);=

 #define IDENT_NO_DATE	       4
 extern const char *git_author_info(int);
 extern const char *git_committer_info(int);
+extern const char *git_committer_email();
 extern const char *fmt_ident(const char *name, const char *email, const
char *date_str, int);
 extern const char *fmt_name(const char *name, const char *email);
 extern const char *git_editor(void);
diff --git a/ident.c b/ident.c
index 9e24388..0e8b78a 100644
--- a/ident.c
+++ b/ident.c
@@ -260,6 +260,15 @@ const char *git_committer_info(int flag)
 			 flag);
 }

+const char *git_committer_email(void)
+{
+	const char *email =3D getenv("GIT_COMMITTER_EMAIL");
+	if(!email)
+		email =3D git_default_email;
+
+	return email;
+}
+
 int user_ident_sufficiently_given(void)
 {
 #ifndef WINDOWS
--=20
1.7.0.4


--------------enigD0AE0FB0DB91B1BACC764EAE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iQEcBAEBCAAGBQJL3g1KAAoJEP5F5V2hilTW0VIH/j5RxpWFi9CRqYmcNKX5K7uL
uG2y4M+tRnTzi908oxRGmHWj78LYK4HC1CWoFIzknG/fxM2hwUOQRyOvdCzTDBcN
if3zafG4RwFPYyvYX+kG/3kZigbCdCmqZcAC48zqR1MRWkGTgHajVrPIhQh2CJ8c
uYApDrM+81YafJLAnstlindj+qHhACcPkioGiSN+pWR8kqkmlCxgObgzRoQrKwfP
K3C8tdz2Hw5vqG/MebT/rgFaooC5It9SqYOoIWkhwORSciIfCHMb6Tk+98vKhh8n
cYvp7K4NXyxwnnx55qWChJx/L3YGw8S7DTQtZb9umWQjV3Lv+I/rRBIqUDZ3Ddc=
=x/wG
-----END PGP SIGNATURE-----

--------------enigD0AE0FB0DB91B1BACC764EAE--
