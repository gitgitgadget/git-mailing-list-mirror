Return-Path: <SRS0=KwJF=EL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4068C00A89
	for <git@archiver.kernel.org>; Thu,  5 Nov 2020 13:29:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A57820A8B
	for <git@archiver.kernel.org>; Thu,  5 Nov 2020 13:29:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730666AbgKEN3L (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Nov 2020 08:29:11 -0500
Received: from cloud.peff.net ([104.130.231.41]:48620 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726874AbgKEN3K (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Nov 2020 08:29:10 -0500
Received: (qmail 15796 invoked by uid 109); 5 Nov 2020 13:29:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 05 Nov 2020 13:29:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22665 invoked by uid 111); 5 Nov 2020 13:29:09 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 05 Nov 2020 08:29:09 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 5 Nov 2020 08:29:09 -0500
From:   Jeff King <peff@peff.net>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v4 00/13] Add struct strmap and associated utility
 functions
Message-ID: <20201105132909.GB91972@coredump.intra.peff.net>
References: <pull.835.v3.git.git.1604343313.gitgitgadget@gmail.com>
 <pull.835.v4.git.git.1604535765.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.835.v4.git.git.1604535765.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 05, 2020 at 12:22:32AM +0000, Elijah Newren via GitGitGadget wrote:

> Changes since v3 (almost all of which were suggestions from Peff):
> 
>  * Fix pointer math due to platform differences in FLEX_ALLOC definition,
>    and a few other FLEXPTR_ALLOC_STR cleanups
>  * Define strmap_for_each_entry in terms of hashmap_for_each_entry instead
>    of lower level functions
>  * Use simpler _INIT macros
>  * Remove strset_check_and_add() from API as per Peff's suggestion
>    (merge-ort doesn't need it; we can add it later)
>  * Update comments and commit messages to update now obsolete statements due
>    to changes from earlier reviews

Thanks, this version looks good to me.

I think we might as well do this on top now:

-- >8 --
Subject: [PATCH] shortlog: drop custom strset implementation

We can use the strset recently added in strmap.h instead. Note that this
doesn't have a "check_and_add" function. We can easily write the same
thing using separate "contains" and "adds" calls. This is slightly less
efficient, in that it hashes the string twice, but for our use here it
shouldn't be a big deal either way.

I did leave it as a separate helper function, though, since we use it in
three separate spots (some of which are in the middle of a conditional).

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/shortlog.c | 59 ++++++----------------------------------------
 1 file changed, 7 insertions(+), 52 deletions(-)

diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index 83f0a739b4..2d036ceec2 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -10,6 +10,7 @@
 #include "shortlog.h"
 #include "parse-options.h"
 #include "trailer.h"
+#include "strmap.h"
 
 static char const * const shortlog_usage[] = {
 	N_("git shortlog [<options>] [<revision-range>] [[--] <path>...]"),
@@ -169,60 +170,14 @@ static void read_from_stdin(struct shortlog *log)
 	strbuf_release(&oneline);
 }
 
-struct strset_item {
-	struct hashmap_entry ent;
-	char value[FLEX_ARRAY];
-};
-
-struct strset {
-	struct hashmap map;
-};
-
-#define STRSET_INIT { { NULL } }
-
-static int strset_item_hashcmp(const void *hash_data,
-			       const struct hashmap_entry *entry,
-			       const struct hashmap_entry *entry_or_key,
-			       const void *keydata)
+static int check_dup(struct strset *dups, const char *str)
 {
-	const struct strset_item *a, *b;
-
-	a = container_of(entry, const struct strset_item, ent);
-	if (keydata)
-		return strcmp(a->value, keydata);
-
-	b = container_of(entry_or_key, const struct strset_item, ent);
-	return strcmp(a->value, b->value);
-}
-
-/*
- * Adds "str" to the set if it was not already present; returns true if it was
- * already there.
- */
-static int strset_check_and_add(struct strset *ss, const char *str)
-{
-	unsigned int hash = strhash(str);
-	struct strset_item *item;
-
-	if (!ss->map.table)
-		hashmap_init(&ss->map, strset_item_hashcmp, NULL, 0);
-
-	if (hashmap_get_from_hash(&ss->map, hash, str))
+	if (strset_contains(dups, str))
 		return 1;
-
-	FLEX_ALLOC_STR(item, value, str);
-	hashmap_entry_init(&item->ent, hash);
-	hashmap_add(&ss->map, &item->ent);
+	strset_add(dups, str);
 	return 0;
 }
 
-static void strset_clear(struct strset *ss)
-{
-	if (!ss->map.table)
-		return;
-	hashmap_clear_and_free(&ss->map, struct strset_item, ent);
-}
-
 static void insert_records_from_trailers(struct shortlog *log,
 					 struct strset *dups,
 					 struct commit *commit,
@@ -253,7 +208,7 @@ static void insert_records_from_trailers(struct shortlog *log,
 		if (!parse_ident(log, &ident, value))
 			value = ident.buf;
 
-		if (strset_check_and_add(dups, value))
+		if (check_dup(dups, value))
 			continue;
 		insert_one_record(log, value, oneline);
 	}
@@ -291,7 +246,7 @@ void shortlog_add_commit(struct shortlog *log, struct commit *commit)
 				      log->email ? "%aN <%aE>" : "%aN",
 				      &ident, &ctx);
 		if (!HAS_MULTI_BITS(log->groups) ||
-		    !strset_check_and_add(&dups, ident.buf))
+		    !check_dup(&dups, ident.buf))
 			insert_one_record(log, ident.buf, oneline_str);
 	}
 	if (log->groups & SHORTLOG_GROUP_COMMITTER) {
@@ -300,7 +255,7 @@ void shortlog_add_commit(struct shortlog *log, struct commit *commit)
 				      log->email ? "%cN <%cE>" : "%cN",
 				      &ident, &ctx);
 		if (!HAS_MULTI_BITS(log->groups) ||
-		    !strset_check_and_add(&dups, ident.buf))
+		    !check_dup(&dups, ident.buf))
 			insert_one_record(log, ident.buf, oneline_str);
 	}
 	if (log->groups & SHORTLOG_GROUP_TRAILER) {
-- 
2.29.2.575.gb51baa09ad

