From: David D Kilzer <ddkilzer@kilzer.net>
Subject: [PATCH 3/3 v2] git-svn log: handle unreachable revisions like "svn log"
Date: Sun, 11 Nov 2007 22:56:52 -0800
Message-ID: <1194850612-6907-1-git-send-email-ddkilzer@kilzer.net>
References: <1194761435-7286-4-git-send-email-ddkilzer@kilzer.net>
Cc: gitster@pobox.com, David D Kilzer <ddkilzer@kilzer.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 12 07:57:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrTEJ-00067p-Un
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 07:57:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752358AbXKLG4w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 01:56:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752056AbXKLG4w
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 01:56:52 -0500
Received: from mail-out4.apple.com ([17.254.13.23]:57678 "EHLO
	mail-out4.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751285AbXKLG4v (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 01:56:51 -0500
Received: from relay14.apple.com (relay14.apple.com [17.128.113.52])
	by mail-out4.apple.com (Postfix) with ESMTP id 04E7D18F6468;
	Sun, 11 Nov 2007 22:56:51 -0800 (PST)
Received: from relay14.apple.com (unknown [127.0.0.1])
	by relay14.apple.com (Symantec Mail Security) with ESMTP id D921E28057;
	Sun, 11 Nov 2007 22:56:50 -0800 (PST)
X-AuditID: 11807134-9fbb9bb0000008bf-a2-4737f9329c52
Received: from localhost.localdomain (unknown [17.151.108.44])
	by relay14.apple.com (Apple SCV relay) with ESMTP id D62B628056;
	Sun, 11 Nov 2007 22:56:49 -0800 (PST)
X-Mailer: git-send-email 1.5.3.4
In-Reply-To: <1194761435-7286-4-git-send-email-ddkilzer@kilzer.net>
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64565>

When unreachable revisions are given to "svn log", it displays all commit
logs in the given range that exist in the current tree.  (If no commit
logs are found in the current tree, it simply prints a single commit log
separator.)  This patch makes "git-svn log" behave the same way.

Ten tests added to t/t9116-git-svn-log.sh.

Signed-off-by: David D Kilzer <ddkilzer@kilzer.net>
---

No changes were needed to parts 1 and 2 of this series, so I am not
reposting them.

Updated this patch based on feedback from Benoit Sigoure and Eric Wong:

- Commented find_rev_before() and find_rev_after().
- Changed commit_log_separator() into a constant.
- Made return statement safer by adding another check in git_svn_log_cmd().
- Changed echo statement to printf in t/t9116-git-svn-log.sh.

All tests pass on maint branch.

 git-svn.perl           |   63 ++++++++++++++++++++++++++++++++--------------
 t/t9116-git-svn-log.sh |   66 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 110 insertions(+), 19 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 39585d8..f017f94 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -2256,10 +2256,15 @@ sub rev_db_get {
 	$ret;
 }
 
+# Finds the first svn revision that exists on (if $eq_ok is true) or
+# before $rev for the current branch.  It will not search any lower
+# than $min_rev.  Returns the git commit hash and svn revision number
+# if found, else (undef, undef).
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
@@ -2268,6 +2273,23 @@ sub find_rev_before {
 	return (undef, undef);
 }
 
+# Finds the first svn revision that exists on (if $eq_ok is true) or
+# after $rev for the current branch.  It will not search any higher
+# than $max_rev.  Returns the git commit hash and svn revision number
+# if found, else (undef, undef).
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
@@ -3494,6 +3516,7 @@ package Git::SVN::Log;
 use strict;
 use warnings;
 use POSIX qw/strftime/;
+use constant commit_log_separator => ('-' x 72) . "\n";
 use vars qw/$TZ $limit $color $pager $non_recursive $verbose $oneline
             %rusers $show_commit $incremental/;
 my $l_fmt;
@@ -3587,19 +3610,19 @@ sub git_svn_log_cmd {
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
+		return () if !defined $c_min || !defined $c_max;
+		if ($c_min eq $c_max) {
+			push @cmd, '--max-count=1', $c_min;
 		} else {
-			push @cmd, $c_min;
+			push @cmd, '--boundary', "$c_min..$c_max";
 		}
 	}
 	return (@cmd, @files);
@@ -3707,7 +3730,7 @@ sub show_commit_changed_paths {
 
 sub show_commit_normal {
 	my ($c) = @_;
-	print '-' x72, "\nr$c->{r} | ";
+	print commit_log_separator, "r$c->{r} | ";
 	print "$c->{c} | " if $show_commit;
 	print "$c->{a} | ", strftime("%Y-%m-%d %H:%M:%S %z (%a, %d %b %Y)",
 				 localtime($c->{t_utc})), ' | ';
@@ -3768,6 +3791,10 @@ sub cmd_show_log {
 
 	config_pager();
 	@args = git_svn_log_cmd($r_min, $r_max, @args);
+	if (!@args) {
+		print commit_log_separator unless $incremental || $oneline;
+		return;
+	}
 	my $log = command_output_pipe(@args);
 	run_pager();
 	my (@k, $c, $d, $stat);
@@ -3816,14 +3843,12 @@ sub cmd_show_log {
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
+	print commit_log_separator unless $incremental || $oneline;
 }
 
 package Git::SVN::Migration;
diff --git a/t/t9116-git-svn-log.sh b/t/t9116-git-svn-log.sh
index 5000892..902ed41 100755
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
+printf -- '------------------------------------------------------------------------\n' > expected-separator
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
