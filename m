From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 2/1] git-svn: fix URL canonicalization during init w/ SVN 1.7+
Date: Wed, 16 Mar 2016 20:14:08 +0000
Message-ID: <20160316201408.GA22261@dcvr.yhbt.net>
References: <20160316190954.GR29016@dinwoodie.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Michael G. Schwern" <schwern@pobox.com>
To: Adam Dinwoodie <adam@dinwoodie.org>
X-From: git-owner@vger.kernel.org Wed Mar 16 21:14:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agHpf-0001wu-60
	for gcvg-git-2@plane.gmane.org; Wed, 16 Mar 2016 21:14:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967146AbcCPUOI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2016 16:14:08 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:36887 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965623AbcCPUOH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2016 16:14:07 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id F28AE633805;
	Wed, 16 Mar 2016 20:14:06 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20160316190954.GR29016@dinwoodie.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289029>

URL canonicalization when full URLs are passed became broken
when using SVN::_Core::svn_dirent_canonicalize under SVN 1.7.

Ensure we canonicalize paths and URLs with appropriate functions
for each type from now on as the path/URL-agnostic
SVN::_Core::svn_path_canonicalize function is deprecated in SVN.

Tested with the following commands:

  git svn init -T svn://svn.code.sf.net/p/squirrelmail/code/trunk
  git svn init -b svn://svn.code.sf.net/p/squirrelmail/code/branches

Reported-by: Adam Dinwoodie <adam@dinwoodie.org>
  http://mid.gmane.org/20160315162344.GM29016@dinwoodie.org
Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 git-svn.perl                  | 14 ++++++++------
 t/t9117-git-svn-init-clone.sh |  2 +-
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index fa5f253..05eced0 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -1745,11 +1745,12 @@ sub post_fetch_checkout {
 
 sub complete_svn_url {
 	my ($url, $path) = @_;
-	$path = canonicalize_path($path);
 
-	# If the path is not a URL...
-	if ($path !~ m#^[a-z\+]+://#) {
-		if (!defined $url || $url !~ m#^[a-z\+]+://#) {
+	if ($path =~ m#^[a-z\+]+://#i) { # path is a URL
+		$path = canonicalize_url($path);
+	} else {
+		$path = canonicalize_path($path);
+		if (!defined $url || $url !~ m#^[a-z\+]+://#i) {
 			fatal("E: '$path' is not a complete URL ",
 			      "and a separate URL is not specified");
 		}
@@ -1764,11 +1765,12 @@ sub complete_url_ls_init {
 		print STDERR "W: $switch not specified\n";
 		return;
 	}
-	$repo_path = canonicalize_path($repo_path);
-	if ($repo_path =~ m#^[a-z\+]+://#) {
+	if ($repo_path =~ m#^[a-z\+]+://#i) {
+		$repo_path = canonicalize_url($repo_path);
 		$ra = Git::SVN::Ra->new($repo_path);
 		$repo_path = '';
 	} else {
+		$repo_path = canonicalize_path($repo_path);
 		$repo_path =~ s#^/+##;
 		unless ($ra) {
 			fatal("E: '$repo_path' is not a complete URL ",
diff --git a/t/t9117-git-svn-init-clone.sh b/t/t9117-git-svn-init-clone.sh
index 2ba003d..69a6750 100755
--- a/t/t9117-git-svn-init-clone.sh
+++ b/t/t9117-git-svn-init-clone.sh
@@ -119,7 +119,7 @@ test_expect_success 'clone with -s/-T/-b/-t and --prefix "" still works' '
 	rm -f warning
 	'
 
-test_expect_failure 'init with -T as a full url works' '
+test_expect_success 'init with -T as a full url works' '
 	test ! -d project &&
 	git svn init -T "$svnrepo"/project/trunk project &&
 	rm -rf project
-- 
EW
