From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH v6 10/16] Improve the mingw getaddrinfo stub to handle more use cases
Date: Wed,  3 Nov 2010 17:31:28 +0100
Message-ID: <1288801894-1168-11-git-send-email-kusmabite@gmail.com>
References: <1288801894-1168-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 03 17:33:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDgGU-0002aC-Eu
	for gcvg-git-2@lo.gmane.org; Wed, 03 Nov 2010 17:32:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932068Ab0KCQcL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Nov 2010 12:32:11 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:37501 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932067Ab0KCQcJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Nov 2010 12:32:09 -0400
Received: by mail-ew0-f46.google.com with SMTP id 7so391724ewy.19
        for <git@vger.kernel.org>; Wed, 03 Nov 2010 09:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=HoVmStYCc1lcmUrwigfcsyy3j4Xh3MUKQWp1L1PiqVs=;
        b=b33AHuYyBOApJ+qBLuQph0Dx8HadbFAxxFsyrK0HwTzpYnqY4/nGHVfJc1SMw1c/KN
         wY58MEPerfeY2pnUC4zsrUROcccHjL2G9H7WqehTLgJQrmiIbGvsVnwAa3iU1Ct24qvG
         VEvsCW6pj4wIhsfIlG2DSGajRRXdWe+mK3HcI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=uMHp7f3YtT555FEbhUbOYGVyRcnAlLsTKnzyB7k1XJqkCEEPduYnHXyki+muyr/H1u
         B0KaJLtmJKO3e37Mixoa/GHcu7lyaMjaV+rNgttfSHQinNfMaO4qrhFr97woBpVC7l1v
         y/BPh8tjYygUZl0jXe8Mewd2LheT7NEJN4SHY=
Received: by 10.213.9.79 with SMTP id k15mr4673597ebk.27.1288801928659;
        Wed, 03 Nov 2010 09:32:08 -0700 (PDT)
Received: from localhost ([77.40.159.131])
        by mx.google.com with ESMTPS id w20sm6705036eeh.0.2010.11.03.09.32.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 03 Nov 2010 09:32:07 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.3.msysgit.0.2.g22c0a
In-Reply-To: <1288801894-1168-1-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160623>

=46rom: Martin Storsj=C3=B6 <martin@martin.st>

Allow the node parameter to be null, which is used for getting
the default bind address.

Also allow the hints parameter to be null, to improve standard
conformance of the stub implementation a little.

Signed-off-by: Martin Storsjo <martin@martin.st>
---
 compat/mingw.c |   28 +++++++++++++++++++++-------
 1 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 21d1c2c..d88c0d0 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -1035,19 +1035,22 @@ static int WSAAPI getaddrinfo_stub(const char *=
node, const char *service,
 				   const struct addrinfo *hints,
 				   struct addrinfo **res)
 {
-	struct hostent *h =3D gethostbyname(node);
+	struct hostent *h =3D NULL;
 	struct addrinfo *ai;
 	struct sockaddr_in *sin;
=20
-	if (!h)
-		return WSAGetLastError();
+	if (node) {
+		h =3D gethostbyname(node);
+		if (!h)
+			return WSAGetLastError();
+	}
=20
 	ai =3D xmalloc(sizeof(struct addrinfo));
 	*res =3D ai;
 	ai->ai_flags =3D 0;
 	ai->ai_family =3D AF_INET;
-	ai->ai_socktype =3D hints->ai_socktype;
-	switch (hints->ai_socktype) {
+	ai->ai_socktype =3D hints ? hints->ai_socktype : 0;
+	switch (ai->ai_socktype) {
 	case SOCK_STREAM:
 		ai->ai_protocol =3D IPPROTO_TCP;
 		break;
@@ -1059,14 +1062,25 @@ static int WSAAPI getaddrinfo_stub(const char *=
node, const char *service,
 		break;
 	}
 	ai->ai_addrlen =3D sizeof(struct sockaddr_in);
-	ai->ai_canonname =3D strdup(h->h_name);
+	if (hints && (hints->ai_flags & AI_CANONNAME))
+		ai->ai_canonname =3D h ? strdup(h->h_name) : NULL;
+	else
+		ai->ai_canonname =3D NULL;
=20
 	sin =3D xmalloc(ai->ai_addrlen);
 	memset(sin, 0, ai->ai_addrlen);
 	sin->sin_family =3D AF_INET;
+	/* Note: getaddrinfo is supposed to allow service to be a string,
+	 * which should be looked up using getservbyname. This is
+	 * currently not implemented */
 	if (service)
 		sin->sin_port =3D htons(atoi(service));
-	sin->sin_addr =3D *(struct in_addr *)h->h_addr;
+	if (h)
+		sin->sin_addr =3D *(struct in_addr *)h->h_addr;
+	else if (hints && (hints->ai_flags & AI_PASSIVE))
+		sin->sin_addr.s_addr =3D INADDR_ANY;
+	else
+		sin->sin_addr.s_addr =3D INADDR_LOOPBACK;
 	ai->ai_addr =3D (struct sockaddr *)sin;
 	ai->ai_next =3D 0;
 	return 0;
--=20
1.7.3.2.161.gd6e00
