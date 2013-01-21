From: Brandon Casey <drafnel@gmail.com>
Subject: [PATCH v2 10/10] Unify appending signoff in format-patch, commit and sequencer
Date: Mon, 21 Jan 2013 00:40:27 -0800
Message-ID: <1358757627-16682-11-git-send-email-drafnel@gmail.com>
References: <1358757627-16682-1-git-send-email-drafnel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: pclouds@gmail.com, git@vger.kernel.org,
	Brandon Casey <drafnel@gmail.com>,
	Brandon Casey <bcasey@nvidia.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jan 21 09:41:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxCwc-00033Z-07
	for gcvg-git-2@plane.gmane.org; Mon, 21 Jan 2013 09:41:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752578Ab3AUIlF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Jan 2013 03:41:05 -0500
Received: from mail-pb0-f41.google.com ([209.85.160.41]:62082 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752111Ab3AUIlD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2013 03:41:03 -0500
Received: by mail-pb0-f41.google.com with SMTP id xa7so3214927pbc.28
        for <git@vger.kernel.org>; Mon, 21 Jan 2013 00:41:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=I8RdwRfyS3rd1cp/EbKN+r0MoesDeMF47XIn+wXtIpg=;
        b=goi8ruvTA2fj7irZdAVl8L1+9qnbtAcmjafToMPRxAprS4buxA7HILr1zf139Mt47E
         NKIKAy2MAt85nd2g4SYgwF1Bkh+fMiAXtuu0NmMdbZOskW65BkYW4okvMoCua6uEaW2m
         9ZjZ7VTwmjToKTk+HRbb0fFvf64374SXbLwfWH7TywvMJOdpu4b1pye/oI4cJFOuQyjs
         gbfrns/eahOcj6091QPeGO7MPJNknNXf8zoNLrTqqlJuVM4WNUSn3kNx24AIXZgVU7se
         gmwhKgkeMnv5mLpTK12Rbt2wkXXowUJ3bY5QTXGw4bbwmqBMARpPdt54YGJTWaEV/lpZ
         MOFQ==
X-Received: by 10.68.241.103 with SMTP id wh7mr27936114pbc.153.1358757662665;
        Mon, 21 Jan 2013 00:41:02 -0800 (PST)
Received: from charliebrown.hsd1.ca.comcast.net (c-98-248-42-122.hsd1.ca.comcast.net. [98.248.42.122])
        by mx.google.com with ESMTPS id x2sm8883757paw.8.2013.01.21.00.41.01
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 21 Jan 2013 00:41:02 -0800 (PST)
X-Mailer: git-send-email 1.8.1.1.252.gdb33759
In-Reply-To: <1358757627-16682-1-git-send-email-drafnel@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214103>

There are two implementations of append_signoff in log-tree.c and
sequencer.c, which do more or less the same thing.  Unify on top of the
sequencer.c implementation.

Add a test in t4014 to demonstrate support for non-s-o-b elements in th=
e
commit footer provided by sequence.c:append_sob.  Mark tests fixed as
appropriate.

[Commit message mostly stolen from Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8D=
c Duy's original
 unification patch]

Signed-off-by: Brandon Casey <bcasey@nvidia.com>
---
 log-tree.c              | 88 +----------------------------------------=
--------
 t/t4014-format-patch.sh | 31 ++++++++++++++---
 2 files changed, 27 insertions(+), 92 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index 83f33f4..299dad3 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -9,6 +9,7 @@
 #include "string-list.h"
 #include "color.h"
 #include "gpg-interface.h"
+#include "sequencer.h"
=20
 struct decoration name_decoration =3D { "object names" };
=20
@@ -206,93 +207,6 @@ void show_decorations(struct rev_info *opt, struct=
 commit *commit)
 	putchar(')');
 }
=20
-/*
- * Search for "^[-A-Za-z]+: [^@]+@" pattern. It usually matches
- * Signed-off-by: and Acked-by: lines.
- */
-static int detect_any_signoff(char *letter, int size)
-{
-	char *cp;
-	int seen_colon =3D 0;
-	int seen_at =3D 0;
-	int seen_name =3D 0;
-	int seen_head =3D 0;
-
-	cp =3D letter + size;
-	while (letter <=3D --cp && *cp =3D=3D '\n')
-		continue;
-
-	while (letter <=3D cp) {
-		char ch =3D *cp--;
-		if (ch =3D=3D '\n')
-			break;
-
-		if (!seen_at) {
-			if (ch =3D=3D '@')
-				seen_at =3D 1;
-			continue;
-		}
-		if (!seen_colon) {
-			if (ch =3D=3D '@')
-				return 0;
-			else if (ch =3D=3D ':')
-				seen_colon =3D 1;
-			else
-				seen_name =3D 1;
-			continue;
-		}
-		if (('A' <=3D ch && ch <=3D 'Z') ||
-		    ('a' <=3D ch && ch <=3D 'z') ||
-		    ch =3D=3D '-') {
-			seen_head =3D 1;
-			continue;
-		}
-		/* no empty last line doesn't match */
-		return 0;
-	}
-	return seen_head && seen_name;
-}
-
-static void append_signoff(struct strbuf *sb, int ignore_footer, int n=
o_dup_sob)
-{
-	static const char signed_off_by[] =3D "Signed-off-by: ";
-	char *signoff =3D xstrdup(fmt_name(getenv("GIT_COMMITTER_NAME"),
-					       getenv("GIT_COMMITTER_EMAIL")));
-	size_t signoff_len =3D strlen(signoff);
-	int has_signoff =3D 0;
-	char *cp;
-
-	cp =3D sb->buf;
-
-	/* First see if we already have the sign-off by the signer */
-	while ((cp =3D strstr(cp, signed_off_by))) {
-
-		has_signoff =3D 1;
-
-		cp +=3D strlen(signed_off_by);
-		if (cp + signoff_len >=3D sb->buf + sb->len)
-			break;
-		if (strncmp(cp, signoff, signoff_len))
-			continue;
-		if (!isspace(cp[signoff_len]))
-			continue;
-		/* we already have him */
-		free(signoff);
-		return;
-	}
-
-	if (!has_signoff)
-		has_signoff =3D detect_any_signoff(sb->buf, sb->len);
-
-	if (!has_signoff)
-		strbuf_addch(sb, '\n');
-
-	strbuf_addstr(sb, signed_off_by);
-	strbuf_add(sb, signoff, signoff_len);
-	strbuf_addch(sb, '\n');
-	free(signoff);
-}
-
 static unsigned int digits_in_number(unsigned int number)
 {
 	unsigned int i =3D 10, result =3D 1;
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 3868cef..d0ec097 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -1104,7 +1104,28 @@ EOF
 	test_cmp expected actual
 '
=20
-test_expect_failure 'signoff: some random signoff-alike' '
+test_expect_success 'signoff: misc conforming footer elements' '
+	append_signoff <<\EOF >actual &&
+subject
+
+body
+
+Signed-off-by: my@house
+(cherry picked from commit da39a3ee5e6b4b0d3255bfef95601890afd80709)
+Tested-by: Some One <someone@example.com>
+Bug: 1234
+EOF
+	cat >expected <<\EOF &&
+4:Subject: [PATCH] subject
+8:
+10:
+11:Signed-off-by: my@house
+15:Signed-off-by: C O Mitter <committer@example.com>
+EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'signoff: some random signoff-alike' '
 	append_signoff <<\EOF >actual &&
 subject
=20
@@ -1120,7 +1141,7 @@ EOF
 	test_cmp expected actual
 '
=20
-test_expect_failure 'signoff: not really a signoff' '
+test_expect_success 'signoff: not really a signoff' '
 	append_signoff <<\EOF >actual &&
 subject
=20
@@ -1136,7 +1157,7 @@ EOF
 	test_cmp expected actual
 '
=20
-test_expect_failure 'signoff: not really a signoff (2)' '
+test_expect_success 'signoff: not really a signoff (2)' '
 	append_signoff <<\EOF >actual &&
 subject
=20
@@ -1153,7 +1174,7 @@ EOF
 	test_cmp expected actual
 '
=20
-test_expect_failure 'signoff: valid S-o-b paragraph in the middle' '
+test_expect_success 'signoff: valid S-o-b paragraph in the middle' '
 	append_signoff <<\EOF >actual &&
 subject
=20
@@ -1221,7 +1242,7 @@ EOF
 	test_cmp expected actual
 '
=20
-test_expect_failure 'signoff: detect garbage in non-conforming footer'=
 '
+test_expect_success 'signoff: detect garbage in non-conforming footer'=
 '
 	append_signoff <<\EOF >actual &&
 subject
=20
--=20
1.8.1.1.252.gdb33759
