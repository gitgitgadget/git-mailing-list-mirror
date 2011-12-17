From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 07/11] git-p4: document and test --import-local
Date: Sat, 17 Dec 2011 13:52:18 -0500
Message-ID: <1324147942-21558-8-git-send-email-pw@padd.com>
References: <1324147942-21558-1-git-send-email-pw@padd.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 17 19:56:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RbzQo-0003Tg-SS
	for gcvg-git-2@lo.gmane.org; Sat, 17 Dec 2011 19:56:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752704Ab1LQS4X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Dec 2011 13:56:23 -0500
Received: from honk.padd.com ([74.3.171.149]:58917 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752685Ab1LQS4W (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Dec 2011 13:56:22 -0500
Received: from arf.padd.com (unknown [50.55.144.134])
	by honk.padd.com (Postfix) with ESMTPSA id F13401C89;
	Sat, 17 Dec 2011 10:56:15 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 73D47314AA; Sat, 17 Dec 2011 13:54:43 -0500 (EST)
X-Mailer: git-send-email 1.7.8.283.g3bcee.dirty
In-Reply-To: <1324147942-21558-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187396>

Explain that it is needed on future syncs to find p4 branches
in refs/heads.  Test this behavior.

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 Documentation/git-p4.txt |    4 +++-
 t/t9806-options.sh       |   22 ++++++++++++++++++++++
 2 files changed, 25 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
index a5d3d81..2885b82 100644
--- a/Documentation/git-p4.txt
+++ b/Documentation/git-p4.txt
@@ -211,7 +211,9 @@ git repository:
 	By default, p4 branches are stored in 'refs/remotes/p4/',
 	where they will be treated as remote-tracking branches by
 	linkgit:git-branch[1] and other commands.  This option instead
-	puts p4 branches in 'refs/heads/p4/'.
+	puts p4 branches in 'refs/heads/p4/'.  Note that future
+	sync operations must specify '--import-local' as well so that
+	they can find the p4 branches in refs/heads.
 
 --max-changes <n>::
 	Limit the number of imported changes to 'n'.  Useful to
diff --git a/t/t9806-options.sh b/t/t9806-options.sh
index 7a1dba6..6770326 100755
--- a/t/t9806-options.sh
+++ b/t/t9806-options.sh
@@ -61,6 +61,28 @@ test_expect_success 'clone --changesfile, @all' '
 	test_must_fail "$GITP4" clone --changesfile="$cf" --dest="$git" //depot@all
 '
 
+# imports both master and p4/master in refs/heads
+# requires --import-local on sync to find p4 refs/heads
+# does not update master on sync, just p4/master
+test_expect_success 'clone/sync --import-local' '
+	"$GITP4" clone --import-local --dest="$git" //depot@1,2 &&
+	test_when_finished cleanup_git &&
+	(
+		cd "$git" &&
+		git log --oneline refs/heads/master >lines &&
+		test_line_count = 2 lines &&
+		git log --oneline refs/heads/p4/master >lines &&
+		test_line_count = 2 lines &&
+		test_must_fail "$GITP4" sync &&
+
+		"$GITP4" sync --import-local &&
+		git log --oneline refs/heads/master >lines &&
+		test_line_count = 2 lines &&
+		git log --oneline refs/heads/p4/master >lines &&
+		test_line_count = 3 lines
+	)
+'
+
 test_expect_success 'kill p4d' '
 	kill_p4d
 '
-- 
1.7.8.258.g45cc3c
