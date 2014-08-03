From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: doublecheck if really file or dir
Date: Sun, 3 Aug 2014 02:45:20 +0000
Message-ID: <20140803024520.GA12880@dcvr.yhbt.net>
References: <1405657201-32035-1-git-send-email-amanduch@gmail.com>
 <20140723220414.GA14145@dcvr.yhbt.net>
 <53D46812.3020706@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andrej Manduch <amanduch@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 03 04:45:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XDlnZ-00044j-D6
	for gcvg-git-2@plane.gmane.org; Sun, 03 Aug 2014 04:45:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753146AbaHCCpV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Aug 2014 22:45:21 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:51916 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751337AbaHCCpU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Aug 2014 22:45:20 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D1EC1FECA;
	Sun,  3 Aug 2014 02:45:20 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <53D46812.3020706@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254717>

Andrej Manduch <amanduch@gmail.com> wrote:
> On 07/24/2014 12:04 AM, Eric Wong wrote:
> > Andrej Manduch <amanduch@gmail.com> wrote:
> >> * this fixes 'git svn info `pwd`' buggy behaviour
> > 
> > While your patch avoids an error, but the output isn't right, either.
> > I tried it running in /home/ew/ruby, the URL field is bogus:

> Thx, I missed this. However this bug was not introduced with my patch,
> it was there before. If you try use `git svn info full_path` and
> directory is not a root dir this bug will occour even wihout my patch.

Hi Andrej, I could not help thinking your patch was obscuring
another bug.  I think I have an alternative to your patch which
fixes both our bugs.  Can you give this a shot?  Thanks.

--------------------------- 8< ----------------------------
Subject: [PATCH] git svn: info: correctly handle absolute path args

Calling "git svn info $(pwd)" would hit:
  "Reading from filehandle failed at ..."
errors due to improper prefixing and canonicalization.

Strip the toplevel path from absolute filesystem paths to ensure
downstream canonicalization routines are only exposed to paths
tracked in git (or SVN).

Noticed-by: Andrej Manduch <amanduch@gmail.com>
Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 git-svn.perl            | 21 +++++++++++++++------
 t/t9119-git-svn-info.sh | 10 ++++++++++
 2 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 1f41ee1..1f9582b 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -1477,10 +1477,19 @@ sub cmd_commit_diff {
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
+		$path =~ s!\A\Q$toplevel\E/?!!;
+		$path = canonicalize_path($path);
+	} else {
+		$path = canonicalize_path($cmd_dir_prefix . $path);
+	}
 	if (exists $_[1]) {
 		die "Too many arguments specified\n";
 	}
@@ -1501,14 +1510,14 @@ sub cmd_info {
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
 
@@ -1539,7 +1548,7 @@ sub cmd_info {
 	}
 
 	my ($lc_author, $lc_rev, $lc_date_utc);
-	my @args = Git::SVN::Log::git_svn_log_cmd($rev, $rev, "--", $fullpath);
+	my @args = Git::SVN::Log::git_svn_log_cmd($rev, $rev, "--", $path);
 	my $log = command_output_pipe(@args);
 	my $esc_color = qr/(?:\033\[(?:(?:\d+;)*\d*)?m)*/;
 	while (<$log>) {
diff --git a/t/t9119-git-svn-info.sh b/t/t9119-git-svn-info.sh
index ff19695..4f6e669 100755
--- a/t/t9119-git-svn-info.sh
+++ b/t/t9119-git-svn-info.sh
@@ -74,6 +74,16 @@ test_expect_success 'info .' "
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
 test_expect_success 'info --url .' '
 	test "$(cd gitwc; git svn info --url .)" = "$quoted_svnrepo"
 	'
-- 
EW
