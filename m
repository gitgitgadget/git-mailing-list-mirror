From: =?iso-8859-1?q?L=E9na=EFc_Huard?= <lenaic@lhuard.fr.eu.org>
Subject: [PATCH] Allow git to use any HTTP authentication method.
Date: Mon, 28 Dec 2009 11:54:06 +0100
Message-ID: <200912281154.09442.lenaic@lhuard.fr.eu.org>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_R5IOLTMEW+jNmZl"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 28 12:29:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPDmo-0005o3-MT
	for gcvg-git-2@lo.gmane.org; Mon, 28 Dec 2009 12:29:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751237AbZL1L3O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Dec 2009 06:29:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751214AbZL1L3O
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Dec 2009 06:29:14 -0500
Received: from freebox.lhuard.fr.eu.org ([88.182.161.122]:33568 "EHLO
	coruscant.lhuard.fr.eu.org" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751020AbZL1L3N (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Dec 2009 06:29:13 -0500
X-Greylist: delayed 2099 seconds by postgrey-1.27 at vger.kernel.org; Mon, 28 Dec 2009 06:29:13 EST
Received: from lenaic by coruscant.lhuard.fr.eu.org with local (Exim 4.71)
	(envelope-from <lenaic@lhuard.fr.eu.org>)
	id 1NPDEn-0008HV-Fc
	for git@vger.kernel.org; Mon, 28 Dec 2009 11:54:09 +0100
User-Agent: KMail/1.12.4 (Linux/2.6.32-trunk-amd64; KDE/4.3.4; x86_64; ; )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135735>

--Boundary-00=_R5IOLTMEW+jNmZl
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello,

As I need to access some of my git repositories behind a corporate company=
=20
firewall, I use the http access method. And, as I don't want my passwords t=
o be=20
sent in clear text over the network, I have configured my web server to use=
 =AB=20
Digest =BB authentication instead of the old =AB Basic =BB authentication.
This authentication method is now well handled by modern software.

Unfortunately, current git version only handles =AB Basic =BB authenticatio=
n.
When attempting to access my repository, I get the following error message:

error: The requested URL returned error: 401 while accessing=20
http://XXX@YYY.ZZ/test.git/info/refs

The web server, on its side, has refused the transaction because of the wro=
ng=20
authentication method used:

Digest: client used wrong authentication scheme `Basic': /test.git/info/refs

The attached patch makes git configure libcurl to negotiate the most suitab=
le=20
HTTP authentication method.
Thanks to that patch, I manage to clone and fetch my git repository hosted =
on=20
my web server requesting an authentication through the =AB Digest  =BB meth=
od.

L=E9na=EFc.

--Boundary-00=_R5IOLTMEW+jNmZl
Content-Type: text/x-patch;
  charset="ISO-8859-1";
  name="0001-Allow-git-to-use-any-HTTP-authentication-method.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0001-Allow-git-to-use-any-HTTP-authentication-method.patch"

=46rom 2acab3ae894c3ea835279a864e654e1c5e956e80 Mon Sep 17 00:00:00 2001
=46rom: =3D?UTF-8?q?L=3DC3=3DA9na=3DC3=3DAFc=3D20Huard?=3D <lenaic@lhuard.f=
r.eu.org>
Date: Mon, 28 Dec 2009 10:52:35 +0100
Subject: [PATCH] Allow git to use any HTTP authentication method.

By default, libcurl performs "Basic" HTTP authentication.
This method transmits passwords in clear text.
libcurl needs some settings in order to use a safest HTTP authentication
method like "Digest" for example.
=2D--
 http.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/http.c b/http.c
index ed6414a..2d9df76 100644
=2D-- a/http.c
+++ b/http.c
@@ -233,6 +233,10 @@ static CURL *get_curl_handle(void)
=20
 	init_curl_http_auth(result);
=20
+#if LIBCURL_VERSION_NUM >=3D 0x070a06
+	curl_easy_setopt(result, CURLOPT_HTTPAUTH, CURLAUTH_ANY);
+#endif
+
 	if (ssl_cert !=3D NULL)
 		curl_easy_setopt(result, CURLOPT_SSLCERT, ssl_cert);
 	if (has_cert_password())
=2D-=20
1.6.5.7


--Boundary-00=_R5IOLTMEW+jNmZl--
