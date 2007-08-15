From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] git-svn: fix log with single revision against a non-HEAD branch
Date: Wed, 15 Aug 2007 09:55:18 -0700
Message-ID: <1187196918619-git-send-email-normalperson@yhbt.net>
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 15 18:56:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILMA9-00051v-3W
	for gcvg-git@gmane.org; Wed, 15 Aug 2007 18:56:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760355AbXHOQzv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Aug 2007 12:55:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760934AbXHOQzv
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Aug 2007 12:55:51 -0400
Received: from hand.yhbt.net ([66.150.188.102]:32867 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759254AbXHOQzt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Aug 2007 12:55:49 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 39AED2DC08D;
	Wed, 15 Aug 2007 09:55:47 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Wed, 15 Aug 2007 09:55:18 -0700
X-Mailer: git-send-email 1.5.3.rc5.1.gb318
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55924>

Running git-svn log <ref> -r<rev> against a <ref> other than the
current HEAD did not work if the <rev> was exclusive to the
other branch.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 git-svn.perl           |   24 +++++++++++++++---------
 t/t9116-git-svn-log.sh |   48 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 63 insertions(+), 9 deletions(-)
 create mode 100755 t/t9116-git-svn-log.sh

diff --git a/git-svn.perl b/git-svn.perl
index ee7ef69..d162114 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -3501,11 +3501,17 @@ sub log_use_color {
 sub git_svn_log_cmd {
 	my ($r_min, $r_max, @args) = @_;
 	my $head = 'HEAD';
+	my (@files, @log_opts);
 	foreach my $x (@args) {
-		last if $x eq '--';
-		next unless ::verify_ref("$x^0");
-		$head = $x;
-		last;
+		if ($x eq '--' || @files) {
+			push @files, $x;
+		} else {
+			if (::verify_ref("$x^0")) {
+				$head = $x;
+			} else {
+				push @log_opts, $x;
+			}
+		}
 	}
 
 	my ($url, $rev, $uuid, $gs) = ::working_head_info($head);
@@ -3515,13 +3521,13 @@ sub git_svn_log_cmd {
 	push @cmd, '-r' unless $non_recursive;
 	push @cmd, qw/--raw --name-status/ if $verbose;
 	push @cmd, '--color' if log_use_color();
-	return @cmd unless defined $r_max;
-	if ($r_max == $r_min) {
+	push @cmd, @log_opts;
+	if (defined $r_max && $r_max == $r_min) {
 		push @cmd, '--max-count=1';
 		if (my $c = $gs->rev_db_get($r_max)) {
 			push @cmd, $c;
 		}
-	} else {
+	} elsif (defined $r_max) {
 		my ($c_min, $c_max);
 		$c_max = $gs->rev_db_get($r_max);
 		$c_min = $gs->rev_db_get($r_min);
@@ -3537,7 +3543,7 @@ sub git_svn_log_cmd {
 			push @cmd, $c_min;
 		}
 	}
-	return @cmd;
+	return (@cmd, @files);
 }
 
 # adapted from pager.c
@@ -3702,7 +3708,7 @@ sub cmd_show_log {
 	}
 
 	config_pager();
-	@args = (git_svn_log_cmd($r_min, $r_max, @args), @args);
+	@args = git_svn_log_cmd($r_min, $r_max, @args);
 	my $log = command_output_pipe(@args);
 	run_pager();
 	my (@k, $c, $d, $stat);
diff --git a/t/t9116-git-svn-log.sh b/t/t9116-git-svn-log.sh
new file mode 100755
index 0000000..0d4e6b3
--- /dev/null
+++ b/t/t9116-git-svn-log.sh
@@ -0,0 +1,48 @@
+#!/bin/sh
+#
+# Copyright (c) 2007 Eric Wong
+#
+
+test_description='git-svn log tests'
+. ./lib-git-svn.sh
+
+test_expect_success 'setup repository and import' "
+	mkdir import &&
+	cd import &&
+		for i in trunk branches/a branches/b \
+		         tags/0.1 tags/0.2 tags/0.3; do
+			mkdir -p \$i && \
+			echo hello >> \$i/README || exit 1
+		done && \
+		svn import -m test . $svnrepo
+		cd .. &&
+	git-svn init $svnrepo -T trunk -b branches -t tags &&
+	git-svn fetch &&
+	git reset --hard trunk &&
+	echo bye >> README &&
+	git commit -a -m bye &&
+	git svn dcommit &&
+	git reset --hard a &&
+	echo why >> FEEDME &&
+	git update-index --add FEEDME &&
+	git commit -m feedme &&
+	git svn dcommit &&
+	git reset --hard trunk &&
+	echo aye >> README &&
+	git commit -a -m aye &&
+	git svn dcommit
+	"
+
+test_expect_success 'run log' "
+	git reset --hard a &&
+	git svn log -r2 trunk | grep ^r2 &&
+	git svn log -r4 trunk | grep ^r4 &&
+	git svn log -r3 | grep ^r3
+	"
+
+test_expect_success 'run log against a from trunk' "
+	git reset --hard trunk &&
+	git svn log -r3 a | grep ^r3
+	"
+
+test_done
-- 
1.5.3.rc5.1.gb318
