From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 09/10] Support "**" in .gitignore and .gitattributes patterns using wildmatch()
Date: Fri,  5 Oct 2012 11:41:08 +0700
Message-ID: <1349412069-627-10-git-send-email-pclouds@gmail.com>
References: <1349412069-627-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 05 09:43:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TK2ZH-0006Oq-Hs
	for gcvg-git-2@plane.gmane.org; Fri, 05 Oct 2012 09:43:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752908Ab2JEHnW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Oct 2012 03:43:22 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:38105 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752773Ab2JEHnV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Oct 2012 03:43:21 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so1407983pad.19
        for <git@vger.kernel.org>; Fri, 05 Oct 2012 00:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=IlzOox5PHgCXRRntr4oZpzo4Wd0FC30qOS22042tUYw=;
        b=jBBxx9pZpef/r9n5YdRJzVGTXlindO+yM8jj0kDDIAvcfqhvSJ2IouTj45UL0F19iu
         NQJ6DJb4ADAnwBdV53EWHHzLi2J7OUZFsBKVDmEGeGKht/91nlCxX5LMJNMyvdAryUb2
         VBGM0hhXPd0sFY1lPISz2SpBgklcomfgRNJamGA9gsLkGWd/KvYjbU+BtUHjbKng3Bb/
         IG8GWjOgUAggpiVa+Sm48H4ERwp9iI5xWdc/gXa2MStPrpQBWJVgeX8ikGFnko6gsQkO
         25+XYTEkv7EkMaAiZPxixYqFbCg0Zl1K7IM0DcTlE8iB/rNVUTjSF7ARNKq4rzGUo30a
         ZQaw==
Received: by 10.68.232.163 with SMTP id tp3mr27517964pbc.44.1349412129176;
        Thu, 04 Oct 2012 21:42:09 -0700 (PDT)
Received: from tre ([115.74.45.10])
        by mx.google.com with ESMTPS id j10sm5380522pax.4.2012.10.04.21.42.06
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 04 Oct 2012 21:42:08 -0700 (PDT)
Received: by tre (sSMTP sendmail emulation); Fri, 05 Oct 2012 11:42:17 +0700
X-Mailer: git-send-email 1.7.10.1.641.g9354186
In-Reply-To: <1349412069-627-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207091>

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
index 1aa058e..3103c66 100644
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
@@ -709,7 +710,8 @@ static int path_matches(const char *pathname, int p=
athlen,
 	if (!namelen || prefix > namelen)
 		return 0;
=20
-	return fnmatch_icase(pattern, name, FNM_PATHNAME) =3D=3D 0;
+	return (ignore_case && iwildmatch(pattern, name)) ||
+		(!ignore_case && wildmatch(pattern, name));
 }
=20
 static int macroexpand_one(int attr_nr, int rem);
diff --git a/dir.c b/dir.c
index c6a0275..cb78273 100644
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
@@ -600,7 +601,9 @@ int excluded_from_list(const char *pathname,
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
1.7.12.1.405.gb727dc9
