From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] dir.c: allow re-include after a dir is excluded in some cases
Date: Wed, 19 Nov 2014 17:30:58 +0700
Message-ID: <1416393058-5497-1-git-send-email-pclouds@gmail.com>
References: <CACsJy8BHvucnEAW065OXOe5NBQkxp7+8HJb7XCGYgOa=pkxLVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: phil-gitml@phil.spodhuis.org
X-From: git-owner@vger.kernel.org Wed Nov 19 11:31:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xr2XP-0004Sg-OK
	for gcvg-git-2@plane.gmane.org; Wed, 19 Nov 2014 11:31:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755538AbaKSKa7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 Nov 2014 05:30:59 -0500
Received: from mail-pd0-f171.google.com ([209.85.192.171]:51367 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754981AbaKSKa5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Nov 2014 05:30:57 -0500
Received: by mail-pd0-f171.google.com with SMTP id v10so296091pde.30
        for <git@vger.kernel.org>; Wed, 19 Nov 2014 02:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=UIPBTb07fMWu8CB5NA7quao3nvDLO3BTtm9mbFk8kTs=;
        b=BkGoDQcGnUJdGbE5q8YZfXV6RsOnVaczzke1lokHsv/IZK0H+xn8km0cjN9r1TzHUQ
         gToy+ZdDb1z1KkemwP1QZzBsGYa3kJ42UDNF9ER/tVQIEYnJLq1jQwrGTkFNnjvA01rs
         mXtKxVoBpUQ/5hLZXlNzf4zqopnWnYKJizeAi85POybDuZDj9X+NCjX5ikG0H4Yge2xE
         rhbUqf/xm5CqnRvbOMUlSEujBXHDTCSMPJJFWWK1yBz5yo6ddGyxLg8f00sGwAWZ80Of
         9wfWWrSw+CURTVtImn/925ryfMXF/FBYOljsfKD0/cVoXRD6zPM92sPSlrjtKXDldb4o
         eZEw==
X-Received: by 10.68.138.137 with SMTP id qq9mr44666690pbb.73.1416393056523;
        Wed, 19 Nov 2014 02:30:56 -0800 (PST)
Received: from lanh ([115.73.225.67])
        by mx.google.com with ESMTPSA id hb6sm1505460pbc.31.2014.11.19.02.30.53
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Nov 2014 02:30:55 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Wed, 19 Nov 2014 17:31:14 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <CACsJy8BHvucnEAW065OXOe5NBQkxp7+8HJb7XCGYgOa=pkxLVA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If we exclude a directory and have no knowledge in advance if there
will be any negative rules on that directory, then it makes no sense
to enter the directory and search for those negative rules. That
defeats the purpose of excluding in the first place.

However there are cases where we know in advance about such negative
rules. One of them is when the rule to exclude a dir and negative
rules on that dir appear on the same .gitignore file. This case be
easily detected.

Note that I do not support this case

  *
  !bar

because I fear of performance degradation because people may not
realize "!bar" will force recursing indefinitely. So you need at least
a slash some where to nail your pattern to some directory. "!/bar" is
fine (but pointless), "bar/*.c" or "**/foo" may be seen more often.

This is a quick prototype. I know the two statements in add_exclude()
is not good enough. I should not count the last trailing slash because
that one means different thing.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 On Wed, Nov 19, 2014 at 4:48 PM, Duy Nguyen <pclouds@gmail.com> wrote:
 > On Wed, Nov 19, 2014 at 10:40 AM, Phil Pennock
 > <phil-gitml@phil.spodhuis.org> wrote:
 >> Expected to work as .gitignore in top-level of repo:
 >>
 >> =C2=A0 =C2=A0 *
 >> =C2=A0 =C2=A0 !**/*.asc
 >> =C2=A0 =C2=A0 !.gitignore
 >>
 >
 > gitignore man page has this "It is not possible to re-include a file
 > if a parent directory of that file is excluded". In this case,
 > directory "foo" is ignored by "*". Although it makes sense for this
 > particular case to re-include something in foo because we can clearl=
y
 > see there are rules to re-include. It's on my todo list, but I don't
 > know when it will be implemented.

 It turns out not so hard to do. I just needed a push like your
 report. I'll try to find some time to finish this up, if people don't
 object this idea.

 Documentation/gitignore.txt | 13 +++++++++----
 dir.c                       | 27 +++++++++++++++++++++------
 dir.h                       |  2 ++
 3 files changed, 32 insertions(+), 10 deletions(-)

diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.txt
index 09e82c3..0340c44 100644
--- a/Documentation/gitignore.txt
+++ b/Documentation/gitignore.txt
@@ -82,10 +82,9 @@ PATTERN FORMAT
=20
  - An optional prefix "`!`" which negates the pattern; any
    matching file excluded by a previous pattern will become
-   included again. It is not possible to re-include a file if a parent
-   directory of that file is excluded. Git doesn't list excluded
-   directories for performance reasons, so any patterns on contained
-   files have no effect, no matter where they are defined.
+   included again.
+   It is usually not possible to re-include a file if a parent
+   directory of that file is excluded. See NOTES for details.
    Put a backslash ("`\`") in front of the first "`!`" for patterns
    that begin with a literal "`!`", for example, "`\!important!.txt`".
=20
@@ -144,6 +143,12 @@ use 'git update-index {litdd}assume-unchanged'.
 To stop tracking a file that is currently tracked, use
 'git rm --cached'.
=20
+It is usually not possible to re-include a file if a parent directory
+of that file is excluded because of performance reasons. However, if
+there are negative rules in the same .gitignore file that contains the
+rule to ignore a specific directory, and those negative rules contain
+a slash, then re-inclusion is possible.
+
 EXAMPLES
 --------
=20
diff --git a/dir.c b/dir.c
index 3f7a025..df6d940 100644
--- a/dir.c
+++ b/dir.c
@@ -443,6 +443,8 @@ void add_exclude(const char *string, const char *ba=
se,
 	int flags;
 	int nowildcardlen;
=20
+	if (string[0] =3D=3D '!' && strchr(string + 1, '/'))
+		el->flags |=3D EXC_FLAG_MAY_REINCLUDE;
 	parse_exclude_pattern(&string, &patternlen, &flags, &nowildcardlen);
 	if (flags & EXC_FLAG_MUSTBEDIR) {
 		char *s;
@@ -710,14 +712,17 @@ static struct exclude *last_exclude_matching_from=
_list(const char *pathname,
 						       struct exclude_list *el)
 {
 	int i;
+	struct exclude *x;
+	const char *exclude;
+	int prefix;
=20
 	if (!el->nr)
 		return NULL;	/* undefined */
=20
 	for (i =3D el->nr - 1; 0 <=3D i; i--) {
-		struct exclude *x =3D el->excludes[i];
-		const char *exclude =3D x->pattern;
-		int prefix =3D x->nowildcardlen;
+		x =3D el->excludes[i];
+		exclude =3D x->pattern;
+		prefix =3D x->nowildcardlen;
=20
 		if (x->flags & EXC_FLAG_MUSTBEDIR) {
 			if (*dtype =3D=3D DT_UNKNOWN)
@@ -731,7 +736,7 @@ static struct exclude *last_exclude_matching_from_l=
ist(const char *pathname,
 					   pathlen - (basename - pathname),
 					   exclude, prefix, x->patternlen,
 					   x->flags))
-				return x;
+				goto done;
 			continue;
 		}
=20
@@ -739,9 +744,19 @@ static struct exclude *last_exclude_matching_from_=
list(const char *pathname,
 		if (match_pathname(pathname, pathlen,
 				   x->base, x->baselen ? x->baselen - 1 : 0,
 				   exclude, prefix, x->patternlen, x->flags))
-			return x;
+			goto done;
+	}
+	x =3D NULL;		/* undecided */
+done:
+	if (x && !(x->flags & EXC_FLAG_NEGATIVE) &&
+	    (el->flags & EXC_FLAG_MAY_REINCLUDE)) {
+		if (*dtype =3D=3D DT_UNKNOWN)
+			*dtype =3D get_dtype(NULL, pathname, pathlen);
+		if (*dtype =3D=3D DT_DIR)
+			x =3D NULL;
 	}
-	return NULL; /* undecided */
+
+	return x;
 }
=20
 /*
diff --git a/dir.h b/dir.h
index 6c45e9d..1ace1cf 100644
--- a/dir.h
+++ b/dir.h
@@ -14,6 +14,7 @@ struct dir_entry {
 #define EXC_FLAG_ENDSWITH 4
 #define EXC_FLAG_MUSTBEDIR 8
 #define EXC_FLAG_NEGATIVE 16
+#define EXC_FLAG_MAY_REINCLUDE 32
=20
 struct exclude {
 	/*
@@ -46,6 +47,7 @@ struct exclude {
 struct exclude_list {
 	int nr;
 	int alloc;
+	int flags;
=20
 	/* remember pointer to exclude file contents so we can free() */
 	char *filebuf;
--=20
2.1.0.rc0.78.gc0d8480
