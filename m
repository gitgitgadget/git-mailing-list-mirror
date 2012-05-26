From: Klaus Reimer <k@ailis.de>
Subject: [PATCH] Implement --messages-prog parameter in git-svn
Date: Sat, 26 May 2012 17:56:42 +0200
Message-ID: <4FC0FD3A.8080803@ailis.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat May 26 18:03:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SYJSe-0006xE-JV
	for gcvg-git-2@plane.gmane.org; Sat, 26 May 2012 18:03:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752784Ab2EZQDT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 May 2012 12:03:19 -0400
Received: from marvin.ailis.de ([176.9.29.37]:39866 "EHLO marvin.ailis.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752393Ab2EZQDT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 May 2012 12:03:19 -0400
X-Greylist: delayed 394 seconds by postgrey-1.27 at vger.kernel.org; Sat, 26 May 2012 12:03:18 EDT
Received: from [IPv6:2001:4dd0:fe00:1:5f:c6c7:ece5:bf0c] (unknown [IPv6:2001:4dd0:fe00:1:5f:c6c7:ece5:bf0c])
	by marvin.ailis.de (Postfix) with ESMTPSA id DA2BA1BB20AF;
	Sat, 26 May 2012 17:56:42 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:12.0) Gecko/20120430 Thunderbird/12.0.1
X-Virus-Scanned: clamav-milter 0.97.3 at marvin
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198564>

Some SVN repositories have strange policies for commit messages requiring an
empty line at the top of the commit message.  When you clone these
repositories with Git to mirror them on GitHub then no commit message
summaries are displayed at all at GitHub because they use the first line for
it (Which is empty).  You always have to open the commit message details
instead which is pretty annoying.  With the --messages-prog parameter you
can specify a program which can modify the SVN commit message before
committing it into the Git repo.  This works like the --authors-prog
parameter with the only difference that the commit message is piped into the
specified program instead of being passed to it as a command-line argument.

The same could be achieved by a "trim" feature but specifying a program
which can modify any aspect of a commit message is much more flexible.

Signed-off-by: Klaus Reimer <k@ailis.de>
---
 Documentation/git-svn.txt        |  5 +++++
 git-svn.perl                     | 26 +++++++++++++++++++++++++-
 t/t9147-git-svn-messages-prog.sh | 40 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 70 insertions(+), 1 deletion(-)
 create mode 100755 t/t9147-git-svn-messages-prog.sh

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index cfe8d2b..7289246 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -546,6 +546,11 @@ config key: svn.authorsfile
 	expected to return a single line of the form "Name <email>",
 	which will be treated as if included in the authors file.
 
+--messages-prog=<filename>::
+	If this option is specified, each SVN commit message is piped
+	through the given program. The output of this program is then
+	used as the new commit message instead.
+
 -q::
 --quiet::
 	Make 'git svn' less verbose. Specify a second time to make it
diff --git a/git-svn.perl b/git-svn.perl
index c84842f..514c888 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -6,7 +6,7 @@ use warnings;
 use strict;
 use vars qw/	$AUTHOR $VERSION
 		$sha1 $sha1_short $_revision $_repository
-		$_q $_authors $_authors_prog %users/;
+		$_q $_authors $_authors_prog $_messages_prog %users/;
 $AUTHOR = 'Eric Wong <normalperson@yhbt.net>';
 $VERSION = '@@GIT_VERSION@@';
 
@@ -120,6 +120,7 @@ my %remote_opts = ( 'username=s' => \$Git::SVN::Prompt::_username,
 my %fc_opts = ( 'follow-parent|follow!' => \$Git::SVN::_follow_parent,
 		'authors-file|A=s' => \$_authors,
 		'authors-prog=s' => \$_authors_prog,
+		'messages-prog=s' => \$_messages_prog,
 		'repack:i' => \$Git::SVN::_repack,
 		'noMetadata' => \$Git::SVN::_no_metadata,
 		'useSvmProps' => \$Git::SVN::_use_svm_props,
@@ -359,6 +360,9 @@ load_authors() if $_authors;
 if (defined $_authors_prog) {
 	$_authors_prog = "'" . File::Spec->rel2abs($_authors_prog) . "'";
 }
+if (defined $_messages_prog) {
+	$_messages_prog = "'" . File::Spec->rel2abs($_messages_prog) . "'";
+}
 
 unless ($cmd =~ /^(?:clone|init|multi-init|commit-diff)$/) {
 	Git::SVN::Migration::migration_check();
@@ -2051,6 +2055,7 @@ use vars qw/$default_repo_id $default_ref_id $_no_metadata $_follow_parent
 use Carp qw/croak/;
 use File::Path qw/mkpath/;
 use File::Copy qw/copy/;
+use IPC::Open2;
 use IPC::Open3;
 use Time::Local;
 use Memoize;  # core since 5.8.0, Jul 2002
@@ -3409,6 +3414,22 @@ sub other_gs {
 	$gs
 }
 
+sub call_messages_prog {
+	my ($orig_message) = @_;
+	my ($pid, $in, $out);
+	
+	$pid = open2($in, $out, $::_messages_prog)	
+		or die "$::_messages_prog failed with exit code $?\n";
+	print $out $orig_message;
+	close($out);
+	my ($message) = "";
+	while (<$in>) {
+		$message .= $_;
+	}
+	close($in);
+	return $message;    
+}
+
 sub call_authors_prog {
 	my ($orig_author) = @_;
 	$orig_author = command_oneline('rev-parse', '--sq-quote', $orig_author);
@@ -3809,6 +3830,9 @@ sub make_log_entry {
 
 	$log_entry{date} = parse_svn_date($log_entry{date});
 	$log_entry{log} .= "\n";
+	if (defined $::_messages_prog) {
+		$log_entry{log} = call_messages_prog($log_entry{log});
+	}
 	my $author = $log_entry{author} = check_author($log_entry{author});
 	my ($name, $email) = defined $::users{$author} ? @{$::users{$author}}
 						       : ($author, undef);
diff --git a/t/t9147-git-svn-messages-prog.sh b/t/t9147-git-svn-messages-prog.sh
new file mode 100755
index 0000000..ebb42b0
--- /dev/null
+++ b/t/t9147-git-svn-messages-prog.sh
@@ -0,0 +1,40 @@
+#!/bin/sh
+
+test_description='git svn messages prog tests'
+
+. ./lib-git-svn.sh
+
+cat > svn-messages-prog <<'EOF'
+#!/bin/sh
+sed s/foo/bar/g
+EOF
+chmod +x svn-messages-prog
+
+test_expect_success 'setup svnrepo' '
+	svn mkdir -m "Unchanged message" "$svnrepo"/a
+	svn mkdir -m "Changed message: foo" "$svnrepo"/b
+	'
+
+test_expect_success 'import messages with prog' '
+	git svn clone --messages-prog=./svn-messages-prog \
+	    "$svnrepo" x
+	'
+
+test_expect_success 'imported 2 revisions successfully' '
+	(
+		cd x
+		test "`git rev-list refs/remotes/git-svn | wc -l`" -eq 2
+	)
+	'
+
+test_expect_success 'messages-prog ran correctly' '
+	(
+		cd x
+		git rev-list -1 --pretty=raw refs/remotes/git-svn~1 | \
+		  grep "^    Unchanged message" &&
+		git rev-list -1 --pretty=raw refs/remotes/git-svn~0 | \
+		  grep "^    Changed message: bar"
+	)
+	'
+
+test_done
-- 
1.7.10.2.605.gbefc5ed.dirty

-- 
Bye, K <http://www.ailis.de/~k/>
[A735 47EC D87B 1F15 C1E9 53D3 AA03 6173 A723 E391]
