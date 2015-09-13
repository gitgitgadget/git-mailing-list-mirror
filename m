From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 2/2] dir.c: don't exclude whole dir prematurely if neg pattern may match
Date: Sun, 13 Sep 2015 08:19:01 +0700
Message-ID: <1442107141-24265-3-git-send-email-pclouds@gmail.com>
References: <1440334214-32131-1-git-send-email-pclouds@gmail.com>
 <1442107141-24265-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 13 03:19:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zavwz-000755-9g
	for gcvg-git-2@plane.gmane.org; Sun, 13 Sep 2015 03:19:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755012AbbIMBTQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 12 Sep 2015 21:19:16 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:36296 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754986AbbIMBS6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Sep 2015 21:18:58 -0400
Received: by padhk3 with SMTP id hk3so108695033pad.3
        for <git@vger.kernel.org>; Sat, 12 Sep 2015 18:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Tt9OVLcxO8wbpHRuwRRrGC8NthxenF9mcBw3p0IOuAM=;
        b=LSHiVkn1kauu81wLuwZsTX0KTOhwf5lZag769SJSIkulmM0rhI5B/q4JUeyQeIghpw
         KdvYL0WP7T1eJN/Bf24dJFqKM7LefXvMjbdHt20RoTZjzJJHP6WWLCCtlmHea/fma34y
         hrISoYez14Qe3cZ9kAV/m9tK3GDH7oEDkTNF5aX4/xaQk57T6TNyvH2/zTfba0KP7Y4s
         t5nMMv9RERTIvW2oIGPXC2ECwzcn8cxwrv6jyigBjDTvLal/Po5zIw9TUux7t11wgO7G
         N6vZTFe9vx5oJfGVnB9IENv9AW78W+sCVRMXwj8ptoYDFvNO6aK693B3p7CNRypyNWKu
         483w==
X-Received: by 10.66.189.69 with SMTP id gg5mr16578482pac.28.1442107138338;
        Sat, 12 Sep 2015 18:18:58 -0700 (PDT)
Received: from lanh ([171.233.230.25])
        by smtp.gmail.com with ESMTPSA id df2sm8049492pad.19.2015.09.12.18.18.55
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Sep 2015 18:18:57 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 13 Sep 2015 08:19:17 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1442107141-24265-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277752>

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
+following conditions must be met:
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
