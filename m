Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25631C433EF
	for <git@archiver.kernel.org>; Fri, 24 Jun 2022 05:29:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbiFXF26 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jun 2022 01:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231446AbiFXF2z (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jun 2022 01:28:55 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41ED568034
        for <git@vger.kernel.org>; Thu, 23 Jun 2022 22:28:54 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id o18so1188234plg.2
        for <git@vger.kernel.org>; Thu, 23 Jun 2022 22:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tvDbpF3jl9jqRJ7Uj9hcAM4/uPMrWiVTqy6urbJ5Ue0=;
        b=z2n1FuFaX/+1a+GFEOwBuleo+3ul402+BVHdpvQXpKjm1zw+fHRL52EZiGlHd/ZiQ3
         Cc7+9IqTGmZL5ba8SLwc4wM0E2du57msHFdxLzo/ayDiUrbgqOiP9izrSBfMKm6DTGsa
         /qOjEoXYofGqPEs34OqPqCQGrkV7iXI/YUl5s0yMESZMghrwWX8OHM6P6MZVP/bHoMll
         DlobOMLQbeNf5HndGNj+iHe+2QKvoqAfpXNV2uGWi8zp6dYydoPWD4f2BHtUnI7bULvh
         fXCVTbtNX1WIYLtmiWt8Ovy0tyYxZBZ4ORsuozdIbcX9hG2o7Et5D3a4RCJ7Gflp+YS5
         eapA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tvDbpF3jl9jqRJ7Uj9hcAM4/uPMrWiVTqy6urbJ5Ue0=;
        b=UGv5SDSVjVxUWF6TjLFsoY/wQZD79BOnpKgZULzZiV4nCvtpBJSTp+tBRfO+S1YATt
         l3EYJQD7nKfWqCW0AsqutptTM2uTmorEAcRkD8sVXtgFq4tG5/Aaatj0xcxfHIrIMYIJ
         XNuEB05NG+0T+wil0szK33345I4fx5jFbEaA+08++XQRLKOXbFSxD8k0ZCd/ws26hq1t
         JYujn3c7iCvPER4bZsvO0+BmHCkqm14bDWWlZMEnaFXZHqvlOm24VNEurNadcPpPaVl6
         OKdwdnPMfJ6DDe7/bNi4OAfSC0NCpfAH1eKkULbg61L2m9o5KHpXWy3dn+ScAIMS/RX5
         ru+g==
X-Gm-Message-State: AJIora+/L9GD9tQa5RnYrPaGAticI0vQ3bbyMxVkEBtV3uBxizRvSvQi
        oQdLNgMjalcqaIuUwxlDmvF7e0aGKEYegg==
X-Google-Smtp-Source: AGRyM1t7zJWBxWSNMaESaZzP4dL6iInO+BvFVUhQbAAwCutrOMehHM5eOGbROYM1AnmglXh7Xfnp1A==
X-Received: by 2002:a17:902:e381:b0:16a:1b5d:5438 with SMTP id g1-20020a170902e38100b0016a1b5d5438mr26771585ple.147.1656048533524;
        Thu, 23 Jun 2022 22:28:53 -0700 (PDT)
Received: from JMHNXMC7VH.bytedance.net ([139.177.225.243])
        by smtp.gmail.com with ESMTPSA id s144-20020a632c96000000b003c265b7d4f6sm602960pgs.44.2022.06.23.22.28.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 23 Jun 2022 22:28:53 -0700 (PDT)
From:   Han Xin <hanxin.hx@bytedance.com>
To:     hanxin.hx@bytedance.com
Cc:     chiyutianyi@gmail.com, derrickstolee@github.com,
        git@vger.kernel.org, haiyangtand@gmail.com,
        jonathantanmy@google.com, me@ttaylorr.com, ps@pks.im
Subject: [PATCH v2 2/2] commit-graph.c: no lazy fetch in lookup_commit_in_graph()
Date:   Fri, 24 Jun 2022 13:27:57 +0800
Message-Id: <d3a99a5c5ae538b626e04d7069dd2fc316605dfc.1656044659.git.hanxin.hx@bytedance.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1656044659.git.hanxin.hx@bytedance.com>
References: <20220618030130.36419-1-hanxin.hx@bytedance.com> <cover.1656044659.git.hanxin.hx@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If a commit is in the commit graph, we would expect the commit to also
be present. So we should use has_object() instead of
repo_has_object_file(), which will help us avoid getting into an endless
loop of lazy fetch.

When we found the commit in the graph in lookup_commit_in_graph(), but
the commit is missing from the repository, we will try
promisor_remote_get_direct() and then enter another loop. While
sometimes it will finally succeed because it cannot fork subprocess,
it has exhausted the local process resources and can be harmful to the
remote service.

Signed-off-by: Han Xin <hanxin.hx@bytedance.com>
---
 commit-graph.c                             |  2 +-
 t/t5329-no-lazy-fetch-with-commit-graph.sh | 47 ++++++++++++++++++++++
 2 files changed, 48 insertions(+), 1 deletion(-)
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
index 0000000000..4d25d2c950
--- /dev/null
+++ b/t/t5329-no-lazy-fetch-with-commit-graph.sh
@@ -0,0 +1,47 @@
+#!/bin/sh
+
+test_description='test for no lazy fetch with the commit-graph'
+
+. ./test-lib.sh
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
+	test_commit -C with-commit-graph somthing &&
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
+test_expect_success 'setup: prepare another commit to fetch' '
+	test_commit -C with-commit another-commit &&
+	anycommit=$(git -C with-commit rev-parse HEAD)
+'
+
+test_expect_success ULIMIT_PROCESSES 'fetch any commit from promisor with the usage of the commit graph' '
+	git -C with-commit-graph remote add origin "$(pwd)/with-commit" &&
+	git -C with-commit-graph config remote.origin.promisor true &&
+	git -C with-commit-graph config remote.origin.partialclonefilter blob:none &&
+	GIT_TRACE="$(pwd)/trace" run_with_limited_processses \
+		git -C with-commit-graph fetch origin $anycommit 2>err &&
+	test_i18ngrep ! "fatal: promisor-remote: unable to fork off fetch subprocess" err &&
+	test $(grep "fetch origin" trace | wc -l) -eq 1
+'
+
+test_done
-- 
2.36.1

