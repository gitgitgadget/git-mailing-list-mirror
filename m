Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 959281F4C4
	for <e@80x24.org>; Fri, 18 Oct 2019 05:08:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404906AbfJRFIz (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Oct 2019 01:08:55 -0400
Received: from cloud.peff.net ([104.130.231.41]:51796 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1732067AbfJRFIz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Oct 2019 01:08:55 -0400
Received: (qmail 9312 invoked by uid 109); 18 Oct 2019 04:42:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 18 Oct 2019 04:42:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14035 invoked by uid 111); 18 Oct 2019 04:45:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 18 Oct 2019 00:45:19 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 18 Oct 2019 00:42:13 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 01/23] parse_commit_buffer(): treat lookup_commit() failure
 as parse error
Message-ID: <20191018044212.GA17879@sigill.intra.peff.net>
References: <20191018044103.GA17625@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191018044103.GA17625@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While parsing the parents of a commit, if we are able to parse an actual
oid but lookup_commit() fails on it (because we previously saw it in
this process as a different object type), we silently omit the parent
and do not report any error to the caller.

The caller has no way of knowing this happened, because even an empty
parent list is a valid parse result. As a result, it's possible to fool
our "rev-list" connectivity check into accepting a corrupted set of
objects.

There's a test for this case already in t6102, but unfortunately it has
a slight error. It creates a broken commit with a parent line pointing
to a blob, and then checks that rev-list notices the problem in two
cases:

  1. the "lone" case: we traverse the broken commit by itself (here we
     try to actually load the blob from disk and find out that it's not
     a commit)

  2. the "seen" case: we parse the blob earlier in the process, and then
     when calling lookup_commit() we realize immediately that it's not a
     commit

The "seen" variant for this test mistakenly parsed another commit
instead of the blob, meaning that we were actually just testing the
"lone" case again. Changing that reveals the breakage (and shows that
this fixes it).

Signed-off-by: Jeff King <peff@peff.net>
---
 commit.c                               | 11 ++++++++---
 t/t6102-rev-list-unexpected-objects.sh |  2 +-
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/commit.c b/commit.c
index 40890ae7ce..6467c9e175 100644
--- a/commit.c
+++ b/commit.c
@@ -432,8 +432,11 @@ int parse_commit_buffer(struct repository *r, struct commit *item, const void *b
 		if (graft && (graft->nr_parent < 0 || grafts_replace_parents))
 			continue;
 		new_parent = lookup_commit(r, &parent);
-		if (new_parent)
-			pptr = &commit_list_insert(new_parent, pptr)->next;
+		if (!new_parent)
+			return error("bad parent %s in commit %s",
+				     oid_to_hex(&parent),
+				     oid_to_hex(&item->object.oid));
+		pptr = &commit_list_insert(new_parent, pptr)->next;
 	}
 	if (graft) {
 		int i;
@@ -442,7 +445,9 @@ int parse_commit_buffer(struct repository *r, struct commit *item, const void *b
 			new_parent = lookup_commit(r,
 						   &graft->parent[i]);
 			if (!new_parent)
-				continue;
+				return error("bad graft parent %s in commit %s",
+					     oid_to_hex(&graft->parent[i]),
+					     oid_to_hex(&item->object.oid));
 			pptr = &commit_list_insert(new_parent, pptr)->next;
 		}
 	}
diff --git a/t/t6102-rev-list-unexpected-objects.sh b/t/t6102-rev-list-unexpected-objects.sh
index 28611c978e..52cde097dd 100755
--- a/t/t6102-rev-list-unexpected-objects.sh
+++ b/t/t6102-rev-list-unexpected-objects.sh
@@ -52,7 +52,7 @@ test_expect_success 'traverse unexpected non-commit parent (lone)' '
 '
 
 test_expect_success 'traverse unexpected non-commit parent (seen)' '
-	test_must_fail git rev-list --objects $commit $broken_commit \
+	test_must_fail git rev-list --objects $blob $broken_commit \
 		>output 2>&1 &&
 	test_i18ngrep "not a commit" output
 '
-- 
2.23.0.1228.gee29b05929

