From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH 2/2] perf-lib: add test_perf_cleanup target
Date: Tue, 17 Sep 2013 14:10:42 +0200
Message-ID: <1379419842-32627-2-git-send-email-t.gummerer@gmail.com>
References: <1379419842-32627-1-git-send-email-t.gummerer@gmail.com>
Cc: trast@inf.ethz.ch, gitster@pobox.com, t.gummerer@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 17 14:11:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VLu7W-0006Ek-VQ
	for gcvg-git-2@plane.gmane.org; Tue, 17 Sep 2013 14:11:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752493Ab3IQMK7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Sep 2013 08:10:59 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:64183 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752340Ab3IQMKv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Sep 2013 08:10:51 -0400
Received: by mail-bk0-f46.google.com with SMTP id 6so2081909bkj.5
        for <git@vger.kernel.org>; Tue, 17 Sep 2013 05:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Uk0TE009978bJiOvF9NG5nVcW09N7JyP86Q43SJVPVw=;
        b=Uc2/caXUJfQI2n4o+c+rBkVTUVlmkxqQ/9h730JQqfzjr8spXOq+FrG7DzI9Im6/lV
         s2C2EGQWUdHohURE3aOdsWtzwVEvtQEdVrhs5rpvuj9E+aYbtxgPeL1M9B4Ua1NJqS6u
         kKgv07tNdQD86CPxSCiB8nxojVEnT2zPG3yx1SgNkmcNZjUpDUymwF5N+IZr0Sq87w9X
         jbdjLKj/bq/kLIr8rXMGNfsevZ5NYNUSZA6tQuw4Oyh4/BdqiN9TZizHToDK2ENdNL12
         YW8myrkOGveMpFMADi9JJN5DT0fh6Vqi/kJ7iceNJ5f/l2/fQKqziVB64AM58eq5LyiY
         zDNg==
X-Received: by 10.204.123.199 with SMTP id q7mr29629692bkr.10.1379419850469;
        Tue, 17 Sep 2013 05:10:50 -0700 (PDT)
Received: from localhost ([2001:5c0:1400:a::44f])
        by mx.google.com with ESMTPSA id b6sm9986380bko.16.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 17 Sep 2013 05:10:49 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.4.1238.ga800761
In-Reply-To: <1379419842-32627-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234875>

Currently there is no way to clean up the changes that have been made
with test_perf for the next run.  Add a way to reset the repository to
the state before the test for testing commands that modify the git
repository, e.g. for perf testing git add.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---

This enables me to do something like (hint, hint, hint ;-)):

Test                                        HEAD~1            HEAD                  
------------------------------------------------------------------------------------
....
0003.16: v5 update-index file               0.19(0.12+0.06)   0.08(0.06+0.01) -57.9%

There are no performance tests currently using this, but since I have
it anyway for a POC of partial writing of index-v5 (which is ugly and
will have to wait a bit until I'm ready to send it to the list) I think
this may be a worthwhile addition others can use in the meantime.

 t/perf/README      | 11 +++++++++++
 t/perf/perf-lib.sh | 25 +++++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/t/perf/README b/t/perf/README
index 8848c14..72f8a7b 100644
--- a/t/perf/README
+++ b/t/perf/README
@@ -123,6 +123,17 @@ tests, use
 		command2
 	'
 
+For performance tests that need cleaning up after them that should not
+be timed, use
+
+	test_perf_cleanup 'descriptive string' '
+		command1 &&
+		command2
+	' '
+		cleanupcommand1 &&
+		cleanupcommand2
+	'
+
 test_perf spawns a subshell, for lack of better options.  This means
 that
 
diff --git a/t/perf/perf-lib.sh b/t/perf/perf-lib.sh
index 95e483c..11a93f1 100644
--- a/t/perf/perf-lib.sh
+++ b/t/perf/perf-lib.sh
@@ -174,6 +174,22 @@ perf_test_ () {
 				test_failure_ "$@"
 				break
 			fi
+			say >&3 "cleaning up: $3"
+			if test "$#" = 3
+			then
+				if test_run_ "$3"
+				then
+					if test -z "$verbose"; then
+						echo -n " c$i"
+					else
+						echo "* cleaning up run $i/$GIT_PERF_REPEAT_COUNT:"
+					fi
+				else
+					test -z "$verbose" && echo
+					test_failure_ "$@"
+					break
+				fi
+			fi
 		done
 		if test -z "$verbose"; then
 			echo " ok"
@@ -194,6 +210,15 @@ test_perf () {
 	perf_test_ "$1" "$2"
 }
 
+test_perf_cleanup () {
+	test_start_
+	test "$#" = 4 && { test_prereq=$1; shift; } || test_prereq=
+	test "$#" = 3 ||
+	error "bug in the test script: not 3 or 4 parameters to test-expect-success"
+	export test_prereq
+	perf_test_ "$1" "$2" "$3"
+}
+
 # We extend test_done to print timings at the end (./run disables this
 # and does it after running everything)
 test_at_end_hook_ () {
-- 
1.8.3.4.1238.ga800761
