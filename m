From: Alex Plotnick <shrike@netaxs.com>
Subject: [PATCH] git-svn: Use git-config --path for pathname-valued variables
Date: Sat, 10 Mar 2012 01:22:23 -0500
Message-ID: <1331360543-11716-1-git-send-email-shrike@netaxs.com>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 10 07:22:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S6FhO-0001Ut-TF
	for gcvg-git-2@plane.gmane.org; Sat, 10 Mar 2012 07:22:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751392Ab2CJGWe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Mar 2012 01:22:34 -0500
Received: from vms173001pub.verizon.net ([206.46.173.1]:28727 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751301Ab2CJGWd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Mar 2012 01:22:33 -0500
Received: from sol.localdomain ([unknown] [108.7.186.97])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0M0N00MH9ODC5LG0@vms173001.mailsrvcs.net> for
 git@vger.kernel.org; Sat, 10 Mar 2012 00:22:25 -0600 (CST)
Received: from sol.localdomain (localhost [127.0.0.1])
	by sol.localdomain (8.14.5/8.14.5) with ESMTP id q2A6MOOx011749; Sat,
 10 Mar 2012 01:22:24 -0500 (EST envelope-from shrike@netaxs.com)
Received: (from alex@localhost)	by sol.localdomain (8.14.5/8.14.5/Submit)
 id q2A6MNvK011748; Sat,
 10 Mar 2012 01:22:23 -0500 (EST envelope-from shrike@netaxs.com)
X-Mailer: git-send-email 1.7.9.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192768>

read_git_config automatically converts Getopt::Long-style option
specs to calls to git-config. It already provided type specifiers
for integer and boolean-valued config variables, but did not
handle pathnames specially. Thus, seemingly reasonable settings
like "svn.authorsfile = ~/svn-authors" could cause commands to
fail since the leading tilde was not expanded.

Because Getopt::Long specs do not provide a specific flag for paths,
we use the heuristic that string-valued options whose names end in
"file" should be treated as pathnames.

This patch also makes it clearer that at most one type specifier
will be used.

Signed-off-by: Alex Plotnick <shrike@netaxs.com>
---
 git-svn.perl                    |    9 +++++++--
 t/t9130-git-svn-authors-file.sh |    5 ++---
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 4334b95..5b065d6 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -1810,8 +1810,13 @@ sub read_git_config {
 		my ($key) = ($o =~ /^([a-zA-Z\-]+)/);
 		$key =~ s/-//g;
 		my $arg = 'git config';
-		$arg .= ' --int' if ($o =~ /[:=]i$/);
-		$arg .= ' --bool' if ($o !~ /[:=][sfi]$/);
+		if ($o =~ /[:=]i$/) {
+			$arg .= ' --int';
+		} elsif ($o !~ /[:=][sfi]$/) {
+			$arg .= ' --bool';
+		} elsif ($o =~ /[:=]s$/ && $key =~ /file$/) {
+			$arg .= ' --path';
+		}
 		if (ref $v eq 'ARRAY') {
 			chomp(my @tmp = `$arg --get-all svn.$key`);
 			@$v = @tmp if @tmp;
diff --git a/t/t9130-git-svn-authors-file.sh b/t/t9130-git-svn-authors-file.sh
index c3443ce..aa50183 100755
--- a/t/t9130-git-svn-authors-file.sh
+++ b/t/t9130-git-svn-authors-file.sh
@@ -98,9 +98,8 @@ test_expect_success 'fresh clone with svn.authors-file in config' '
 		test_config="$HOME"/.gitconfig &&
 		sane_unset GIT_DIR &&
 		sane_unset GIT_CONFIG &&
-		git config --global \
-		  svn.authorsfile "$HOME"/svn-authors &&
-		test x"$HOME"/svn-authors = x"$(git config svn.authorsfile)" &&
+		git config --global svn.authorsfile "~/svn-authors" &&
+		test x"$HOME"/svn-authors = x"$(git config --path svn.authorsfile)" &&
 		git svn clone "$svnrepo" gitconfig.clone &&
 		cd gitconfig.clone &&
 		nr_ex=$(git log | grep "^Author:.*example.com" | wc -l) &&
-- 
1.7.9.2
