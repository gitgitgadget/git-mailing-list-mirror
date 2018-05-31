Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C34EB1F42D
	for <e@80x24.org>; Thu, 31 May 2018 22:42:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750794AbeEaWmz (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 May 2018 18:42:55 -0400
Received: from cloud.peff.net ([104.130.231.41]:58488 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750766AbeEaWmz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 May 2018 18:42:55 -0400
Received: (qmail 23852 invoked by uid 109); 31 May 2018 22:42:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 31 May 2018 22:42:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18359 invoked by uid 111); 31 May 2018 22:43:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 31 May 2018 18:43:06 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 31 May 2018 18:42:53 -0400
Date:   Thu, 31 May 2018 18:42:53 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 1/2] prepare_commit_graft: treat non-repository as a noop
Message-ID: <20180531224252.GA13127@sigill.intra.peff.net>
References: <20180531223901.GA18999@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180531223901.GA18999@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The parse_commit_buffer() function consults lookup_commit_graft()
to see if we need to rewrite parents. The latter will look
at $GIT_DIR/info/grafts. If you're outside of a repository,
then this will trigger a BUG() as of b1ef400eec (setup_git_env:
avoid blind fall-back to ".git", 2016-10-20).

It's probably uncommon to actually parse a commit outside of
a repository, but you can see it in action with:

  cd /not/a/git/repo
  git index-pack --strict /some/file.pack

This works fine without --strict, but the fsck checks will
try to parse any commits, triggering the BUG(). We can fix
that by teaching the graft code to behave as if there are no
grafts when we aren't in a repository.

Arguably index-pack (and fsck) are wrong to consider grafts
at all. So another solution is to disable grafts entirely
for those commands. But given that the graft feature is
deprecated anyway, it's not worth even thinking through the
ramifications that might have.

There is one other corner case I considered here. What
should:

  cd /not/a/git/repo
  export GIT_GRAFT_FILE=/file/with/grafts
  git index-pack --strict /some/file.pack

do? We don't have a repository, but the user has pointed us
directly at a graft file, which we could respect. I believe
this case did work that way prior to b1ef400eec. However,
fixing it now would be pretty invasive. Back then we would
just call into setup_git_env() even without a repository.
But these days it actually takes a git_dir argument. So
there would be a fair bit of refactoring of the setup code
involved.

Given the obscurity of this case, plus the fact that grafts
are deprecated and probably shouldn't work under index-pack
anyway, it's not worth pursuing further. This patch at least
un-breaks the common case where you're _not_ using grafts,
but we BUG() anyway trying to even find that out.

Signed-off-by: Jeff King <peff@peff.net>
---
 commit.c               | 3 +++
 t/t5300-pack-object.sh | 6 ++++++
 2 files changed, 9 insertions(+)

diff --git a/commit.c b/commit.c
index b0e57cc440..0030e79940 100644
--- a/commit.c
+++ b/commit.c
@@ -207,6 +207,9 @@ static void prepare_commit_graft(void)
 
 	if (commit_graft_prepared)
 		return;
+	if (!startup_info->have_repository)
+		return;
+
 	graft_file = get_graft_file();
 	read_graft_file(graft_file);
 	/* make sure shallows are read */
diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index 87a590c4a9..2336d09dcc 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -421,6 +421,12 @@ test_expect_success 'index-pack <pack> works in non-repo' '
 	test_path_is_file foo.idx
 '
 
+test_expect_success 'index-pack --strict <pack> works in non-repo' '
+	rm -f foo.idx &&
+	nongit git index-pack --strict ../foo.pack &&
+	test_path_is_file foo.idx
+'
+
 test_expect_success !PTHREADS,C_LOCALE_OUTPUT 'index-pack --threads=N or pack.threads=N warns when no pthreads' '
 	test_must_fail git index-pack --threads=2 2>err &&
 	grep ^warning: err >warnings &&
-- 
2.17.1.1443.gd58a3f03b7

