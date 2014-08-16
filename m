From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v13 08/11] trailer: add tests for "git interpret-trailers"
Date: Sat, 16 Aug 2014 18:06:18 +0200
Message-ID: <20140816160622.18221.11511.chriscool@tuxfamily.org>
References: <20140816153440.18221.29179.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 16 18:54:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XIhFC-0005m1-OA
	for gcvg-git-2@plane.gmane.org; Sat, 16 Aug 2014 18:54:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751548AbaHPQyO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Aug 2014 12:54:14 -0400
Received: from gleek.ethostream.com ([66.195.129.15]:58958 "EHLO
	barracuda.ethostream.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751536AbaHPQyN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Aug 2014 12:54:13 -0400
X-ASG-Debug-ID: 1408208000-016a7707b5114ebf0001-QuoKaX
Received: from relay.ethostream.com (www1.ethostream.com [66.195.129.11]) by barracuda.ethostream.com with ESMTP id 8CJWNN2FVa5lBl9e; Sat, 16 Aug 2014 11:53:20 -0500 (CDT)
X-Barracuda-Envelope-From: chriscool@tuxfamily.org
X-Barracuda-Apparent-Source-IP: 66.195.129.11
Received: from ethoserver.ezone.net (unknown [10.230.15.218])
	by relay.ethostream.com (Postfix) with ESMTPA id 7D19089124F;
	Sat, 16 Aug 2014 11:37:49 -0500 (CDT)
Received: from [127.0.1.1] (unknown [10.0.7.4])
	by ethoserver.ezone.net (Postfix) with ESMTP id 7EE6BC54993;
	Sat, 16 Aug 2014 11:11:15 -0500 (CDT)
X-ASG-Orig-Subj: [PATCH v13 08/11] trailer: add tests for "git interpret-trailers"
X-git-sha1: df1daf85f24e1d0904793ee385f44adabc06e132 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20140816153440.18221.29179.chriscool@tuxfamily.org>
X-Barracuda-Connect: www1.ethostream.com[66.195.129.11]
X-Barracuda-Start-Time: 1408208000
X-Barracuda-URL: http://66.195.129.15:8000/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at ethostream.com
X-Barracuda-Spam-Score: 3.38
X-Barracuda-Spam-Status: No, SCORE=3.38 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=5.0 tests=FH_DATE_PAST_20XX
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.2.138343
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------
	3.38 FH_DATE_PAST_20XX      The date is grossly in the future.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255333>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t7513-interpret-trailers.sh | 726 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 726 insertions(+)
 create mode 100755 t/t7513-interpret-trailers.sh

diff --git a/t/t7513-interpret-trailers.sh b/t/t7513-interpret-trailers.sh
new file mode 100755
index 0000000..fa37565
--- /dev/null
+++ b/t/t7513-interpret-trailers.sh
@@ -0,0 +1,726 @@
+#!/bin/sh
+#
+# Copyright (c) 2013, 2014 Christian Couder
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
+	: >empty &&
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
+	sed -e "s/ Z\$/ /" >complex_message_trailers <<-\EOF &&
+		Fixes: Z
+		Acked-by: Z
+		Reviewed-by: Z
+		Signed-off-by: Z
+	EOF
+	cat >basic_patch <<-\EOF
+		---
+		 foo.txt | 2 +-
+		 1 file changed, 1 insertion(+), 1 deletion(-)
+
+		diff --git a/foo.txt b/foo.txt
+		index 0353767..1d91aa1 100644
+		--- a/foo.txt
+		+++ b/foo.txt
+		@@ -1,3 +1,3 @@
+
+		-bar
+		+baz
+
+		--
+		1.9.rc0.11.ga562ddc
+
+	EOF
+'
+
+test_expect_success 'without config' '
+	sed -e "s/ Z\$/ /" >expected <<-\EOF &&
+
+		ack: Peff
+		Reviewed-by: Z
+		Acked-by: Johan
+	EOF
+	git interpret-trailers --trailer "ack = Peff" --trailer "Reviewed-by" \
+		--trailer "Acked-by: Johan" empty >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'without config in another order' '
+	sed -e "s/ Z\$/ /" >expected <<-\EOF &&
+
+		Acked-by: Johan
+		Reviewed-by: Z
+		ack: Peff
+	EOF
+	git interpret-trailers --trailer "Acked-by: Johan" --trailer "Reviewed-by" \
+		--trailer "ack = Peff" empty >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success '--trim-empty without config' '
+	cat >expected <<-\EOF &&
+
+		ack: Peff
+		Acked-by: Johan
+	EOF
+	git interpret-trailers --trim-empty --trailer ack=Peff \
+		--trailer "Reviewed-by" --trailer "Acked-by: Johan" \
+		--trailer "sob:" empty >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'with config setup' '
+	git config trailer.ack.key "Acked-by: " &&
+	cat >expected <<-\EOF &&
+
+		Acked-by: Peff
+	EOF
+	git interpret-trailers --trim-empty --trailer "ack = Peff" empty >actual &&
+	test_cmp expected actual &&
+	git interpret-trailers --trim-empty --trailer "Acked-by = Peff" empty >actual &&
+	test_cmp expected actual &&
+	git interpret-trailers --trim-empty --trailer "Acked-by :Peff" empty >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'with config setup and ":=" as separators' '
+	git config trailer.separators ":=" &&
+	git config trailer.ack.key "Acked-by= " &&
+	cat >expected <<-\EOF &&
+
+		Acked-by= Peff
+	EOF
+	git interpret-trailers --trim-empty --trailer "ack = Peff" empty >actual &&
+	test_cmp expected actual &&
+	git interpret-trailers --trim-empty --trailer "Acked-by= Peff" empty >actual &&
+	test_cmp expected actual &&
+	git interpret-trailers --trim-empty --trailer "Acked-by : Peff" empty >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'with config setup and "%" as separators' '
+	git config trailer.separators "%" &&
+	cat >expected <<-\EOF &&
+
+		bug% 42
+		count% 10
+		bug% 422
+	EOF
+	git interpret-trailers --trim-empty --trailer "bug = 42" \
+		--trailer count%10 --trailer "test: stuff" \
+		--trailer "bug % 422" empty >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'with "%" as separators and a message with trailers' '
+	cat >special_message <<-\EOF &&
+		Special Message
+
+		bug% 42
+		count% 10
+		bug% 422
+	EOF
+	cat >expected <<-\EOF &&
+		Special Message
+
+		bug% 42
+		count% 10
+		bug% 422
+		count% 100
+	EOF
+	git interpret-trailers --trailer count%100 \
+		special_message >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'with config setup and ":=#" as separators' '
+	git config trailer.separators ":=#" &&
+	git config trailer.bug.key "Bug #" &&
+	cat >expected <<-\EOF &&
+
+		Bug #42
+	EOF
+	git interpret-trailers --trim-empty --trailer "bug = 42" empty >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'with commit basic message' '
+	cat basic_message >expected &&
+	echo >>expected &&
+	git interpret-trailers <basic_message >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'with basic patch' '
+	cat basic_message >input &&
+	cat basic_patch >>input &&
+	cat basic_message >expected &&
+	echo >>expected &&
+	cat basic_patch >>expected &&
+	git interpret-trailers <input >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'with commit complex message as argument' '
+	cat complex_message_body complex_message_trailers >complex_message &&
+	cat complex_message_body >expected &&
+	sed -e "s/ Z\$/ /" >>expected <<-\EOF &&
+		Fixes: Z
+		Acked-by= Z
+		Reviewed-by: Z
+		Signed-off-by: Z
+	EOF
+	git interpret-trailers complex_message >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'with 2 files arguments' '
+	cat basic_message >>expected &&
+	echo >>expected &&
+	cat basic_patch >>expected &&
+	git interpret-trailers complex_message input >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'with message that has comments' '
+	cat basic_message >>message_with_comments &&
+	sed -e "s/ Z\$/ /" >>message_with_comments <<-\EOF &&
+		# comment
+
+		# other comment
+		Cc: Z
+		# yet another comment
+		Reviewed-by: Johan
+		Reviewed-by: Z
+		# last comment
+
+	EOF
+	cat basic_patch >>message_with_comments &&
+	cat basic_message >expected &&
+	cat >>expected <<-\EOF &&
+		# comment
+
+		Reviewed-by: Johan
+		Cc: Peff
+	EOF
+	cat basic_patch >>expected &&
+	git interpret-trailers --trim-empty --trailer "Cc: Peff" message_with_comments >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'with commit complex message and trailer args' '
+	cat complex_message_body >expected &&
+	sed -e "s/ Z\$/ /" >>expected <<-\EOF &&
+		Fixes: Z
+		Acked-by= Z
+		Reviewed-by: Z
+		Signed-off-by: Z
+		Acked-by= Peff
+		Bug #42
+	EOF
+	git interpret-trailers --trailer "ack: Peff" \
+		--trailer "bug: 42" <complex_message >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'with complex patch, args and --trim-empty' '
+	cat complex_message >complex_patch &&
+	cat basic_patch >>complex_patch &&
+	cat complex_message_body >expected &&
+	cat >>expected <<-\EOF &&
+		Acked-by= Peff
+		Bug #42
+	EOF
+	cat basic_patch >>expected &&
+	git interpret-trailers --trim-empty --trailer "ack: Peff" \
+		--trailer "bug: 42" <complex_patch >actual &&
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
+		Reviewed-by: Z
+		Signed-off-by: Z
+		Acked-by= Peff
+	EOF
+	git interpret-trailers --trailer "ack: Peff" \
+		--trailer "bug: 42" complex_message >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'using "where = after"' '
+	git config trailer.ack.where "after" &&
+	cat complex_message_body >expected &&
+	sed -e "s/ Z\$/ /" >>expected <<-\EOF &&
+		Bug #42
+		Fixes: Z
+		Acked-by= Z
+		Acked-by= Peff
+		Reviewed-by: Z
+		Signed-off-by: Z
+	EOF
+	git interpret-trailers --trailer "ack: Peff" \
+		--trailer "bug: 42" complex_message >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'using "where = end"' '
+	git config trailer.review.key "Reviewed-by" &&
+	git config trailer.review.where "end" &&
+	cat complex_message_body >expected &&
+	sed -e "s/ Z\$/ /" >>expected <<-\EOF &&
+		Fixes: Z
+		Acked-by= Z
+		Acked-by= Peff
+		Reviewed-by: Z
+		Signed-off-by: Z
+		Reviewed-by: Junio
+		Reviewed-by: Johannes
+	EOF
+	git interpret-trailers --trailer "ack: Peff" \
+		--trailer "Reviewed-by: Junio" --trailer "Reviewed-by: Johannes" \
+		complex_message >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'using "where = start"' '
+	git config trailer.review.key "Reviewed-by" &&
+	git config trailer.review.where "start" &&
+	cat complex_message_body >expected &&
+	sed -e "s/ Z\$/ /" >>expected <<-\EOF &&
+		Reviewed-by: Johannes
+		Reviewed-by: Junio
+		Fixes: Z
+		Acked-by= Z
+		Acked-by= Peff
+		Reviewed-by: Z
+		Signed-off-by: Z
+	EOF
+	git interpret-trailers --trailer "ack: Peff" \
+		--trailer "Reviewed-by: Junio" --trailer "Reviewed-by: Johannes" \
+		complex_message >actual &&
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
+		Reviewed-by:Johan
+		Reviewed-by:
+		Signed-off-by: Z
+	EOF
+	git interpret-trailers --trailer "ack: Peff" --trailer "bug: 42" \
+		--trailer "review: Johan" <complex_message >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'using "where = before" and --trim-empty' '
+	cat complex_message_body >expected &&
+	cat >>expected <<-\EOF &&
+		Bug #46
+		Bug #42
+		Acked-by= Peff
+		Reviewed-by:Johan
+	EOF
+	git interpret-trailers --trim-empty --trailer "ack: Peff" \
+		--trailer "bug: 42" --trailer "review: Johan" \
+		--trailer "Bug: 46" <complex_message >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'the default is "ifExists = addIfDifferentNeighbor"' '
+	cat complex_message_body >expected &&
+	sed -e "s/ Z\$/ /" >>expected <<-\EOF &&
+		Bug #42
+		Fixes: Z
+		Acked-by= Z
+		Acked-by= Peff
+		Acked-by= Junio
+		Acked-by= Peff
+		Reviewed-by:
+		Signed-off-by: Z
+	EOF
+	git interpret-trailers --trailer "ack: Peff" --trailer "review:" \
+		--trailer "ack: Junio" --trailer "bug: 42" --trailer "ack: Peff" \
+		--trailer "ack: Peff" <complex_message >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'default "ifExists" is now "addIfDifferent"' '
+	git config trailer.ifexists "addIfDifferent" &&
+	cat complex_message_body >expected &&
+	sed -e "s/ Z\$/ /" >>expected <<-\EOF &&
+		Bug #42
+		Fixes: Z
+		Acked-by= Z
+		Acked-by= Peff
+		Acked-by= Junio
+		Reviewed-by:
+		Signed-off-by: Z
+	EOF
+	git interpret-trailers --trailer "ack: Peff" --trailer "review:" \
+		--trailer "ack: Junio" --trailer "bug: 42" --trailer "ack: Peff" \
+		--trailer "ack: Peff" <complex_message >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'using "ifExists = addIfDifferent" with "where = end"' '
+	git config trailer.ack.ifExists "addIfDifferent" &&
+	git config trailer.ack.where "end" &&
+	cat complex_message_body >expected &&
+	sed -e "s/ Z\$/ /" >>expected <<-\EOF &&
+		Bug #42
+		Fixes: Z
+		Acked-by= Z
+		Reviewed-by:
+		Signed-off-by: Z
+		Acked-by= Peff
+	EOF
+	git interpret-trailers --trailer "ack: Peff" --trailer "review:" \
+		--trailer "bug: 42" --trailer "ack: Peff" \
+		<complex_message >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'using "ifExists = addIfDifferent" with "where = before"' '
+	git config trailer.ack.ifExists "addIfDifferent" &&
+	git config trailer.ack.where "before" &&
+	cat complex_message_body >expected &&
+	sed -e "s/ Z\$/ /" >>expected <<-\EOF &&
+		Bug #42
+		Fixes: Z
+		Acked-by= Peff
+		Acked-by= Z
+		Reviewed-by:
+		Signed-off-by: Z
+	EOF
+	git interpret-trailers --trailer "ack: Peff" --trailer "review:" \
+		--trailer "bug: 42" --trailer "ack: Peff" \
+		<complex_message >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'using "ifExists = addIfDifferentNeighbor" with "where = end"' '
+	git config trailer.ack.ifExists "addIfDifferentNeighbor" &&
+	git config trailer.ack.where "end" &&
+	cat complex_message_body >expected &&
+	sed -e "s/ Z\$/ /" >>expected <<-\EOF &&
+		Bug #42
+		Fixes: Z
+		Acked-by= Z
+		Reviewed-by:
+		Signed-off-by: Z
+		Acked-by= Peff
+		Acked-by= Junio
+		Tested-by: Jakub
+		Acked-by= Junio
+		Acked-by= Peff
+	EOF
+	git interpret-trailers --trailer "ack: Peff" --trailer "review:" \
+		--trailer "ack: Junio" --trailer "bug: 42" \
+		--trailer "Tested-by: Jakub" --trailer "ack: Junio" \
+		--trailer "ack: Junio" --trailer "ack: Peff" <complex_message >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'using "ifExists = addIfDifferentNeighbor"  with "where = after"' '
+	git config trailer.ack.ifExists "addIfDifferentNeighbor" &&
+	git config trailer.ack.where "after" &&
+	cat complex_message_body >expected &&
+	sed -e "s/ Z\$/ /" >>expected <<-\EOF &&
+		Bug #42
+		Fixes: Z
+		Acked-by= Z
+		Acked-by= Peff
+		Acked-by= Junio
+		Acked-by= Peff
+		Reviewed-by:
+		Signed-off-by: Z
+		Tested-by: Jakub
+	EOF
+	git interpret-trailers --trailer "ack: Peff" --trailer "review:" \
+		--trailer "ack: Junio" --trailer "bug: 42" \
+		--trailer "Tested-by: Jakub" --trailer "ack: Junio" \
+		--trailer "ack: Junio" --trailer "ack: Peff" <complex_message >actual &&
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
+	git interpret-trailers --trim-empty --trailer "ack: Peff" \
+		--trailer "Acked-by= Peff" --trailer "review:" \
+		--trailer "ack: Junio" --trailer "bug: 42" \
+		--trailer "ack: Peff" <complex_message >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'using "ifExists = add" with "where = end"' '
+	git config trailer.ack.ifExists "add" &&
+	git config trailer.ack.where "end" &&
+	cat complex_message_body >expected &&
+	sed -e "s/ Z\$/ /" >>expected <<-\EOF &&
+		Bug #42
+		Fixes: Z
+		Acked-by= Z
+		Reviewed-by:
+		Signed-off-by: Z
+		Acked-by= Peff
+		Acked-by= Peff
+		Tested-by: Jakub
+		Acked-by= Junio
+		Tested-by: Johannes
+		Acked-by= Peff
+	EOF
+	git interpret-trailers --trailer "ack: Peff" \
+		--trailer "Acked-by= Peff" --trailer "review:" \
+		--trailer "Tested-by: Jakub" --trailer "ack: Junio" \
+		--trailer "bug: 42" --trailer "Tested-by: Johannes" \
+		--trailer "ack: Peff" <complex_message >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'using "ifExists = add" with "where = after"' '
+	git config trailer.ack.ifExists "add" &&
+	git config trailer.ack.where "after" &&
+	cat complex_message_body >expected &&
+	sed -e "s/ Z\$/ /" >>expected <<-\EOF &&
+		Bug #42
+		Fixes: Z
+		Acked-by= Z
+		Acked-by= Peff
+		Acked-by= Peff
+		Acked-by= Junio
+		Acked-by= Peff
+		Reviewed-by:
+		Signed-off-by: Z
+	EOF
+	git interpret-trailers --trailer "ack: Peff" \
+		--trailer "Acked-by= Peff" --trailer "review:" \
+		--trailer "ack: Junio" --trailer "bug: 42" \
+		--trailer "ack: Peff" <complex_message >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'using "ifExists = replace"' '
+	git config trailer.fix.key "Fixes: " &&
+	git config trailer.fix.ifExists "replace" &&
+	cat complex_message_body >expected &&
+	sed -e "s/ Z\$/ /" >>expected <<-\EOF &&
+		Bug #42
+		Acked-by= Z
+		Acked-by= Junio
+		Acked-by= Peff
+		Reviewed-by:
+		Signed-off-by: Z
+		Fixes: 22
+	EOF
+	git interpret-trailers --trailer "review:" \
+		--trailer "fix=53" --trailer "ack: Junio" --trailer "fix=22" \
+		--trailer "bug: 42" --trailer "ack: Peff" \
+		<complex_message >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'using "ifExists = replace" with "where = after"' '
+	git config trailer.fix.where "after" &&
+	cat complex_message_body >expected &&
+	sed -e "s/ Z\$/ /" >>expected <<-\EOF &&
+		Bug #42
+		Fixes: 22
+		Acked-by= Z
+		Acked-by= Junio
+		Acked-by= Peff
+		Reviewed-by:
+		Signed-off-by: Z
+	EOF
+	git interpret-trailers --trailer "review:" \
+		--trailer "fix=53" --trailer "ack: Junio" --trailer "fix=22" \
+		--trailer "bug: 42" --trailer "ack: Peff" \
+		<complex_message >actual &&
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
+		Reviewed-by:
+		Signed-off-by: Z
+	EOF
+	git interpret-trailers --trailer "review:" --trailer "fix=53" \
+		--trailer "ack: Junio" --trailer "fix=22" \
+		--trailer "bug: 42" --trailer "ack: Peff" \
+		<complex_message >actual &&
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
+		Reviewed-by:
+		Signed-off-by: Z
+	EOF
+	git interpret-trailers --trailer "review:" --trailer "fix=53" \
+		--trailer "cc=Linus" --trailer "ack: Junio" \
+		--trailer "fix=22" --trailer "bug: 42" --trailer "ack: Peff" \
+		<complex_message >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'when default "ifMissing" is "doNothing"' '
+	git config trailer.ifmissing "doNothing" &&
+	cat complex_message_body >expected &&
+	sed -e "s/ Z\$/ /" >>expected <<-\EOF &&
+		Fixes: Z
+		Acked-by= Z
+		Acked-by= Junio
+		Acked-by= Peff
+		Reviewed-by:
+		Signed-off-by: Z
+	EOF
+	git interpret-trailers --trailer "review:" --trailer "fix=53" \
+		--trailer "cc=Linus" --trailer "ack: Junio" \
+		--trailer "fix=22" --trailer "bug: 42" --trailer "ack: Peff" \
+		<complex_message >actual &&
+	test_cmp expected actual &&
+	git config trailer.ifmissing "add"
+'
+
+test_expect_success 'using "ifMissing = add" with "where = end"' '
+	git config trailer.cc.key "Cc: " &&
+	git config trailer.cc.where "end" &&
+	git config trailer.cc.ifMissing "add" &&
+	cat complex_message_body >expected &&
+	sed -e "s/ Z\$/ /" >>expected <<-\EOF &&
+		Bug #42
+		Fixes: Z
+		Acked-by= Z
+		Acked-by= Junio
+		Acked-by= Peff
+		Reviewed-by:
+		Signed-off-by: Z
+		Cc: Linus
+	EOF
+	git interpret-trailers --trailer "review:" --trailer "fix=53" \
+		--trailer "ack: Junio" --trailer "fix=22" \
+		--trailer "bug: 42" --trailer "cc=Linus" --trailer "ack: Peff" \
+		<complex_message >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'using "ifMissing = add" with "where = before"' '
+	git config trailer.cc.key "Cc: " &&
+	git config trailer.cc.where "before" &&
+	git config trailer.cc.ifMissing "add" &&
+	cat complex_message_body >expected &&
+	sed -e "s/ Z\$/ /" >>expected <<-\EOF &&
+		Cc: Linus
+		Bug #42
+		Fixes: Z
+		Acked-by= Z
+		Acked-by= Junio
+		Acked-by= Peff
+		Reviewed-by:
+		Signed-off-by: Z
+	EOF
+	git interpret-trailers --trailer "review:" --trailer "fix=53" \
+		--trailer "ack: Junio" --trailer "fix=22" \
+		--trailer "bug: 42" --trailer "cc=Linus" --trailer "ack: Peff" \
+		<complex_message >actual &&
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
+		Reviewed-by:
+		Signed-off-by: Z
+	EOF
+	git interpret-trailers --trailer "review:" --trailer "fix=53" \
+		--trailer "cc=Linus" --trailer "ack: Junio" \
+		--trailer "fix=22" --trailer "bug: 42" --trailer "ack: Peff" \
+		<complex_message >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'default "where" is now "after"' '
+	git config trailer.where "after" &&
+	git config --unset trailer.ack.where &&
+	cat complex_message_body >expected &&
+	sed -e "s/ Z\$/ /" >>expected <<-\EOF &&
+		Bug #42
+		Fixes: Z
+		Acked-by= Z
+		Acked-by= Peff
+		Acked-by= Peff
+		Acked-by= Junio
+		Acked-by= Peff
+		Reviewed-by:
+		Signed-off-by: Z
+		Tested-by: Jakub
+		Tested-by: Johannes
+	EOF
+	git interpret-trailers --trailer "ack: Peff" \
+		--trailer "Acked-by= Peff" --trailer "review:" \
+		--trailer "Tested-by: Jakub" --trailer "ack: Junio" \
+		--trailer "bug: 42" --trailer "Tested-by: Johannes" \
+		--trailer "ack: Peff" <complex_message >actual &&
+	test_cmp expected actual
+'
+
+test_done
-- 
2.0.1.674.ga7f57b7
