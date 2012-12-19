From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/3] wildmatch: support "no FNM_PATHNAME" mode
Date: Wed, 19 Dec 2012 20:08:07 +0700
Message-ID: <1355922488-20976-3-git-send-email-pclouds@gmail.com>
References: <1355922488-20976-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 19 14:33:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TlJlm-0007e3-M8
	for gcvg-git-2@plane.gmane.org; Wed, 19 Dec 2012 14:33:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755292Ab2LSNcx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 Dec 2012 08:32:53 -0500
Received: from mail-pb0-f42.google.com ([209.85.160.42]:51428 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755262Ab2LSNcw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Dec 2012 08:32:52 -0500
X-Greylist: delayed 1502 seconds by postgrey-1.27 at vger.kernel.org; Wed, 19 Dec 2012 08:32:51 EST
Received: by mail-pb0-f42.google.com with SMTP id rp2so1227417pbb.1
        for <git@vger.kernel.org>; Wed, 19 Dec 2012 05:32:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=2STrS83Wq4fBlOULTtSduSrJgsW/9Xg5+m5CBKieTnA=;
        b=NjUKsaJPl4wbdP5rCoBHary2x1FhBIi4ATHDURS5pwEmkKDBtl5TFUnizyu6ykOVLA
         pu8pBiUercqxaUz8SMFVRB1S6xTcfRVqjzMfQcDBEDDyjEDu5xf2UQug1+hdHaO4YajW
         XbUp+s0Ct43yAyLW243raReWlxg+EFtnz2IiSDSQae0PQmD8ayDZZDONKgowhiySxdls
         BXkYCAFg/z6WkDek2tdeYUqkUBUzXL9r6CfEKWHj/jt70ZkG8wVpM6j+1AAn7Ktgf0dV
         2zB9TOZdKSYn2XeMfXMoGt1e30y0qtAA8Ya7jHvSYvfz+DhYOeuiOpt0gzyyB0UGt8dg
         H+AA==
X-Received: by 10.68.220.6 with SMTP id ps6mr18404433pbc.80.1355922475623;
        Wed, 19 Dec 2012 05:07:55 -0800 (PST)
Received: from lanh ([115.74.42.11])
        by mx.google.com with ESMTPS id mz10sm3098073pbc.37.2012.12.19.05.07.52
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 19 Dec 2012 05:07:55 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Wed, 19 Dec 2012 20:08:36 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
In-Reply-To: <1355922488-20976-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211825>

By default wildmatch(,, 0) is equivalent with fnmatch(,, FNM_PATHNAME).

This patch makes wildmatch behave more like fnmatch: FNM_PATHNAME
behavior is always applied when FNM_PATHNAME is passed to
wildmatch. Without FNM_PATHNAME, wildmatch accepts '/' in '?' and '[]'
and treats '*' like '**' in the original version.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 The choice of name "pathspec" is not good. I couldn't think of
 anything appropriate and just did not care enough at this point.

 dir.c                |  2 +-
 t/t3070-wildmatch.sh | 27 +++++++++++++++++++++++++++
 test-wildmatch.c     |  4 +++-
 wildmatch.c          | 12 ++++++++----
 4 files changed, 39 insertions(+), 6 deletions(-)

diff --git a/dir.c b/dir.c
index cb7328b..7bbd6f8 100644
--- a/dir.c
+++ b/dir.c
@@ -595,7 +595,7 @@ int match_pathname(const char *pathname, int pathle=
n,
 	}
=20
 	return wildmatch(pattern, name,
-			 ignore_case ? FNM_CASEFOLD : 0) =3D=3D 0;
+			 FNM_PATHNAME | (ignore_case ? FNM_CASEFOLD : 0)) =3D=3D 0;
 }
=20
 /* Scan the list and let the last match determine the fate.
diff --git a/t/t3070-wildmatch.sh b/t/t3070-wildmatch.sh
index 3155eab..ca4ac46 100755
--- a/t/t3070-wildmatch.sh
+++ b/t/t3070-wildmatch.sh
@@ -29,6 +29,18 @@ match() {
     fi
 }
=20
+pathspec() {
+    if [ $1 =3D 1 ]; then
+	test_expect_success "pathspec:    match '$2' '$3'" "
+	    test-wildmatch pathspec '$2' '$3'
+	"
+    else
+	test_expect_success "pathspec: no match '$2' '$3'" "
+	    ! test-wildmatch pathspec '$2' '$3'
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
+pathspec 1 foo foo
+pathspec 0 foo fo
+pathspec 1 foo/bar foo/bar
+pathspec 1 foo/bar 'foo/*'
+pathspec 1 foo/bba/arr 'foo/*'
+pathspec 1 foo/bba/arr 'foo/**'
+pathspec 1 foo/bba/arr 'foo*'
+pathspec 1 foo/bba/arr 'foo**'
+pathspec 1 foo/bba/arr 'foo/*arr'
+pathspec 1 foo/bba/arr 'foo/**arr'
+pathspec 0 foo/bba/arr 'foo/*z'
+pathspec 0 foo/bba/arr 'foo/**z'
+pathspec 1 foo/bar 'foo?bar'
+pathspec 1 foo/bar 'foo[/]bar'
+
 test_done
diff --git a/test-wildmatch.c b/test-wildmatch.c
index e384c8e..7fefa4f 100644
--- a/test-wildmatch.c
+++ b/test-wildmatch.c
@@ -12,9 +12,11 @@ int main(int argc, char **argv)
 			argv[i] +=3D 3;
 	}
 	if (!strcmp(argv[1], "wildmatch"))
+		return !!wildmatch(argv[3], argv[2], FNM_PATHNAME);
+	else if (!strcmp(argv[1], "pathspec"))
 		return !!wildmatch(argv[3], argv[2], 0);
 	else if (!strcmp(argv[1], "iwildmatch"))
-		return !!wildmatch(argv[3], argv[2], FNM_CASEFOLD);
+		return !!wildmatch(argv[3], argv[2], FNM_PATHNAME | FNM_CASEFOLD);
 	else if (!strcmp(argv[1], "fnmatch"))
 		return !!fnmatch(argv[3], argv[2], FNM_PATHNAME);
 	else
diff --git a/wildmatch.c b/wildmatch.c
index 9586ed9..6aa034f 100644
--- a/wildmatch.c
+++ b/wildmatch.c
@@ -80,14 +80,17 @@ static int dowild(const uchar *p, const uchar *text=
, int flags)
 			continue;
 		case '?':
 			/* Match anything but '/'. */
-			if (t_ch =3D=3D '/')
+			if (flags & FNM_PATHNAME && t_ch =3D=3D '/')
 				return NOMATCH;
 			continue;
 		case '*':
 			if (*++p =3D=3D '*') {
 				const uchar *prev_p =3D p - 2;
 				while (*++p =3D=3D '*') {}
-				if ((prev_p =3D=3D text || *prev_p =3D=3D '/') ||
+				if (!(flags & FNM_PATHNAME))
+					/* without FNM_PATHNAME, '*' =3D=3D '**' */
+					special =3D TRUE;
+				else if ((prev_p =3D=3D text || *prev_p =3D=3D '/') ||
 				    (*p =3D=3D '\0' || *p =3D=3D '/' ||
 				     (p[0] =3D=3D '\\' && p[1] =3D=3D '/'))) {
 					/*
@@ -106,7 +109,7 @@ static int dowild(const uchar *p, const uchar *text=
, int flags)
 				} else
 					return ABORT_MALFORMED;
 			} else
-				special =3D FALSE;
+				special =3D flags & FNM_PATHNAME ? FALSE: TRUE;
 			if (*p =3D=3D '\0') {
 				/* Trailing "**" matches everything.  Trailing "*" matches
 				 * only if there are no more slash characters. */
@@ -217,7 +220,8 @@ static int dowild(const uchar *p, const uchar *text=
, int flags)
 				} else if (t_ch =3D=3D p_ch)
 					matched =3D TRUE;
 			} while (prev_ch =3D p_ch, (p_ch =3D *++p) !=3D ']');
-			if (matched =3D=3D special || t_ch =3D=3D '/')
+			if (matched =3D=3D special ||
+			    (flags & FNM_PATHNAME && t_ch =3D=3D '/'))
 				return NOMATCH;
 			continue;
 		}
--=20
1.8.0.rc2.23.g1fb49df
