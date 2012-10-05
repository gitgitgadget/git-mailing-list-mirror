From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 01/10] gitignore: make pattern parsing code a separate function
Date: Fri,  5 Oct 2012 11:41:00 +0700
Message-ID: <1349412069-627-2-git-send-email-pclouds@gmail.com>
References: <1349412069-627-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 05 09:36:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TK2SN-0001OW-8j
	for gcvg-git-2@plane.gmane.org; Fri, 05 Oct 2012 09:36:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752723Ab2JEHgL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Oct 2012 03:36:11 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:46160 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752300Ab2JEHgJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Oct 2012 03:36:09 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so1401381pad.19
        for <git@vger.kernel.org>; Fri, 05 Oct 2012 00:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=10vibbMPK6SguzwgbJYdV6xON6m+a6g+a4afQvUDsfk=;
        b=GBofHbwoEAXt2MhzcMBvwlZLzpglDrl8XSd97xpgqjVKh407+HRKiIq/9NtYV+0CpA
         xRq9ZYxFfrdNOcLVHgJs926xwXvEDzNWxzJWR9GLwW7jRjDh6L5c9gT/dMUb2gL68LUR
         iRS+YMpKHkcW4ag2J/71lEzhz2E89i+ric+BwfCfW5bHOJrCYxQYzlE+Yb+GSXU9deEK
         vTmIQo3IK7GNrniktKgeFstg3MPD9SmGEc6uap6vMWREwG3p2dVR9hWeRKoSjWhX76sz
         rgAd419mvdBje8PoNOwyyBscybJlXa28xin4fQIGW9XLQ0yPldDKNq67OXJVGsdbztIy
         PZGg==
Received: by 10.68.242.69 with SMTP id wo5mr27288384pbc.47.1349412067815;
        Thu, 04 Oct 2012 21:41:07 -0700 (PDT)
Received: from tre ([115.74.45.10])
        by mx.google.com with ESMTPS id qf4sm5440105pbc.1.2012.10.04.21.41.04
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 04 Oct 2012 21:41:07 -0700 (PDT)
Received: by tre (sSMTP sendmail emulation); Fri, 05 Oct 2012 11:41:16 +0700
X-Mailer: git-send-email 1.7.10.1.641.g9354186
In-Reply-To: <1349412069-627-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207087>

This function can later be reused by attr.c. Also turn to_exclude
field into a flag.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 If we go with glob->regex conversion way, this is where we could
 rewrite the pattern (and set EXC_FLAG_REGEX).

 dir.c | 71 ++++++++++++++++++++++++++++++++++++++++++++++-------------=
--------
 dir.h |  2 +-
 2 files changed, 50 insertions(+), 23 deletions(-)

diff --git a/dir.c b/dir.c
index 240bf0c..cd13920 100644
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
@@ -518,7 +545,7 @@ int excluded_from_list(const char *pathname,
 	for (i =3D el->nr - 1; 0 <=3D i; i--) {
 		struct exclude *x =3D el->excludes[i];
 		const char *name, *exclude =3D x->pattern;
-		int to_exclude =3D x->to_exclude;
+		int to_exclude =3D x->flags & EXC_FLAG_NEGATIVE ? 0 : 1;
 		int namelen, prefix =3D x->nowildcardlen;
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
1.7.12.1.405.gb727dc9
