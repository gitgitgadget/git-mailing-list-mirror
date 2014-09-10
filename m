From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 15/32] setup.c: convert is_git_directory() to use strbuf
Date: Thu, 11 Sep 2014 05:41:51 +0700
Message-ID: <1410388928-32265-16-git-send-email-pclouds@gmail.com>
References: <1409387642-24492-1-git-send-email-pclouds@gmail.com>
 <1410388928-32265-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 11 00:43:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XRqbo-0001n3-29
	for gcvg-git-2@plane.gmane.org; Thu, 11 Sep 2014 00:43:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753286AbaIJWnY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Sep 2014 18:43:24 -0400
Received: from mail-pd0-f182.google.com ([209.85.192.182]:65009 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753063AbaIJWnX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2014 18:43:23 -0400
Received: by mail-pd0-f182.google.com with SMTP id w10so7093579pde.27
        for <git@vger.kernel.org>; Wed, 10 Sep 2014 15:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=bfwhgknady5YKyiU7vhjIUJPDZL4fzbuUIuhgG5yMk4=;
        b=eCtETN/SyLVxdHeYriHIeosIkNLfhP0sLKDyQlHsl6jAMUKlVpcfyU5wHfWQbHCjl8
         uYsADdmTEAWlVGPgERKGVTqN/U+HDGUrSpQK+D6qFtzMW2qyTadN4Bsv+Qtc93fbzs3H
         pz2yJFuShRq7s5MlF3jJlhu8kcR4pdI8XIIRE7JUNN0ohKLMYHOLxk7WdE5vJ48nwb4J
         c2mEvHEMv0MhrX0gSG7emTjxBBN/8MRTjUsFg4VBm6nh/fnMfQuc+I1NydaYeds76Mrw
         Qh/k2DC10bqwCfAD0mWfUzhM1M3CDiZ54ebEzmKLPlItTYaUocsxhjkmrGHlA9egtSLf
         aaYw==
X-Received: by 10.69.20.11 with SMTP id gy11mr41587275pbd.5.1410389003056;
        Wed, 10 Sep 2014 15:43:23 -0700 (PDT)
Received: from lanh ([115.73.197.210])
        by mx.google.com with ESMTPSA id sf1sm15459147pbb.0.2014.09.10.15.43.20
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Sep 2014 15:43:22 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Thu, 11 Sep 2014 05:43:42 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1410388928-32265-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256792>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 setup.c | 37 +++++++++++++++++++++----------------
 1 file changed, 21 insertions(+), 16 deletions(-)

diff --git a/setup.c b/setup.c
index 0a22f8b..425fd79 100644
--- a/setup.c
+++ b/setup.c
@@ -238,31 +238,36 @@ void verify_non_filename(const char *prefix, cons=
t char *arg)
  */
 int is_git_directory(const char *suspect)
 {
-	char path[PATH_MAX];
-	size_t len =3D strlen(suspect);
+	struct strbuf path =3D STRBUF_INIT;
+	int ret =3D 0;
+	size_t len;
=20
-	if (PATH_MAX <=3D len + strlen("/objects"))
-		die("Too long path: %.*s", 60, suspect);
-	strcpy(path, suspect);
+	strbuf_addstr(&path, suspect);
+	len =3D path.len;
 	if (getenv(DB_ENVIRONMENT)) {
 		if (access(getenv(DB_ENVIRONMENT), X_OK))
-			return 0;
+			goto done;
 	}
 	else {
-		strcpy(path + len, "/objects");
-		if (access(path, X_OK))
-			return 0;
+		strbuf_addstr(&path, "/objects");
+		if (access(path.buf, X_OK))
+			goto done;
 	}
=20
-	strcpy(path + len, "/refs");
-	if (access(path, X_OK))
-		return 0;
+	strbuf_setlen(&path, len);
+	strbuf_addstr(&path, "/refs");
+	if (access(path.buf, X_OK))
+		goto done;
=20
-	strcpy(path + len, "/HEAD");
-	if (validate_headref(path))
-		return 0;
+	strbuf_setlen(&path, len);
+	strbuf_addstr(&path, "/HEAD");
+	if (validate_headref(path.buf))
+		goto done;
=20
-	return 1;
+	ret =3D 1;
+done:
+	strbuf_release(&path);
+	return ret;
 }
=20
 int is_inside_git_dir(void)
--=20
2.1.0.rc0.78.gc0d8480
