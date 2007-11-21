From: "David D. Kilzer" <ddkilzer@kilzer.net>
Subject: [PATCH 2/3 v3] git-svn info: implement info command
Date: Wed, 21 Nov 2007 11:57:18 -0800
Message-ID: <1195675039-26746-3-git-send-email-ddkilzer@kilzer.net>
References: <1195675039-26746-1-git-send-email-ddkilzer@kilzer.net>
 <1195675039-26746-2-git-send-email-ddkilzer@kilzer.net>
Cc: git@vger.kernel.org, "David D. Kilzer" <ddkilzer@kilzer.net>
To: "Eric Wong" <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed Nov 21 20:58:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IuviR-00055F-DG
	for gcvg-git-2@gmane.org; Wed, 21 Nov 2007 20:58:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756173AbXKUT53 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Nov 2007 14:57:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754924AbXKUT52
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Nov 2007 14:57:28 -0500
Received: from mail-out4.apple.com ([17.254.13.23]:52156 "EHLO
	mail-out4.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752808AbXKUT5V (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Nov 2007 14:57:21 -0500
Received: from relay11.apple.com (relay11.apple.com [17.128.113.48])
	by mail-out4.apple.com (Postfix) with ESMTP id 1FAA219D7A22;
	Wed, 21 Nov 2007 11:57:21 -0800 (PST)
Received: from relay11.apple.com (unknown [127.0.0.1])
	by relay11.apple.com (Symantec Mail Security) with ESMTP id 0858C2808A;
	Wed, 21 Nov 2007 11:57:21 -0800 (PST)
X-AuditID: 11807130-a83adbb000006ed1-fc-47448da0ab1f
Received: from localhost.localdomain (unknown [17.151.86.253])
	by relay11.apple.com (Apple SCV relay) with ESMTP id 9E49C2804E;
	Wed, 21 Nov 2007 11:57:20 -0800 (PST)
X-Mailer: git-send-email 1.5.3.4
In-Reply-To: <1195675039-26746-2-git-send-email-ddkilzer@kilzer.net>
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65696>

Implement "git-svn info" for files and directories based on the
"svn info" command.  Note that the -r/--revision argument is not
supported yet.

Added 18 tests in t/t9119-git-svn-info.sh.

Signed-off-by: David D. Kilzer <ddkilzer@kilzer.net>
---
 Documentation/git-svn.txt |    5 +
 git-svn.perl              |  132 ++++++++++++++++++++++
 t/t9119-git-svn-info.sh   |  274 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 411 insertions(+), 0 deletions(-)
 create mode 100644 t/t9119-git-svn-info.sh

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 488e4b1..c3fc878 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -193,6 +193,11 @@ Any other arguments are passed directly to `git log'
 	repository (that has been init-ed with git-svn).
 	The -r<revision> option is required for this.
 
+'info'::
+	Shows information about a file or directory similar to what
+	`svn info' provides.  Does not currently support a -r/--revision
+	argument.
+
 --
 
 OPTIONS
diff --git a/git-svn.perl b/git-svn.perl
index 98c980f..be9290c 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -178,6 +178,10 @@ my %cmd = (
 			  'file|F=s' => \$_file,
 			  'revision|r=s' => \$_revision,
 			%cmt_opts } ],
+	'info' => [ \&cmd_info,
+		    "Show info about the latest SVN revision
+		     on the current branch",
+		    { } ],
 );
 
 my $cmd;
@@ -586,12 +590,18 @@ sub cmd_create_ignore {
 
 sub canonicalize_path {
 	my ($path) = @_;
+	my $dot_slash_added = 0;
+	if (substr($path, 0, 1) ne "/") {
+		$path = "./" . $path;
+		$dot_slash_added = 1;
+	}
 	# File::Spec->canonpath doesn't collapse x/../y into y (for a
 	# good reason), so let's do this manually.
 	$path =~ s#/+#/#g;
 	$path =~ s#/\.(?:/|$)#/#g;
 	$path =~ s#/[^/]+/\.\.##g;
 	$path =~ s#/$##g;
+	$path =~ s#^\./## if $dot_slash_added;
 	return $path;
 }
 
@@ -743,6 +753,104 @@ sub cmd_commit_diff {
 	}
 }
 
+sub cmd_info {
+	my $path = canonicalize_path(shift or ".");
+	unless (scalar(@_) == 0) {
+		die "Too many arguments specified\n";
+	}
+
+	my ($file_type, $diff_status) = find_file_type_and_diff_status($path);
+
+	if (!$file_type && !$diff_status) {
+		print STDERR "$path:  (Not a versioned resource)\n\n";
+		return;
+	}
+
+	my ($url, $rev, $uuid, $gs) = working_head_info('HEAD');
+	unless ($gs) {
+		die "Unable to determine upstream SVN information from ",
+		    "working tree history\n";
+	}
+	my $full_url = $url . ($path eq "." ? "" : "/$path");
+
+	my $result = "Path: $path\n";
+	$result .= "Name: " . basename($path) . "\n" if $file_type ne "dir";
+	$result .= "URL: " . $full_url . "\n";
+
+	my $repos_root = $gs->ra->{repos_root};
+	Git::SVN::remove_username($repos_root);
+	$result .= "Repository Root: $repos_root\n";
+	$result .= "Repository UUID: $uuid\n" unless $diff_status eq "A";
+	$result .= "Revision: " . ($diff_status eq "A" ? 0 : $rev) . "\n";
+
+	$result .= "Node Kind: " .
+		   ($file_type eq "dir" ? "directory" : "file") . "\n";
+
+	my $schedule = $diff_status eq "A"
+		       ? "add"
+		       : ($diff_status eq "D" ? "delete" : "normal");
+	$result .= "Schedule: $schedule\n";
+
+	if ($diff_status eq "A") {
+		print $result, "\n";
+		return;
+	}
+
+	my ($lc_author, $lc_rev, $lc_date_utc);
+	my @args = Git::SVN::Log::git_svn_log_cmd($rev, $rev, "--", $path);
+	my $log = command_output_pipe(@args);
+	my $esc_color = qr/(?:\033\[(?:(?:\d+;)*\d*)?m)*/;
+	while (<$log>) {
+		if (/^${esc_color}author (.+) <[^>]+> (\d+) ([\-\+]?\d+)$/o) {
+			$lc_author = $1;
+			$lc_date_utc = Git::SVN::Log::parse_git_date($2, $3);
+		} elsif (/^${esc_color}    (git-svn-id:.+)$/o) {
+			(undef, $lc_rev, undef) = ::extract_metadata($1);
+		}
+	}
+	close $log;
+
+	Git::SVN::Log::set_local_timezone();
+
+	$result .= "Last Changed Author: $lc_author\n";
+	$result .= "Last Changed Rev: $lc_rev\n";
+	$result .= "Last Changed Date: " .
+		   Git::SVN::Log::format_svn_date($lc_date_utc) . "\n";
+
+	if ($file_type ne "dir") {
+		my $text_last_updated_date =
+		    ($diff_status eq "D" ? $lc_date_utc : (stat $path)[9]);
+		$result .=
+		    "Text Last Updated: " .
+		    Git::SVN::Log::format_svn_date($text_last_updated_date) .
+		    "\n";
+		my $checksum;
+		if ($diff_status eq "D") {
+			my ($fh, $ctx) =
+			    command_output_pipe(qw(cat-file blob), "HEAD:$path");
+			if ($file_type eq "link") {
+				my $file_name = <$fh>;
+				$checksum = Git::SVN::Util::md5sum("link $file_name");
+			} else {
+				$checksum = Git::SVN::Util::md5sum($fh);
+			}
+			command_close_pipe($fh, $ctx);
+		} elsif ($file_type eq "link") {
+			my $file_name =
+			    command(qw(cat-file blob), "HEAD:$path");
+			$checksum =
+			    Git::SVN::Util::md5sum("link " . $file_name);
+		} else {
+			open FILE, "<", $path or die $!;
+			$checksum = Git::SVN::Util::md5sum(\*FILE);
+			close FILE or die $!;
+		}
+		$result .= "Checksum: " . $checksum . "\n";
+	}
+
+	print $result, "\n";
+}
+
 ########################### utility functions #########################
 
 sub rebase_cmd {
@@ -1050,6 +1158,30 @@ sub linearize_history {
 	(\@linear_refs, \%parents);
 }
 
+sub find_file_type_and_diff_status {
+	my ($path) = @_;
+
+	my $diff_output =
+	    command_oneline(qw(diff --cached --name-status --), $path) || "";
+	my $diff_status = (split(' ', $diff_output))[0] || "";
+
+	my $ls_tree = command_oneline(qw(ls-tree HEAD), $path) || "";
+
+	return (undef, undef) if !$diff_status && !$ls_tree;
+
+	if ($diff_status eq "A") {
+		return ("link", $diff_status) if -l $path;
+		return ("dir", $diff_status) if -d $path;
+		return ("file", $diff_status);
+	}
+
+	my $mode = (split(' ', $ls_tree))[0] || "";
+
+	return ("link", $diff_status) if $mode eq "120000";
+	return ("dir", $diff_status) if $mode eq "040000";
+	return ("file", $diff_status);
+}
+
 package Git::SVN::Util;
 use strict;
 use warnings;
diff --git a/t/t9119-git-svn-info.sh b/t/t9119-git-svn-info.sh
new file mode 100644
index 0000000..edd64d6
--- /dev/null
+++ b/t/t9119-git-svn-info.sh
@@ -0,0 +1,274 @@
+#!/bin/sh
+#
+# Copyright (c) 2007 David D. Kilzer
+
+test_description='git-svn info'
+
+. ./lib-git-svn.sh
+
+ptouch() {
+	perl -w -e '
+		use strict;
+		die "ptouch requires exactly 2 arguments" if @ARGV != 2;
+		die "$ARGV[0] does not exist" if ! -e $ARGV[0];
+		my @s = stat $ARGV[0];
+		utime $s[8], $s[9], $ARGV[1];
+	' "$1" "$2"
+}
+
+test_expect_success 'setup repository and import' "
+	mkdir info &&
+	cd info &&
+		echo one > file &&
+		ln -s file symlink-file &&
+		mkdir directory &&
+		touch directory/.placeholder &&
+		ln -s directory symlink-directory &&
+		svn import -m 'initial' . $svnrepo &&
+	cd .. &&
+	mkdir gitwc &&
+	cd gitwc &&
+		git-svn init $svnrepo &&
+		git-svn fetch &&
+	cd .. &&
+	svn co $svnrepo svnwc &&
+	ptouch svnwc/file gitwc/file &&
+	ptouch svnwc/directory gitwc/directory &&
+	ptouch svnwc/symlink-file gitwc/symlink-file &&
+	ptouch svnwc/symlink-directory gitwc/symlink-directory
+	"
+
+test_expect_success 'info' "
+	(cd svnwc; svn info) > expected.info &&
+	(cd gitwc; git-svn info) > actual.info &&
+	git-diff expected.info actual.info
+	"
+
+test_expect_success 'info .' "
+	(cd svnwc; svn info .) > expected.info-dot &&
+	(cd gitwc; git-svn info .) > actual.info-dot &&
+	git-diff expected.info-dot actual.info-dot
+	"
+
+test_expect_success 'info file' "
+	(cd svnwc; svn info file) > expected.info-file &&
+	(cd gitwc; git-svn info file) > actual.info-file &&
+	git-diff expected.info-file actual.info-file
+	"
+
+test_expect_success 'info directory' "
+	(cd svnwc; svn info directory) > expected.info-directory &&
+	(cd gitwc; git-svn info directory) > actual.info-directory &&
+	git-diff expected.info-directory actual.info-directory
+	"
+
+test_expect_success 'info symlink-file' "
+	(cd svnwc; svn info symlink-file) > expected.info-symlink-file &&
+	(cd gitwc; git-svn info symlink-file) > actual.info-symlink-file &&
+	git-diff expected.info-symlink-file actual.info-symlink-file
+	"
+
+test_expect_success 'info symlink-directory' "
+	(cd svnwc; svn info symlink-directory) \
+		> expected.info-symlink-directory &&
+	(cd gitwc; git-svn info symlink-directory) \
+		> actual.info-symlink-directory &&
+	git-diff expected.info-symlink-directory actual.info-symlink-directory
+	"
+
+test_expect_success 'info added-file' "
+	echo two > gitwc/added-file &&
+	cd gitwc &&
+		git add added-file &&
+	cd .. &&
+	cp gitwc/added-file svnwc/added-file &&
+	ptouch gitwc/added-file svnwc/added-file &&
+	cd svnwc &&
+		svn add added-file > /dev/null &&
+	cd .. &&
+	(cd svnwc; svn info added-file) > expected.info-added-file &&
+	(cd gitwc; git-svn info added-file) > actual.info-added-file &&
+	git-diff expected.info-added-file actual.info-added-file
+	"
+
+test_expect_success 'info added-directory' "
+	mkdir gitwc/added-directory svnwc/added-directory &&
+	ptouch gitwc/added-directory svnwc/added-directory &&
+	touch gitwc/added-directory/.placeholder &&
+	cd svnwc &&
+		svn add added-directory > /dev/null &&
+	cd .. &&
+	cd gitwc &&
+		git add added-directory &&
+	cd .. &&
+	(cd svnwc; svn info added-directory) \
+		> expected.info-added-directory &&
+	(cd gitwc; git-svn info added-directory) \
+		> actual.info-added-directory &&
+	git-diff expected.info-added-directory actual.info-added-directory
+	"
+
+test_expect_success 'info added-symlink-file' "
+	cd gitwc &&
+		ln -s added-file added-symlink-file &&
+		git add added-symlink-file &&
+	cd .. &&
+	cd svnwc &&
+		ln -s added-file added-symlink-file &&
+		svn add added-symlink-file > /dev/null &&
+	cd .. &&
+	ptouch gitwc/added-symlink-file svnwc/added-symlink-file &&
+	(cd svnwc; svn info added-symlink-file) \
+		> expected.info-added-symlink-file &&
+	(cd gitwc; git-svn info added-symlink-file) \
+		> actual.info-added-symlink-file &&
+	git-diff expected.info-added-symlink-file \
+		 actual.info-added-symlink-file
+	"
+
+test_expect_success 'info added-symlink-directory' "
+	cd gitwc &&
+		ln -s added-directory added-symlink-directory &&
+		git add added-symlink-directory &&
+	cd .. &&
+	cd svnwc &&
+		ln -s added-directory added-symlink-directory &&
+		svn add added-symlink-directory > /dev/null &&
+	cd .. &&
+	ptouch gitwc/added-symlink-directory svnwc/added-symlink-directory &&
+	(cd svnwc; svn info added-symlink-directory) \
+		> expected.info-added-symlink-directory &&
+	(cd gitwc; git-svn info added-symlink-directory) \
+		> actual.info-added-symlink-directory &&
+	git-diff expected.info-added-symlink-directory \
+		 actual.info-added-symlink-directory
+	"
+
+# The next few tests replace the "Text Last Updated" value with a
+# placeholder since git doesn't have a way to know the date that a
+# now-deleted file was last checked out locally.  Internally it
+# simply reuses the Last Changed Date.
+
+test_expect_success 'info deleted-file' "
+	cd gitwc &&
+		git rm -f file > /dev/null &&
+	cd .. &&
+	cd svnwc &&
+		svn rm --force file > /dev/null &&
+	cd .. &&
+	(cd svnwc; svn info file) |
+	sed -e 's/^\(Text Last Updated:\).*/\1 TEXT-LAST-UPDATED-STRING/' \
+		> expected.info-deleted-file &&
+	(cd gitwc; git-svn info file) |
+	sed -e 's/^\(Text Last Updated:\).*/\1 TEXT-LAST-UPDATED-STRING/' \
+		> actual.info-deleted-file &&
+	git-diff expected.info-deleted-file actual.info-deleted-file
+	"
+
+test_expect_success 'info deleted-directory' "
+	cd gitwc &&
+		git rm -r -f directory > /dev/null &&
+	cd .. &&
+	cd svnwc &&
+		svn rm --force directory > /dev/null &&
+	cd .. &&
+	(cd svnwc; svn info directory) |
+	sed -e 's/^\(Text Last Updated:\).*/\1 TEXT-LAST-UPDATED-STRING/' \
+		> expected.info-deleted-directory &&
+	(cd gitwc; git-svn info directory) |
+	sed -e 's/^\(Text Last Updated:\).*/\1 TEXT-LAST-UPDATED-STRING/' \
+		> actual.info-deleted-directory &&
+	git-diff expected.info-deleted-directory actual.info-deleted-directory
+	"
+
+test_expect_success 'info deleted-symlink-file' "
+	cd gitwc &&
+		git rm -f symlink-file > /dev/null &&
+	cd .. &&
+	cd svnwc &&
+		svn rm --force symlink-file > /dev/null &&
+	cd .. &&
+	(cd svnwc; svn info symlink-file) |
+	sed -e 's/^\(Text Last Updated:\).*/\1 TEXT-LAST-UPDATED-STRING/' \
+		> expected.info-deleted-symlink-file &&
+	(cd gitwc; git-svn info symlink-file) |
+	sed -e 's/^\(Text Last Updated:\).*/\1 TEXT-LAST-UPDATED-STRING/' \
+		> actual.info-deleted-symlink-file &&
+	git-diff expected.info-deleted-symlink-file \
+		 actual.info-deleted-symlink-file
+	"
+
+test_expect_success 'info deleted-symlink-directory' "
+	cd gitwc &&
+		git rm -f symlink-directory > /dev/null &&
+	cd .. &&
+	cd svnwc &&
+		svn rm --force symlink-directory > /dev/null &&
+	cd .. &&
+	(cd svnwc; svn info symlink-directory) |
+	sed -e 's/^\(Text Last Updated:\).*/\1 TEXT-LAST-UPDATED-STRING/' \
+		 > expected.info-deleted-symlink-directory &&
+	(cd gitwc; git-svn info symlink-directory) |
+	sed -e 's/^\(Text Last Updated:\).*/\1 TEXT-LAST-UPDATED-STRING/' \
+		 > actual.info-deleted-symlink-directory &&
+	git-diff expected.info-deleted-symlink-directory \
+		 actual.info-deleted-symlink-directory
+	"
+
+# NOTE: git does not have the concept of replaced objects,
+# so we can't test for files in that state.
+
+test_expect_success 'info unknown-file' "
+	echo two > gitwc/unknown-file &&
+	cp gitwc/unknown-file svnwc/unknown-file &&
+	ptouch gitwc/unknown-file svnwc/unknown-file &&
+	(cd svnwc; svn info unknown-file) 2> expected.info-unknown-file &&
+	(cd gitwc; git-svn info unknown-file) 2> actual.info-unknown-file &&
+	git-diff expected.info-unknown-file actual.info-unknown-file
+	"
+
+test_expect_success 'info unknown-directory' "
+	mkdir gitwc/unknown-directory svnwc/unknown-directory &&
+	ptouch gitwc/unknown-directory svnwc/unknown-directory &&
+	touch gitwc/unknown-directory/.placeholder &&
+	(cd svnwc; svn info unknown-directory) \
+		2> expected.info-unknown-directory &&
+	(cd gitwc; git-svn info unknown-directory) \
+		2> actual.info-unknown-directory &&
+	git-diff expected.info-unknown-directory actual.info-unknown-directory
+	"
+
+test_expect_success 'info unknown-symlink-file' "
+	cd gitwc &&
+		ln -s unknown-file unknown-symlink-file &&
+	cd .. &&
+	cd svnwc &&
+		ln -s unknown-file unknown-symlink-file &&
+	cd .. &&
+	ptouch gitwc/unknown-symlink-file svnwc/unknown-symlink-file &&
+	(cd svnwc; svn info unknown-symlink-file) \
+		2> expected.info-unknown-symlink-file &&
+	(cd gitwc; git-svn info unknown-symlink-file) \
+		2> actual.info-unknown-symlink-file &&
+	git-diff expected.info-unknown-symlink-file \
+		 actual.info-unknown-symlink-file
+	"
+
+test_expect_success 'info unknown-symlink-directory' "
+	cd gitwc &&
+		ln -s unknown-directory unknown-symlink-directory &&
+	cd .. &&
+	cd svnwc &&
+		ln -s unknown-directory unknown-symlink-directory &&
+	cd .. &&
+	ptouch gitwc/unknown-symlink-directory \
+	       svnwc/unknown-symlink-directory &&
+	(cd svnwc; svn info unknown-symlink-directory) \
+		2> expected.info-unknown-symlink-directory &&
+	(cd gitwc; git-svn info unknown-symlink-directory) \
+		2> actual.info-unknown-symlink-directory &&
+	git-diff expected.info-unknown-symlink-directory \
+		 actual.info-unknown-symlink-directory
+	"
+
+test_done
-- 
1.5.3.4
