From: Robert Luberda <robert@debian.org>
Subject: [PATCH/RFC] git svn: optionally trim imported log messages
Date: Sun, 19 Aug 2012 23:52:50 +0200
Message-ID: <1345413170-2519-1-git-send-email-robert@debian.org>
References: <50315ED1.6080803@debian.org>
Cc: Robert Luberda <robert@debian.org>
To: Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 20 00:45:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3EEv-0007mZ-3E
	for gcvg-git-2@plane.gmane.org; Mon, 20 Aug 2012 00:45:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751724Ab2HSWo4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Aug 2012 18:44:56 -0400
Received: from master.debian.org ([70.103.162.29]:34414 "EHLO
	master.debian.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751333Ab2HSWoV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Aug 2012 18:44:21 -0400
Received: from localhost ([127.0.0.1] helo=vox.robbo.home)
	by master.debian.org with esmtp (Exim 4.72)
	(envelope-from <robert@debian.org>)
	id 1T3EE9-0006fY-TP; Sun, 19 Aug 2012 22:44:14 +0000
Received: by vox.robbo.home (Postfix, from userid 1000)
	id 8CB95E3130; Sun, 19 Aug 2012 23:52:59 +0200 (CEST)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <50315ED1.6080803@debian.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203740>

Introduce a `--trim-svn-log' option and svn.trimsvnlog boolean
configuration key for git svn commands.

When enabled while retrieving commits from svn, git svn will strip any
white spaces from beginnings and endings of SVN commit messages and will
skip adding an extra new line character before `git-svn-id:' line in case
the commit message already ends with a pseudo-headers section (a section
starting with an empty line followed by one or more pseudo-headers like
`From: ', `Signed-off-by: ', or `Change-Id: ').

Additionally, while creating new commits in svn when the new option is
enabled and `--add-author-from' is in effect, git svn will not add
a new line character before the `From: ' pseudo-header if the commit
message already ends with a pseudo-headers section.

The new option allows one to use gerrit code review system on
git-svn-managed repositories. gerrit expects its `Change-Id:' header
to appear in the last paragraph of commit message and the standard
behaviour of preceding `git-svn-id:' line with a new line character
was breaking this expectation.
---
 Documentation/git-svn.txt          |   16 ++
 git-svn.perl                       |    8 +-
 perl/Git/SVN.pm                    |   19 +-
 t/t9165-git-svn-import-messages.sh |  387 ++++++++++++++++++++++++++++++++++++
 4 files changed, 427 insertions(+), 3 deletions(-)
 create mode 100755 t/t9165-git-svn-import-messages.sh

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index cfe8d2b..79c21ee 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -603,6 +603,22 @@ creating the branch or tag.
 	git commit's author string.  If you use this, then `--use-log-author`
 	will retrieve a valid author string for all commits.
 
+--trim-svn-log::
+	When retrieving svn commits into git (as part of 'fetch', 'rebase',
+	or 'dcommit') trim the whitespaces from beginnings and endings
+	of the svn log messages and avoid preceding `git-svn-id:` line with
+	a new line character in case the log message already ends with a
+	pseudo-headers section (i.e. section starting with an empty line
+	followed by one or more lines like `Signed-off-by: `, `From: `,
+	or `Change-Id: `).
++
+When committing to svn from git (as part of 'commit-diff', 'set-tree'
+or 'dcommit') and '--add-author-from' is in effect, a new line character
+is not added before the `From: ` line if the log message ends with
+a pseudo-headers section.
++
+[verse]
+config key: svn.trimsvnlog
 
 ADVANCED OPTIONS
 ----------------
diff --git a/git-svn.perl b/git-svn.perl
index 828b8f0..3740835 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -133,6 +133,7 @@ my %fc_opts = ( 'follow-parent|follow!' => \$Git::SVN::_follow_parent,
 		   \$Git::SVN::_repack_flags,
 		'use-log-author' => \$Git::SVN::_use_log_author,
 		'add-author-from' => \$Git::SVN::_add_author_from,
+		'trim-svn-log' => \$Git::SVN::_trim_svn_log,
 		'localtime' => \$Git::SVN::_localtime,
 		%remote_opts );
 
@@ -500,6 +501,8 @@ sub cmd_clone {
 	cmd_init($url, $path);
 	command_oneline('config', 'svn.authorsfile', $authors_absolute)
 	    if $_authors;
+	command_oneline('config', 'svn.trimsvnlog', 'true')
+	    if $Git::SVN::_trim_svn_log;
 	Git::SVN::fetch_all($Git::SVN::default_repo_id);
 }
 
@@ -1782,7 +1785,10 @@ sub get_commit_entry {
 		$msgbuf =~ s/\s+$//s;
 		if ($Git::SVN::_add_author_from && defined($author)
 		    && !$saw_from) {
-			$msgbuf .= "\n\nFrom: $author";
+			$msgbuf .= "\n";
+			$msgbuf .= "\n"
+				unless Git::SVN::avoid_extra_new_line($msgbuf);
+			$msgbuf .= "From: $author";
 		}
 		print $log_fh $msgbuf or croak $!;
 		command_close_pipe($msg_fh, $ctx);
diff --git a/perl/Git/SVN.pm b/perl/Git/SVN.pm
index 8478d0c..9604667 100644
--- a/perl/Git/SVN.pm
+++ b/perl/Git/SVN.pm
@@ -5,7 +5,7 @@ use Fcntl qw/:DEFAULT :seek/;
 use constant rev_map_fmt => 'NH40';
 use vars qw/$_no_metadata
             $_repack $_repack_flags $_use_svm_props $_head
-            $_use_svnsync_props $no_reuse_existing
+            $_use_svnsync_props $no_reuse_existing $_trim_svn_log
 	    $_use_log_author $_add_author_from $_localtime/;
 use Carp qw/croak/;
 use File::Path qw/mkpath/;
@@ -978,6 +978,17 @@ sub gc {
 	command_noisy('gc', '--auto');
 };
 
+# An utility function which returns true if both trimming svn log messages
+# is enabled, and passed log entry ends with a pseudo-headers section (i.e.
+# section starting with empty line followed by one or more pseudo-headers
+# like 'From: ' or 'Change-Id: ' etc.)
+sub avoid_extra_new_line {
+	return 0 unless $_trim_svn_log;
+
+	my $log_entry = shift;
+	return ($log_entry =~ m/\n\n([\w-]+:\s.*\n)+$/);
+}
+
 sub do_git_commit {
 	my ($self, $log_entry) = @_;
 	my $lr = $self->last_rev;
@@ -1015,7 +1026,9 @@ sub do_git_commit {
 	print $msg_fh $log_entry->{log} or croak $!;
 	restore_commit_header_env($old_env);
 	unless ($self->no_metadata) {
-		print $msg_fh "\ngit-svn-id: $log_entry->{metadata}\n"
+		print $msg_fh "\n"
+			unless avoid_extra_new_line($log_entry->{log});
+		print $msg_fh "git-svn-id: $log_entry->{metadata}\n"
 		              or croak $!;
 	}
 	$msg_fh->flush == 0 or croak $!;
@@ -1821,6 +1834,8 @@ sub make_log_entry {
 	close $un or croak $!;
 
 	$log_entry{date} = parse_svn_date($log_entry{date});
+	$log_entry{log} =~ s/^\s*// if $_trim_svn_log;
+	$log_entry{log} =~ s/\s*$// if $_trim_svn_log;
 	$log_entry{log} .= "\n";
 	my $author = $log_entry{author} = check_author($log_entry{author});
 	my ($name, $email) = defined $::users{$author} ? @{$::users{$author}}
diff --git a/t/t9165-git-svn-import-messages.sh b/t/t9165-git-svn-import-messages.sh
new file mode 100755
index 0000000..1ad4485
--- /dev/null
+++ b/t/t9165-git-svn-import-messages.sh
@@ -0,0 +1,387 @@
+#!/bin/sh
+#
+# Copyright (c) 2012 Robert Luberda
+#
+
+test_description='checks behaviour of --trim-svn-log option of git svn'
+. ./lib-git-svn.sh
+
+# The test cases in this file check if the --trim-svn-log option
+# of git svn works as expected.
+#
+# Basically the test cases use two git repositories:
+# * work-TRIM.git, created by git svn clone with the option enabled,
+# * work-NOTR.git, created with the option disabled.
+#
+# Each test case (except for the first two) does the following:
+# 1. commit a change to svn with either svn commit, or git svn dcommit
+#    (what is important is the commit log message, not the changed file)
+# 2. git svn rebase the  work-NOTR.git repository and check its most recent
+#    log message against some expected output
+# 3. git svn rebase the work-TRIM.git repository and similarly check the
+#    latest log message
+#
+# The following two prerequisites are defined mostly for debugging purposes
+# to make it possible to skip test cases or parts of the test cases that
+# operate on one of the two git repositories. For example to ignore checking
+# of log messages imported when --trim-svn-log is enabled, one needs to comment
+# out the PRQ_TRIM pre-requisite (this makes it possible to run the test with
+# a version of git svn that does not support the option yet). Similarly
+# commenting out the PRQ_NOTR pre-requisite will check only the effects of the
+# svn log trimming option.
+# Please note that a whole test case must be marked as requiring one of
+# those pre-requisites if and only if it uses `git svn dcommit' for committing
+# changes to svn.
+test_set_prereq PRQ_TRIM
+test_set_prereq PRQ_NOTR
+
+N=0
+NL=""	# for better readability only, e.g.:
+	# "$NL" "   " "$NL" is cleaner than "" "   " ""
+
+next_N()
+{
+	N=$((N + 1)) &&
+	echo "N is $N"
+}
+
+# An utility function used for writing log messages to files
+get_file_contents()
+{
+	for line in "$@"; do
+		echo "$line"
+	done
+}
+
+# Commit to svn using 'svn commit'.
+# Usage:
+#  svn_commit commit_log_line ...
+# For example:
+#  svn_commit "message line 1" "message line 2"
+# will create a svn commit which log message is
+#  "message line 1\nmessage line 2\n\n"
+# Please note the two ending new line characters - the first one
+# is added by us and the second one is added by svn (which seems
+# to always adds a new line character on its own).
+svn_commit()
+{
+	get_file_contents "$@" > t${N}-svn-message &&
+	(
+		cd work.svn && svn_cmd up &&
+		echo "$N" >> file &&
+		svn_cmd commit -F ../t${N}-svn-message file
+	)
+}
+
+# Commit to svn using 'git svn dcommit' in either work-TRIM.git or
+# work-NOTR.git repository.
+# Usage:
+#  git_svn_dcm [ git_svn_dcommit_options ] TRIM | NOTR commit_log_line ...
+# Examples:
+#  git_svn_dcm TRIM "message line 1" "message line 2"
+#  git_svn_dcm NOTR "message line 1" "message line 2"
+#  git_svn_dcm --add-author-from TRIM "message line 1" "message line 2"
+# Notes:
+# * On the contrary to the above svn_commit() function, created
+#   svn log message ends with only one new line character, e.g. the command
+#   from the first example will create a commit in svn with a log message:
+#   "message line 1\nmessage line 2\n"
+# * Test using this function should declare an appropriate pre-requisite.
+git_svn_dcm()
+{
+	opts="" &&
+	while test "$1" != "TRIM"  && test "$1" != "NOTR"
+	do
+		opts="$opts $1" && shift;
+	done &&
+	type="$1" && shift  &&
+	get_file_contents "$@" > t${N}-git-svn-message.$type    &&
+	(
+		cd work-${type}.git && git svn rebase           &&
+		echo "$N" >> file                               &&
+		git commit -a -F ../t${N}-git-svn-message.$type &&
+		git svn dcommit $opts
+	)
+}
+
+
+# Rebases either work-TRIM.git or work-NOTR.git repository using `git svn
+# rebase' and checks the latest git log message against the given expected
+# message log lines.
+# Usage:
+#  fetch_check TRIM | NOTR expected_log_line ...
+# Examples:
+#  fetch_check TRIM "expected message line 1" "expected message line 2"
+#  fetch_check NOTR "expected message line 1"
+# Notes:
+# * A `git-svn-id: ' line is assumed to end each log message. No such line
+#   should be passed as argument of this function.
+# * The function does nothing but returning successfully if a necessary
+#   pre-requisite is not set.
+fetch_check()
+{
+	type="$1" && shift                                  &&
+	{ test_have_prereq "PRQ_$type"  || return 0; }      &&
+	expected_file="t${N}-expected.${type}" 	            &&
+	{
+		get_file_contents "$@" >  "$expected_file"  &&
+		echo "GIT-SVN-ID-LINE" >> "$expected_file"
+	} &&
+	actual_file="t${N}-actual.${type}"  &&
+	{
+		(cd work-${type}.git && git svn rebase) &&
+		(cd work-${type}.git && git show -s HEAD) | sed -ne '/^    /,${
+			s/^    //
+			s/^git-svn-id: .*$/GIT-SVN-ID-LINE/
+			p
+			}' > "$actual_file"
+	} &&
+	test_cmp "$expected_file" "$actual_file"
+}
+
+
+test_expect_success 'setup svn & git repositories' '
+	svn_cmd checkout "$svnrepo" work.svn &&
+	(
+		cd work.svn      &&
+		echo >file       &&
+		svn_cmd add file &&
+		svn_cmd commit -m "Initial commit"
+	) &&
+	if test_have_prereq PRQ_NOTR; then
+		git svn clone "$svnrepo" work-NOTR.git
+	fi &&
+	if test_have_prereq PRQ_TRIM; then
+		git svn clone --trim-svn-log \
+				"$svnrepo"  work-TRIM.git
+	fi
+'
+
+test_expect_success 'configuration key check' '
+	key=svn.trimsvnlog     &&
+	if test_have_prereq PRQ_NOTR; then
+	(
+		cd work-NOTR.git  &&
+		test_must_fail git config --local --get "$key"
+	)
+	fi &&
+	if test_have_prereq PRQ_TRIM; then
+	(
+		cd work-TRIM.git                                 &&
+		echo "true" > expected.setting                   &&
+		git config --local --get "$key" > actual.setting &&
+		test_cmp expected.setting actual.setting
+	)
+	fi
+'
+
+test_expect_success 'no pseudo-header in message' '
+	next_N &&
+	svn_commit       "test message $N"              &&
+	fetch_check NOTR "test message $N" "$NL" "$NL"  &&
+	fetch_check TRIM "test message $N" "$NL"
+'
+
+test_expect_success 'one pseudo-header at the end of message' '
+	next_N &&
+	svn_commit       "test message $N" "$NL" "Change-Id: I123456"  &&
+	fetch_check NOTR "test message $N" "$NL" "Change-Id: I123456"   \
+			"$NL" "$NL"                                    &&
+	fetch_check TRIM "test message $N" "$NL" "Change-Id: I123456"
+'
+
+test_expect_success 'two pseudo-headers at the end of message' '
+	next_N &&
+	svn_commit      "test message $N" "$NL"  "Change-Id: I123456"   \
+			"Signed-off-by: Au Thor <author@example.com>"  &&
+	fetch_check NOTR "test message $N" "$NL" "Change-Id: I123456"   \
+			"Signed-off-by: Au Thor <author@example.com>"   \
+			"$NL" "$NL"                                    &&
+	fetch_check TRIM "test message $N" "$NL" "Change-Id: I123456"   \
+			"Signed-off-by: Au Thor <author@example.com>"
+'
+
+test_expect_success 'pseudo-header with digits in header name' '
+	next_N &&
+	svn_commit       "test $N" "$NL" "Key12X3: value"             &&
+	fetch_check NOTR "test $N" "$NL" "Key12X3: value" "$NL" "$NL" &&
+	fetch_check TRIM "test $N" "$NL" "Key12X3: value"
+'
+
+test_expect_success 'pseudo-header with tab as a separator' '
+	next_N &&
+	svn_commit       "test $N" "$NL" "Key:	value"             &&
+	fetch_check NOTR "test $N" "$NL" "Key:	value" "$NL" "$NL" &&
+	fetch_check TRIM "test $N" "$NL" "Key:	value"
+'
+
+test_expect_success 'pseudo-header not in the last section' '
+	next_N &&
+	svn_commit       "test $N" "$NL" "Change-Id: I123456"  \
+			"line without colon"                 &&
+	fetch_check NOTR "test $N" "$NL" "Change-Id: I123456"  \
+			"line without colon" "$NL" "$NL"     &&
+	fetch_check TRIM "test $N" "$NL" "Change-Id: I123456"  \
+			"line without colon" "$NL"
+'
+
+test_expect_success 'pseudo-header not separated by empty line' '
+	next_N &&
+	svn_commit       "test $N" "$NL" "not a pseudo header"  \
+			"Pseudo-Header: value"                 &&
+	fetch_check NOTR "test $N" "$NL" "not a pseudo header"  \
+			"Pseudo-Header: value" "$NL" "$NL"     &&
+	fetch_check TRIM "test $N" "$NL" "not a pseudo header"  \
+			"Pseudo-Header: value" "$NL"
+'
+
+test_expect_success 'not considered as pseudo-header: no space after colon' '
+	next_N &&
+	svn_commit       "test $N" "$NL" "Change-Id:I123456"              &&
+	fetch_check NOTR "test $N" "$NL" "Change-Id:I123456"  "$NL" "$NL" &&
+	fetch_check TRIM "test $N" "$NL" "Change-Id:I123456"  "$NL"
+'
+
+test_expect_success 'not considered as pseudo-header: missing colon' '
+	next_N &&
+	svn_commit       "test $N" "$NL" "Change-Id I123456"             &&
+	fetch_check NOTR "test $N" "$NL" "Change-Id I123456" "$NL" "$NL" &&
+	fetch_check TRIM "test $N" "$NL" "Change-Id I123456" "$NL"
+'
+
+test_expect_success 'not considered as pseudo-header: space in header name' '
+	next_N &&
+	svn_commit       "test $N" "$NL" "Change Id: I1234567"             &&
+	fetch_check NOTR "test $N" "$NL" "Change Id: I1234567" "$NL" "$NL" &&
+	fetch_check TRIM "test $N" "$NL" "Change Id: I1234567" "$NL"
+'
+
+test_expect_success 'not considered as pseudo-header: space at front' '
+	next_N &&
+	svn_commit       "test $N" "$NL" "   Change Id: Iaaaab"             &&
+	fetch_check NOTR "test $N" "$NL" "   Change Id: Iaaaab" "$NL" "$NL" &&
+	fetch_check TRIM "test $N" "$NL" "   Change Id: Iaaaab" "$NL"
+'
+
+test_expect_success 'new line added if pseudo-header only message' '
+	next_N &&
+	svn_commit       "Change-Id: I7a1b2c3"             &&
+	fetch_check NOTR "Change-Id: I7a1b2c3" "$NL" "$NL" &&
+	fetch_check TRIM "Change-Id: I7a1b2c3" "$NL"
+'
+
+test_expect_success 'extra whitespaces dropped from beginning of message' '
+	next_N &&
+	svn_commit       "   "  "  test $N"          &&
+	fetch_check NOTR "  test $N" "$NL" "$NL"     &&
+	fetch_check TRIM "test $N" "$NL"
+'
+
+test_expect_success 'extra whitespaces dropped from the end of message' '
+	next_N &&
+	ws1="    " && ws2="	 "                           \
+	svn_commit       "test $N  " "$ws1" "$ws2"          &&
+	fetch_check NOTR "test $N" "$NL" "$NL" "$NL" "$NL"  &&
+	fetch_check TRIM "test $N" "$NL"
+'
+
+test_expect_success 'whitespace-only message imported as git-svn-id only' '
+	next_N &&
+	svn_commit       "   " &&
+	fetch_check NOTR       &&
+	fetch_check TRIM
+'
+
+test_expect_success PRQ_NOTR 'dcommit: no-trim, no-pseudo-header' '
+	next_N &&
+	git_svn_dcm NOTR "test $N"         &&
+	fetch_check NOTR "test $N" "$NL"   &&
+	fetch_check TRIM "test $N" "$NL"
+'
+
+test_expect_success PRQ_TRIM 'dcommit: trim, no-pseudo-header' '
+	next_N &&
+	git_svn_dcm TRIM "test $N"         &&
+	fetch_check NOTR "test $N" "$NL"   &&
+	fetch_check TRIM "test $N" "$NL"
+'
+
+test_expect_success PRQ_NOTR 'dcommit: no-trim, pseudo-header' '
+	next_N &&
+	git_svn_dcm NOTR "test $N" "$NL" "Change-Id: I2344a"        &&
+	fetch_check NOTR "test $N" "$NL" "Change-Id: I2344a" "$NL"  &&
+	fetch_check TRIM "test $N" "$NL" "Change-Id: I2344a"
+'
+
+test_expect_success PRQ_TRIM 'dcommit: trim, pseudo-header' '
+	next_N &&
+	git_svn_dcm TRIM "test $N" "$NL" "Change-Id: I2344b"        &&
+	fetch_check NOTR "test $N" "$NL" "Change-Id: I2344b" "$NL"  &&
+	fetch_check TRIM "test $N" "$NL" "Change-Id: I2344b"
+'
+
+
+test_expect_success PRQ_NOTR 'dcommit --add-a-f: no-trim, no-pseudo-header' '
+	next_N &&
+	git_svn_dcm --add-author-from NOTR "test $N"                 &&
+	fetch_check NOTR "test $N" "$NL"                              \
+			"From: A U Thor <author@example.com>" "$NL"  &&
+	fetch_check TRIM "test $N" "$NL"                              \
+			"From: A U Thor <author@example.com>"
+'
+
+test_expect_success PRQ_TRIM 'dcommit --add-a-f: trim, no-pseudo-header' '
+	next_N &&
+	git_svn_dcm --add-author-from TRIM "test $N"                 &&
+	fetch_check NOTR "test $N" "$NL"                              \
+			"From: A U Thor <author@example.com>" "$NL"  &&
+	fetch_check TRIM "test $N" "$NL"                              \
+			"From: A U Thor <author@example.com>"
+'
+
+test_expect_success PRQ_NOTR 'dcommit --add-a-f: no-trim, pseudo-header' '
+	next_N &&
+	git_svn_dcm --add-author-from NOTR                            \
+			"test $N" "$NL"                               \
+			"Change-Id: Ixxx1"                           &&
+	fetch_check NOTR "test $N" "$NL"                              \
+			"Change-Id: Ixxx1" "$NL"                      \
+			"From: A U Thor <author@example.com>" "$NL"  &&
+	fetch_check TRIM "test $N" "$NL"                              \
+			"Change-Id: Ixxx1"  "$NL"                     \
+			"From: A U Thor <author@example.com>"
+'
+
+test_expect_success PRQ_TRIM 'dcommit --add-a-f: trim, pseudo-header' '
+	next_N &&
+	git_svn_dcm --add-author-from TRIM                            \
+			"test $N" "$NL"                               \
+			"Change-Id: Ixxx1"                           &&
+	fetch_check NOTR "test $N" "$NL"                              \
+			"Change-Id: Ixxx1"                            \
+			"From: A U Thor <author@example.com>" "$NL"  &&
+	fetch_check TRIM "test $N" "$NL"                              \
+			"Change-Id: Ixxx1"                            \
+			"From: A U Thor <author@example.com>"
+'
+
+test_expect_success PRQ_NOTR 'dcommit: remove suprious git-svn-id' '
+	next_N &&
+	id=cb7b2de7-d0f6-461c-9b5c-d86679671c8                  &&
+	git_svn_dcm NOTR "test $N" "$NL"                         \
+			"git-svn-id: file:///tmp/test@100 $id"  &&
+	fetch_check NOTR "test $N" "$NL"                        &&
+	fetch_check TRIM "test $N" "$NL"
+'
+
+test_expect_success PRQ_NOTR 'dcommit: remove git-svn-id in middle of message' '
+	next_N &&
+	id=cb7b2de7-d0f6-461c-9b5c-d86679671c8                 &&
+	git_svn_dcm NOTR "test $N" "$NL"                        \
+			"git-svn-id: file:///tmp/test@110 $id"  \
+			"Header: test"                         &&
+	fetch_check NOTR "test $N" "$NL" "Header: test" "$NL"  &&
+	fetch_check TRIM "test $N" "$NL" "Header: test"
+
+'
+test_done
-- 
1.7.10.4
