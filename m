Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0DAD51F404
	for <e@80x24.org>; Tue, 10 Apr 2018 12:57:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753161AbeDJM5Q (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Apr 2018 08:57:16 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:40962 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753150AbeDJM5P (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Apr 2018 08:57:15 -0400
Received: by mail-pl0-f65.google.com with SMTP id bj1-v6so7449285plb.8
        for <git@vger.kernel.org>; Tue, 10 Apr 2018 05:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uqhJD1A582TjcDfUxDQ/xmfkEi+vohiJ1I2MSMXqWuo=;
        b=M4O7p2ftRMZUhXbZcyGN/WakMqpd6Fq0gkYh1VefolOOJYh50ubjEo35aPk8WPzDLt
         rkohijq8FQw3IGS8yER+sHoF3OUvvKRnzkQ6qs46xNN87qzEpb6OTbuLO1NKLhLCvAaW
         6DSfB3RB2u7er+J2q7ICfm7PuFIgQVi2knvS1rIYB+yauoN9jPLxmGcPqPCF3Yl6LsIf
         SLxGQClVqeUTAt1gIwQ7JW9z9OtWQwLp7W+mT8jG56NDwoiHojsJ1mSEQ3c0Yj26FI3A
         YAyuBebnRi2n26u1XCn7hZWHJquP9QPr1emACWbScSHEivJIMuIpGyLqirNwUdMT8HmD
         8V9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uqhJD1A582TjcDfUxDQ/xmfkEi+vohiJ1I2MSMXqWuo=;
        b=XrsqAk3UP+tZqwnlQdNj4CMlOGUxHra8N2Qq4PtQIQRlOpWG4DXcjser8ofvHuG4w5
         zqMqgLMR6EcNAiYF7TsHlv8J0lJAOJEesdXGU17l6MA+MKf6RSv31/diZaR/6C49Nl6Q
         tH1K9YdhzNu5lI/qCdAyp399Ryz8RHiCqVk8ZrM+xn0tDGdmF+nEPyVyoP2WmfMCW7Kp
         shgmSRSHv/golW2k6qVzpsajqmS14+mAR4zVMVQVS/pmKzW9QSLVltGYplURyfvorNaE
         0AL7tV6oHpRTJf5lyQVR3gHkyedBDH0mZlm+WzG9MwiaWR5lSZEMFQSvV+apRUzrhPNx
         fPWw==
X-Gm-Message-State: ALQs6tAyE6D2LTcCYbbbCp7i+jza4s14U7jAS9NW33qRT/pTNznNqa1P
        Qna/aiMJecCWe/FHBNyyYzywgnbzEXc=
X-Google-Smtp-Source: AIpwx48B5dAs+UlEZe9dywWsyzbF3deg4bMzSBpOda8aPXlytzh4xGPSGrvf7nVeND/IQlywzuDV/g==
X-Received: by 2002:a17:902:780d:: with SMTP id p13-v6mr293568pll.281.1523365034884;
        Tue, 10 Apr 2018 05:57:14 -0700 (PDT)
Received: from stolee-linux-2.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:730f])
        by smtp.gmail.com with ESMTPSA id l10sm4421666pgp.35.2018.04.10.05.57.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Apr 2018 05:57:14 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, ramsay@ramsayjones.plus.com, sbeller@google.com,
        szeder.dev@gmail.com, git@jeffhostetler.com, peff@peff.net,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v8 10/14] commit-graph: close under reachability
Date:   Tue, 10 Apr 2018 08:56:04 -0400
Message-Id: <20180410125608.39443-11-dstolee@microsoft.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410125608.39443-1-dstolee@microsoft.com>
References: <20180402203427.170177-1-dstolee@microsoft.com>
 <20180410125608.39443-1-dstolee@microsoft.com>
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
 commit-graph.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/commit-graph.c b/commit-graph.c
index b1bd3a892d..ea29c5c2d8 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -367,6 +367,50 @@ static int add_packed_commits(const struct object_id *oid,
 	return 0;
 }
 
+static void add_missing_parents(struct packed_oid_list *oids, struct commit *commit)
+{
+	struct commit_list *parent;
+	for (parent = commit->parents; parent; parent = parent->next) {
+		if (!(parent->item->object.flags & UNINTERESTING)) {
+			ALLOC_GROW(oids->list, oids->nr + 1, oids->alloc);
+			oidcpy(&oids->list[oids->nr], &(parent->item->object.oid));
+			oids->nr++;
+			parent->item->object.flags |= UNINTERESTING;
+		}
+	}
+}
+
+static void close_reachable(struct packed_oid_list *oids)
+{
+	int i;
+	struct commit *commit;
+
+	for (i = 0; i < oids->nr; i++) {
+		commit = lookup_commit(&oids->list[i]);
+		if (commit)
+			commit->object.flags |= UNINTERESTING;
+	}
+
+	/*
+	 * As this loop runs, oids->nr may grow, but not more
+	 * than the number of missing commits in the reachable
+	 * closure.
+	 */
+	for (i = 0; i < oids->nr; i++) {
+		commit = lookup_commit(&oids->list[i]);
+
+		if (commit && !parse_commit(commit))
+			add_missing_parents(oids, commit);
+	}
+
+	for (i = 0; i < oids->nr; i++) {
+		commit = lookup_commit(&oids->list[i]);
+
+		if (commit)
+			commit->object.flags &= ~UNINTERESTING;
+	}
+}
+
 void write_commit_graph(const char *obj_dir)
 {
 	struct packed_oid_list oids;
@@ -390,6 +434,7 @@ void write_commit_graph(const char *obj_dir)
 	ALLOC_ARRAY(oids.list, oids.alloc);
 
 	for_each_packed_object(add_packed_commits, &oids, 0);
+	close_reachable(&oids);
 
 	QSORT(oids.list, oids.nr, commit_compare);
 
-- 
2.17.0

