Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B665F1F4C4
	for <e@80x24.org>; Fri, 18 Oct 2019 04:58:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407184AbfJRE6B (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Oct 2019 00:58:01 -0400
Received: from cloud.peff.net ([104.130.231.41]:51710 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1730688AbfJRE6B (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Oct 2019 00:58:01 -0400
Received: (qmail 9373 invoked by uid 109); 18 Oct 2019 04:51:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 18 Oct 2019 04:51:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14065 invoked by uid 111); 18 Oct 2019 04:54:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 18 Oct 2019 00:54:25 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 18 Oct 2019 00:51:19 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 07/23] fsck: stop checking tag->tagged
Message-ID: <20191018045118.GG17879@sigill.intra.peff.net>
References: <20191018044103.GA17625@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191018044103.GA17625@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Way back in 92d4c85d24 (fsck-cache: fix SIGSEGV on bad tag object,
2005-05-03), we added an fsck check that the "tagged" field of a tag
struct isn't NULL. But that was mainly protecting the printing code for
"--tags", and that code wasn't moved along with the check as part of
ba002f3b28 (builtin-fsck: move common object checking code to fsck.c,
2008-02-25).

It could also serve to detect type mismatch problems (where a tag points
to object X as a commit, but really X is a blob), but it couldn't do so
reliably (we'd call lookup_commit(X), but it will only notice the
problem if we happen to have previously called lookup_blob(X) in the
same process). And as of a commit earlier in this series, we'd consider
that a parse error and complain about the object even before getting to
this point anyway.

So let's drop this "tag->tagged" check. It's not helping anything, and
getting rid of it makes the function conceptually cleaner, as it really
is just checking the buffer we feed it. In fact, we can get rid of our
one-line wrapper and just unify fsck_tag() and fsck_tag_buffer().

Signed-off-by: Jeff King <peff@peff.net>
---
 fsck.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/fsck.c b/fsck.c
index a0f8ae7650..79ce3a97c8 100644
--- a/fsck.c
+++ b/fsck.c
@@ -798,8 +798,8 @@ static int fsck_commit(struct commit *commit, const char *data,
 	return ret;
 }
 
-static int fsck_tag_buffer(struct tag *tag, const char *data,
-	unsigned long size, struct fsck_options *options)
+static int fsck_tag(struct tag *tag, const char *data,
+		    unsigned long size, struct fsck_options *options)
 {
 	struct object_id oid;
 	int ret = 0;
@@ -893,17 +893,6 @@ static int fsck_tag_buffer(struct tag *tag, const char *data,
 	return ret;
 }
 
-static int fsck_tag(struct tag *tag, const char *data,
-	unsigned long size, struct fsck_options *options)
-{
-	struct object *tagged = tag->tagged;
-
-	if (!tagged)
-		return report(options, &tag->object, FSCK_MSG_BAD_TAG_OBJECT, "could not load tagged object");
-
-	return fsck_tag_buffer(tag, data, size, options);
-}
-
 struct fsck_gitmodules_data {
 	struct object *obj;
 	struct fsck_options *options;
-- 
2.23.0.1228.gee29b05929

