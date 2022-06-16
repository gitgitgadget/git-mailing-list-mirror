Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C90FC43334
	for <git@archiver.kernel.org>; Thu, 16 Jun 2022 03:39:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358169AbiFPDjX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jun 2022 23:39:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356282AbiFPDjV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jun 2022 23:39:21 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 338891CFED
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 20:39:20 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id v17-20020a17090a899100b001ead067eaf9so668025pjn.0
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 20:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mNOTUFfdKMNYspcLCed+ztcc3HTgXEP/TnpY9Z64ruc=;
        b=PRaTV8n3NPNogjzGogyirgDV5qe1+VvurCW49ZlcR9FEyPwhfGZJ9aomTkYwWO6Tm2
         yVf8er7SFXYcEWi6yJpcHMM80FbBxPckCiT10Knk57FWjtSFD4fmHSSb/vMakd87572N
         +XZzdNpBTUkhtaQrI++gg4KbhleyZ5TcOp/X8kwEpvMgEb+fSYexms/JAOPv7dvpjqfn
         Z1ASgOKXMW20LwHcLj0BDf4DKxbPNUE8Nk58W391jg8voo+bZCICEQZvPENp6u/eMZPi
         LXii5xldsVg+91fi4SpCFC5o+oJ3YErW6+22JwzihYRLu7jNswSbQ3UM1j+nHRqL8Dwk
         ji2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mNOTUFfdKMNYspcLCed+ztcc3HTgXEP/TnpY9Z64ruc=;
        b=Q1Wf0BEAFeJvpVJ/tLWUXocwAqqrIPUbk11T2sxTVpxARWMDkVaz9wCR+9PmxVWmkG
         Q1t36ljf2bXiwTVdP7PrlObcIUO28LaB3siiaZx17n60GRYvtvuLRnfEGPcrp0CYsTxL
         cbmGBjvLo7d6RORN+N92RxJM6SGI1Lne+PXTxZjMoiuDFl0bM+0b0RQ7EtyKq7xsU7lt
         vgatbG7XS9uVcvvO0C7u8k/0KRDRz0VxXNb0dFMMtsWdh0MchcacEpUy6uDwHBQuALH8
         DnZPn7w4UhefI7+wOGEEtwlRhgnLDkfIQM+1/6mnDY5yqm+RU4y8sn4w+Rzf3L6c/SwL
         86MA==
X-Gm-Message-State: AJIora9ZCRfLrvpiIFAS24Liui/V04wnNPx5/ersA8X5n0uUa4lw5Mvv
        KbcN+EtVIuVN9BhdN0MR3jHbBQ==
X-Google-Smtp-Source: AGRyM1sdAqDJmv2YDDbsg0+XboK78Hi0X9moF5VteM0O4iUipDNzRZ1T0DyOIukeZRJJRgtwMHI13Q==
X-Received: by 2002:a17:90b:4b8d:b0:1e3:5147:6e63 with SMTP id lr13-20020a17090b4b8d00b001e351476e63mr2909974pjb.162.1655350759653;
        Wed, 15 Jun 2022 20:39:19 -0700 (PDT)
Received: from JMHNXMC7VH.bytedance.net ([139.177.225.227])
        by smtp.gmail.com with ESMTPSA id p4-20020a170902780400b0016760c06b76sm393163pll.194.2022.06.15.20.39.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 15 Jun 2022 20:39:19 -0700 (PDT)
From:   Han Xin <hanxin.hx@bytedance.com>
To:     me@ttaylorr.com
Cc:     chiyutianyi@gmail.com, derrickstolee@github.com,
        git@vger.kernel.org, haiyangtand@gmail.com,
        jonathantanmy@google.com, ps@pks.im,
        Han Xin <hanxin.hx@bytedance.com>
Subject: [RFC PATCH 1/2] commit-graph.c: add "flags" to lookup_commit_in_graph()
Date:   Thu, 16 Jun 2022 11:38:32 +0800
Message-Id: <9aa52b29862d9a6432d0752eae12365f43ba52c0.1655350442.git.hanxin.hx@bytedance.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1655350442.git.hanxin.hx@bytedance.com>
References: <cover.1655350442.git.hanxin.hx@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When try to do deref_without_lazy_fetch_extended(), "oi_flags" will
be missed by lookup_commit_in_graph(), then repo_has_object_file()
may start a new round objects fetching.
So let's add "flags" to lookup_commit_in_graph() and use
repo_has_object_file_with_flags() to pass the flags.

Signed-off-by: Han Xin <hanxin.hx@bytedance.com>
---
 builtin/fetch.c | 4 +++-
 commit-graph.c  | 5 +++--
 commit-graph.h  | 3 ++-
 fetch-pack.c    | 4 ++--
 revision.c      | 2 +-
 upload-pack.c   | 5 +++--
 6 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index ac29c2b1ae..44285d5318 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1179,7 +1179,9 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
 				 * annotated tags.
 				 */
 				if (!starts_with(rm->name, "refs/tags/"))
-					commit = lookup_commit_in_graph(the_repository, &rm->old_oid);
+					commit = lookup_commit_in_graph(
+						the_repository, &rm->old_oid,
+						0);
 				if (!commit) {
 					commit = lookup_commit_reference_gently(the_repository,
 										&rm->old_oid,
diff --git a/commit-graph.c b/commit-graph.c
index 92d4503336..b09f454bb5 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -889,7 +889,8 @@ static int find_commit_pos_in_graph(struct commit *item, struct commit_graph *g,
 	}
 }
 
-struct commit *lookup_commit_in_graph(struct repository *repo, const struct object_id *id)
+struct commit *lookup_commit_in_graph(struct repository *repo,
+				      const struct object_id *id, int flags)
 {
 	struct commit *commit;
 	uint32_t pos;
@@ -898,7 +899,7 @@ struct commit *lookup_commit_in_graph(struct repository *repo, const struct obje
 		return NULL;
 	if (!search_commit_pos_in_graph(id, repo->objects->commit_graph, &pos))
 		return NULL;
-	if (!repo_has_object_file(repo, id))
+	if (!repo_has_object_file_with_flags(repo, id, flags))
 		return NULL;
 
 	commit = lookup_commit(repo, id);
diff --git a/commit-graph.h b/commit-graph.h
index 2e3ac35237..747a67c0ee 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -46,7 +46,8 @@ int parse_commit_in_graph(struct repository *r, struct commit *item);
  * that we don't return commits whose object has been pruned. Otherwise, this
  * function returns `NULL`.
  */
-struct commit *lookup_commit_in_graph(struct repository *repo, const struct object_id *id);
+struct commit *lookup_commit_in_graph(struct repository *repo,
+				      const struct object_id *id, int flags);
 
 /*
  * It is possible that we loaded commit contents from the commit buffer,
diff --git a/fetch-pack.c b/fetch-pack.c
index cb6647d657..4a62fb182e 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -123,7 +123,7 @@ static struct commit *deref_without_lazy_fetch_extended(const struct object_id *
 	struct object_info info = { .typep = type };
 	struct commit *commit;
 
-	commit = lookup_commit_in_graph(the_repository, oid);
+	commit = lookup_commit_in_graph(the_repository, oid, 0);
 	if (commit)
 		return commit;
 
@@ -714,7 +714,7 @@ static void mark_complete_and_common_ref(struct fetch_negotiator *negotiator,
 	for (ref = *refs; ref; ref = ref->next) {
 		struct commit *commit;
 
-		commit = lookup_commit_in_graph(the_repository, &ref->old_oid);
+		commit = lookup_commit_in_graph(the_repository, &ref->old_oid, 0);
 		if (!commit) {
 			struct object *o;
 
diff --git a/revision.c b/revision.c
index 211352795c..df5db51f98 100644
--- a/revision.c
+++ b/revision.c
@@ -379,7 +379,7 @@ static struct object *get_reference(struct rev_info *revs, const char *name,
 	 * look up the object ID in those graphs. Like this, we can avoid
 	 * parsing commit data from disk.
 	 */
-	commit = lookup_commit_in_graph(revs->repo, oid);
+	commit = lookup_commit_in_graph(revs->repo, oid, 0);
 	if (commit)
 		object = &commit->object;
 	else
diff --git a/upload-pack.c b/upload-pack.c
index 3a851b3606..0fa9c3cf3f 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -1407,7 +1407,7 @@ static int parse_want(struct packet_writer *writer, const char *line,
 			die("git upload-pack: protocol error, "
 			    "expected to get oid, not '%s'", line);
 
-		commit = lookup_commit_in_graph(the_repository, &oid);
+		commit = lookup_commit_in_graph(the_repository, &oid, 0);
 		if (commit)
 			o = &commit->object;
 		else
@@ -1455,7 +1455,8 @@ static int parse_want_ref(struct packet_writer *writer, const char *line,
 		item->util = oiddup(&oid);
 
 		if (!starts_with(refname_nons, "refs/tags/")) {
-			struct commit *commit = lookup_commit_in_graph(the_repository, &oid);
+			struct commit *commit =
+				lookup_commit_in_graph(the_repository, &oid, 0);
 			if (commit)
 				o = &commit->object;
 		}
-- 
2.36.1

