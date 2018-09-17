Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 579B41F404
	for <e@80x24.org>; Mon, 17 Sep 2018 21:36:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728668AbeIRDF1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Sep 2018 23:05:27 -0400
Received: from mail-io1-f73.google.com ([209.85.166.73]:43585 "EHLO
        mail-io1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728564AbeIRDF1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Sep 2018 23:05:27 -0400
Received: by mail-io1-f73.google.com with SMTP id w19-v6so19928251ioa.10
        for <git@vger.kernel.org>; Mon, 17 Sep 2018 14:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=TniJD7JODSLZpF0IMCAmfYzJECJnfUzycru4/HQVYAQ=;
        b=H4U0at3Y064rW16YPMhZRCFu5x75Zd0W4Nnx6xrO3auAsIaOuvIyYiJmLBFAlfRB77
         KrM9cj0lyZs9lDM1+ef2Ne/BTGNwthuwibzigMEbpTt16EuBaroVJhkK8oPoMyHRMXan
         MLGqWRunEYd9zalSQK2Ob//IHnmm3pO566OGBxBLz7g8Aqjx7aKfRVTta1VblbZUsd6h
         HqbTk5qxhcjvd9lSG15R0stRSGzXUNhhHj0PSjJR05J6H/4zNA+HgHrb/DdNulUs7kR9
         VkUDbc6J3zC3embULpt1ZG7q9dw4zIqhjUOMBx8vOx7yOKpC/2rm9VtR1jF87CPNpQ2T
         MOcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=TniJD7JODSLZpF0IMCAmfYzJECJnfUzycru4/HQVYAQ=;
        b=WJVkpiYSHi2dvVhFlQLc3clkwNsg+vO6L4XG9vLJpMhQMQ55GwgIaCrtb7ZFCLSXQO
         4msQjMZB3IsvzdqiWmi/wuLIYE+DoNwK0KLVu/2ZtPf9OZZb7qdBtxPfCfFOL45wr+JU
         byHKW8C1iN/g7JmxZwqbyjY5o18knzttZxB/IaPPo0aQxHQrNqskNxJgEgunHuCMYD+a
         vCKyoSrIJu0Y63O8IABG5D9zz1uQmz5FoasDbM4aFjRZIuIxKsawgnEUA6cK+wsTDZxx
         JkdbzdJSGQM7FImitsb0Xi+6eLCxZ3Spx5r469k67JhoMJyUH14tQTazY1F9mNpBfJcv
         xEtQ==
X-Gm-Message-State: APzg51CUMptBzZmDdBzIcDYucCGDXlw6l7Vj6phN6yJTKTi3tDjbfWQc
        ZxSICkpEeqkn3SILjEl7hge+E56Zf8kV
X-Google-Smtp-Source: ANB0VdbljlM3hTCsut+YlMmVorO72Ckq8TXK0zvBF4lf0YCk2uxafLs4U6XANJvQkNI2UM4ZazdUrl5L2V+5
X-Received: by 2002:a24:9f84:: with SMTP id c126-v6mr12510847ite.29.1537220176975;
 Mon, 17 Sep 2018 14:36:16 -0700 (PDT)
Date:   Mon, 17 Sep 2018 14:35:56 -0700
In-Reply-To: <20180917213559.126404-1-sbeller@google.com>
Message-Id: <20180917213559.126404-7-sbeller@google.com>
Mime-Version: 1.0
References: <20180911234951.14129-1-sbeller@google.com> <20180917213559.126404-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.0.444.g18242da7ef-goog
Subject: [PATCH 6/9] submodule.c: do not copy around submodule list
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

'calculate_changed_submodule_paths' uses a local list to compute the
changed submodules, and then produces the result by copying appropriate
items into the result list.

Instead use the result list directly and prune items afterwards
using string_list_remove_empty_items.

By doing so we'll have access to the util pointer for longer that
contains the commits that we need to fetch, which will be
useful in a later patch.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/submodule.c b/submodule.c
index 3520dd76bdf..00a9a3c6b12 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1128,8 +1128,7 @@ static void calculate_changed_submodule_paths(
 	struct submodule_parallel_fetch *spf)
 {
 	struct argv_array argv = ARGV_ARRAY_INIT;
-	struct string_list changed_submodules = STRING_LIST_INIT_DUP;
-	const struct string_list_item *name;
+	struct string_list_item *name;
 
 	/* No need to check if there are no submodules configured */
 	if (!submodule_from_path(the_repository, NULL, NULL))
@@ -1146,9 +1145,9 @@ static void calculate_changed_submodule_paths(
 	 * Collect all submodules (whether checked out or not) for which new
 	 * commits have been recorded upstream in "changed_submodule_names".
 	 */
-	collect_changed_submodules(&changed_submodules, &argv);
+	collect_changed_submodules(&spf->changed_submodule_names, &argv);
 
-	for_each_string_list_item(name, &changed_submodules) {
+	for_each_string_list_item(name, &spf->changed_submodule_names) {
 		struct oid_array *commits = name->util;
 		const struct submodule *submodule;
 		const char *path = NULL;
@@ -1162,12 +1161,14 @@ static void calculate_changed_submodule_paths(
 		if (!path)
 			continue;
 
-		if (!submodule_has_commits(path, commits))
-			string_list_append(&spf->changed_submodule_names,
-					   name->string);
+		if (submodule_has_commits(path, commits)) {
+			oid_array_clear(commits);
+			*name->string = '\0';
+		}
 	}
 
-	free_submodules_oids(&changed_submodules);
+	string_list_remove_empty_items(&spf->changed_submodule_names, 1);
+
 	argv_array_clear(&argv);
 	oid_array_clear(&ref_tips_before_fetch);
 	oid_array_clear(&ref_tips_after_fetch);
@@ -1363,7 +1364,7 @@ int fetch_populated_submodules(struct repository *r,
 
 	argv_array_clear(&spf.args);
 out:
-	string_list_clear(&spf.changed_submodule_names, 1);
+	free_submodules_oids(&spf.changed_submodule_names);
 	return spf.result;
 }
 
-- 
2.19.0.397.gdd90340f6a-goog

