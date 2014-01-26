From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 09/17] trailer: add tests for "git interpret-trailers"
Date: Sun, 26 Jan 2014 18:00:02 +0100
Message-ID: <20140126170011.24291.47211.chriscool@tuxfamily.org>
References: <20140126165018.24291.47716.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 26 18:24:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W7TRt-0004a4-9Z
	for gcvg-git-2@plane.gmane.org; Sun, 26 Jan 2014 18:24:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753206AbaAZRYk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Jan 2014 12:24:40 -0500
Received: from mail-1y.bbox.fr ([194.158.98.14]:43148 "EHLO mail-1y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752892AbaAZRYB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Jan 2014 12:24:01 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-1y.bbox.fr (Postfix) with ESMTP id D2DB57E;
	Sun, 26 Jan 2014 18:23:59 +0100 (CET)
X-git-sha1: a9d987575c00539e135a793aed384b330abad312 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20140126165018.24291.47716.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241105>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t7513-interpret-trailers.sh | 208 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 208 insertions(+)
 create mode 100755 t/t7513-interpret-trailers.sh

diff --git a/t/t7513-interpret-trailers.sh b/t/t7513-interpret-trailers.sh
new file mode 100755
index 0000000..8be333c
--- /dev/null
+++ b/t/t7513-interpret-trailers.sh
@@ -0,0 +1,208 @@
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
+# We want one trailing space at the end of each line.
+# Let's use sed to make sure that these spaces are not removed
+# by any automatic tool.
+sed -e 's/ Z$/ /' >complex_message_trailers <<-\EOF
+Fixes: Z
+Acked-by: Z
+Reviewed-by: Z
+Signed-off-by: Z
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
1.8.5.2.201.gacc5987
