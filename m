From: David D Kilzer <ddkilzer@kilzer.net>
Subject: [PATCH 2/3] git-svn log: include commit log for the smallest revision in a range
Date: Sat, 10 Nov 2007 22:10:34 -0800
Message-ID: <1194761435-7286-3-git-send-email-ddkilzer@kilzer.net>
References: <1194761435-7286-1-git-send-email-ddkilzer@kilzer.net>
 <1194761435-7286-2-git-send-email-ddkilzer@kilzer.net>
Cc: gitster@pobox.com, David D Kilzer <ddkilzer@kilzer.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 11 07:11:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ir62K-0008Gd-2K
	for gcvg-git-2@gmane.org; Sun, 11 Nov 2007 07:11:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752754AbXKKGKi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2007 01:10:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752737AbXKKGKg
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Nov 2007 01:10:36 -0500
Received: from mail-out3.apple.com ([17.254.13.22]:61316 "EHLO
	mail-out3.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752658AbXKKGKd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2007 01:10:33 -0500
Received: from relay13.apple.com (relay13.apple.com [17.128.113.29])
	by mail-out3.apple.com (Postfix) with ESMTP id 5F7D71836190;
	Sat, 10 Nov 2007 22:10:33 -0800 (PST)
Received: from relay13.apple.com (unknown [127.0.0.1])
	by relay13.apple.com (Symantec Mail Security) with ESMTP id 47E7128052;
	Sat, 10 Nov 2007 22:10:33 -0800 (PST)
X-AuditID: 1180711d-9d2b7bb0000008bf-34-47369cd970b4
Received: from localhost.localdomain (unknown [17.151.89.105])
	by relay13.apple.com (Apple SCV relay) with ESMTP id 07F3428057;
	Sat, 10 Nov 2007 22:10:33 -0800 (PST)
X-Mailer: git-send-email 1.5.3.4
In-Reply-To: <1194761435-7286-2-git-send-email-ddkilzer@kilzer.net>
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64409>

The "svn log -rM:N" command shows commit logs inclusive in the range [M,N].
Previously "git-svn log" always excluded the commit log for the smallest
revision in a range, whether the range was ascending or descending.  With
this patch, the smallest revision in a range is always shown.

Updated tests for ascending and descending revision ranges.

Signed-off-by: David D Kilzer <ddkilzer@kilzer.net>
---
 git-svn.perl           |    6 +++---
 t/t9116-git-svn-log.sh |    8 ++++----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 3c5a87d..39585d8 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -3592,9 +3592,9 @@ sub git_svn_log_cmd {
 		$c_min = $gs->rev_db_get($r_min);
 		if (defined $c_min && defined $c_max) {
 			if ($r_max > $r_min) {
-				push @cmd, "$c_min..$c_max";
+				push @cmd, "--boundary", "$c_min..$c_max";
 			} else {
-				push @cmd, "$c_max..$c_min";
+				push @cmd, "--boundary", "$c_max..$c_min";
 			}
 		} elsif ($r_max > $r_min) {
 			push @cmd, $c_max;
@@ -3773,7 +3773,7 @@ sub cmd_show_log {
 	my (@k, $c, $d, $stat);
 	my $esc_color = qr/(?:\033\[(?:(?:\d+;)*\d*)?m)*/;
 	while (<$log>) {
-		if (/^${esc_color}commit ($::sha1_short)/o) {
+		if (/^${esc_color}commit -?($::sha1_short)/o) {
 			my $cmt = $1;
 			if ($c && cmt_showable($c) && $c->{r} != $r_last) {
 				$r_last = $c->{r};
diff --git a/t/t9116-git-svn-log.sh b/t/t9116-git-svn-log.sh
index 618d7e9..5000892 100755
--- a/t/t9116-git-svn-log.sh
+++ b/t/t9116-git-svn-log.sh
@@ -45,18 +45,18 @@ test_expect_success 'run log against a from trunk' "
 	git svn log -r3 a | grep ^r3
 	"
 
-printf 'r2 \nr4 \n' > expected-range-r2-r4
+printf 'r1 \nr2 \nr4 \n' > expected-range-r1-r2-r4
 
 test_expect_success 'test ascending revision range' "
 	git reset --hard trunk &&
-	git svn log -r 1:4 | grep '^r[0-9]' | cut -d'|' -f1 | diff -u expected-range-r2-r4 -
+	git svn log -r 1:4 | grep '^r[0-9]' | cut -d'|' -f1 | diff -u expected-range-r1-r2-r4 -
 	"
 
-printf 'r4 \nr2 \n' > expected-range-r4-r2
+printf 'r4 \nr2 \nr1 \n' > expected-range-r4-r2-r1
 
 test_expect_success 'test descending revision range' "
 	git reset --hard trunk &&
-	git svn log -r 4:1 | grep '^r[0-9]' | cut -d'|' -f1 | diff -u expected-range-r4-r2 -
+	git svn log -r 4:1 | grep '^r[0-9]' | cut -d'|' -f1 | diff -u expected-range-r4-r2-r1 -
 	"
 
 test_done
-- 
1.5.3.4
