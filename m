From: Brandon Casey <drafnel@gmail.com>
Subject: [PATCH v4 10/12] t4014: more tests about appending s-o-b lines
Date: Tue, 12 Feb 2013 02:17:37 -0800
Message-ID: <1360664260-11803-11-git-send-email-drafnel@gmail.com>
References: <1360664260-11803-1-git-send-email-drafnel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, pclouds@gmail.com, jrnieder@gmail.com,
	Brandon Casey <bcasey@nvidia.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 12 11:19:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5Cx3-0002yo-4z
	for gcvg-git-2@plane.gmane.org; Tue, 12 Feb 2013 11:19:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932973Ab3BLKSf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Feb 2013 05:18:35 -0500
Received: from mail-pa0-f54.google.com ([209.85.220.54]:65206 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932965Ab3BLKSd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2013 05:18:33 -0500
Received: by mail-pa0-f54.google.com with SMTP id fa10so7248pad.41
        for <git@vger.kernel.org>; Tue, 12 Feb 2013 02:18:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=uvuM/aLKizxT7RQFAzehwYhJUvQg+HD7B6QkeI0Azv4=;
        b=gitQCQB8CPqjJaXLO0DgLH2boD32r8VNbCDVQ8J6QtNbHM2KeLP7k94mnHzzRtzhZR
         RXZOikY5aPsoQkTlhYfavZAElRN1nL3ayU3CLpc0DB/0LCbuBuGFNUGIuAuePvmPdHBa
         ws9RS5CEG0QPtP/OtenDx9p1/hZxeUU36D5hYfnZdi5wml5F6+VagbIYcSYoY+Gdf5if
         nopcsd0CwqsOBhUmO7sVrSiACBVzM7BRdQspqAfS5nUk+iLINMTm5QSGxfmUabZ3H7aO
         SV9ae/YZ71nTjxunD2e06NyasONrviuZCMOVSQTLX4Wh8+rRmh7CRVg6z2uwcPw7SmdH
         4jxw==
X-Received: by 10.66.74.234 with SMTP id x10mr51004671pav.10.1360664312946;
        Tue, 12 Feb 2013 02:18:32 -0800 (PST)
Received: from charliebrown.hsd1.ca.comcast.net (c-98-248-42-122.hsd1.ca.comcast.net. [98.248.42.122])
        by mx.google.com with ESMTPS id l5sm73839001pax.10.2013.02.12.02.18.30
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 12 Feb 2013 02:18:31 -0800 (PST)
X-Mailer: git-send-email 1.8.1.1.252.gdb33759
In-Reply-To: <1360664260-11803-1-git-send-email-drafnel@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216140>

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
 t/t4014-format-patch.sh | 241 ++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 file changed, 241 insertions(+)

diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 7fa3647..a415b89 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -1021,4 +1021,245 @@ test_expect_success 'cover letter using branch =
description (6)' '
 	grep hello actual >/dev/null
 '
=20
+append_signoff()
+{
+	C=3D$(git commit-tree HEAD^^{tree} -p HEAD) &&
+	git format-patch --stdout --signoff $C^..$C >append_signoff.patch &&
+	sed -n -e "1,/^---$/p" append_signoff.patch |
+		egrep -n "^Subject|Sign|^$"
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
1.8.1.3.579.gd9af3b6
