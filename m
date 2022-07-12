Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D59DFCCA47C
	for <git@archiver.kernel.org>; Tue, 12 Jul 2022 07:04:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232329AbiGLHEG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jul 2022 03:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232285AbiGLHDx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jul 2022 03:03:53 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 040361D0EA
        for <git@vger.kernel.org>; Tue, 12 Jul 2022 00:03:46 -0700 (PDT)
Received: (qmail 10490 invoked by uid 109); 12 Jul 2022 07:03:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 12 Jul 2022 07:03:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27804 invoked by uid 111); 12 Jul 2022 07:03:45 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 12 Jul 2022 03:03:45 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 12 Jul 2022 03:03:45 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH] diff-files: move misplaced cleanup label
Message-ID: <Ys0c0ePxPOqZ/5ck@coredump.intra.peff.net>
References: <cover-v5-00.27-00000000000-20220402T102002Z-avarab@gmail.com>
 <cover-v6-00.27-00000000000-20220413T195935Z-avarab@gmail.com>
 <patch-v6-11.27-e93791b6242-20220413T195935Z-avarab@gmail.com>
 <YsxmrRCSpze1csHz@coredump.intra.peff.net>
 <220711.86tu7n5ryf.gmgdl@evledraar.gmail.com>
 <Ys0at7pMPUrrmEaB@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Ys0at7pMPUrrmEaB@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Commit 0139c58ab9 (revisions API users: add "goto cleanup" for
release_revisions(), 2022-04-13) converted an early return in
cmd_diff_files() into a goto. But it put the cleanup label too early: if
read_cache_preload() returns an error, we'll set result to "-1", but
then jump to calling run_diff_files(), overwriting our result.

We should jump past the call to run_diff_files(). Likewise, we should go
past diff_result_code(), which is expecting to see a code from an actual
diff, not a negative error code.

In practice, I suspect this bug cannot actually be triggered, because
read_cache_preload() does not seem to ever return an error. Its return
value (eventually) comes from do_read_index(), which gives the number of
cache entries found, and calls die() on error. Still, it makes sense to
fix the inadvertent change from 0139c58ab9 first, and we can look into
the overall error handling of read_cache() separately (which is present
in many other callsites).

Signed-off-by: Jeff King <peff@peff.net>
---
This is on top of ab/plug-leak-in-revisions, though it's long since
graduated to master.

The read_cache() thing is weird. The error checking was introduced back
in 6304c29d51 (diff-files: do not play --no-index games, 2008-05-23).
And even back then, I don't see it ever returning -1. Yet then, as well
as now, running "git grep 'read_cache.*< 0'" turns up many hits. So I'm
not sure if I'm missing a case, or if it's cargo-culting gone wild.

Still, I don't plan to dig further into it anytime soon. Removing the
error handling from those sites is relatively low reward, with high risk
for introducing a bug.

 builtin/diff-files.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/diff-files.c b/builtin/diff-files.c
index 2bfaf9ba7a..92cf6e1e92 100644
--- a/builtin/diff-files.c
+++ b/builtin/diff-files.c
@@ -80,9 +80,9 @@ int cmd_diff_files(int argc, const char **argv, const char *prefix)
 		result = -1;
 		goto cleanup;
 	}
-cleanup:
 	result = run_diff_files(&rev, options);
 	result = diff_result_code(&rev.diffopt, result);
+cleanup:
 	release_revisions(&rev);
 	return result;
 }
-- 
2.37.0.497.g676cb53800

