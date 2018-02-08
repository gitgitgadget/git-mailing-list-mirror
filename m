Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 293E61F404
	for <e@80x24.org>; Thu,  8 Feb 2018 20:38:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752406AbeBHUiJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Feb 2018 15:38:09 -0500
Received: from mail-qk0-f196.google.com ([209.85.220.196]:36793 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752381AbeBHUiF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Feb 2018 15:38:05 -0500
Received: by mail-qk0-f196.google.com with SMTP id 15so7344901qkl.3
        for <git@vger.kernel.org>; Thu, 08 Feb 2018 12:38:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TBnELlUn84GW/6wEp01AwVbZYWbitPnAcJ24xA4D0M0=;
        b=ZUirBnckZ54feA4oxBmSVVDkCJN68UTTJyX3euhaDskA1ib75GxiSXr9rLI2jNr/3u
         u1yQ6ndtDgFkdOjj6OB/mbrURY2aY0HU74ARhmum3WovK+Z57RIGJ14WRb7IoRo5jtIj
         QIiqKrnAhYHfsJ9ZKlkn2noC/cfkBSRSGuO6fOXcRGYGGfo/cUD6mQvwa0ly5buS0RvA
         VyQaYr52lXfwCLAczTD0KRoYzjKzap+bplmn1vKkU98jnq1MYXhLYxzwpznhoMo9DuoV
         t/ngnZQ0ucVE3Gs513QTWGWEusdOE6lZwT3DApUYEdjJMpfq+Sn3koJWHT3k7jMeYY7s
         zXLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TBnELlUn84GW/6wEp01AwVbZYWbitPnAcJ24xA4D0M0=;
        b=q1Pj7SKoLbAgvXB0y/pocOPkWoc6tQxWF1w6MnVCPUQdIevTqUomWL/crylIhgDH6G
         DAKVs2BmMkyJicE9wIyDwVDIzPkUBHlSdLmBfS2IeIVg56/Wvx0PEITHQkqrJTH4L7Pm
         u1XGeHfj73hqgL4hPvp0iqs/t5d0xMicCMT7xge3ZN0p88iOMdLph6xVcpOIXCQssSNs
         fEMBboo0w5jEpRGV8Q/xrgdrlMevR2YffaM61AmGCCKgEEaDQ7EefifZQdW7nwRzM0IK
         VDzWy2peSNuhpt4X26wc1okkLjT8RaC3docKlppGIP0M6e6PWt385TjygQU8tS4KxbF0
         Cc3g==
X-Gm-Message-State: APf1xPDCRmB+kAV6Ff0Nx82rm27dCrx3OuJhPjHsBKPn8tNz456yBi2H
        30MrAVXK/mIxUtCNml9BN8o1+n/Bbeo=
X-Google-Smtp-Source: AH8x227bkhtgpXygt6Z9gaC9ZfzV36lZDFj7jgnvqQ7Q7zhD7XJOlSRK2knbNEsO/9c15ETLsnCc4w==
X-Received: by 10.55.130.134 with SMTP id e128mr423373qkd.333.1518122284592;
        Thu, 08 Feb 2018 12:38:04 -0800 (PST)
Received: from stolee-linux.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:7308])
        by smtp.gmail.com with ESMTPSA id 58sm636735qtm.51.2018.02.08.12.38.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Feb 2018 12:38:04 -0800 (PST)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, git@jeffhostetler.com, gitster@pobox.com,
        peff@peff.net, jonathantanmy@google.com, sbeller@google.com,
        szeder.dev@gmail.com
Subject: [PATCH v3 12/14] commit-graph: close under reachability
Date:   Thu,  8 Feb 2018 15:37:36 -0500
Message-Id: <1518122258-157281-13-git-send-email-dstolee@microsoft.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518122258-157281-1-git-send-email-dstolee@microsoft.com>
References: <1517348383-112294-1-git-send-email-dstolee@microsoft.com>
 <1518122258-157281-1-git-send-email-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach write_commit_graph() to walk all parents from the commits
discovered in packfiles. This prevents gaps given by loose objects or
previously-missed packfiles.

Also automatically add commits from the existing graph file, if it
exists.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/commit-graph.c b/commit-graph.c
index aff67c458e..d711a2cd81 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -633,6 +633,28 @@ static int if_packed_commit_add_to_list(const struct object_id *oid,
 	return 0;
 }
 
+static void close_reachable(struct packed_oid_list *oids)
+{
+	int i;
+	struct rev_info revs;
+	struct commit *commit;
+	init_revisions(&revs, NULL);
+	for (i = 0; i < oids->nr; i++) {
+		commit = lookup_commit(oids->list[i]);
+		if (commit && !parse_commit(commit))
+			revs.commits = commit_list_insert(commit, &revs.commits);
+	}
+
+	if (prepare_revision_walk(&revs))
+		die(_("revision walk setup failed"));
+
+	while ((commit = get_revision(&revs)) != NULL) {
+		ALLOC_GROW(oids->list, oids->nr + 1, oids->alloc);
+		oids->list[oids->nr] = &(commit->object.oid);
+		(oids->nr)++;
+	}
+}
+
 struct object_id *write_commit_graph(const char *pack_dir)
 {
 	struct packed_oid_list oids;
@@ -650,12 +672,27 @@ struct object_id *write_commit_graph(const char *pack_dir)
 	char *fname;
 	struct commit_list *parent;
 
+	prepare_commit_graph();
+
 	oids.nr = 0;
 	oids.alloc = 1024;
+
+	if (commit_graph && oids.alloc < commit_graph->num_commits)
+		oids.alloc = commit_graph->num_commits;
+
 	ALLOC_ARRAY(oids.list, oids.alloc);
 
+	if (commit_graph) {
+		for (i = 0; i < commit_graph->num_commits; i++) {
+			oids.list[i] = malloc(sizeof(struct object_id));
+			get_nth_commit_oid(commit_graph, i, oids.list[i]);
+		}
+		oids.nr = commit_graph->num_commits;
+	}
+
 	for_each_packed_object(if_packed_commit_add_to_list, &oids, 0);
 
+	close_reachable(&oids);
 	QSORT(oids.list, oids.nr, commit_compare);
 
 	count_distinct = 1;
-- 
2.15.1.45.g9b7079f

