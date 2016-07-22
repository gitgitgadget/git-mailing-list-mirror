Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A7D23203E2
	for <e@80x24.org>; Fri, 22 Jul 2016 20:46:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752909AbcGVUqM (ORCPT <rfc822;e@80x24.org>);
	Fri, 22 Jul 2016 16:46:12 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:48442 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752208AbcGVUqM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jul 2016 16:46:12 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id E52FE203E2;
	Fri, 22 Jul 2016 20:46:10 +0000 (UTC)
Date:	Fri, 22 Jul 2016 20:46:10 +0000
From:	Eric Wong <e@80x24.org>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	git@vger.kernel.org
Subject: [PATCH] git-svn: allow --version to work anywhere
Message-ID: <20160722204610.GA20896@whir>
References: <20160720004734.GA19635@whir>
 <xmqqeg6lbnow.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqeg6lbnow.fsf@gitster.mtv.corp.google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> wrote:
> Eric Wong <e@80x24.org> writes:
> >   I'm hoping "cd /" in the test will always succeed;
> >   but I suppose non-*nix systems might fail, here.
> 
> How about digging a few levels of directory hierarchy, exporting
> GIT_CEILING_DIRECTORIES so that we won't find any repository and
> going there to run these tests?

Ah, thanks; I missed that.

Repushed my master in case it's a convenient time to pull.

The following changes since commit 29493589e97a2de0c4c1c314f61ccafaee3b5caf:

  archive-tar: huge offset and future timestamps would not work on 32-bit (2016-07-15 10:51:55 -0700)

are available in the git repository at:

  git://bogomips.org/git-svn.git master

for you to fetch changes up to c0071ae5dc1c610ab3791ece7ccf7d4772fde151:

  git-svn: allow --version to work anywhere (2016-07-22 20:38:11 +0000)

----------------------------------------------------------------
Eric Wong (2):
      git-svn: document svn.authorsProg in config
      git-svn: allow --version to work anywhere

 Documentation/git-svn.txt |  3 +++
 git-svn.perl              |  4 ++--
 t/t9100-git-svn-basic.sh  | 19 +++++++++++++++++++
 3 files changed, 24 insertions(+), 2 deletions(-)

-----8<-----
Subject: [PATCH] git-svn: allow --version to work anywhere

Checking the version of the installed SVN libraries should not
require a git repository at all.  This matches the behavior of
"git --version".

Add a test for "git svn help" for the same behavior while we're
at it, too.

Signed-off-by: Eric Wong <e@80x24.org>
---
 git-svn.perl             |  4 ++--
 t/t9100-git-svn-basic.sh | 19 +++++++++++++++++++
 2 files changed, 21 insertions(+), 2 deletions(-)

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
index 28082b1..ab6593b 100755
--- a/t/t9100-git-svn-basic.sh
+++ b/t/t9100-git-svn-basic.sh
@@ -19,6 +19,25 @@ case "$GIT_SVN_LC_ALL" in
 	;;
 esac
 
+deepdir=nothing-above
+ceiling=$PWD
+
+test_expect_success 'git svn --version works anywhere' '
+	mkdir -p "$deepdir" && (
+		export GIT_CEILING_DIRECTORIES="$ceiling" &&
+		cd "$deepdir" &&
+		git svn --version
+	)
+'
+
+test_expect_success 'git svn help works anywhere' '
+	mkdir -p "$deepdir" && (
+		export GIT_CEILING_DIRECTORIES="$ceiling" &&
+		cd "$deepdir" &&
+		git svn help
+	)
+'
+
 test_expect_success \
     'initialize git svn' '
 	mkdir import &&
-- 
EW
