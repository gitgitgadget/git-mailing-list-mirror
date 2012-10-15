From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 12/13] wildmatch: make /**/ match zero or more directories
Date: Mon, 15 Oct 2012 13:26:01 +0700
Message-ID: <1350282362-4505-12-git-send-email-pclouds@gmail.com>
References: <1350282212-4270-1-git-send-email-pclouds@gmail.com>
 <1350282362-4505-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 15 08:28:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNe9d-0008T5-8b
	for gcvg-git-2@plane.gmane.org; Mon, 15 Oct 2012 08:27:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753998Ab2JOG1q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Oct 2012 02:27:46 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:39239 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753956Ab2JOG1p (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2012 02:27:45 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so4542541pad.19
        for <git@vger.kernel.org>; Sun, 14 Oct 2012 23:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=f0UqsMxsFET9/yCJEztBKymhmt38C861jC763GoFHP4=;
        b=h5oXuPqkqwq6Bh8Zt2qiLaTY0XPN8YoZZ44N//hya6kMMVzFzMBZzp9IMebCzJDVF8
         0NHIoMjMbFx70v/ctzlfGAZG0/TxbT0cEMd2PTApb6qKLQB1q2ExJHsaUEEDmNvfoW9p
         1Ndn4aeMjpMTRpcAUG4lsz7wvvUl8XzQQkege2CbcMaFBjhoMr/ESRxvMY9lMhb3mdMn
         nfnvgW6+MUcgKhnDGhVt87itMTWWkStSPBosUcrKQ6agEY9vWlYRKSWJIPNALjRR2PEc
         iVUijbMHV7sZA1sW8qfUpi8pKgldtaiNdp3oKRs/QD2NxinO3gBhOMbJa4N1o7MP4z5m
         DnGg==
Received: by 10.68.230.66 with SMTP id sw2mr34557123pbc.119.1350282465690;
        Sun, 14 Oct 2012 23:27:45 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id po4sm8582229pbb.13.2012.10.14.23.27.41
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 14 Oct 2012 23:27:44 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 15 Oct 2012 13:27:35 +0700
X-Mailer: git-send-email 1.8.0.rc0.29.g1fdd78f
In-Reply-To: <1350282362-4505-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207710>

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
 wildmatch.c          | 12 ++++++++++++
 2 files changed, 19 insertions(+), 1 deletion(-)

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
index 85bc0df..3972e26 100644
--- a/wildmatch.c
+++ b/wildmatch.c
@@ -90,6 +90,18 @@ static int dowild(const uchar *p, const uchar *text,=
 int force_lower_case)
 				if ((prev_p =3D=3D text || *prev_p =3D=3D '/') ||
 				    (*p =3D=3D '\0' || *p =3D=3D '/' ||
 				     (p[0] =3D=3D '\\' && p[1] =3D=3D '/'))) {
+					/*
+					 * Assuming we already match 'foo/' and are at
+					 * <star star slash>, just assume it matches
+					 * nothing and go ahead match the rest of the
+					 * pattern with the remaining string. This
+					 * helps make foo/<*><*>/bar (<> because
+					 * otherwise it breaks C comment syntax) match
+					 * both foo/bar and foo/a/bar.
+					 */
+					if (p[0] =3D=3D '/' &&
+					    dowild(p + 1, text, force_lower_case) =3D=3D MATCH)
+						return MATCH;
 					special =3D TRUE;
 				} else
 					return ABORT_MALFORMED;
--=20
1.8.0.rc0.29.g1fdd78f
