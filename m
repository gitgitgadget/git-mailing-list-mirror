From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 4/4] attr.c: fix matching "subdir" without the trailing slash
Date: Mon, 25 Mar 2013 13:05:10 +0700
Message-ID: <1364191510-8900-5-git-send-email-pclouds@gmail.com>
References: <20130319175756.GA13760@sigill.intra.peff.net>
 <1364191510-8900-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, avila.jn@gmail.com,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 25 07:06:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UK0Y9-0002Kz-Ja
	for gcvg-git-2@plane.gmane.org; Mon, 25 Mar 2013 07:06:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757639Ab3CYGGA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Mar 2013 02:06:00 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:33247 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757631Ab3CYGGA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Mar 2013 02:06:00 -0400
Received: by mail-pa0-f43.google.com with SMTP id rl6so850426pac.2
        for <git@vger.kernel.org>; Sun, 24 Mar 2013 23:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=9v5wuAhGSyyt5yrOjfg2Hqbu0kJlcouRIKSI18Bl4KY=;
        b=w9bZsB8maZd1eq8Me4CE8a226D9Jy32pNPl6jiBLVVItJgMD2jNaBaoisrTkuwNNsB
         yGvLznM1JXk/NdRlzWLUEcu8Nj8iBy856Oh+74h47WI4cIoUb0ydL5bq84gXci2+Br/e
         L3NR+l7oruB8H1r9lYkqrrUNOidTJvc5IkfH9IN7MMSU2pkJVWk4BBLwk1mcqLHUM4ZZ
         k9N0wCTlFfy+36Qbh2zD0/UJsKiL3pT+cYSmBa9dS+5kbQeWzsruxfIv1BSgLPh1Klqu
         +pkL6xddFglr/TujuhhHxTILjJFootmNiLCW8B7FJ12gldoI+4mOPwPXr7GMUHU4v++G
         uuIA==
X-Received: by 10.66.216.198 with SMTP id os6mr16070751pac.145.1364191559565;
        Sun, 24 Mar 2013 23:05:59 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id fc8sm13462472pad.21.2013.03.24.23.05.55
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 24 Mar 2013 23:05:58 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 25 Mar 2013 13:05:51 +0700
X-Mailer: git-send-email 1.8.2.82.gc24b958
In-Reply-To: <1364191510-8900-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219010>

The story goes back to 94bc671 (Add directory pattern matching to
attributes - 2012-12-08). Before this commit, directories are passed
to path_matches without the trailing slash. This is fine for matching
pattern "subdir" with "foo/subdir".

Patterns like "subdir/" (i.e. match _directory_ subdir) won't work
though. So paths are now passed to path_matches with the trailing
slash (i.e. "subdir/"). The trailing slash is used as the directory
indicator (similar to dtype in exclude case). This makes pattern
"subdir/" match directory "subdir/". Pattern "subdir" no longer match
subdir, which is now "subdir/".

As the trailing slash in pathname is the directory indicator, we do
not need to keep it in the pathname for matching. The trailing slash
should be turned to dtype "DT_DIR" and stripped out of pathname. This
keeps the code pattern similar to exclude.

The same applies for the pattern "subdir/". The trailing slash is
converted to flag EXC_FLAG_MUSTBEDIR and should not remain in the
pattern, as noted in parse_exclude_pattern(). prepare_attr_stack()
breaks this and keeps the trailing slash anyway.

To sum up, both patterns and pathnames should never have the trailing
slash when it comes to match_basename.

Reported-and-analyzed-by: Jeff King <peff@peff.net>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 attr.c                          | 11 +++++++++--
 t/t5002-archive-attr-pattern.sh |  6 ++++++
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/attr.c b/attr.c
index 1818ba5..a95c837 100644
--- a/attr.c
+++ b/attr.c
@@ -256,7 +256,7 @@ static struct match_attr *parse_attr_line(const cha=
r *line, const char *src,
 				      &res->u.pat.flags,
 				      &res->u.pat.nowildcardlen);
 		if (res->u.pat.flags & EXC_FLAG_MUSTBEDIR)
-			res->u.pat.patternlen++;
+			p[res->u.pat.patternlen] =3D '\0';
 		if (res->u.pat.flags & EXC_FLAG_NEGATIVE) {
 			warning(_("Negative patterns are ignored in git attributes\n"
 				  "Use '\\!' for literal leading exclamation."));
@@ -665,9 +665,16 @@ static int path_matches(const char *pathname, int =
pathlen,
 {
 	const char *pattern =3D pat->pattern;
 	int prefix =3D pat->nowildcardlen;
+	int dtype;
+
+	if (pathlen && pathname[pathlen-1] =3D=3D '/') {
+		dtype =3D DT_DIR;
+		pathlen--;
+	} else
+		dtype =3D DT_REG;
=20
 	if ((pat->flags & EXC_FLAG_MUSTBEDIR) &&
-	    ((!pathlen) || (pathname[pathlen-1] !=3D '/')))
+	    dtype !=3D DT_DIR)
 		return 0;
=20
 	if (pat->flags & EXC_FLAG_NODIR) {
diff --git a/t/t5002-archive-attr-pattern.sh b/t/t5002-archive-attr-pat=
tern.sh
index 0c847fb..98ccc3c 100755
--- a/t/t5002-archive-attr-pattern.sh
+++ b/t/t5002-archive-attr-pattern.sh
@@ -27,6 +27,10 @@ test_expect_success 'setup' '
 	echo ignored-only-if-dir/ export-ignore >>.git/info/attributes &&
 	git add ignored-only-if-dir &&
=20
+	mkdir -p ignored-without-slash &&
+	echo ignored without slash >ignored-without-slash/foo &&
+	git add ignored-without-slash/foo &&
+	echo ignored-without-slash export-ignore >>.git/info/attributes &&
=20
 	mkdir -p one-level-lower/two-levels-lower/ignored-only-if-dir &&
 	echo ignored by ignored dir >one-level-lower/two-levels-lower/ignored=
-only-if-dir/ignored-by-ignored-dir &&
@@ -49,6 +53,8 @@ test_expect_exists	archive/not-ignored-dir/ignored-on=
ly-if-dir
 test_expect_exists	archive/not-ignored-dir/
 test_expect_missing	archive/ignored-only-if-dir/
 test_expect_missing	archive/ignored-ony-if-dir/ignored-by-ignored-dir
+test_expect_missing	archive/ignored-without-slash/ &&
+test_expect_missing	archive/ignored-without-slash/foo &&
 test_expect_exists	archive/one-level-lower/
 test_expect_missing	archive/one-level-lower/two-levels-lower/ignored-o=
nly-if-dir/
 test_expect_missing	archive/one-level-lower/two-levels-lower/ignored-o=
ny-if-dir/ignored-by-ignored-dir
--=20
1.8.2.82.gc24b958
