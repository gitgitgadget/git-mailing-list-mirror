From: Robert Luberda <robert@debian.org>
Subject: [PATCH/RFC] git svn: don't introduce new paragraph for git-svn-id
Date: Wed,  1 Aug 2012 23:23:17 +0200
Message-ID: <1343856197-6393-1-git-send-email-robert@debian.org>
Cc: Robert Luberda <robert@debian.org>
To: Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 01 23:42:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SwggX-0003sO-43
	for gcvg-git-2@plane.gmane.org; Wed, 01 Aug 2012 23:42:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755951Ab2HAVmW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Aug 2012 17:42:22 -0400
Received: from master.debian.org ([70.103.162.29]:51570 "EHLO
	master.debian.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755277Ab2HAVmV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Aug 2012 17:42:21 -0400
X-Greylist: delayed 348 seconds by postgrey-1.27 at vger.kernel.org; Wed, 01 Aug 2012 17:42:21 EDT
Received: from localhost ([127.0.0.1] helo=vox.robbo.home)
	by master.debian.org with esmtp (Exim 4.72)
	(envelope-from <robert@debian.org>)
	id 1Swgaf-00089I-Gr; Wed, 01 Aug 2012 21:36:25 +0000
Received: by vox.robbo.home (Postfix, from userid 1000)
	id 19B57E2D23; Wed,  1 Aug 2012 23:23:47 +0200 (CEST)
X-Mailer: git-send-email 1.7.10.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202729>

While importing changes from SVN by `git svn fetch' strip any
white spaces from beginnings and endings of SVN commit messages
and skip adding a new line character before `git-svn-id:'
line in case the commit message ends with another pseudo-header
(like From:, Signed-off-by: or Change-Id:, etc.).

This patch allows one to use gerrit code review system on git-svn-managed
repositories. gerrit expects its `Change-Id:' header to appear in the
last paragraph of commit message and `git-svn-id:' following a new
line character was breaking this expectation.
---
 perl/Git/SVN.pm                    |    5 +-
 t/t9122-git-svn-author.sh          |    4 +-
 t/t9163-git-svn-import-messages.sh |  174 ++++++++++++++++++++++++++++++++++++
 3 files changed, 180 insertions(+), 3 deletions(-)
 create mode 100755 t/t9163-git-svn-import-messages.sh

diff --git a/perl/Git/SVN.pm b/perl/Git/SVN.pm
index b8b3474..bf22408 100644
--- a/perl/Git/SVN.pm
+++ b/perl/Git/SVN.pm
@@ -1015,7 +1015,8 @@ sub do_git_commit {
 	print $msg_fh $log_entry->{log} or croak $!;
 	restore_commit_header_env($old_env);
 	unless ($self->no_metadata) {
-		print $msg_fh "\ngit-svn-id: $log_entry->{metadata}\n"
+		print $msg_fh "\n" unless $log_entry->{log} =~ m/\n\n([\w-]+:\s.*\n)+$/;
+		print $msg_fh "git-svn-id: $log_entry->{metadata}\n"
 		              or croak $!;
 	}
 	$msg_fh->flush == 0 or croak $!;
@@ -1803,6 +1804,8 @@ sub make_log_entry {
 	close $un or croak $!;
 
 	$log_entry{date} = parse_svn_date($log_entry{date});
+	$log_entry{log} =~ s/^\s*//;
+	$log_entry{log} =~ s/\s*$//;
 	$log_entry{log} .= "\n";
 	my $author = $log_entry{author} = check_author($log_entry{author});
 	my ($name, $email) = defined $::users{$author} ? @{$::users{$author}}
diff --git a/t/t9122-git-svn-author.sh b/t/t9122-git-svn-author.sh
index 30013b7..c1d55eb 100755
--- a/t/t9122-git-svn-author.sh
+++ b/t/t9122-git-svn-author.sh
@@ -68,8 +68,8 @@ test_expect_success 'interact with it via git svn' '
 
 	# Make sure there are no commit messages with excess blank lines
 	test $(grep "^ " actual.2 | wc -l) = 3 &&
-	test $(grep "^ " actual.3 | wc -l) = 5 &&
-	test $(grep "^ " actual.4 | wc -l) = 5 &&
+	test $(grep "^ " actual.3 | wc -l) = 4 &&
+	test $(grep "^ " actual.4 | wc -l) = 4 &&
 
 	# Make sure there are no svn commit messages with excess blank lines
 	(
diff --git a/t/t9163-git-svn-import-messages.sh b/t/t9163-git-svn-import-messages.sh
new file mode 100755
index 0000000..46b7c5b
--- /dev/null
+++ b/t/t9163-git-svn-import-messages.sh
@@ -0,0 +1,174 @@
+#!/bin/sh
+#
+# Copyright (c) 2012 Robert Luberda
+#
+
+test_description='git svn check log messages imported from svn'
+. ./lib-git-svn.sh
+
+get_file_contents()
+{
+	for line in "$@"; do
+		echo "$line"
+	done
+}
+
+svn_commit()
+{
+	N=`expr $N + 1`
+	get_file_contents "$@" > svn-message.$N;
+	(cd work.svn && echo "$N" >> file &&
+	svn_cmd commit -F ../svn-message.$N file)
+}
+
+git_svn_dcommit()
+{
+	N=`expr $N + 1`
+	get_file_contents "$@" > git-svn-message.$N;
+	(cd work.git && echo "$N" >> file &&
+	git commit -a -F ../git-svn-message.$N &&
+	git svn dcommit )
+}
+
+fetch_and_check()
+{
+	get_file_contents "$@" >expected.$N	&&
+	echo "GIT-SVN-ID-LINE" >> expected.$N	&&
+	(cd work.git && git svn rebase)		&&
+	(cd work.git && git show -s HEAD) | sed -ne '/^    /,${
+		s/^    //
+		s/^git-svn-id: .*$/GIT-SVN-ID-LINE/
+		p
+		}' > actual.$N			&&
+	test_cmp expected.$N actual.$N
+}
+
+
+test_expect_success 'setup svn & git repository' '
+	svn_cmd checkout "$svnrepo" work.svn &&
+	(
+		cd work.svn &&
+		echo >file
+		svn_cmd add file &&
+		svn_cmd commit -m "initial commit"
+       ) &&
+       git svn clone "$svnrepo" work.git
+'
+
+test_expect_success 'check empty line is added before git-svn-id' '
+	svn_commit "test message 1" &&
+	fetch_and_check "test message 1" \
+			""
+'
+
+test_expect_success 'no empty line before git-svn-id if ends with pseudo-header' '
+	svn_commit "test message 2" \
+			"" \
+			"Change-Id: I123456" &&
+	fetch_and_check "test message 2" \
+				"" \
+				"Change-Id: I123456"
+'
+
+test_expect_success 'no empty line before git-svn-id if ends with 2 pseudo-headers' '
+	svn_commit "test message 3" \
+			"" \
+			"Change-Id: I123456" \
+			"Signed-off-by: Au Thor <author@example.com>" &&
+	fetch_and_check "test message 3" \
+			"" \
+			"Change-Id: I123456" \
+			"Signed-off-by: Au Thor <author@example.com>"
+'
+
+test_expect_success 'empty line added when pseudo-header not in last section' '
+	svn_commit "test 4" \
+			"" \
+			"Change-Id: I123456" \
+			"line without colon" &&
+	fetch_and_check "test 4" \
+			"" \
+			"Change-Id: I123456" \
+			"line without colon" \
+			""
+'
+
+test_expect_success 'empty line added when pseudo-header missing space' '
+	svn_commit "test 5" \
+			"" \
+			"Change-Id:I123456" &&
+	fetch_and_check "test 5" \
+			"" \
+			"Change-Id:I123456" \
+			""
+'
+
+test_expect_success 'empty line added when pseudo-header missing colon' '
+	svn_commit "test 6" \
+			"" \
+			"Change-Id I123456" &&
+	fetch_and_check "test 6" \
+			"" \
+			"Change-Id I123456" \
+			""
+'
+test_expect_success 'empty line added when message consist of pseudo-header only' '
+	svn_commit "Change-Id: I7a1b2c3" &&
+	fetch_and_check "Change-Id: I7a1b2c3" \
+			""
+'
+
+test_expect_success 'whitespaces removed from start of message' '
+	svn_commit "   " \
+		   "  test 8" &&
+	fetch_and_check "test 8" \
+			""
+'
+
+test_expect_success 'whitespaces removed from end of message' '
+	svn_commit "test commit 9  " \
+		   "  "  \
+		   "	" &&
+	fetch_and_check "test commit 9" \
+			""
+'
+
+test_expect_success 'empty message imported as git-svn-id only' '
+	svn_commit "   " &&
+	fetch_and_check
+'
+
+test_expect_success 'pseudo-header preserved during git svn dcommit/rebase' '
+	git_svn_dcommit "test 11" \
+			"" \
+			"Change-Id: I23445" &&
+	fetch_and_check "test 11" \
+			"" \
+			"Change-Id: I23445"
+'
+
+test_expect_success 'empty line added if no pseudo-header when using git svn dcommit' '
+	git_svn_dcommit "test 12" &&
+	fetch_and_check "test 12" \
+			""
+'
+
+test_expect_success 'suprious git-svn-id line removed by git svn dcommit' '
+	git_svn_dcommit "test 13" \
+			"" \
+			"git-svn-id: file:///tmp/test@100 cb7b2de7-d0f6-461c-9b5c-d86679671c8" &&
+	fetch_and_check "test 13" \
+			""
+'
+
+test_expect_success 'suprious git-svn-id line removed by git svn dcommit when in middle of message' '
+	git_svn_dcommit "test 14" \
+			"" \
+			"git-svn-id: file:///tmp/test@110 cb7b2de7-d0f6-461c-9b5c-d86679671c8" \
+			"Header: test" &&
+	fetch_and_check "test 14" \
+			"" \
+			"Header: test"
+
+'
+test_done
-- 
1.7.10.4
