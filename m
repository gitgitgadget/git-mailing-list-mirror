From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 9/9] trailer: add tests for "git interpret-trailers"
Date: Tue, 24 Dec 2013 07:37:25 +0100
Message-ID: <20131224063726.19560.61859.chriscool@tuxfamily.org>
References: <20131224061541.19560.17773.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 24 07:39:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VvLds-0001ZO-Qj
	for gcvg-git-2@plane.gmane.org; Tue, 24 Dec 2013 07:39:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751256Ab3LXGiq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Dec 2013 01:38:46 -0500
Received: from [194.158.98.45] ([194.158.98.45]:47058 "EHLO mail-3y.bbox.fr"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751242Ab3LXGio (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Dec 2013 01:38:44 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-3y.bbox.fr (Postfix) with ESMTP id DB02745;
	Tue, 24 Dec 2013 07:38:21 +0100 (CET)
X-git-sha1: 5b325d09cd18efa34e7cd39ef327bbffe5ad5537 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20131224061541.19560.17773.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239658>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t7513-interpret-trailers.sh | 206 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 206 insertions(+)
 create mode 100755 t/t7513-interpret-trailers.sh

diff --git a/t/t7513-interpret-trailers.sh b/t/t7513-interpret-trailers.sh
new file mode 100755
index 0000000..beb58fe
--- /dev/null
+++ b/t/t7513-interpret-trailers.sh
@@ -0,0 +1,206 @@
+#!/bin/sh
+#
+# Copyright (c) 2013 Christian Couder
+#
+
+test_description='git interpret-trailers'
+
+. ./test-lib.sh
+
+cat >basic_message <<'EOF'
+subject
+
+body
+EOF
+
+cat >complex_message_body <<'EOF'
+my subject
+
+my body which is long
+and contains some special
+chars like : = ? !
+
+EOF
+
+# Do not remove trailing spaces below!
+cat >complex_message_trailers <<'EOF'
+Fixes: 
+Acked-by: 
+Reviewed-by: 
+Signed-off-by: 
+EOF
+
+test_expect_success 'without config' '
+	printf "ack: Peff\nReviewed-by: \nAcked-by: Johan\n" >expected &&
+	git interpret-trailers "ack = Peff" "Reviewed-by" "Acked-by: Johan" >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success '--trim-empty without config' '
+	printf "ack: Peff\nAcked-by: Johan\n" >expected &&
+	git interpret-trailers --trim-empty "ack = Peff" "Reviewed-by" "Acked-by: Johan" "sob:" >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'with config setup' '
+	git config trailer.ack.key "Acked-by: " &&
+	printf "Acked-by: Peff\n" >expected &&
+	git interpret-trailers --trim-empty "ack = Peff" >actual &&
+	test_cmp expected actual &&
+	git interpret-trailers --trim-empty "Acked-by = Peff" >actual &&
+	test_cmp expected actual &&
+	git interpret-trailers --trim-empty "Acked-by :Peff" >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'with config setup and = sign' '
+	git config trailer.ack.key "Acked-by= " &&
+	printf "Acked-by= Peff\n" >expected &&
+	git interpret-trailers --trim-empty "ack = Peff" >actual &&
+	test_cmp expected actual &&
+	git interpret-trailers --trim-empty "Acked-by= Peff" >actual &&
+	test_cmp expected actual &&
+	git interpret-trailers --trim-empty "Acked-by : Peff" >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'with config setup and # sign' '
+	git config trailer.bug.key "Bug #" &&
+	printf "Bug #42\n" >expected &&
+	git interpret-trailers --trim-empty "bug = 42" >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'with commit basic message' '
+	git interpret-trailers --infile basic_message >actual &&
+	test_cmp basic_message actual
+'
+
+test_expect_success 'with commit complex message' '
+	cat complex_message_body complex_message_trailers >complex_message &&
+	cat complex_message_body >expected &&
+	printf "Fixes: \nAcked-by= \nReviewed-by: \nSigned-off-by: \n" >>expected &&
+	git interpret-trailers --infile complex_message >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'with commit complex message and args' '
+	cat complex_message_body >expected &&
+	printf "Fixes: \nAcked-by= \nAcked-by= Peff\nReviewed-by: \nSigned-off-by: \nBug #42\n" >>expected &&
+	git interpret-trailers --infile complex_message "ack: Peff" "bug: 42" >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'with commit complex message, args and --trim-empty' '
+	cat complex_message_body >expected &&
+	printf "Acked-by= Peff\nBug #42\n" >>expected &&
+	git interpret-trailers --trim-empty --infile complex_message "ack: Peff" "bug: 42" >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'using "where = before"' '
+	git config trailer.bug.where "before" &&
+	cat complex_message_body >expected &&
+	printf "Bug #42\nFixes: \nAcked-by= \nAcked-by= Peff\nReviewed-by: \nSigned-off-by: \n" >>expected &&
+	git interpret-trailers --infile complex_message "ack: Peff" "bug: 42" >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'using "where = before" for a token in the middle of infile' '
+	git config trailer.review.key "Reviewed-by:" &&
+	git config trailer.review.where "before" &&
+	cat complex_message_body >expected &&
+	printf "Bug #42\nFixes: \nAcked-by= \nAcked-by= Peff\nReviewed-by: Johan\nReviewed-by: \nSigned-off-by: \n" >>expected &&
+	git interpret-trailers --infile complex_message "ack: Peff" "bug: 42" "review: Johan" >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'using "where = before" and --trim-empty' '
+	cat complex_message_body >expected &&
+	printf "Bug #46\nBug #42\nAcked-by= Peff\nReviewed-by: Johan\n" >>expected &&
+	git interpret-trailers --infile complex_message --trim-empty "ack: Peff" "bug: 42" "review: Johan" "Bug: 46"  >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'the default is "ifExist = addIfDifferent"' '
+	cat complex_message_body >expected &&
+	printf "Bug #42\nFixes: \nAcked-by= \nAcked-by= Peff\nReviewed-by: \nSigned-off-by: \n" >>expected &&
+	git interpret-trailers --infile complex_message "ack: Peff" "review:" "bug: 42" "ack: Peff" >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'using "ifExist = addIfDifferent"' '
+	git config trailer.review.ifExist "addIfDifferent" &&
+	cat complex_message_body >expected &&
+	printf "Bug #42\nFixes: \nAcked-by= \nAcked-by= Peff\nReviewed-by: \nSigned-off-by: \n" >>expected &&
+	git interpret-trailers --infile complex_message "ack: Peff" "review:" "bug: 42" "ack: Peff" >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'using "ifExist = addIfDifferentNeighbor"' '
+	git config trailer.ack.ifExist "addIfDifferentNeighbor" &&
+	cat complex_message_body >expected &&
+	printf "Bug #42\nFixes: \nAcked-by= \nAcked-by= Peff\nAcked-by= Junio\nAcked-by= Peff\nReviewed-by: \nSigned-off-by: \n" >>expected &&
+	git interpret-trailers --infile complex_message "ack: Peff" "review:" "ack: Junio" "bug: 42" "ack: Peff" >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'using "ifExist = addIfDifferentNeighbor" and --trim-empty' '
+	git config trailer.ack.ifExist "addIfDifferentNeighbor" &&
+	cat complex_message_body >expected &&
+	printf "Bug #42\nAcked-by= Peff\nAcked-by= Junio\nAcked-by= Peff\n" >>expected &&
+	git interpret-trailers --infile complex_message --trim-empty "ack: Peff" "Acked-by= Peff" "review:" "ack: Junio" "bug: 42" "ack: Peff" >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'using "ifExist = add"' '
+	git config trailer.ack.ifExist "add" &&
+	cat complex_message_body >expected &&
+	printf "Bug #42\nFixes: \nAcked-by= \nAcked-by= Peff\nAcked-by= Peff\nAcked-by= Junio\nAcked-by= Peff\nReviewed-by: \nSigned-off-by: \n" >>expected &&
+	git interpret-trailers --infile complex_message "ack: Peff" "Acked-by= Peff" "review:" "ack: Junio" "bug: 42" "ack: Peff" >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'using "ifExist = overwrite"' '
+	git config trailer.fix.key "Fixes:" &&
+	git config trailer.fix.ifExist "overwrite" &&
+	cat complex_message_body >expected &&
+	printf "Bug #42\nFixes: 22\nAcked-by= \nAcked-by= Junio\nAcked-by= Peff\nReviewed-by: \nSigned-off-by: \n" >>expected &&
+	git interpret-trailers --infile complex_message "review:" "fix=53" "ack: Junio" "fix=22" "bug: 42" "ack: Peff" >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'using "ifExist = doNothing"' '
+	git config trailer.fix.ifExist "doNothing" &&
+	cat complex_message_body >expected &&
+	printf "Bug #42\nFixes: \nAcked-by= \nAcked-by= Junio\nAcked-by= Peff\nReviewed-by: \nSigned-off-by: \n" >>expected &&
+	git interpret-trailers --infile complex_message "review:" "fix=53" "ack: Junio" "fix=22" "bug: 42" "ack: Peff" >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'the default is "ifMissing = add"' '
+	git config trailer.cc.key "Cc: " &&
+	git config trailer.Cc.where "before" &&
+	cat complex_message_body >expected &&
+	printf "Bug #42\nCc: Linus\nFixes: \nAcked-by= \nAcked-by= Junio\nAcked-by= Peff\nReviewed-by: \nSigned-off-by: \n" >>expected &&
+	git interpret-trailers --infile complex_message "review:" "fix=53" "cc=Linus" "ack: Junio" "fix=22" "bug: 42" "ack: Peff" >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'using "ifMissing = add"' '
+	git config trailer.Cc.ifMissing "add" &&
+	cat complex_message_body >expected &&
+	printf "Cc: Linus\nBug #42\nFixes: \nAcked-by= \nAcked-by= Junio\nAcked-by= Peff\nReviewed-by: \nSigned-off-by: \n" >>expected &&
+	git interpret-trailers --infile complex_message "review:" "fix=53" "ack: Junio" "fix=22" "bug: 42" "cc=Linus" "ack: Peff" >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'using "ifMissing = doNothing"' '
+	git config trailer.Cc.ifMissing "doNothing" &&
+	cat complex_message_body >expected &&
+	printf "Bug #42\nFixes: \nAcked-by= \nAcked-by= Junio\nAcked-by= Peff\nReviewed-by: \nSigned-off-by: \n" >>expected &&
+	git interpret-trailers --infile complex_message "review:" "fix=53" "cc=Linus" "ack: Junio" "fix=22" "bug: 42" "ack: Peff" >actual &&
+	test_cmp expected actual
+'
+
+test_done
-- 
1.8.4.1.616.g07f5c81
