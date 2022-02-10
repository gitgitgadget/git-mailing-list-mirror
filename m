Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A2A3C433EF
	for <git@archiver.kernel.org>; Thu, 10 Feb 2022 16:53:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239993AbiBJQxH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Feb 2022 11:53:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244488AbiBJQxG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Feb 2022 11:53:06 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F310EE
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 08:53:07 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id j4so2322467plj.8
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 08:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NCRkHXXoe2yFGl5JzOStPL6PzTPwZuQvPLS3hLpOKTo=;
        b=UdKRwy18/jB0hGRvE2iYeih+OGnLTQubDhxGvlHPjTBsv/vL+cZ9B6cMgtre5YxNbd
         zHnPyjQfYQeb3NlqgTIMoCGjD/2zUtIPf93hoB8otEO+G/6Y4TOsxBg9Jv59W2t0Rpkt
         cHTNtRLxx2HDstzSg4LpGiWgNnjvyDKRUMxmTKe3qUQN150JHW/gOFLQN7W/9yWE/nbp
         MS9ZQjZMBmRob1EkSUiDcHivnemPwiwRv5EKWoDcFx2HdOtm94nsUbVLW+dRGH16+vVs
         CJSRT7avgSKyGbDeLh0ifypwnqdr5QNKs/Eo81nroX5roRYEzG2/+oQP8CFtbZSDs83p
         y0KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NCRkHXXoe2yFGl5JzOStPL6PzTPwZuQvPLS3hLpOKTo=;
        b=4fT+UA0rHsjy7vWWGFHUxDHz7NwI2n10gcKfjeUrjWuyktDIN+AIAcRAAO3sU7XV4G
         qYbfsBmVYCwAD5D1CKQ80Gcr3Qr4w4Bmk92VUn9c9fB5skTdYA22LBM3Juc5OGlxnrn7
         q4ZGHf6iGf2SNerKAOUoZi61T/5quv0YVAYgvb5jkXbezgvxHdo79kiErA+zkRFuDKBE
         l7TpWHYz5yLK70fR7/oc9wbYP32KY1WudFND7OHfbE8CbWYCMkkeGQ16NBUIk+dAFcl2
         MAVQDoNeQ+dp3oDcnLBap68eulozERtSldAykgRI1+QTp35dcSDEKTJ7UTiwhPSPqm65
         Ouzw==
X-Gm-Message-State: AOAM533VGBt5tOe32cq/LvjI9D8J6QiyDiBBb/374/I1UUjuHhEphH9Z
        ANlxQMjiEOO4Tpn6Kegjlq20hjnO/ug=
X-Google-Smtp-Source: ABdhPJx39V/uac55YQrYdwDO/IJhPFcivImga1iigNCpRiN6LBfeX5oaVMLog/VySBx6cC1Pxt6nlQ==
X-Received: by 2002:a17:90a:cc5:: with SMTP id 5mr3694122pjt.156.1644511986596;
        Thu, 10 Feb 2022 08:53:06 -0800 (PST)
Received: from xavier.lan ([2001:470:b:114::cc1])
        by smtp.gmail.com with ESMTPSA id c17sm25614840pfv.68.2022.02.10.08.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 08:53:06 -0800 (PST)
From:   Alex Henrie <alexhenrie24@gmail.com>
To:     git@vger.kernel.org, paulus@ozlabs.org
Cc:     Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH v2 1/4] log: fix memory leak if --graph is passed multiple times
Date:   Thu, 10 Feb 2022 09:52:06 -0700
Message-Id: <20220210165209.310930-1-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.32.0.2645.gc109162a1f
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
v2: introduce graph_clear function
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
2.32.0.2645.gc109162a1f

