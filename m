Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5EB761F404
	for <e@80x24.org>; Tue, 27 Feb 2018 02:33:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752028AbeB0Cdq (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Feb 2018 21:33:46 -0500
Received: from mail-qt0-f196.google.com ([209.85.216.196]:32882 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751923AbeB0CdY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Feb 2018 21:33:24 -0500
Received: by mail-qt0-f196.google.com with SMTP id a23so9058070qtn.0
        for <git@vger.kernel.org>; Mon, 26 Feb 2018 18:33:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bD5CL0rLNT81GlK7MX95hl2j7k/fzwnEI79/hx8SDts=;
        b=O0g5he5QhmIIWQu+Ut7PzIt35aBWhZZCNzqvEdbcamAevNoEOFiuSJd+Qpt/pWMPbO
         gwPt1TPcu8MX1ijGt/2qWrHrVgP1GI2J+R0KnVxZM1xixVDMm+fMxvZQUK1NNmMj7D4J
         f2JFA2cjAZXryRremALiJc8Io5xwvKXIlZLYVRlRqtEU3dvqH0itL7WwpFBEXd/8UBSQ
         JPKdsIuhI29SEbaZxDb9J5v4LbRgLJFEv1HFoL7EeE/hY2I/LVfRlC6R1FV+zOUdC9so
         S06ZehuolY/Rr/u4PLkP23eI0huZXXxNCkcemS5r7y3mawj9tu39uLD6d5w1/jVOS9Yv
         5krg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bD5CL0rLNT81GlK7MX95hl2j7k/fzwnEI79/hx8SDts=;
        b=Jr8gqdafXo7X6+q+we+3Le8WrEC/3hvhUqau354GL2PXNvPc7AJTdmlKwg4jNIiDv2
         64/808WCkQUmUdO0ctRj7IJkkVO84DuDUKKx5WoEcES7/R3D9QE1M8FrL+opxJQvUMNm
         xgFsltZr0J59c9WM2KtCUL8NkAXYeOUzCVRfIfJXlaxf5olKxGXQxhQ4NXdnMmJVVrD6
         4DOF0J8Cgj2bwF+XanLAvjRC2hsJG1pj9CHDuI7MNs9Z+Uj9k3sa1ULR8NWDkiKSHrPU
         nhfzybPnQ/0/RXpmU5iFtjyfJiWcDXoR/jpFeHn19qrNXdbNsvK7ajuatp2apAUjlsbd
         yTGg==
X-Gm-Message-State: APf1xPAVnuUMTiZrb6Okl+/phz4lgFM67FaD5hJBAF8y6YlWS6Z0JvvR
        DJCeisov1Sk7tRWE4n39ON888aQmNwM=
X-Google-Smtp-Source: AG47ELtKZh8b920Q39Gj4RPDnhkgIz75RFQEO2i8cciwyJES8IYmOfquf79lWi9ikfOpxDi6IyG5dA==
X-Received: by 10.237.59.59 with SMTP id p56mr21837381qte.84.1519698803867;
        Mon, 26 Feb 2018 18:33:23 -0800 (PST)
Received: from stolee-linux.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:7308])
        by smtp.gmail.com with ESMTPSA id 94sm5566530qtb.2.2018.02.26.18.33.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 26 Feb 2018 18:33:23 -0800 (PST)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, git@jeffhostetler.com,
        jonathantanmy@google.com, sbeller@google.com, szeder.dev@gmail.com,
        ramsay@ramsayjones.plus.com, Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v5 09/13] commit-graph: close under reachability
Date:   Mon, 26 Feb 2018 21:33:03 -0500
Message-Id: <1519698787-190494-10-git-send-email-dstolee@microsoft.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519698787-190494-1-git-send-email-dstolee@microsoft.com>
References: <1519698787-190494-1-git-send-email-dstolee@microsoft.com>
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
 commit-graph.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/commit-graph.c b/commit-graph.c
index 7b0cfb4..01aa23d 100644
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
@@ -393,6 +415,7 @@ void write_commit_graph(const char *obj_dir)
 	ALLOC_ARRAY(oids.list, oids.alloc);
 
 	for_each_packed_object(add_packed_commits, &oids, 0);
+	close_reachable(&oids);
 
 	QSORT(oids.list, oids.nr, commit_compare);
 
-- 
2.7.4

