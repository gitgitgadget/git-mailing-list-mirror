From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 1/6] wrapper.c: introduce gentle xmalloc(z) that does not die()
Date: Wed, 13 Aug 2014 17:57:29 +0700
Message-ID: <1407927454-9268-2-git-send-email-pclouds@gmail.com>
References: <1403610336-27761-1-git-send-email-pclouds@gmail.com>
 <1407927454-9268-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, worley@alum.mit.edu,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 13 12:57:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XHWFg-0000NN-KB
	for gcvg-git-2@plane.gmane.org; Wed, 13 Aug 2014 12:57:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752092AbaHMK5v convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Aug 2014 06:57:51 -0400
Received: from mail-pd0-f171.google.com ([209.85.192.171]:53876 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751494AbaHMK5r (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2014 06:57:47 -0400
Received: by mail-pd0-f171.google.com with SMTP id z10so14262820pdj.16
        for <git@vger.kernel.org>; Wed, 13 Aug 2014 03:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Qdtri5LKv+GEQubANmYAr37/4eg9aGFMNmwGlwBLO0o=;
        b=1KSpLzx+2BsapC7I0brnM+8oj2Jn65ddldyDn0ETjO4Ue2TJlBFnMjpMEYKHluDP/Q
         NDWVN6eyNz3ldHfNjxlqk+BVoQtHi30cPx7ULia6GoAzEQgvST+ipoftqRiW+bLf7Ooy
         /Opjd3kWnxiFk9VAIwV/sus9rYnFQdrWFeYkBeBdTR2cPQHCrc1KsFx83Vu+PAbFyc2a
         /Jv3RglLvMpzUyoOYys95K4ASKpLKHGJ32RwlpsAbgvrTWxUmFJjs5wwVN5Hf54TAi6f
         AOn0pMJXPJ9Ug1Q9r7kR1b5ZNJXa6RvXAWbBPM3+aDxzGkv59I/HJIZgA3RxD1L7Mq8V
         cYrg==
X-Received: by 10.70.54.102 with SMTP id i6mr3347014pdp.25.1407927467044;
        Wed, 13 Aug 2014 03:57:47 -0700 (PDT)
Received: from lanh ([115.73.196.146])
        by mx.google.com with ESMTPSA id xq3sm5778970pab.0.2014.08.13.03.57.44
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Aug 2014 03:57:46 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 13 Aug 2014 17:57:42 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1407927454-9268-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255193>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 git-compat-util.h |  2 ++
 wrapper.c         | 73 +++++++++++++++++++++++++++++++++++++++++++----=
--------
 2 files changed, 59 insertions(+), 16 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index f587749..0e541e7 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -592,7 +592,9 @@ extern try_to_free_t set_try_to_free_routine(try_to=
_free_t);
 #endif
 extern char *xstrdup(const char *str);
 extern void *xmalloc(size_t size);
+extern void *xmalloc_gentle(size_t size);
 extern void *xmallocz(size_t size);
+extern void *xmallocz_gentle(size_t size);
 extern void *xmemdupz(const void *data, size_t len);
 extern char *xstrndup(const char *str, size_t len);
 extern void *xrealloc(void *ptr, size_t size);
diff --git a/wrapper.c b/wrapper.c
index bc1bfb8..ad0992a 100644
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
@@ -65,16 +80,42 @@ void *xmalloc(size_t size)
 	return ret;
 }
=20
-void *xmallocz(size_t size)
+void *xmalloc(size_t size)
+{
+	return do_xmalloc(size, 0);
+}
+
+void *xmalloc_gentle(size_t size)
+{
+	return do_xmalloc(size, 1);
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
@@ -96,7 +137,7 @@ void *xrealloc(void *ptr, size_t size)
 {
 	void *ret;
=20
-	memory_limit_check(size);
+	memory_limit_check(size, 0);
 	ret =3D realloc(ptr, size);
 	if (!ret && !size)
 		ret =3D realloc(ptr, 1);
@@ -115,7 +156,7 @@ void *xcalloc(size_t nmemb, size_t size)
 {
 	void *ret;
=20
-	memory_limit_check(size * nmemb);
+	memory_limit_check(size * nmemb, 0);
 	ret =3D calloc(nmemb, size);
 	if (!ret && (!nmemb || !size))
 		ret =3D calloc(1, 1);
--=20
2.1.0.rc0.78.gc0d8480
