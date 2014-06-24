From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 1/4] wrapper.c: introduce gentle xmallocz that does not die()
Date: Tue, 24 Jun 2014 18:45:33 +0700
Message-ID: <1403610336-27761-1-git-send-email-pclouds@gmail.com>
References: <1401368227-14469-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, worley@alum.mit.edu,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 24 13:45:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WzPAd-0004FH-QR
	for gcvg-git-2@plane.gmane.org; Tue, 24 Jun 2014 13:45:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752597AbaFXLpr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Jun 2014 07:45:47 -0400
Received: from mail-pb0-f48.google.com ([209.85.160.48]:40970 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752581AbaFXLpq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2014 07:45:46 -0400
Received: by mail-pb0-f48.google.com with SMTP id rq2so149045pbb.35
        for <git@vger.kernel.org>; Tue, 24 Jun 2014 04:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=NjEsvfKAVvM2+8sz3oZziJtwWxkCUbwLCdYj74P3RQc=;
        b=e3EqBWGlbD/VEB4CKiv6OGxHFMxZnqOYFXrMEhTj5xQ7/o2w9XrutWauTY9L8TWN/r
         JbyBdRP9wHLGHeEn0/paCrQct6TfXN4AZ3AOrIrXPpUqLfXpwyfFG7ZQX66di0P+LHVh
         6LUEvYVlcLdqlBVWe9aFYM14wi9v55CysU4X0blJU3Io74wnVKCJMKYEKEJ2bLVTnB83
         oPsHtJUnpMbxrUnxqjVb2SpWFD7onKlgQwsWjk8mtarTyScnj5RiKT98evemh5jJbRfG
         EcTrsbMU0xQ4RRU/J9WeEVB6InhJwqvbe7LNVaNiVd2vn9as9IXU4qI8FaagpdR6H+jH
         TGyQ==
X-Received: by 10.66.120.99 with SMTP id lb3mr833873pab.2.1403610346438;
        Tue, 24 Jun 2014 04:45:46 -0700 (PDT)
Received: from lanh ([115.73.210.12])
        by mx.google.com with ESMTPSA id xs2sm233984pab.0.2014.06.24.04.45.43
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Jun 2014 04:45:45 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Tue, 24 Jun 2014 18:45:43 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <1401368227-14469-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252399>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 git-compat-util.h |  1 +
 wrapper.c         | 68 ++++++++++++++++++++++++++++++++++++++++++-----=
--------
 2 files changed, 53 insertions(+), 16 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index b6f03b3..7eee0f2 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -540,6 +540,7 @@ extern try_to_free_t set_try_to_free_routine(try_to=
_free_t);
 extern char *xstrdup(const char *str);
 extern void *xmalloc(size_t size);
 extern void *xmallocz(size_t size);
+extern void *xmallocz_gentle(size_t size);
 extern void *xmemdupz(const void *data, size_t len);
 extern char *xstrndup(const char *str, size_t len);
 extern void *xrealloc(void *ptr, size_t size);
diff --git a/wrapper.c b/wrapper.c
index bc1bfb8..06601c4 100644
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
