From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 07/13] utf8.c: add reencode_string_len() that can handle NULs in string
Date: Fri, 19 Apr 2013 09:08:46 +1000
Message-ID: <1366326532-28517-8-git-send-email-pclouds@gmail.com>
References: <1366100702-31745-1-git-send-email-pclouds@gmail.com>
 <1366326532-28517-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 19 01:09:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USxxk-0007jU-GX
	for gcvg-git-2@plane.gmane.org; Fri, 19 Apr 2013 01:09:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967234Ab3DRXJw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Apr 2013 19:09:52 -0400
Received: from mail-pd0-f178.google.com ([209.85.192.178]:35609 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753871Ab3DRXJw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Apr 2013 19:09:52 -0400
Received: by mail-pd0-f178.google.com with SMTP id w11so1835962pde.9
        for <git@vger.kernel.org>; Thu, 18 Apr 2013 16:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=yMzCC4w8it5N1UrWU7sDyhCMJ8PomEJt6OUCw3dCzio=;
        b=d+AswhCUCeynKO5Mq0H5dvUuKJLLR/Jgp5p+X/fkmr9sGNBwe+yIHGSF5EijVFQt9O
         0swJl6OVSzjfPCn4VgOj+eHuDqGJSDqbXbPXPMJovI/clj0KiNhLXNxzN58UNs6CD29s
         d/IU8BSRp9N6j0HgLimF3AVOga4v+KWH+puHREdme+Iwkaf5cIBVXkQBg/qukqbG2NLJ
         FWgyVKqdzf8r89ewVoOIYa7HQEtP26hcIfYhVFCkrg4LZ7j1gOJy/85H0RU2eacACvlH
         9mnIBSRsO6YqiABLpI12lpMB40qreNKhFsasuiYqezx/xj/Bu0yX8fTF8uyahNQ5OWfB
         FWSg==
X-Received: by 10.68.5.166 with SMTP id t6mr15744674pbt.105.1366326591711;
        Thu, 18 Apr 2013 16:09:51 -0700 (PDT)
Received: from pclouds@gmail.com (dektec3.lnk.telstra.net. [165.228.202.174])
        by mx.google.com with ESMTPS id c5sm11166077pbl.37.2013.04.18.16.09.48
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 18 Apr 2013 16:09:51 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 19 Apr 2013 09:09:41 +1000
X-Mailer: git-send-email 1.8.2.82.gc24b958
In-Reply-To: <1366326532-28517-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221709>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 compat/precompose_utf8.c |  2 +-
 utf8.c                   | 10 +++++++---
 utf8.h                   | 19 ++++++++++++++++---
 3 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/compat/precompose_utf8.c b/compat/precompose_utf8.c
index 8cf5955..d9203d0 100644
--- a/compat/precompose_utf8.c
+++ b/compat/precompose_utf8.c
@@ -78,7 +78,7 @@ void precompose_argv(int argc, const char **argv)
 		size_t namelen;
 		oldarg =3D argv[i];
 		if (has_non_ascii(oldarg, (size_t)-1, &namelen)) {
-			newarg =3D reencode_string_iconv(oldarg, namelen, ic_precompose);
+			newarg =3D reencode_string_iconv(oldarg, namelen, ic_precompose, NU=
LL);
 			if (newarg)
 				argv[i] =3D newarg;
 		}
diff --git a/utf8.c b/utf8.c
index e7ba33c..7c342ff 100644
--- a/utf8.c
+++ b/utf8.c
@@ -468,7 +468,7 @@ int utf8_fprintf(FILE *stream, const char *format, =
=2E..)
 #else
 	typedef char * iconv_ibp;
 #endif
-char *reencode_string_iconv(const char *in, size_t insz, iconv_t conv)
+char *reencode_string_iconv(const char *in, size_t insz, iconv_t conv,=
 int *outsz_p)
 {
 	size_t outsz, outalloc;
 	char *out, *outpos;
@@ -502,13 +502,17 @@ char *reencode_string_iconv(const char *in, size_=
t insz, iconv_t conv)
 		}
 		else {
 			*outpos =3D '\0';
+			if (outsz_p)
+				*outsz_p =3D outpos - out;
 			break;
 		}
 	}
 	return out;
 }
=20
-char *reencode_string(const char *in, const char *out_encoding, const =
char *in_encoding)
+char *reencode_string_len(const char *in, int insz,
+			  const char *out_encoding, const char *in_encoding,
+			  int *outsz)
 {
 	iconv_t conv;
 	char *out;
@@ -534,7 +538,7 @@ char *reencode_string(const char *in, const char *o=
ut_encoding, const char *in_e
 			return NULL;
 	}
=20
-	out =3D reencode_string_iconv(in, strlen(in), conv);
+	out =3D reencode_string_iconv(in, insz, conv, outsz);
 	iconv_close(conv);
 	return out;
 }
diff --git a/utf8.h b/utf8.h
index d3da96f..a43ef9a 100644
--- a/utf8.h
+++ b/utf8.h
@@ -17,12 +17,25 @@ void strbuf_add_wrapped_bytes(struct strbuf *buf, c=
onst char *data, int len,
 			     int indent, int indent2, int width);
=20
 #ifndef NO_ICONV
-char *reencode_string_iconv(const char *in, size_t insz, iconv_t conv)=
;
-char *reencode_string(const char *in, const char *out_encoding, const =
char *in_encoding);
+char *reencode_string_iconv(const char *in, size_t insz,
+			    iconv_t conv, int *outsz);
+char *reencode_string_len(const char *in, int insz,
+			  const char *out_encoding,
+			  const char *in_encoding,
+			  int *outsz);
 #else
-#define reencode_string(a,b,c) NULL
+#define reencode_string_len(a,b,c,d,e) NULL
 #endif
=20
+static inline char *reencode_string(const char *in,
+				    const char *out_encoding,
+				    const char *in_encoding)
+{
+	return reencode_string_len(in, strlen(in),
+				   out_encoding, in_encoding,
+				   NULL);
+}
+
 int mbs_chrlen(const char **text, size_t *remainder_p, const char *enc=
oding);
=20
 #endif
--=20
1.8.2.82.gc24b958
