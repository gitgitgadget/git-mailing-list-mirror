From: Alexey Shumkin <alex.crezoff@gmail.com>
Subject: [PATCH v4 5/5] pretty.c: format string with truncate respects logOutputEncoding
Date: Wed, 21 May 2014 17:20:07 +0400
Message-ID: <ee7b2aa742a2fd287a57a38239d5eb71b9f50ef9.1400678003.git.Alex.Crezoff@gmail.com>
References: <cover.1400678003.git.Alex.Crezoff@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Alexey Shumkin <Alex.Crezoff@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 21 15:21:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wn6SC-0002dn-Ob
	for gcvg-git-2@plane.gmane.org; Wed, 21 May 2014 15:21:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752713AbaEUNUw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 May 2014 09:20:52 -0400
Received: from mail-la0-f53.google.com ([209.85.215.53]:39430 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752294AbaEUNUv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 May 2014 09:20:51 -0400
Received: by mail-la0-f53.google.com with SMTP id ty20so7848lab.40
        for <git@vger.kernel.org>; Wed, 21 May 2014 06:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=TGyyjAWhriqIltJ3rKlI7TSwzXTOgWUMbaf4bNDo9Do=;
        b=x1rW6taugrPo9pWvVaKHMr+GLMKkkye/Zq7/7VEPCFalhbSW1SPlPCFBqaGZ4OiQVm
         XoTFC1KvkSQ9BSLKge8DuWBVC1qFSpvR3ycsBlOVS8fEfm+qJw2cTo5kJGrkYQdRKXZL
         amz4fuU8xmxFljwpZKjdxMoa+j6jcahPar2dlJ9Pbmu11pDWNtKCh64gDF1u2E0epT/C
         bueusWeNo9U+OSe0PT+clbNdza8emgNZeMijAmmojdA/D5Y2mu/WUGQpJKBqQzIQE9DK
         kYqu93ZZliyzLttDlfVdDx5c6bkhuhpT8vclyZaJPEgW6cd1+AHyNaBofhFvRbc5TrNX
         xj8A==
X-Received: by 10.112.52.167 with SMTP id u7mr35625849lbo.28.1400678449017;
        Wed, 21 May 2014 06:20:49 -0700 (PDT)
Received: from localhost (ppp91-77-196-183.pppoe.mtu-net.ru. [91.77.196.183])
        by mx.google.com with ESMTPSA id o8sm11932658laj.10.2014.05.21.06.20.46
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 May 2014 06:20:48 -0700 (PDT)
X-Google-Original-From: Alexey Shumkin <Alex.Crezoff@gmail.com>
X-Mailer: git-send-email 1.9.2-15
In-Reply-To: <cover.1400678003.git.Alex.Crezoff@gmail.com>
In-Reply-To: <cover.1400678003.git.Alex.Crezoff@gmail.com>
References: <cover.1400513063.git.Alex.Crezoff@gmail.com> <cover.1400678003.git.Alex.Crezoff@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249799>

Pretty format string %<(N,[ml]trunc)>%s truncates subject to a given
length with an appropriate padding. This works for non-ASCII texts when
i18n.logOutputEncoding is UTF-8 only (independently of a printed commit
message encoding) but does not work when i18n.logOutputEncoding is NOT
UTF-8.

In 7e77df3 (pretty: two phase conversion for non utf-8 commits, 2013-04=
-19)
'format_commit_item' function assumes commit message to be in UTF-8.
And that was so until ecaee80 (pretty: --format output should honor
logOutputEncoding, 2013-06-26) where conversion to logOutputEncoding wa=
s
added before calling 'format_commit_message'.

Correct this by converting a commit message to UTF-8 first (as it
assumed in 7e77df3 (pretty: two phase conversion for non utf-8 commits,
2013-04-19)). Only after that convert a commit message to an actual
logOutputEncoding.

Signed-off-by: Alexey Shumkin <Alex.Crezoff@gmail.com>
Reviewed-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>
---
 pretty.c                      | 7 ++++++-
 t/t4205-log-pretty-formats.sh | 8 ++++----
 t/t6006-rev-list-format.sh    | 6 +++---
 3 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/pretty.c b/pretty.c
index 6e266dd..25e8825 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1507,13 +1507,18 @@ void format_commit_message(const struct commit =
*commit,
 	context.commit =3D commit;
 	context.pretty_ctx =3D pretty_ctx;
 	context.wrap_start =3D sb->len;
+	/*
+	 * convert a commit message to UTF-8 first
+	 * as far as 'format_commit_item' assumes it in UTF-8
+	 */
 	context.message =3D logmsg_reencode(commit,
 					  &context.commit_encoding,
-					  output_enc);
+					  utf8);
=20
 	strbuf_expand(sb, format, format_commit_item, &context);
 	rewrap_message_tail(sb, &context, 0, 0, 0);
=20
+	/* then convert a commit message to an actual output encoding */
 	if (output_enc) {
 		if (same_encoding(utf8, output_enc))
 			output_enc =3D NULL;
diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats=
=2Esh
index 74babce..c84ec9a 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -220,7 +220,7 @@ EOF
 	test_cmp expected actual
 '
=20
-test_expect_failure 'left alignment formatting with trunc. i18n.logOut=
putEncoding' '
+test_expect_success 'left alignment formatting with trunc. i18n.logOut=
putEncoding' '
 	git -c i18n.logOutputEncoding=3D$test_encoding log --pretty=3D"tforma=
t:%<(10,trunc)%s" >actual &&
 	qz_to_tab_space <<EOF | iconv -f utf-8 -t $test_encoding >expected &&
 message ..
@@ -242,7 +242,7 @@ EOF
 	test_cmp expected actual
 '
=20
-test_expect_failure 'left alignment formatting with ltrunc. i18n.logOu=
tputEncoding' '
+test_expect_success 'left alignment formatting with ltrunc. i18n.logOu=
tputEncoding' '
 	git -c i18n.logOutputEncoding=3D$test_encoding log --pretty=3D"tforma=
t:%<(10,ltrunc)%s" >actual &&
 	qz_to_tab_space <<EOF | iconv -f utf-8 -t $test_encoding >expected &&
 ..sage two
@@ -264,7 +264,7 @@ EOF
 	test_cmp expected actual
 '
=20
-test_expect_failure 'left alignment formatting with mtrunc. i18n.logOu=
tputEncoding' '
+test_expect_success 'left alignment formatting with mtrunc. i18n.logOu=
tputEncoding' '
 	git -c i18n.logOutputEncoding=3D$test_encoding log --pretty=3D"tforma=
t:%<(10,mtrunc)%s" >actual &&
 	qz_to_tab_space <<EOF | iconv -f utf-8 -t $test_encoding >expected &&
 mess.. two
@@ -420,7 +420,7 @@ initial...   A U Thor
 EOF
 	test_cmp expected actual
 '
-test_expect_failure 'left/right alignment formatting with stealing. i1=
8n.logOutputEncoding' '
+test_expect_success 'left/right alignment formatting with stealing. i1=
8n.logOutputEncoding' '
 	git -c i18n.logOutputEncoding=3D$test_encoding log --pretty=3D"tforma=
t:%<(10,trunc)%s%>>(10,ltrunc)% an" >actual &&
 	cat <<EOF | iconv -f utf-8 -t $test_encoding >expected &&
 short long  long long
diff --git a/t/t6006-rev-list-format.sh b/t/t6006-rev-list-format.sh
index 42bdefe..19434ad 100755
--- a/t/t6006-rev-list-format.sh
+++ b/t/t6006-rev-list-format.sh
@@ -259,7 +259,7 @@ commit $head1
 $added_iso88591
 EOF
=20
-test_format complex-subject-trunc "%<($truncate_count,trunc)%s" failur=
e <<EOF
+test_format complex-subject-trunc "%<($truncate_count,trunc)%s" <<EOF
 commit $head3
 Test printing of c..
 commit $head2
@@ -268,7 +268,7 @@ commit $head1
 added (hinzugef${added_utf8_part_iso88591}gt..
 EOF
=20
-test_format complex-subject-mtrunc "%<($truncate_count,mtrunc)%s" fail=
ure <<EOF
+test_format complex-subject-mtrunc "%<($truncate_count,mtrunc)%s" <<EO=
=46
 commit $head3
 Test prin..ex bodies
 commit $head2
@@ -277,7 +277,7 @@ commit $head1
 added (hi..f${added_utf8_part_iso88591}gt) foo
 EOF
=20
-test_format complex-subject-ltrunc "%<($truncate_count,ltrunc)%s" fail=
ure <<EOF
+test_format complex-subject-ltrunc "%<($truncate_count,ltrunc)%s" <<EO=
=46
 commit $head3
 .. of complex bodies
 commit $head2
--=20
1.9.2-15
