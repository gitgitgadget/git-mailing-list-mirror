From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 5/6] gitignore: do not do basename match with patterns that have '**'
Date: Thu,  4 Oct 2012 14:39:51 +0700
Message-ID: <1349336392-1772-6-git-send-email-pclouds@gmail.com>
References: <7v626q3hen.fsf@alter.siamese.dyndns.org>
 <1349336392-1772-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 05 00:19:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJtUK-0001w8-SH
	for gcvg-git-2@plane.gmane.org; Fri, 05 Oct 2012 00:01:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932348Ab2JDHkq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Oct 2012 03:40:46 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:45932 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932157Ab2JDHko (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2012 03:40:44 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so327784pbb.19
        for <git@vger.kernel.org>; Thu, 04 Oct 2012 00:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Bq63rqy23fPSCI+mRNa+grRRwusfzmO084Q62yNI98A=;
        b=RKn43xrqY91WnjPddgxAT7tt8hnTLtZmRCeZH+Dq0C0d9pyjm5avgfY6cimWqxB81G
         CeWdXL27ytSQNbuZR6LnhaRVgbTbeMQy3NJyYUAfXCdi3Yk1FQvJUpbFlaWLwwPAX3P1
         PhqrXKmNrb9OPq1BdPDu+X4uS1C+hgRqMP4pO2IYD/mtExmV3XsPFKc2cJulTKYvcRVv
         phTVt2eVIktNOk1GhXfPq8g0rzkj1lXlN7Ir6JyE8a0UN/azx3kc1Y9SdChB5IRHoTuJ
         D0ZAAhMxvooTNosYro1hmrcdgurrtAv3gkQvcmudsDB+cVVtnca2tcVaLo5IQ4IMLGUt
         YTBg==
Received: by 10.68.200.231 with SMTP id jv7mr19409668pbc.140.1349336444667;
        Thu, 04 Oct 2012 00:40:44 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id ox5sm3929247pbc.75.2012.10.04.00.40.41
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 04 Oct 2012 00:40:44 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 04 Oct 2012 14:40:32 +0700
X-Mailer: git-send-email 1.7.12.1.405.gb727dc9
In-Reply-To: <1349336392-1772-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206986>

"**" can match slashes, not like "*". "ab**ef" should be able to match
"ab/cd/ef", or "ab/c/d/ef" and so on. Turn off the EXC_FLAG_NODIR in
this case otherwise the pattern is only checked against the base
name. This behavior is in sync with rsync.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/gitignore.txt        | 10 +++++-----
 attr.c                             |  2 +-
 dir.c                              |  2 +-
 t/t0003-attributes.sh              | 16 ++++++++++++++++
 t/t3001-ls-files-others-exclude.sh | 10 ++++++++++
 5 files changed, 33 insertions(+), 7 deletions(-)

diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.txt
index eb81d31..4dfe8bd 100644
--- a/Documentation/gitignore.txt
+++ b/Documentation/gitignore.txt
@@ -81,11 +81,11 @@ PATTERN FORMAT
    regular file or a symbolic link `foo` (this is consistent
    with the way how pathspec works in general in git).
=20
- - If the pattern does not contain a slash '/', git treats it as
-   a shell glob pattern and checks for a match against the
-   pathname relative to the location of the `.gitignore` file
-   (relative to the toplevel of the work tree if not from a
-   `.gitignore` file).
+ - If the pattern does not contain a slash '/' nor '**', git
+   treats it as a shell glob pattern and checks for a match
+   against the pathname relative to the location of the
+   `.gitignore` file (relative to the toplevel of the work tree
+   if not from a `.gitignore` file).
=20
  - Otherwise, git treats the pattern as a shell glob suitable
    for consumption by fnmatch(3) with the FNM_PATHNAME flag:
diff --git a/attr.c b/attr.c
index 3fde9fa..634b39c 100644
--- a/attr.c
+++ b/attr.c
@@ -253,7 +253,7 @@ static struct match_attr *parse_attr_line(const cha=
r *line, const char *src,
 		res->pat.pattern =3D p;
 		res->pat.patternlen =3D strlen(p);
 		res->pat.nowildcardlen =3D simple_length(p);
-		if (!strchr(p, '/'))
+		if (!strchr(p, '/') && !strstr(p, "**"))
 			res->pat.flags |=3D EXC_FLAG_NODIR;
 		if (*p =3D=3D '*' && no_wildcard(p+1))
 			res->pat.flags |=3D EXC_FLAG_ENDSWITH;
diff --git a/dir.c b/dir.c
index fd49336..6a5de98 100644
--- a/dir.c
+++ b/dir.c
@@ -340,7 +340,7 @@ void add_exclude(const char *string, const char *ba=
se,
 	x->base =3D base;
 	x->baselen =3D baselen;
 	x->flags =3D flags;
-	if (!strchr(string, '/'))
+	if (!strchr(string, '/') && !strstr(string, "**"))
 		x->flags |=3D EXC_FLAG_NODIR;
 	x->nowildcardlen =3D simple_length(string);
 	if (*string =3D=3D '*' && no_wildcard(string+1))
diff --git a/t/t0003-attributes.sh b/t/t0003-attributes.sh
index 6c3c554..9b534a0 100755
--- a/t/t0003-attributes.sh
+++ b/t/t0003-attributes.sh
@@ -249,4 +249,20 @@ EOF
 	test_line_count =3D 0 err
 '
=20
+test_expect_success '"**" with no slashes test' '
+	echo "a**f foo=3Dbar" >.gitattributes &&
+	cat <<\EOF >expect &&
+f: foo: unspecified
+a/f: foo: bar
+a/b/f: foo: bar
+a/b/c/f: foo: bar
+EOF
+	git check-attr foo -- "f" >actual 2>err &&
+	git check-attr foo -- "a/f" >>actual 2>>err &&
+	git check-attr foo -- "a/b/f" >>actual 2>>err &&
+	git check-attr foo -- "a/b/c/f" >>actual 2>>err &&
+	test_cmp expect actual &&
+	test_line_count =3D 0 err
+'
+
 test_done
diff --git a/t/t3001-ls-files-others-exclude.sh b/t/t3001-ls-files-othe=
rs-exclude.sh
index 67c8bcf..6a5a4ab 100755
--- a/t/t3001-ls-files-others-exclude.sh
+++ b/t/t3001-ls-files-others-exclude.sh
@@ -225,4 +225,14 @@ EOF
 	test_cmp expect actual
 '
=20
+
+test_expect_success 'ls-files with "**" patterns and no slashes' '
+	cat <<\EOF >expect &&
+one/a.1
+one/two/a.1
+EOF
+	git ls-files -o -i --exclude "one**a.1" >actual
+	test_cmp expect actual
+'
+
 test_done
--=20
1.7.12.1.405.gb727dc9
