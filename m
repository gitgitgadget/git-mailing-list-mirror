From: =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <schnhrr@cs.tu-berlin.de>
Subject: [PATCH v2 2/7] format-patch: do not wrap non-rfc2047 headers too early
Date: Thu, 18 Oct 2012 16:43:29 +0200
Message-ID: <1350571414-17907-3-git-send-email-schnhrr@cs.tu-berlin.de>
References: <1350571414-17907-1-git-send-email-schnhrr@cs.tu-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <schnhrr@cs.tu-berlin.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 18 16:45:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOrLo-0005Ni-LV
	for gcvg-git-2@plane.gmane.org; Thu, 18 Oct 2012 16:45:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756570Ab2JROpS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Oct 2012 10:45:18 -0400
Received: from mail.eecsit.tu-berlin.de ([130.149.17.13]:58379 "EHLO
	mail.cs.tu-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756203Ab2JROpR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2012 10:45:17 -0400
Received: from localhost (localhost [127.0.0.1])
	by localhost-12225.cs.tu-berlin.de (Postfix) with ESMTP id 9599661D1
	for <git@vger.kernel.org>; Thu, 18 Oct 2012 16:45:15 +0200 (CEST)
X-Virus-Scanned: amavisd-new at cs.tu-berlin.de (including SpamAssassin)
Received: from mailhost.cs.tu-berlin.de ([127.0.0.1])
	by localhost (mail.cs.tu-berlin.de [127.0.0.1]) (amavisd-new, port 12224)
	with ESMTP id OOD1kHMiFeWv 04292-16;
	Thu, 18 Oct 2012 16:45:03 +0200 (CEST) 13698
Received: from asahi.kbs.tu-berlin.de (asahi.kbs.tu-berlin.de [130.149.91.59])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: schnhrr)
	by mailhost.cs.tu-berlin.de (Postfix) with ESMTPSA;
	Thu, 18 Oct 2012 16:45:03 +0200 (CEST)
X-Mailer: git-send-email 1.7.12
In-Reply-To: <1350571414-17907-1-git-send-email-schnhrr@cs.tu-berlin.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208009>

=46rom: Jan H. Sch=C3=B6nherr <schnhrr@cs.tu-berlin.de>

Do not wrap the second and later lines of non-rfc2047-encoded headers
substantially before the 78 character limit.

Instead of passing the remaining length of the first line as wrapping
width, use the correct maximum length and tell strbuf_add_wrapped_bytes=
()
how many characters of the first line are already used.

Signed-off-by: Jan H. Sch=C3=B6nherr <schnhrr@cs.tu-berlin.de>
---
v2:
- removed off-by-one correction now handled by first patch
- commit message clarifications
---
 pretty.c                |  2 +-
 t/t4014-format-patch.sh | 60 ++++++++++++++++++++++++++++-------------=
--------
 2 Dateien ge=C3=A4ndert, 35 Zeilen hinzugef=C3=BCgt(+), 27 Zeilen entf=
ernt(-)

diff --git a/pretty.c b/pretty.c
index 8b1ea9f..71e4024 100644
--- a/pretty.c
+++ b/pretty.c
@@ -286,7 +286,7 @@ static void add_rfc2047(struct strbuf *sb, const ch=
ar *line, int len,
 		if ((i + 1 < len) && (ch =3D=3D '=3D' && line[i+1] =3D=3D '?'))
 			goto needquote;
 	}
-	strbuf_add_wrapped_bytes(sb, line, len, 0, 1, max_length - line_len);
+	strbuf_add_wrapped_bytes(sb, line, len, -line_len, 1, max_length);
 	return;
=20
 needquote:
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 959aa26..d66e358 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -752,16 +752,14 @@ M64=3D$M8$M8$M8$M8$M8$M8$M8$M8
 M512=3D$M64$M64$M64$M64$M64$M64$M64$M64
 cat >expect <<'EOF'
 Subject: [PATCH] foo bar foo bar foo bar foo bar foo bar foo bar foo b=
ar foo
- bar foo bar foo bar foo bar foo bar foo bar foo bar foo bar
- foo bar foo bar foo bar foo bar foo bar foo bar foo bar foo
- bar foo bar foo bar foo bar foo bar foo bar foo bar foo bar
- foo bar foo bar foo bar foo bar foo bar foo bar foo bar foo
- bar foo bar foo bar foo bar foo bar foo bar foo bar foo bar
- foo bar foo bar foo bar foo bar foo bar foo bar foo bar foo
- bar foo bar foo bar foo bar foo bar foo bar foo bar foo bar
- foo bar foo bar foo bar foo bar
+ bar foo bar foo bar foo bar foo bar foo bar foo bar foo bar foo bar f=
oo bar
+ foo bar foo bar foo bar foo bar foo bar foo bar foo bar foo bar foo b=
ar foo
+ bar foo bar foo bar foo bar foo bar foo bar foo bar foo bar foo bar f=
oo bar
+ foo bar foo bar foo bar foo bar foo bar foo bar foo bar foo bar foo b=
ar foo
+ bar foo bar foo bar foo bar foo bar foo bar foo bar foo bar foo bar f=
oo bar
+ foo bar foo bar foo bar foo bar foo bar foo bar foo bar foo bar foo b=
ar
 EOF
-test_expect_success 'format-patch wraps extremely long headers (ascii)=
' '
+test_expect_success 'format-patch wraps extremely long subject (ascii)=
' '
 	echo content >>file &&
 	git add file &&
 	git commit -m "$M512" &&
@@ -807,28 +805,12 @@ test_expect_success 'format-patch wraps extremely=
 long headers (rfc2047)' '
 	test_cmp expect subject
 '
=20
-M8=3D"foo_bar_"
-M64=3D$M8$M8$M8$M8$M8$M8$M8$M8
-cat >expect <<EOF
-From: $M64
- <foobar@foo.bar>
-EOF
-test_expect_success 'format-patch wraps non-quotable headers' '
-	rm -rf patches/ &&
-	echo content >>file &&
-	git add file &&
-	git commit -mfoo --author "$M64 <foobar@foo.bar>" &&
-	git format-patch --stdout -1 >patch &&
-	sed -n "/^From: /p; /^ /p; /^$/q" <patch >from &&
-	test_cmp expect from
-'
-
 check_author() {
 	echo content >>file &&
 	git add file &&
 	GIT_AUTHOR_NAME=3D$1 git commit -m author-check &&
 	git format-patch --stdout -1 >patch &&
-	grep ^From: patch >actual &&
+	sed -n "/^From: /p; /^ /p; /^$/q" <patch >actual &&
 	test_cmp expect actual
 }
=20
@@ -853,6 +835,32 @@ test_expect_success 'rfc2047-encoded headers also =
double-quote 822 specials' '
 	check_author "F=C3=B6o B. Bar"
 '
=20
+cat >expect <<EOF
+From: foo_bar_foo_bar_foo_bar_foo_bar_foo_bar_foo_bar_foo_bar_foo_bar_
+ <author@example.com>
+EOF
+test_expect_success 'format-patch wraps moderately long from-header (a=
scii)' '
+	check_author "foo_bar_foo_bar_foo_bar_foo_bar_foo_bar_foo_bar_foo_bar=
_foo_bar_"
+'
+
+cat >expect <<'EOF'
+From: Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar =
=46oo Bar
+ Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo B=
ar Foo
+ Bar Foo Bar Foo Bar Foo Bar <author@example.com>
+EOF
+test_expect_success 'format-patch wraps extremely long from-header (as=
cii)' '
+	check_author "Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar=
 Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Ba=
r Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar"
+'
+
+cat >expect <<'EOF'
+From: "Foo.Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar=
 Foo Bar
+ Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo B=
ar Foo
+ Bar Foo Bar Foo Bar Foo Bar" <author@example.com>
+EOF
+test_expect_success 'format-patch wraps extremely long from-header (rf=
c822)' '
+	check_author "Foo.Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar=
 Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Ba=
r Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar"
+'
+
 cat >expect <<'EOF'
 Subject: header with . in it
 EOF
--=20
1.7.12
