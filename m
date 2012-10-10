From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 10/12] wildmatch: make /**/ match zero or more directories
Date: Wed, 10 Oct 2012 17:40:49 +0700
Message-ID: <1349865651-31889-11-git-send-email-pclouds@gmail.com>
References: <1349865651-31889-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 10 12:42:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLtk1-000343-Af
	for gcvg-git-2@plane.gmane.org; Wed, 10 Oct 2012 12:42:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755723Ab2JJKmH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Oct 2012 06:42:07 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:49272 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755686Ab2JJKmE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2012 06:42:04 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so466174pad.19
        for <git@vger.kernel.org>; Wed, 10 Oct 2012 03:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=2/eguRJrwfj/6OfjLELN6WCWaI4ZucmAlh91Lht9uCA=;
        b=yxAXQ0Ae1FmYeeWV6tboWf6UzsTx/WwbTFl0qR51ZNrFYHtBaCSW0q3of6hHNy092e
         dHPaedqcXNuOZFX3ck1TW+IWX02d9q5jAYwTHNkPH/d/KPSw/ZAnXrqVHSpCzVJi4s3+
         Z8EgyxwJZYKWFTHsRy3knd4214ybigRHRAr940HEUUMHaHbhYfLWPwISF0vBWAmpwQEI
         nyon+eMPKqAPnch0xuER8sIxBgzZHyivAm9VmzZVwIMtJ4EZEvqaSTBA92YJHsVpFJ/t
         yQffL63QEDelMDl1IEKGdYiVXfGWgnZEKU51aswxkgFojQvo41NlO4dURFQBG7fj1yeG
         y3wA==
Received: by 10.68.135.196 with SMTP id pu4mr72708690pbb.11.1349865724306;
        Wed, 10 Oct 2012 03:42:04 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.54.82])
        by mx.google.com with ESMTPS id pi1sm853210pbb.7.2012.10.10.03.42.01
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 10 Oct 2012 03:42:03 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 10 Oct 2012 17:41:56 +0700
X-Mailer: git-send-email 1.7.12.1.406.g6ab07c4
In-Reply-To: <1349865651-31889-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207395>

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
index f6c64be..f21da6c 100755
--- a/t/t3070-wildmatch.sh
+++ b/t/t3070-wildmatch.sh
@@ -53,11 +53,17 @@ match 1 1 ']' ']'
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
 match 1 1 '/foo' '**/foo'
 match 1 0 'bar/baz/foo' '**/foo'
 match 0 0 'bar/baz/foo' '*/foo'
diff --git a/wildmatch.c b/wildmatch.c
index e09a459..f060bb0 100644
--- a/wildmatch.c
+++ b/wildmatch.c
@@ -91,6 +91,23 @@ static int dowild(const uchar *p, const uchar *text,=
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
1.7.12.1.406.g6ab07c4
