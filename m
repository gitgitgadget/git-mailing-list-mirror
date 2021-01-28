Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99484C433DB
	for <git@archiver.kernel.org>; Thu, 28 Jan 2021 06:13:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 470B664DD6
	for <git@archiver.kernel.org>; Thu, 28 Jan 2021 06:13:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231358AbhA1GNT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jan 2021 01:13:19 -0500
Received: from cloud.peff.net ([104.130.231.41]:41612 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229561AbhA1GNQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jan 2021 01:13:16 -0500
Received: (qmail 9612 invoked by uid 109); 28 Jan 2021 06:12:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 28 Jan 2021 06:12:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25244 invoked by uid 111); 28 Jan 2021 06:12:37 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 28 Jan 2021 01:12:37 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 28 Jan 2021 01:12:35 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 1/6] commit_graft_pos(): take an oid instead of a bare hash
Message-ID: <YBJV07YU1Y+siwZc@coredump.intra.peff.net>
References: <YBJVuckmbGriVa//@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YBJVuckmbGriVa//@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

All of our callers have an object_id, and are just dereferencing the
hash field to pass to us. Let's take the actual object_id instead. We
still access the hash to pass to hash_pos, but it's a step in the right
direction.

This makes the callers slightly simpler, but also gets rid of the
untyped pointer, as well as the now-inaccurate name "sha1".

Signed-off-by: Jeff King <peff@peff.net>
---
I think this one is an obvious cleanup that we'd want whether we go
further in the series or not.

 commit.c  | 8 ++++----
 commit.h  | 2 +-
 shallow.c | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/commit.c b/commit.c
index bab8d5ab07..fa26729ba5 100644
--- a/commit.c
+++ b/commit.c
@@ -111,17 +111,17 @@ static const unsigned char *commit_graft_sha1_access(size_t index, void *table)
 	return commit_graft_table[index]->oid.hash;
 }
 
-int commit_graft_pos(struct repository *r, const unsigned char *sha1)
+int commit_graft_pos(struct repository *r, const struct object_id *oid)
 {
-	return hash_pos(sha1, r->parsed_objects->grafts,
+	return hash_pos(oid->hash, r->parsed_objects->grafts,
 			r->parsed_objects->grafts_nr,
 			commit_graft_sha1_access);
 }
 
 int register_commit_graft(struct repository *r, struct commit_graft *graft,
 			  int ignore_dups)
 {
-	int pos = commit_graft_pos(r, graft->oid.hash);
+	int pos = commit_graft_pos(r, &graft->oid);
 
 	if (0 <= pos) {
 		if (ignore_dups)
@@ -232,7 +232,7 @@ struct commit_graft *lookup_commit_graft(struct repository *r, const struct obje
 {
 	int pos;
 	prepare_commit_graft(r);
-	pos = commit_graft_pos(r, oid->hash);
+	pos = commit_graft_pos(r, oid);
 	if (pos < 0)
 		return NULL;
 	return r->parsed_objects->grafts[pos];
diff --git a/commit.h b/commit.h
index f4e7b0158e..ecacf9ade3 100644
--- a/commit.h
+++ b/commit.h
@@ -239,7 +239,7 @@ typedef int (*each_commit_graft_fn)(const struct commit_graft *, void *);
 
 struct commit_graft *read_graft_line(struct strbuf *line);
 /* commit_graft_pos returns an index into r->parsed_objects->grafts. */
-int commit_graft_pos(struct repository *r, const unsigned char *sha1);
+int commit_graft_pos(struct repository *r, const struct object_id *oid);
 int register_commit_graft(struct repository *r, struct commit_graft *, int);
 void prepare_commit_graft(struct repository *r);
 struct commit_graft *lookup_commit_graft(struct repository *r, const struct object_id *oid);
diff --git a/shallow.c b/shallow.c
index 91b9e1073c..9ed18eb884 100644
--- a/shallow.c
+++ b/shallow.c
@@ -41,7 +41,7 @@ int register_shallow(struct repository *r, const struct object_id *oid)
 
 int unregister_shallow(const struct object_id *oid)
 {
-	int pos = commit_graft_pos(the_repository, oid->hash);
+	int pos = commit_graft_pos(the_repository, oid);
 	if (pos < 0)
 		return -1;
 	if (pos + 1 < the_repository->parsed_objects->grafts_nr)
-- 
2.30.0.758.gfe500d6872

