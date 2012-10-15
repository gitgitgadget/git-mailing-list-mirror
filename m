From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 5/6] gitignore: make pattern parsing code a separate function
Date: Mon, 15 Oct 2012 13:24:38 +0700
Message-ID: <1350282279-4377-5-git-send-email-pclouds@gmail.com>
References: <1350282212-4270-1-git-send-email-pclouds@gmail.com>
 <1350282279-4377-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 15 08:25:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNe7N-0006Qc-KZ
	for gcvg-git-2@plane.gmane.org; Mon, 15 Oct 2012 08:25:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753871Ab2JOGZZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Oct 2012 02:25:25 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:42564 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753294Ab2JOGZY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2012 02:25:24 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so4541884pad.19
        for <git@vger.kernel.org>; Sun, 14 Oct 2012 23:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=3j0orpkXxGJLTtdQ0MVwPF6+mFCl7MtDIu4ko1VQgdg=;
        b=PHyAsHeg6n+5AXxhFNSh36Pe0BdHByhyim4njdu6BoNNhkE3F/G+vJCXnNS4oiGry8
         Qs6Lz8h6Ay32rboZUES4+nXxQpnPL0cPltNMhXygQj0SUaS6pyKjnZRr0nPpsOimiOQT
         asJVN/iievMzzrlfF7kbF6oh8eW4v571zrs2nSxg4wKM/krMNs9pg3KQQVfUhDGumOg/
         fWowcOco3PIXCVjEBjNhwXyq5V1+FuzNEWDLAUKC6Us4gU4mC2G/AUKneWu3qCtcOFm2
         IhuKOImqa0VYueUZeO0YW7xI6Kc6cwto13hJRzq2N2V+Af6WhXxi86sOeayHs3XFtEfV
         lrvg==
Received: by 10.68.211.67 with SMTP id na3mr34198545pbc.21.1350282323524;
        Sun, 14 Oct 2012 23:25:23 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id nv2sm8573031pbc.44.2012.10.14.23.25.18
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 14 Oct 2012 23:25:21 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 15 Oct 2012 13:25:12 +0700
X-Mailer: git-send-email 1.8.0.rc0.29.g1fdd78f
In-Reply-To: <1350282279-4377-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207697>

This function can later be reused by attr.c. Also turn to_exclude
field into a flag.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 dir.c | 71 ++++++++++++++++++++++++++++++++++++++++++++++-------------=
--------
 dir.h |  2 +-
 2 files changed, 50 insertions(+), 23 deletions(-)

diff --git a/dir.c b/dir.c
index 32d1c90..c4e64a5 100644
--- a/dir.c
+++ b/dir.c
@@ -308,42 +308,69 @@ static int no_wildcard(const char *string)
 	return string[simple_length(string)] =3D=3D '\0';
 }
=20
+static void parse_exclude_pattern(const char **pattern,
+				  int *patternlen,
+				  int *flags,
+				  int *nowildcardlen)
+{
+	const char *p =3D *pattern;
+	size_t i, len;
+
+	*flags =3D 0;
+	if (*p =3D=3D '!') {
+		*flags |=3D EXC_FLAG_NEGATIVE;
+		p++;
+	}
+	len =3D strlen(p);
+	if (len && p[len - 1] =3D=3D '/') {
+		len--;
+		*flags |=3D EXC_FLAG_MUSTBEDIR;
+	}
+	for (i =3D 0; i < len; i++) {
+		if (p[i] =3D=3D '/')
+			break;
+	}
+	if (i =3D=3D len)
+		*flags |=3D EXC_FLAG_NODIR;
+	*nowildcardlen =3D simple_length(p);
+	/*
+	 * we should have excluded the trailing slash from 'p' too,
+	 * but that's one more allocation. Instead just make sure
+	 * nowildcardlen does not exceed real patternlen
+	 */
+	if (*nowildcardlen > len)
+		*nowildcardlen =3D len;
+	if (*p =3D=3D '*' && no_wildcard(p + 1))
+		*flags |=3D EXC_FLAG_ENDSWITH;
+	*pattern =3D p;
+	*patternlen =3D len;
+}
+
 void add_exclude(const char *string, const char *base,
 		 int baselen, struct exclude_list *which)
 {
 	struct exclude *x;
-	size_t len;
-	int to_exclude =3D 1;
-	int flags =3D 0;
+	int patternlen;
+	int flags;
+	int nowildcardlen;
=20
-	if (*string =3D=3D '!') {
-		to_exclude =3D 0;
-		string++;
-	}
-	len =3D strlen(string);
-	if (len && string[len - 1] =3D=3D '/') {
+	parse_exclude_pattern(&string, &patternlen, &flags, &nowildcardlen);
+	if (flags & EXC_FLAG_MUSTBEDIR) {
 		char *s;
-		x =3D xmalloc(sizeof(*x) + len);
+		x =3D xmalloc(sizeof(*x) + patternlen + 1);
 		s =3D (char *)(x+1);
-		memcpy(s, string, len - 1);
-		s[len - 1] =3D '\0';
-		string =3D s;
+		memcpy(s, string, patternlen);
+		s[patternlen] =3D '\0';
 		x->pattern =3D s;
-		flags =3D EXC_FLAG_MUSTBEDIR;
 	} else {
 		x =3D xmalloc(sizeof(*x));
 		x->pattern =3D string;
 	}
-	x->to_exclude =3D to_exclude;
-	x->patternlen =3D strlen(string);
+	x->patternlen =3D patternlen;
+	x->nowildcardlen =3D nowildcardlen;
 	x->base =3D base;
 	x->baselen =3D baselen;
 	x->flags =3D flags;
-	if (!strchr(string, '/'))
-		x->flags |=3D EXC_FLAG_NODIR;
-	x->nowildcardlen =3D simple_length(string);
-	if (*string =3D=3D '*' && no_wildcard(string+1))
-		x->flags |=3D EXC_FLAG_ENDSWITH;
 	ALLOC_GROW(which->excludes, which->nr + 1, which->alloc);
 	which->excludes[which->nr++] =3D x;
 }
@@ -584,7 +611,7 @@ int excluded_from_list(const char *pathname,
 	for (i =3D el->nr - 1; 0 <=3D i; i--) {
 		struct exclude *x =3D el->excludes[i];
 		const char *exclude =3D x->pattern;
-		int to_exclude =3D x->to_exclude;
+		int to_exclude =3D x->flags & EXC_FLAG_NEGATIVE ? 0 : 1;
 		int prefix =3D x->nowildcardlen;
=20
 		if (x->flags & EXC_FLAG_MUSTBEDIR) {
diff --git a/dir.h b/dir.h
index 893465a..41ea32d 100644
--- a/dir.h
+++ b/dir.h
@@ -11,6 +11,7 @@ struct dir_entry {
 #define EXC_FLAG_NODIR 1
 #define EXC_FLAG_ENDSWITH 4
 #define EXC_FLAG_MUSTBEDIR 8
+#define EXC_FLAG_NEGATIVE 16
=20
 struct exclude_list {
 	int nr;
@@ -21,7 +22,6 @@ struct exclude_list {
 		int nowildcardlen;
 		const char *base;
 		int baselen;
-		int to_exclude;
 		int flags;
 	} **excludes;
 };
--=20
1.8.0.rc0.29.g1fdd78f
