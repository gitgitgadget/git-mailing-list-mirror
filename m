From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 5/5] Support "**" in .gitignore and .gitattributes patterns using wildmatch()
Date: Wed, 26 Sep 2012 18:25:41 +0700
Message-ID: <1348658741-8146-6-git-send-email-pclouds@gmail.com>
References: <1348658741-8146-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 26 13:35:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGptS-0005u5-0m
	for gcvg-git-2@plane.gmane.org; Wed, 26 Sep 2012 13:35:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754937Ab2IZLe5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 26 Sep 2012 07:34:57 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:33242 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752725Ab2IZLe4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Sep 2012 07:34:56 -0400
Received: by padhz1 with SMTP id hz1so381907pad.19
        for <git@vger.kernel.org>; Wed, 26 Sep 2012 04:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=hDi/k7u7S+Bkb5hBXoV6KPu80G0QxHe+89Ng1ObPHic=;
        b=Q+WN7TDhfrhToGR+hS+71FjRK66ynnicHOV71958GRf0v+k2/drnmtEz3INeIf53tT
         6G+48kkBKgWRL4Hy2pKZnZ5L6aPf0zhXwhaym16HqxlWqBwu+VYotv3kvMMNGMSaxzx5
         Zmhx+TamahK3UedT9vCHe2snLwOGV6O+CUhQBbJYovQgWTuPrcoTePg0d+bFQD+q2/mt
         xAkzKwSTftfmZt16EqNasyiK4skiTEiUVugiiO1kZGD4nvvHZhAzP+yaHpzXvbqDvHgb
         t/WXqemNKob6jH5Ead7EzcCf3o9F5TS2Nz5apAJyYud/svXzqnhnRHi5M4SelwQ9pEYl
         tBQw==
Received: by 10.68.224.69 with SMTP id ra5mr1584993pbc.114.1348659295925;
        Wed, 26 Sep 2012 04:34:55 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.51.2])
        by mx.google.com with ESMTPS id i2sm1784855pay.31.2012.09.26.04.34.53
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 26 Sep 2012 04:34:55 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 26 Sep 2012 18:28:05 +0700
X-Mailer: git-send-email 1.7.12.1.406.g6ab07c4
In-Reply-To: <1348658741-8146-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206411>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/gitignore.txt        |  3 +++
 attr.c                             |  4 +++-
 dir.c                              |  5 ++++-
 t/t0003-attributes.sh              | 17 +++++++++++++++++
 t/t3001-ls-files-others-exclude.sh | 11 +++++++++++
 5 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.txt
index c1f692a..eb81d31 100644
--- a/Documentation/gitignore.txt
+++ b/Documentation/gitignore.txt
@@ -93,6 +93,9 @@ PATTERN FORMAT
    For example, "Documentation/{asterisk}.html" matches
    "Documentation/git.html" but not "Documentation/ppc/ppc.html"
    or "tools/perf/Documentation/perf.html".
++
+Contrary to fnmatch(3), git matches "**" to anything including
+slashes, similar to rsync(1).
=20
  - A leading slash matches the beginning of the pathname.
    For example, "/{asterisk}.c" matches "cat-file.c" but not
diff --git a/attr.c b/attr.c
index b52efb5..15ebaa1 100644
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
@@ -663,7 +664,8 @@ static int path_matches(const char *pathname, int p=
athlen,
 		return 0;
 	if (baselen !=3D 0)
 		baselen++;
-	return fnmatch_icase(pattern, pathname + baselen, FNM_PATHNAME) =3D=3D=
 0;
+	return (ignore_case && iwildmatch(pattern, pathname + baselen)) ||
+		(!ignore_case && wildmatch(pattern, pathname + baselen));
 }
=20
 static int macroexpand_one(int attr_nr, int rem);
diff --git a/dir.c b/dir.c
index 240bf0c..92cda82 100644
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
@@ -573,7 +574,9 @@ int excluded_from_list(const char *pathname,
 			namelen -=3D prefix;
 		}
=20
-		if (!namelen || !fnmatch_icase(exclude, name, FNM_PATHNAME))
+		if (!namelen ||
+		    ((ignore_case && iwildmatch(exclude, name)) ||
+		     (!ignore_case && wildmatch(exclude, name))))
 			return to_exclude;
 	}
 	return -1; /* undecided */
diff --git a/t/t0003-attributes.sh b/t/t0003-attributes.sh
index febc45c..6c3c554 100755
--- a/t/t0003-attributes.sh
+++ b/t/t0003-attributes.sh
@@ -232,4 +232,21 @@ test_expect_success 'bare repository: test info/at=
tributes' '
 	attr_check subdir/a/i unspecified
 '
=20
+test_expect_success '"**" test' '
+	cd .. &&
+	echo "**/f foo=3Dbar" >.gitattributes &&
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
index c8fe978..67c8bcf 100755
--- a/t/t3001-ls-files-others-exclude.sh
+++ b/t/t3001-ls-files-others-exclude.sh
@@ -214,4 +214,15 @@ test_expect_success 'subdirectory ignore (l1)' '
 	test_cmp expect actual
 '
=20
+
+test_expect_success 'ls-files with "**" patterns' '
+	cat <<\EOF >expect &&
+one/a.1
+one/two/a.1
+three/a.1
+EOF
+	git ls-files -o -i --exclude "**/a.1" >actual
+	test_cmp expect actual
+'
+
 test_done
--=20
1.7.12.1.406.g6ab07c4
