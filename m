Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5517C5479D
	for <git@archiver.kernel.org>; Fri,  6 Jan 2023 11:04:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231831AbjAFLED (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Jan 2023 06:04:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjAFLD7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jan 2023 06:03:59 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7D586E0D2
        for <git@vger.kernel.org>; Fri,  6 Jan 2023 03:03:58 -0800 (PST)
Received: (qmail 13991 invoked by uid 109); 6 Jan 2023 11:03:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 06 Jan 2023 11:03:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13264 invoked by uid 111); 6 Jan 2023 11:04:03 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 06 Jan 2023 06:04:03 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 6 Jan 2023 06:03:57 -0500
From:   Jeff King <peff@peff.net>
To:     Carl Baldwin <carl@ecbaldwin.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 1/3] diff: use filespec path to set up tempfiles for ext-diff
Message-ID: <Y7gAHenwmIo4gXTb@coredump.intra.peff.net>
References: <Y7f/YiVu1TgbucDI@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y7f/YiVu1TgbucDI@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we're going to run an external diff, we have to make the contents
of the pre- and post-images available either by dumping them to a
tempfile, or by pointing at a valid file in the worktree. The logic of
this is all handled by prepare_temp_file(), and we just pass in the
filename and the diff_filespec.

But there's a gotcha here. The "filename" we have is a logical filename
and not necessarily a path on disk or in the repository. This matters in
at least one case: when using "--relative", we may have a name like
"foo", even though the file content is found at "subdir/foo". As a
result, we look for the wrong path, fail to find "foo", and claim that
the file has been deleted (passing "/dev/null" to the external diff,
rather than the correct worktree path).

We can fix this by passing the pathname from the diff_filespec, which
should always be a full repository path (and that's what we want even if
reusing a worktree file, since we're always operating from the top-level
of the working tree).

The breakage seems to go all the way back to cd676a5136 (diff
--relative: output paths as relative to the current subdirectory,
2008-02-12). As far as I can tell, before then "name" would always have
been the same as the filespec's "path".

There are two related cases I looked at that aren't buggy:

  1. the only other caller of prepare_temp_file() is run_textconv(). But
     it always passes the filespec's path field, so it's OK.

  2. I wondered if file renames/copies might cause similar confusion.
     But they don't, because run_external_diff() receives two names in
     that case: "name" and "other", which correspond to the two sides of
     the diff. And we did correctly pass "other" when handling the
     post-image side. Barring the use of "--relative", that would always
     match "two->path", the path of the second filespec (and the rename
     destination).

So the only bug is just the interaction with external diff drivers and
--relative.

Reported-by: Carl Baldwin <carl@ecbaldwin.net>
Signed-off-by: Jeff King <peff@peff.net>
---
 diff.c                   |  2 +-
 t/t4045-diff-relative.sh | 29 +++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/diff.c b/diff.c
index 9b14543e6e..59039773a1 100644
--- a/diff.c
+++ b/diff.c
@@ -4281,7 +4281,7 @@ static void add_external_diff_name(struct repository *r,
 				   const char *name,
 				   struct diff_filespec *df)
 {
-	struct diff_tempfile *temp = prepare_temp_file(r, name, df);
+	struct diff_tempfile *temp = prepare_temp_file(r, df->path, df);
 	strvec_push(argv, temp->name);
 	strvec_push(argv, temp->hex);
 	strvec_push(argv, temp->mode);
diff --git a/t/t4045-diff-relative.sh b/t/t4045-diff-relative.sh
index 198dfc9190..9b46c4c1be 100755
--- a/t/t4045-diff-relative.sh
+++ b/t/t4045-diff-relative.sh
@@ -164,6 +164,35 @@ check_diff_relative_option subdir file2 true --no-relative --relative
 check_diff_relative_option . file2 false --no-relative --relative=subdir
 check_diff_relative_option . file2 true --no-relative --relative=subdir
 
+test_expect_success 'external diff with --relative' '
+	test_when_finished "git reset --hard" &&
+	echo changed >file1 &&
+	echo changed >subdir/file2 &&
+
+	write_script mydiff <<-\EOF &&
+	# hacky pretend diff; the goal here is just to make sure we got
+	# passed sensible input that we _could_ diff, without relying on
+	# the specific output of a system diff tool.
+	echo "diff a/$1 b/$1" &&
+	echo "--- a/$1" &&
+	echo "+++ b/$1" &&
+	echo "@@ -1 +0,0 @@" &&
+	sed "s/^/-/" "$2" &&
+	sed "s/^/+/" "$5"
+	EOF
+
+	cat >expect <<-\EOF &&
+	diff a/file2 b/file2
+	--- a/file2
+	+++ b/file2
+	@@ -1 +0,0 @@
+	-other content
+	+changed
+	EOF
+	GIT_EXTERNAL_DIFF=./mydiff git diff --relative=subdir >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'setup diff --relative unmerged' '
 	test_commit zero file0 &&
 	test_commit base subdir/file0 &&
-- 
2.39.0.463.g3774f23bc9

