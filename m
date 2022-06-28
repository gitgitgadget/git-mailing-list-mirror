Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61E52C43334
	for <git@archiver.kernel.org>; Tue, 28 Jun 2022 02:03:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243318AbiF1CDk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jun 2022 22:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243250AbiF1CDO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jun 2022 22:03:14 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4FCFDFBF
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 19:03:13 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id m14-20020a17090a668e00b001ee6ece8368so5061712pjj.3
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 19:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NrWrTDpN2me7QTqEcAXuTa/S3fve06wLUs+z7oFd8hA=;
        b=0evJ3AN/q05n4BYiGKXdTm5mMu0nvFtqCcxYpRSbI7wv9I0I/MEn4fpr4OnsP1lshM
         rTJKKpZ8ATXrNKLjK/BB0ZEggG+zIJw+T5ALfowvvJsY9QXdL8xKGQS1C8fXUi6/8jOc
         mLvFT47fkNV96bEf1ZIsU9UbD7RTBOtHTsIkpll9CPwGjQQk5IbjpSwRezvx335ZCPkP
         JNQDHQKRiY5/OSuto0hwooV0olOW63tewdoN5aYYxxVs3qE7hYNcNc+uqXmhsIA6XudI
         9gUBd2/ubldwNsXiWIdH6IBKoy7uTYwrIf/sUq8gPRDpzKmxlhBSoPMxL9xln7xHNmFN
         8Ypw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NrWrTDpN2me7QTqEcAXuTa/S3fve06wLUs+z7oFd8hA=;
        b=FDhjFAx3RPdxqEkIVS+m5r1qpnGoU9SV54pOzSVcqLO7PFvDkp7G2WCesx8+0mtUn3
         HBJXnssjmVoRUkkkl+3Y4OwUzleDlwtbagHRZj9ooo0734kUPsxY/RPeEux/nLTYS2cU
         9j4EsI7RCWwgiCMtzkZo+2LiHbnhUZrZmMvBhmQ792wkEykTlJ8irjv1m57leePd6DTw
         tFHrKYb2hmFJC7m+rKEPPRFGgX1xwNCgjK5I+EtylJyDd00GKcJ+Zy24o4+btY9Lph40
         Fbhi8IjWxxcf4JJWnxhvSWvIJ9NLWoRiai4TGiorXheGNQe71NskC6beIFozLt8bWF0q
         1Jmw==
X-Gm-Message-State: AJIora+gAEdPZp/wzn1z3NeMnHe+nNPBoIwZq377u2ALwXo6FznR9oL0
        U4IEpD0CDYserRzHbeh4ow1jdw==
X-Google-Smtp-Source: AGRyM1vODxVvj6obM0ni2ukYsKHgxIcIsKn7MPaeAX4P5g1ePZbR8ndSKrpEXTzuC9CDJZ48aY3bEg==
X-Received: by 2002:a17:903:32c4:b0:16a:6b37:7cbe with SMTP id i4-20020a17090332c400b0016a6b377cbemr1220900plr.30.1656381793061;
        Mon, 27 Jun 2022 19:03:13 -0700 (PDT)
Received: from JMHNXMC7VH.bytedance.net ([139.177.225.227])
        by smtp.gmail.com with ESMTPSA id n18-20020a63f812000000b0040c33cb0ccasm7823744pgh.42.2022.06.27.19.03.09
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 27 Jun 2022 19:03:12 -0700 (PDT)
From:   Han Xin <hanxin.hx@bytedance.com>
To:     hanxin.hx@bytedance.com
Cc:     chiyutianyi@gmail.com, derrickstolee@github.com,
        git@vger.kernel.org, haiyangtand@gmail.com,
        jonathantanmy@google.com, me@ttaylorr.com,
        Junio C Hamano <gitster@pobox.com>, ps@pks.im
Subject: [PATCH v3 2/2] commit-graph.c: no lazy fetch in lookup_commit_in_graph()
Date:   Tue, 28 Jun 2022 10:02:52 +0800
Message-Id: <3cdb1abd43779844b8e8dc094e2fd2da1adc461a.1656381667.git.hanxin.hx@bytedance.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1656381667.git.hanxin.hx@bytedance.com>
References: <cover.1656044659.git.hanxin.hx@bytedance.com> <cover.1656381667.git.hanxin.hx@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The commit-graph is used to opportunistically optimize accesses to
certain pieces of information on commit objects, and
lookup_commit_in_graph() tries to say "no" when the requested commit
does not locally exist by returning NULL, in which case the caller
can ask for (which may result in on-demand fetching from a promisor
remote) and parse the commit object itself.

However, it uses a wrong helper, repo_has_object_file(), to do so.
This helper not only checks if an object is mmediately available in
the local object store, but also tries to fetch from a promisor remote.
But the fetch machinery calls lookup_commit_in_graph(), thus causing an
infinite loop.

We should make lookup_commit_in_graph() expect that a commit given to it
can be legitimately missing from the local object store, by using the
has_object_file() helper instead.

Signed-off-by: Han Xin <hanxin.hx@bytedance.com>
---
 commit-graph.c                             |  2 +-
 t/t5329-no-lazy-fetch-with-commit-graph.sh | 53 ++++++++++++++++++++++
 2 files changed, 54 insertions(+), 1 deletion(-)
 create mode 100755 t/t5329-no-lazy-fetch-with-commit-graph.sh

diff --git a/commit-graph.c b/commit-graph.c
index 2b52818731..2dd9bcc7ea 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -907,7 +907,7 @@ struct commit *lookup_commit_in_graph(struct repository *repo, const struct obje
 		return NULL;
 	if (!search_commit_pos_in_graph(id, repo->objects->commit_graph, &pos))
 		return NULL;
-	if (!repo_has_object_file(repo, id))
+	if (!has_object(repo, id, 0))
 		return NULL;
 
 	commit = lookup_commit(repo, id);
diff --git a/t/t5329-no-lazy-fetch-with-commit-graph.sh b/t/t5329-no-lazy-fetch-with-commit-graph.sh
new file mode 100755
index 0000000000..d7877a5758
--- /dev/null
+++ b/t/t5329-no-lazy-fetch-with-commit-graph.sh
@@ -0,0 +1,53 @@
+#!/bin/sh
+
+test_description='test for no lazy fetch with the commit-graph'
+
+. ./test-lib.sh
+
+if ! test_have_prereq ULIMIT_PROCESSES
+then
+	skip_all='skipping tests for no lazy fetch with the commit-graph, ulimit processes not available'
+	test_done
+fi
+
+test_expect_success 'setup: prepare a repository with a commit' '
+	git init with-commit &&
+	test_commit -C with-commit the-commit &&
+	oid=$(git -C with-commit rev-parse HEAD)
+'
+
+test_expect_success 'setup: prepare a repository with commit-graph contains the commit' '
+	git init with-commit-graph &&
+	echo "$(pwd)/with-commit/.git/objects" \
+		>with-commit-graph/.git/objects/info/alternates &&
+	# create a ref that points to the commit in alternates
+	git -C with-commit-graph update-ref refs/ref_to_the_commit "$oid" &&
+	# prepare some other objects to commit-graph
+	test_commit -C with-commit-graph something &&
+	git -c gc.writeCommitGraph=true -C with-commit-graph gc &&
+	test_path_is_file with-commit-graph/.git/objects/info/commit-graph
+'
+
+test_expect_success 'setup: change the alternates to what without the commit' '
+	git init --bare without-commit &&
+	echo "$(pwd)/without-commit/objects" \
+		>with-commit-graph/.git/objects/info/alternates &&
+	test_must_fail git -C with-commit-graph cat-file -e $oid
+'
+
+test_expect_success 'setup: prepare any commit to fetch' '
+	test_commit -C with-commit any-commit &&
+	anycommit=$(git -C with-commit rev-parse HEAD)
+'
+
+test_expect_success 'fetch any commit from promisor with the usage of the commit graph' '
+	git -C with-commit-graph remote add origin "$(pwd)/with-commit" &&
+	git -C with-commit-graph config remote.origin.promisor true &&
+	git -C with-commit-graph config remote.origin.partialclonefilter blob:none &&
+	run_with_limited_processses env GIT_TRACE="$(pwd)/trace" \
+		git -C with-commit-graph fetch origin $anycommit 2>err &&
+	test_i18ngrep ! "fatal: promisor-remote: unable to fork off fetch subprocess" err &&
+	test $(grep "fetch origin" trace | wc -l) -eq 1
+'
+
+test_done
-- 
2.36.1

