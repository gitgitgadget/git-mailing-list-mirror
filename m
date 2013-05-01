From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH/RFC] get_sha1: prefer 40-hex ref name over 40-hex SHA-1
Date: Wed,  1 May 2013 10:01:22 +0700
Message-ID: <1367377282-9862-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 01 05:00:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXNHm-00089h-O1
	for gcvg-git-2@plane.gmane.org; Wed, 01 May 2013 05:00:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758945Ab3EADAf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 30 Apr 2013 23:00:35 -0400
Received: from mail-da0-f49.google.com ([209.85.210.49]:36149 "EHLO
	mail-da0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758746Ab3EADAe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Apr 2013 23:00:34 -0400
Received: by mail-da0-f49.google.com with SMTP id t11so512996daj.36
        for <git@vger.kernel.org>; Tue, 30 Apr 2013 20:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=t+u7KdRvvNdvc5fciVYJjOmnigYhrLPlCCJEx6wklVo=;
        b=P4wMLPjyIcFUsYkV7zEh1bXzzL8ZuxNtd6iaf1wZby3JnztvXcn1x/7KyR6HMeJ1sL
         lqPXtIPQzQUn0VUCUKkRLu+aD6v9eSxleAqWWazbAbumyoGVJcEAI6FUBJecXAc3W70y
         kp6cp1E/c3eUQGqI3qFpHJChGL8UOi1h3OF2uOMVtyE+xze6FMMi4h1FaJAsS0fdKS2I
         Q8geiVHj9wR+eAZpLpAkmDVlYZSx6m44lNGfpCgJreB6Y/0fKT0xVrEp9gKyy2rVSKmR
         t4ZVG7uSBZPscE9ien7QjxjiL4M6muL8ThLXJpfZ2tEGX0VbSw30nWRqoUgZylLrE1FJ
         Thug==
X-Received: by 10.66.232.230 with SMTP id tr6mr2744975pac.83.1367377233570;
        Tue, 30 Apr 2013 20:00:33 -0700 (PDT)
Received: from lanh ([115.74.47.19])
        by mx.google.com with ESMTPSA id qb1sm1070447pbb.33.2013.04.30.20.00.29
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 30 Apr 2013 20:00:32 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 01 May 2013 10:01:23 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223066>

The current behavior is inconsistent when passing SHA-1 to get_sha1.
If it's a short sha-1, refs take precedence. "git rev-parse 1234" will
resolve refs/heads/1234 if exists even if there is an unambiguous
SHA-1 starting with 1234. However if it's full SHA-1, the SHA-1 takes
precedence and refs with the same name are ignored.

The former makes more sense than the latter. This patch makes git
check for 40-hex ref names before consider it SHA-1. In future, we may
want to warn ambiguity between refs and SHA-1 (for both full and short
SHA-1).

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Some gray area where my "makes more sense" may not actually be common
 sense.

 sha1_name.c                         | 13 +++++++++++--
 t/t1512-rev-parse-disambiguation.sh | 15 +++++++++++++++
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index 3820f28..faf10b4 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -436,11 +436,20 @@ static int get_sha1_basic(const char *str, int le=
n, unsigned char *sha1)
 {
 	static const char *warn_msg =3D "refname '%.*s' is ambiguous.";
 	char *real_ref =3D NULL;
-	int refs_found =3D 0;
+	int refs_found;
 	int at, reflog_len;
=20
-	if (len =3D=3D 40 && !get_sha1_hex(str, sha1))
+	if (len =3D=3D 40 && !get_sha1_hex(str, sha1)) {
+		unsigned char ref_sha1[20];
+		refs_found =3D dwim_ref(str, len, ref_sha1, &real_ref);
+		if (refs_found > 0) {
+			if (warn_ambiguous_refs && refs_found > 1)
+				warning(warn_msg, len, str);
+			hashcpy(sha1, ref_sha1);
+		}
+		free(real_ref);
 		return 0;
+	}
=20
 	/* basic@{time or number or -number} format to query ref-log */
 	reflog_len =3D at =3D 0;
diff --git a/t/t1512-rev-parse-disambiguation.sh b/t/t1512-rev-parse-di=
sambiguation.sh
index 6b3d797..97ff8ac 100755
--- a/t/t1512-rev-parse-disambiguation.sh
+++ b/t/t1512-rev-parse-disambiguation.sh
@@ -261,4 +261,19 @@ test_expect_success 'rev-parse --disambiguate' '
 	test "$(sed -e "s/^\(.........\).*/\1/" actual | sort -u)" =3D 000000=
000
 '
=20
+test_expect_success 'rev-parse 20-hex ref' '
+	REF=3D`git rev-parse HEAD` &&
+	VAL=3D`echo| git commit-tree 4b825dc642cb6eb9a060e54bf8d69288fbee4904=
` &&
+	git update-ref refs/heads/$REF $VAL &&
+	test `git rev-parse $REF` =3D $VAL
+'
+
+test_expect_success 'rev-parse ambiguous 20-hex ref' '
+	REF=3D`git rev-parse HEAD` &&
+	VAL=3D`echo| git commit-tree -p HEAD 4b825dc642cb6eb9a060e54bf8d69288=
fbee4904` &&
+	git update-ref refs/tags/$REF $VAL &&
+	test `git rev-parse $REF 2>err` =3D $VAL &&
+	grep "refname.*ambiguous" err
+'
+
 test_done
--=20
1.8.2.83.gc99314b
