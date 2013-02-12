From: Brandon Casey <drafnel@gmail.com>
Subject: [PATCH v4 12/12] Unify appending signoff in format-patch, commit and sequencer
Date: Tue, 12 Feb 2013 02:17:39 -0800
Message-ID: <1360664260-11803-13-git-send-email-drafnel@gmail.com>
References: <1360664260-11803-1-git-send-email-drafnel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, pclouds@gmail.com, jrnieder@gmail.com,
	Brandon Casey <drafnel@gmail.com>,
	Brandon Casey <bcasey@nvidia.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 12 11:19:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5CxF-0003dA-Ls
	for gcvg-git-2@plane.gmane.org; Tue, 12 Feb 2013 11:19:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932992Ab3BLKSn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Feb 2013 05:18:43 -0500
Received: from mail-pa0-f52.google.com ([209.85.220.52]:55490 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932980Ab3BLKSk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2013 05:18:40 -0500
Received: by mail-pa0-f52.google.com with SMTP id fb1so9273pad.11
        for <git@vger.kernel.org>; Tue, 12 Feb 2013 02:18:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=QqSe3CjsAuAN49BhFehHvo+Ag2kSycsRzUHM+eO7UUg=;
        b=0aKJcOX7eW8DEJ+QJFGCC3ah40Bp8zDfAK09+VKO2bbYY+dtayW6/dL3RzCmOAya/1
         cnYKVxKW6UYjE5nHk47c1jfOil4Fqc+cfVUmMiTrq47NL45r/0X6W8xmOpg2xAKmOIG2
         g668hyXCI2h7QHox4LaNb70OBXZ1HI6aZ8C1ll6ihIXMkCFDvPM9GoL9V8mqN6rBeTxw
         NoGYhinXaqhNsV97irVr9hphC7+PSWfI2K4oxWnFjz0BJTb5fKAVZnHz9oevlhxGKC/R
         RTtVKLdMsKp7ZcNmhnmFllQ0q98KIm5i9YNgAQtCGMfaAA75WOCZJdnzYD0wLSeae+hc
         Fi3Q==
X-Received: by 10.66.9.2 with SMTP id v2mr50646108paa.18.1360664320209;
        Tue, 12 Feb 2013 02:18:40 -0800 (PST)
Received: from charliebrown.hsd1.ca.comcast.net (c-98-248-42-122.hsd1.ca.comcast.net. [98.248.42.122])
        by mx.google.com with ESMTPS id l5sm73839001pax.10.2013.02.12.02.18.37
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 12 Feb 2013 02:18:39 -0800 (PST)
X-Mailer: git-send-email 1.8.1.1.252.gdb33759
In-Reply-To: <1360664260-11803-1-git-send-email-drafnel@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216142>

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
 log-tree.c              | 91 +----------------------------------------=
--------
 t/t4014-format-patch.sh | 31 ++++++++++++++---
 2 files changed, 27 insertions(+), 95 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index ac1cd68..c9d9a37 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -9,8 +9,7 @@
 #include "string-list.h"
 #include "color.h"
 #include "gpg-interface.h"
-
-#define APPEND_SIGNOFF_DEDUP (1u <<0)
+#include "sequencer.h"
=20
 struct decoration name_decoration =3D { "object names" };
=20
@@ -208,94 +207,6 @@ void show_decorations(struct rev_info *opt, struct=
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
-static void append_signoff(struct strbuf *sb, int ignore_footer, unsig=
ned flag)
-{
-	unsigned no_dup_sob =3D flag & APPEND_SIGNOFF_DEDUP;
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
index a415b89..97fde9e 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -1103,7 +1103,28 @@ EOF
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
@@ -1119,7 +1140,7 @@ EOF
 	test_cmp expected actual
 '
=20
-test_expect_failure 'signoff: not really a signoff' '
+test_expect_success 'signoff: not really a signoff' '
 	append_signoff <<\EOF >actual &&
 subject
=20
@@ -1135,7 +1156,7 @@ EOF
 	test_cmp expected actual
 '
=20
-test_expect_failure 'signoff: not really a signoff (2)' '
+test_expect_success 'signoff: not really a signoff (2)' '
 	append_signoff <<\EOF >actual &&
 subject
=20
@@ -1152,7 +1173,7 @@ EOF
 	test_cmp expected actual
 '
=20
-test_expect_failure 'signoff: valid S-o-b paragraph in the middle' '
+test_expect_success 'signoff: valid S-o-b paragraph in the middle' '
 	append_signoff <<\EOF >actual &&
 subject
=20
@@ -1220,7 +1241,7 @@ EOF
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
1.8.1.3.579.gd9af3b6
