Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77919C43334
	for <git@archiver.kernel.org>; Tue, 12 Jul 2022 23:10:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233845AbiGLXKl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jul 2022 19:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233195AbiGLXKe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jul 2022 19:10:34 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12BDD9B9C7
        for <git@vger.kernel.org>; Tue, 12 Jul 2022 16:10:33 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id q13so2335103qkc.9
        for <git@vger.kernel.org>; Tue, 12 Jul 2022 16:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xQDAKvb0FE2cG0PUsInWPKPYo/rQ4AnDRWkJClFki68=;
        b=DVxnpv1PavN9R33Sx8OOGcWH/jNSDeA4j/aLD612g8di+DK/04+j2X5Qvm2on9eLHo
         K8WgpUzyQDmLmb2YGaQT7xFNpxWcUX4Q4JAt8TS4Ici5xpZxh/O2wLx07H7/MJRVCV+n
         nTt5XlYIIAauYfMG3tIAa4MNTG/iiahP0gYJFd5Rwmq8gKuBBC2Tzw3rHnCgQuCyg3YU
         dUDLWUkgIGK60V8+Kd0qusOmXCNwq8nTKgbUY1ssPQrT0iVlyPwU7mLTFeQdwojODAuh
         qyr5ssAkamwuPncQcXzvQVbWUZDyteFr/eNRT5jDx3BTL8SPDcciZPXo5lWNJx+N6Bws
         JhoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xQDAKvb0FE2cG0PUsInWPKPYo/rQ4AnDRWkJClFki68=;
        b=1zAd96stNl4gYoV7x8UitHxFsVIGC2DantjthKOhU0CidkOEQoGUm1D5bi1qDIvKF9
         n5HZopai2yLKi0x1BU8x7Xo30cxClhCHZczjexLWfWPaq83VfzzL/fxTumJvyPyUDtoS
         cFB1WL4eLMjIyekkpHWnt6YLhEG+IAEqP9whkqHHij1IpGaESG3Em88b/gNHa/1bfaoM
         b89OyQsAKWJ/oHE8RNOdBZkzMdmZjLa6/Y55d9gwhxdkyds1cGQe5vuC2hiKxJ44PSLN
         dHxwv6cHX99wLcxbJPYyEune3sryq/XZsjJEeEq2g70yJoTo7JjIzihxZtTwf2CWLF0v
         JjCg==
X-Gm-Message-State: AJIora/L47ZMsjW1TnumGRPsTEUyEdMY/IpJPxpBErxYuIRCqdV7m1KO
        6eWj7HUnPBkqoiPM4dkQKRACuahzF5QYdg==
X-Google-Smtp-Source: AGRyM1tG0zC+wrmxwNoXRn68/TRmniLcHXa6QqeZ1M6LKbCp5OrcNOH9BQOaERD/DKfqiJf0qgcp4Q==
X-Received: by 2002:a05:620a:210f:b0:6b5:9575:9084 with SMTP id l15-20020a05620a210f00b006b595759084mr514266qkl.587.1657667432028;
        Tue, 12 Jul 2022 16:10:32 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id c7-20020ac87dc7000000b003172da668desm8692370qte.50.2022.07.12.16.10.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 16:10:31 -0700 (PDT)
Date:   Tue, 12 Jul 2022 19:10:31 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, derrickstolee@github.com, peff@peff.net,
        ps@pks.im, wfc@wfchandler.org
Subject: [PATCH 2/3] commit-graph: introduce `repo_find_commit_pos_in_graph()`
Message-ID: <e988c974119edbabc06dae6d24810fc0bafbdc94.1657667404.git.me@ttaylorr.com>
References: <cover.1657667404.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1657667404.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Low-level callers in systems that are adjacent to the commit-graph (like
the changed-path Bloom filter code) could benefit from being able to
call a function like `parse_commit_in_graph()` without modifying the
corresponding commit slab data.

This is useful in contexts where that slab data is being used to prepare
for an upcoming commit-graph write, where Git must be careful to avoid
clobbering any of that data during a read operation.

Introduce a low-level variant of `parse_commit_in_graph()` which returns
the graph position of a given commit only, without modifying any of the
slab data.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 commit-graph.c | 12 +++++++++---
 commit-graph.h | 15 +++++++++++++++
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 92d4503336..1c34ae1ea4 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -889,6 +889,14 @@ static int find_commit_pos_in_graph(struct commit *item, struct commit_graph *g,
 	}
 }
 
+int repo_find_commit_pos_in_graph(struct repository *r, struct commit *c,
+				  uint32_t *pos)
+{
+	if (!prepare_commit_graph(r))
+		return 0;
+	return find_commit_pos_in_graph(c, r->objects->commit_graph, pos);
+}
+
 struct commit *lookup_commit_in_graph(struct repository *repo, const struct object_id *id)
 {
 	struct commit *commit;
@@ -946,9 +954,7 @@ int parse_commit_in_graph(struct repository *r, struct commit *item)
 void load_commit_graph_info(struct repository *r, struct commit *item)
 {
 	uint32_t pos;
-	if (!prepare_commit_graph(r))
-		return;
-	if (find_commit_pos_in_graph(item, r->objects->commit_graph, &pos))
+	if (repo_find_commit_pos_in_graph(r, item, &pos))
 		fill_commit_graph_info(item, r->objects->commit_graph, pos);
 }
 
diff --git a/commit-graph.h b/commit-graph.h
index 2e3ac35237..f23b9e9026 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -40,6 +40,21 @@ int open_commit_graph(const char *graph_file, int *fd, struct stat *st);
  */
 int parse_commit_in_graph(struct repository *r, struct commit *item);
 
+/*
+ * Fills `*pos` with the graph position of `c`, and returns 1 if `c` is
+ * found in the commit-graph belonging to `r`, or 0 otherwise.
+ * Initializes the commit-graph belonging to `r` if it hasn't been
+ * already.
+ *
+ * Note: this is a low-level helper that does not alter any slab data
+ * associated with `c`. Useful in circumstances where the slab data is
+ * already being modified (e.g., writing the commit-graph itself).
+ *
+ * In most cases, callers should use `parse_commit_in_graph()` instead.
+ */
+int repo_find_commit_pos_in_graph(struct repository *r, struct commit *c,
+				  uint32_t *pos);
+
 /*
  * Look up the given commit ID in the commit-graph. This will only return a
  * commit if the ID exists both in the graph and in the object database such
-- 
2.37.0.1.g1379af2e9d

