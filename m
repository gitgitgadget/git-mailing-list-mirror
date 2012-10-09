From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 7/8] wildmatch: make /**/ match zero or more directories
Date: Tue,  9 Oct 2012 10:09:06 +0700
Message-ID: <1349752147-13314-8-git-send-email-pclouds@gmail.com>
References: <1349752147-13314-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 09 05:10:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLQCx-0006IM-Po
	for gcvg-git-2@plane.gmane.org; Tue, 09 Oct 2012 05:10:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753345Ab2JIDKB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Oct 2012 23:10:01 -0400
Received: from mail-da0-f46.google.com ([209.85.210.46]:49505 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753163Ab2JIDJ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Oct 2012 23:09:59 -0400
Received: by mail-da0-f46.google.com with SMTP id n41so1887286dak.19
        for <git@vger.kernel.org>; Mon, 08 Oct 2012 20:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=DoAwq54cm4HRkZekGk0yO1EnJppZ9Ajty16ytFDB/wA=;
        b=hiPbiSgmvzjb/vioMzu2vWG5+EfLN6wUAcudQJOEnwfEb4igHByS9TrAeTjsGAijMa
         ChVI79tH5WLUaTRrGGGLCBxhvn5fbmos9T1DAkhRkUKcCl8ib3HYHxXPjnC6Uh5cOj40
         iz6Jj3td3LLxmjFu+k1ccedGfZKNQNnWzrAXJqWes1i+7JqRykR2MoYUt96l9/XC8lYX
         FovLNkkLJReJgXbG+mgQ3GSpatcqN+G55r+LMIi2NcMPyznbAPX4y47N768QMfPlm5ZI
         pg5cLFsdQKLEPImgrtswP92uQ+R3MipRTQAfvmOBtwOVLs9sh+nmzNlSgardRjYaGWmO
         j3jw==
Received: by 10.68.233.198 with SMTP id ty6mr58788539pbc.107.1349752198629;
        Mon, 08 Oct 2012 20:09:58 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id to8sm6370527pbc.11.2012.10.08.20.09.55
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 08 Oct 2012 20:09:58 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Tue, 09 Oct 2012 10:09:52 +0700
X-Mailer: git-send-email 1.8.0.rc0.29.g1fdd78f
In-Reply-To: <1349752147-13314-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207294>

"foo/**/bar" matches "foo/x/bar", "foo/x/y/bar"... but not
"foo/bar". We make a special case, when foo/**/ is detected (and
"foo/" part is already matched), try matching "bar" with the rest of
the string.

"Match one or more directories" semantics can be easily achieved using
"foo/*/**/bar".

This also makes "**/foo" match "foo" in addition to "x/foo",
"x/y/foo"..

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t3070-wildmatch.sh |  8 +++++++-
 wildmatch.c          | 17 +++++++++++++++++
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/t/t3070-wildmatch.sh b/t/t3070-wildmatch.sh
index d320f84..a247a36 100755
--- a/t/t3070-wildmatch.sh
+++ b/t/t3070-wildmatch.sh
@@ -52,11 +52,17 @@ match 1 1 ']' ']'
 # Extended slash-matching features
 match 0 0 'foo/baz/bar' 'foo*bar'
 match 0 0 'foo/baz/bar' 'foo**bar'
+match 1 1 'foo/baz/bar' 'foo/**/bar'
+match 1 0 'foo/baz/bar' 'foo/**/**/bar'
+match 1 0 'foo/b/a/z/bar' 'foo/**/bar'
+match 1 0 'foo/b/a/z/bar' 'foo/**/**/bar'
+match 1 0 'foo/bar' 'foo/**/bar'
+match 1 0 'foo/bar' 'foo/**/**/bar'
 match 0 0 'foo/bar' 'foo?bar'
 match 0 0 'foo/bar' 'foo[/]bar'
 match 0 0 'foo/bar' 'f[^eiu][^eiu][^eiu][^eiu][^eiu]r'
 match 1 1 'foo-bar' 'f[^eiu][^eiu][^eiu][^eiu][^eiu]r'
-match 0 0 'foo' '**/foo'
+match 1 0 'foo' '**/foo'
 match 1 1 '/foo' '**/foo'
 match 1 0 'bar/baz/foo' '**/foo'
 match 0 0 'bar/baz/foo' '*/foo'
diff --git a/wildmatch.c b/wildmatch.c
index 1b39346..4069b2d 100644
--- a/wildmatch.c
+++ b/wildmatch.c
@@ -96,6 +96,23 @@ static int dowild(const uchar *p, const uchar *text,=
 int force_lower_case)
 		if ((prev_p =3D=3D text || *prev_p =3D=3D '/') ||
 		    (*p =3D=3D '\0' || *p =3D=3D '/' ||
 		     (p[0] =3D=3D '\\' && p[1] =3D=3D '/'))) {
+			/*
+			 * Assuming we already match 'foo/' and are at
+			 * <star star slash>, just assume it matches
+			 * nothing and go ahead match the rest of the
+			 * pattern with the remaining string. This
+			 * helps make foo/<*><*>/bar (<> because
+			 * otherwise it breaks C comment syntax) match
+			 * both foo/bar and foo/a/bar.
+			 *
+			 * Crazy patterns like /<*><*>/<*><*>/ are
+			 * treated like /<*><*>/. But undefined
+			 * behavior is even appropriate for people
+			 * writing such a pattern.
+			 */
+			if (p[0] =3D=3D '/' &&
+			    dowild(p + 1, text, force_lower_case) =3D=3D TRUE)
+				return TRUE;
 		    special =3D TRUE;
 		} else
 		    special =3D FALSE;
--=20
1.8.0.rc0.29.g1fdd78f
