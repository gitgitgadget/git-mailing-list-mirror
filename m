From: David D Kilzer <ddkilzer@kilzer.net>
Subject: [PATCH 1/3] git-svn log: fix ascending revision ranges
Date: Sat, 10 Nov 2007 22:10:33 -0800
Message-ID: <1194761435-7286-2-git-send-email-ddkilzer@kilzer.net>
References: <1194761435-7286-1-git-send-email-ddkilzer@kilzer.net>
Cc: gitster@pobox.com, David D Kilzer <ddkilzer@kilzer.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 11 07:11:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ir62K-0008Gd-Mv
	for gcvg-git-2@gmane.org; Sun, 11 Nov 2007 07:11:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752737AbXKKGKj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2007 01:10:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752739AbXKKGKi
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Nov 2007 01:10:38 -0500
Received: from mail-out4.apple.com ([17.254.13.23]:59599 "EHLO
	mail-out4.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752627AbXKKGKd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2007 01:10:33 -0500
Received: from relay13.apple.com (relay13.apple.com [17.128.113.29])
	by mail-out4.apple.com (Postfix) with ESMTP id 284B818DDD84;
	Sat, 10 Nov 2007 22:10:33 -0800 (PST)
Received: from relay13.apple.com (unknown [127.0.0.1])
	by relay13.apple.com (Symantec Mail Security) with ESMTP id 0953E2804F;
	Sat, 10 Nov 2007 22:10:33 -0800 (PST)
X-AuditID: 1180711d-a12bfbb0000008bf-32-47369cd89986
Received: from localhost.localdomain (unknown [17.151.89.105])
	by relay13.apple.com (Apple SCV relay) with ESMTP id C935E28052;
	Sat, 10 Nov 2007 22:10:32 -0800 (PST)
X-Mailer: git-send-email 1.5.3.4
In-Reply-To: <1194761435-7286-1-git-send-email-ddkilzer@kilzer.net>
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64411>

Fixed typo in Git::SVN::Log::git_svn_log_cmd().  Previously a command like
"git-svn log -r1:4" would only show a commit log separator.

Added tests for ascending and descending revision ranges.

Signed-off-by: David D Kilzer <ddkilzer@kilzer.net>
---
 git-svn.perl           |    2 +-
 t/t9116-git-svn-log.sh |   14 ++++++++++++++
 2 files changed, 15 insertions(+), 1 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index ec25ea4..3c5a87d 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -3591,7 +3591,7 @@ sub git_svn_log_cmd {
 		$c_max = $gs->rev_db_get($r_max);
 		$c_min = $gs->rev_db_get($r_min);
 		if (defined $c_min && defined $c_max) {
-			if ($r_max > $r_max) {
+			if ($r_max > $r_min) {
 				push @cmd, "$c_min..$c_max";
 			} else {
 				push @cmd, "$c_max..$c_min";
diff --git a/t/t9116-git-svn-log.sh b/t/t9116-git-svn-log.sh
index 0d4e6b3..618d7e9 100755
--- a/t/t9116-git-svn-log.sh
+++ b/t/t9116-git-svn-log.sh
@@ -45,4 +45,18 @@ test_expect_success 'run log against a from trunk' "
 	git svn log -r3 a | grep ^r3
 	"
 
+printf 'r2 \nr4 \n' > expected-range-r2-r4
+
+test_expect_success 'test ascending revision range' "
+	git reset --hard trunk &&
+	git svn log -r 1:4 | grep '^r[0-9]' | cut -d'|' -f1 | diff -u expected-range-r2-r4 -
+	"
+
+printf 'r4 \nr2 \n' > expected-range-r4-r2
+
+test_expect_success 'test descending revision range' "
+	git reset --hard trunk &&
+	git svn log -r 4:1 | grep '^r[0-9]' | cut -d'|' -f1 | diff -u expected-range-r4-r2 -
+	"
+
 test_done
-- 
1.5.3.4
