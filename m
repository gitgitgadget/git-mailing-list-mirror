Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1031C433F5
	for <git@archiver.kernel.org>; Thu, 17 Mar 2022 18:24:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237432AbiCQS0L (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Mar 2022 14:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236934AbiCQS0K (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Mar 2022 14:26:10 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CD5A1DBA8C
        for <git@vger.kernel.org>; Thu, 17 Mar 2022 11:24:53 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id bj8-20020a056a02018800b0035ec8c16f0bso2122565pgb.11
        for <git@vger.kernel.org>; Thu, 17 Mar 2022 11:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=PXmSmrwgLzxilslh5V+52bAzL0DKVQmbXhQoZ7urNGQ=;
        b=E550dVaTG7aVhUkr02wM5FAow7gzu1AwQkgH7BbW47/I0EQEJqzNA/iLPpi8f0+o9x
         uOP0RNZYARgIMrTGevjeabDN7Qk2qgMie/PwYsALxeSElPAiPGEu/Q3OTgmYV4//9ILc
         iLWKE8NUNgQqFwPYAm0D/bJHeg/VeV98Z0G1pRhQcTUV+8w1+AnSg2UAuKvG1Ly1fHQn
         zNMIXzesf8TUxVhjPYveGtc5DFejbBeaT9gQG4JycQVVdV/PCbEfJ6NXz1J1E4CH2z5c
         +aW+xqfIWehQNuvH83smvSarS9sa0Au2q87T/Rja60U6+JbaKBkw2VEr7Hd9Ju/JKNuq
         QbfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=PXmSmrwgLzxilslh5V+52bAzL0DKVQmbXhQoZ7urNGQ=;
        b=Es9IKKqJdYwgkNjHkTPlhJwsupwMavnSaLCphOYsGNcxrjb2TDjEQsRLIeJ6d1AsPX
         4/JTiUmDKXT6OpQOXlok1yvVZgYs5V5NtVmjDIJTdkfU9vJvLtmE4bOd8WP5RpEWOwyA
         XoVI2ogCsyw9hYpYs+hrnMzRxNNRb5iGCPKL2ox9jEoJnIEo0iQoSLB/9616mW4KlJW4
         9mZrDVCzX+03Y/DzR4jgVxJrgt4i1heIG0A+p8Fm1VZy5lCAMwmHTlaZoPhO1/XXNbfR
         /A6JlzR403TUevqcg6WcG7KP8tNgahPXJTt5YZoJYJc0JQzLxvRkI7SzBq/F3fQIweQs
         21hQ==
X-Gm-Message-State: AOAM531wjm7FaxeTW6xVzZZmHbEDt1mLs8XwpCYx1atd4YhGI9E80kJT
        DqYGF/k8Hu/dNsO2Gyr4RDZb41vtSJG9M/OhJtKWiBHhyLR2QRGPqO9Q4sjtND5yG6pSxSKioka
        jlv5/YWY+AaHiOXFqtcPHOrx8go81ItjSBRajO/XhfYZvRVEi40PXubBAh1lwVpHS3VFBD2rmhu
        MC
X-Google-Smtp-Source: ABdhPJx2hYwGpcFo6mpUV8tz7ueZXWlZDnlWPmFarf8ZjhOM9/oQ/nUY58QLUTBVR3APUrybqpu3+qadYpwTSccgcXDT
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:902:cf02:b0:14f:e0c2:1514 with
 SMTP id i2-20020a170902cf0200b0014fe0c21514mr6030171plg.90.1647541492389;
 Thu, 17 Mar 2022 11:24:52 -0700 (PDT)
Date:   Thu, 17 Mar 2022 11:24:47 -0700
Message-Id: <20220317182448.1633847-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.894.gb6a874cedc-goog
Subject: [PATCH] shallow: reset commit grafts when shallow is reset
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, chooglen@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When reset_repository_shallow() is called, Git clears its cache of
shallow information, so that if shallow information is re-requested, Git
will read fresh data from disk instead of reusing its stale cached data.
However, the cache of commit grafts is not likewise cleared, even though
there are commit grafts created from shallow information.

This means that if on-disk shallow information were to be updated and
then a commit-graft-using codepath were run (for example, a revision
walk), Git would be using stale commit graft information. This can be
seen from the test in this patch, in which Git performs a revision walk
(to check for changed submodules) after a fetch with --update-shallow.

Therefore, clear the cache of commit grafts whenever
reset_repository_shallow() is called.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
This is the same bug noticed by Glen Choo, as can be seen by the patch
here [1]. (That patch doesn't seem to be carried forward to subsequent
versions of the patch set, presumably because it is not needed in that
patch set.)

I have verified that Glen's test also works with the fix in this patch.
But I have written a test in t5537-fetch-shallow instead, as I think
that this is more about updating shallows than fetching submodules.

[1] https://lore.kernel.org/git/20220215172318.73533-9-chooglen@google.com/
---
 commit.c                 | 10 ++++++++++
 commit.h                 |  1 +
 shallow.c                |  1 +
 submodule.c              |  1 +
 t/t5537-fetch-shallow.sh |  9 +++++++++
 5 files changed, 22 insertions(+)

diff --git a/commit.c b/commit.c
index d400f5dfa2..f8405fe46e 100644
--- a/commit.c
+++ b/commit.c
@@ -249,6 +249,16 @@ int for_each_commit_graft(each_commit_graft_fn fn, void *cb_data)
 	return ret;
 }
 
+void reset_commit_grafts(struct repository *r)
+{
+	int i;
+
+	for (i = 0; i < r->parsed_objects->grafts_nr; i++)
+		free(r->parsed_objects->grafts[i]);
+	r->parsed_objects->grafts_nr = 0;
+	r->parsed_objects->commit_graft_prepared = 0;
+}
+
 struct commit_buffer {
 	void *buffer;
 	unsigned long size;
diff --git a/commit.h b/commit.h
index 38cc542661..336e0bfa42 100644
--- a/commit.h
+++ b/commit.h
@@ -249,6 +249,7 @@ int commit_graft_pos(struct repository *r, const struct object_id *oid);
 int register_commit_graft(struct repository *r, struct commit_graft *, int);
 void prepare_commit_graft(struct repository *r);
 struct commit_graft *lookup_commit_graft(struct repository *r, const struct object_id *oid);
+void reset_commit_grafts(struct repository *r);
 
 struct commit *get_fork_point(const char *refname, struct commit *commit);
 
diff --git a/shallow.c b/shallow.c
index 71e5876f37..e158be58b0 100644
--- a/shallow.c
+++ b/shallow.c
@@ -90,6 +90,7 @@ static void reset_repository_shallow(struct repository *r)
 {
 	r->parsed_objects->is_shallow = -1;
 	stat_validity_clear(r->parsed_objects->shallow_stat);
+	reset_commit_grafts(r);
 }
 
 int commit_shallow_file(struct repository *r, struct shallow_lock *lk)
diff --git a/submodule.c b/submodule.c
index 5ace18a7d9..7a0515913c 100644
--- a/submodule.c
+++ b/submodule.c
@@ -22,6 +22,7 @@
 #include "parse-options.h"
 #include "object-store.h"
 #include "commit-reach.h"
+#include "shallow.h"
 
 static int config_update_recurse_submodules = RECURSE_SUBMODULES_OFF;
 static int initialized_fetch_ref_tips;
diff --git a/t/t5537-fetch-shallow.sh b/t/t5537-fetch-shallow.sh
index 11d5ea54a9..92948de7a0 100755
--- a/t/t5537-fetch-shallow.sh
+++ b/t/t5537-fetch-shallow.sh
@@ -161,6 +161,15 @@ test_expect_success 'fetch --update-shallow' '
 	)
 '
 
+test_expect_success 'fetch --update-shallow into a repo with submodules' '
+	git init a-submodule &&
+	test_commit -C a-submodule foo &&
+	git init repo-with-sub &&
+	git -C repo-with-sub submodule add ../a-submodule a-submodule &&
+	git -C repo-with-sub commit -m "added submodule" &&
+	git -C repo-with-sub fetch --update-shallow ../shallow/.git refs/heads/*:refs/remotes/shallow/*
+'
+
 test_expect_success 'fetch --update-shallow (with fetch.writeCommitGraph)' '
 	(
 	cd shallow &&
-- 
2.35.1.894.gb6a874cedc-goog

