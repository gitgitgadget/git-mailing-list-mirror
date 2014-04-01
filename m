From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v9 08/11] trailer: add tests for "git interpret-trailers"
Date: Tue, 01 Apr 2014 21:20:19 +0200
Message-ID: <20140401192023.353.56221.chriscool@tuxfamily.org>
References: <20140401191831.353.99271.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 01 21:25:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WV4JW-0001NC-Ng
	for gcvg-git-2@plane.gmane.org; Tue, 01 Apr 2014 21:25:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751626AbaDATZN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Apr 2014 15:25:13 -0400
Received: from mail-3y.bbox.fr ([194.158.98.45]:34790 "EHLO mail-3y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751365AbaDATZL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Apr 2014 15:25:11 -0400
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-3y.bbox.fr (Postfix) with ESMTP id 0D5E55E;
	Tue,  1 Apr 2014 21:25:10 +0200 (CEST)
X-git-sha1: 992358ec40bb79ccc0335fe4e982179224c9eb32 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20140401191831.353.99271.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245627>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t7513-interpret-trailers.sh | 336 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 336 insertions(+)
 create mode 100755 t/t7513-interpret-trailers.sh

diff --git a/t/t7513-interpret-trailers.sh b/t/t7513-interpret-trailers.sh
new file mode 100755
index 0000000..417a4f3
--- /dev/null
+++ b/t/t7513-interpret-trailers.sh
@@ -0,0 +1,336 @@
+#!/bin/sh
+#
+# Copyright (c) 2013 Christian Couder
+#
+
+test_description='git interpret-trailers'
+
+. ./test-lib.sh
+
+# When we want one trailing space at the end of each line, let's use sed
+# to make sure that these spaces are not removed by any automatic tool.
+
+test_expect_success 'setup' '
+	cat >basic_message <<-\EOF &&
+		subject
+
+		body
+	EOF
+	cat >complex_message_body <<-\EOF &&
+		my subject
+
+		my body which is long
+		and contains some special
+		chars like : = ? !
+
+	EOF
+	sed -e "s/ Z\$/ /" >complex_message_trailers <<-\EOF
+		Fixes: Z
+		Acked-by: Z
+		Reviewed-by: Z
+		Signed-off-by: Z
+	EOF
+'
+
+test_expect_success 'without config' '
+	sed -e "s/ Z\$/ /" >expected <<-\EOF &&
+		ack: Peff
+		Reviewed-by: Z
+		Acked-by: Johan
+	EOF
+	git interpret-trailers "ack = Peff" "Reviewed-by" "Acked-by: Johan" >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success '--trim-empty without config' '
+	cat >expected <<-\EOF &&
+		ack: Peff
+		Acked-by: Johan
+	EOF
+	git interpret-trailers --trim-empty "ack = Peff" "Reviewed-by" "Acked-by: Johan" "sob:" >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'with config setup' '
+	git config trailer.ack.key "Acked-by: " &&
+	cat >expected <<-\EOF &&
+		Acked-by: Peff
+	EOF
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
+	cat >expected <<-\EOF &&
+		Acked-by= Peff
+	EOF
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
+	cat >expected <<-\EOF &&
+		Bug #42
+	EOF
+	git interpret-trailers --trim-empty "bug = 42" >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'with commit basic message' '
+	git interpret-trailers <basic_message >actual &&
+	test_cmp basic_message actual
+'
+
+test_expect_success 'with commit complex message' '
+	cat complex_message_body complex_message_trailers >complex_message &&
+	cat complex_message_body >expected &&
+	sed -e "s/ Z\$/ /" >>expected <<-\EOF &&
+		Fixes: Z
+		Acked-by= Z
+		Reviewed-by: Z
+		Signed-off-by: Z
+	EOF
+	git interpret-trailers <complex_message >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'with commit complex message and args' '
+	cat complex_message_body >expected &&
+	sed -e "s/ Z\$/ /" >>expected <<-\EOF &&
+		Fixes: Z
+		Acked-by= Z
+		Acked-by= Peff
+		Reviewed-by: Z
+		Signed-off-by: Z
+		Bug #42
+	EOF
+	git interpret-trailers "ack: Peff" "bug: 42" <complex_message >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'with commit complex message, args and --trim-empty' '
+	cat complex_message_body >expected &&
+	cat >>expected <<-\EOF &&
+		Acked-by= Peff
+		Bug #42
+	EOF
+	git interpret-trailers --trim-empty "ack: Peff" "bug: 42" <complex_message >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'using "where = before"' '
+	git config trailer.bug.where "before" &&
+	cat complex_message_body >expected &&
+	sed -e "s/ Z\$/ /" >>expected <<-\EOF &&
+		Bug #42
+		Fixes: Z
+		Acked-by= Z
+		Acked-by= Peff
+		Reviewed-by: Z
+		Signed-off-by: Z
+	EOF
+	git interpret-trailers "ack: Peff" "bug: 42" <complex_message >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'using "where = before" for a token in the middle of the message' '
+	git config trailer.review.key "Reviewed-by:" &&
+	git config trailer.review.where "before" &&
+	cat complex_message_body >expected &&
+	sed -e "s/ Z\$/ /" >>expected <<-\EOF &&
+		Bug #42
+		Fixes: Z
+		Acked-by= Z
+		Acked-by= Peff
+		Reviewed-by: Johan
+		Reviewed-by: Z
+		Signed-off-by: Z
+	EOF
+	git interpret-trailers "ack: Peff" "bug: 42" "review: Johan" <complex_message >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'using "where = before" and --trim-empty' '
+	cat complex_message_body >expected &&
+	cat >>expected <<-\EOF &&
+		Bug #46
+		Bug #42
+		Acked-by= Peff
+		Reviewed-by: Johan
+	EOF
+	git interpret-trailers --trim-empty "ack: Peff" "bug: 42" "review: Johan" "Bug: 46" <complex_message >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'the default is "ifExists = addIfDifferent"' '
+	cat complex_message_body >expected &&
+	sed -e "s/ Z\$/ /" >>expected <<-\EOF &&
+		Bug #42
+		Fixes: Z
+		Acked-by= Z
+		Acked-by= Peff
+		Reviewed-by: Z
+		Signed-off-by: Z
+	EOF
+	git interpret-trailers "ack: Peff" "review:" "bug: 42" "ack: Peff" <complex_message >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'using "ifExists = addIfDifferent"' '
+	git config trailer.review.ifExists "addIfDifferent" &&
+	cat complex_message_body >expected &&
+	sed -e "s/ Z\$/ /" >>expected <<-\EOF &&
+		Bug #42
+		Fixes: Z
+		Acked-by= Z
+		Acked-by= Peff
+		Reviewed-by: Z
+		Signed-off-by: Z
+	EOF
+	git interpret-trailers "ack: Peff" "review:" "bug: 42" "ack: Peff" <complex_message >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'using "ifExists = addIfDifferentNeighbor"' '
+	git config trailer.ack.ifExists "addIfDifferentNeighbor" &&
+	cat complex_message_body >expected &&
+	sed -e "s/ Z\$/ /" >>expected <<-\EOF &&
+		Bug #42
+		Fixes: Z
+		Acked-by= Z
+		Acked-by= Peff
+		Acked-by= Junio
+		Acked-by= Peff
+		Reviewed-by: Z
+		Signed-off-by: Z
+	EOF
+	git interpret-trailers "ack: Peff" "review:" "ack: Junio" "bug: 42" "ack: Peff" <complex_message >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'using "ifExists = addIfDifferentNeighbor" and --trim-empty' '
+	git config trailer.ack.ifExists "addIfDifferentNeighbor" &&
+	cat complex_message_body >expected &&
+	cat >>expected <<-\EOF &&
+		Bug #42
+		Acked-by= Peff
+		Acked-by= Junio
+		Acked-by= Peff
+	EOF
+	git interpret-trailers --trim-empty "ack: Peff" "Acked-by= Peff" "review:" "ack: Junio" "bug: 42" "ack: Peff" <complex_message >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'using "ifExists = add"' '
+	git config trailer.ack.ifExists "add" &&
+	cat complex_message_body >expected &&
+	sed -e "s/ Z\$/ /" >>expected <<-\EOF &&
+		Bug #42
+		Fixes: Z
+		Acked-by= Z
+		Acked-by= Peff
+		Acked-by= Peff
+		Acked-by= Junio
+		Acked-by= Peff
+		Reviewed-by: Z
+		Signed-off-by: Z
+	EOF
+	git interpret-trailers "ack: Peff" "Acked-by= Peff" "review:" "ack: Junio" "bug: 42" "ack: Peff" <complex_message >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'using "ifExists = overwrite"' '
+	git config trailer.fix.key "Fixes:" &&
+	git config trailer.fix.ifExists "overwrite" &&
+	cat complex_message_body >expected &&
+	sed -e "s/ Z\$/ /" >>expected <<-\EOF &&
+		Bug #42
+		Fixes: 22
+		Acked-by= Z
+		Acked-by= Junio
+		Acked-by= Peff
+		Reviewed-by: Z
+		Signed-off-by: Z
+	EOF
+	git interpret-trailers "review:" "fix=53" "ack: Junio" "fix=22" "bug: 42" "ack: Peff" <complex_message >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'using "ifExists = doNothing"' '
+	git config trailer.fix.ifExists "doNothing" &&
+	cat complex_message_body >expected &&
+	sed -e "s/ Z\$/ /" >>expected <<-\EOF &&
+		Bug #42
+		Fixes: Z
+		Acked-by= Z
+		Acked-by= Junio
+		Acked-by= Peff
+		Reviewed-by: Z
+		Signed-off-by: Z
+	EOF
+	git interpret-trailers "review:" "fix=53" "ack: Junio" "fix=22" "bug: 42" "ack: Peff" <complex_message >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'the default is "ifMissing = add"' '
+	git config trailer.cc.key "Cc: " &&
+	git config trailer.cc.where "before" &&
+	cat complex_message_body >expected &&
+	sed -e "s/ Z\$/ /" >>expected <<-\EOF &&
+		Bug #42
+		Cc: Linus
+		Fixes: Z
+		Acked-by= Z
+		Acked-by= Junio
+		Acked-by= Peff
+		Reviewed-by: Z
+		Signed-off-by: Z
+	EOF
+	git interpret-trailers "review:" "fix=53" "cc=Linus" "ack: Junio" "fix=22" "bug: 42" "ack: Peff" <complex_message >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'using "ifMissing = add"' '
+	git config trailer.cc.ifMissing "add" &&
+	cat complex_message_body >expected &&
+	sed -e "s/ Z\$/ /" >>expected <<-\EOF &&
+		Cc: Linus
+		Bug #42
+		Fixes: Z
+		Acked-by= Z
+		Acked-by= Junio
+		Acked-by= Peff
+		Reviewed-by: Z
+		Signed-off-by: Z
+	EOF
+	git interpret-trailers "review:" "fix=53" "ack: Junio" "fix=22" "bug: 42" "cc=Linus" "ack: Peff" <complex_message >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'using "ifMissing = doNothing"' '
+	git config trailer.cc.ifMissing "doNothing" &&
+	cat complex_message_body >expected &&
+	sed -e "s/ Z\$/ /" >>expected <<-\EOF &&
+		Bug #42
+		Fixes: Z
+		Acked-by= Z
+		Acked-by= Junio
+		Acked-by= Peff
+		Reviewed-by: Z
+		Signed-off-by: Z
+	EOF
+	git interpret-trailers "review:" "fix=53" "cc=Linus" "ack: Junio" "fix=22" "bug: 42" "ack: Peff" <complex_message >actual &&
+	test_cmp expected actual
+'
+
+test_done
-- 
1.9.0.164.g3aa33cd.dirty
