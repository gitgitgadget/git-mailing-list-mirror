From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v5 12/12] Support "**" wildcard in .gitignore and .gitattributes
Date: Sun, 14 Oct 2012 09:35:10 +0700
Message-ID: <1350182110-25936-13-git-send-email-pclouds@gmail.com>
References: <1350182110-25936-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 14 04:37:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNE4W-00068b-Ro
	for gcvg-git-2@plane.gmane.org; Sun, 14 Oct 2012 04:36:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751427Ab2JNCgq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 13 Oct 2012 22:36:46 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:37467 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751286Ab2JNCgp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Oct 2012 22:36:45 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so3964144pbb.19
        for <git@vger.kernel.org>; Sat, 13 Oct 2012 19:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=9tmCEbNY63PAAFGTSwLiMfaiDMixJTCkqCpmXfVhSfs=;
        b=Xcchc3DCZuXYSqEs1GlsTNiQcQIid2HsymzXaSzO70XHqeuRHCkZ+PiaisSFHd7k8Z
         e8NQcQ2hX6PxQQY6FIpx8iqJG/OXV8N/JbV425Y93kTkgdb1KR/YpD1G2/3fdo5mE0No
         nHEnLBv8gKA8e0jTzFZCKOJ+C2fS14Nr6GlOY+EQtGEgoelf5z5LaazKPLLFDhlkadFL
         3/cVUc5rXUWmWiwmaDCSpIZbmB/XT76AfakeiUsEw8ieZxSX79IPy5kYzvMpViwADrhY
         P1EMV3PWQnc9Dmz4xre8OS9AaXLIFrH6a70ZzgOposdINet4St1v9Z25chdckBkc/e6k
         udhQ==
Received: by 10.68.138.198 with SMTP id qs6mr26080073pbb.151.1350182204785;
        Sat, 13 Oct 2012 19:36:44 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.54.82])
        by mx.google.com with ESMTPS id j9sm6782548pav.15.2012.10.13.19.36.41
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 13 Oct 2012 19:36:43 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun, 14 Oct 2012 09:36:29 +0700
X-Mailer: git-send-email 1.8.0.rc2.11.g2b79d01
In-Reply-To: <1350182110-25936-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207603>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/gitignore.txt        | 19 +++++++++++++++++++
 attr.c                             |  4 +++-
 dir.c                              |  4 +++-
 t/t0003-attributes.sh              | 37 ++++++++++++++++++++++++++++++=
+++++++
 t/t3001-ls-files-others-exclude.sh | 19 +++++++++++++++++++
 5 files changed, 81 insertions(+), 2 deletions(-)

diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.txt
index 1b82fe1..91a6438 100644
--- a/Documentation/gitignore.txt
+++ b/Documentation/gitignore.txt
@@ -108,6 +108,25 @@ PATTERN FORMAT
    For example, "/{asterisk}.c" matches "cat-file.c" but not
    "mozilla-sha1/sha1.c".
=20
+Two consecutive asterisks ("`**`") in patterns matched against
+full pathname may have special meaning:
+
+ - A leading "`**`" followed by a slash means match in all
+   directories. For example, "`**/foo`" matches file or directory
+   "`foo`" anywhere, the same as pattern "`foo`". "**/foo/bar"
+   matches file or directory "`bar`" anywhere that is directly
+   under directory "`foo`".
+
+ - A trailing "/**" matches everything inside. For example,
+   "abc/**" matches all files inside directory "abc", relative
+   to the location of the `.gitignore` file, with infinite depth.
+
+ - A slash followed by two consecutive asterisks then a slash
+   matches zero or more directories. For example, "`a/**/b`"
+   matches "`a/b`", "`a/x/b`", "`a/x/y/b`" and so on.
+
+ - Other consecutive asterisks are considered invalid.
+
 NOTES
 -----
=20
diff --git a/attr.c b/attr.c
index 887a9ae..8010429 100644
--- a/attr.c
+++ b/attr.c
@@ -12,6 +12,7 @@
 #include "exec_cmd.h"
 #include "attr.h"
 #include "dir.h"
+#include "wildmatch.h"
=20
 const char git_attr__true[] =3D "(builtin)true";
 const char git_attr__false[] =3D "\0(builtin)false";
@@ -666,7 +667,8 @@ static int path_matches(const char *pathname, int p=
athlen,
 		return 0;
 	if (baselen !=3D 0)
 		baselen++;
-	return fnmatch_icase(pattern, pathname + baselen, FNM_PATHNAME) =3D=3D=
 0;
+	return wildmatch(pattern, pathname + baselen,
+			 ignore_case ? FNM_CASEFOLD : 0) =3D=3D 0;
 }
=20
 static int macroexpand_one(int attr_nr, int rem);
diff --git a/dir.c b/dir.c
index 4868339..442db1c 100644
--- a/dir.c
+++ b/dir.c
@@ -8,6 +8,7 @@
 #include "cache.h"
 #include "dir.h"
 #include "refs.h"
+#include "wildmatch.h"
=20
 struct path_simplify {
 	int len;
@@ -575,7 +576,8 @@ int excluded_from_list(const char *pathname,
 			namelen -=3D prefix;
 		}
=20
-		if (!namelen || !fnmatch_icase(exclude, name, FNM_PATHNAME))
+		if (!namelen ||
+		    wildmatch(exclude, name, ignore_case ? FNM_CASEFOLD : 0) =3D=3D =
0)
 			return to_exclude;
 	}
 	return -1; /* undecided */
diff --git a/t/t0003-attributes.sh b/t/t0003-attributes.sh
index febc45c..d5a6946 100755
--- a/t/t0003-attributes.sh
+++ b/t/t0003-attributes.sh
@@ -196,6 +196,43 @@ test_expect_success 'root subdir attribute test' '
 	attr_check subdir/a/i unspecified
 '
=20
+test_expect_success '"**" test' '
+	echo "**/f foo=3Dbar" >.gitattributes &&
+	cat <<\EOF >expect &&
+f: foo: bar
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
+test_expect_success '"**" with no slashes test' '
+	echo "a**f foo=3Dbar" >.gitattributes &&
+	git check-attr foo -- "f" >actual &&
+	cat <<\EOF >expect &&
+f: foo: unspecified
+af: foo: bar
+axf: foo: bar
+a/f: foo: unspecified
+a/b/f: foo: unspecified
+a/b/c/f: foo: unspecified
+EOF
+	git check-attr foo -- "f" >actual 2>err &&
+	git check-attr foo -- "af" >>actual 2>err &&
+	git check-attr foo -- "axf" >>actual 2>err &&
+	git check-attr foo -- "a/f" >>actual 2>>err &&
+	git check-attr foo -- "a/b/f" >>actual 2>>err &&
+	git check-attr foo -- "a/b/c/f" >>actual 2>>err &&
+	test_cmp expect actual &&
+	test_line_count =3D 0 err
+'
+
 test_expect_success 'setup bare' '
 	git clone --bare . bare.git &&
 	cd bare.git
diff --git a/t/t3001-ls-files-others-exclude.sh b/t/t3001-ls-files-othe=
rs-exclude.sh
index c8fe978..278315d 100755
--- a/t/t3001-ls-files-others-exclude.sh
+++ b/t/t3001-ls-files-others-exclude.sh
@@ -214,4 +214,23 @@ test_expect_success 'subdirectory ignore (l1)' '
 	test_cmp expect actual
 '
=20
+
+test_expect_success 'ls-files with "**" patterns' '
+	cat <<\EOF >expect &&
+a.1
+one/a.1
+one/two/a.1
+three/a.1
+EOF
+	git ls-files -o -i --exclude "**/a.1" >actual
+	test_cmp expect actual
+'
+
+
+test_expect_success 'ls-files with "**" patterns and no slashes' '
+	: >expect &&
+	git ls-files -o -i --exclude "one**a.1" >actual &&
+	test_cmp expect actual
+'
+
 test_done
--=20
1.8.0.rc2.11.g2b79d01
