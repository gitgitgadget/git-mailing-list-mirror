From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH v4 10/15] Improve the mingw getaddrinfo stub to handle more use cases
Date: Mon, 11 Oct 2010 23:50:24 +0200
Message-ID: <1286833829-5116-11-git-send-email-kusmabite@gmail.com>
References: <1286833829-5116-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: msysgit@googlegroups.com, j6t@kdbg.org, avarab@gmail.com,
	sunshine@sunshineco.com,
	=?UTF-8?q?Martin=20Storsj=C3=B6?= <martin@martin.st>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 11 23:52:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5QIR-0006c0-Ok
	for gcvg-git-2@lo.gmane.org; Mon, 11 Oct 2010 23:52:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756624Ab0JKVwd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 Oct 2010 17:52:33 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:36668 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756565Ab0JKVwd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Oct 2010 17:52:33 -0400
Received: by mail-ew0-f46.google.com with SMTP id 20so833577ewy.19
        for <git@vger.kernel.org>; Mon, 11 Oct 2010 14:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=AGa45tl2UrB+iH3YIC9cF+TxylosH2/BdjLAuH0g00A=;
        b=pKVqGu6R5pz18hWAv9ppESdCud+MhFxQGyeY4nt5j1Qv2C8hRotbo5Fcx38bSSnvSA
         vIbAEU/DM39zLlO13zd1zm5fczG9Zd7ZpzU1IbjikxDyfzKof5dO228OjEOCQLctPfde
         NT+U9MjdZb0Ssb7XT+EioUiBVN+Uks4DHiZ2o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=EATW4Hd+1Lb6pF7zYvt8FalZn4zZ35IfGzLfhwXns2HAmUAQEYne5EmwpXC7EV3vGk
         bkI6v31kfbBgRbfuKyzEPaIMfOYmdj0/uNe1K8wAXPHogtrhdO8jqi5ahund3du9E48k
         d8/Yh2lG8xQoyBtn6NlwJXbI/2tvB7UmgQiTo=
Received: by 10.213.13.2 with SMTP id z2mr3521697ebz.96.1286833952113;
        Mon, 11 Oct 2010 14:52:32 -0700 (PDT)
Received: from localhost (cm-84.215.188.225.getinternet.no [84.215.188.225])
        by mx.google.com with ESMTPS id v59sm11651096eeh.16.2010.10.11.14.52.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 11 Oct 2010 14:52:31 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.165.gdfe39.dirty
In-Reply-To: <1286833829-5116-1-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158802>

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
1.7.3.1.199.g72340
