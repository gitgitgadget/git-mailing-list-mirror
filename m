From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH v7 10/16] Improve the mingw getaddrinfo stub to handle more use cases
Date: Thu,  4 Nov 2010 02:35:18 +0100
Message-ID: <1288834524-2400-11-git-send-email-kusmabite@gmail.com>
References: <1288834524-2400-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 04 02:36:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDokt-0001ds-HE
	for gcvg-git-2@lo.gmane.org; Thu, 04 Nov 2010 02:36:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754219Ab0KDBfz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Nov 2010 21:35:55 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:56990 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754455Ab0KDBfs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Nov 2010 21:35:48 -0400
Received: by mail-ey0-f174.google.com with SMTP id 27so722316eye.19
        for <git@vger.kernel.org>; Wed, 03 Nov 2010 18:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=jGhrENrbb70jeujjPWhMOEek50mjED12Cy/r+MGPTME=;
        b=pp9cXbczGd2ac6Xaw1K21vz4Js7/balKKR0s1XL5anbckahfxlknWyjMj2hAfUb8w9
         cUMvvoX1q/FeHEwBSr9p9s0IxV9S3KL5TasdZ8kyM+mDoCRzVaLj47/i45okiFip6e5M
         Q3vpYXoOYjfhFjQGD5yvUvqBoak4GyMSzEgiE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=aO+JBS2EOiWQ0Wot8qOVe0EkhkS7fA2zamEHZxPcwa1mt60C2Rk+Z6oP6aQ1YpUVoE
         yeA8PR5dmXGX48eakYuJEKPtwkr9vk8oeE4CISGWYkZ5mGWw6rbrOlYO65mADILrboUj
         FwWqbfmTcoyPB6A6Rb7FS4sSVIkbt4oyIRoio=
Received: by 10.213.35.204 with SMTP id q12mr142197ebd.53.1288834547878;
        Wed, 03 Nov 2010 18:35:47 -0700 (PDT)
Received: from localhost (cm-84.215.188.225.getinternet.no [84.215.188.225])
        by mx.google.com with ESMTPS id x54sm7206776eeh.23.2010.11.03.18.35.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 03 Nov 2010 18:35:47 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.165.gdfe39.dirty
In-Reply-To: <1288834524-2400-1-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160672>

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
index 146a6ed..a6c1ee7 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -1039,19 +1039,22 @@ static int WSAAPI getaddrinfo_stub(const char *=
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
@@ -1063,14 +1066,25 @@ static int WSAAPI getaddrinfo_stub(const char *=
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
1.7.3.2.162.g09d37
