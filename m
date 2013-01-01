From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 06/10] wildmatch: support "no FNM_PATHNAME" mode
Date: Tue,  1 Jan 2013 09:44:07 +0700
Message-ID: <1357008251-10014-7-git-send-email-pclouds@gmail.com>
References: <1357008251-10014-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 01 03:45:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tprql-0000L0-Or
	for gcvg-git-2@plane.gmane.org; Tue, 01 Jan 2013 03:45:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751890Ab3AACos convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 31 Dec 2012 21:44:48 -0500
Received: from mail-da0-f47.google.com ([209.85.210.47]:39694 "EHLO
	mail-da0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751864Ab3AACos (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Dec 2012 21:44:48 -0500
Received: by mail-da0-f47.google.com with SMTP id s35so5937714dak.20
        for <git@vger.kernel.org>; Mon, 31 Dec 2012 18:44:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=T5k0cWyfdJe9DnbjU+2V+vbv19oN8f+PqSymrd+3E9I=;
        b=RRZVj3cqpmngFG+8Pv0t8BiLbqOQvssndBKdo0YJGBh5AnlZoGZz4CB/V1ll6SQNqA
         6lt5t/2xLHqCpBI/TViV7EBpBP1mvvzyQDcyrV+YhFXpwQTsmVCi7jK6Xq3vdBQYEDMl
         nWJ+Nu2U5IDb+Vjw2nAUvdqhJOzDsqH1xNIczL1TgVC28mD+fZqyKzxnHubJ97GumCuz
         KJ47XADuFzBiylJdwd4CzVMwrXGV6OZqD9Y0Bh0E0MnVqGEVuWrfhr/XCDXbviz5Dhn+
         GPWo69/zGE2715JSIMFv3xCwf1j9Niv5x/Y3D6mES3dIzDijTS4wmkZ6PAhGVs9cGcix
         S3dA==
X-Received: by 10.68.213.233 with SMTP id nv9mr131593179pbc.155.1357008287505;
        Mon, 31 Dec 2012 18:44:47 -0800 (PST)
Received: from lanh ([115.74.57.25])
        by mx.google.com with ESMTPS id sk1sm25827481pbc.0.2012.12.31.18.44.43
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 31 Dec 2012 18:44:46 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 01 Jan 2013 09:44:50 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
In-Reply-To: <1357008251-10014-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212389>

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
index af54c83..5c9601a 100755
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
index 1b5bbac..536470b 100644
--- a/wildmatch.c
+++ b/wildmatch.c
@@ -78,14 +78,17 @@ static int dowild(const uchar *p, const uchar *text=
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
-				if ((prev_p < pattern || *prev_p =3D=3D '/') &&
+				if (!(flags & WM_PATHNAME))
+					/* without WM_PATHNAME, '*' =3D=3D '**' */
+					match_slash =3D 1;
+				else if ((prev_p < pattern || *prev_p =3D=3D '/') &&
 				    (*p =3D=3D '\0' || *p =3D=3D '/' ||
 				     (p[0] =3D=3D '\\' && p[1] =3D=3D '/'))) {
 					/*
@@ -104,7 +107,8 @@ static int dowild(const uchar *p, const uchar *text=
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
@@ -215,7 +219,8 @@ static int dowild(const uchar *p, const uchar *text=
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
