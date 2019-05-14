Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 803F91F4B7
	for <e@80x24.org>; Tue, 14 May 2019 13:54:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726044AbfENNy6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 May 2019 09:54:58 -0400
Received: from cloud.peff.net ([104.130.231.41]:57010 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725901AbfENNy6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 May 2019 09:54:58 -0400
Received: (qmail 5313 invoked by uid 109); 14 May 2019 13:54:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 14 May 2019 13:54:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13296 invoked by uid 111); 14 May 2019 13:55:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 14 May 2019 09:55:36 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 14 May 2019 09:54:55 -0400
Date:   Tue, 14 May 2019 09:54:55 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     Eric Wong <e@80x24.org>, Antonio Ospite <ao2@ao2.it>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: [PATCH] get_oid: handle NULL repo->index
Message-ID: <20190514135455.GA17927@sigill.intra.peff.net>
References: <20190511205711.tdclwrdixaau75zv@dcvr>
 <20190511223120.GA25224@sigill.intra.peff.net>
 <20190511230204.GA18474@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190511230204.GA18474@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 11, 2019 at 07:02:05PM -0400, Jeff King wrote:

> But regardless, I think it makes sense to load the index on demand when
> we need it here, which makes Antonio's original test pass (like the
> patch below).
> 
> The segfault ultimately comes from repo_get_oid(); we feed it
> ":.gitmodules" and it blindly looks at repo->index. It's probably worth
> it being a bit more defensive and just returning "no such entry" if
> there's no index to look at (it could also load on demand, I guess, but
> it seems like too low a level to be making that kind of decision).

This turned out to be even simpler than the patch I posted earlier.
After polishing up my submodule-config fix, I looked at teaching
get_oid() to behave differently. And it turns out that it already tries
to load the index on demand! There's just a silly mistake in the code to
check whether the index is already initialized.

Once we fix that, we don't need to handle this specifically in the
submodule code. So here's a simpler, revised patch:

-- >8 --
Subject: [PATCH] get_oid: handle NULL repo->index

When get_oid() and its helpers see an index name like ":.gitmodules",
they try to load the index on demand, like:

  if (repo->index->cache)
	repo_read_index(repo);

However, that misses the case when "repo->index" itself is NULL; we'll
segfault in the conditional.

This never happens with the_repository; there we always point its index
field to &the_index. But a submodule repository may have a NULL index
field until somebody calls repo_read_index().

This bug is triggered by t7411, but it was hard to notice because it's
in an expect_failure block. That test was added by 2b1257e463 (t/helper:
add test-submodule-nested-repo-config, 2018-10-25). Back then we had no
easy way to access the .gitmodules blob of a submodule repo, so we
expected (and got) an error message to that effect. Later, d9b8b8f896
(submodule-config.c: use repo_get_oid for reading .gitmodules,
2019-04-16) started looking in the correct repo, which is when we
started triggering the segfault.

With this fix, the test starts passing (once we clean it up as its
comment instructs).

Note that as far as I know, this bug could not be triggered outside of
the test suite. It requires resolving an index name in a submodule, and
all of the code paths (aside from test-tool) which do that either load
the index themselves, or always pass the_repository.

Ultimately it comes from 3a7a698e93 (sha1-name.c: remove implicit
dependency on the_index, 2019-01-12), which replaced a check of
"the_index.cache" with "repo->index->cache". So even if there is another
way to trigger it, it wouldn't affect any versions before then.

Signed-off-by: Jeff King <peff@peff.net>
---
Arguably this code should just unconditionally call repo_read_index(),
which should be a noop if the index is already loaded. But I wanted to
do the minimal fix here, without getting into any subtle differences
between what checking index->cache versus index->initialized might mean.
Anybody who wants to dig into that is welcome to make a patch on top. :)

I also wondered if we should simply allocate an empty index whenever we
have a non-toplevel "struct repository", which might be less surprising
to other callers. I don't have a strong opinion either way. I did grep
around for other callers which might have similar problems, but couldn't
find any.

 sha1-name.c                 | 2 +-
 t/t7411-submodule-config.sh | 8 ++------
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/sha1-name.c b/sha1-name.c
index 775a73d8ad..455e9fb1ea 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -1837,7 +1837,7 @@ static enum get_oid_result get_oid_with_context_1(struct repository *repo,
 		if (flags & GET_OID_RECORD_PATH)
 			oc->path = xstrdup(cp);
 
-		if (!repo->index->cache)
+		if (!repo->index || !repo->index->cache)
 			repo_read_index(repo);
 		pos = index_name_pos(repo->index, cp, namelen);
 		if (pos < 0)
diff --git a/t/t7411-submodule-config.sh b/t/t7411-submodule-config.sh
index fcc0fb82d8..ad28e93880 100755
--- a/t/t7411-submodule-config.sh
+++ b/t/t7411-submodule-config.sh
@@ -243,18 +243,14 @@ test_expect_success 'reading nested submodules config' '
 	)
 '
 
-# When this test eventually passes, before turning it into
-# test_expect_success, remember to replace the test_i18ngrep below with
-# a "test_must_be_empty warning" to be sure that the warning is actually
-# removed from the code.
-test_expect_failure 'reading nested submodules config when .gitmodules is not in the working tree' '
+test_expect_success 'reading nested submodules config when .gitmodules is not in the working tree' '
 	test_when_finished "git -C super/submodule checkout .gitmodules" &&
 	(cd super &&
 		echo "./nested_submodule" >expect &&
 		rm submodule/.gitmodules &&
 		test-tool submodule-nested-repo-config \
 			submodule submodule.nested_submodule.url >actual 2>warning &&
-		test_i18ngrep "nested submodules without %s in the working tree are not supported yet" warning &&
+		test_must_be_empty warning &&
 		test_cmp expect actual
 	)
 '
-- 
2.21.0.1388.g2b1efd806f

