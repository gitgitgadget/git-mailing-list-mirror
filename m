Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC3D6C433DB
	for <git@archiver.kernel.org>; Fri, 26 Feb 2021 07:12:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 666A164EE3
	for <git@archiver.kernel.org>; Fri, 26 Feb 2021 07:12:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbhBZHMX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Feb 2021 02:12:23 -0500
Received: from cloud.peff.net ([104.130.231.41]:45602 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229990AbhBZHMV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Feb 2021 02:12:21 -0500
Received: (qmail 12232 invoked by uid 109); 26 Feb 2021 07:11:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 26 Feb 2021 07:11:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16804 invoked by uid 111); 26 Feb 2021 07:11:39 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 26 Feb 2021 02:11:39 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 26 Feb 2021 02:11:39 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v2 1/2] t/perf: handle worktrees as test repos
Message-ID: <YDifK3oimeZ4HbJQ@coredump.intra.peff.net>
References: <YDiesofYW18Mzd9Q@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YDiesofYW18Mzd9Q@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The perf suite gets confused when test_perf_default_repo is pointed at a
worktree (which includes when it is run from within a worktree at all,
since the default is to use the current repository).

Here's an example:

  $ git worktree add ~/foo
  Preparing worktree (new branch 'foo')
  HEAD is now at 328c109303 The eighth batch
  $ cd ~/foo
  $ make
  [...build output...]
  $ cd t/perf
  $ ./p0000-perf-lib-sanity.sh -v -i
  [...]
  perf 1 - test_perf_default_repo works:
  running:
  	foo=$(git rev-parse HEAD) &&
  	test_export foo

  fatal: ambiguous argument 'HEAD': unknown revision or path not in the working tree.
  Use '--' to separate paths from revisions, like this:
  'git <command> [<revision>...] -- [<file>...]'

The problem is that we didn't copy all of the necessary files from the
source repository (in this case we got HEAD, but we have no refs!). We
discover the git-dir with "rev-parse --git-dir", but this points to the
worktree's partial repository in .../.git/worktrees/foo.

That partial repository has a "commondir" file which points to the main
repository, where the actual refs are stored, but we don't copy it. This
is the correct thing to do, though! If we did copy it, then our scratch
test repo would be pointing back to the original main repo, and any ref
updates we made in the tests would impact that original repo.

Instead, we need to either:

  1. Make a scratch copy of the original main repo (in addition to the
     worktree repo), and point the scratch worktree repo's commondir at
     it. This preserves the original relationship, but it's doubtful any
     script really cares (if they are testing worktree performance,
     they'd probably make their own worktrees). And it's trickier to get
     right.

  2. Collapse the main and worktree repos into a single scratch repo.
     This can be done by copying everything from both, preferring any
     files from the worktree repo.

This patch does the second one. With this applied, the example above
results in p0000 running successfully.

Reported-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 t/perf/perf-lib.sh | 31 ++++++++++++++++++++++---------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/t/perf/perf-lib.sh b/t/perf/perf-lib.sh
index e385c6896f..1226be4005 100644
--- a/t/perf/perf-lib.sh
+++ b/t/perf/perf-lib.sh
@@ -70,27 +70,40 @@ test_perf_do_repo_symlink_config_ () {
 	test_have_prereq SYMLINKS || git config core.symlinks false
 }
 
+test_perf_copy_repo_contents () {
+	for stuff in "$1"/*
+	do
+		case "$stuff" in
+		*/objects|*/hooks|*/config|*/commondir)
+			;;
+		*)
+			cp -R "$stuff" "$repo/.git/" || exit 1
+			;;
+		esac
+	done
+}
+
 test_perf_create_repo_from () {
 	test "$#" = 2 ||
 	BUG "not 2 parameters to test-create-repo"
 	repo="$1"
 	source="$2"
 	source_git="$("$MODERN_GIT" -C "$source" rev-parse --git-dir)"
 	objects_dir="$("$MODERN_GIT" -C "$source" rev-parse --git-path objects)"
+	common_dir="$("$MODERN_GIT" -C "$source" rev-parse --git-common-dir)"
 	mkdir -p "$repo/.git"
 	(
 		cd "$source" &&
 		{ cp -Rl "$objects_dir" "$repo/.git/" 2>/dev/null ||
 			cp -R "$objects_dir" "$repo/.git/"; } &&
-		for stuff in "$source_git"/*; do
-			case "$stuff" in
-				*/objects|*/hooks|*/config|*/commondir)
-					;;
-				*)
-					cp -R "$stuff" "$repo/.git/" || exit 1
-					;;
-			esac
-		done
+
+		# common_dir must come first here, since we want source_git to
+		# take precedence and overwrite any overlapping files
+		test_perf_copy_repo_contents "$common_dir"
+		if test "$source_git" != "$common_dir"
+		then
+			test_perf_copy_repo_contents "$source_git"
+		fi
 	) &&
 	(
 		cd "$repo" &&
-- 
2.31.0.rc0.520.ge7c5201139

