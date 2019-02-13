Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F9A01F453
	for <e@80x24.org>; Wed, 13 Feb 2019 20:11:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732114AbfBMULW (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Feb 2019 15:11:22 -0500
Received: from cloud.peff.net ([104.130.231.41]:43076 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727049AbfBMULV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Feb 2019 15:11:21 -0500
Received: (qmail 9044 invoked by uid 109); 13 Feb 2019 20:11:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 13 Feb 2019 20:11:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3281 invoked by uid 111); 13 Feb 2019 20:11:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 13 Feb 2019 15:11:31 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 13 Feb 2019 15:11:19 -0500
Date:   Wed, 13 Feb 2019 15:11:19 -0500
From:   Jeff King <peff@peff.net>
To:     Sylvain Lacaze <sylvain@lacaze.me>
Cc:     git@vger.kernel.org
Subject: [PATCH] diff: reuse diff setup for --no-index case
Message-ID: <20190213201118.GA13261@sigill.intra.peff.net>
References: <CAH1FtBpcZJ8V4B=RJ0SfC+kehpmpaBGafDzXvi8i33rc++jOUw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH1FtBpcZJ8V4B=RJ0SfC+kehpmpaBGafDzXvi8i33rc++jOUw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 13, 2019 at 06:50:19PM +0000, Sylvain Lacaze wrote:

> I have “p4merge” setup as diff.tool and merge.tool, and it work great
> in normal operation (i.e., “p4merge” opens), e.g:
> 
> $: git difftool HEAD~3 somePath/someFile.m
> 
> However, when I use “—no-index” to compare 2 arbitrary file, difftool
> just uses diff:
> 
> $: git difftool --no-index somePath/someFile.m somePath/someOtherFile.m
> $: git difftool --no-index --tool=p4merge somePath/someFile.m
> somePath/someOtherFile.m
> 
> Both the above command just yield normal diff.

The root of the problem is that "git diff --no-index" does not enable
external diff tools by default. You can probably make it work by passing
"--no-index --ext-diff".

It seems to me that "git diff --no-index" should generally behave the
same as a regular "git diff" when possible, though. Maybe we should do
something like the patch below?

-- >8 --
Subject: [PATCH] diff: reuse diff setup for --no-index case

When "--no-index" is in effect (or implied by the arguments), git-diff
jumps early to a special code path to perform that diff. This means we
miss out on some settings like enabling --ext-diff and --textconv by
default.

Let's jump to the no-index path _after_ we've done more setup on
rev.diffopt. Some of these options won't affect us either way (e.g.,
items related to the index), but that makes it less likely for these two
paths to diverge again in the future.

Note that we also need to stop re-initializing the diffopt struct in
diff_no_index(). This should not be necessary, as it will already have
been initialized by cmd_diff() (and there are no other callers). That in
turn lets us drop the "repository" argument from diff_no_index (which
never made much sense, since the whole point is that you don't need a
repository).

Signed-off-by: Jeff King <peff@peff.net>
---
Generated with --inter-hunk-context=13 so you can see the actual list of
options.

 builtin/diff.c           | 7 ++++---
 diff-no-index.c          | 8 +-------
 diff.h                   | 2 +-
 t/t4053-diff-no-index.sh | 8 ++++++++
 4 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/builtin/diff.c b/builtin/diff.c
index 9f6109224b..458ce326c8 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -338,28 +338,29 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 		       "--no-index" : "[--no-index]");
 
 	}
-	if (no_index)
-		/* If this is a no-index diff, just run it and exit there. */
-		diff_no_index(the_repository, &rev, argc, argv);
 
 	/* Otherwise, we are doing the usual "git" diff */
 	rev.diffopt.skip_stat_unmatch = !!diff_auto_refresh_index;
 
 	/* Scale to real terminal size and respect statGraphWidth config */
 	rev.diffopt.stat_width = -1;
 	rev.diffopt.stat_graph_width = -1;
 
 	/* Default to let external and textconv be used */
 	rev.diffopt.flags.allow_external = 1;
 	rev.diffopt.flags.allow_textconv = 1;
 
 	/*
 	 * Default to intent-to-add entries invisible in the
 	 * index. This makes them show up as new files in diff-files
 	 * and not at all in diff-cached.
 	 */
 	rev.diffopt.ita_invisible_in_index = 1;
 
+	if (no_index)
+		/* If this is a no-index diff, just run it and exit there. */
+		diff_no_index(&rev, argc, argv);
+
 	if (nongit)
 		die(_("Not a git repository"));
 	argc = setup_revisions(argc, argv, &rev, NULL);
diff --git a/diff-no-index.c b/diff-no-index.c
index 9414e922d1..6001baecd4 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -233,20 +233,14 @@ static void fixup_paths(const char **path, struct strbuf *replacement)
 	}
 }
 
-void diff_no_index(struct repository *r,
-		   struct rev_info *revs,
+void diff_no_index(struct rev_info *revs,
 		   int argc, const char **argv)
 {
 	int i;
 	const char *paths[2];
 	struct strbuf replacement = STRBUF_INIT;
 	const char *prefix = revs->prefix;
 
-	/*
-	 * FIXME: --no-index should not look at index and we should be
-	 * able to pass NULL repo. Maybe later.
-	 */
-	repo_diff_setup(r, &revs->diffopt);
 	for (i = 1; i < argc - 2; ) {
 		int j;
 		if (!strcmp(argv[i], "--no-index"))
diff --git a/diff.h b/diff.h
index b512d0477a..a01e03985a 100644
--- a/diff.h
+++ b/diff.h
@@ -435,7 +435,7 @@ int diff_flush_patch_id(struct diff_options *, struct object_id *, int);
 
 int diff_result_code(struct diff_options *, int);
 
-void diff_no_index(struct repository *, struct rev_info *, int, const char **);
+void diff_no_index(struct rev_info *, int, const char **);
 
 int index_differs_from(struct repository *r, const char *def,
 		       const struct diff_flags *flags,
diff --git a/t/t4053-diff-no-index.sh b/t/t4053-diff-no-index.sh
index 6e0dd6f9e5..4331b3118a 100755
--- a/t/t4053-diff-no-index.sh
+++ b/t/t4053-diff-no-index.sh
@@ -137,4 +137,12 @@ test_expect_success 'diff --no-index from repo subdir with absolute paths' '
 	test_cmp expect actual
 '
 
+test_expect_success 'diff --no-index allows external diff' '
+	test_expect_code 1 \
+		env GIT_EXTERNAL_DIFF="echo external ;:" \
+		git diff --no-index non/git/a non/git/b >actual &&
+	echo external >expect &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.21.0.rc0.586.gffba1126a0

