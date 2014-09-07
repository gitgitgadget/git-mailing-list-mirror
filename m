From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH v2] git svn: info: correctly handle absolute path args
Date: Sun, 7 Sep 2014 08:06:26 +0000
Message-ID: <20140907080626.GA6273@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andrej Manduch <amanduch@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 07 10:06:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XQXUo-00018l-9n
	for gcvg-git-2@plane.gmane.org; Sun, 07 Sep 2014 10:06:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750977AbaIGIGc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Sep 2014 04:06:32 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:49484 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750840AbaIGIG2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Sep 2014 04:06:28 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA7F01FD5A;
	Sun,  7 Sep 2014 08:06:26 +0000 (UTC)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256615>

Calling "git svn info $(pwd)" would hit:
  "Reading from filehandle failed at ..."
errors due to improper prefixing and canonicalization.

Strip the toplevel path from absolute filesystem paths to ensure
downstream canonicalization routines are only exposed to paths
tracked in git (or SVN).

Thanks to Andrej Manduch <amanduch@gmail.com> for originally
noticing the issue and fixing my original version of this to handle
more corner cases such as "/path/to/top/../top" and
"/path/to/top/../top/file" as shown in the new test cases.

Signed-off-by: Andrej Manduch <amanduch@gmail.com>
Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
    Eric Wong <normalperson@yhbt.net> wrote:
    > Thanks Andrej.  I'll queue that on top of mine.
    > Can you turn that into a proper commit message with Subject?
    > Thanks.

    I just squashed in your change and gave you credit.
    Sorry, I forgot about this completely.  Will test a bit more
    and ask Junio to pull.

 git-svn.perl            | 22 ++++++++++++++++------
 t/t9119-git-svn-info.sh | 30 ++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+), 6 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 1f41ee1..47cd6ea 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -1477,10 +1477,20 @@ sub cmd_commit_diff {
 	}
 }
 
-
 sub cmd_info {
-	my $path = canonicalize_path(defined($_[0]) ? $_[0] : ".");
-	my $fullpath = canonicalize_path($cmd_dir_prefix . $path);
+	my $path_arg = defined($_[0]) ? $_[0] : '.';
+	my $path = $path_arg;
+	if ($path =~ m!\A/!) {
+		my $toplevel = eval {
+			my @cmd = qw/rev-parse --show-toplevel/;
+			command_oneline(\@cmd, STDERR => 0);
+		};
+		$path = canonicalize_path($path);
+		$path =~ s!\A\Q$toplevel\E/?!!;
+		$path = canonicalize_path($path);
+	} else {
+		$path = canonicalize_path($cmd_dir_prefix . $path);
+	}
 	if (exists $_[1]) {
 		die "Too many arguments specified\n";
 	}
@@ -1501,14 +1511,14 @@ sub cmd_info {
 	# canonicalize_path() will return "" to make libsvn 1.5.x happy,
 	$path = "." if $path eq "";
 
-	my $full_url = canonicalize_url( add_path_to_url( $url, $fullpath ) );
+	my $full_url = canonicalize_url( add_path_to_url( $url, $path ) );
 
 	if ($_url) {
 		print "$full_url\n";
 		return;
 	}
 
-	my $result = "Path: $path\n";
+	my $result = "Path: $path_arg\n";
 	$result .= "Name: " . basename($path) . "\n" if $file_type ne "dir";
 	$result .= "URL: $full_url\n";
 
@@ -1539,7 +1549,7 @@ sub cmd_info {
 	}
 
 	my ($lc_author, $lc_rev, $lc_date_utc);
-	my @args = Git::SVN::Log::git_svn_log_cmd($rev, $rev, "--", $fullpath);
+	my @args = Git::SVN::Log::git_svn_log_cmd($rev, $rev, "--", $path);
 	my $log = command_output_pipe(@args);
 	my $esc_color = qr/(?:\033\[(?:(?:\d+;)*\d*)?m)*/;
 	while (<$log>) {
diff --git a/t/t9119-git-svn-info.sh b/t/t9119-git-svn-info.sh
index ff19695..f16f323 100755
--- a/t/t9119-git-svn-info.sh
+++ b/t/t9119-git-svn-info.sh
@@ -74,6 +74,36 @@ test_expect_success 'info .' "
 	test_cmp_info expected.info-dot actual.info-dot
 	"
 
+test_expect_success 'info $(pwd)' '
+	(cd svnwc; svn info "$(pwd)") >expected.info-pwd &&
+	(cd gitwc; git svn info "$(pwd)") >actual.info-pwd &&
+	grep -v ^Path: <expected.info-pwd >expected.info-np &&
+	grep -v ^Path: <actual.info-pwd >actual.info-np &&
+	test_cmp_info expected.info-np actual.info-np &&
+	test "$(sed -ne \"/^Path:/ s!/svnwc!!\" <expected.info-pwd)" = \
+	     "$(sed -ne \"/^Path:/ s!/gitwc!!\" <actual.info-pwd)"
+	'
+
+test_expect_success 'info $(pwd)/../___wc' '
+	(cd svnwc; svn info "$(pwd)/../svnwc") >expected.info-pwd &&
+	(cd gitwc; git svn info "$(pwd)/../gitwc") >actual.info-pwd &&
+	grep -v ^Path: <expected.info-pwd >expected.info-np &&
+	grep -v ^Path: <actual.info-pwd >actual.info-np &&
+	test_cmp_info expected.info-np actual.info-np &&
+	test "$(sed -ne \"/^Path:/ s!/svnwc!!\" <expected.info-pwd)" = \
+	     "$(sed -ne \"/^Path:/ s!/gitwc!!\" <actual.info-pwd)"
+	'
+
+test_expect_success 'info $(pwd)/../___wc//file' '
+	(cd svnwc; svn info "$(pwd)/../svnwc//file") >expected.info-pwd &&
+	(cd gitwc; git svn info "$(pwd)/../gitwc//file") >actual.info-pwd &&
+	grep -v ^Path: <expected.info-pwd >expected.info-np &&
+	grep -v ^Path: <actual.info-pwd >actual.info-np &&
+	test_cmp_info expected.info-np actual.info-np &&
+	test "$(sed -ne \"/^Path:/ s!/svnwc!!\" <expected.info-pwd)" = \
+	     "$(sed -ne \"/^Path:/ s!/gitwc!!\" <actual.info-pwd)"
+	'
+
 test_expect_success 'info --url .' '
 	test "$(cd gitwc; git svn info --url .)" = "$quoted_svnrepo"
 	'
-- 
EW
