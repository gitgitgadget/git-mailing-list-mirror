Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B767C677F1
	for <git@archiver.kernel.org>; Fri, 24 Feb 2023 06:34:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbjBXGer (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Feb 2023 01:34:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjBXGeq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2023 01:34:46 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78BE51589C
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 22:34:45 -0800 (PST)
Received: (qmail 3649 invoked by uid 109); 24 Feb 2023 06:34:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 24 Feb 2023 06:34:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31044 invoked by uid 111); 24 Feb 2023 06:34:44 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 24 Feb 2023 01:34:44 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 24 Feb 2023 01:34:44 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 01/21] ref-filter: drop unused atom parameter from
 get_worktree_path()
Message-ID: <Y/hahKMhm4EYz3Pf@coredump.intra.peff.net>
References: <Y/habYJxDRJQg/kJ@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y/habYJxDRJQg/kJ@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The get_worktree_path() function is used to populate the %(worktreepath)
value, but it has never used its "atom" parameter since it was added in
2582083fa1 (ref-filter: add worktreepath atom, 2019-04-28).

Normally we'd use the atom struct to cache any work we do, but in this
case there's a global hashmap that does that caching already. So we can
just drop the unused parameter.

Signed-off-by: Jeff King <peff@peff.net>
---
 ref-filter.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index f8203c6b05..434a28c830 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1822,7 +1822,7 @@ static void lazy_init_worktree_map(void)
 	populate_worktree_map(&(ref_to_worktree_map.map), ref_to_worktree_map.worktrees);
 }
 
-static char *get_worktree_path(const struct used_atom *atom, const struct ref_array_item *ref)
+static char *get_worktree_path(const struct ref_array_item *ref)
 {
 	struct hashmap_entry entry, *e;
 	struct ref_to_worktree_entry *lookup_result;
@@ -1881,7 +1881,7 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
 			refname = get_refname(atom, ref);
 		else if (atom_type == ATOM_WORKTREEPATH) {
 			if (ref->kind == FILTER_REFS_BRANCHES)
-				v->s = get_worktree_path(atom, ref);
+				v->s = get_worktree_path(ref);
 			else
 				v->s = xstrdup("");
 			continue;
-- 
2.39.2.981.g6157336f25

