Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4770020195
	for <e@80x24.org>; Wed, 20 Jul 2016 00:47:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752970AbcGTArh (ORCPT <rfc822;e@80x24.org>);
	Tue, 19 Jul 2016 20:47:37 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:35612 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752424AbcGTArf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jul 2016 20:47:35 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 217C920195;
	Wed, 20 Jul 2016 00:47:35 +0000 (UTC)
Date:	Wed, 20 Jul 2016 00:47:34 +0000
From:	Eric Wong <e@80x24.org>
To:	git@vger.kernel.org
Subject: [RFC] git-svn: allow --version to work anywhere
Message-ID: <20160720004734.GA19635@whir>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Checking the version of the installed SVN libraries should not
require a git repository at all.  This matches the behavior of
"git --version".

Add a test for "git svn help" for the same behavior while we're
at it, too.

Signed-off-by: Eric Wong <e@80x24.org>
---
  I'm hoping "cd /" in the test will always succeed;
  but I suppose non-*nix systems might fail, here.

  And maybe a BOFH did "chmod 700 /"	:(

  Anyways this is sitting in master of git://bogomips.org/git-svn.git

 git-svn.perl             | 4 ++--
 t/t9100-git-svn-basic.sh | 8 ++++++++
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index f609e54..4d41d22 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -339,7 +339,7 @@ if ($cmd && $cmd =~ /(?:clone|init|multi-init)$/) {
 			die "failed to open $ENV{GIT_DIR}: $!\n";
 		$ENV{GIT_DIR} = $1 if <$fh> =~ /^gitdir: (.+)$/;
 	}
-} else {
+} elsif ($cmd) {
 	my ($git_dir, $cdup);
 	git_cmd_try {
 		$git_dir = command_oneline([qw/rev-parse --git-dir/]);
@@ -356,7 +356,7 @@ if ($cmd && $cmd =~ /(?:clone|init|multi-init)$/) {
 
 my %opts = %{$cmd{$cmd}->[2]} if (defined $cmd);
 
-read_git_config(\%opts);
+read_git_config(\%opts) if $ENV{GIT_DIR};
 if ($cmd && ($cmd eq 'log' || $cmd eq 'blame')) {
 	Getopt::Long::Configure('pass_through');
 }
diff --git a/t/t9100-git-svn-basic.sh b/t/t9100-git-svn-basic.sh
index 28082b1..10408d0 100755
--- a/t/t9100-git-svn-basic.sh
+++ b/t/t9100-git-svn-basic.sh
@@ -19,6 +19,14 @@ case "$GIT_SVN_LC_ALL" in
 	;;
 esac
 
+test_expect_success 'git svn --version works anywhere' '
+	( cd / || exit 0; git svn --version )
+'
+
+test_expect_success 'git svn help works anywhere' '
+	( cd / || exit 0; git svn help )
+'
+
 test_expect_success \
     'initialize git svn' '
 	mkdir import &&
-- 
EW
