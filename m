From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 14/27] setup.c: convert is_git_directory() to use strbuf
Date: Sat,  1 Mar 2014 19:12:50 +0700
Message-ID: <1393675983-3232-15-git-send-email-pclouds@gmail.com>
References: <1392730814-19656-1-git-send-email-pclouds@gmail.com>
 <1393675983-3232-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 01 13:22:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJivu-0002EO-0J
	for gcvg-git-2@plane.gmane.org; Sat, 01 Mar 2014 13:22:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752831AbaCAMWR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 1 Mar 2014 07:22:17 -0500
Received: from mail-pd0-f181.google.com ([209.85.192.181]:64511 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752429AbaCAMWP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2014 07:22:15 -0500
Received: by mail-pd0-f181.google.com with SMTP id p10so1860403pdj.12
        for <git@vger.kernel.org>; Sat, 01 Mar 2014 04:22:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=RNEpKk9s8TgZ+gPo1A1zivDKaSQ4z7YQ+Rz+qaJTMnU=;
        b=kyg1OLq2PsS58zfWAN0/5ce6SHyOB0VtN5Ln5MOINQepuCPRzxeyuVQjt+BP9wn4fz
         9pSviHNd3UAo+BCfLKXnDZGVNYNXBZDmVYbaFVF9HxmXnt3SS/LtI3da1N1bembjkPFK
         8hBQ/0hBpRrgWZ4BQzrTad2xh4d8Tqa5AKveEn+2t30tp+XPfbznaZx0YhnpNekiu6A6
         sMnNieBEgTTrIVQ8SNcsrsflEByGwMKOiHwvbw6Dgx3t4qYdTMMIwopOLr6ZyddQE4B3
         FdfvKHjpPeAP8VFKD3XXA5jNjzZ2hDGssu4X0feN6WZSy2tILMqejdjsQx6A+wxr0Xb5
         t9iw==
X-Received: by 10.68.164.229 with SMTP id yt5mr9340448pbb.28.1393676535429;
        Sat, 01 Mar 2014 04:22:15 -0800 (PST)
Received: from lanh ([115.73.238.45])
        by mx.google.com with ESMTPSA id ce15sm37218546pac.0.2014.03.01.04.22.12
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 01 Mar 2014 04:22:14 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 01 Mar 2014 19:22:40 +0700
X-Mailer: git-send-email 1.9.0.40.gaa8c3ea
In-Reply-To: <1393675983-3232-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243079>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 setup.c | 37 +++++++++++++++++++++----------------
 1 file changed, 21 insertions(+), 16 deletions(-)

diff --git a/setup.c b/setup.c
index 6c3f85f..4994437 100644
--- a/setup.c
+++ b/setup.c
@@ -184,31 +184,36 @@ void verify_non_filename(const char *prefix, cons=
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
1.9.0.40.gaa8c3ea
