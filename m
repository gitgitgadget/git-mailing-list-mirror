From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v7 5/7] tests: refactor mechanics of testing in a sub
 test-lib
Date: Thu, 20 Dec 2012 19:12:36 -0800
Message-ID: <1356059558-23479-6-git-send-email-gitster@pobox.com>
References: <1356059558-23479-1-git-send-email-gitster@pobox.com>
Cc: Adam Spiers <git@adamspiers.org>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 21 04:13:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tlt2v-0000D7-0E
	for gcvg-git-2@plane.gmane.org; Fri, 21 Dec 2012 04:13:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752179Ab2LUDM4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Dec 2012 22:12:56 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47638 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752066Ab2LUDMv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Dec 2012 22:12:51 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5E2E6A824;
	Thu, 20 Dec 2012 22:12:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:in-reply-to
	:references; s=sasl; bh=jDVDDOz1JlXAgZe7T9e1r7+KNYE=; b=qw2RG1Wl
	GhXA7HRtzFPKWTq+7uczi9YuuyqcokWuGlliVyB7XfHi5K5fvwsduBkLpwXmJt7W
	Fn6FtSmA6s/BHVFDE7hrWrK7Z1xgGR/VG/vz8pvN1J6CqWMQz0HxCDDXZ+Fb1rr4
	scrhfMt4x/LP3zCndW4WY4TYkXOgfPAHtOc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:in-reply-to
	:references; q=dns; s=sasl; b=k7Udic0iLJHLkaCmV8x/INRrPd09CKN+fO
	0jMFK+BIjirWJf7jwcWOXMnQqZCpjZ4Q5gHBC/eNG3mqRfEopKQzPPqun6eU3i3j
	6QkYXTjncJ4Ex3WybOFTOxwPnudsQYOT3ROKofCE4Jn27kuu0cBlUVJWoYSu9K7P
	PC9sjrTMc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4BD97A822;
	Thu, 20 Dec 2012 22:12:51 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6C9DAA81F; Thu, 20 Dec 2012
 22:12:50 -0500 (EST)
X-Mailer: git-send-email 1.8.1.rc2.225.g8d36ab4
In-Reply-To: <1356059558-23479-1-git-send-email-gitster@pobox.com>
In-Reply-To: <CAOkDyE9tDYRYzojzNnjWsT7UygxMAurHqLSDGA66_LMPD2Wmnw@mail.gmail.com>
References: <CAOkDyE9tDYRYzojzNnjWsT7UygxMAurHqLSDGA66_LMPD2Wmnw@mail.gmail.com>
X-Pobox-Relay-ID: 4D6A4A58-4B1C-11E2-A381-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211946>

From: Adam Spiers <git@adamspiers.org>

This will allow us to test the test framework more thoroughly
without disrupting the top-level test metrics.

Signed-off-by: Adam Spiers <git@adamspiers.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t0000-basic.sh | 85 ++++++++++++++++++++++++++------------------------------
 1 file changed, 40 insertions(+), 45 deletions(-)

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index c6b42de..d0f46e8 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -55,39 +55,53 @@ test_expect_failure 'pretend we have a known breakage' '
 	false
 '
 
-test_expect_success 'pretend we have fixed a known breakage (run in sub test-lib)' "
-	mkdir passing-todo &&
-	(cd passing-todo &&
-	cat >passing-todo.sh <<-EOF &&
-	#!$SHELL_PATH
-
-	test_description='A passing TODO test
-
-	This is run in a sub test-lib so that we do not get incorrect
-	passing metrics
-	'
-
-	# Point to the t/test-lib.sh, which isn't in ../ as usual
-	TEST_DIRECTORY=\"$TEST_DIRECTORY\"
-	. \"\$TEST_DIRECTORY\"/test-lib.sh
+run_sub_test_lib_test () {
+	name="$1" descr="$2" # stdin is the body of the test code
+	mkdir "$name" &&
+	(
+		cd "$name" &&
+		cat >"$name.sh" <<-EOF &&
+		#!$SHELL_PATH
+
+		test_description='$descr (run in sub test-lib)
+
+		This is run in a sub test-lib so that we do not get incorrect
+		passing metrics
+		'
+
+		# Point to the t/test-lib.sh, which isn't in ../ as usual
+		. "\$TEST_DIRECTORY"/test-lib.sh
+		EOF
+		cat >>"$name.sh" &&
+		chmod +x "$name.sh" &&
+		export TEST_DIRECTORY &&
+		./"$name.sh" >out 2>err
+	)
+}
 
-	test_expect_failure 'pretend we have fixed a known breakage' '
-		:
-	'
+check_sub_test_lib_test () {
+	name="$1" # stdin is the expected output from the test
+	(
+		cd "$name" &&
+		! test -s err &&
+		sed -e 's/^> //' -e 's/Z$//' >expect &&
+		test_cmp expect out
+	)
+}
 
+test_expect_success 'pretend we have fixed a known breakage' "
+	run_sub_test_lib_test passing-todo 'A passing TODO test' <<-\\EOF &&
+	test_expect_failure 'pretend we have fixed a known breakage' 'true'
 	test_done
 	EOF
-	chmod +x passing-todo.sh &&
-	./passing-todo.sh >out 2>err &&
-	! test -s err &&
-	sed -e 's/^> //' >expect <<-\\EOF &&
+	check_sub_test_lib_test passing-todo <<-\\EOF
 	> ok 1 - pretend we have fixed a known breakage # TODO known breakage
 	> # fixed 1 known breakage(s)
 	> # passed all 1 test(s)
 	> 1..1
 	EOF
-	test_cmp expect out)
 "
+
 test_set_prereq HAVEIT
 haveit=no
 test_expect_success HAVEIT 'test runs if prerequisite is satisfied' '
@@ -137,19 +151,8 @@ then
 fi
 
 test_expect_success 'tests clean up even on failures' "
-	mkdir failing-cleanup &&
-	(
-	cd failing-cleanup &&
-
-	cat >failing-cleanup.sh <<-EOF &&
-	#!$SHELL_PATH
-
-	test_description='Failing tests with cleanup commands'
-
-	# Point to the t/test-lib.sh, which isn't in ../ as usual
-	TEST_DIRECTORY=\"$TEST_DIRECTORY\"
-	. \"\$TEST_DIRECTORY\"/test-lib.sh
-
+	test_must_fail run_sub_test_lib_test \
+		failing-cleanup 'Failing tests with cleanup commands' <<-\\EOF &&
 	test_expect_success 'tests clean up even after a failure' '
 		touch clean-after-failure &&
 		test_when_finished rm clean-after-failure &&
@@ -159,14 +162,8 @@ test_expect_success 'tests clean up even on failures' "
 		test_when_finished \"(exit 2)\"
 	'
 	test_done
-
 	EOF
-
-	chmod +x failing-cleanup.sh &&
-	test_must_fail ./failing-cleanup.sh >out 2>err &&
-	! test -s err &&
-	! test -f \"trash directory.failing-cleanup/clean-after-failure\" &&
-	sed -e 's/Z$//' -e 's/^> //' >expect <<-\\EOF &&
+	check_sub_test_lib_test failing-cleanup <<-\\EOF
 	> not ok 1 - tests clean up even after a failure
 	> #	Z
 	> #	touch clean-after-failure &&
@@ -180,8 +177,6 @@ test_expect_success 'tests clean up even on failures' "
 	> # failed 2 among 2 test(s)
 	> 1..2
 	EOF
-	test_cmp expect out
-	)
 "
 
 ################################################################
-- 
1.8.1.rc2.225.g8d36ab4
