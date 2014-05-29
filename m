From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/4] wrapper.c: introduce gentle xmallocz that does not die()
Date: Thu, 29 May 2014 19:57:04 +0700
Message-ID: <1401368227-14469-1-git-send-email-pclouds@gmail.com>
References: <CACsJy8BM1f1pJPzGPf--a-kUim6wyX+Mr1AfMupY3mpREY+8DA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: worley@alum.mit.edu, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 29 14:49:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpzmC-0003ti-5d
	for gcvg-git-2@plane.gmane.org; Thu, 29 May 2014 14:49:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757344AbaE2Mtk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 29 May 2014 08:49:40 -0400
Received: from mail-wi0-f173.google.com ([209.85.212.173]:35840 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757323AbaE2Mtj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 May 2014 08:49:39 -0400
Received: by mail-wi0-f173.google.com with SMTP id bs8so5485709wib.6
        for <git@vger.kernel.org>; Thu, 29 May 2014 05:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=cWUOVcLNq/N5MsQP/0D6D4rHROH8NBAnix0fMISLdkA=;
        b=aXj1NSewaDruMcNHJ2e57sozjwBJnNoT7e69hK2xZQBBJmIzLCWokEuiwyizStRaSd
         /3UFYY2TL5wTlTqzLk7Cq9cmLqHY9Lm5CuD6fJGjSQ+zCKiMZAxY+L11D/QJVNTxKPN2
         OA2RpzH5+jfPO7UFKLJsnVDhVeM5ScUERlTOFYAfJCfkBTE3476VGo4OZgHu7xBOODKg
         bVyRxp544y48Asg1teerDg6PQbsdghKWwtNCs+yjgyujvn4+EmJ67THdN5/CoUcYlANf
         tc+6QRxHbLgAbnKTKxnADTIzDcgf44UTFA5VKMDIDIPWPZKQhf23FxNruNtCPtgGhxAb
         zKIw==
X-Received: by 10.180.212.48 with SMTP id nh16mr59722206wic.49.1401367775737;
        Thu, 29 May 2014 05:49:35 -0700 (PDT)
Received: from lanh ([115.73.231.189])
        by mx.google.com with ESMTPSA id ho2sm2640494wib.15.2014.05.29.05.49.31
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 May 2014 05:49:34 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Thu, 29 May 2014 19:57:16 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <CACsJy8BM1f1pJPzGPf--a-kUim6wyX+Mr1AfMupY3mpREY+8DA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250366>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 git-compat-util.h |  1 +
 wrapper.c         | 68 ++++++++++++++++++++++++++++++++++++++++++-----=
--------
 2 files changed, 53 insertions(+), 16 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index f6d3a46..f23e4e4 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -524,6 +524,7 @@ extern try_to_free_t set_try_to_free_routine(try_to=
_free_t);
 extern char *xstrdup(const char *str);
 extern void *xmalloc(size_t size);
 extern void *xmallocz(size_t size);
+extern void *xmallocz_gentle(size_t size);
 extern void *xmemdupz(const void *data, size_t len);
 extern char *xstrndup(const char *str, size_t len);
 extern void *xrealloc(void *ptr, size_t size);
diff --git a/wrapper.c b/wrapper.c
index 0cc5636..7ab9a98 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -9,16 +9,23 @@ static void do_nothing(size_t size)
=20
 static void (*try_to_free_routine)(size_t size) =3D do_nothing;
=20
-static void memory_limit_check(size_t size)
+static int memory_limit_check(size_t size, int gentle)
 {
 	static int limit =3D -1;
 	if (limit =3D=3D -1) {
 		const char *env =3D getenv("GIT_ALLOC_LIMIT");
 		limit =3D env ? atoi(env) * 1024 : 0;
 	}
-	if (limit && size > limit)
-		die("attempting to allocate %"PRIuMAX" over limit %d",
-		    (intmax_t)size, limit);
+	if (limit && size > limit) {
+		if (gentle) {
+			error("attempting to allocate %"PRIuMAX" over limit %d",
+			      (intmax_t)size, limit);
+			return -1;
+		} else
+			die("attempting to allocate %"PRIuMAX" over limit %d",
+			    (intmax_t)size, limit);
+	}
+	return 0;
 }
=20
 try_to_free_t set_try_to_free_routine(try_to_free_t routine)
@@ -42,11 +49,12 @@ char *xstrdup(const char *str)
 	return ret;
 }
=20
-void *xmalloc(size_t size)
+static void *do_xmalloc(size_t size, int gentle)
 {
 	void *ret;
=20
-	memory_limit_check(size);
+	if (memory_limit_check(size, gentle))
+		return NULL;
 	ret =3D malloc(size);
 	if (!ret && !size)
 		ret =3D malloc(1);
@@ -55,9 +63,16 @@ void *xmalloc(size_t size)
 		ret =3D malloc(size);
 		if (!ret && !size)
 			ret =3D malloc(1);
-		if (!ret)
-			die("Out of memory, malloc failed (tried to allocate %lu bytes)",
-			    (unsigned long)size);
+		if (!ret) {
+			if (!gentle)
+				die("Out of memory, malloc failed (tried to allocate %lu bytes)",
+				    (unsigned long)size);
+			else {
+				error("Out of memory, malloc failed (tried to allocate %lu bytes)"=
,
+				      (unsigned long)size);
+				return NULL;
+			}
+		}
 	}
 #ifdef XMALLOC_POISON
 	memset(ret, 0xA5, size);
@@ -65,16 +80,37 @@ void *xmalloc(size_t size)
 	return ret;
 }
=20
-void *xmallocz(size_t size)
+void *xmalloc(size_t size)
+{
+	return do_xmalloc(size, 0);
+}
+
+static void *do_xmallocz(size_t size, int gentle)
 {
 	void *ret;
-	if (unsigned_add_overflows(size, 1))
-		die("Data too large to fit into virtual memory space.");
-	ret =3D xmalloc(size + 1);
-	((char*)ret)[size] =3D 0;
+	if (unsigned_add_overflows(size, 1)) {
+		if (gentle) {
+			error("Data too large to fit into virtual memory space.");
+			return NULL;
+		} else
+			die("Data too large to fit into virtual memory space.");
+	}
+	ret =3D do_xmalloc(size + 1, gentle);
+	if (ret)
+		((char*)ret)[size] =3D 0;
 	return ret;
 }
=20
+void *xmallocz(size_t size)
+{
+	return do_xmallocz(size, 0);
+}
+
+void *xmallocz_gentle(size_t size)
+{
+	return do_xmallocz(size, 1);
+}
+
 /*
  * xmemdupz() allocates (len + 1) bytes of memory, duplicates "len" by=
tes of
  * "data" to the allocated memory, zero terminates the allocated memor=
y,
@@ -96,7 +132,7 @@ void *xrealloc(void *ptr, size_t size)
 {
 	void *ret;
=20
-	memory_limit_check(size);
+	memory_limit_check(size, 0);
 	ret =3D realloc(ptr, size);
 	if (!ret && !size)
 		ret =3D realloc(ptr, 1);
@@ -115,7 +151,7 @@ void *xcalloc(size_t nmemb, size_t size)
 {
 	void *ret;
=20
-	memory_limit_check(size * nmemb);
+	memory_limit_check(size * nmemb, 0);
 	ret =3D calloc(nmemb, size);
 	if (!ret && (!nmemb || !size))
 		ret =3D calloc(1, 1);
--=20
1.9.1.346.ga2b5940
