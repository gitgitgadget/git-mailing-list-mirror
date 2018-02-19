Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BAE2C1F404
	for <e@80x24.org>; Mon, 19 Feb 2018 18:53:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753573AbeBSSxw (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Feb 2018 13:53:52 -0500
Received: from mail-qt0-f196.google.com ([209.85.216.196]:43944 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753489AbeBSSxp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Feb 2018 13:53:45 -0500
Received: by mail-qt0-f196.google.com with SMTP id d26so13429081qtk.10
        for <git@vger.kernel.org>; Mon, 19 Feb 2018 10:53:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fo7RKYifyu75V7tRIfO/LRh8Yicj4rA9wRIGyXUqLGc=;
        b=ggqEixuC1nbWSAmHRm7QYiIItakTjqkYhfS9quEKS2uPXa6y1ufelZ+RRQHZcaXZ4G
         2NVFLlYhzdsBjb4z0loCGwLpaxvZGc4RjvYt3HXHMeHYXUzyUCAQ4mcD4kAROGbYVAzX
         SmeE3csFYXsajLW1Yf0QnwdpKDvU/P8tOxgT9bBI3vKhN3I2TE7pw9T+12FI22GVpWcl
         N3YKXF2uJ1rrmzLoDRYc8iVSYx/EgLAHfcr71IUJ9NM/RhwL2fqSpDiHLbtXptVLCI4c
         TaMm5l1VtxkGW/e3l7htlWKqS5lSEh+bRxBVhpHKV1zwqUDNJ0AbP23+q0J2Z4HP+P3P
         QVWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fo7RKYifyu75V7tRIfO/LRh8Yicj4rA9wRIGyXUqLGc=;
        b=uf+6+n42dYQ5Yh7beA+u+yLBbZOWWQkN40jQRskzclO4E/Z7fsJ+TBzziQNSkfZ3Lp
         g6s4r7g/3IENy9S54xTzL0id4HEPWHfD6b6enhXf3FqOht+yqDbN3k2PtQGhgZm5KzBV
         irVFNYwBMp9wv5JsroqWnRJMeZC182yJBHxc96FQVVQ5EfbaVl4May+j19xbCRCX2v7W
         peeff0zeKf6NcRCNAMGFVWM0c5HWWnq3Ab66qXhPB2xiy7cRPVZaWzNFCzDIzqA6cgjv
         jRIL3kP+GjCzxenHd6wis1p3VcafcVdTZoM+VYW+pYrfcqE+Xw4n2bJldmVx6PfpHGUW
         GsiQ==
X-Gm-Message-State: APf1xPBJQuk5xD6uJPJmP7UL6+ov911jpWeXI3o5ztowXwtbRkQmpeKc
        ycjCTN5MbRq9KAljGwYA9xh/9QHcb/A=
X-Google-Smtp-Source: AH8x2276kWqZk9ArsrIJnVTALWCQJnuwHT9DTQ0LNW2TQ3t1OsaTWO+/mymqG/LPt1Ce6DfpdLne6Q==
X-Received: by 10.237.35.87 with SMTP id i23mr25434535qtc.59.1519066424725;
        Mon, 19 Feb 2018 10:53:44 -0800 (PST)
Received: from stolee-linux.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:7308])
        by smtp.gmail.com with ESMTPSA id o12sm1672631qke.81.2018.02.19.10.53.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 19 Feb 2018 10:53:44 -0800 (PST)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org, git@jeffhostetler.com
Cc:     peff@peff.net, jonathantanmy@google.com, szeder.dev@gmail.com,
        sbeller@google.com, gitster@pobox.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v4 10/13] commit-graph: close under reachability
Date:   Mon, 19 Feb 2018 13:53:23 -0500
Message-Id: <1519066406-81663-11-git-send-email-dstolee@microsoft.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519066406-81663-1-git-send-email-dstolee@microsoft.com>
References: <4d1ee202-7d79-d73c-6e05-d0fc85db943c@gmail.com>
 <1519066406-81663-1-git-send-email-dstolee@microsoft.com>
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
index c8fb38f..00bd73a 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -385,6 +385,28 @@ static int if_packed_commit_add_to_list(const struct object_id *oid,
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
 char *write_commit_graph(const char *obj_dir)
 {
 	struct packed_oid_list oids;
@@ -411,6 +433,7 @@ char *write_commit_graph(const char *obj_dir)
 	ALLOC_ARRAY(oids.list, oids.alloc);
 
 	for_each_packed_object(if_packed_commit_add_to_list, &oids, 0);
+	close_reachable(&oids);
 
 	QSORT(oids.list, oids.nr, commit_compare);
 
-- 
2.7.4

