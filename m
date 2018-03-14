Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B71A51F404
	for <e@80x24.org>; Wed, 14 Mar 2018 19:28:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751971AbeCNT2M (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Mar 2018 15:28:12 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:45411 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751964AbeCNT2G (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Mar 2018 15:28:06 -0400
Received: by mail-qt0-f194.google.com with SMTP id v90so4681838qte.12
        for <git@vger.kernel.org>; Wed, 14 Mar 2018 12:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JBZ+7VxGD0/kRk6sKaP7VjV8FjyvlZzJ0ygTcjqNf5U=;
        b=R1gilXUDQy+FsQeJUqG7k0DDNOfd6jDs0UBNRP/mCEo78d3LwX831rJZpxX7UcPAYE
         uPXoBnNIoMsSejJUKmji5ENN802ywgqIrzgknzEj6NF+7SqY+Aqi26PdCMUbAEe+XRGr
         TAr8Qdx0HRt0xG5fDZ5MU8/jGIAjZLbNPjueg5Iyuw8ctqXKtz9GkpJoV4yz4DgM5Mcw
         LGnjNzjwPN/t60oU7pr+t8+h2GhRCQ6gSiY6bTOJnTBKViFx2lu0bi4v7n1Dl9epvPTy
         h7IUcwH7dyJ1xVfeMA0SLr2FEu6gfiMUGJWMKtf6+HJL5sSTDsPHZVooRexZvFQWchql
         3VbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JBZ+7VxGD0/kRk6sKaP7VjV8FjyvlZzJ0ygTcjqNf5U=;
        b=P1fYbUT2f48UccVzWQgRpSpStXV8rtPSleka2AmpIFkeQ7npVr6kE7OViX3M257j6V
         d3H+GqHn0Uj2wSAjTTJ0NT0ErYkijBE4C3b+LsWluj2FNvfZbQhgzXkeUntk1aJrfyBY
         bI+3IJlJ6nbetaegv78STycBH0CsYxdGWUP88Zfvo4wAUykox3WBRJaz4kSF85nZPkTc
         0stdsPXmA9izq4hwqiKd8oajO6UfB3v28FTUezzWxWPAhOZzFxXGZV35rAwI9wh2pXV8
         TvcmFmxM3hn0jA48nE0a5awW34zLT0mGdy97dLYpaEbNaZ9HzHc6uCzky7sXFqJwT9L4
         R1Fg==
X-Gm-Message-State: AElRT7FHUUTqrNAAi39tUlbAsoE6wZTB8kcY4KDPVPHzLatnkDvwl5Gr
        en2JQqIa1dnZzRa/hxx6d/sLjizuQfQ=
X-Google-Smtp-Source: AG47ELtqkCmb8vlWOB4ka1Qn8bosAxzR+cdkAlnwy8+Xkx144jGDUWU4w9ytFdakEGQy/HxFNj3opg==
X-Received: by 10.200.55.215 with SMTP id e23mr8944922qtc.158.1521055685675;
        Wed, 14 Mar 2018 12:28:05 -0700 (PDT)
Received: from stolee-linux-2.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:730f])
        by smtp.gmail.com with ESMTPSA id q30sm2847395qte.10.2018.03.14.12.28.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Mar 2018 12:28:05 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, sbeller@google.com,
        szeder.dev@gmail.com, ramsay@ramsayjones.plus.com,
        git@jeffhostetler.com, Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v6 10/14] commit-graph: close under reachability
Date:   Wed, 14 Mar 2018 15:27:32 -0400
Message-Id: <20180314192736.70602-11-dstolee@microsoft.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180314192736.70602-1-dstolee@microsoft.com>
References: <1519698787-190494-1-git-send-email-dstolee@microsoft.com>
 <20180314192736.70602-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Teach write_commit_graph() to walk all parents from the commits
discovered in packfiles. This prevents gaps given by loose objects or
previously-missed packfiles.

Also automatically add commits from the existing graph file, if it
exists.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/commit-graph.c b/commit-graph.c
index 2f2e2c7083..fc7b4fa622 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -369,6 +369,28 @@ static int add_packed_commits(const struct object_id *oid,
 	return 0;
 }
 
+static void close_reachable(struct packed_oid_list *oids)
+{
+	int i;
+	struct rev_info revs;
+	struct commit *commit;
+	init_revisions(&revs, NULL);
+	for (i = 0; i < oids->nr; i++) {
+		commit = lookup_commit(&oids->list[i]);
+		if (commit && !parse_commit(commit))
+			revs.commits = commit_list_insert(commit, &revs.commits);
+	}
+
+	if (prepare_revision_walk(&revs))
+		die(_("revision walk setup failed"));
+
+	while ((commit = get_revision(&revs)) != NULL) {
+		ALLOC_GROW(oids->list, oids->nr + 1, oids->alloc);
+		oidcpy(&oids->list[oids->nr], &(commit->object.oid));
+		(oids->nr)++;
+	}
+}
+
 void write_commit_graph(const char *obj_dir)
 {
 	struct packed_oid_list oids;
@@ -392,6 +414,7 @@ void write_commit_graph(const char *obj_dir)
 	ALLOC_ARRAY(oids.list, oids.alloc);
 
 	for_each_packed_object(add_packed_commits, &oids, 0);
+	close_reachable(&oids);
 
 	QSORT(oids.list, oids.nr, commit_compare);
 
-- 
2.14.1

