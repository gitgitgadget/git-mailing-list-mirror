From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v7 6/7] tests: test the test framework more thoroughly
Date: Thu, 20 Dec 2012 19:12:37 -0800
Message-ID: <1356059558-23479-7-git-send-email-gitster@pobox.com>
References: <1356059558-23479-1-git-send-email-gitster@pobox.com>
Cc: Adam Spiers <git@adamspiers.org>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 21 04:13:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tlt35-0000Og-Q0
	for gcvg-git-2@plane.gmane.org; Fri, 21 Dec 2012 04:13:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752187Ab2LUDM6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Dec 2012 22:12:58 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47682 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752159Ab2LUDMy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Dec 2012 22:12:54 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 69C8AA82F;
	Thu, 20 Dec 2012 22:12:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:in-reply-to
	:references; s=sasl; bh=xU2OKv5n937QPLy0qGwsR553qBM=; b=OPLrBTd0
	XUgPoLSjvwX7Brm2o7mSL5HJT95AviovEe2ODjdD2vk/xWqzJMQPTfrUG99RfJNQ
	09rlxzIjC4sjIFXKY/Ok7E1swQH/qie+GXzYuoj63vH3oTtspMfoHR8t66YQsK/K
	5puuoB8kmimtv1Ehl6QxxnXIsBl8MKchamA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:in-reply-to
	:references; q=dns; s=sasl; b=QKoLBeK4xgGezz4tWBJ91ubeWtgzjL0Rsv
	maHjPNrHoYR4oaMc+sNINV6l7+y3xaAvqGiX1IB+pxNegoeySQ4g7cGnA+jIhamS
	0V7YzVD90BTj2qUaHTgQIE0ky3AqFsCgcEnhJbNsJB1zVLIDtrZe1mJItqIAb7Jk
	vjS0qpLxI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 56679A82E;
	Thu, 20 Dec 2012 22:12:53 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 97BC8A828; Thu, 20 Dec 2012
 22:12:52 -0500 (EST)
X-Mailer: git-send-email 1.8.1.rc2.225.g8d36ab4
In-Reply-To: <1356059558-23479-1-git-send-email-gitster@pobox.com>
In-Reply-To: <CAOkDyE9tDYRYzojzNnjWsT7UygxMAurHqLSDGA66_LMPD2Wmnw@mail.gmail.com>
References: <CAOkDyE9tDYRYzojzNnjWsT7UygxMAurHqLSDGA66_LMPD2Wmnw@mail.gmail.com>
X-Pobox-Relay-ID: 4EB68228-4B1C-11E2-A513-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211950>

From: Adam Spiers <git@adamspiers.org>

Add 5 new full test suite runs each with a different number of
passing/failing/broken/fixed tests, in order to ensure that the
correct exit code and output are generated in each case.  As before,
these are run in a subdirectory to avoid disrupting the metrics for
the parent tests.

Signed-off-by: Adam Spiers <git@adamspiers.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t0000-basic.sh | 105 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 105 insertions(+)

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index d0f46e8..384b0ae 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -89,6 +89,56 @@ check_sub_test_lib_test () {
 	)
 }
 
+test_expect_success 'pretend we have a fully passing test suite' "
+	run_sub_test_lib_test full-pass '3 passing tests' <<-\\EOF &&
+	for i in 1 2 3
+	do
+		test_expect_success \"passing test #\$i\" 'true'
+	done
+	test_done
+	EOF
+	check_sub_test_lib_test full-pass <<-\\EOF
+	> ok 1 - passing test #1
+	> ok 2 - passing test #2
+	> ok 3 - passing test #3
+	> # passed all 3 test(s)
+	> 1..3
+	EOF
+"
+
+test_expect_success 'pretend we have a partially passing test suite' "
+	test_must_fail run_sub_test_lib_test \
+		partial-pass '2/3 tests passing' <<-\\EOF &&
+	test_expect_success 'passing test #1' 'true'
+	test_expect_success 'failing test #2' 'false'
+	test_expect_success 'passing test #3' 'true'
+	test_done
+	EOF
+	check_sub_test_lib_test partial-pass <<-\\EOF
+	> ok 1 - passing test #1
+	> not ok 2 - failing test #2
+	#	false
+	> ok 3 - passing test #3
+	> # failed 1 among 3 test(s)
+	> 1..3
+	EOF
+"
+
+test_expect_success 'pretend we have a known breakage' "
+	run_sub_test_lib_test failing-todo 'A failing TODO test' <<-\\EOF &&
+	test_expect_success 'passing test' 'true'
+	test_expect_failure 'pretend we have a known breakage' 'false'
+	test_done
+	EOF
+	check_sub_test_lib_test failing-todo <<-\\EOF
+	> ok 1 - passing test
+	> not ok 2 - pretend we have a known breakage # TODO known breakage
+	> # still have 1 known breakage(s)
+	> # passed all remaining 1 test(s)
+	> 1..2
+	EOF
+"
+
 test_expect_success 'pretend we have fixed a known breakage' "
 	run_sub_test_lib_test passing-todo 'A passing TODO test' <<-\\EOF &&
 	test_expect_failure 'pretend we have fixed a known breakage' 'true'
@@ -102,6 +152,61 @@ test_expect_success 'pretend we have fixed a known breakage' "
 	EOF
 "
 
+test_expect_success 'pretend we have a pass, fail, and known breakage' "
+	test_must_fail run_sub_test_lib_test \
+		mixed-results1 'mixed results #1' <<-\\EOF &&
+	test_expect_success 'passing test' 'true'
+	test_expect_success 'failing test' 'false'
+	test_expect_failure 'pretend we have a known breakage' 'false'
+	test_done
+	EOF
+	check_sub_test_lib_test mixed-results1 <<-\\EOF
+	> ok 1 - passing test
+	> not ok 2 - failing test
+	> #	false
+	> not ok 3 - pretend we have a known breakage # TODO known breakage
+	> # still have 1 known breakage(s)
+	> # failed 1 among remaining 2 test(s)
+	> 1..3
+	EOF
+"
+
+test_expect_success 'pretend we have a mix of all possible results' "
+	test_must_fail run_sub_test_lib_test \
+		mixed-results2 'mixed results #2' <<-\\EOF &&
+	test_expect_success 'passing test' 'true'
+	test_expect_success 'passing test' 'true'
+	test_expect_success 'passing test' 'true'
+	test_expect_success 'passing test' 'true'
+	test_expect_success 'failing test' 'false'
+	test_expect_success 'failing test' 'false'
+	test_expect_success 'failing test' 'false'
+	test_expect_failure 'pretend we have a known breakage' 'false'
+	test_expect_failure 'pretend we have a known breakage' 'false'
+	test_expect_failure 'pretend we have fixed a known breakage' 'true'
+	test_done
+	EOF
+	check_sub_test_lib_test mixed-results2 <<-\\EOF
+	> ok 1 - passing test
+	> ok 2 - passing test
+	> ok 3 - passing test
+	> ok 4 - passing test
+	> not ok 5 - failing test
+	> #	false
+	> not ok 6 - failing test
+	> #	false
+	> not ok 7 - failing test
+	> #	false
+	> not ok 8 - pretend we have a known breakage # TODO known breakage
+	> not ok 9 - pretend we have a known breakage # TODO known breakage
+	> ok 10 - pretend we have fixed a known breakage # TODO known breakage
+	> # fixed 1 known breakage(s)
+	> # still have 2 known breakage(s)
+	> # failed 3 among remaining 8 test(s)
+	> 1..10
+	EOF
+"
+
 test_set_prereq HAVEIT
 haveit=no
 test_expect_success HAVEIT 'test runs if prerequisite is satisfied' '
-- 
1.8.1.rc2.225.g8d36ab4
