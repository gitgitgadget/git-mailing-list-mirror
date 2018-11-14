Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-12.3 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E74B1F87F
	for <e@80x24.org>; Wed, 14 Nov 2018 00:14:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731192AbeKNKOo (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 05:14:44 -0500
Received: from mail-pl1-f201.google.com ([209.85.214.201]:52465 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731191AbeKNKOo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 05:14:44 -0500
Received: by mail-pl1-f201.google.com with SMTP id 33-v6so10796258pld.19
        for <git@vger.kernel.org>; Tue, 13 Nov 2018 16:14:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=27BOe5wD3fr53AYTQS7q4HuK2T7gbBlT87unv87+w2c=;
        b=NIp9v5cz/gI6069Qvsp4t874ba10xKRGGf08aSYDoIPODEJNn2UWerzZp5tYS+oxaJ
         r2oKgf0YOJcTmod+dxPafIsqYrHlwO/7JnZ/GF1W2GEZZT7QH2qaObIpRMzny2HAuoKU
         sC6g9Nb0dYazEusRc2G3QWxa/SD8fG/ccdEa4EHwKmIHulQb5XPr51UyTItc3x+G/LyV
         fy8TmqSfLnvIpoAiHhBQ0Mf8qipwIKEA2wsu4swG7TbJE1ftt9GHvqSx7IP2mLMVCWol
         ylBoj4PZ7P8SmIduxUcqTHVCtafQ8IqU71KhMJXy9BZQCTYuVgmhBfPqUZMQS4ogc8WG
         SjfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=27BOe5wD3fr53AYTQS7q4HuK2T7gbBlT87unv87+w2c=;
        b=ivExksYPcilf1xFAb6TjyiD2BALq7vlRyTlZCA48kebnnRYg1P0pMOAsIE9sUMtZ/P
         GDXT4IFwxsYlpBHa2rZ0JbjsofiF1ER5yQcgcSXtr3vaUJ4c0HYaqklyFJ5jlOuWm4kL
         kTibZnaI1pJd1ob+Ig5wVop+LpfRd6RZY2DLGVOOoFSGKh247vCiYQsLhn/InvX7mc08
         jiq24BX+yZBU/PVifuvIPqeL1aKJdoE86fIh0ocAqowJ6YB620jx9B/8DUT2WsmQ4ws9
         mtjUt2GZp8EY5O7eez8rF3Qi0VA4IJ5GiWNC1ga8piU4Ee+86UvGbo2xRH0uHsB/YLWP
         Fnrg==
X-Gm-Message-State: AGRZ1gIgzZy+oYmTUCh+7eak7fDTmHl2/LDc+9JB34XbaUWBwrCU2X2C
        DSES5Uno59DLzVptwnl+z7OErmieqayB
X-Google-Smtp-Source: AJdET5cC5tEh5LCAaGHW8t6PRUpcBeQ8uMn05Zfjh5urKZedbGyTT/T5bm9lbqxf4cJ529X7eFjvE545T7VT
X-Received: by 2002:a62:d5c2:: with SMTP id d185mr1876866pfg.123.1542154441210;
 Tue, 13 Nov 2018 16:14:01 -0800 (PST)
Date:   Tue, 13 Nov 2018 16:12:55 -0800
In-Reply-To: <20181114001306.138053-1-sbeller@google.com>
Message-Id: <20181114001306.138053-13-sbeller@google.com>
Mime-Version: 1.0
References: <20181114001306.138053-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.1.1215.g8438c0b245-goog
Subject: [PATCH 12/23] commit-reach: prepare get_merge_bases to handle any repo
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, jonathantanmy@google.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Similarly to previous patches, the get_merge_base functions are used
often in the code base, which makes migrating them hard.

Implement the new functions, prefixed with 'repo_' and hide the old
functions behind a wrapper macro.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 commit-reach.c                                | 24 ++++++++++-------
 commit-reach.h                                | 26 ++++++++++++-------
 .../coccinelle/the_repository.pending.cocci   | 26 +++++++++++++++++++
 3 files changed, 56 insertions(+), 20 deletions(-)

diff --git a/commit-reach.c b/commit-reach.c
index b3b1f62aba..657a4e9b5a 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -258,23 +258,27 @@ static struct commit_list *get_merge_bases_many_0(struct repository *r,
 	return result;
 }
 
-struct commit_list *get_merge_bases_many(struct commit *one,
-					 int n,
-					 struct commit **twos)
+struct commit_list *repo_get_merge_bases_many(struct repository *r,
+					      struct commit *one,
+					      int n,
+					      struct commit **twos)
 {
-	return get_merge_bases_many_0(the_repository, one, n, twos, 1);
+	return get_merge_bases_many_0(r, one, n, twos, 1);
 }
 
-struct commit_list *get_merge_bases_many_dirty(struct commit *one,
-					       int n,
-					       struct commit **twos)
+struct commit_list *repo_get_merge_bases_many_dirty(struct repository *r,
+						    struct commit *one,
+						    int n,
+						    struct commit **twos)
 {
-	return get_merge_bases_many_0(the_repository, one, n, twos, 0);
+	return get_merge_bases_many_0(r, one, n, twos, 0);
 }
 
-struct commit_list *get_merge_bases(struct commit *one, struct commit *two)
+struct commit_list *repo_get_merge_bases(struct repository *r,
+					 struct commit *one,
+					 struct commit *two)
 {
-	return get_merge_bases_many_0(the_repository, one, 1, &two, 1);
+	return get_merge_bases_many_0(r, one, 1, &two, 1);
 }
 
 /*
diff --git a/commit-reach.h b/commit-reach.h
index 7d313e2975..52667d64ac 100644
--- a/commit-reach.h
+++ b/commit-reach.h
@@ -8,17 +8,23 @@ struct commit_list;
 struct contains_cache;
 struct ref_filter;
 
-struct commit_list *get_merge_bases_many(struct commit *one,
-					 int n,
-					 struct commit **twos);
-struct commit_list *get_merge_bases_many_dirty(struct commit *one,
-					       int n,
-					       struct commit **twos);
-struct commit_list *get_merge_bases(struct commit *one, struct commit *two);
-struct commit_list *get_octopus_merge_bases(struct commit_list *in);
-
+struct commit_list *repo_get_merge_bases(struct repository *r,
+					 struct commit *rev1,
+					 struct commit *rev2);
+struct commit_list *repo_get_merge_bases_many(struct repository *r,
+					      struct commit *one, int n,
+					      struct commit **twos);
 /* To be used only when object flags after this call no longer matter */
-struct commit_list *get_merge_bases_many_dirty(struct commit *one, int n, struct commit **twos);
+struct commit_list *repo_get_merge_bases_many_dirty(struct repository *r,
+						    struct commit *one, int n,
+						    struct commit **twos);
+#ifndef NO_THE_REPOSITORY_COMPATIBILITY_MACROS
+#define get_merge_bases(r1, r2)           repo_get_merge_bases(the_repository, r1, r2)
+#define get_merge_bases_many(one, n, two) repo_get_merge_bases_many(the_repository, one, n, two)
+#define get_merge_bases_many_dirty(one, n, twos) repo_get_merge_bases_many_dirty(the_repository, one, n, twos)
+#endif
+
+struct commit_list *get_octopus_merge_bases(struct commit_list *in);
 
 int is_descendant_of(struct commit *commit, struct commit_list *with_commit);
 int in_merge_bases_many(struct commit *commit, int nr_reference, struct commit **reference);
diff --git a/contrib/coccinelle/the_repository.pending.cocci b/contrib/coccinelle/the_repository.pending.cocci
index b185fe0a1d..f6c2915a4e 100644
--- a/contrib/coccinelle/the_repository.pending.cocci
+++ b/contrib/coccinelle/the_repository.pending.cocci
@@ -64,3 +64,29 @@ expression E;
 - parse_commit(
 + repo_parse_commit(the_repository,
   E)
+
+@@
+expression E;
+expression F;
+@@
+- get_merge_bases(
++ repo_get_merge_bases(the_repository,
+  E, F);
+
+@@
+expression E;
+expression F;
+expression G;
+@@
+- get_merge_bases_many(
++ repo_get_merge_bases_many(the_repository,
+  E, F, G);
+
+@@
+expression E;
+expression F;
+expression G;
+@@
+- get_merge_bases_many_dirty(
++ repo_get_merge_bases_many_dirty(the_repository,
+  E, F, G);
-- 
2.19.1.1215.g8438c0b245-goog

