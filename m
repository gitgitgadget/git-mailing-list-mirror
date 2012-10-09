From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 8/8] Support "**" wildcard in .gitignore and .gitattributes
Date: Tue,  9 Oct 2012 10:09:07 +0700
Message-ID: <1349752147-13314-9-git-send-email-pclouds@gmail.com>
References: <1349752147-13314-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 09 05:10:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLQD3-0006Lj-6l
	for gcvg-git-2@plane.gmane.org; Tue, 09 Oct 2012 05:10:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751228Ab2JIDKH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Oct 2012 23:10:07 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:52676 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753163Ab2JIDKF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Oct 2012 23:10:05 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so4552787pad.19
        for <git@vger.kernel.org>; Mon, 08 Oct 2012 20:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=MzeIIKBbgPaJZjuLQCCmUjHYg3RIsTKCPAPYptpE6cQ=;
        b=R4xjgp4LyFDTFbv0LqNxi8pTaEb2GeCg0JsFpxGgn6VaTodLUoMg3v2YevK4XNZQLv
         9txIrX1AEvlnXFQcjHKbHck69ZHFnSqye8rtIKJPo0C20tlwqEzjEBY1N9D/OFMfwsM0
         JCS6vmEwvRjyCCIcPJCGqvDYxgbW3u05T08Hgp2H+Gg15RiZL+jcaUSP7z/c43T6AAO3
         1SfRmdtexD/Y7neTVk4o0fdHfYMtLHz+KThqp8LIfcI/9amn9bN6wGQ9rCObFdDx9Gj7
         HAIPtpSyelzh+iV9QO9uNCfMt4uBpNYtTNDEt7+jmn79Hmm5sQLIQqLIVjuj4hJHShPO
         QidQ==
Received: by 10.68.202.6 with SMTP id ke6mr58804764pbc.82.1349752204471;
        Mon, 08 Oct 2012 20:10:04 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id o5sm6969472paz.32.2012.10.08.20.10.01
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 08 Oct 2012 20:10:03 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Tue, 09 Oct 2012 10:09:58 +0700
X-Mailer: git-send-email 1.8.0.rc0.29.g1fdd78f
In-Reply-To: <1349752147-13314-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207295>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/gitignore.txt        | 19 +++++++++++++++++++
 attr.c                             |  4 +++-
 dir.c                              |  4 +++-
 t/t0003-attributes.sh              | 38 ++++++++++++++++++++++++++++++=
++++++++
 t/t3001-ls-files-others-exclude.sh | 19 +++++++++++++++++++
 5 files changed, 82 insertions(+), 2 deletions(-)

diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.txt
index 96639e0..5a9c9f7 100644
--- a/Documentation/gitignore.txt
+++ b/Documentation/gitignore.txt
@@ -104,6 +104,25 @@ PATTERN FORMAT
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
+   "abc/**" is equivalent to "`/abc/`".
+
+ - A slash followed by two consecutive asterisks then a slash
+   matches zero or more directories. For example, "`a/**/b`"
+   matches "`a/b`", "`a/x/b`", "`a/x/y/b`" and so on.
+
+ - Consecutive asterisks otherwise are treated like normal
+   asterisk wildcards.
+
 NOTES
 -----
=20
diff --git a/attr.c b/attr.c
index 887a9ae..e85e5ed 100644
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
+			 ignore_case ? FNM_CASEFOLD : 0);
 }
=20
 static int macroexpand_one(int attr_nr, int rem);
diff --git a/dir.c b/dir.c
index 4868339..dc721c0 100644
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
+		    wildmatch(exclude, name, ignore_case ? FNM_CASEFOLD : 0))
 			return to_exclude;
 	}
 	return -1; /* undecided */
diff --git a/t/t0003-attributes.sh b/t/t0003-attributes.sh
index febc45c..67a5694 100755
--- a/t/t0003-attributes.sh
+++ b/t/t0003-attributes.sh
@@ -232,4 +232,42 @@ test_expect_success 'bare repository: test info/at=
tributes' '
 	attr_check subdir/a/i unspecified
 '
=20
+test_expect_success '"**" test' '
+	cd .. &&
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
 test_done
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
1.8.0.rc0.29.g1fdd78f
