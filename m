From: Brandon Casey <drafnel@gmail.com>
Subject: [PATCH v2 08/10] t4014: more tests about appending s-o-b lines
Date: Mon, 21 Jan 2013 00:40:25 -0800
Message-ID: <1358757627-16682-9-git-send-email-drafnel@gmail.com>
References: <1358757627-16682-1-git-send-email-drafnel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: pclouds@gmail.com, git@vger.kernel.org,
	Brandon Casey <bcasey@nvidia.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jan 21 09:41:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxCwV-0002yZ-GG
	for gcvg-git-2@plane.gmane.org; Mon, 21 Jan 2013 09:41:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752561Ab3AUIlC convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Jan 2013 03:41:02 -0500
Received: from mail-pa0-f43.google.com ([209.85.220.43]:62714 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752111Ab3AUIk7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2013 03:40:59 -0500
Received: by mail-pa0-f43.google.com with SMTP id fb10so3286441pad.30
        for <git@vger.kernel.org>; Mon, 21 Jan 2013 00:40:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=K1cb84XXugSXSZ3YKjCpwgFtoNXKrVjQeM0uhIV1JeY=;
        b=lxFLORqrh449Jz36M3Hy59M/ld+7FXxLse/SACKPbofuVX3DCEUdVyHaSdbAkbGqEp
         4JKq+wjIMRk0+mVJN+zX78DNErx6bnNwAuPUnzUxSsKl3q9tjCOmyNEjpvEt7et0xS/B
         LJLyCqM1FqQ+R3yGAzIdX5VzKO19rZAQEVp9wO60U+0T8iNOw6Q3BKWOOx6JwcCT1kmA
         0JVFnTewt8PA+6gS0i/BmspJa9wLAZJ2TYMzAkte+12c7+nNtFpD72/cKN0AFbp1Ii6y
         JIhZSchsz2qwEay7QQLbYjbX78r7dIzozLg/7r93kzIH9vcqB5r4FpUMAG4y51tswspV
         f6bw==
X-Received: by 10.68.220.161 with SMTP id px1mr28321870pbc.167.1358757658720;
        Mon, 21 Jan 2013 00:40:58 -0800 (PST)
Received: from charliebrown.hsd1.ca.comcast.net (c-98-248-42-122.hsd1.ca.comcast.net. [98.248.42.122])
        by mx.google.com with ESMTPS id x2sm8883757paw.8.2013.01.21.00.40.57
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 21 Jan 2013 00:40:58 -0800 (PST)
X-Mailer: git-send-email 1.8.1.1.252.gdb33759
In-Reply-To: <1358757627-16682-1-git-send-email-drafnel@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214102>

=46rom: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>

[bc: Squash the tests from Duy's original unify-appending-sob series.

     Fix test 90 "signoff: some random signoff-alike" and mark as faili=
ng.
     Correct behavior should insert a blank line after message body and
     signed-off-by.

     Add two additional tests:

       1. failure to detect non-conforming elements in the footer when =
last
          line matches committer's s-o-b.
       2. ensure various s-o-b -like elements in the footer are handled=
 as
          conforming. e.g. "Change-id: IXXXX or Bug: 1234"
]

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Brandon Casey <bcasey@nvidia.com>
---
 t/t4014-format-patch.sh | 242 ++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 file changed, 242 insertions(+)

diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 7fa3647..3868cef 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -1021,4 +1021,246 @@ test_expect_success 'cover letter using branch =
description (6)' '
 	grep hello actual >/dev/null
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
+	printf subject | append_signoff >actual &&
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
+test_expect_failure 'signoff: some random signoff-alike' '
+	append_signoff <<\EOF >actual &&
+subject
+
+body
+Fooled-by-me: my@house
+EOF
+	cat >expected <<\EOF &&
+4:Subject: [PATCH] subject
+8:
+11:
+12:Signed-off-by: C O Mitter <committer@example.com>
+EOF
+	test_cmp expected actual
+'
+
+test_expect_failure 'signoff: not really a signoff' '
+	append_signoff <<\EOF >actual &&
+subject
+
+I want to mention about Signed-off-by: here.
+EOF
+	cat >expected <<\EOF &&
+4:Subject: [PATCH] subject
+8:
+9:I want to mention about Signed-off-by: here.
+10:
+11:Signed-off-by: C O Mitter <committer@example.com>
+EOF
+	test_cmp expected actual
+'
+
+test_expect_failure 'signoff: not really a signoff (2)' '
+	append_signoff <<\EOF >actual &&
+subject
+
+My unfortunate
+Signed-off-by: example happens to be wrapped here.
+EOF
+	cat >expected <<\EOF &&
+4:Subject: [PATCH] subject
+8:
+10:Signed-off-by: example happens to be wrapped here.
+11:
+12:Signed-off-by: C O Mitter <committer@example.com>
+EOF
+	test_cmp expected actual
+'
+
+test_expect_failure 'signoff: valid S-o-b paragraph in the middle' '
+	append_signoff <<\EOF >actual &&
+subject
+
+Signed-off-by: my@house
+Signed-off-by: your@house
+
+A lot of houses.
+EOF
+	cat >expected <<\EOF &&
+4:Subject: [PATCH] subject
+8:
+9:Signed-off-by: my@house
+10:Signed-off-by: your@house
+11:
+13:
+14:Signed-off-by: C O Mitter <committer@example.com>
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
+test_expect_failure 'signoff: detect garbage in non-conforming footer'=
 '
+	append_signoff <<\EOF >actual &&
+subject
+
+body
+
+Tested-by: my@house
+Some Trash
+Signed-off-by: C O Mitter <committer@example.com>
+EOF
+	cat >expected <<\EOF &&
+4:Subject: [PATCH] subject
+8:
+10:
+13:Signed-off-by: C O Mitter <committer@example.com>
+14:
+15:Signed-off-by: C O Mitter <committer@example.com>
+EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'signoff: footer begins with non-signoff without @=
 sign' '
+	append_signoff <<\EOF >actual &&
+subject
+
+body
+
+Reviewed-id: Noone
+Tested-by: my@house
+Change-id: Ideadbeef
+Signed-off-by: C O Mitter <committer@example.com>
+Bug: 1234
+EOF
+	cat >expected <<\EOF &&
+4:Subject: [PATCH] subject
+8:
+10:
+14:Signed-off-by: C O Mitter <committer@example.com>
+EOF
+	test_cmp expected actual
+'
+
 test_done
--=20
1.8.1.1.252.gdb33759
