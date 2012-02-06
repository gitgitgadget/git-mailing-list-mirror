From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/6] csum-file: make sha1 calculation optional
Date: Mon,  6 Feb 2012 12:48:35 +0700
Message-ID: <1328507319-24687-2-git-send-email-pclouds@gmail.com>
References: <1328507319-24687-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@inf.ethz.ch>,
	Joshua Redstone <joshua.redstone@fb.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 06 06:44:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuHN4-0002mM-Gf
	for gcvg-git-2@plane.gmane.org; Mon, 06 Feb 2012 06:44:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750977Ab2BFFoF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Feb 2012 00:44:05 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:39009 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750916Ab2BFFoE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Feb 2012 00:44:04 -0500
Received: by pbdu11 with SMTP id u11so4687056pbd.19
        for <git@vger.kernel.org>; Sun, 05 Feb 2012 21:44:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=EveRb0HzMUQoR0cG2THNmCJDUI1NlCK32bLf3ykTgHE=;
        b=R3gfQWoXrSUeaPTkbiwbjlHZI3bSEhZbW0lDuPj2jcWMaqUaHfxVsqtROWON99xlSA
         4yjZvfN9MlvhIexXx3KKjykdsMZHIiu5mja+ocbhtmgOkunUe9QUx+ImtQqTsP2dLoBm
         pE8Lnn7dCqqhmYXb0EcUwt065PKAQRgK/0sV8=
Received: by 10.68.226.98 with SMTP id rr2mr44200788pbc.115.1328507043139;
        Sun, 05 Feb 2012 21:44:03 -0800 (PST)
Received: from tre ([115.74.57.120])
        by mx.google.com with ESMTPS id j4sm36750865pbg.12.2012.02.05.21.43.59
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 05 Feb 2012 21:44:02 -0800 (PST)
Received: by tre (sSMTP sendmail emulation); Mon, 06 Feb 2012 12:48:49 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <1328507319-24687-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190017>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 csum-file.c |   16 +++++++++++++---
 csum-file.h |    2 +-
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/csum-file.c b/csum-file.c
index 53f5375..4c517d1 100644
--- a/csum-file.c
+++ b/csum-file.c
@@ -11,6 +11,12 @@
 #include "progress.h"
 #include "csum-file.h"
=20
+static void sha1update(struct sha1file *f, const void *data, unsigned =
offset)
+{
+	if (f->do_sha1)
+		git_SHA1_Update(&f->ctx, data, offset);
+}
+
 static void flush(struct sha1file *f, void *buf, unsigned int count)
 {
 	if (0 <=3D f->check_fd && count)  {
@@ -47,7 +53,7 @@ void sha1flush(struct sha1file *f)
 	unsigned offset =3D f->offset;
=20
 	if (offset) {
-		git_SHA1_Update(&f->ctx, f->buffer, offset);
+		sha1update(f, f->buffer, offset);
 		flush(f, f->buffer, offset);
 		f->offset =3D 0;
 	}
@@ -58,7 +64,10 @@ int sha1close(struct sha1file *f, unsigned char *res=
ult, unsigned int flags)
 	int fd;
=20
 	sha1flush(f);
-	git_SHA1_Final(f->buffer, &f->ctx);
+	if (f->do_sha1)
+		git_SHA1_Final(f->buffer, &f->ctx);
+	else
+		hashclr(f->buffer);
 	if (result)
 		hashcpy(result, f->buffer);
 	if (flags & (CSUM_CLOSE | CSUM_FSYNC)) {
@@ -110,7 +119,7 @@ int sha1write(struct sha1file *f, void *buf, unsign=
ed int count)
 		buf =3D (char *) buf + nr;
 		left -=3D nr;
 		if (!left) {
-			git_SHA1_Update(&f->ctx, data, offset);
+			sha1update(f, data, offset);
 			flush(f, data, offset);
 			offset =3D 0;
 		}
@@ -154,6 +163,7 @@ struct sha1file *sha1fd_throughput(int fd, const ch=
ar *name, struct progress *tp
 	f->tp =3D tp;
 	f->name =3D name;
 	f->do_crc =3D 0;
+	f->do_sha1 =3D 1;
 	git_SHA1_Init(&f->ctx);
 	return f;
 }
diff --git a/csum-file.h b/csum-file.h
index 3b540bd..c23ea62 100644
--- a/csum-file.h
+++ b/csum-file.h
@@ -12,7 +12,7 @@ struct sha1file {
 	off_t total;
 	struct progress *tp;
 	const char *name;
-	int do_crc;
+	int do_crc, do_sha1;
 	uint32_t crc32;
 	unsigned char buffer[8192];
 };
--=20
1.7.8.36.g69ee2
