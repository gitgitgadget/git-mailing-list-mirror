From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 3/8] mv: flatten error handling code block
Date: Fri,  8 Aug 2014 20:10:57 +0700
Message-ID: <1407503462-32632-4-git-send-email-pclouds@gmail.com>
References: <1407503462-32632-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 08 15:11:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XFjxA-0000gV-UW
	for gcvg-git-2@plane.gmane.org; Fri, 08 Aug 2014 15:11:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756683AbaHHNLY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Aug 2014 09:11:24 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:50393 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756251AbaHHNLX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2014 09:11:23 -0400
Received: by mail-pa0-f50.google.com with SMTP id et14so7289527pad.9
        for <git@vger.kernel.org>; Fri, 08 Aug 2014 06:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=oUABVW529SbHecUghJ43z7W7vWNc2/r7b77onmUmY3M=;
        b=IBRHyMEFFsE7ipSGtoFs2QGGPVSPxWIuRSPyQ5djXpyCj1AnFJDRlCeHJi/oVM9dZ9
         yXiwHp98U+qqOcAcqoOvW03wAcDjY5fMOZmls3779N4LIw/xouMIoWcLn0XF83WdjUcV
         QzigOvCuheSekKcQ3RK4B4aH2L3orRJqnDqtgSpVYuyXYStwp+gYwdK1Yo/qjoLSUYmn
         5y3e1tpKQzD7pc8x1dzGtAFkRb/arAcjFeV1pjVeAOxPBoelZYjauYxz2ZG/S5C6Nkc7
         T7isFVihR0u3UONqrf8aUHoNLUUQthw5hIcf0aapKyrtbnkwohJtxDkaFZY/LEvLFkS2
         FFnA==
X-Received: by 10.70.140.198 with SMTP id ri6mr1518609pdb.158.1407503483064;
        Fri, 08 Aug 2014 06:11:23 -0700 (PDT)
Received: from lanh ([115.73.206.39])
        by mx.google.com with ESMTPSA id pz10sm2998841pbb.33.2014.08.08.06.11.20
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Aug 2014 06:11:22 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Fri, 08 Aug 2014 20:11:26 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1407503462-32632-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255009>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/mv.c | 35 +++++++++++++++++------------------
 1 file changed, 17 insertions(+), 18 deletions(-)

diff --git a/builtin/mv.c b/builtin/mv.c
index a7e02c0..5c6f58f 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -58,6 +58,11 @@ static const char *add_slash(const char *path)
 	return path;
 }
=20
+static void move_up_one(void *p, int nmemb, int size)
+{
+	memmove(p, (char*)p + size, nmemb * size);
+}
+
 static struct lock_file lock_file;
 #define SUBMODULE_WITH_GITDIR ((const char *)1)
=20
@@ -224,24 +229,18 @@ int cmd_mv(int argc, const char **argv, const cha=
r *prefix)
 		else
 			string_list_insert(&src_for_dst, dst);
=20
-		if (bad) {
-			if (ignore_errors) {
-				if (--argc > 0) {
-					memmove(source + i, source + i + 1,
-						(argc - i) * sizeof(char *));
-					memmove(destination + i,
-						destination + i + 1,
-						(argc - i) * sizeof(char *));
-					memmove(modes + i, modes + i + 1,
-						(argc - i) * sizeof(enum update_mode));
-					memmove(submodule_gitfile + i,
-						submodule_gitfile + i + 1,
-						(argc - i) * sizeof(char *));
-					i--;
-				}
-			} else
-				die (_("%s, source=3D%s, destination=3D%s"),
-				     bad, src, dst);
+		if (!bad)
+			continue;
+		if (!ignore_errors)
+			die (_("%s, source=3D%s, destination=3D%s"),
+			     bad, src, dst);
+		if (--argc > 0) {
+			int n =3D argc - i;
+			move_up_one(source + i, n, sizeof(*source));
+			move_up_one(destination + i, n, sizeof(*destination));
+			move_up_one(modes + i, n, sizeof(*modes));
+			move_up_one(submodule_gitfile + i, n, sizeof(*submodule_gitfile));
+			i--;
 		}
 	}
=20
--=20
2.1.0.rc0.78.gc0d8480
