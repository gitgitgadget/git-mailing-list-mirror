From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 2/3] trailer: add tests for trailer.trimEmpty
Date: Sat, 07 Feb 2015 14:11:10 +0100
Message-ID: <20150207131112.394.64847.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 07 14:26:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YK5PD-0004Dv-GD
	for gcvg-git-2@plane.gmane.org; Sat, 07 Feb 2015 14:26:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755199AbbBGN0d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Feb 2015 08:26:33 -0500
Received: from delay-3y.bbox.fr ([194.158.98.73]:51450 "EHLO delay-3y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751068AbbBGN0c (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Feb 2015 08:26:32 -0500
Received: from mail-1y.bbox.fr (bt8sssom.cs.dolmen.bouyguestelecom.fr [172.24.208.144])
	by delay-3y.bbox.fr (Postfix) with ESMTP id 63C7949B74
	for <git@vger.kernel.org>; Sat,  7 Feb 2015 14:12:10 +0100 (CET)
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-1y.bbox.fr (Postfix) with ESMTP id C01AD75;
	Sat,  7 Feb 2015 14:12:05 +0100 (CET)
X-git-sha1: a6a51e520a19cd0937a321aa6c7097ddd131c263 
X-Mailer: git-mail-commits v0.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263440>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t7513-interpret-trailers.sh | 72 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/t/t7513-interpret-trailers.sh b/t/t7513-interpret-trailers.sh
index bd0ab46..066d00b 100755
--- a/t/t7513-interpret-trailers.sh
+++ b/t/t7513-interpret-trailers.sh
@@ -892,4 +892,76 @@ test_expect_success 'with no command and no key' '
 	test_cmp expected actual
 '
 
+test_expect_success 'with trailer.trimEmpty set to true' '
+	git config trailer.trimEmpty true &&
+	cat >expected <<-EOF &&
+
+		sign: A U Thor <author@example.com>
+		Thanks-to: Johannes
+	EOF
+	git interpret-trailers --trailer "review:" \
+		--trailer "Thanks-to:Johannes" >actual <<-EOF
+	EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'with trailer.trimEmpty set to false' '
+	git config trailer.trimEmpty false &&
+	sed -e "s/ Z\$/ /" >expected <<-EOF &&
+
+		review: Z
+		sign: A U Thor <author@example.com>
+		Thanks-to: Johannes
+	EOF
+	git interpret-trailers --trailer "review:" \
+		--trailer "Thanks-to:Johannes" >actual <<-EOF
+	EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'with trailer.trimEmpty set to false and a message' '
+	cat complex_message_body >expected &&
+	sed -e "s/ Z\$/ /" >>expected <<-\EOF &&
+		Fixes: Z
+		Acked-by= Z
+		Reviewed-by: Z
+		Signed-off-by: Z
+		sign: A U Thor <author@example.com>
+		Thanks-to: Johannes
+	EOF
+	git interpret-trailers --trailer "review:" \
+		--trailer "Thanks-to:Johannes" complex_message >actual
+	test_cmp expected actual &&
+	git interpret-trailers --no-trim-empty --trailer "review:" \
+		--trailer "Thanks-to:Johannes" complex_message >actual
+	test_cmp expected actual
+'
+
+test_expect_success 'with trailer.trimEmpty set to 1 and a message' '
+	git config trailer.trimEmpty 1 &&
+	cat complex_message_body >expected &&
+	sed -e "s/ Z\$/ /" >>expected <<-\EOF &&
+		sign: A U Thor <author@example.com>
+		Thanks-to: Johannes
+	EOF
+	git interpret-trailers --trailer "review:" \
+		--trailer "Thanks-to:Johannes" complex_message >actual
+	test_cmp expected actual
+'
+
+test_expect_success 'with trailer.trimEmpty set to 1 and --no-trim-empty' '
+	cat complex_message_body >expected &&
+	sed -e "s/ Z\$/ /" >>expected <<-\EOF &&
+		Fixes: Z
+		Acked-by= Z
+		Reviewed-by: Z
+		Signed-off-by: Z
+		sign: A U Thor <author@example.com>
+		Thanks-to: Johannes
+	EOF
+	git interpret-trailers --no-trim-empty --trailer "review:" \
+		--trailer "Thanks-to:Johannes" complex_message >actual
+	test_cmp expected actual
+'
+
 test_done
-- 
2.2.1.313.gcc831f2
