From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 13/13] Support "**" wildcard in .gitignore and .gitattributes
Date: Mon, 15 Oct 2012 13:26:02 +0700
Message-ID: <1350282362-4505-13-git-send-email-pclouds@gmail.com>
References: <1350282212-4270-1-git-send-email-pclouds@gmail.com>
 <1350282362-4505-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 15 08:28:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNe9k-0008WT-SQ
	for gcvg-git-2@plane.gmane.org; Mon, 15 Oct 2012 08:28:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753994Ab2JOG1y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Oct 2012 02:27:54 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:39239 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754000Ab2JOG1x (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2012 02:27:53 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so4542541pad.19
        for <git@vger.kernel.org>; Sun, 14 Oct 2012 23:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=A2MxFWuR3VRIkGdTBfDu5oJtKBn/iS9dBYVTD2wf2ZU=;
        b=BNR6vTQFVreYXNsDP6MaeRqcU0Is+DXc/TNQOvjVmwj5ewxTqik4P/u7/VNT0RkT8n
         UNX6rvWi6OmNCB2a/UFwacgV6U5CvDgoGQY1e9lTaEdYd/eBS97kLLRT4nR6VhSUwCUU
         1OqXDX3CtYH97UMRVlKkQIKOcA/n3x9xkJ2hS9XsUZW0J7jzY55GLFI5KvewI2wNt3fR
         6367zEdSUIve6H6ugmsT7SyQSifmiB5XEwdRAhuHZihMrGEiaPjbOnuGnCt85UzXsTYT
         M4f4IcAyPiO1om2PUWNby6P+I0v/bh8BlKIa/Qd0zbv9T3zHCkzAdjVVzqAqNie1Hcs5
         /qLw==
Received: by 10.66.77.74 with SMTP id q10mr30181035paw.81.1350282473758;
        Sun, 14 Oct 2012 23:27:53 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id j9sm8592384pav.15.2012.10.14.23.27.50
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 14 Oct 2012 23:27:52 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 15 Oct 2012 13:27:44 +0700
X-Mailer: git-send-email 1.8.0.rc0.29.g1fdd78f
In-Reply-To: <1350282362-4505-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207711>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/gitignore.txt        | 19 +++++++++++++++++++
 dir.c                              |  4 +++-
 t/t0003-attributes.sh              | 37 ++++++++++++++++++++++++++++++=
+++++++
 t/t3001-ls-files-others-exclude.sh | 18 ++++++++++++++++++
 4 files changed, 77 insertions(+), 1 deletion(-)

diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.txt
index 2e7328b..d4747ce 100644
--- a/Documentation/gitignore.txt
+++ b/Documentation/gitignore.txt
@@ -96,6 +96,25 @@ PATTERN FORMAT
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
diff --git a/dir.c b/dir.c
index ee8e711..cb7328b 100644
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
@@ -593,7 +594,8 @@ int match_pathname(const char *pathname, int pathle=
n,
 		namelen -=3D prefix;
 	}
=20
-	return fnmatch_icase(pattern, name, FNM_PATHNAME) =3D=3D 0;
+	return wildmatch(pattern, name,
+			 ignore_case ? FNM_CASEFOLD : 0) =3D=3D 0;
 }
=20
 /* Scan the list and let the last match determine the fate.
diff --git a/t/t0003-attributes.sh b/t/t0003-attributes.sh
index f6c21ea..c962403 100755
--- a/t/t0003-attributes.sh
+++ b/t/t0003-attributes.sh
@@ -216,6 +216,43 @@ test_expect_success 'patterns starting with exclam=
ation' '
 	attr_check "!f" foo
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
index dc2f045..efb7ebc 100755
--- a/t/t3001-ls-files-others-exclude.sh
+++ b/t/t3001-ls-files-others-exclude.sh
@@ -220,4 +220,22 @@ test_expect_success 'pattern matches prefix comple=
tely' '
 	test_cmp expect actual
 '
=20
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
1.8.0.rc0.29.g1fdd78f
