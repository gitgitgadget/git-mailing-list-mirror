From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v5 11/12] wildmatch: make /**/ match zero or more directories
Date: Sun, 14 Oct 2012 09:35:09 +0700
Message-ID: <1350182110-25936-12-git-send-email-pclouds@gmail.com>
References: <1350182110-25936-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 14 04:36:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNE4Q-000606-7S
	for gcvg-git-2@plane.gmane.org; Sun, 14 Oct 2012 04:36:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752019Ab2JNCgj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 13 Oct 2012 22:36:39 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:52657 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751674Ab2JNCgi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Oct 2012 22:36:38 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so3876701pad.19
        for <git@vger.kernel.org>; Sat, 13 Oct 2012 19:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=nOVtsO1j2+W48WgB9wOEhhT4C9UyTmWUK9bqZiwqHQA=;
        b=PTUBH5HlGplcojU2p8/0uEUFomck18NgqpPpRdoAT5wmQxxFugnU7juubmPuxJsI+l
         vQDNGtfNdssGgScABv+GkbB+J9QqfMmtK96Sst+DNEqOCtByt2gXf4RRQq4zKX6UEwb+
         U81aiztAkpaDxiDyLUQnQhmokJJ/wpGahnFZ+8Pqac615IwXx1mpLHSbsq8PAgLMXbQg
         d0IX4mzMyebj9FobAtjzCzoJuKwtu6XccedBG+YNsG/9ZShOcTAKNdAmaLM1XqVYTbMn
         ca2C8ejDp4AFSbYF8inFInyIz6Bc85o9RpNvSbz1psSp/JJrNTyZbLAkXkVY/CA9V+Hh
         1r5A==
Received: by 10.68.248.1 with SMTP id yi1mr26324361pbc.93.1350182198558;
        Sat, 13 Oct 2012 19:36:38 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.54.82])
        by mx.google.com with ESMTPS id h8sm6787956pay.0.2012.10.13.19.36.35
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 13 Oct 2012 19:36:37 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun, 14 Oct 2012 09:36:24 +0700
X-Mailer: git-send-email 1.8.0.rc2.11.g2b79d01
In-Reply-To: <1350182110-25936-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207602>

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
index 15848d5..e6ad6f4 100755
--- a/t/t3070-wildmatch.sh
+++ b/t/t3070-wildmatch.sh
@@ -63,11 +63,17 @@ match 1 1 ']' ']'
 match 0 0 'foo/baz/bar' 'foo*bar'
 match 0 0 'foo/baz/bar' 'foo**bar'
 match 0 1 'foobazbar' 'foo**bar'
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
 match 1 x '/foo' '**/foo'
 match 1 0 'bar/baz/foo' '**/foo'
 match 0 0 'bar/baz/foo' '*/foo'
diff --git a/wildmatch.c b/wildmatch.c
index 7209f26..35c34ac 100644
--- a/wildmatch.c
+++ b/wildmatch.c
@@ -90,6 +90,23 @@ static int dowild(const uchar *p, const uchar *text,=
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
+			    dowild(p + 1, text, force_lower_case) =3D=3D MATCH)
+				return MATCH;
 		    special =3D TRUE;
 		} else
 		    return ABORT_MALFORMED;
--=20
1.8.0.rc2.11.g2b79d01
