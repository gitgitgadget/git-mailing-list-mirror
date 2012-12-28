From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 5/9] wildmatch: support "no FNM_PATHNAME" mode
Date: Fri, 28 Dec 2012 11:10:50 +0700
Message-ID: <1356667854-8686-6-git-send-email-pclouds@gmail.com>
References: <1356667854-8686-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 28 05:12:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ToRIf-0000wl-Om
	for gcvg-git-2@plane.gmane.org; Fri, 28 Dec 2012 05:12:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753319Ab2L1ELn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 27 Dec 2012 23:11:43 -0500
Received: from mail-da0-f49.google.com ([209.85.210.49]:37723 "EHLO
	mail-da0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753199Ab2L1ELm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Dec 2012 23:11:42 -0500
Received: by mail-da0-f49.google.com with SMTP id v40so4587713dad.8
        for <git@vger.kernel.org>; Thu, 27 Dec 2012 20:11:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=KiQASXgGKWF92AGAV50s8wglY8oqrBSMR8nQLVzFLhY=;
        b=CqpeGDrjri/VbZI876NMNyUapE2xAVVoocQe/SeQvKbf/of1zEdME+qDQqx1/LgzAu
         X/qtZenUbhui502Eu4bxFUEH6wuPsRcWQB0SPSuRIfYvaaDqc8zh35JEo1AJEClHiCZV
         GMO91nozvB7Co34AZkM227yeb/mQxGsCgQ1Ke0QgXc80iWVMAhNc8tUM6W3gzRdPTxem
         iA3fExCTCJbVWfrO8WL3HvNZAgwP3R+EJO63maZfG5HEtA9cwE/f4B8VWRdfhBO6oLp8
         rT7Wro5Zp/CUDPuUO1ziX9A/RI4wDZS3+NRz+npucR7ql0sjye4SfbhlGzNP5tVwRqSh
         WLtw==
X-Received: by 10.66.82.162 with SMTP id j2mr95577397pay.13.1356667900877;
        Thu, 27 Dec 2012 20:11:40 -0800 (PST)
Received: from lanh ([115.74.54.149])
        by mx.google.com with ESMTPS id qt3sm18925074pbb.32.2012.12.27.20.11.37
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 27 Dec 2012 20:11:40 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Fri, 28 Dec 2012 11:11:40 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
In-Reply-To: <1356667854-8686-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212228>

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
index 68e4213..0c8edb8 100644
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
+					match_slash =3D 1;
+				else if ((prev_p =3D=3D text || *prev_p =3D=3D '/') ||
 				    (*p =3D=3D '\0' || *p =3D=3D '/' ||
 				     (p[0] =3D=3D '\\' && p[1] =3D=3D '/'))) {
 					/*
@@ -103,7 +106,8 @@ static int dowild(const uchar *p, const uchar *text=
, unsigned int flags)
 				} else
 					return WM_ABORT_MALFORMED;
 			} else
-				match_slash =3D 0;
+				/* without WM_PATHNAME, '*' =3D=3D '**' */
+				match_slash =3D flags & WM_PATHNAME ? 0 : 1;
 			if (*p =3D=3D '\0') {
 				/* Trailing "**" matches everything.  Trailing "*" matches
 				 * only if there are no more slash characters. */
@@ -214,7 +218,8 @@ static int dowild(const uchar *p, const uchar *text=
, unsigned int flags)
 				} else if (t_ch =3D=3D p_ch)
 					matched =3D 1;
 			} while (prev_ch =3D p_ch, (p_ch =3D *++p) !=3D ']');
-			if (matched =3D=3D negated || t_ch =3D=3D '/')
+			if (matched =3D=3D negated ||
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
