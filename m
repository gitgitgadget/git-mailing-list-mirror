From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 4/8] wildmatch: support "no FNM_PATHNAME" mode
Date: Sat, 22 Dec 2012 14:57:04 +0700
Message-ID: <1356163028-29967-5-git-send-email-pclouds@gmail.com>
References: <1356163028-29967-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 22 08:58:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TmJyB-0008UB-La
	for gcvg-git-2@plane.gmane.org; Sat, 22 Dec 2012 08:58:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751182Ab2LVH5r convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 22 Dec 2012 02:57:47 -0500
Received: from mail-pb0-f53.google.com ([209.85.160.53]:49643 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751144Ab2LVH5m (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Dec 2012 02:57:42 -0500
Received: by mail-pb0-f53.google.com with SMTP id jt11so3146207pbb.40
        for <git@vger.kernel.org>; Fri, 21 Dec 2012 23:57:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=jgF1SIq3W9wUwbDgngUVSXbS8+Ec1Hb1SiTLrBi/eNA=;
        b=08L35QY7/c7zzow6F5T4LM+FzSaWPZgB6PHc+SPhIsJvJ4RoK7Xhag4giSe+ub7qeZ
         FCyu1HXK9Pv7s3dTcgyprqcGirOVmhecA0Wiqg3gUmFTXamqNwICwecLxIyNvume4Qdq
         I1F/BwfNyI1qpTb7xJHtJjiqEe5f2IyQnJb0FABE1k0ESUb6ZC7px5ZDVNOINkuDQQj3
         KnrlbxBn88XTCjVNI3PDP2jamA5qc+y/aLSlxiYPMvhipUilQwoycULWecku0vw/f5ff
         /h4qyHVN7NJoS/pWFca6eZI0ndhM+HN9cOlh153UbGfFrZdUl1UaVmcn6Mn+Y6hkGoRE
         RC7A==
X-Received: by 10.68.230.200 with SMTP id ta8mr46547045pbc.13.1356163061993;
        Fri, 21 Dec 2012 23:57:41 -0800 (PST)
Received: from lanh ([115.74.46.73])
        by mx.google.com with ESMTPS id f5sm8859298pav.22.2012.12.21.23.57.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 21 Dec 2012 23:57:41 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 22 Dec 2012 14:57:36 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
In-Reply-To: <1356163028-29967-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212029>

So far, wildmatch() has always honoured directory boundary and there
was no way to turn it off. Make it behave more like fnmatch() by
requiring all callers that want the FNM_PATHNAME behaviour to pass
that in the equivalent flag WM_PATHNAME. Callers that do not specify
WM_PATHNAME will get wildcards like ? and * in their patterns matched
against '/', just like not passing FNM_PATHNAME to fnmatch().

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 dir.c                |  2 +-
 t/t3070-wildmatch.sh | 27 +++++++++++++++++++++++++++
 test-wildmatch.c     |  6 ++++--
 wildmatch.c          | 13 +++++++++----
 wildmatch.h          |  1 +
 5 files changed, 42 insertions(+), 7 deletions(-)

diff --git a/dir.c b/dir.c
index 175a182..6ef0396 100644
--- a/dir.c
+++ b/dir.c
@@ -595,7 +595,7 @@ int match_pathname(const char *pathname, int pathle=
n,
 	}
=20
 	return wildmatch(pattern, name,
-			 ignore_case ? WM_CASEFOLD : 0,
+			 WM_PATHNAME | (ignore_case ? WM_CASEFOLD : 0),
 			 NULL) =3D=3D 0;
 }
=20
diff --git a/t/t3070-wildmatch.sh b/t/t3070-wildmatch.sh
index d5bafef..dbfa903 100755
--- a/t/t3070-wildmatch.sh
+++ b/t/t3070-wildmatch.sh
@@ -29,6 +29,18 @@ match() {
     fi
 }
=20
+pathmatch() {
+    if [ $1 =3D 1 ]; then
+	test_expect_success "pathmatch:    match '$2' '$3'" "
+	    test-wildmatch pathmatch '$2' '$3'
+	"
+    else
+	test_expect_success "pathmatch: no match '$2' '$3'" "
+	    ! test-wildmatch pathmatch '$2' '$3'
+	"
+    fi
+}
+
 # Basic wildmat features
 match 1 1 foo foo
 match 0 0 foo bar
@@ -192,4 +204,19 @@ match 0 0 'XXX/adobe/courier/bold/o/normal//12/120=
/75/75/X/70/iso8859/1' 'XXX/*/
 match 1 0 'abcd/abcdefg/abcdefghijk/abcdefghijklmnop.txt' '**/*a*b*g*n=
*t'
 match 0 0 'abcd/abcdefg/abcdefghijk/abcdefghijklmnop.txtz' '**/*a*b*g*=
n*t'
=20
+pathmatch 1 foo foo
+pathmatch 0 foo fo
+pathmatch 1 foo/bar foo/bar
+pathmatch 1 foo/bar 'foo/*'
+pathmatch 1 foo/bba/arr 'foo/*'
+pathmatch 1 foo/bba/arr 'foo/**'
+pathmatch 1 foo/bba/arr 'foo*'
+pathmatch 1 foo/bba/arr 'foo**'
+pathmatch 1 foo/bba/arr 'foo/*arr'
+pathmatch 1 foo/bba/arr 'foo/**arr'
+pathmatch 0 foo/bba/arr 'foo/*z'
+pathmatch 0 foo/bba/arr 'foo/**z'
+pathmatch 1 foo/bar 'foo?bar'
+pathmatch 1 foo/bar 'foo[/]bar'
+
 test_done
diff --git a/test-wildmatch.c b/test-wildmatch.c
index 4bb23b4..a5f4833 100644
--- a/test-wildmatch.c
+++ b/test-wildmatch.c
@@ -12,9 +12,11 @@ int main(int argc, char **argv)
 			argv[i] +=3D 3;
 	}
 	if (!strcmp(argv[1], "wildmatch"))
-		return !!wildmatch(argv[3], argv[2], 0, NULL);
+		return !!wildmatch(argv[3], argv[2], WM_PATHNAME, NULL);
 	else if (!strcmp(argv[1], "iwildmatch"))
-		return !!wildmatch(argv[3], argv[2], WM_CASEFOLD, NULL);
+		return !!wildmatch(argv[3], argv[2], WM_PATHNAME | WM_CASEFOLD, NULL=
);
+	else if (!strcmp(argv[1], "pathmatch"))
+		return !!wildmatch(argv[3], argv[2], 0, NULL);
 	else if (!strcmp(argv[1], "fnmatch"))
 		return !!fnmatch(argv[3], argv[2], FNM_PATHNAME);
 	else
diff --git a/wildmatch.c b/wildmatch.c
index a79f97e..4fe1d65 100644
--- a/wildmatch.c
+++ b/wildmatch.c
@@ -77,14 +77,17 @@ static int dowild(const uchar *p, const uchar *text=
, unsigned int flags)
 			continue;
 		case '?':
 			/* Match anything but '/'. */
-			if (t_ch =3D=3D '/')
+			if ((flags & WM_PATHNAME) && t_ch =3D=3D '/')
 				return WM_NOMATCH;
 			continue;
 		case '*':
 			if (*++p =3D=3D '*') {
 				const uchar *prev_p =3D p - 2;
 				while (*++p =3D=3D '*') {}
-				if ((prev_p =3D=3D text || *prev_p =3D=3D '/') ||
+				if (!(flags & WM_PATHNAME))
+					/* without WM_PATHNAME, '*' =3D=3D '**' */
+					special =3D 1;
+				else if ((prev_p =3D=3D text || *prev_p =3D=3D '/') ||
 				    (*p =3D=3D '\0' || *p =3D=3D '/' ||
 				     (p[0] =3D=3D '\\' && p[1] =3D=3D '/'))) {
 					/*
@@ -103,7 +106,8 @@ static int dowild(const uchar *p, const uchar *text=
, unsigned int flags)
 				} else
 					return WM_ABORT_MALFORMED;
 			} else
-				special =3D 0;
+				/* without WM_PATHNAME, '*' =3D=3D '**' */
+				special =3D flags & WM_PATHNAME ? 0 : 1;
 			if (*p =3D=3D '\0') {
 				/* Trailing "**" matches everything.  Trailing "*" matches
 				 * only if there are no more slash characters. */
@@ -214,7 +218,8 @@ static int dowild(const uchar *p, const uchar *text=
, unsigned int flags)
 				} else if (t_ch =3D=3D p_ch)
 					matched =3D 1;
 			} while (prev_ch =3D p_ch, (p_ch =3D *++p) !=3D ']');
-			if (matched =3D=3D special || t_ch =3D=3D '/')
+			if (matched =3D=3D special ||
+			    ((flags & WM_PATHNAME) && t_ch =3D=3D '/'))
 				return WM_NOMATCH;
 			continue;
 		}
diff --git a/wildmatch.h b/wildmatch.h
index 1c814fd..4090c8f 100644
--- a/wildmatch.h
+++ b/wildmatch.h
@@ -2,6 +2,7 @@
 #define WILDMATCH_H
=20
 #define WM_CASEFOLD 1
+#define WM_PATHNAME 2
=20
 #define WM_ABORT_MALFORMED 2
 #define WM_NOMATCH 1
--=20
1.8.0.rc2.23.g1fb49df
