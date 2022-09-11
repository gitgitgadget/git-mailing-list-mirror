Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03A63ECAAA1
	for <git@archiver.kernel.org>; Sun, 11 Sep 2022 05:00:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbiIKFAt (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Sep 2022 01:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiIKFAs (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Sep 2022 01:00:48 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 335142F027
        for <git@vger.kernel.org>; Sat, 10 Sep 2022 22:00:46 -0700 (PDT)
Received: (qmail 18251 invoked by uid 109); 11 Sep 2022 05:00:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 11 Sep 2022 05:00:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31506 invoked by uid 111); 11 Sep 2022 05:00:48 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 11 Sep 2022 01:00:48 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 11 Sep 2022 01:00:45 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>
Subject: [PATCH 2/4] list-objects-filter: handle null default filter spec
Message-ID: <Yx1rfYtQAlZGfAak@coredump.intra.peff.net>
References: <Yx1qwlpNbxGEiUgc@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yx1qwlpNbxGEiUgc@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we have a remote.*.promisor config variable, we know that we're in
a partial clone. Usually there's a matching remote.*.partialclonefilter
option, which tells us which filter to use with the remote. If that
option is missing, we skip setting up the filter at all. But something
funny happens: we stick a NULL entry into the string_list storing the
text filter spec.

This is a weird state, and could possibly segfault if anybody called
called list_objects_filter_spec(), etc. In practice, nobody does,
because filter->choice will still be LOFC_DISABLED, so code generally
realizes there's no filter to use. And the string_list itself is OK,
because it starts in non-dup mode until we actually parse a filter spec.
So it blindly stores the NULL without even looking at it.

But it's probably worth avoiding this confused state. It's an accident
waiting to happen, and it will be a problem if we replace the lazy
initialization from 7e2619d8ff (list_objects_filter_options: plug leak
of filter_spec strings, 2022-09-08) with a real initialization function.

The history is a little interesting here, as the bug was introduced
during the merge resolution in 627b826834 (Merge branch
'md/list-objects-filter-combo', 2019-09-18).

The original logic comes from cac1137dc4 (list-objects: check if filter
is NULL before using, 2018-06-11), where we had a single string via
core.partialCloneFilter, and a simple NULL check was sufficient. And it
even added a test in t0410 that covers this situation.

Later, that was expanded to allow per-remote filters in fa3d1b63e8
(promisor-remote: parse remote.*.partialclonefilter, 2019-06-25). After
that commit, we get a promisor struct with a partial_clone_filter
string, which could be NULL. The commit checks only that the struct
pointer is non-NULL, which is enough. It may pass NULL to
gently_parse_list_objects_filter(), but that function is smart enough to
consider it a noop.

But in parallel, cf9ceb5a12 (list-objects-filter-options: make
filter_spec a string_list, 2019-06-27) added a new line of code: before
we call gently_parse_list_objets_filter(), we append the filter spec to
the string_list. By itself that was OK, since we'd have returned early
if the string was NULL.

When the two were merged in 627b826834, the result is that we return
early only if the struct is NULL, but not the string. And we append to
the string_list, meaning we may append NULL.

The solution is to return early if either is NULL, as it would mean we
don't have a configured filter.

Signed-off-by: Jeff King <peff@peff.net>
---
Sorry, I know it's a long message for a one-line fix! I found the
history of it so interesting, though, because it's rare that I see
bugs introduced during merges.

 list-objects-filter-options.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
index ea989db260..18c51001dc 100644
--- a/list-objects-filter-options.c
+++ b/list-objects-filter-options.c
@@ -399,7 +399,7 @@ void partial_clone_get_default_filter_spec(
 	/*
 	 * Parse default value, but silently ignore it if it is invalid.
 	 */
-	if (!promisor)
+	if (!promisor || !promisor->partial_clone_filter)
 		return;
 
 	string_list_append(&filter_options->filter_spec,
-- 
2.37.3.1242.g835d375f85

