Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A2ACC38159
	for <git@archiver.kernel.org>; Wed, 18 Jan 2023 20:36:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbjARUg0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Jan 2023 15:36:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbjARUf7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2023 15:35:59 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 346415FD43
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 12:35:54 -0800 (PST)
Received: (qmail 3329 invoked by uid 109); 18 Jan 2023 20:35:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 18 Jan 2023 20:35:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24932 invoked by uid 111); 18 Jan 2023 20:35:55 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 18 Jan 2023 15:35:55 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 18 Jan 2023 15:35:52 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: [PATCH 2/6] t1006: stop using 0-padded timestamps
Message-ID: <Y8hYKD07HulByUcB@coredump.intra.peff.net>
References: <Y8hX+pIZUKXsyYj5@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y8hX+pIZUKXsyYj5@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The fake objects in t1006 use dummy timestamps like "0000000000 +0000".
While this does make them look more like normal timestamps (which,
unless it is 1970, have many digits), it actually violates our fsck
checks, which complain about zero-padded timestamps.

This doesn't currently break anything, but let's future-proof our tests
against a version of hash-object which is a little more careful about
its input. We don't actually care about the exact values here (and in
fact, the helper functions in this script end up removing the timestamps
anyway, so we don't even have to adjust other parts of the tests).

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t1006-cat-file.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index 23b8942edb..2d875b17d8 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -292,8 +292,8 @@ commit_message="Initial commit"
 commit_sha1=$(echo_without_newline "$commit_message" | git commit-tree $tree_sha1)
 commit_size=$(($(test_oid hexsz) + 137))
 commit_content="tree $tree_sha1
-author $GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL> 0000000000 +0000
-committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 0000000000 +0000
+author $GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL> 0 +0000
+committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 0 +0000
 
 $commit_message"
 
@@ -304,7 +304,7 @@ type blob
 tag hellotag
 tagger $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>"
 tag_description="This is a tag"
-tag_content="$tag_header_without_timestamp 0000000000 +0000
+tag_content="$tag_header_without_timestamp 0 +0000
 
 $tag_description"
 
-- 
2.39.1.616.gd06fca9e99

