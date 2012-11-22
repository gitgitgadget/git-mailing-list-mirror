From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 1/4] t4014: more tests about appending s-o-b lines
Date: Thu, 22 Nov 2012 23:38:06 +0700
Message-ID: <1353602289-9418-2-git-send-email-pclouds@gmail.com>
References: <CACsJy8BiJRK7N3_HZ2WXpMd1YkDSW00AxuYqiCWJgij+Kq6AiQ@mail.gmail.com>
 <1353602289-9418-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 22 20:29:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TbcSh-0005lj-8T
	for gcvg-git-2@plane.gmane.org; Thu, 22 Nov 2012 20:29:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756239Ab2KVT3H convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 Nov 2012 14:29:07 -0500
Received: from mail-da0-f46.google.com ([209.85.210.46]:52785 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965183Ab2KVT3F (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Nov 2012 14:29:05 -0500
Received: by mail-da0-f46.google.com with SMTP id p5so2313928dak.19
        for <git@vger.kernel.org>; Thu, 22 Nov 2012 11:29:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=5T5PF+YtXfrVW/WlicdjQ5ams4RrqfbVNtcN8dheUJc=;
        b=maLHSJq4qvCeL9ve/LliTYbX84V3anzlBdvTNzDiutljt+xGbx7inu8uirhcK5DTtN
         AoV53SunD3pd0Zzke3Sp4ej9fFH5UWoUAfZXeH72p6aVWFmwicIZtUFuegyHu4SNlGZN
         X/XhI9MCLJwuJnhADo7Ov3mlexBx5ZEbzHBtHWi4COul48EDC7BQ4esUlTszxR8lyJnn
         7pbEV/oyafaB0B7+qzBYYXGIUBo+9PJfWp7M1Pv6BbkYkwt423kIU23Ak1U9oCqR4XJd
         9nVbhcl93P8hOI+MiwvQ8nXYAVuE16ZkvNqGEzahO+vX8GAoIUBc658t1mkh6Jq5+OSU
         Ho5Q==
Received: by 10.66.76.162 with SMTP id l2mr2881017paw.13.1353602288372;
        Thu, 22 Nov 2012 08:38:08 -0800 (PST)
Received: from lanh ([115.74.40.93])
        by mx.google.com with ESMTPS id yi9sm2295597pbc.39.2012.11.22.08.38.05
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 22 Nov 2012 08:38:07 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Thu, 22 Nov 2012 23:38:20 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
In-Reply-To: <1353602289-9418-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210195>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t4014-format-patch.sh | 145 ++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 file changed, 145 insertions(+)

diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 959aa26..c8d5d29 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -891,4 +891,149 @@ test_expect_success 'format patch ignores color.u=
i' '
 	test_cmp expect actual
 '
=20
+append_signoff()
+{
+	C=3D`git commit-tree HEAD^^{tree} -p HEAD` &&
+	git format-patch --stdout --signoff ${C}^..${C} |
+		tee append_signoff.patch |
+		sed -n "1,/^---$/p" |
+		grep -n -E "^Subject|Sign|^$"
+}
+
+test_expect_success 'signoff: commit with no body' '
+	append_signoff </dev/null >actual &&
+	cat <<\EOF | sed "s/EOL$//" >expected &&
+4:Subject: [PATCH] EOL
+8:
+9:Signed-off-by: C O Mitter <committer@example.com>
+EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'signoff: commit with only subject' '
+	echo subject | append_signoff >actual &&
+	cat >expected <<\EOF &&
+4:Subject: [PATCH] subject
+8:
+9:Signed-off-by: C O Mitter <committer@example.com>
+EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'signoff: commit with only subject that does not e=
nd with NL' '
+	echo -n subject | append_signoff >actual &&
+	cat >expected <<\EOF &&
+4:Subject: [PATCH] subject
+8:
+9:Signed-off-by: C O Mitter <committer@example.com>
+EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'signoff: no existing signoffs' '
+	append_signoff <<\EOF >actual &&
+subject
+
+body
+EOF
+	cat >expected <<\EOF &&
+4:Subject: [PATCH] subject
+8:
+10:
+11:Signed-off-by: C O Mitter <committer@example.com>
+EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'signoff: no existing signoffs and no trailing NL'=
 '
+	printf "subject\n\nbody" | append_signoff >actual &&
+	cat >expected <<\EOF &&
+4:Subject: [PATCH] subject
+8:
+10:
+11:Signed-off-by: C O Mitter <committer@example.com>
+EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'signoff: some random signoff' '
+	append_signoff <<\EOF >actual &&
+subject
+
+body
+
+Signed-off-by: my@house
+EOF
+	cat >expected <<\EOF &&
+4:Subject: [PATCH] subject
+8:
+10:
+11:Signed-off-by: my@house
+12:Signed-off-by: C O Mitter <committer@example.com>
+EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'signoff: some random signoff-alike' '
+	append_signoff <<\EOF >actual &&
+subject
+
+body
+Fooled-by-me: my@house
+EOF
+	cat >expected <<\EOF &&
+4:Subject: [PATCH] subject
+8:
+11:Signed-off-by: C O Mitter <committer@example.com>
+EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'signoff: the same signoff at the end' '
+	append_signoff <<\EOF >actual &&
+subject
+
+body
+
+Signed-off-by: C O Mitter <committer@example.com>
+EOF
+	cat >expected <<\EOF &&
+4:Subject: [PATCH] subject
+8:
+10:
+11:Signed-off-by: C O Mitter <committer@example.com>
+EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'signoff: the same signoff at the end, no trailing=
 NL' '
+	printf "subject\n\nSigned-off-by: C O Mitter <committer@example.com>"=
 |
+		append_signoff >actual &&
+	cat >expected <<\EOF &&
+4:Subject: [PATCH] subject
+8:
+9:Signed-off-by: C O Mitter <committer@example.com>
+EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'signoff: the same signoff NOT at the end' '
+	append_signoff <<\EOF >actual &&
+subject
+
+body
+
+Signed-off-by: C O Mitter <committer@example.com>
+Signed-off-by: my@house
+EOF
+	cat >expected <<\EOF &&
+4:Subject: [PATCH] subject
+8:
+10:
+11:Signed-off-by: C O Mitter <committer@example.com>
+12:Signed-off-by: my@house
+EOF
+	test_cmp expected actual
+'
+
 test_done
--=20
1.8.0.4.g5d0415a
