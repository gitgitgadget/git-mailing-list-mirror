From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 2/5] git p4 test: add broken --use-client-spec --detect-branches tests
Date: Sat, 11 Aug 2012 12:55:01 -0400
Message-ID: <1344704104-17727-2-git-send-email-pw@padd.com>
References: <20120811165143.GA2004@padd.com>
Cc: Matthew Korich <matthew@korich.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 11 18:55:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T0EyK-00013A-18
	for gcvg-git-2@plane.gmane.org; Sat, 11 Aug 2012 18:55:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753308Ab2HKQz1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Aug 2012 12:55:27 -0400
Received: from honk.padd.com ([74.3.171.149]:50671 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752670Ab2HKQz1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Aug 2012 12:55:27 -0400
Received: from arf.padd.com (unknown [50.55.149.165])
	by honk.padd.com (Postfix) with ESMTPSA id 61147D27;
	Sat, 11 Aug 2012 09:55:26 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 2320A5A90C; Sat, 11 Aug 2012 12:55:24 -0400 (EDT)
X-Mailer: git-send-email 1.7.11.2.329.ga84ed21
In-Reply-To: <20120811165143.GA2004@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203291>


Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 t/t9801-git-p4-branch.sh | 77 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/t/t9801-git-p4-branch.sh b/t/t9801-git-p4-branch.sh
index 99fe16b..ca3a7f9 100755
--- a/t/t9801-git-p4-branch.sh
+++ b/t/t9801-git-p4-branch.sh
@@ -410,6 +410,83 @@ test_expect_failure 'git p4 clone file subset branch' '
 		test_path_is_missing file3
 	)
 '
+
+# From a report in http://stackoverflow.com/questions/11893688
+# where --use-client-spec caused branch prefixes not to be removed;
+# every file in git appeared into a subdirectory of the branch name.
+test_expect_success 'use-client-spec detect-branches setup' '
+	rm -rf "$cli" &&
+	mkdir "$cli" &&
+	(
+		cd "$cli" &&
+		client_view "//depot/usecs/... //client/..." &&
+		mkdir b1 &&
+		echo b1/b1-file1 >b1/b1-file1 &&
+		p4 add b1/b1-file1 &&
+		p4 submit -d "b1/b1-file1" &&
+
+		p4 integrate //depot/usecs/b1/... //depot/usecs/b2/... &&
+		p4 submit -d "b1 -> b2" &&
+		p4 branch -i <<-EOF &&
+		Branch: b2
+		View: //depot/usecs/b1/... //depot/usecs/b2/...
+		EOF
+
+		echo b2/b2-file2 >b2/b2-file2 &&
+		p4 add b2/b2-file2 &&
+		p4 submit -d "b2/b2-file2"
+	)
+'
+
+test_expect_failure 'use-client-spec detect-branches files in top-level' '
+	test_when_finished cleanup_git &&
+	test_create_repo "$git" &&
+	(
+		cd "$git" &&
+		git p4 sync --detect-branches --use-client-spec //depot/usecs@all &&
+		git checkout -b master p4/usecs/b1 &&
+		test_path_is_file b1-file1 &&
+		test_path_is_missing b2-file2 &&
+		test_path_is_missing b1 &&
+		test_path_is_missing b2 &&
+
+		git checkout -b b2 p4/usecs/b2 &&
+		test_path_is_file b1-file1 &&
+		test_path_is_file b2-file2 &&
+		test_path_is_missing b1 &&
+		test_path_is_missing b2
+	)
+'
+
+test_expect_success 'use-client-spec detect-branches skips branches setup' '
+	(
+		cd "$cli" &&
+
+		p4 integrate //depot/usecs/b1/... //depot/usecs/b3/... &&
+		p4 submit -d "b1 -> b3" &&
+		p4 branch -i <<-EOF &&
+		Branch: b3
+		View: //depot/usecs/b1/... //depot/usecs/b3/...
+		EOF
+
+		echo b3/b3-file3 >b3/b3-file3 &&
+		p4 add b3/b3-file3 &&
+		p4 submit -d "b3/b3-file3"
+	)
+'
+
+test_expect_success 'use-client-spec detect-branches skips branches' '
+	client_view "//depot/usecs/... //client/..." \
+	            "-//depot/usecs/b3/... //client/b3/..." &&
+	test_when_finished cleanup_git &&
+	test_create_repo "$git" &&
+	(
+		cd "$git" &&
+		git p4 sync --detect-branches --use-client-spec //depot/usecs@all &&
+		test_must_fail git rev-parse refs/remotes/p4/usecs/b3
+	)
+'
+
 test_expect_success 'kill p4d' '
 	kill_p4d
 '
-- 
1.7.12.rc2.24.gc304662
