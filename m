Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B9D9520286
	for <e@80x24.org>; Wed, 13 Sep 2017 19:00:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751896AbdIMTAw (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Sep 2017 15:00:52 -0400
Received: from avasout07.plus.net ([84.93.230.235]:46751 "EHLO
        avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751810AbdIMTAw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Sep 2017 15:00:52 -0400
Received: from [10.0.2.15] ([147.147.86.16])
        by avasout07 with smtp
        id 970o1w00B0M91Ur0170qT9; Wed, 13 Sep 2017 20:00:50 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=CrLPSjwD c=1 sm=1 tr=0
 a=dubYQqM3tRRTmV8xSh8cXQ==:117 a=dubYQqM3tRRTmV8xSh8cXQ==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=7JGjDT5uExA8dU3LybAA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] test-lib: don't use ulimit in test prerequisites on cygwin
To:     Michael J Gruber <git@grubix.eu>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Adam Dinwoodie <adam@dinwoodie.org>,
        Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Message-ID: <b57731ed-4640-d27f-f7b2-6c70af8dd400@ramsayjones.plus.com>
Date:   Wed, 13 Sep 2017 20:00:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On cygwin (and MinGW), the 'ulimit' built-in bash command does not have
the desired effect of limiting the resources of new processes, at least
for the stack and file descriptors. However, it always returns success
and leads to several test prerequisites being erroneously set to true.

Add a check for cygwin and MinGW to the prerequisite expressions, using
'uname -s', and return false instead of (indirectly) using 'ulimit'.
This affects the prerequisite expressions for the ULIMIT_STACK_SIZE,
CMDLINE_LIMIT and ULIMIT_FILE_DESCRIPTORS prerequisites.

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Michael,

So, I finally got around to testing ulimit with open files and
found that it does not limit them on cygwin (it actually fails
on the hard limit of 3200). Having seen Johannes email earlier,
I took a chance and added MinGW to this patch as well. (Hopefully
this won't cause any screams!) ;-)

So, this patch was developed on top of the 'pu' branch, but it
also applies cleanly to your 'mg/name-rev-tests-with-short-stack'
branch (ie. on top of commit 31625b34c0).

If you are going to re-roll your branch, could you please add this
on top (after squashing the two comment deletions into your earlier
patches, maybe).

Thanks!

ATB,
Ramsay Jones

 t/t1400-update-ref.sh | 11 ++++++++++-
 t/t6120-describe.sh   |  1 -
 t/t7004-tag.sh        |  1 -
 t/test-lib.sh         | 22 ++++++++++++++++++++--
 4 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index dc98b4bc6..49415074f 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -1253,7 +1253,16 @@ run_with_limited_open_files () {
 	(ulimit -n 32 && "$@")
 }
 
-test_lazy_prereq ULIMIT_FILE_DESCRIPTORS 'run_with_limited_open_files true'
+test_lazy_prereq ULIMIT_FILE_DESCRIPTORS '
+	case $(uname -s) in
+	CYGWIN*|MINGW*)
+		false
+		;;
+	*)
+		run_with_limited_open_files true
+		;;
+	esac
+'
 
 test_expect_success ULIMIT_FILE_DESCRIPTORS 'large transaction creating branches does not burst open file limit' '
 (
diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index dd6dd9df9..3d45dc295 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -279,7 +279,6 @@ test_expect_success 'describe ignoring a borken submodule' '
 	grep broken out
 '
 
-# we require ulimit, this excludes Windows
 test_expect_failure ULIMIT_STACK_SIZE 'name-rev works in a deep repo' '
 	i=1 &&
 	while test $i -lt 8000
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 5bf5ace56..b545c33f8 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -1863,7 +1863,6 @@ test_expect_success 'version sort with very long prerelease suffix' '
 	git tag -l --sort=version:refname
 '
 
-# we require ulimit, this excludes Windows
 test_expect_success ULIMIT_STACK_SIZE '--contains and --no-contains work in a deep repo' '
 	>expect &&
 	i=1 &&
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 83f5d3dd2..250ba5e9b 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1170,13 +1170,31 @@ run_with_limited_cmdline () {
 	(ulimit -s 128 && "$@")
 }
 
-test_lazy_prereq CMDLINE_LIMIT 'run_with_limited_cmdline true'
+test_lazy_prereq CMDLINE_LIMIT '
+	case $(uname -s) in
+	CYGWIN*|MINGW*)
+		false
+		;;
+	*)
+		run_with_limited_cmdline true
+		;;
+	esac
+'
 
 run_with_limited_stack () {
 	(ulimit -s 128 && "$@")
 }
 
-test_lazy_prereq ULIMIT_STACK_SIZE 'run_with_limited_stack true'
+test_lazy_prereq ULIMIT_STACK_SIZE '
+	case $(uname -s) in
+	CYGWIN*|MINGW*)
+		false
+		;;
+	*)
+		run_with_limited_stack true
+		;;
+	esac
+'
 
 build_option () {
 	git version --build-options |
-- 
2.14.0
