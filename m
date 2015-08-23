From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/2] dir.c: don't exclude whole dir prematurely if neg pattern may match
Date: Sun, 23 Aug 2015 19:50:14 +0700
Message-ID: <1440334214-32131-3-git-send-email-pclouds@gmail.com>
References: <1440334214-32131-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 23 14:51:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZTUjq-0007MZ-81
	for gcvg-git-2@plane.gmane.org; Sun, 23 Aug 2015 14:51:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752433AbbHWMu7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 23 Aug 2015 08:50:59 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:34299 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752415AbbHWMuu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Aug 2015 08:50:50 -0400
Received: by padfa11 with SMTP id fa11so4574632pad.1
        for <git@vger.kernel.org>; Sun, 23 Aug 2015 05:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=dH4P3VdJx1mHVLrhRyamMLmLA5CUOFEUoD4OnDSuGoQ=;
        b=0Zjp+6wxYhc4gAHIRXDxyIUH8AVC4qqYkL6p81bDIMj4PkUZng9FhApFXaxeNWnlqV
         2aRCm/W5srIvJOW3zPHxIuPXVLdrydKpo0waGyV4rzULn3Hy5WuKkRbtgrMdeQMBOCyu
         3wFKgiwsVzyBG7v1xXwezfGv4eg6R1F2F1NdcAd5r5Z+EJJdwv8MbtoAK5V3BchvAX6n
         l8sG9Dnp8T24wT8Osgg2fIaDh/Hj76dKaKdGQ95c1ZY52ceP9I2I9c33DgvenIIA76hN
         z5O+6sMJdUXRTnzW5fQxglGX7y17izgDweUQR7vyWOQm+ryYbXKnmJxsc8fqynq1pgjo
         1mRQ==
X-Received: by 10.68.227.8 with SMTP id rw8mr35932327pbc.74.1440334250135;
        Sun, 23 Aug 2015 05:50:50 -0700 (PDT)
Received: from lanh ([171.232.84.126])
        by smtp.gmail.com with ESMTPSA id h16sm13963487pdk.4.2015.08.23.05.50.47
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Aug 2015 05:50:49 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 23 Aug 2015 19:50:48 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1440334214-32131-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276407>

If there is a pattern "!foo/bar", this patch makes it not exclude "foo"
right away. This gives us a chance to examine "foo" and re-include
"foo/bar".

In order for it to detect that the directory under examination should
not be excluded right away, in other words it is a parent directory of =
a
negative pattern, the "directory path" of the negative pattern must be
literal. Patterns like "!f?o/bar" can't stop "foo" from being excluded.

Basename matching (i.e. "no slashes in the pattern") or must-be-dir
matching (i.e. "trailing slash in the pattern") does not work well with
this. For example, if we descend in "foo" and are examining "foo/abc",
current code for "foo/" pattern will check if path "foo/abc", not "foo"=
,
is a directory. The same problem with basename matching. These may need
big code reorg to make it work.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/gitignore.txt        | 21 ++++++++---
 dir.c                              | 76 ++++++++++++++++++++++++++++++=
+++++++-
 t/t3001-ls-files-others-exclude.sh | 20 ++++++++++
 3 files changed, 109 insertions(+), 8 deletions(-)

diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.txt
index 473623d..889a72a 100644
--- a/Documentation/gitignore.txt
+++ b/Documentation/gitignore.txt
@@ -82,12 +82,9 @@ PATTERN FORMAT
=20
  - An optional prefix "`!`" which negates the pattern; any
    matching file excluded by a previous pattern will become
-   included again. It is not possible to re-include a file if a parent
-   directory of that file is excluded. Git doesn't list excluded
-   directories for performance reasons, so any patterns on contained
-   files have no effect, no matter where they are defined.
-   Put a backslash ("`\`") in front of the first "`!`" for patterns
-   that begin with a literal "`!`", for example, "`\!important!.txt`".
+   included again. It is possible to re-include a file if a parent
+   directory of that file is excluded, with restrictions. See section
+   NOTES for detail.
=20
  - If the pattern ends with a slash, it is removed for the
    purpose of the following description, but it would only find
@@ -141,6 +138,18 @@ not tracked by Git remain untracked.
 To stop tracking a file that is currently tracked, use
 'git rm --cached'.
=20
+To re-include a file when its parent directory is excluded, the
+following conditions must match:
+
+ - The directory part in the re-include rules must be literal (i.e. no
+   wildcards)
+
+ - The rules to exclude the parent directory must not end with a
+   trailing slash.
+
+ - The rules to exclude the parent directory must have at least one
+   slash.
+
 EXAMPLES
 --------
=20
diff --git a/dir.c b/dir.c
index 3a7630a..a1f711c 100644
--- a/dir.c
+++ b/dir.c
@@ -882,6 +882,25 @@ int match_pathname(const char *pathname, int pathl=
en,
 		 */
 		if (!patternlen && !namelen)
 			return 1;
+		/*
+		 * This can happen when we ignore some exclude rules
+		 * on directories in other to see if negative rules
+		 * may match. E.g.
+		 *
+		 * /abc
+		 * !/abc/def/ghi
+		 *
+		 * The pattern of interest is "/abc". On the first
+		 * try, we should match path "abc" with this pattern
+		 * in the "if" statement right above, but the caller
+		 * ignores it.
+		 *
+		 * On the second try with paths within "abc",
+		 * e.g. "abc/xyz", we come here and try to match it
+		 * with "/abc".
+		 */
+		if (!patternlen && namelen && *name =3D=3D '/')
+			return 1;
 	}
=20
 	return fnmatch_icase_mem(pattern, patternlen,
@@ -890,6 +909,48 @@ int match_pathname(const char *pathname, int pathl=
en,
 }
=20
 /*
+ * Return non-zero if pathname is a directory and an ancestor of the
+ * literal path in a (negative) pattern. This is used to keep
+ * descending in "foo" and "foo/bar" when the pattern is
+ * "!foo/bar/.gitignore". "foo/notbar" will not be descended however.
+ */
+static int match_neg_path(const char *pathname, int pathlen, int *dtyp=
e,
+			  const char *base, int baselen,
+			  const char *pattern, int prefix, int patternlen,
+			  int flags)
+{
+	assert((flags & EXC_FLAG_NEGATIVE) && !(flags & EXC_FLAG_NODIR));
+
+	if (*dtype =3D=3D DT_UNKNOWN)
+		*dtype =3D get_dtype(NULL, pathname, pathlen);
+	if (*dtype !=3D DT_DIR)
+		return 0;
+
+	if (*pattern =3D=3D '/') {
+		pattern++;
+		patternlen--;
+		prefix--;
+	}
+
+	if (baselen) {
+		if (((pathlen < baselen && base[pathlen] =3D=3D '/') ||
+		     pathlen =3D=3D baselen) &&
+		    !strncmp_icase(pathname, base, pathlen))
+			return 1;
+		pathname +=3D baselen + 1;
+		pathlen  -=3D baselen + 1;
+	}
+
+
+	if (prefix &&
+	    ((pathlen < prefix && pattern[pathlen] =3D=3D '/') &&
+	     !strncmp_icase(pathname, pattern, pathlen)))
+		return 1;
+
+	return 0;
+}
+
+/*
  * Scan the given exclude list in reverse to see whether pathname
  * should be ignored.  The first match (i.e. the last on the list), if
  * any, determines the fate.  Returns the exclude_list element which
@@ -902,7 +963,7 @@ static struct exclude *last_exclude_matching_from_l=
ist(const char *pathname,
 						       struct exclude_list *el)
 {
 	struct exclude *exc =3D NULL; /* undecided */
-	int i;
+	int i, matched_negative_path =3D 0;
=20
 	if (!el->nr)
 		return NULL;	/* undefined */
@@ -937,7 +998,18 @@ static struct exclude *last_exclude_matching_from_=
list(const char *pathname,
 			exc =3D x;
 			break;
 		}
-	}
+
+		if ((x->flags & EXC_FLAG_NEGATIVE) && !matched_negative_path &&
+		    match_neg_path(pathname, pathlen, dtype, x->base,
+				   x->baselen ? x->baselen - 1 : 0,
+				   exclude, prefix, x->patternlen, x->flags))
+			matched_negative_path =3D 1;
+	}
+	if (exc &&
+	    !(exc->flags & EXC_FLAG_NEGATIVE) &&
+	    !(exc->flags & EXC_FLAG_NODIR) &&
+	    matched_negative_path)
+		exc =3D NULL;
 	return exc;
 }
=20
diff --git a/t/t3001-ls-files-others-exclude.sh b/t/t3001-ls-files-othe=
rs-exclude.sh
index 3fc484e..9de49a6 100755
--- a/t/t3001-ls-files-others-exclude.sh
+++ b/t/t3001-ls-files-others-exclude.sh
@@ -305,4 +305,24 @@ test_expect_success 'ls-files with "**" patterns a=
nd no slashes' '
 	test_cmp expect actual
 '
=20
+test_expect_success 'negative patterns' '
+	git init reinclude &&
+	(
+		cd reinclude &&
+		cat >.gitignore <<-\EOF &&
+		/foo
+		!foo/bar/bar
+		EOF
+		mkdir -p foo/bar &&
+		touch abc foo/def foo/bar/ghi foo/bar/bar &&
+		git ls-files -o --exclude-standard >../actual &&
+		cat >../expected <<-\EOF &&
+		.gitignore
+		abc
+		foo/bar/bar
+		EOF
+		test_cmp ../expected ../actual
+	)
+'
+
 test_done
--=20
2.3.0.rc1.137.g477eb31
