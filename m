From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH v3 10/14] Improve the mingw getaddrinfo stub to handle more use cases
Date: Sun, 10 Oct 2010 15:20:50 +0200
Message-ID: <1286716854-5744-11-git-send-email-kusmabite@gmail.com>
References: <1286716854-5744-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: msysgit@googlegroups.com, j6t@kdbg.org,
	=?UTF-8?q?Martin=20Storsj=C3=B6?= <martin@martin.st>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 10 15:22:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4vra-00057R-02
	for gcvg-git-2@lo.gmane.org; Sun, 10 Oct 2010 15:22:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757731Ab0JJNWw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 Oct 2010 09:22:52 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:54307 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757674Ab0JJNWv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Oct 2010 09:22:51 -0400
Received: by mail-ew0-f46.google.com with SMTP id 20so255794ewy.19
        for <git@vger.kernel.org>; Sun, 10 Oct 2010 06:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=vtekDRpZJBIdHj6N0Kx3XXNMt/nqobmLQgpXo5gSqcs=;
        b=m4jHRzSao9gVSi2N8MhOxdfagCBMO84eOmGUPOwPLNRqq6e9ZfyaiOKsSp0zQwe9b1
         KIazUkrEwI2ahUvTjWJ4RiMBozCBvRzy2Hgk8Mc/ioQef9aAV9E0kwUsSncjv2O4XnaZ
         2INrg41djVdCTCQgZOPnvBvsfagfGn4BavTSs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=XIUn+K8TQ/q81KzdHTMOjt2VEks/SH+iAPIUedRIbdKaoOy/E6oqMSZCn4vE/nOOGI
         9hIyTIIcgXLVWDuRtaJWA5hFhTsd6MDhQ2NB/mUUAYVm6o0khxXb5FwZzJQx9W413E3E
         GYMlTEi4K3MMmUPCR8uqSxOzfFf258hGmitw8=
Received: by 10.213.76.16 with SMTP id a16mr1110452ebk.90.1286716970645;
        Sun, 10 Oct 2010 06:22:50 -0700 (PDT)
Received: from localhost (cm-84.215.188.225.getinternet.no [84.215.188.225])
        by mx.google.com with ESMTPS id v59sm9037766eeh.4.2010.10.10.06.22.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 10 Oct 2010 06:22:49 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.165.gdfe39.dirty
In-Reply-To: <1286716854-5744-1-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158669>

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
index 44ea419..32ca664 100644
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
1.7.3.1.51.ge462f.dirty
