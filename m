Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C942FC32771
	for <git@archiver.kernel.org>; Fri, 19 Aug 2022 10:08:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348307AbiHSKIl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Aug 2022 06:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348275AbiHSKIi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2022 06:08:38 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8072DBD2
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 03:08:36 -0700 (PDT)
Received: (qmail 17663 invoked by uid 109); 19 Aug 2022 10:08:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 19 Aug 2022 10:08:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 925 invoked by uid 111); 19 Aug 2022 10:08:38 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 19 Aug 2022 06:08:38 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 19 Aug 2022 06:08:35 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 03/11] refs: mark unused reflog callback parameters
Message-ID: <Yv9hIzQRuxlOUi3F@coredump.intra.peff.net>
References: <Yv9gxqH6nK2KYnNj@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yv9gxqH6nK2KYnNj@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Functions used with for_each_reflog_ent() need to conform to a
particular interface, but not every function needs all of the
parameters. Mark the unused ones to make -Wunused-parameter happy.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/fsck.c            |  5 +++--
 builtin/stash.c           |  9 ++++++---
 commit.c                  |  5 +++--
 object-name.c             |  7 +++++--
 reflog.c                  | 13 ++++++++-----
 refs.c                    | 10 ++++++----
 remote.c                  | 15 +++++++++------
 revision.c                |  7 +++++--
 t/helper/test-ref-store.c |  2 +-
 wt-status.c               | 14 +++++++++-----
 10 files changed, 55 insertions(+), 32 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 36f1524614..31d3da8954 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -488,8 +488,9 @@ static void fsck_handle_reflog_oid(const char *refname, struct object_id *oid,
 }
 
 static int fsck_handle_reflog_ent(struct object_id *ooid, struct object_id *noid,
-		const char *email, timestamp_t timestamp, int tz,
-		const char *message, void *cb_data)
+				  const char *UNUSED(email),
+				  timestamp_t timestamp, int UNUSED(tz),
+				  const char *UNUSED(message), void *cb_data)
 {
 	const char *refname = cb_data;
 
diff --git a/builtin/stash.c b/builtin/stash.c
index 30fa101460..a741b920b3 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -638,9 +638,12 @@ static int apply_stash(int argc, const char **argv, const char *prefix)
 	return ret;
 }
 
-static int reject_reflog_ent(struct object_id *ooid, struct object_id *noid,
-			     const char *email, timestamp_t timestamp, int tz,
-			     const char *message, void *cb_data)
+static int reject_reflog_ent(struct object_id *UNUSED(ooid),
+			     struct object_id *UNUSED(noid),
+			     const char *UNUSED(email),
+			     timestamp_t UNUSED(timestamp),
+			     int UNUSED(tz), const char *UNUSED(message),
+			     void *UNUSED(cb_data))
 {
 	return 1;
 }
diff --git a/commit.c b/commit.c
index 0db461f973..cb20082736 100644
--- a/commit.c
+++ b/commit.c
@@ -951,8 +951,9 @@ static void add_one_commit(struct object_id *oid, struct rev_collect *revs)
 }
 
 static int collect_one_reflog_ent(struct object_id *ooid, struct object_id *noid,
-				  const char *ident, timestamp_t timestamp,
-				  int tz, const char *message, void *cbdata)
+				  const char *UNUSED(ident),
+				  timestamp_t UNUSED(timestamp), int UNUSED(tz),
+				  const char *UNUSED(message), void *cbdata)
 {
 	struct rev_collect *revs = cbdata;
 
diff --git a/object-name.c b/object-name.c
index 052644977e..3f7fce8322 100644
--- a/object-name.c
+++ b/object-name.c
@@ -1385,8 +1385,11 @@ struct grab_nth_branch_switch_cbdata {
 	struct strbuf *sb;
 };
 
-static int grab_nth_branch_switch(struct object_id *ooid, struct object_id *noid,
-				  const char *email, timestamp_t timestamp, int tz,
+static int grab_nth_branch_switch(struct object_id *UNUSED(ooid),
+				  struct object_id *UNUSED(noid),
+				  const char *UNUSED(email),
+				  timestamp_t UNUSED(timestamp),
+				  int UNUSED(tz),
 				  const char *message, void *cb_data)
 {
 	struct grab_nth_branch_switch_cbdata *cb = cb_data;
diff --git a/reflog.c b/reflog.c
index ee8aaa78f5..56ea3ba762 100644
--- a/reflog.c
+++ b/reflog.c
@@ -240,8 +240,9 @@ static int unreachable(struct expire_reflog_policy_cb *cb, struct commit *commit
  * Return true iff the specified reflog entry should be expired.
  */
 int should_expire_reflog_ent(struct object_id *ooid, struct object_id *noid,
-			     const char *email, timestamp_t timestamp, int tz,
-			     const char *message, void *cb_data)
+			     const char *UNUSED(email),
+			     timestamp_t timestamp, int UNUSED(tz),
+			     const char *UNUSED(message), void *cb_data)
 {
 	struct expire_reflog_policy_cb *cb = cb_data;
 	struct commit *old_commit, *new_commit;
@@ -379,9 +380,11 @@ void reflog_expiry_cleanup(void *cb_data)
 	}
 }
 
-int count_reflog_ent(struct object_id *ooid, struct object_id *noid,
-		     const char *email, timestamp_t timestamp, int tz,
-		     const char *message, void *cb_data)
+int count_reflog_ent(struct object_id *UNUSED(ooid),
+		     struct object_id *UNUSED(noid),
+		     const char *UNUSED(email),
+		     timestamp_t timestamp, int UNUSED(tz),
+		     const char *UNUSED(message), void *cb_data)
 {
 	struct cmd_reflog_expire_cb *cb = cb_data;
 	if (!cb->expire_total || timestamp < cb->expire_total)
diff --git a/refs.c b/refs.c
index 34373e8087..38b1165189 100644
--- a/refs.c
+++ b/refs.c
@@ -894,8 +894,9 @@ static void set_read_ref_cutoffs(struct read_ref_at_cb *cb,
 }
 
 static int read_ref_at_ent(struct object_id *ooid, struct object_id *noid,
-		const char *email, timestamp_t timestamp, int tz,
-		const char *message, void *cb_data)
+			   const char *UNUSED(email),
+			   timestamp_t timestamp, int tz,
+			   const char *message, void *cb_data)
 {
 	struct read_ref_at_cb *cb = cb_data;
 	int reached_count;
@@ -950,8 +951,9 @@ static int read_ref_at_ent_newest(struct object_id *UNUSED(ooid),
 }
 
 static int read_ref_at_ent_oldest(struct object_id *ooid, struct object_id *noid,
-				  const char *email, timestamp_t timestamp,
-				  int tz, const char *message, void *cb_data)
+				  const char *UNUSED(email),
+				  timestamp_t timestamp, int tz,
+				  const char *message, void *cb_data)
 {
 	struct read_ref_at_cb *cb = cb_data;
 
diff --git a/remote.c b/remote.c
index 723aa8841c..029fc630b9 100644
--- a/remote.c
+++ b/remote.c
@@ -2577,19 +2577,22 @@ struct check_and_collect_until_cb_data {
 };
 
 /* Get the timestamp of the latest entry. */
-static int peek_reflog(struct object_id *o_oid, struct object_id *n_oid,
-		       const char *ident, timestamp_t timestamp,
-		       int tz, const char *message, void *cb_data)
+static int peek_reflog(struct object_id *UNUSED(o_oid),
+		       struct object_id *UNUSED(n_oid),
+		       const char *UNUSED(ident),
+		       timestamp_t timestamp, int UNUSED(tz),
+		       const char *UNUSED(message), void *cb_data)
 {
 	timestamp_t *ts = cb_data;
 	*ts = timestamp;
 	return 1;
 }
 
-static int check_and_collect_until(struct object_id *o_oid,
+static int check_and_collect_until(struct object_id *UNUSED(o_oid),
 				   struct object_id *n_oid,
-				   const char *ident, timestamp_t timestamp,
-				   int tz, const char *message, void *cb_data)
+				   const char *UNUSED(ident),
+				   timestamp_t timestamp, int UNUSED(tz),
+				   const char *UNUSED(message), void *cb_data)
 {
 	struct commit *commit;
 	struct check_and_collect_until_cb_data *cb = cb_data;
diff --git a/revision.c b/revision.c
index 23c2bba0d8..6c7250d6a8 100644
--- a/revision.c
+++ b/revision.c
@@ -1619,8 +1619,11 @@ static void handle_one_reflog_commit(struct object_id *oid, void *cb_data)
 }
 
 static int handle_one_reflog_ent(struct object_id *ooid, struct object_id *noid,
-		const char *email, timestamp_t timestamp, int tz,
-		const char *message, void *cb_data)
+				 const char *UNUSED(email),
+				 timestamp_t UNUSED(timestamp),
+				 int UNUSED(tz),
+				 const char *UNUSED(message),
+				 void *cb_data)
 {
 	handle_one_reflog_commit(ooid, cb_data);
 	handle_one_reflog_commit(noid, cb_data);
diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
index a98775d1a6..8f930ad358 100644
--- a/t/helper/test-ref-store.c
+++ b/t/helper/test-ref-store.c
@@ -207,7 +207,7 @@ static int cmd_for_each_reflog(struct ref_store *refs, const char **argv)
 
 static int each_reflog(struct object_id *old_oid, struct object_id *new_oid,
 		       const char *committer, timestamp_t timestamp,
-		       int tz, const char *msg, void *cb_data)
+		       int tz, const char *msg, void *UNUSED(cb_data))
 {
 	printf("%s %s %s %" PRItime " %+05d%s%s", oid_to_hex(old_oid),
 	       oid_to_hex(new_oid), committer, timestamp, tz,
diff --git a/wt-status.c b/wt-status.c
index 867e3e417e..38d0900aa9 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -947,9 +947,11 @@ static void wt_longstatus_print_changed(struct wt_status *s)
 	wt_longstatus_print_trailer(s);
 }
 
-static int stash_count_refs(struct object_id *ooid, struct object_id *noid,
-			    const char *email, timestamp_t timestamp, int tz,
-			    const char *message, void *cb_data)
+static int stash_count_refs(struct object_id *UNUSED(ooid),
+			    struct object_id *UNUSED(noid),
+			    const char *UNUSED(email),
+			    timestamp_t UNUSED(timestamp), int UNUSED(tz),
+			    const char *UNUSED(message), void *cb_data)
 {
 	int *c = cb_data;
 	(*c)++;
@@ -1612,8 +1614,10 @@ struct grab_1st_switch_cbdata {
 	struct object_id noid;
 };
 
-static int grab_1st_switch(struct object_id *ooid, struct object_id *noid,
-			   const char *email, timestamp_t timestamp, int tz,
+static int grab_1st_switch(struct object_id *UNUSED(ooid),
+			   struct object_id *noid,
+			   const char *UNUSED(email),
+			   timestamp_t UNUSED(timestamp), int UNUSED(tz),
 			   const char *message, void *cb_data)
 {
 	struct grab_1st_switch_cbdata *cb = cb_data;
-- 
2.37.2.928.g0821088f4a

