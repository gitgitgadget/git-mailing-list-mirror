From: Alexey Shumkin <alex.crezoff@gmail.com>
Subject: [PATCH 1/2] t4205 (log-pretty-formats): Add failing tests for the case when i18n.logOutputEncoding is set
Date: Fri, 16 May 2014 17:06:30 +0400
Message-ID: <b3195b5f42e11400643efd70b66cb4b7b8d221f4.1400242108.git.Alex.Crezoff@gmail.com>
References: <cover.1400242108.git.Alex.Crezoff@gmail.com>
Cc: Alexey Shumkin <Alex.Crezoff@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 16 15:07:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlHrM-0001WJ-M4
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 15:07:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756831AbaEPNHc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2014 09:07:32 -0400
Received: from mail-la0-f48.google.com ([209.85.215.48]:60469 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756306AbaEPNHb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2014 09:07:31 -0400
Received: by mail-la0-f48.google.com with SMTP id mc6so1928925lab.35
        for <git@vger.kernel.org>; Fri, 16 May 2014 06:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=F2DgNbKE2vkZ+yKlGXefrfJ7mQ8J1wtSuGtJvrgbwcA=;
        b=Cg9BCI01TFc94r90tKr/qseLAnMdudX7S/NWhoK19XHmdJ5aQSy7fwXDY/2O1DkVAr
         ZT5GLRB0X5+aaK8Q4cdOwD0CTF9pe1z6C0yr50LBTI3u1AOpPfF1gyS+g0YLbrumrdMZ
         Wg6r0vsa4TBj9eV4DyGSQvF8LiHAWEMD8Qz6BjxQIpz4PapunvJkXUP+2ummim8BcqL/
         mv2gKgx3PwGzYegsksn5DEwEOsaQrlAIifc9RDvaGzfTxP6gU6H9SBwhUrcURkeeX6t+
         JtB4Wmbr4fxR57YMntpqBXrDkap4S/p685UCqaELy3U14uk2uOthhVNpovJC6nWQKfdm
         Iqdg==
X-Received: by 10.152.20.71 with SMTP id l7mr12183575lae.4.1400245649259;
        Fri, 16 May 2014 06:07:29 -0700 (PDT)
Received: from localhost ([193.9.244.4])
        by mx.google.com with ESMTPSA id sq7sm4890561lbb.10.2014.05.16.06.07.28
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 May 2014 06:07:28 -0700 (PDT)
X-Google-Original-From: Alexey Shumkin <Alex.Crezoff@gmail.com>
X-Mailer: git-send-email 1.9.2-17
In-Reply-To: <cover.1400242108.git.Alex.Crezoff@gmail.com>
In-Reply-To: <cover.1400242108.git.Alex.Crezoff@gmail.com>
References: <cover.1400242108.git.Alex.Crezoff@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249301>

Pretty format string %<(N,[ml]trunc)>%s truncates subject to a given
length with an appropriate padding. This works for non-ASCII texts when
i18n.logOutputEncoding is UTF-8 only (independently of a printed commit
message encoding) but does not work when i18n.logOutputEncoding is NOT
UTF-8.

There were no breakages as far as were no tests for the case
when both a commit message and logOutputEncoding are not UTF-8.

Add failing tests for that which will be fixed in the next patch.

Signed-off-by: Alexey Shumkin <Alex.Crezoff@gmail.com>
---
 t/t4205-log-pretty-formats.sh | 169 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 169 insertions(+)

diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index 2a6278b..6791e0d 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -153,6 +153,19 @@ EOF
 	test_cmp expected actual
 '
 
+test_expect_success 'left alignment formatting. i18n.logOutputEncoding' '
+	git -c i18n.logOutputEncoding=iso8859-1 log --pretty="format:%<(40)%s" >actual &&
+	# complete the incomplete line at the end
+	echo >>actual &&
+	qz_to_tab_space <<EOF | iconv -f utf-8 -t iso8859-1 >expected &&
+message two                            Z
+message one                            Z
+add bar                                Z
+$(commit_msg)                    Z
+EOF
+	test_cmp expected actual
+'
+
 test_expect_success 'left alignment formatting at the nth column' '
 	git log --pretty="format:%h %<|(40)%s" >actual &&
 	# complete the incomplete line at the end
@@ -166,6 +179,19 @@ EOF
 	test_cmp expected actual
 '
 
+test_expect_success 'left alignment formatting at the nth column. i18n.logOutputEncoding' '
+	git -c i18n.logOutputEncoding=iso8859-1 log --pretty="format:%h %<|(40)%s" >actual &&
+	# complete the incomplete line at the end
+	echo >>actual &&
+	qz_to_tab_space <<EOF | iconv -f utf-8 -t iso8859-1 >expected &&
+$head1 message two                    Z
+$head2 message one                    Z
+$head3 add bar                        Z
+$head4 $(commit_msg)            Z
+EOF
+	test_cmp expected actual
+'
+
 test_expect_success 'left alignment formatting with no padding' '
 	git log --pretty="format:%<(1)%s" >actual &&
 	# complete the incomplete line at the end
@@ -179,6 +205,19 @@ EOF
 	test_cmp expected actual
 '
 
+test_expect_success 'left alignment formatting with no padding. i18n.logOutputEncoding' '
+	git -c i18n.logOutputEncoding=iso8859-1 log --pretty="format:%<(1)%s" >actual &&
+	# complete the incomplete line at the end
+	echo >>actual &&
+	cat <<EOF | iconv -f utf-8 -t iso8859-1 >expected &&
+message two
+message one
+add bar
+$(commit_msg)
+EOF
+	test_cmp expected actual
+'
+
 test_expect_success 'left alignment formatting with trunc' '
 	git log --pretty="format:%<(10,trunc)%s" >actual &&
 	# complete the incomplete line at the end
@@ -192,6 +231,19 @@ EOF
 	test_cmp expected actual
 '
 
+test_expect_failure 'left alignment formatting with trunc. i18n.logOutputEncoding' '
+	git -c i18n.logOutputEncoding=iso8859-1 log --pretty="format:%<(10,trunc)%s" >actual &&
+	# complete the incomplete line at the end
+	echo >>actual &&
+	qz_to_tab_space <<EOF | iconv -f utf-8 -t iso8859-1 >expected &&
+message ..
+message ..
+add bar  Z
+initial...
+EOF
+	test_cmp expected actual
+'
+
 test_expect_success 'left alignment formatting with ltrunc' '
 	git log --pretty="format:%<(10,ltrunc)%s" >actual &&
 	# complete the incomplete line at the end
@@ -205,6 +257,19 @@ EOF
 	test_cmp expected actual
 '
 
+test_expect_failure 'left alignment formatting with ltrunc. i18n.logOutputEncoding' '
+	git -c i18n.logOutputEncoding=iso8859-1 log --pretty="format:%<(10,ltrunc)%s" >actual &&
+	# complete the incomplete line at the end
+	echo >>actual &&
+	qz_to_tab_space <<EOF | iconv -f utf-8 -t iso8859-1 >expected &&
+..sage two
+..sage one
+add bar  Z
+..${sample_utf8_part}lich
+EOF
+	test_cmp expected actual
+'
+
 test_expect_success 'left alignment formatting with mtrunc' '
 	git log --pretty="format:%<(10,mtrunc)%s" >actual &&
 	# complete the incomplete line at the end
@@ -218,6 +283,19 @@ EOF
 	test_cmp expected actual
 '
 
+test_expect_failure 'left alignment formatting with mtrunc. i18n.logOutputEncoding' '
+	git -c i18n.logOutputEncoding=iso8859-1 log --pretty="format:%<(10,mtrunc)%s" >actual &&
+	# complete the incomplete line at the end
+	echo >>actual &&
+	qz_to_tab_space <<EOF | iconv -f utf-8 -t iso8859-1 >expected &&
+mess.. two
+mess.. one
+add bar  Z
+init..lich
+EOF
+	test_cmp expected actual
+'
+
 test_expect_success 'right alignment formatting' '
 	git log --pretty="format:%>(40)%s" >actual &&
 	# complete the incomplete line at the end
@@ -231,6 +309,19 @@ EOF
 	test_cmp expected actual
 '
 
+test_expect_success 'right alignment formatting. i18n.logOutputEncoding' '
+	git -c i18n.logOutputEncoding=iso8859-1 log --pretty="format:%>(40)%s" >actual &&
+	# complete the incomplete line at the end
+	echo >>actual &&
+	qz_to_tab_space <<EOF | iconv -f utf-8 -t iso8859-1 >expected &&
+Z                            message two
+Z                            message one
+Z                                add bar
+Z                    $(commit_msg)
+EOF
+	test_cmp expected actual
+'
+
 test_expect_success 'right alignment formatting at the nth column' '
 	git log --pretty="format:%h %>|(40)%s" >actual &&
 	# complete the incomplete line at the end
@@ -244,6 +335,19 @@ EOF
 	test_cmp expected actual
 '
 
+test_expect_success 'right alignment formatting at the nth column. i18n.logOutputEncoding' '
+	git -c i18n.logOutputEncoding=iso8859-1 log --pretty="format:%h %>|(40)%s" >actual &&
+	# complete the incomplete line at the end
+	echo >>actual &&
+	qz_to_tab_space <<EOF | iconv -f utf-8 -t iso8859-1 >expected &&
+$head1                      message two
+$head2                      message one
+$head3                          add bar
+$head4              $(commit_msg)
+EOF
+	test_cmp expected actual
+'
+
 test_expect_success 'right alignment formatting with no padding' '
 	git log --pretty="format:%>(1)%s" >actual &&
 	# complete the incomplete line at the end
@@ -257,6 +361,19 @@ EOF
 	test_cmp expected actual
 '
 
+test_expect_success 'right alignment formatting with no padding. i18n.logOutputEncoding' '
+	git -c i18n.logOutputEncoding=iso8859-1 log --pretty="format:%>(1)%s" >actual &&
+	# complete the incomplete line at the end
+	echo >>actual &&
+	cat <<EOF | iconv -f utf-8 -t iso8859-1 >expected &&
+message two
+message one
+add bar
+$(commit_msg)
+EOF
+	test_cmp expected actual
+'
+
 test_expect_success 'center alignment formatting' '
 	git log --pretty="format:%><(40)%s" >actual &&
 	# complete the incomplete line at the end
@@ -270,6 +387,18 @@ EOF
 	test_cmp expected actual
 '
 
+test_expect_success 'center alignment formatting. i18n.logOutputEncoding' '
+	git -c i18n.logOutputEncoding=iso8859-1 log --pretty="format:%><(40)%s" >actual &&
+	# complete the incomplete line at the end
+	echo >>actual &&
+	qz_to_tab_space <<EOF | iconv -f utf-8 -t iso8859-1 >expected &&
+Z             message two              Z
+Z             message one              Z
+Z               add bar                Z
+Z         $(commit_msg)          Z
+EOF
+	test_cmp expected actual
+'
 test_expect_success 'center alignment formatting at the nth column' '
 	git log --pretty="format:%h %><|(40)%s" >actual &&
 	# complete the incomplete line at the end
@@ -283,6 +412,19 @@ EOF
 	test_cmp expected actual
 '
 
+test_expect_success 'center alignment formatting at the nth column. i18n.logOutputEncoding' '
+	git -c i18n.logOutputEncoding=iso8859-1 log --pretty="format:%h %><|(40)%s" >actual &&
+	# complete the incomplete line at the end
+	echo >>actual &&
+	qz_to_tab_space <<EOF | iconv -f utf-8 -t iso8859-1 >expected &&
+$head1           message two          Z
+$head2           message one          Z
+$head3             add bar            Z
+$head4       $(commit_msg)      Z
+EOF
+	test_cmp expected actual
+'
+
 test_expect_success 'center alignment formatting with no padding' '
 	git log --pretty="format:%><(1)%s" >actual &&
 	# complete the incomplete line at the end
@@ -296,6 +438,19 @@ EOF
 	test_cmp expected actual
 '
 
+test_expect_success 'center alignment formatting with no padding. i18n.logOutputEncoding' '
+	git -c i18n.logOutputEncoding=iso8859-1 log --pretty="format:%><(1)%s" >actual &&
+	# complete the incomplete line at the end
+	echo >>actual &&
+	cat <<EOF | iconv -f utf-8 -t iso8859-1 >expected &&
+message two
+message one
+add bar
+$(commit_msg)
+EOF
+	test_cmp expected actual
+'
+
 test_expect_success 'left/right alignment formatting with stealing' '
 	git commit --amend -m short --author "long long long <long@me.com>" &&
 	git log --pretty="format:%<(10,trunc)%s%>>(10,ltrunc)% an" >actual &&
@@ -310,6 +465,20 @@ EOF
 	test_cmp expected actual
 '
 
+test_expect_failure 'left/right alignment formatting with stealing. i18n.logOutputEncoding' '
+	git commit --amend -m short --author "long long long <long@me.com>" &&
+	git -c i18n.logOutputEncoding=iso8859-1 log --pretty="format:%<(10,trunc)%s%>>(10,ltrunc)% an" >actual &&
+	# complete the incomplete line at the end
+	echo >>actual &&
+	cat <<EOF | iconv -f utf-8 -t iso8859-1 >expected &&
+short long  long long
+message ..   A U Thor
+add bar      A U Thor
+initial...   A U Thor
+EOF
+	test_cmp expected actual
+'
+
 test_expect_success 'log decoration properly follows tag chain' '
 	git tag -a tag1 -m tag1 &&
 	git tag -a tag2 -m tag2 tag1 &&
-- 
1.9.2-15
