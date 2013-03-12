From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 08/13] exclude: record baselen in the pattern
Date: Tue, 12 Mar 2013 20:04:55 +0700
Message-ID: <1363093500-16796-9-git-send-email-pclouds@gmail.com>
References: <1362896070-17456-1-git-send-email-pclouds@gmail.com>
 <1363093500-16796-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 12 14:06:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFOuh-0007n6-R6
	for gcvg-git-2@plane.gmane.org; Tue, 12 Mar 2013 14:06:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755456Ab3CLNGP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Mar 2013 09:06:15 -0400
Received: from mail-pb0-f42.google.com ([209.85.160.42]:36917 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755388Ab3CLNGO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Mar 2013 09:06:14 -0400
Received: by mail-pb0-f42.google.com with SMTP id xb4so4971512pbc.1
        for <git@vger.kernel.org>; Tue, 12 Mar 2013 06:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=AnevXY0LYkOOYngrBT7WVT8AxTmUvWGbbQBy9bF+rMQ=;
        b=iCiBZCRR7d8j5j/TOZcJ4eI2iTWKW0fztVnw01pllvNAELfrGIo8RIrRa5C7KeHSdC
         2T9KBSS9dkoVffuOC2wh+csE0XkHjL/RjQtfDJWdpbLCN54wRCAGecu68H92hmiKs7MJ
         v2HDt5gFNs6gjAFaEgbTlAVQegfDAo4J2Dm1jdCftR74V8F0F0RHA+jMCrokvamaPAvB
         KOUqkAekAyouHCQutCmBIIK8YM4SrhKfpDyTLcvhB1hVxeSC0Mjpg2yZqYcHuqNxeInT
         kfqX8d5TwBbGs0TStohaAL8eBxtvR9JmE0Kism2DLNQHzbr4hzmLG66UFqBQzWqVGwYT
         eQcA==
X-Received: by 10.68.143.74 with SMTP id sc10mr37439383pbb.110.1363093574077;
        Tue, 12 Mar 2013 06:06:14 -0700 (PDT)
Received: from lanh ([115.74.63.193])
        by mx.google.com with ESMTPS id ou3sm25006710pbc.7.2013.03.12.06.06.11
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 12 Mar 2013 06:06:13 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Tue, 12 Mar 2013 20:06:08 +0700
X-Mailer: git-send-email 1.8.1.2.536.gf441e6d
In-Reply-To: <1363093500-16796-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217957>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 attr.c |  4 +++-
 dir.c  | 19 ++++++++++++++-----
 dir.h  |  6 +++++-
 3 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/attr.c b/attr.c
index 1818ba5..b89da33 100644
--- a/attr.c
+++ b/attr.c
@@ -249,12 +249,14 @@ static struct match_attr *parse_attr_line(const c=
har *line, const char *src,
 		res->u.attr =3D git_attr_internal(name, namelen);
 	else {
 		char *p =3D (char *)&(res->state[num_attr]);
+		int pattern_baselen;
 		memcpy(p, name, namelen);
 		res->u.pat.pattern =3D p;
 		parse_exclude_pattern(&res->u.pat.pattern,
 				      &res->u.pat.patternlen,
 				      &res->u.pat.flags,
-				      &res->u.pat.nowildcardlen);
+				      &res->u.pat.nowildcardlen,
+				      &pattern_baselen);
 		if (res->u.pat.flags & EXC_FLAG_MUSTBEDIR)
 			res->u.pat.patternlen++;
 		if (res->u.pat.flags & EXC_FLAG_NEGATIVE) {
diff --git a/dir.c b/dir.c
index f8f7a7e..932fd2f 100644
--- a/dir.c
+++ b/dir.c
@@ -390,10 +390,11 @@ static int no_wildcard(const char *string)
 void parse_exclude_pattern(const char **pattern,
 			   int *patternlen,
 			   int *flags,
-			   int *nowildcardlen)
+			   int *nowildcardlen,
+			   int *pattern_baselen)
 {
 	const char *p =3D *pattern;
-	size_t i, len;
+	int i, len;
=20
 	*flags =3D 0;
 	if (*p =3D=3D '!') {
@@ -405,12 +406,15 @@ void parse_exclude_pattern(const char **pattern,
 		len--;
 		*flags |=3D EXC_FLAG_MUSTBEDIR;
 	}
-	for (i =3D 0; i < len; i++) {
+	for (i =3D len - 1; i >=3D 0; i--) {
 		if (p[i] =3D=3D '/')
 			break;
 	}
-	if (i =3D=3D len)
+	if (i < 0) {
 		*flags |=3D EXC_FLAG_NODIR;
+		*pattern_baselen =3D -1;
+	} else
+		*pattern_baselen =3D i;
 	*nowildcardlen =3D simple_length(p);
 	/*
 	 * we should have excluded the trailing slash from 'p' too,
@@ -421,6 +425,8 @@ void parse_exclude_pattern(const char **pattern,
 		*nowildcardlen =3D len;
 	if (*p =3D=3D '*' && no_wildcard(p + 1))
 		*flags |=3D EXC_FLAG_ENDSWITH;
+	else if (*nowildcardlen !=3D len)
+		*pattern_baselen =3D -1;
 	*pattern =3D p;
 	*patternlen =3D len;
 }
@@ -432,8 +438,10 @@ void add_exclude(const char *string, const char *b=
ase,
 	int patternlen;
 	int flags;
 	int nowildcardlen;
+	int pattern_baselen;
=20
-	parse_exclude_pattern(&string, &patternlen, &flags, &nowildcardlen);
+	parse_exclude_pattern(&string, &patternlen, &flags,
+			      &nowildcardlen, &pattern_baselen);
 	if (flags & EXC_FLAG_MUSTBEDIR) {
 		char *s;
 		x =3D xmalloc(sizeof(*x) + patternlen + 1);
@@ -449,6 +457,7 @@ void add_exclude(const char *string, const char *ba=
se,
 	x->nowildcardlen =3D nowildcardlen;
 	x->base =3D base;
 	x->baselen =3D baselen;
+	x->pattern_baselen =3D pattern_baselen;
 	x->flags =3D flags;
 	x->srcpos =3D srcpos;
 	ALLOC_GROW(el->excludes, el->nr + 1, el->alloc);
diff --git a/dir.h b/dir.h
index 0748407..cb50a85 100644
--- a/dir.h
+++ b/dir.h
@@ -44,6 +44,7 @@ struct exclude_list {
 		int nowildcardlen;
 		const char *base;
 		int baselen;
+		int pattern_baselen;
 		int flags;
=20
 		/*
@@ -172,7 +173,10 @@ extern struct exclude_list *add_exclude_list(struc=
t dir_struct *dir,
 extern int add_excludes_from_file_to_list(const char *fname, const cha=
r *base, int baselen,
 					  struct exclude_list *el, int check_index);
 extern void add_excludes_from_file(struct dir_struct *, const char *fn=
ame);
-extern void parse_exclude_pattern(const char **string, int *patternlen=
, int *flags, int *nowildcardlen);
+extern void parse_exclude_pattern(const char **string,
+				  int *patternlen, int *flags,
+				  int *nowildcardlen,
+				  int *pattern_baselen);
 extern void add_exclude(const char *string, const char *base,
 			int baselen, struct exclude_list *el, int srcpos);
 extern void clear_exclude_list(struct exclude_list *el);
--=20
1.8.1.2.536.gf441e6d
