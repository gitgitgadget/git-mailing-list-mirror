From: Brandon Casey <drafnel@gmail.com>
Subject: [PATCH 08/11] t4014: more tests about appending s-o-b lines
Date: Sun, 25 Nov 2012 17:45:56 -0800
Message-ID: <1353894359-6733-9-git-send-email-drafnel@gmail.com>
References: <1353894359-6733-1-git-send-email-drafnel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: pclouds@gmail.com, gitster@pobox.com,
	Brandon Casey <bcasey@nvidia.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 26 02:48:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tcnnv-0007j0-Ue
	for gcvg-git-2@plane.gmane.org; Mon, 26 Nov 2012 02:48:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753854Ab2KZBr5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Nov 2012 20:47:57 -0500
Received: from mail-pa0-f46.google.com ([209.85.220.46]:40660 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753846Ab2KZBr4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Nov 2012 20:47:56 -0500
Received: by mail-pa0-f46.google.com with SMTP id bh2so4644001pad.19
        for <git@vger.kernel.org>; Sun, 25 Nov 2012 17:47:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=efJkzEYWkDN9ptGqtjztHJ7Fs3yNwQ/VwaxD3bqqM40=;
        b=zV2bzcwL6lPG3tq7zG5XwehUnNjUvuU2myQUpyysiRM5EkgzojwTBE8BzjmO1itaKW
         FXX6JfO4nIZOZidRQTSPXbzy8RKPVir55wH5ZnsROzOdqXKz/3ooZaLNkL25oXrBwuhA
         Zq14veqGOpIpC1+RgxyGOdmFX66eIbuJdM95zwT7M0Q5oyr9+4L05Z42lS6jIMq9aqOC
         fUzvUbCSsUfp9LjNgSuttFI9eFWmFlTX9dnMYCxocn3EcvJq1KvlYF8L6+QW1EFRPh6p
         Iucgkn5HSUPs1gPjDToRnqLJa7reFFu6etnbfyRAbmYC/8xGyBGTMp/Wyc8hZVZDxZw7
         EQAQ==
Received: by 10.66.85.138 with SMTP id h10mr28580764paz.40.1353894476423;
        Sun, 25 Nov 2012 17:47:56 -0800 (PST)
Received: from charliebrown.sbx05686.santaca.wayport.net (dhcp64-134-221-228.hoic.dca.wayport.net. [64.134.221.228])
        by mx.google.com with ESMTPS id ot5sm7828428pbb.29.2012.11.25.17.47.48
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 25 Nov 2012 17:47:55 -0800 (PST)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1353894359-6733-1-git-send-email-drafnel@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210398>

=46rom: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>

[bc: fix test 90 "signoff: some random signoff-alike" and mark as faili=
ng.
     Correct behavior should insert a blank line after message body and
     signed-off-by ]

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Brandon Casey <bcasey@nvidia.com>
---
 t/t4014-format-patch.sh | 146 ++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 file changed, 146 insertions(+)

diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 16a4ca1..dfe9209 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -963,4 +963,150 @@ test_expect_success 'format patch ignores color.u=
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
1.8.0.284.g959048a
