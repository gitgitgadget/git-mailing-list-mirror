From: Ilya Bobyr <ilya.bobyr@gmail.com>
Subject: [PATCH 2/3] test-lib: tests skipped by GIT_SKIP_TESTS say so
Date: Tue, 22 Apr 2014 01:19:26 -0700
Message-ID: <1398154767-1276-3-git-send-email-ilya.bobyr@gmail.com>
References: <1398154767-1276-1-git-send-email-ilya.bobyr@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Ilya Bobyr <ilya.bobyr@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 22 10:20:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WcVwH-00024U-4Z
	for gcvg-git-2@plane.gmane.org; Tue, 22 Apr 2014 10:20:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754988AbaDVIUR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2014 04:20:17 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:47690 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753996AbaDVIUL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2014 04:20:11 -0400
Received: by mail-pa0-f44.google.com with SMTP id bj1so4688404pad.31
        for <git@vger.kernel.org>; Tue, 22 Apr 2014 01:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RU2Tb5DiKKCZKWhYlJJlxrgyRi/oQKRT0SZZ9IwCabY=;
        b=YAjwYG61p072IYmmDX20uZ3wyL0J/0RB+3IgblF1LBeS7TBpMxaAV68MB0Oavnh68K
         tJODPZyEkwo+khEfsAMevVJT1Ve1h+l0oMMmKASXSBNPuebaFIHt06Oj6PuFepsfO9Pm
         vpdrN0o367EOwhSACxyaMCRzYtp+5OxKeH2KzLdySnBaBzxU1Zc8dB8Srez1tpgzhohc
         9mlDVRHVQRTwVHCuiQG1czlRcwW1kkXgL2iFIMuWSiROFEr76N+WJlPxB7uBzbuTX4is
         tnnepj5ly5fI4h4gJ+Aseb/1zLcHdVv8dgnci/bw8y0oqNqTeaiUIUIVlroLADbx5VjY
         Le0Q==
X-Received: by 10.66.164.70 with SMTP id yo6mr42844865pab.85.1398154810817;
        Tue, 22 Apr 2014 01:20:10 -0700 (PDT)
Received: from localhost.localdomain (c-50-136-172-14.hsd1.ca.comcast.net. [50.136.172.14])
        by mx.google.com with ESMTPSA id om6sm83107950pbc.43.2014.04.22.01.20.09
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Apr 2014 01:20:10 -0700 (PDT)
X-Mailer: git-send-email 1.7.9
In-Reply-To: <1398154767-1276-1-git-send-email-ilya.bobyr@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246714>

We used to show "(missing )" next to tests skipped because they are
specified in GIT_SKIP_TESTS.  Use "(GIT_SKIP_TESTS)" instead.

Plus tests that check basic GIT_SKIP_TESTS functions.

Signed-off-by: Ilya Bobyr <ilya.bobyr@gmail.com>
---
 t/t0000-basic.sh |   63 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 t/test-lib.sh    |   13 ++++++----
 2 files changed, 71 insertions(+), 5 deletions(-)

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index a2bb63c..ae8874e 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -270,6 +270,69 @@ test_expect_success 'test --verbose-only' '
 	EOF
 '
 
+test_expect_success 'GIT_SKIP_TESTS' "
+	GIT_SKIP_TESTS='git.2' \
+		run_sub_test_lib_test git-skip-tests-basic \
+		'GIT_SKIP_TESTS' <<-\\EOF &&
+	for i in 1 2 3
+	do
+		test_expect_success \"passing test #\$i\" 'true'
+	done
+	test_done
+	EOF
+	check_sub_test_lib_test git-skip-tests-basic <<-\\EOF
+	> ok 1 - passing test #1
+	> ok 2 # skip passing test #2 (GIT_SKIP_TESTS)
+	> ok 3 - passing test #3
+	> # passed all 3 test(s)
+	> 1..3
+	EOF
+"
+
+test_expect_success 'GIT_SKIP_TESTS several tests' "
+	GIT_SKIP_TESTS='git.2 git.5' \
+		run_sub_test_lib_test git-skip-tests-several \
+		'GIT_SKIP_TESTS several tests' <<-\\EOF &&
+	for i in 1 2 3 4 5 6
+	do
+		test_expect_success \"passing test #\$i\" 'true'
+	done
+	test_done
+	EOF
+	check_sub_test_lib_test git-skip-tests-several <<-\\EOF
+	> ok 1 - passing test #1
+	> ok 2 # skip passing test #2 (GIT_SKIP_TESTS)
+	> ok 3 - passing test #3
+	> ok 4 - passing test #4
+	> ok 5 # skip passing test #5 (GIT_SKIP_TESTS)
+	> ok 6 - passing test #6
+	> # passed all 6 test(s)
+	> 1..6
+	EOF
+"
+
+test_expect_success 'GIT_SKIP_TESTS sh pattern' "
+	GIT_SKIP_TESTS='git.[2-5]' \
+		run_sub_test_lib_test git-skip-tests-sh-pattern \
+		'GIT_SKIP_TESTS sh pattern' <<-\\EOF &&
+	for i in 1 2 3 4 5 6
+	do
+		test_expect_success \"passing test #\$i\" 'true'
+	done
+	test_done
+	EOF
+	check_sub_test_lib_test git-skip-tests-sh-pattern <<-\\EOF
+	> ok 1 - passing test #1
+	> ok 2 # skip passing test #2 (GIT_SKIP_TESTS)
+	> ok 3 # skip passing test #3 (GIT_SKIP_TESTS)
+	> ok 4 # skip passing test #4 (GIT_SKIP_TESTS)
+	> ok 5 # skip passing test #5 (GIT_SKIP_TESTS)
+	> ok 6 - passing test #6
+	> # passed all 6 test(s)
+	> 1..6
+	EOF
+"
+
 test_set_prereq HAVEIT
 haveit=no
 test_expect_success HAVEIT 'test runs if prerequisite is satisfied' '
diff --git a/t/test-lib.sh b/t/test-lib.sh
index c081668..e7d9c51 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -452,25 +452,28 @@ test_finish_ () {
 
 test_skip () {
 	to_skip=
+	skipped_reason=
 	if match_pattern_list $this_test.$test_count $GIT_SKIP_TESTS
 	then
 		to_skip=t
+		skipped_reason="GIT_SKIP_TESTS"
 	fi
 	if test -z "$to_skip" && test -n "$test_prereq" &&
 	   ! test_have_prereq "$test_prereq"
 	then
 		to_skip=t
-	fi
-	case "$to_skip" in
-	t)
+
 		of_prereq=
 		if test "$missing_prereq" != "$test_prereq"
 		then
 			of_prereq=" of $test_prereq"
 		fi
-
+		skipped_reason="missing $missing_prereq${of_prereq}"
+	fi
+	case "$to_skip" in
+	t)
 		say_color skip >&3 "skipping test: $@"
-		say_color skip "ok $test_count # skip $1 (missing $missing_prereq${of_prereq})"
+		say_color skip "ok $test_count # skip $1 ($skipped_reason)"
 		: true
 		;;
 	*)
-- 
1.7.9
