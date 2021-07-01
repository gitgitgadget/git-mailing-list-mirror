Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C125C11F67
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 21:30:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D32B6140E
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 21:30:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234350AbhGAVdU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jul 2021 17:33:20 -0400
Received: from cloud.peff.net ([104.130.231.41]:39258 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234122AbhGAVdT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jul 2021 17:33:19 -0400
Received: (qmail 28976 invoked by uid 109); 1 Jul 2021 21:30:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 01 Jul 2021 21:30:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19312 invoked by uid 111); 1 Jul 2021 21:30:49 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 01 Jul 2021 17:30:49 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 1 Jul 2021 17:30:47 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Martin Langhoff <martin.langhoff@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Taylor Blau <me@ttaylorr.com>
Subject: [PATCH 2/3] pathspec: turn on tries when appropriate
Message-ID: <YN40B00vK2ul6yMW@coredump.intra.peff.net>
References: <YN4zKVK7gvuIZ0vK@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YN4zKVK7gvuIZ0vK@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

An earlier commit introduced pathspec_tries, but we did not
actually generate them by default. This patch causes us to
do so when it is possible (i.e., when no wildcards or other
pathspec magic are in use). This doesn't actually do
anything yet, though, as none of the pathspec users have
learned to make use of the tries.

We embed the pathspec_trie directly inside the "struct
pathspec". This is not strictly necessary, as once created,
the trie does not depend on the original pathspec. However,
since the intended use is to optimize existing pathspec
callers, passing the trie around as part of the pathspec
will minimize disruption to the call chain.

Signed-off-by: Jeff King <peff@peff.net>
---
 pathspec.c               | 2 ++
 pathspec.h               | 1 +
 t/helper/test-pathspec.c | 6 ++----
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/pathspec.c b/pathspec.c
index 24a24f627e..435dfd3117 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -639,6 +639,8 @@ void parse_pathspec(struct pathspec *pathspec,
 			BUG("PATHSPEC_MAXDEPTH_VALID and PATHSPEC_KEEP_ORDER are incompatible");
 		QSORT(pathspec->items, pathspec->nr, pathspec_item_cmp);
 	}
+
+	pathspec->trie = build_pathspec_trie(pathspec);
 }
 
 void parse_pathspec_file(struct pathspec *pathspec, unsigned magic_mask,
diff --git a/pathspec.h b/pathspec.h
index 15c9244d08..5329c0a6f6 100644
--- a/pathspec.h
+++ b/pathspec.h
@@ -61,6 +61,7 @@ struct pathspec {
 		} *attr_match;
 		struct attr_check *attr_check;
 	} *items;
+	struct pathspec_trie *trie;
 };
 
 #define GUARD_PATHSPEC(ps, mask) \
diff --git a/t/helper/test-pathspec.c b/t/helper/test-pathspec.c
index 3f1b8f1a79..0fb059409b 100644
--- a/t/helper/test-pathspec.c
+++ b/t/helper/test-pathspec.c
@@ -63,7 +63,6 @@ static int cmd_trie(const char **argv)
 {
 	const char **specs, **paths;
 	struct pathspec pathspec;
-	struct pathspec_trie *trie;
 
 	paths = specs = argv;
 	while (*paths && strcmp(*paths, "--"))
@@ -72,12 +71,11 @@ static int cmd_trie(const char **argv)
 		*paths++ = NULL;
 
 	parse_pathspec(&pathspec, 0, 0, "", specs);
-	trie = build_pathspec_trie(&pathspec);
-	if (!trie)
+	if (!pathspec.trie)
 		die("unable to make trie from pathspec");
 
 	for (; *paths; paths++) {
-		if (trie_match(trie, *paths))
+		if (trie_match(pathspec.trie, *paths))
 			printf("yes\n");
 		else
 			printf("no\n");
-- 
2.32.0.359.g3de86e008e.dirty

