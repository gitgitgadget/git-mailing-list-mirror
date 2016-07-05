Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9359D20706
	for <e@80x24.org>; Tue,  5 Jul 2016 19:53:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753756AbcGETxG (ORCPT <rfc822;e@80x24.org>);
	Tue, 5 Jul 2016 15:53:06 -0400
Received: from mta01.prd.rdg.aluminati.org ([94.76.243.214]:39127 "EHLO
	mta01.prd.rdg.aluminati.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751525AbcGETxD (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Jul 2016 15:53:03 -0400
Received: from mta01.prd.rdg.aluminati.org (localhost [127.0.0.1])
	by mta.aluminati.local (Postfix) with ESMTP id 94CC8BF229;
	Tue,  5 Jul 2016 20:53:00 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by mta01.prd.rdg.aluminati.org (Postfix) with ESMTP id 8D99920D0E;
	Tue,  5 Jul 2016 20:53:00 +0100 (BST)
X-Quarantine-ID: <fodDgi_Id9Gi>
X-Virus-Scanned: Debian amavisd-new at mta01.prd.rdg.aluminati.org
Received: from mta.aluminati.local ([127.0.0.1])
	by localhost (mta01.prd.rdg.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id fodDgi_Id9Gi; Tue,  5 Jul 2016 20:52:58 +0100 (BST)
Received: from john.keeping.me.uk (unknown [10.2.0.10])
	by mta01.prd.rdg.aluminati.org (Postfix) with ESMTPSA id 329F95FD8F;
	Tue,  5 Jul 2016 20:52:56 +0100 (BST)
Date:	Tue, 5 Jul 2016 20:52:52 +0100
From:	John Keeping <john@keeping.me.uk>
To:	Bernhard Kirchen <bernhard.kirchen@rwth-aachen.de>
Cc:	git@vger.kernel.org, David Aguilar <davvid@gmail.com>
Subject: [PATCH] difftool: fix argument handling in subdirs
Message-ID: <20160705195252.hzf5hvrcub3g32gg@john.keeping.me.uk>
References: <OFEE90CED0.0832E3D4-ONC1257FE9.0053D856-C1257FE6.00660366@lancom.de>
 <155b7339538.2774.8c011de0e6d4f677db1e190e9d3169b9@rwth-aachen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <155b7339538.2774.8c011de0e6d4f677db1e190e9d3169b9@rwth-aachen.de>
User-Agent: Mutt/1.6.1 (2016-06-11)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Jul 04, 2016 at 08:37:39PM +0200, Bernhard Kirchen wrote:
> Today I started using --dir-diff and noticed a problem when specifying a
> non-full path limiter. My diff tool is setup to be meld (*1).
> 
> OK while working directory is repo root; also OK while working directory is
> repo subfolder "actual":
> git difftool --dir-diff HEAD~1 HEAD -- actual/existing/path
> => meld opens with proper dir-diff.
> 
> NOT OK while working directory is repo subfolder "actual":
> git difftool --dir-diff HEAD~1 HEAD -- existing/path
> => nothing happens, as if using "non/such/path" as the path limiter.
> 
> Because "git diff HEAD~1 HEAD -- existing/path" while the working directory
> is the repo subfolder "actual" works, I epxected the difftool to work
> similarly. Is this a bug?

I think it is, yes.  The patch below fixes it for me and doesn't break
any existing tests, but I still don't understand why the separate
$diffrepo was needed originally, so I'm not certain this won't break
some other corner case.

-- >8 --
When in a subdirectory of a repository, path arguments should be
interpreted relative to the current directory not the root of the
working tree.

The Git::repository object passed into setup_dir_diff() is configured to
handle this correctly but we create a new Git::repository here without
setting the WorkingSubdir argument.  By simply using the existing
repository, path arguments are handled relative to the current
directory.

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 git-difftool.perl | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/git-difftool.perl b/git-difftool.perl
index ebd13ba..c9d3ef8 100755
--- a/git-difftool.perl
+++ b/git-difftool.perl
@@ -115,16 +115,9 @@ sub setup_dir_diff
 {
 	my ($repo, $workdir, $symlinks) = @_;
 
-	# Run the diff; exit immediately if no diff found
-	# 'Repository' and 'WorkingCopy' must be explicitly set to insure that
-	# if $GIT_DIR and $GIT_WORK_TREE are set in ENV, they are actually used
-	# by Git->repository->command*.
 	my $repo_path = $repo->repo_path();
-	my %repo_args = (Repository => $repo_path, WorkingCopy => $workdir);
-	my $diffrepo = Git->repository(%repo_args);
-
 	my @gitargs = ('diff', '--raw', '--no-abbrev', '-z', @ARGV);
-	my $diffrtn = $diffrepo->command_oneline(@gitargs);
+	my $diffrtn = $repo->command_oneline(@gitargs);
 	exit(0) unless defined($diffrtn);
 
 	# Build index info for left and right sides of the diff
@@ -176,12 +169,12 @@ EOF
 
 		if ($lmode eq $symlink_mode) {
 			$symlink{$src_path}{left} =
-				$diffrepo->command_oneline('show', "$lsha1");
+				$repo->command_oneline('show', "$lsha1");
 		}
 
 		if ($rmode eq $symlink_mode) {
 			$symlink{$dst_path}{right} =
-				$diffrepo->command_oneline('show', "$rsha1");
+				$repo->command_oneline('show', "$rsha1");
 		}
 
 		if ($lmode ne $null_mode and $status !~ /^C/) {
-- 
2.9.0.465.g8850cbc

