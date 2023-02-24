Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 265D9C677F1
	for <git@archiver.kernel.org>; Fri, 24 Feb 2023 06:38:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbjBXGie (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Feb 2023 01:38:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjBXGid (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2023 01:38:33 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C07BC1D92A
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 22:38:31 -0800 (PST)
Received: (qmail 3666 invoked by uid 109); 24 Feb 2023 06:38:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 24 Feb 2023 06:38:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31090 invoked by uid 111); 24 Feb 2023 06:38:30 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 24 Feb 2023 01:38:30 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 24 Feb 2023 01:38:30 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 05/21] object-name: mark unused parameters in disambiguate
 callbacks
Message-ID: <Y/hbZqVZhRyIlFTk@coredump.intra.peff.net>
References: <Y/habYJxDRJQg/kJ@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y/habYJxDRJQg/kJ@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The object-name disambiguation code triggers a callback for each
possible object id we find. This is really used for two purposes:

  - "hint" functions like disambiguate_commit_only report back on
    whether the value is usable

  - iterator functions like repo_for_each_abbrev() use it to collect
    and report matching names.

Compiling with -Wunused-parameter generates several warnings, but
they're distinct for each type. The "hint" functions never look at the
void cb_data pointer; they only care whether the oid matches our hint.
The iterator functions never look at the "struct repository" parameter;
they're just reporting back the oids they see, and always return 0.

So arguably these could be two separate interfaces:

  int (*hint)(struct repository *r, const struct object_id *oid);
  void (*iter)(const struct object_id *oid, void *cb_data);

But doing so would complicate the disambiguation code, which now has to
accept and call the two different types. Since we can easily squelch the
compiler warnings by annotating the functions, let's just do that.

Signed-off-by: Jeff King <peff@peff.net>
---
 object-name.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/object-name.c b/object-name.c
index 2dd1a0f56e..7d1986ad48 100644
--- a/object-name.c
+++ b/object-name.c
@@ -223,15 +223,15 @@ static int finish_object_disambiguation(struct disambiguate_state *ds,
 
 static int disambiguate_commit_only(struct repository *r,
 				    const struct object_id *oid,
-				    void *cb_data_unused)
+				    void *cb_data UNUSED)
 {
 	int kind = oid_object_info(r, oid, NULL);
 	return kind == OBJ_COMMIT;
 }
 
 static int disambiguate_committish_only(struct repository *r,
 					const struct object_id *oid,
-					void *cb_data_unused)
+					void *cb_data UNUSED)
 {
 	struct object *obj;
 	int kind;
@@ -251,15 +251,15 @@ static int disambiguate_committish_only(struct repository *r,
 
 static int disambiguate_tree_only(struct repository *r,
 				  const struct object_id *oid,
-				  void *cb_data_unused)
+				  void *cb_data UNUSED)
 {
 	int kind = oid_object_info(r, oid, NULL);
 	return kind == OBJ_TREE;
 }
 
 static int disambiguate_treeish_only(struct repository *r,
 				     const struct object_id *oid,
-				     void *cb_data_unused)
+				     void *cb_data UNUSED)
 {
 	struct object *obj;
 	int kind;
@@ -279,7 +279,7 @@ static int disambiguate_treeish_only(struct repository *r,
 
 static int disambiguate_blob_only(struct repository *r,
 				  const struct object_id *oid,
-				  void *cb_data_unused)
+				  void *cb_data UNUSED)
 {
 	int kind = oid_object_info(r, oid, NULL);
 	return kind == OBJ_BLOB;
@@ -473,7 +473,7 @@ static int collect_ambiguous(const struct object_id *oid, void *data)
 	return 0;
 }
 
-static int repo_collect_ambiguous(struct repository *r,
+static int repo_collect_ambiguous(struct repository *r UNUSED,
 				  const struct object_id *oid,
 				  void *data)
 {
@@ -665,7 +665,7 @@ static int extend_abbrev_len(const struct object_id *oid, void *cb_data)
 	return 0;
 }
 
-static int repo_extend_abbrev_len(struct repository *r,
+static int repo_extend_abbrev_len(struct repository *r UNUSED,
 				  const struct object_id *oid,
 				  void *cb_data)
 {
-- 
2.39.2.981.g6157336f25

