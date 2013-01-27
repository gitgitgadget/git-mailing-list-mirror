From: Pete Wyckoff <pw@padd.com>
Subject: [PATCHv2 14/21] git p4: cygwin p4 client does not mark read-only
Date: Sat, 26 Jan 2013 22:11:17 -0500
Message-ID: <1359256284-5660-15-git-send-email-pw@padd.com>
References: <1359256284-5660-1-git-send-email-pw@padd.com>
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 27 04:16:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzIjO-0006Kw-Gf
	for gcvg-git-2@plane.gmane.org; Sun, 27 Jan 2013 04:16:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755547Ab3A0DQJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jan 2013 22:16:09 -0500
Received: from honk.padd.com ([74.3.171.149]:58737 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755361Ab3A0DQI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jan 2013 22:16:08 -0500
Received: from arf.padd.com (unknown [50.52.174.88])
	by honk.padd.com (Postfix) with ESMTPSA id 8D9C62F3F;
	Sat, 26 Jan 2013 19:16:07 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id C70BE22838; Sat, 26 Jan 2013 22:16:04 -0500 (EST)
X-Mailer: git-send-email 1.8.1.1.517.gf5c753f
In-Reply-To: <1359256284-5660-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214665>

There are some old versions of p4, compiled for cygwin, that
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
index 67101b1..2098b9b 100644
--- a/t/lib-git-p4.sh
+++ b/t/lib-git-p4.sh
@@ -148,3 +148,16 @@ client_view() {
 		printf "\t%s\n" "$@"
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
index a911988..77f6349 100755
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
1.8.1.1.460.g6fa8886
