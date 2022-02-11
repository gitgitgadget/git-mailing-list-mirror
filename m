Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFDFFC433EF
	for <git@archiver.kernel.org>; Fri, 11 Feb 2022 16:37:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351591AbiBKQhX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Feb 2022 11:37:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244029AbiBKQhW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Feb 2022 11:37:22 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE7AD66
        for <git@vger.kernel.org>; Fri, 11 Feb 2022 08:37:21 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id p6so4913666plf.10
        for <git@vger.kernel.org>; Fri, 11 Feb 2022 08:37:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RoPGnZ3megEgKMguJWV/dkqP4GvLBc/JHQ0pSnelzpk=;
        b=JlVZM7Rl2c41mQ66CpWlUdPojLNnzmryL+F8FbbKqjegBBAogtL0tkduj9SH4uG21k
         ESBxn5x4TdeacM42H4Wr5v31dOQM7HYw/BeU0zjw54ujEPUJ2daYG258/diDSQVpJQ12
         a6dutmYz4IUgu0QpcLmVQZUUBPDb8lJ7o/y68jo5b4BAq8+vIOtq7p8KAxa+TMlEb+lZ
         GLviI9sz3ytVWdssu5+jUaROyosH4YdBz0mYiy0bCW8hpAMo3cJOe4zEkO8oUjOPLVuM
         uiWxroVAF5ZRkFWjwerh+/nkv9hJyD2GmRIhARzoqrOzCVjZqtALd8SkgU96MXFhW++I
         bCfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RoPGnZ3megEgKMguJWV/dkqP4GvLBc/JHQ0pSnelzpk=;
        b=2+cTqG5vrtcMxla0IEzJKmJI1wlSS0bC11oyNJEhDZoaG/jjlyA9c7dG+K3bq3vayb
         tDdNboMdb5ndktrIjqqk4CzGzX7KivlHwF93GOL6PobCP7qGGbNWHz5fIgKp7GnqxwlU
         Zk9u65gtWl5pfWq66NAQG6nUF9j3Ff1n3IVTlUBMOZcRTQbggGpAdUMDO3KmH8AwUivN
         1gZCqB8I1kqxFyAdc9ei4OVhf4UMe2eWKHSVJXQw9LOkv4nf/FbPKtYCIi9fnrRC+7sv
         u9VCOBzgp2pc52Ge1WAgQrFQ+3AFcgi78xGTs6e6+z2H8Phm1DwtfOeybVWUMn5d1Lvj
         5/wA==
X-Gm-Message-State: AOAM5335l+IokFA/XLwSCwoVyHp6YI4NWRqbHO63vnRIu6u6WslMDZSR
        rT8JhDUrHht3kIyzfoXxbf3u3AUDtgk=
X-Google-Smtp-Source: ABdhPJzhFminZ9QiLmd0MF2CySK4G+twR1fDTpakriZpL1qig1thmOnJncd8+cMzcZEGr0Vvrude3w==
X-Received: by 2002:a17:90b:4a52:: with SMTP id lb18mr1252919pjb.92.1644597440136;
        Fri, 11 Feb 2022 08:37:20 -0800 (PST)
Received: from xavier.lan ([2001:470:b:114::cc1])
        by smtp.gmail.com with ESMTPSA id l17sm27450568pfu.61.2022.02.11.08.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 08:37:19 -0800 (PST)
From:   Alex Henrie <alexhenrie24@gmail.com>
To:     git@vger.kernel.org, paulus@ozlabs.org
Cc:     Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH v3 1/4] log: fix memory leak if --graph is passed multiple times
Date:   Fri, 11 Feb 2022 09:36:24 -0700
Message-Id: <20220211163627.598166-1-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
v3: no changes
---
 graph.c    | 12 ++++++++++++
 graph.h    |  5 +++++
 revision.c |  1 +
 3 files changed, 18 insertions(+)

diff --git a/graph.c b/graph.c
index e3828eb8f2..568b6e7cd4 100644
--- a/graph.c
+++ b/graph.c
@@ -401,6 +401,18 @@ struct git_graph *graph_init(struct rev_info *opt)
 	return graph;
 }
 
+void graph_clear(struct git_graph *graph)
+{
+	if (!graph)
+		return;
+
+	free(graph->columns);
+	free(graph->new_columns);
+	free(graph->mapping);
+	free(graph->old_mapping);
+	free(graph);
+}
+
 static void graph_update_state(struct git_graph *graph, enum graph_state s)
 {
 	graph->prev_state = graph->state;
diff --git a/graph.h b/graph.h
index 8313e293c7..e88632a014 100644
--- a/graph.h
+++ b/graph.h
@@ -139,6 +139,11 @@ void graph_set_column_colors(const char **colors, unsigned short colors_max);
  */
 struct git_graph *graph_init(struct rev_info *opt);
 
+/*
+ * Free a struct git_graph.
+ */
+void graph_clear(struct git_graph *graph);
+
 /*
  * Update a git_graph with a new commit.
  * This will cause the graph to begin outputting lines for the new commit
diff --git a/revision.c b/revision.c
index ad4286fbdd..816061f3d9 100644
--- a/revision.c
+++ b/revision.c
@@ -2426,6 +2426,7 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 	} else if (!strcmp(arg, "--graph")) {
 		revs->topo_order = 1;
 		revs->rewrite_parents = 1;
+		graph_clear(revs->graph);
 		revs->graph = graph_init(revs);
 	} else if (!strcmp(arg, "--encode-email-headers")) {
 		revs->encode_email_headers = 1;
-- 
2.35.1

