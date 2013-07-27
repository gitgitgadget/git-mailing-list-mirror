From: Lukas Fleischer <git@cryptocrack.de>
Subject: [PATCH] Avoid using `echo -n` anywhere
Date: Sat, 27 Jul 2013 14:11:33 +0200
Message-ID: <1374927093-16663-1-git-send-email-git@cryptocrack.de>
References: <CAFM=nTeRpZ=Y-+4KMCZd8Qj-9K105uSquh8Y=7mC3aqJiE0gbQ@mail.gmail.com>
Cc: Avery Pennarun <apenwarr@gmail.com>,
	"David A. Greene" <greened@obbligato.org>,
	Thomas Rast <trast@inf.ethz.ch>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 27 14:11:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V33La-00048y-KC
	for gcvg-git-2@plane.gmane.org; Sat, 27 Jul 2013 14:11:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751617Ab3G0MLi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Jul 2013 08:11:38 -0400
Received: from elnino.cryptocrack.de ([46.165.227.75]:25554 "EHLO
	elnino.cryptocrack.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751538Ab3G0MLh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jul 2013 08:11:37 -0400
Received: from localhost (p5B2C6C02.dip0.t-ipconnect.de [91.44.108.2]);
	by elnino.cryptocrack.de (OpenSMTPD) with ESMTP id b699c058;
	TLS version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO;
	Sat, 27 Jul 2013 14:11:34 +0200 (CEST)
X-Mailer: git-send-email 1.8.3.3.1135.ge2c9e63
In-Reply-To: <CAFM=nTeRpZ=Y-+4KMCZd8Qj-9K105uSquh8Y=7mC3aqJiE0gbQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231240>

`echo -n` is non-portable. The POSIX specification says:

    Conforming applications that wish to do prompting without <newline>
    characters or that could possibly be expecting to echo a -n, should
    use the printf utility derived from the Ninth Edition system.

Since all of the affected shell scripts use a POSIX shell shebang,
replace `echo -n` invocations with printf.

Signed-off-by: Lukas Fleischer <git@cryptocrack.de>
---
 contrib/subtree/git-subtree.sh     | 2 +-
 contrib/subtree/t/t7900-subtree.sh | 8 ++++----
 t/perf/perf-lib.sh                 | 4 ++--
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index 51ae932..7d7af03 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -311,7 +311,7 @@ copy_commit()
 			GIT_COMMITTER_NAME \
 			GIT_COMMITTER_EMAIL \
 			GIT_COMMITTER_DATE
-		(echo -n "$annotate"; cat ) |
+		(printf "%s" "$annotate"; cat ) |
 		git commit-tree "$2" $3  # reads the rest of stdin
 	) || die "Can't copy commit $1"
 }
diff --git a/contrib/subtree/t/t7900-subtree.sh b/contrib/subtree/t/t7900-subtree.sh
index b0f8536..556a94d 100755
--- a/contrib/subtree/t/t7900-subtree.sh
+++ b/contrib/subtree/t/t7900-subtree.sh
@@ -182,9 +182,9 @@ test_expect_success 'merge new subproj history into subdir' '
 test_expect_success 'Check that prefix argument is required for split' '
         echo "You must provide the --prefix option." > expected &&
         test_must_fail git subtree split > actual 2>&1 &&
-        test_debug "echo -n expected: " &&
+        test_debug "printf '"'"'expected: '"'"'" &&
         test_debug "cat expected" &&
-        test_debug "echo -n actual: " &&
+        test_debug "printf '"'"'actual: '"'"'" &&
         test_debug "cat actual" &&
         test_cmp expected actual &&
         rm -f expected actual
@@ -193,9 +193,9 @@ test_expect_success 'Check that prefix argument is required for split' '
 test_expect_success 'Check that the <prefix> exists for a split' '
         echo "'"'"'non-existent-directory'"'"'" does not exist\; use "'"'"'git subtree add'"'"'" > expected &&
         test_must_fail git subtree split --prefix=non-existent-directory > actual 2>&1 &&
-        test_debug "echo -n expected: " &&
+        test_debug "printf '"'"'expected: '"'"'" &&
         test_debug "cat expected" &&
-        test_debug "echo -n actual: " &&
+        test_debug "printf '"'"'actual: '"'"'" &&
         test_debug "cat actual" &&
         test_cmp expected actual
 #        rm -f expected actual
diff --git a/t/perf/perf-lib.sh b/t/perf/perf-lib.sh
index c61d535..ae44117 100644
--- a/t/perf/perf-lib.sh
+++ b/t/perf/perf-lib.sh
@@ -161,7 +161,7 @@ test_perf () {
 		echo "$test_count" >>"$perf_results_dir"/$base.subtests
 		echo "$1" >"$perf_results_dir"/$base.$test_count.descr
 		if test -z "$verbose"; then
-			echo -n "perf $test_count - $1:"
+			printf "%s" "perf $test_count - $1:"
 		else
 			echo "perf $test_count - $1:"
 		fi
@@ -170,7 +170,7 @@ test_perf () {
 			if test_run_perf_ "$2"
 			then
 				if test -z "$verbose"; then
-					echo -n " $i"
+					printf " %d" "$i"
 				else
 					echo "* timing run $i/$GIT_PERF_REPEAT_COUNT:"
 				fi
-- 
1.8.3.3.1135.ge2c9e63
