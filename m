From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 14/21] git p4: cygwin p4 client does not mark read-only
Date: Fri, 28 Sep 2012 08:04:18 -0400
Message-ID: <1348833865-6093-15-git-send-email-pw@padd.com>
References: <1348833865-6093-1-git-send-email-pw@padd.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 28 14:09:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THZNg-0003PC-80
	for gcvg-git-2@plane.gmane.org; Fri, 28 Sep 2012 14:09:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757487Ab2I1MJL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Sep 2012 08:09:11 -0400
Received: from honk.padd.com ([74.3.171.149]:58372 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751613Ab2I1MJK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Sep 2012 08:09:10 -0400
Received: from arf.padd.com (unknown [50.55.148.232])
	by honk.padd.com (Postfix) with ESMTPSA id 9B52F5AF2;
	Fri, 28 Sep 2012 05:09:09 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 3667131413; Fri, 28 Sep 2012 08:09:07 -0400 (EDT)
X-Mailer: git-send-email 1.7.12.1.457.g468b3ef
In-Reply-To: <1348833865-6093-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206571>

There are some old version of p4, compiled for cygwin, that
treat read-only files differently.

Normally, a file that is not open is read-only, meaning that
"test -w" on the file is false.  This works on unix, and it works
on windows using the NT version of p4.  The cygwin version
of p4, though, changes the permissions, but does not set the
windows read-only attribute, so "test -w" returns false.

Notice this oddity and make the tests work, even on cygiwn.

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 t/lib-git-p4.sh               | 13 +++++++++++++
 t/t9807-git-p4-submit.sh      | 14 ++++++++++++--
 t/t9809-git-p4-client-view.sh |  4 ++--
 3 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/t/lib-git-p4.sh b/t/lib-git-p4.sh
index fbd55ea..23d01fd 100644
--- a/t/lib-git-p4.sh
+++ b/t/lib-git-p4.sh
@@ -150,3 +150,16 @@ client_view() {
 		done
 	) | p4 client -i
 }
+
+is_cli_file_writeable() {
+	# cygwin version of p4 does not set read-only attr,
+	# will be marked 444 but -w is true
+	file="$1" &&
+	if test_have_prereq CYGWIN && p4 -V | grep -q CYGWIN
+	then
+		stat=$(stat --format=%a "$file") &&
+		test $stat = 644
+	else
+		test -w "$file"
+	fi
+}
diff --git a/t/t9807-git-p4-submit.sh b/t/t9807-git-p4-submit.sh
index 0ae048f..1fb7bc7 100755
--- a/t/t9807-git-p4-submit.sh
+++ b/t/t9807-git-p4-submit.sh
@@ -17,6 +17,16 @@ test_expect_success 'init depot' '
 	)
 '
 
+test_expect_failure 'is_cli_file_writeable function' '
+	(
+		cd "$cli" &&
+		echo a >a &&
+		is_cli_file_writeable a &&
+		! is_cli_file_writeable file1 &&
+		rm a
+	)
+'
+
 test_expect_success 'submit with no client dir' '
 	test_when_finished cleanup_git &&
 	git p4 clone --dest="$git" //depot &&
@@ -200,7 +210,7 @@ test_expect_success 'submit copy' '
 	(
 		cd "$cli" &&
 		test_path_is_file file5.ta &&
-		test ! -w file5.ta
+		! is_cli_file_writeable file5.ta
 	)
 '
 
@@ -219,7 +229,7 @@ test_expect_success 'submit rename' '
 		cd "$cli" &&
 		test_path_is_missing file6.t &&
 		test_path_is_file file6.ta &&
-		test ! -w file6.ta
+		! is_cli_file_writeable file6.ta
 	)
 '
 
diff --git a/t/t9809-git-p4-client-view.sh b/t/t9809-git-p4-client-view.sh
index fd8fa89..e0eb6b0 100755
--- a/t/t9809-git-p4-client-view.sh
+++ b/t/t9809-git-p4-client-view.sh
@@ -333,7 +333,7 @@ test_expect_success 'subdir clone, submit copy' '
 	(
 		cd "$cli" &&
 		test_path_is_file dir1/file11a &&
-		test ! -w dir1/file11a
+		! is_cli_file_writeable dir1/file11a
 	)
 '
 
@@ -353,7 +353,7 @@ test_expect_success 'subdir clone, submit rename' '
 		cd "$cli" &&
 		test_path_is_missing dir1/file13 &&
 		test_path_is_file dir1/file13a &&
-		test ! -w dir1/file13a
+		! is_cli_file_writeable dir1/file13a
 	)
 '
 
-- 
1.7.12.1.403.g28165e1
