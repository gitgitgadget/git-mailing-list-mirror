From: Ilya Bobyr <ilya.bobyr@gmail.com>
Subject: [PATCH 2/3] test-lib: tests skipped by GIT_SKIP_TESTS say so
Date: Thu, 27 Mar 2014 03:32:49 -0700
Message-ID: <1395916370-1404-3-git-send-email-ilya.bobyr@gmail.com>
References: <1395650987-5960-1-git-send-email-ilya.bobyr@gmail.com>
 <1395916370-1404-1-git-send-email-ilya.bobyr@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Ilya Bobyr <ilya.bobyr@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 27 11:34:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WT7dG-0005B8-P9
	for gcvg-git-2@plane.gmane.org; Thu, 27 Mar 2014 11:33:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755294AbaC0Kdy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Mar 2014 06:33:54 -0400
Received: from mail-pd0-f181.google.com ([209.85.192.181]:41503 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755279AbaC0Kdx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Mar 2014 06:33:53 -0400
Received: by mail-pd0-f181.google.com with SMTP id p10so3166629pdj.40
        for <git@vger.kernel.org>; Thu, 27 Mar 2014 03:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Kyep4wtjne8BUpACCEqqyJvEgKcE8e5L1cj9YavO3HQ=;
        b=Kdi/5CxfCuqAwXhjLmnzuNrh9fFDbbqZF/NoKwCm/ke1hbeQ94hPTGKyXuROPrrD5S
         VVMgJkpYAXByiBjk+ZkGZ++9AjfPR6ALZ5E033GIefcrNh3tS8p3r4Ot+DHjKL1oUDEd
         zjK30MRavDkCUcXCLrsV+wCv0Pwdx5qya6UtFuc7f+GHYgK85CCUIlrD3YbltECF5zBS
         9piw2UuXAcXa/2qy4huIydZFDIKzTtsUY21wfmvjoKRRAeKVw4Jnm3A6BNRji5ZHhAeO
         ZjPt3R0xve4bhTn2RFCSgM1cI+LKLcll9A1Cnumo5Wm6srnVWlz40In0m2hY0YAaW316
         PVIQ==
X-Received: by 10.67.14.69 with SMTP id fe5mr1019709pad.120.1395916432704;
        Thu, 27 Mar 2014 03:33:52 -0700 (PDT)
Received: from localhost.localdomain (c-50-136-172-14.hsd1.ca.comcast.net. [50.136.172.14])
        by mx.google.com with ESMTPSA id hc4sm7104861pbc.29.2014.03.27.03.33.51
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Mar 2014 03:33:51 -0700 (PDT)
X-Mailer: git-send-email 1.7.9
In-Reply-To: <1395916370-1404-1-git-send-email-ilya.bobyr@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245273>

We used to show "(missing )" next to tests skipped because they are
specified in GIT_SKIP_TESTS.  Use "(GIT_SKIP_TESTS)" instead.

Plus tests that check basic GIT_SKIP_TESTS functions.

Signed-off-by: Ilya Bobyr <ilya.bobyr@gmail.com>
---
 No changes from the previous version.

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
index 569b52d..e035f36 100644
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
