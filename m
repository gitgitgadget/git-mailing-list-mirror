From: Alexey Shumkin <alex.crezoff@gmail.com>
Subject: [PATCH v2 2/2] pretty.c: format string with truncate respects logOutputEncoding
Date: Fri, 16 May 2014 19:40:33 +0400
Message-ID: <01a8e808974159833cc18fe8e5ab1ac7ea4e8369.1400254654.git.Alex.Crezoff@gmail.com>
References: <cover.1400254654.git.Alex.Crezoff@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Alexey Shumkin <Alex.Crezoff@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 16 17:41:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlKG1-0002Rm-8X
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 17:41:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932843AbaEPPlH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 May 2014 11:41:07 -0400
Received: from mail-lb0-f182.google.com ([209.85.217.182]:55267 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932655AbaEPPlG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2014 11:41:06 -0400
Received: by mail-lb0-f182.google.com with SMTP id z11so1861540lbi.13
        for <git@vger.kernel.org>; Fri, 16 May 2014 08:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=yAJSUJWYKbbaH+mhqEAvkdmtNItGuD0oTDlLzewaen4=;
        b=hRHlfGS87xZBeJDD4STOd/MKM00U99GHA5GGLlCpAJ/fsGuPzcxaxphKc/ru9ykhR8
         dJbSE6juYosaEDGmdM7ZJfqZRL40ToD5HuCX9P4FRjbxV+gmexAd8jDNqEOgsvlt2I1e
         kEP/c4aMrRzkRjDQd0EBctp/eE58jY5D8vHxFf5wp+GyGNvrhyd4/AdJXsVZ3lZXSz4h
         AmnBovn7cq1AlEOj7lbVgvQMYFpqYVN6qyJBRwuLketSgWecMAVa9DMWwfCgnuf6ENT6
         ec+AnYcfSeWYzmGYnUuytxk+yStT6Sjsr7n7N2aQliMBd0QsAlA52y+W0vQ8B9xstY/E
         fnjw==
X-Received: by 10.112.180.225 with SMTP id dr1mr2366678lbc.51.1400254864799;
        Fri, 16 May 2014 08:41:04 -0700 (PDT)
Received: from localhost ([193.9.244.4])
        by mx.google.com with ESMTPSA id r2sm9879645laa.5.2014.05.16.08.41.03
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 May 2014 08:41:04 -0700 (PDT)
X-Google-Original-From: Alexey Shumkin <Alex.Crezoff@gmail.com>
X-Mailer: git-send-email 1.9.2-17
In-Reply-To: <cover.1400254654.git.Alex.Crezoff@gmail.com>
In-Reply-To: <cover.1400254654.git.Alex.Crezoff@gmail.com>
References: <CACsJy8B20XMiNqtG9c-cLERd8-zahcvWU=UnY80ZJUmLD91ZKg@mail.gmail.com> <cover.1400254654.git.Alex.Crezoff@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249352>

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
index 6791e0d..7426fe2 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -231,7 +231,7 @@ EOF
 	test_cmp expected actual
 '
=20
-test_expect_failure 'left alignment formatting with trunc. i18n.logOut=
putEncoding' '
+test_expect_success 'left alignment formatting with trunc. i18n.logOut=
putEncoding' '
 	git -c i18n.logOutputEncoding=3Diso8859-1 log --pretty=3D"format:%<(1=
0,trunc)%s" >actual &&
 	# complete the incomplete line at the end
 	echo >>actual &&
@@ -257,7 +257,7 @@ EOF
 	test_cmp expected actual
 '
=20
-test_expect_failure 'left alignment formatting with ltrunc. i18n.logOu=
tputEncoding' '
+test_expect_success 'left alignment formatting with ltrunc. i18n.logOu=
tputEncoding' '
 	git -c i18n.logOutputEncoding=3Diso8859-1 log --pretty=3D"format:%<(1=
0,ltrunc)%s" >actual &&
 	# complete the incomplete line at the end
 	echo >>actual &&
@@ -283,7 +283,7 @@ EOF
 	test_cmp expected actual
 '
=20
-test_expect_failure 'left alignment formatting with mtrunc. i18n.logOu=
tputEncoding' '
+test_expect_success 'left alignment formatting with mtrunc. i18n.logOu=
tputEncoding' '
 	git -c i18n.logOutputEncoding=3Diso8859-1 log --pretty=3D"format:%<(1=
0,mtrunc)%s" >actual &&
 	# complete the incomplete line at the end
 	echo >>actual &&
@@ -465,7 +465,7 @@ EOF
 	test_cmp expected actual
 '
=20
-test_expect_failure 'left/right alignment formatting with stealing. i1=
8n.logOutputEncoding' '
+test_expect_success 'left/right alignment formatting with stealing. i1=
8n.logOutputEncoding' '
 	git commit --amend -m short --author "long long long <long@me.com>" &=
&
 	git -c i18n.logOutputEncoding=3Diso8859-1 log --pretty=3D"format:%<(1=
0,trunc)%s%>>(10,ltrunc)% an" >actual &&
 	# complete the incomplete line at the end
diff --git a/t/t6006-rev-list-format.sh b/t/t6006-rev-list-format.sh
index 09cdf24..04811fd 100755
--- a/t/t6006-rev-list-format.sh
+++ b/t/t6006-rev-list-format.sh
@@ -256,7 +256,7 @@ commit $head1
 $added_iso88591
 EOF
=20
-test_format complex-subject-trunc %<($truncate_count,trunc)%s failure =
<<EOF
+test_format complex-subject-trunc %<($truncate_count,trunc)%s <<EOF
 commit $head3
 Test printing of c..
 commit $head2
@@ -265,7 +265,7 @@ commit $head1
 added (hinzugef${added_utf8_part_iso88591}gt..
 EOF
=20
-test_format complex-subject-mtrunc %<($truncate_count,mtrunc)%s failur=
e <<EOF
+test_format complex-subject-mtrunc %<($truncate_count,mtrunc)%s <<EOF
 commit $head3
 Test prin..ex bodies
 commit $head2
@@ -274,7 +274,7 @@ commit $head1
 added (hi..f${added_utf8_part_iso88591}gt) foo
 EOF
=20
-test_format complex-subject-ltrunc %<($truncate_count,ltrunc)%s failur=
e <<EOF
+test_format complex-subject-ltrunc %<($truncate_count,ltrunc)%s <<EOF
 commit $head3
 .. of complex bodies
 commit $head2
--=20
1.9.2-17
