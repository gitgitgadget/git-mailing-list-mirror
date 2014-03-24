From: Ilya Bobyr <ilya.bobyr@gmail.com>
Subject: [PATCH 2/3] test-lib: tests skipped by GIT_SKIP_TESTS say so
Date: Mon, 24 Mar 2014 01:49:46 -0700
Message-ID: <1395650987-5960-3-git-send-email-ilya.bobyr@gmail.com>
References: <1395650987-5960-1-git-send-email-ilya.bobyr@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ilya Bobyr <ilya.bobyr@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 24 09:50:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WS0av-0004TJ-5b
	for gcvg-git-2@plane.gmane.org; Mon, 24 Mar 2014 09:50:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753125AbaCXIuv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2014 04:50:51 -0400
Received: from mail-pb0-f42.google.com ([209.85.160.42]:41553 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753119AbaCXIum (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Mar 2014 04:50:42 -0400
Received: by mail-pb0-f42.google.com with SMTP id rr13so5153787pbb.15
        for <git@vger.kernel.org>; Mon, 24 Mar 2014 01:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GKmBka4vsvH9mMmowmXggsaCRZsiwie1iXUWpXhIFmw=;
        b=APQxa0jPA1+103fBEY3FBp66A0CjBvJMsWUXlfugUk/PCH029pcBM9/CTi1cqXM2xj
         3Nhr1b0EnIHG6cUuu7mxQwdiFKdRN/fusl40blyOIG+hd1NkWsJ8+QOTYcYrFCFI2yv9
         TyUU3ThaHAYpWV2saOV4z3LjoR3ajYgJVYGBvX3pAz6JZzYsjwUZPE/b6W2ERWHK1uBY
         lKMc9wCHYPGN1IUMwLvoLz188q+ZrBZEEcz/Za4mRzbH8/APaEDJ9oI+vadbQfw8Z9p5
         8Cr8/ca2wQXLapfN5f3iGEdJvcVIGPtG+SgmQHRPdgW4fIPCYZVKJdHNCel+GEtE1CjD
         14fg==
X-Received: by 10.66.232.68 with SMTP id tm4mr69628026pac.114.1395651042227;
        Mon, 24 Mar 2014 01:50:42 -0700 (PDT)
Received: from localhost.localdomain (c-50-136-172-14.hsd1.ca.comcast.net. [50.136.172.14])
        by mx.google.com with ESMTPSA id vx10sm56423680pac.17.2014.03.24.01.50.40
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Mar 2014 01:50:41 -0700 (PDT)
X-Mailer: git-send-email 1.7.9
In-Reply-To: <1395650987-5960-1-git-send-email-ilya.bobyr@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244814>

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
