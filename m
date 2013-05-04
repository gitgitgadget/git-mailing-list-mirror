From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] get_sha1: improve ambiguity warning regarding SHA-1 and ref names
Date: Sat,  4 May 2013 10:45:13 +0700
Message-ID: <1367639113-17342-1-git-send-email-pclouds@gmail.com>
References: <20130501184327.GM24467@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Niedier <jrnieder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 04 05:44:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UYTOd-0001xF-TV
	for gcvg-git-2@plane.gmane.org; Sat, 04 May 2013 05:44:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752117Ab3EDDoY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 May 2013 23:44:24 -0400
Received: from mail-pd0-f173.google.com ([209.85.192.173]:56030 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751656Ab3EDDoX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 May 2013 23:44:23 -0400
Received: by mail-pd0-f173.google.com with SMTP id v10so1202189pde.18
        for <git@vger.kernel.org>; Fri, 03 May 2013 20:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=DyVfh+tkSTVsImFvWJxo9mRtrqPszm+XUdClOBwQPlU=;
        b=NeHSw+bAj71kVGAUHn3XCDnyKSsZxx6SJm4AfkDecyMQML3kzf97FPNZge10BcTHgE
         dPMZ8qdMBS7pw3qZKdeBkJGLOshHISy4wyYkQFVy8dO/s0ykZ3vVGPrl2aWxkGA9Ogr3
         QO3tm4MhTvbS9lY6NV2s/hJjG0jfUMuiCPTNGyJ+twmbFZd3z3ez4foWN9wM/5ZSGRkF
         T2c+0sdQtQkhV/skKMtUQgw1pvefR/lCzY/b1p2ttUCNP9UGW+ucAKf9tpt3HBqK7fXI
         6t3f7EgjRE7ZO7LetP6ReWXHFBqOq1fWj6vLnf96spa2oUJDuy1Gr9+ZA93CC9b02weR
         H3/w==
X-Received: by 10.68.209.232 with SMTP id mp8mr6924100pbc.44.1367639062556;
        Fri, 03 May 2013 20:44:22 -0700 (PDT)
Received: from lanh ([115.74.38.7])
        by mx.google.com with ESMTPSA id hp1sm15416965pac.3.2013.05.03.20.44.18
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 03 May 2013 20:44:21 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 04 May 2013 10:45:15 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <20130501184327.GM24467@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223353>

When we get 40 hex digits, we immediately assume it's an SHA-1. Warn
about ambiguity if there's also refs/heads/$sha1 (or similar) on system=
=2E

When we successfully resolve a ref like "1234abc" and "1234abc"
happens to be valid abbreviated SHA-1 on system, warn also.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 On Thu, May 2, 2013 at 1:43 AM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
 > Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
 >
 >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0"git rev-parse 1234" will
 >> resolve refs/heads/1234 if exists even if there is an unambiguous
 >> SHA-1 starting with 1234. However if it's full SHA-1, the SHA-1 tak=
es
 >> precedence and refs with the same name are ignored.
 >
 > That's an important feature for safety. =C2=A0When a script has crea=
ted an
 > object or learned about it some other way, as long as it doesn't
 > abbreviate its name it can be sure that git commands will not
 > misunderstand it.
 >
 > So I think this is a bad change. =C2=A0Maybe check-ref-format should
 > reject 40-hexdigit refnames?

 We can't, at least not in a simple way, because there are 40-hex
 digit refs in refs/replace. I think warning only is a simpler
 approach to this minor issue.

 sha1_name.c                         | 12 ++++++++++--
 t/t1512-rev-parse-disambiguation.sh | 18 ++++++++++++++++++
 2 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index 3820f28..04a9fbe 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -435,12 +435,18 @@ static int get_sha1_1(const char *name, int len, =
unsigned char *sha1, unsigned l
 static int get_sha1_basic(const char *str, int len, unsigned char *sha=
1)
 {
 	static const char *warn_msg =3D "refname '%.*s' is ambiguous.";
+	unsigned char tmp_sha1[20];
 	char *real_ref =3D NULL;
 	int refs_found =3D 0;
 	int at, reflog_len;
=20
-	if (len =3D=3D 40 && !get_sha1_hex(str, sha1))
+	if (len =3D=3D 40 && !get_sha1_hex(str, sha1)) {
+		refs_found =3D dwim_ref(str, len, tmp_sha1, &real_ref);
+		if (refs_found > 0 && warn_ambiguous_refs)
+			warning(warn_msg, len, str);
+		free(real_ref);
 		return 0;
+	}
=20
 	/* basic@{time or number or -number} format to query ref-log */
 	reflog_len =3D at =3D 0;
@@ -481,7 +487,9 @@ static int get_sha1_basic(const char *str, int len,=
 unsigned char *sha1)
 	if (!refs_found)
 		return -1;
=20
-	if (warn_ambiguous_refs && refs_found > 1)
+	if (warn_ambiguous_refs &&
+	    (refs_found > 1 ||
+	     !get_short_sha1(str, len, tmp_sha1, GET_SHA1_QUIETLY)))
 		warning(warn_msg, len, str);
=20
 	if (reflog_len) {
diff --git a/t/t1512-rev-parse-disambiguation.sh b/t/t1512-rev-parse-di=
sambiguation.sh
index 6b3d797..db22808 100755
--- a/t/t1512-rev-parse-disambiguation.sh
+++ b/t/t1512-rev-parse-disambiguation.sh
@@ -261,4 +261,22 @@ test_expect_success 'rev-parse --disambiguate' '
 	test "$(sed -e "s/^\(.........\).*/\1/" actual | sort -u)" =3D 000000=
000
 '
=20
+test_expect_success 'ambiguous 40-hex ref' '
+	TREE=3D$(git mktree </dev/null) &&
+	REF=3D`git rev-parse HEAD` &&
+	VAL=3D$(git commit-tree $TREE </dev/null) &&
+	git update-ref refs/heads/$REF $VAL &&
+	test `git rev-parse $REF 2>err` =3D $REF &&
+	grep "refname.*${REF}.*ambiguous" err
+'
+
+test_expect_success 'ambiguous short sha1 ref' '
+	TREE=3D$(git mktree </dev/null) &&
+	REF=3D`git rev-parse --short HEAD` &&
+	VAL=3D$(git commit-tree $TREE </dev/null) &&
+	git update-ref refs/heads/$REF $VAL &&
+	test `git rev-parse $REF 2>err` =3D $VAL &&
+	grep "refname.*${REF}.*ambiguous" err
+'
+
 test_done
--=20
1.8.2.83.gc99314b
