From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v2 2/3] perf-lib: add cleanup option
Date: Mon, 23 Sep 2013 23:08:45 +0200
Message-ID: <1379970526-27997-3-git-send-email-t.gummerer@gmail.com>
References: <xmqqtxhgsi5p.fsf@gitster.dls.corp.google.com>
 <1379970526-27997-1-git-send-email-t.gummerer@gmail.com>
Cc: trast@inf.ethz.ch, git@vger.kernel.org, t.gummerer@gmail.com
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Sep 23 23:10:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VODOK-0007ut-KM
	for gcvg-git-2@plane.gmane.org; Mon, 23 Sep 2013 23:10:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753920Ab3IWVJz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Sep 2013 17:09:55 -0400
Received: from mail-pb0-f52.google.com ([209.85.160.52]:38589 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753603Ab3IWVJy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Sep 2013 17:09:54 -0400
Received: by mail-pb0-f52.google.com with SMTP id wz12so3682530pbc.11
        for <git@vger.kernel.org>; Mon, 23 Sep 2013 14:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mBuZuq/1K+BvMbI1gUCC2NuluhK+52sTrhegoJkeeek=;
        b=N3LrZLY3q2o3v+tXxtdWAa3+Pw/tm0wIxmgkIHi2XFn/yH8Wa9ofnoDvmfQrebZQiO
         OBM08fAlp+/SZU3FKmBMfhi5iR2ShcEZV9TLOFeQ7Mv6b9d6e+fHZCVL0JMCifiImgKh
         KFCOZDdVv150BhiYEbsgOWrpCMNX6TSFYYi8yiaim+EyAVnKb5xkNgDJIBxTV/7vTnur
         Ikyjg5gLMDAU7dJtuVOgsXnk56Vpd0PxJJhTaq7xHzP5TMFaLVIQ1qiTDh08vLlnb3fb
         qHLBajV0j2wihqg/KLWc49NNToFApEqlouu1KP8dngDaXtyvOCjbz8BZ32DTjoikW3vi
         bd4Q==
X-Received: by 10.68.134.202 with SMTP id pm10mr25598093pbb.2.1379970593986;
        Mon, 23 Sep 2013 14:09:53 -0700 (PDT)
Received: from localhost ([216.18.212.218])
        by mx.google.com with ESMTPSA id sn4sm31645873pbc.37.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 23 Sep 2013 14:09:53 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.4.1241.g1ce9896
In-Reply-To: <1379970526-27997-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235243>

Add a --cleanup for the performance tests.  This option can be used to
clean up the tested repository after each time the performance tests are
run.  The option can be specified for normal tests too, although it will
not do anything for them.  Use test_when_finished for those tests.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 t/perf/README           | 11 ++++++++++-
 t/perf/perf-lib.sh      | 15 +++++++++++++++
 t/test-lib-functions.sh |  6 ++++++
 3 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/t/perf/README b/t/perf/README
index 21abbaf..73a1d1c 100644
--- a/t/perf/README
+++ b/t/perf/README
@@ -123,7 +123,7 @@ tests, use
 		command2
 	'
 
-	test_perf [--prereq <prereq>] [--] 'descriptive string' '
+	test_perf [--prereq <prereq>] [--cleanup <cleanup>] [--] 'descriptive string' '
 		command1 &&
 		command2
 	'
@@ -133,6 +133,15 @@ tests are only executed if the prerequisite is fulfilled.  The modern
 version also allows to distinguish the message from the description
 and test script with --, in case the message starts with --.
 
+cleanup is another optional parameter to test_perf, which is executed
+after every run of the performance test.  It can specify actions to
+bring the repository to the original state, in order to be able to
+execute the exact same test multiple times, e.g:
+
+	test_perf --cleanup 'git reset' 'test performance of git add' '
+		  git add $somefile
+	'
+
 test_perf spawns a subshell, for lack of better options.  This means
 that
 
diff --git a/t/perf/perf-lib.sh b/t/perf/perf-lib.sh
index 6477d38..8ace4a3 100644
--- a/t/perf/perf-lib.sh
+++ b/t/perf/perf-lib.sh
@@ -176,6 +176,21 @@ test_perf () {
 				test_failure_ "$@"
 				break
 			fi
+			if ! test -z "$cleanup_action"; then
+				say >&3 "cleaning up: $cleanup_action"
+				if test_run_ "$cleanup_action"
+				then
+					if test -z "$verbose"; then
+						printf " c%s" "$i"
+					else
+						echo "* cleaning up run $i/$GIT_PERF_REPEAT_COUNT:"
+					fi
+				else
+					test -z $verbose && echo
+					test_failure_ "$@"
+					break
+				fi
+			fi
 		done
 		if test -z "$verbose"; then
 			echo " ok"
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 473b21d..4bad14f 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -360,6 +360,12 @@ test_expect_parse () {
 			test_prereq=$2
 			shift
 			;;
+		--cleanup)
+			test $# -gt 1 ||
+			error "bug in the test script: --cleanup needs a parameter"
+			cleanup_action=$2
+			shift
+			;;
 		--)
 			shift
 			break
-- 
1.8.3.4.1241.g1ce9896
