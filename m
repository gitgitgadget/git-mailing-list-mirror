From: Ilya Bobyr <ilya.bobyr@gmail.com>
Subject: [PATCH 2/3] test-lib: tests skipped by GIT_SKIP_TESTS say so
Date: Wed, 30 Apr 2014 02:50:43 -0700
Message-ID: <1398851444-2492-3-git-send-email-ilya.bobyr@gmail.com>
References: <1398154767-1276-1-git-send-email-ilya.bobyr@gmail.com>
 <1398851444-2492-1-git-send-email-ilya.bobyr@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Ilya Bobyr <ilya.bobyr@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 30 11:51:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfRAn-0003Ku-9M
	for gcvg-git-2@plane.gmane.org; Wed, 30 Apr 2014 11:51:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756960AbaD3JvT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2014 05:51:19 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:42317 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753450AbaD3JvM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2014 05:51:12 -0400
Received: by mail-pa0-f52.google.com with SMTP id kx10so1708674pab.11
        for <git@vger.kernel.org>; Wed, 30 Apr 2014 02:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tGkmK8p2K+S43nOSJCS/CRc0yoLV0zqWpOfxjlgtS/0=;
        b=bcI//B6RAzqvmSPW3yrKa4tpQdjbOo8sFUhVMp+EtTi1b9GVEXP+1loZzLxVfn8AsC
         SztODvbZl4azdEwip6RNvGYRamN3HnOD48Vbyy8zhvnfF2pYnQWn663hAE7oIbzckw6h
         WwVHi564d3Ag6o3Mlm6BTsZM/FHtVaWmp5+o/OU3KaKV7J4ndxZ2141Q1dnSQAbhJbHz
         rGJVwwkx6SpTAcAL0J9N3FMtelV7/CTCO/roJ9I651r5XMv71amkA0uwJIg1BUtracbY
         yeiy63ynVNsUDM+zHv6dr6lldlN17s2X5mrGOCC1q2iYTKr/q2oeStREgPQso7/Q7EOV
         +v/g==
X-Received: by 10.66.219.225 with SMTP id pr1mr6591040pac.83.1398851468358;
        Wed, 30 Apr 2014 02:51:08 -0700 (PDT)
Received: from localhost.localdomain (c-50-136-172-14.hsd1.ca.comcast.net. [50.136.172.14])
        by mx.google.com with ESMTPSA id ss2sm131761603pab.8.2014.04.30.02.51.07
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Apr 2014 02:51:07 -0700 (PDT)
X-Mailer: git-send-email 1.7.9
In-Reply-To: <1398851444-2492-1-git-send-email-ilya.bobyr@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247695>

We used to show "(missing )" next to tests skipped because they are
specified in GIT_SKIP_TESTS.  Use "(GIT_SKIP_TESTS)" instead.

Plus tests that check basic GIT_SKIP_TESTS functions.

Signed-off-by: Ilya Bobyr <ilya.bobyr@gmail.com>
---
No changes.

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
