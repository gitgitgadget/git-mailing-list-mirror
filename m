From: David D Kilzer <ddkilzer@kilzer.net>
Subject: [PATCH 3/3] git-svn log: handle unreachable revisions like "svn log"
Date: Sat, 10 Nov 2007 22:10:35 -0800
Message-ID: <1194761435-7286-4-git-send-email-ddkilzer@kilzer.net>
References: <1194761435-7286-1-git-send-email-ddkilzer@kilzer.net>
 <1194761435-7286-2-git-send-email-ddkilzer@kilzer.net>
 <1194761435-7286-3-git-send-email-ddkilzer@kilzer.net>
Cc: gitster@pobox.com, David D Kilzer <ddkilzer@kilzer.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 11 07:11:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ir62L-0008Gd-CV
	for gcvg-git-2@gmane.org; Sun, 11 Nov 2007 07:11:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752764AbXKKGKl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2007 01:10:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752739AbXKKGKl
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Nov 2007 01:10:41 -0500
Received: from mail-out3.apple.com ([17.254.13.22]:61319 "EHLO
	mail-out3.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752701AbXKKGKe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2007 01:10:34 -0500
Received: from relay13.apple.com (relay13.apple.com [17.128.113.29])
	by mail-out3.apple.com (Postfix) with ESMTP id B098E1836191;
	Sat, 10 Nov 2007 22:10:33 -0800 (PST)
Received: from relay13.apple.com (unknown [127.0.0.1])
	by relay13.apple.com (Symantec Mail Security) with ESMTP id 9B5F928057;
	Sat, 10 Nov 2007 22:10:33 -0800 (PST)
X-AuditID: 1180711d-9e2b9bb0000008bf-35-47369cd9bf71
Received: from localhost.localdomain (unknown [17.151.89.105])
	by relay13.apple.com (Apple SCV relay) with ESMTP id 4474D2804F;
	Sat, 10 Nov 2007 22:10:33 -0800 (PST)
X-Mailer: git-send-email 1.5.3.4
In-Reply-To: <1194761435-7286-3-git-send-email-ddkilzer@kilzer.net>
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64410>

When unreachable revisions are given to "svn log", it displays all commit
logs in the given range that exist in the current tree.  (If no commit
logs are found in the current tree, it simply prints a single commit log
separator.)  This patch makes "git-svn log" behave the same way.

Ten tests added to t/t9116-git-svn-log.sh.

Signed-off-by: David D Kilzer <ddkilzer@kilzer.net>
---
 git-svn.perl           |   58 ++++++++++++++++++++++++++++--------------
 t/t9116-git-svn-log.sh |   66 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 105 insertions(+), 19 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 39585d8..c584715 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -2257,9 +2257,10 @@ sub rev_db_get {
 }
 
 sub find_rev_before {
-	my ($self, $rev, $eq_ok) = @_;
+	my ($self, $rev, $eq_ok, $min_rev) = @_;
 	--$rev unless $eq_ok;
-	while ($rev > 0) {
+	$min_rev ||= 1;
+	while ($rev >= $min_rev) {
 		if (my $c = $self->rev_db_get($rev)) {
 			return ($rev, $c);
 		}
@@ -2268,6 +2269,19 @@ sub find_rev_before {
 	return (undef, undef);
 }
 
+sub find_rev_after {
+	my ($self, $rev, $eq_ok, $max_rev) = @_;
+	++$rev unless $eq_ok;
+	$max_rev ||= $self->rev_db_max();
+	while ($rev <= $max_rev) {
+		if (my $c = $self->rev_db_get($rev)) {
+			return ($rev, $c);
+		}
+		++$rev;
+	}
+	return (undef, undef);
+}
+
 sub _new {
 	my ($class, $repo_id, $ref_id, $path) = @_;
 	unless (defined $repo_id && length $repo_id) {
@@ -3587,19 +3601,19 @@ sub git_svn_log_cmd {
 			push @cmd, $c;
 		}
 	} elsif (defined $r_max) {
-		my ($c_min, $c_max);
-		$c_max = $gs->rev_db_get($r_max);
-		$c_min = $gs->rev_db_get($r_min);
-		if (defined $c_min && defined $c_max) {
-			if ($r_max > $r_min) {
-				push @cmd, "--boundary", "$c_min..$c_max";
-			} else {
-				push @cmd, "--boundary", "$c_max..$c_min";
-			}
-		} elsif ($r_max > $r_min) {
-			push @cmd, $c_max;
+		if ($r_max < $r_min) {
+			($r_min, $r_max) = ($r_max, $r_min);
+		}
+		my (undef, $c_max) = $gs->find_rev_before($r_max, 1, $r_min);
+		my (undef, $c_min) = $gs->find_rev_after($r_min, 1, $r_max);
+		# If there are no commits in the range, both $c_max and $c_min
+		# will be undefined.  If there is at least 1 commit in the
+		# range, both will be defined.
+		return () if !defined $c_min;
+		if ($c_min eq $c_max) {
+			push @cmd, '--max-count=1', $c_min;
 		} else {
-			push @cmd, $c_min;
+			push @cmd, '--boundary', "$c_min..$c_max";
 		}
 	}
 	return (@cmd, @files);
@@ -3705,9 +3719,13 @@ sub show_commit_changed_paths {
 	print "Changed paths:\n", @{$c->{changed}};
 }
 
+sub commit_log_separator {
+    return ('-' x 72) . "\n";
+}
+
 sub show_commit_normal {
 	my ($c) = @_;
-	print '-' x72, "\nr$c->{r} | ";
+	print commit_log_separator(), "r$c->{r} | ";
 	print "$c->{c} | " if $show_commit;
 	print "$c->{a} | ", strftime("%Y-%m-%d %H:%M:%S %z (%a, %d %b %Y)",
 				 localtime($c->{t_utc})), ' | ';
@@ -3768,6 +3786,10 @@ sub cmd_show_log {
 
 	config_pager();
 	@args = git_svn_log_cmd($r_min, $r_max, @args);
+	if (!@args) {
+		print commit_log_separator() unless $incremental || $oneline;
+		return;
+	}
 	my $log = command_output_pipe(@args);
 	run_pager();
 	my (@k, $c, $d, $stat);
@@ -3816,14 +3838,12 @@ sub cmd_show_log {
 		process_commit($c, $r_min, $r_max, \@k);
 	}
 	if (@k) {
-		my $swap = $r_max;
-		$r_max = $r_min;
-		$r_min = $swap;
+		($r_min, $r_max) = ($r_max, $r_min);
 		process_commit($_, $r_min, $r_max) foreach reverse @k;
 	}
 out:
 	close $log;
-	print '-' x72,"\n" unless $incremental || $oneline;
+	print commit_log_separator() unless $incremental || $oneline;
 }
 
 package Git::SVN::Migration;
diff --git a/t/t9116-git-svn-log.sh b/t/t9116-git-svn-log.sh
index 5000892..56dd8fe 100755
--- a/t/t9116-git-svn-log.sh
+++ b/t/t9116-git-svn-log.sh
@@ -30,6 +30,12 @@ test_expect_success 'setup repository and import' "
 	git reset --hard trunk &&
 	echo aye >> README &&
 	git commit -a -m aye &&
+	git svn dcommit &&
+	git reset --hard b &&
+	echo spy >> README &&
+	git commit -a -m spy &&
+	echo try >> README &&
+	git commit -a -m try &&
 	git svn dcommit
 	"
 
@@ -59,4 +65,64 @@ test_expect_success 'test descending revision range' "
 	git svn log -r 4:1 | grep '^r[0-9]' | cut -d'|' -f1 | diff -u expected-range-r4-r2-r1 -
 	"
 
+printf 'r1 \nr2 \n' > expected-range-r1-r2
+
+test_expect_success 'test ascending revision range with unreachable revision' "
+	git reset --hard trunk &&
+	git svn log -r 1:3 | grep '^r[0-9]' | cut -d'|' -f1 | diff -u expected-range-r1-r2 -
+	"
+
+printf 'r2 \nr1 \n' > expected-range-r2-r1
+
+test_expect_success 'test descending revision range with unreachable revision' "
+	git reset --hard trunk &&
+	git svn log -r 3:1 | grep '^r[0-9]' | cut -d'|' -f1 | diff -u expected-range-r2-r1 -
+	"
+
+printf 'r2 \n' > expected-range-r2
+
+test_expect_success 'test ascending revision range with unreachable upper boundary revision and 1 commit' "
+	git reset --hard trunk &&
+	git svn log -r 2:3 | grep '^r[0-9]' | cut -d'|' -f1 | diff -u expected-range-r2 -
+	"
+
+test_expect_success 'test descending revision range with unreachable upper boundary revision and 1 commit' "
+	git reset --hard trunk &&
+	git svn log -r 3:2 | grep '^r[0-9]' | cut -d'|' -f1 | diff -u expected-range-r2 -
+	"
+
+printf 'r4 \n' > expected-range-r4
+
+test_expect_success 'test ascending revision range with unreachable lower boundary revision and 1 commit' "
+	git reset --hard trunk &&
+	git svn log -r 3:4 | grep '^r[0-9]' | cut -d'|' -f1 | diff -u expected-range-r4 -
+	"
+
+test_expect_success 'test descending revision range with unreachable lower boundary revision and 1 commit' "
+	git reset --hard trunk &&
+	git svn log -r 4:3 | grep '^r[0-9]' | cut -d'|' -f1 | diff -u expected-range-r4 -
+	"
+
+echo ------------------------------------------------------------------------ > expected-separator
+
+test_expect_success 'test ascending revision range with unreachable boundary revisions and no commits' "
+	git reset --hard trunk &&
+	git svn log -r 5:6 | diff -u expected-separator -
+	"
+
+test_expect_success 'test descending revision range with unreachable boundary revisions and no commits' "
+	git reset --hard trunk &&
+	git svn log -r 6:5 | diff -u expected-separator -
+	"
+
+test_expect_success 'test ascending revision range with unreachable boundary revisions and 1 commit' "
+	git reset --hard trunk &&
+	git svn log -r 3:5 | grep '^r[0-9]' | cut -d'|' -f1 | diff -u expected-range-r4 -
+	"
+
+test_expect_success 'test descending revision range with unreachable boundary revisions and 1 commit' "
+	git reset --hard trunk &&
+	git svn log -r 5:3 | grep '^r[0-9]' | cut -d'|' -f1 | diff -u expected-range-r4 -
+	"
+
 test_done
-- 
1.5.3.4
