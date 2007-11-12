From: "David D. Kilzer" <ddkilzer@kilzer.net>
Subject: [RFC PATCH] git-svn info: implement info command
Date: Mon, 12 Nov 2007 08:19:09 -0800
Message-ID: <1194884349-11504-1-git-send-email-ddkilzer@kilzer.net>
Cc: "David D. Kilzer" <ddkilzer@kilzer.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 12 17:19:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Irc0U-0006qo-MC
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 17:19:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753096AbXKLQTK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 11:19:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753847AbXKLQTJ
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 11:19:09 -0500
Received: from mail-out3.apple.com ([17.254.13.22]:57176 "EHLO
	mail-out3.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753016AbXKLQTH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 11:19:07 -0500
Received: from relay11.apple.com (relay11.apple.com [17.128.113.48])
	by mail-out3.apple.com (Postfix) with ESMTP id 0DB871856B21;
	Mon, 12 Nov 2007 08:19:07 -0800 (PST)
Received: from relay11.apple.com (unknown [127.0.0.1])
	by relay11.apple.com (Symantec Mail Security) with ESMTP id EB0AB2804D;
	Mon, 12 Nov 2007 08:19:06 -0800 (PST)
X-AuditID: 11807130-a50c9bb00000088f-16-47387cfa1f8a
Received: from localhost.localdomain (unknown [17.151.102.63])
	by relay11.apple.com (Apple SCV relay) with ESMTP id A45672805A;
	Mon, 12 Nov 2007 08:19:06 -0800 (PST)
X-Mailer: git-send-email 1.5.3.4
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64650>

Implement "git-svn info" for files and directories based on the "svn info"
command.  Note that the -r/--revision argument is not supported yet.

Added 18 tests in t/t9117-git-svn-info.sh.

Signed-off-by: David D. Kilzer <ddkilzer@kilzer.net>
---

Looking for feedback on this patch.  Specifically, I'm looking for insight
for the two FIXME comments in the cmd_info() function added to git-svn.
(I can't help but think I'm missing a plumbing command or a basic concept.
Pointers to code, web pages or man pages are welcome.)

Note that I've tried to cover all the bases that "svn info" does (by using
tests), except supporting the -r/--revision argument.

I've also tried to be aggressive in extracting common code into functions.

Dave

 Documentation/git-svn.txt |    5 +
 git-svn.perl              |  194 +++++++++++++++++++++++++++++++------
 t/t9117-git-svn-info.sh   |  236 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 403 insertions(+), 32 deletions(-)
 create mode 100644 t/t9117-git-svn-info.sh

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
index dd93e32..256a3e0 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -48,7 +48,8 @@ BEGIN {
 	foreach (qw/command command_oneline command_noisy command_output_pipe
 	            command_input_pipe command_close_pipe/) {
 		for my $package ( qw(SVN::Git::Editor SVN::Git::Fetcher
-			Git::SVN::Migration Git::SVN::Log Git::SVN),
+			Git::SVN::Migration Git::SVN::Log Git::SVN
+			Git::SVN::Util),
 			__PACKAGE__) {
 			*{"${package}::$_"} = \&{"Git::$_"};
 		}
@@ -177,6 +178,8 @@ my %cmd = (
 			  'file|F=s' => \$_file,
 			  'revision|r=s' => \$_revision,
 			%cmt_opts } ],
+	'info' => [ \&cmd_info, "Show info about the latest SVN revision on the current branch",
+			{ } ],
 );
 
 my $cmd;
@@ -577,6 +580,23 @@ sub cmd_create_ignore {
 	});
 }
 
+sub canonicalize_path {
+	my ($path) = @_;
+	my $dotSlashAdded = 0;
+	if (substr($path, 0, 1) ne "/") {
+		$path = "./" . $path;
+		$dotSlashAdded = 1;
+	}
+	# File::Spec->canonpath doesn't collapse x/../y into y (for a
+	# good reason), so let's do this manually.
+	$path =~ s#/+#/#g;
+	$path =~ s#/\.(?:/|$)#/#g;
+	$path =~ s#/[^/]+/\.\.##g;
+	$path =~ s#/$##g;
+	$path =~ s#^\./## if $dotSlashAdded;
+	return $path;
+}
+
 # get_svnprops(PATH)
 # ------------------
 # Helper for cmd_propget and cmd_proplist below.
@@ -594,12 +614,7 @@ sub get_svnprops {
 
 	# canonicalize the path (otherwise libsvn will abort or fail to
 	# find the file)
-	# File::Spec->canonpath doesn't collapse x/../y into y (for a
-	# good reason), so let's do this manually.
-	$path =~ s#/+#/#g;
-	$path =~ s#/\.(?:/|$)#/#g;
-	$path =~ s#/[^/]+/\.\.##g;
-	$path =~ s#/$##g;
+	$path = canonicalize_path($path);
 
 	my $r = (defined $_revision ? $_revision : $gs->ra->get_latest_revnum);
 	my $props;
@@ -730,6 +745,96 @@ sub cmd_commit_diff {
 	}
 }
 
+sub cmd_info {
+	my $path = canonicalize_path(shift or ".");
+	unless (scalar(@_) == 0) {
+		die "Too many arguments specified\n";
+	}
+
+	# FIXME: We use a combination of git-diff, git-ls-files and git-cat-file
+	# to divine the state and type of object that was passed in as $path.
+	# There has to be a better way.  Note that only $diffStatus is used
+	# beyond setting $isDirectory below.
+
+	my $diffStatus = (split(' ', command_oneline(qw(diff --cached --name-status --), $path) || ""))[0] || "";
+	my $lsFiles = command_oneline(qw(ls-files), $path) || "";
+	if (!$diffStatus && !$lsFiles) {
+		print STDERR "$path:  (Not a versioned resource)\n\n";
+		return;
+	}
+
+	my $catFileType = ($path eq "." || $diffStatus eq "A") ? "" : (command_oneline(qw(cat-file -t), "HEAD:$path") || "");
+	my $isDirectory = (-e $path && ! -f $path && ! -l $path || $diffStatus eq "D" && $catFileType eq "tree");
+
+	my $result = "Path: $path\n";
+	$result .= "Name: " . basename($path) . "\n" if !$isDirectory;
+
+	my ($url, $rev, $uuid, $gs) = working_head_info('HEAD');
+	unless ($gs) {
+		die "Unable to determine upstream SVN information from ",
+		    "working tree history\n";
+	}
+	$result .= "URL: " . ($url . ($path eq "." ? "" : "/$path")) . "\n";
+
+	my $repos_root = $gs->ra->{repos_root};
+	Git::SVN::remove_username($repos_root);
+	$result .= "Repository Root: $repos_root\n";
+	$result .= "Repository UUID: $uuid\n" unless $diffStatus eq "A";
+	$result .= "Revision: " . ($diffStatus eq "A" ? 0 : $rev) . "\n";
+
+	$result .= "Node Kind: " . ($isDirectory ? "directory" : "file") . "\n";
+
+	my $schedule = ($diffStatus eq "A" ? "add" : ($diffStatus eq "D" ? "delete" : "normal"));
+	$result .= "Schedule: $schedule\n";
+
+	if ($diffStatus eq "A") {
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
+	$result .= "Last Changed Date: " . Git::SVN::Log::format_svn_date($lc_date_utc) . "\n";
+
+	if (!$isDirectory) {
+		my $textLastUpdatedDate = ($diffStatus eq "D" ? $lc_date_utc : (stat $path)[9]);
+		$result .= "Text Last Updated: " . Git::SVN::Log::format_svn_date($textLastUpdatedDate) . "\n";
+		my $checksum;
+		# FIXME: We fail to generate the correct checksum for deleted
+		# symlinks here.  How do we know if a deleted file was a symlink?
+		if ($diffStatus eq "D") {
+			my ($fh, $ctx) = command_output_pipe(qw(cat-file blob), "HEAD:$path");
+			$checksum = Git::SVN::Util::md5sum($fh);
+			command_close_pipe($fh, $ctx);
+		} elsif (-l $path) {
+			$checksum = Git::SVN::Util::md5sum("link " . command(qw(cat-file blob), "HEAD:$path"));
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
@@ -1037,6 +1142,27 @@ sub linearize_history {
 	(\@linear_refs, \%parents);
 }
 
+package Git::SVN::Util;
+use strict;
+use warnings;
+use Digest::MD5;
+
+sub md5sum {
+	my $arg = shift;
+	my $ref = ref $arg;
+	my $md5 = Digest::MD5->new();
+        if ($ref eq 'GLOB' || $ref eq 'IO::File') {
+		$md5->addfile($arg) or croak $!;
+	} elsif ($ref eq 'SCALAR') {
+		$md5->add($$arg) or croak $!;
+	} elsif (!$ref) {
+		$md5->add($arg) or croak $!;
+	} else {
+		::fatal "Can't provide MD5 hash for unknown ref type: '", $ref, "'";
+	}
+	return $md5->hexdigest();
+}
+
 package Git::SVN;
 use strict;
 use warnings;
@@ -2582,7 +2708,6 @@ use strict;
 use warnings;
 use Carp qw/croak/;
 use IO::File qw//;
-use Digest::MD5;
 
 # file baton members: path, mode_a, mode_b, pool, fh, blob, base
 sub new {
@@ -2734,9 +2859,7 @@ sub apply_textdelta {
 
 		if (defined $exp) {
 			seek $base, 0, 0 or croak $!;
-			my $md5 = Digest::MD5->new;
-			$md5->addfile($base);
-			my $got = $md5->hexdigest;
+			my $got = Git::SVN::Util::md5sum($base);
 			die "Checksum mismatch: $fb->{path} $fb->{blob}\n",
 			    "expected: $exp\n",
 			    "     got: $got\n" if ($got ne $exp);
@@ -2755,9 +2878,7 @@ sub close_file {
 	if (my $fh = $fb->{fh}) {
 		if (defined $exp) {
 			seek($fh, 0, 0) or croak $!;
-			my $md5 = Digest::MD5->new;
-			$md5->addfile($fh);
-			my $got = $md5->hexdigest;
+			my $got = Git::SVN::Util::md5sum($fh);
 			if ($got ne $exp) {
 				die "Checksum mismatch: $path\n",
 				    "expected: $exp\n    got: $got\n";
@@ -2809,7 +2930,6 @@ use strict;
 use warnings;
 use Carp qw/croak/;
 use IO::File;
-use Digest::MD5;
 
 sub new {
 	my ($class, $opts) = @_;
@@ -3113,11 +3233,9 @@ sub chg_file {
 	$fh->flush == 0 or croak $!;
 	seek $fh, 0, 0 or croak $!;
 
-	my $md5 = Digest::MD5->new;
-	$md5->addfile($fh) or croak $!;
+	my $exp = Git::SVN::Util::md5sum($fh);
 	seek $fh, 0, 0 or croak $!;
 
-	my $exp = $md5->hexdigest;
 	my $pool = SVN::Pool->new;
 	my $atd = $self->apply_textdelta($fbat, undef, $pool);
 	my $got = SVN::TxDelta::send_stream($fh, @$atd, $pool);
@@ -3810,6 +3928,29 @@ sub run_pager {
 	exec $pager or ::fatal "Can't run pager: $! ($pager)";
 }
 
+sub format_svn_date {
+	return strftime("%Y-%m-%d %H:%M:%S %z (%a, %d %b %Y)", localtime(shift));
+}
+
+sub parse_git_date {
+	my ($t, $tz) = @_;
+	# Date::Parse isn't in the standard Perl distro :(
+	if ($tz =~ s/^\+//) {
+		$t += tz_to_s_offset($tz);
+	} elsif ($tz =~ s/^\-//) {
+		$t -= tz_to_s_offset($tz);
+	}
+	return $t;
+}
+
+sub set_local_timezone {
+	if (defined $TZ) {
+		$ENV{TZ} = $TZ;
+	} else {
+		delete $ENV{TZ};
+	}
+}
+
 sub tz_to_s_offset {
 	my ($tz) = @_;
 	$tz =~ s/(\d\d)$//;
@@ -3830,13 +3971,7 @@ sub get_author_info {
 	$dest->{t} = $t;
 	$dest->{tz} = $tz;
 	$dest->{a} = $au;
-	# Date::Parse isn't in the standard Perl distro :(
-	if ($tz =~ s/^\+//) {
-		$t += tz_to_s_offset($tz);
-	} elsif ($tz =~ s/^\-//) {
-		$t -= tz_to_s_offset($tz);
-	}
-	$dest->{t_utc} = $t;
+	$dest->{t_utc} = parse_git_date($t, $tz);
 }
 
 sub process_commit {
@@ -3890,8 +4025,7 @@ sub show_commit_normal {
 	my ($c) = @_;
 	print '-' x72, "\nr$c->{r} | ";
 	print "$c->{c} | " if $show_commit;
-	print "$c->{a} | ", strftime("%Y-%m-%d %H:%M:%S %z (%a, %d %b %Y)",
-				 localtime($c->{t_utc})), ' | ';
+	print "$c->{a} | ", format_svn_date($c->{t_utc}), ' | ';
 	my $nr_line = 0;
 
 	if (my $l = $c->{l}) {
@@ -3931,11 +4065,7 @@ sub cmd_show_log {
 	my (@args) = @_;
 	my ($r_min, $r_max);
 	my $r_last = -1; # prevent dupes
-	if (defined $TZ) {
-		$ENV{TZ} = $TZ;
-	} else {
-		delete $ENV{TZ};
-	}
+	set_local_timezone();
 	if (defined $::_revision) {
 		if ($::_revision =~ /^(\d+):(\d+)$/) {
 			($r_min, $r_max) = ($1, $2);
diff --git a/t/t9117-git-svn-info.sh b/t/t9117-git-svn-info.sh
new file mode 100644
index 0000000..b20db04
--- /dev/null
+++ b/t/t9117-git-svn-info.sh
@@ -0,0 +1,236 @@
+#!/bin/sh
+#
+# Copyright (c) 2007 David D. Kilzer
+
+test_description='git-svn info'
+
+. ./lib-git-svn.sh
+
+test_expect_success 'setup repository and import' "
+	rm -rf info gitwc svnwc &&
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
+	touch -c -r svnwc/file gitwc/file &&
+	touch -c -r svnwc/directory gitwc/directory &&
+	touch -c -r svnwc/symlink-file gitwc/symlink-file &&
+	touch -c -r svnwc/symlink-directory gitwc/symlink-directory
+	"
+
+test_expect_success 'info no arguments' "
+	(cd svnwc; svn info) > expected.info-no-arguments &&
+	(cd gitwc; git-svn info) > actual.info-no-arguments &&
+	diff -u expected.info-no-arguments actual.info-no-arguments
+	"
+
+test_expect_success 'info dot' "
+	(cd svnwc; svn info .) > expected.info-dot &&
+	(cd gitwc; git-svn info .) > actual.info-dot &&
+	diff -u expected.info-dot actual.info-dot
+	"
+
+test_expect_success 'info file' "
+	(cd svnwc; svn info file) > expected.info-file &&
+	(cd gitwc; git-svn info file) > actual.info-file &&
+	diff -u expected.info-file actual.info-file
+	"
+
+test_expect_success 'info directory' "
+	(cd svnwc; svn info directory) > expected.info-directory &&
+	(cd gitwc; git-svn info directory) > actual.info-directory &&
+	diff -u expected.info-directory actual.info-directory
+	"
+
+test_expect_success 'info symlink-file' "
+	(cd svnwc; svn info symlink-file) > expected.info-symlink-file &&
+	(cd gitwc; git-svn info symlink-file) > actual.info-symlink-file &&
+	diff -u expected.info-symlink-file actual.info-symlink-file
+	"
+
+test_expect_success 'info symlink-directory' "
+	(cd svnwc; svn info symlink-directory) > expected.info-symlink-directory &&
+	(cd gitwc; git-svn info symlink-directory) > actual.info-symlink-directory &&
+	diff -u expected.info-symlink-directory actual.info-symlink-directory
+	"
+
+test_expect_success 'info added-file' "
+	echo two > gitwc/added-file &&
+	cd gitwc &&
+		git add added-file &&
+	cd .. &&
+	cp -p gitwc/added-file svnwc/added-file &&
+	touch -r gitwc/added-file svnwc/added-file &&
+	cd svnwc &&
+		svn add added-file > /dev/null &&
+	cd .. &&
+	(cd svnwc; svn info added-file) > expected.info-added-file &&
+	(cd gitwc; git-svn info added-file) > actual.info-added-file &&
+	diff -u expected.info-added-file actual.info-added-file
+	"
+
+test_expect_success 'info added-directory' "
+	mkdir gitwc/added-directory svnwc/added-directory &&
+	touch -r gitwc/added-directory svnwc/added-directory &&
+        touch gitwc/added-directory/.placeholder &&
+	cd svnwc &&
+		svn add added-directory > /dev/null &&
+	cd .. &&
+	cd gitwc &&
+		git add added-directory &&
+	cd .. &&
+	(cd svnwc; svn info added-directory) > expected.info-added-directory &&
+	(cd gitwc; git-svn info added-directory) > actual.info-added-directory &&
+	diff -u expected.info-added-directory actual.info-added-directory
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
+	touch -r gitwc/added-symlink-file svnwc/added-symlink-file &&
+	(cd svnwc; svn info added-symlink-file) > expected.info-added-symlink-file &&
+	(cd gitwc; git-svn info added-symlink-file) > actual.info-added-symlink-file &&
+	diff -u expected.info-added-symlink-file actual.info-added-symlink-file
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
+	touch -r gitwc/added-symlink-directory svnwc/added-symlink-directory &&
+	(cd svnwc; svn info added-symlink-directory) > expected.info-added-symlink-directory &&
+	(cd gitwc; git-svn info added-symlink-directory) > actual.info-added-symlink-directory &&
+	diff -u expected.info-added-symlink-directory actual.info-added-symlink-directory
+	"
+
+replace_Text_Last_Updated_date () {
+	REPLACEMENT=`cat $1 | grep '^Last Changed Date:' | sed -e 's/Last Changed Date/Text Last Updated/'` &&
+	cat $1 | sed -e "s/^Text Last Updated: .*\$/${REPLACEMENT}/" > $1.$$ &&
+	mv -f $1.$$ $1
+}
+
+test_expect_success 'info deleted-file' "
+	cd gitwc &&
+		git rm -f file > /dev/null &&
+	cd .. &&
+	cd svnwc &&
+		svn rm --force file > /dev/null &&
+	cd .. &&
+	(cd svnwc; svn info file) > expected.info-deleted-file &&
+	(cd gitwc; git-svn info file) > actual.info-deleted-file &&
+	replace_Text_Last_Updated_date expected.info-deleted-file &&
+	diff -u expected.info-deleted-file actual.info-deleted-file
+	"
+
+test_expect_success 'info deleted-directory' "
+	cd gitwc &&
+		git rm -r -f directory > /dev/null &&
+	cd .. &&
+	cd svnwc &&
+		svn rm --force directory > /dev/null &&
+	cd .. &&
+	(cd svnwc; svn info directory) > expected.info-deleted-directory &&
+	(cd gitwc; git-svn info directory) > actual.info-deleted-directory &&
+	replace_Text_Last_Updated_date expected.info-deleted-directory &&
+	diff -u expected.info-deleted-directory actual.info-deleted-directory
+	"
+
+test_expect_success 'info deleted-symlink-file' "
+	cd gitwc &&
+		git rm -f symlink-file > /dev/null &&
+	cd .. &&
+	cd svnwc &&
+		svn rm --force symlink-file > /dev/null &&
+	cd .. &&
+	(cd svnwc; svn info symlink-file) > expected.info-deleted-symlink-file &&
+	(cd gitwc; git-svn info symlink-file) > actual.info-deleted-symlink-file &&
+	replace_Text_Last_Updated_date expected.info-deleted-symlink-file &&
+	diff -u expected.info-deleted-symlink-file actual.info-deleted-symlink-file
+	"
+
+test_expect_success 'info deleted-symlink-directory' "
+	cd gitwc &&
+		git rm -f symlink-directory > /dev/null &&
+	cd .. &&
+	cd svnwc &&
+		svn rm --force symlink-directory > /dev/null &&
+	cd .. &&
+	(cd svnwc; svn info symlink-directory) > expected.info-deleted-symlink-directory &&
+	(cd gitwc; git-svn info symlink-directory) > actual.info-deleted-symlink-directory &&
+	replace_Text_Last_Updated_date expected.info-deleted-symlink-directory &&
+	diff -u expected.info-deleted-symlink-directory actual.info-deleted-symlink-directory
+	"
+
+# NOTE: git does not have the concept of replaced objects, so we can't test for them.
+#test_expect_success 'info replaced-file' "/usr/bin/true"
+#test_expect_success 'info replaced-directory' "/usr/bin/true"
+#test_expect_success 'info replaced-symlink-file' "/usr/bin/true"
+#test_expect_success 'info replaced-symlink-directory' "/usr/bin/true"
+
+test_expect_success 'info unknown-file' "
+	echo two > gitwc/unknown-file &&
+	cp -p gitwc/unknown-file svnwc/unknown-file &&
+	touch -r gitwc/unknown-file svnwc/unknown-file &&
+	(cd svnwc; svn info unknown-file) 2> expected.info-unknown-file &&
+	(cd gitwc; git-svn info unknown-file) 2> actual.info-unknown-file &&
+	diff -u expected.info-unknown-file actual.info-unknown-file
+	"
+
+test_expect_success 'info unknown-directory' "
+	mkdir gitwc/unknown-directory svnwc/unknown-directory &&
+	touch -r gitwc/unknown-directory svnwc/unknown-directory &&
+        touch gitwc/unknown-directory/.placeholder &&
+	(cd svnwc; svn info unknown-directory) 2> expected.info-unknown-directory &&
+	(cd gitwc; git-svn info unknown-directory) 2> actual.info-unknown-directory &&
+	diff -u expected.info-unknown-directory actual.info-unknown-directory
+	"
+
+test_expect_success 'info unknown-symlink-file' "
+	cd gitwc &&
+		ln -s unknown-file unknown-symlink-file &&
+	cd .. &&
+	cd svnwc &&
+		ln -s unknown-file unknown-symlink-file &&
+	cd .. &&
+	touch -r gitwc/unknown-symlink-file svnwc/unknown-symlink-file &&
+	(cd svnwc; svn info unknown-symlink-file) 2> expected.info-unknown-symlink-file &&
+	(cd gitwc; git-svn info unknown-symlink-file) 2> actual.info-unknown-symlink-file &&
+	diff -u expected.info-unknown-symlink-file actual.info-unknown-symlink-file
+	"
+
+test_expect_success 'info unknown-symlink-directory' "
+	cd gitwc &&
+		ln -s unknown-directory unknown-symlink-directory &&
+	cd .. &&
+	cd svnwc &&
+		ln -s unknown-directory unknown-symlink-directory &&
+	cd .. &&
+	touch -r gitwc/unknown-symlink-directory svnwc/unknown-symlink-directory &&
+	(cd svnwc; svn info unknown-symlink-directory) 2> expected.info-unknown-symlink-directory &&
+	(cd gitwc; git-svn info unknown-symlink-directory) 2> actual.info-unknown-symlink-directory &&
+	diff -u expected.info-unknown-symlink-directory actual.info-unknown-symlink-directory
+	"
+
+test_done
-- 
1.5.3.4
