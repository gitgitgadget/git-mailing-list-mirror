From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 5/5] Support "**" in .gitignore and .gitattributes patterns using wildmatch()
Date: Sun, 16 Sep 2012 22:27:45 +0700
Message-ID: <1347809265-2457-6-git-send-email-pclouds@gmail.com>
References: <1347710524-15404-1-git-send-email-pclouds@gmail.com>
 <1347809265-2457-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 16 17:28:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDGln-0004Aq-KV
	for gcvg-git-2@plane.gmane.org; Sun, 16 Sep 2012 17:28:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752252Ab2IPP2N convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 16 Sep 2012 11:28:13 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:61205 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751389Ab2IPP2L (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Sep 2012 11:28:11 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr13so7881072pbb.19
        for <git@vger.kernel.org>; Sun, 16 Sep 2012 08:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=cgRzgZjlj6+twtmhxKbWcRhdCoMfp/us3HqBO/YZbAo=;
        b=RD93s8fMtNrgvAPRRJ+hI6w5crANdskz1mackizAulKT5OKg0l8r/GF8Xpns3V6WXa
         41bl/elPdWSLsm5mxqcXIMoaFnpzofMqH7qjxcW53dSMU4u8yejlxTorm5GsxeEJfCVn
         cWi0sDbmpjBKn43QrS2IF6o4QQAtqW4zftT+6p0uGP8u77XaJnWOVzm6PMs8meznGz+k
         DYA/XCQ+LN1CaZrqNggH4A4MZ2M7TRim0ebwHniONLmrm/7R14zjF9a/6z6wGZwi4zTu
         UmaFGyofZdf1U4VIMivxQdc4fKseAJDbM15+Iro2bbdAlg0PCUrtpGq9E6BGSrGL4LOl
         yrAg==
Received: by 10.68.240.7 with SMTP id vw7mr16536052pbc.152.1347809291700;
        Sun, 16 Sep 2012 08:28:11 -0700 (PDT)
Received: from lanh ([115.74.50.93])
        by mx.google.com with ESMTPS id it6sm5211656pbc.14.2012.09.16.08.28.08
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 16 Sep 2012 08:28:11 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 16 Sep 2012 22:28:15 +0700
X-Mailer: git-send-email 1.7.12.403.gce5cf6f.dirty
In-Reply-To: <1347809265-2457-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205622>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
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
index 3430faf..2cea18c 100644
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
+	return (ignore_case && iwildmatch(pattern, pathname + baselen)) ||
+		(!ignore_case && wildmatch(pattern, pathname + baselen));
 }
=20
 static int macroexpand_one(int attr_nr, int rem);
diff --git a/dir.c b/dir.c
index 4868339..55ab2b3 100644
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
@@ -575,7 +576,9 @@ int excluded_from_list(const char *pathname,
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
1.7.12.403.gce5cf6f.dirty
