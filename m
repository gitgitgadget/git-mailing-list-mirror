From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 10/11] git p4 test: examine behavior with locked (+l) files
Date: Tue, 21 Jan 2014 18:16:47 -0500
Message-ID: <1390346208-9207-11-git-send-email-pw@padd.com>
References: <1390346208-9207-1-git-send-email-pw@padd.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 22 00:20:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W5kcD-0002V5-Mo
	for gcvg-git-2@plane.gmane.org; Wed, 22 Jan 2014 00:20:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753965AbaAUXUN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jan 2014 18:20:13 -0500
Received: from honk.padd.com ([74.3.171.149]:36966 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752447AbaAUXUN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jan 2014 18:20:13 -0500
Received: from arf.padd.com (unknown [50.105.0.78])
	by honk.padd.com (Postfix) with ESMTPSA id 494527138;
	Tue, 21 Jan 2014 15:20:12 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id CB475200F7; Tue, 21 Jan 2014 18:20:08 -0500 (EST)
X-Mailer: git-send-email 1.8.5.2.364.g6ac45cd
In-Reply-To: <1390346208-9207-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240800>

The p4 server can enforce file locking, so that only one user
can edit a file at a time.  Git p4 is unable to submit changes
to locked files.  Currently it exits poorly.  Ideally it would
notice the locked condition and clean up nicely.

Add a bunch of tests that describe the problem, hoping that
fixes appear in the future.

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 t/t9816-git-p4-locked.sh | 145 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 145 insertions(+)
 create mode 100755 t/t9816-git-p4-locked.sh

diff --git a/t/t9816-git-p4-locked.sh b/t/t9816-git-p4-locked.sh
new file mode 100755
index 0000000..e71e543
--- /dev/null
+++ b/t/t9816-git-p4-locked.sh
@@ -0,0 +1,145 @@
+#!/bin/sh
+
+test_description='git p4 locked file behavior'
+
+. ./lib-git-p4.sh
+
+test_expect_success 'start p4d' '
+	start_p4d
+'
+
+# See
+# http://www.perforce.com/perforce/doc.current/manuals/p4sag/03_superuser.html#1088563
+# for suggestions on how to configure "sitewide pessimistic locking"
+# where only one person can have a file open for edit at a time.
+test_expect_success 'init depot' '
+	(
+		cd "$cli" &&
+		echo "TypeMap: +l //depot/..." | p4 typemap -i &&
+		echo file1 >file1 &&
+		p4 add file1 &&
+		p4 submit -d "add file1"
+	)
+'
+
+test_expect_success 'edit with lock not taken' '
+	test_when_finished cleanup_git &&
+	git p4 clone --dest="$git" //depot &&
+	(
+		cd "$git" &&
+		echo line2 >>file1 &&
+		git add file1 &&
+		git commit -m "line2 in file1" &&
+		git config git-p4.skipSubmitEdit true &&
+		git p4 submit
+	)
+'
+
+test_expect_failure 'add with lock not taken' '
+	test_when_finished cleanup_git &&
+	git p4 clone --dest="$git" //depot &&
+	(
+		cd "$git" &&
+		echo line1 >>add-lock-not-taken &&
+		git add file2 &&
+		git commit -m "add add-lock-not-taken" &&
+		git config git-p4.skipSubmitEdit true &&
+		git p4 submit --verbose
+	)
+'
+
+lock_in_another_client() {
+	# build a different client
+	cli2="$TRASH_DIRECTORY/cli2" &&
+	mkdir -p "$cli2" &&
+	test_when_finished "p4 client -f -d client2 && rm -rf \"$cli2\"" &&
+	(
+		cd "$cli2" &&
+		P4CLIENT=client2 &&
+		cli="$cli2" &&
+		client_view "//depot/... //client2/..." &&
+		p4 sync &&
+		p4 open file1
+	)
+}
+
+test_expect_failure 'edit with lock taken' '
+	lock_in_another_client &&
+	test_when_finished cleanup_git &&
+	test_when_finished "cd \"$cli\" && p4 sync -f file1" &&
+	git p4 clone --dest="$git" //depot &&
+	(
+		cd "$git" &&
+		echo line3 >>file1 &&
+		git add file1 &&
+		git commit -m "line3 in file1" &&
+		git config git-p4.skipSubmitEdit true &&
+		git p4 submit --verbose
+	)
+'
+
+test_expect_failure 'delete with lock taken' '
+	lock_in_another_client &&
+	test_when_finished cleanup_git &&
+	test_when_finished "cd \"$cli\" && p4 sync -f file1" &&
+	git p4 clone --dest="$git" //depot &&
+	(
+		cd "$git" &&
+		git rm file1 &&
+		git commit -m "delete file1" &&
+		git config git-p4.skipSubmitEdit true &&
+		git p4 submit --verbose
+	)
+'
+
+test_expect_failure 'chmod with lock taken' '
+	lock_in_another_client &&
+	test_when_finished cleanup_git &&
+	test_when_finished "cd \"$cli\" && p4 sync -f file1" &&
+	git p4 clone --dest="$git" //depot &&
+	(
+		cd "$git" &&
+		chmod +x file1 &&
+		git add file1 &&
+		git commit -m "chmod +x file1" &&
+		git config git-p4.skipSubmitEdit true &&
+		git p4 submit --verbose
+	)
+'
+
+test_expect_failure 'copy with lock taken' '
+	lock_in_another_client &&
+	test_when_finished cleanup_git &&
+	test_when_finished "cd \"$cli\" && p4 revert file2 && rm -f file2" &&
+	git p4 clone --dest="$git" //depot &&
+	(
+		cd "$git" &&
+		cp file1 file2 &&
+		git add file2 &&
+		git commit -m "cp file1 to file2" &&
+		git config git-p4.skipSubmitEdit true &&
+		git config git-p4.detectCopies true &&
+		git p4 submit --verbose
+	)
+'
+
+test_expect_failure 'move with lock taken' '
+	lock_in_another_client &&
+	test_when_finished cleanup_git &&
+	test_when_finished "cd \"$cli\" && p4 sync file1 && rm -f file2" &&
+	git p4 clone --dest="$git" //depot &&
+	(
+		cd "$git" &&
+		git mv file1 file2 &&
+		git commit -m "mv file1 to file2" &&
+		git config git-p4.skipSubmitEdit true &&
+		git config git-p4.detectRenames true &&
+		git p4 submit --verbose
+	)
+'
+
+test_expect_success 'kill p4d' '
+	kill_p4d
+'
+
+test_done
-- 
1.8.5.2.320.g99957e5
