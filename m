From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] git-svn: shorten glob error message
Date: Thu, 14 Jan 2016 04:07:59 +0000
Message-ID: <20160114040759.GA7671@dcvr.yhbt.net>
References: <1452522358-16943-1-git-send-email-vleschuk@accesssoftek.com>
 <20160113031601.GA28224@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, vleschuk@accesssoftek.com,
	Victor Leschuk <vleschuk@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 14 05:08:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJZDB-0003Qw-I7
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jan 2016 05:08:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751402AbcANEID (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2016 23:08:03 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:54281 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750847AbcANEIB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2016 23:08:01 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF7221FD21;
	Thu, 14 Jan 2016 04:07:59 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20160113031601.GA28224@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284016>

Error messages should attempt to fit within the confines of
an 80-column terminal to avoid compatibility and accessibility
problems.  Furthermore the word "directories" can be misleading
when used in the context of git refnames.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
  Eric Wong <normalperson@yhbt.net> wrote:
  > I also noticed the "Only one set of wildcard directories" error
  > message is unnecessary long and "wildcard directories" should
  > probably be shortened to "wildcards" to avoid wrapping in a terminal.
  > That will probably be a separate patch for me.

  There's likely more instances of this in git-svn, but I figured
  we'll get this one fixed, first.

  Also pushed to bogomips.org/git-svn.git
  (commit dc6aa7e61e9d33856f54d63b7acb518383420373)
  along with Victor's patch.

 perl/Git/SVN/GlobSpec.pm                   | 4 ++--
 t/t9108-git-svn-glob.sh                    | 9 ++++++---
 t/t9109-git-svn-multi-glob.sh              | 9 ++++++---
 t/t9168-git-svn-partially-globbed-names.sh | 7 ++++---
 4 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/perl/Git/SVN/GlobSpec.pm b/perl/Git/SVN/GlobSpec.pm
index 4775026..a0a8d17 100644
--- a/perl/Git/SVN/GlobSpec.pm
+++ b/perl/Git/SVN/GlobSpec.pm
@@ -8,8 +8,8 @@ sub new {
 	$re =~ s!/+$!!g; # no need for trailing slashes
 	my (@left, @right, @patterns);
 	my $state = "left";
-	my $die_msg = "Only one set of wildcard directories " .
-				"(e.g. '*' or '*/*/*') is supported: '$glob'\n";
+	my $die_msg = "Only one set of wildcards " .
+				"(e.g. '*' or '*/*/*') is supported: $glob\n";
 	for my $part (split(m|/|, $glob)) {
 		if ($pattern_ok && $part =~ /[{}]/ &&
 			 $part !~ /^\{[^{}]+\}/) {
diff --git a/t/t9108-git-svn-glob.sh b/t/t9108-git-svn-glob.sh
index d732d31..29b363b 100755
--- a/t/t9108-git-svn-glob.sh
+++ b/t/t9108-git-svn-glob.sh
@@ -86,9 +86,12 @@ test_expect_success 'test left-hand-side only globbing' '
 	test_cmp expect.two output.two
 	'
 
-echo "Only one set of wildcard directories" \
-     "(e.g. '*' or '*/*/*') is supported: 'branches/*/t/*'" > expect.three
-echo "" >> expect.three
+test_expect_success 'prepare test disallow multi-globs' "
+cat >expect.three <<EOF
+Only one set of wildcards (e.g. '*' or '*/*/*') is supported: branches/*/t/*
+
+EOF
+	"
 
 test_expect_success 'test disallow multi-globs' '
 	git config --add svn-remote.three.url "$svnrepo" &&
diff --git a/t/t9109-git-svn-multi-glob.sh b/t/t9109-git-svn-multi-glob.sh
index c318f9f..d0b79fe 100755
--- a/t/t9109-git-svn-multi-glob.sh
+++ b/t/t9109-git-svn-multi-glob.sh
@@ -135,9 +135,12 @@ test_expect_success 'test another branch' '
 	test_cmp expect.four output.four
 	'
 
-echo "Only one set of wildcard directories" \
-     "(e.g. '*' or '*/*/*') is supported: 'branches/*/t/*'" > expect.three
-echo "" >> expect.three
+test_expect_success 'prepare test disallow multiple globs' "
+cat >expect.three <<EOF
+Only one set of wildcards (e.g. '*' or '*/*/*') is supported: branches/*/t/*
+
+EOF
+	"
 
 test_expect_success 'test disallow multiple globs' '
 	git config --add svn-remote.three.url "$svnrepo" &&
diff --git a/t/t9168-git-svn-partially-globbed-names.sh b/t/t9168-git-svn-partially-globbed-names.sh
index a7641dc..8b22f22 100755
--- a/t/t9168-git-svn-partially-globbed-names.sh
+++ b/t/t9168-git-svn-partially-globbed-names.sh
@@ -130,9 +130,10 @@ test_expect_success 'test prefixed globs match just prefix' '
 	'
 
 test_expect_success 'prepare test disallow prefixed multi-globs' "
-	echo \"Only one set of wildcard directories\" \
-	     \"(e.g. '*' or '*/*/*') is supported: 'branches/b_*/t/*'\" >expect.four &&
-	echo \"\" >>expect.four
+cat >expect.four <<EOF
+Only one set of wildcards (e.g. '*' or '*/*/*') is supported: branches/b_*/t/*
+
+EOF
 	"
 
 test_expect_success 'test disallow prefixed multi-globs' '
-- 
EW
