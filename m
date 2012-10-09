From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 6/8] wildmatch: adjust "**" behavior
Date: Tue,  9 Oct 2012 10:09:05 +0700
Message-ID: <1349752147-13314-7-git-send-email-pclouds@gmail.com>
References: <1349752147-13314-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 09 05:10:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLQCr-0006Fd-89
	for gcvg-git-2@plane.gmane.org; Tue, 09 Oct 2012 05:10:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753097Ab2JIDJz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Oct 2012 23:09:55 -0400
Received: from mail-da0-f46.google.com ([209.85.210.46]:49505 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751260Ab2JIDJy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Oct 2012 23:09:54 -0400
Received: by mail-da0-f46.google.com with SMTP id n41so1887286dak.19
        for <git@vger.kernel.org>; Mon, 08 Oct 2012 20:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=DZ4EBNxwV3iMOp2m+Zsfzh34m0NLcO6UOoTWsLlPTuA=;
        b=NdtxbAvCq/BmOoULOjo4q+ImT6Sz+OcsKeqGr9htecCt6JeajVYDjlqzoB3bVafH0y
         +WhSALtveY3EMxihly5s1rW/D3oO+Hds3o1gdBkb9gjh+D2czy3PsF5UPIkZIYJgWpoM
         7zs9Rb3vVHYWk1PecDADo2I1+zW+xmyGQpo+IY7Sm3yGYAHFD/kjE9LlSiRkLkaCzBvw
         WtWUQBL3HeQ2ILKASCljHgxEvuIoo/S+G1OXuFF3UBMg+0fFW2rtFhMj02OgyrsrvIPd
         +sevUVzWtgjA8Jl7Q1+YnCmWYEtn+pchazfkmuNpmYbNEhTOR3PSmzoaDNfVnRDb6uwB
         ZrkA==
Received: by 10.68.224.133 with SMTP id rc5mr58593027pbc.130.1349752192681;
        Mon, 08 Oct 2012 20:09:52 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id nd6sm8083563pbc.68.2012.10.08.20.09.49
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 08 Oct 2012 20:09:51 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Tue, 09 Oct 2012 10:09:46 +0700
X-Mailer: git-send-email 1.8.0.rc0.29.g1fdd78f
In-Reply-To: <1349752147-13314-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207293>

Standard wildmatch() sees consecutive asterisks as "*" that can also
match slashes. But that may be hard to explain to users as
"abc/**/def" can match "abcdef", "abcxyzdef", "abc/def", "abc/x/def",
"abc/x/y/def"...

This patch changes wildmatch so that users can do

- "**/def" -> all paths ending with file/directory 'def'
- "abc/**" - equivalent to "/abc/"
- "abc/**/def" -> "abc/x/def", "abc/x/y/def"...
- other "**" cases are downgraded to normal "*"

Basically the magic of "**" only remains if it's wrapped around by
slashes.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t3070-wildmatch.sh | 2 +-
 wildmatch.c          | 8 +++++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/t/t3070-wildmatch.sh b/t/t3070-wildmatch.sh
index bb92f8d..d320f84 100755
--- a/t/t3070-wildmatch.sh
+++ b/t/t3070-wildmatch.sh
@@ -51,7 +51,7 @@ match 1 1 ']' ']'
=20
 # Extended slash-matching features
 match 0 0 'foo/baz/bar' 'foo*bar'
-match 1 0 'foo/baz/bar' 'foo**bar'
+match 0 0 'foo/baz/bar' 'foo**bar'
 match 0 0 'foo/bar' 'foo?bar'
 match 0 0 'foo/bar' 'foo[/]bar'
 match 0 0 'foo/bar' 'f[^eiu][^eiu][^eiu][^eiu][^eiu]r'
diff --git a/wildmatch.c b/wildmatch.c
index fdb8cb1..1b39346 100644
--- a/wildmatch.c
+++ b/wildmatch.c
@@ -91,8 +91,14 @@ static int dowild(const uchar *p, const uchar *text,=
 int force_lower_case)
 	    continue;
 	  case '*':
 	    if (*++p =3D=3D '*') {
+		const uchar *prev_p =3D p - 2;
 		while (*++p =3D=3D '*') {}
-		special =3D TRUE;
+		if ((prev_p =3D=3D text || *prev_p =3D=3D '/') ||
+		    (*p =3D=3D '\0' || *p =3D=3D '/' ||
+		     (p[0] =3D=3D '\\' && p[1] =3D=3D '/'))) {
+		    special =3D TRUE;
+		} else
+		    special =3D FALSE;
 	    } else
 		special =3D FALSE;
 	    if (*p =3D=3D '\0') {
--=20
1.8.0.rc0.29.g1fdd78f
