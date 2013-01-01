From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 01/10] wildmatch: fix "**" special case
Date: Tue,  1 Jan 2013 09:44:02 +0700
Message-ID: <1357008251-10014-2-git-send-email-pclouds@gmail.com>
References: <1357008251-10014-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 01 03:44:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TprqE-0008O2-Tp
	for gcvg-git-2@plane.gmane.org; Tue, 01 Jan 2013 03:44:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751450Ab3AACoQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 31 Dec 2012 21:44:16 -0500
Received: from mail-da0-f51.google.com ([209.85.210.51]:36596 "EHLO
	mail-da0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751283Ab3AACoP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Dec 2012 21:44:15 -0500
Received: by mail-da0-f51.google.com with SMTP id i30so5943692dad.24
        for <git@vger.kernel.org>; Mon, 31 Dec 2012 18:44:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=Chbzk8bDnhGLMcNBxPiXkIKfak6e4h9/M//CPtAa8F4=;
        b=wwV5j5Dm3ZmKA8pSX3PUAeRRvg7gfQ88Jky9MhjFcp1YyvnOsKd0xhsifwqkeVeOdA
         jB21/1bb2hDZUQbRzANFD5GWc+O3Gonre6sDVP3xbrKQuDHScf4/ihfi8LSs5LFfS/yY
         ahBTCh2WSQJ0UOr8otJrfu9s0IntDJPa9bssG+7zrbGRB16CIk7ovwVhN2mI5LrncYIG
         5pdXDXf9gq3ll0u4QURaWou+S5asTbSG+K8hT9ztOgOp0PhsNHBvQzANQIMPpC4wQc8t
         31wayKnr2RSibctYyKjIYxUkN60dyi4lHB0v6Hftvo2j00Gaxn3pEX6nRh/l8uzGHTG7
         QXHQ==
X-Received: by 10.68.232.195 with SMTP id tq3mr132162279pbc.70.1357008254903;
        Mon, 31 Dec 2012 18:44:14 -0800 (PST)
Received: from lanh ([115.74.57.25])
        by mx.google.com with ESMTPS id na7sm25813763pbc.48.2012.12.31.18.44.11
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 31 Dec 2012 18:44:14 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 01 Jan 2013 09:44:18 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
In-Reply-To: <1357008251-10014-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212384>

"**" is adjusted to only be effective when surrounded by slashes, in
40bbee0 (wildmatch: adjust "**" behavior - 2012-10-15). Except that
the commit did it wrong:

1. when it checks for "the preceding slash unless ** is at the
   beginning", it compares to wrong pointer. It should have compared
   to the beginning of the pattern, not the text.

2. prev_p points to the character before "**", not the first "*". The
   correct comparison must be "prev_p < pattern" or
   "prev_p + 1 =3D=3D pattern", not "prev_p =3D=3D pattern".

3. The pattern must be surrounded by slashes unless it's at the
   beginning or the end of the pattern. We do two checks: one for the
   preceding slash and one the trailing slash. Both checks must be
   met. The use of "||" is wrong.

This patch fixes all above.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t3070-wildmatch.sh | 2 +-
 wildmatch.c          | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/t/t3070-wildmatch.sh b/t/t3070-wildmatch.sh
index d5bafef..af54c83 100755
--- a/t/t3070-wildmatch.sh
+++ b/t/t3070-wildmatch.sh
@@ -83,7 +83,7 @@ match 0 0 'deep/foo/bar/baz/' '**/bar/*'
 match 1 0 'deep/foo/bar/baz/' '**/bar/**'
 match 0 0 'deep/foo/bar' '**/bar/*'
 match 1 0 'deep/foo/bar/' '**/bar/**'
-match 1 0 'foo/bar/baz' '**/bar**'
+match 0 0 'foo/bar/baz' '**/bar**'
 match 1 0 'foo/bar/baz/x' '*/bar/**'
 match 0 0 'deep/foo/bar/baz/x' '*/bar/**'
 match 1 0 'deep/foo/bar/baz/x' '**/bar/*/*'
diff --git a/wildmatch.c b/wildmatch.c
index 3972e26..5f976e9 100644
--- a/wildmatch.c
+++ b/wildmatch.c
@@ -58,6 +58,7 @@ typedef unsigned char uchar;
 static int dowild(const uchar *p, const uchar *text, int force_lower_c=
ase)
 {
 	uchar p_ch;
+	const uchar *pattern =3D p;
=20
 	for ( ; (p_ch =3D *p) !=3D '\0'; text++, p++) {
 		int matched, special;
@@ -87,7 +88,7 @@ static int dowild(const uchar *p, const uchar *text, =
int force_lower_case)
 			if (*++p =3D=3D '*') {
 				const uchar *prev_p =3D p - 2;
 				while (*++p =3D=3D '*') {}
-				if ((prev_p =3D=3D text || *prev_p =3D=3D '/') ||
+				if ((prev_p < pattern || *prev_p =3D=3D '/') &&
 				    (*p =3D=3D '\0' || *p =3D=3D '/' ||
 				     (p[0] =3D=3D '\\' && p[1] =3D=3D '/'))) {
 					/*
--=20
1.8.0.rc2.23.g1fb49df
