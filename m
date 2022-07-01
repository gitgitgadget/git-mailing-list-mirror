Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B1C1C43334
	for <git@archiver.kernel.org>; Fri,  1 Jul 2022 01:34:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbiGABes (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 21:34:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiGABep (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 21:34:45 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAAD353EC2
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 18:34:44 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id o18so971474plg.2
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 18:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=caiS/2cEqzMSrQqdnrCsMzaqUS2sb3KBZx7gzXl3s7Q=;
        b=4jVVt7UM95NtX6IqmyO9TH4R3mS2r9MoW6PvBSUz2Tk/CwTSSD2jC9IcmgkCeZRuFe
         VFdQ3HzujaN0bvYRTLInn0i0lbNgLAAaAIQ1spEcIZlP3sV+3FOmSqiLXvyHo0uF+bly
         xo+bQIU4/HE1ZpZ1TQNT+3/no+OHI9V66QEr+8nsCYN2THi3XtYjC1BLJf05OegznDO6
         ES8uFnSJbyMqlqgvxqjTtp5kcLy8mgoFhKZoxQRwm29yfiHOMMrKB7Lf0OHS2qBtRwgS
         nmCghnDl0HX6rcwO4uY5IdSoUbAcYXpjrECsjn+e58Q8kg8HehB42695v4zI3SLiih7+
         /Utw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=caiS/2cEqzMSrQqdnrCsMzaqUS2sb3KBZx7gzXl3s7Q=;
        b=vfupLegP1MaoFJVvzCXL0naByW1JMCdqFM0kXyO6L4lxOkTI9YP7J9ao75n3h7w1eP
         2t/NALQVewwKNJZdI9mZS27OfH5G+zywsAoK7jRiTxwTSgsRZs7GzXLs72cu+WgV5Wen
         REC+AIHNOL79O4um+f4yrdNyX+nokPyQqrcRH1TdbqKjyn4VdFxRThfLRMFkihseuyxX
         FW2yD+QJ1H3dxbtluC3uhR/+pBsWshRuSsZ5ELCr4AeaKX7o6fED3Soux85C8eDQNho1
         doBRxKkj1tRg/mDVX/lfy9winw5+3gfxYV4XI48iTCKpAmsjqi8ivZWzoYMmxQtCWwF2
         q5PA==
X-Gm-Message-State: AJIora9qeLfYWMU6O8LBWhYp0nWLQXbsSGWPydN/RRNm9JZvupyqjEhK
        JfdL/FuycQ8/gjMaecbxcEeTJQ==
X-Google-Smtp-Source: AGRyM1uSDGwmLqds9Jsfixm/xaQKZSxIUGoSCAStqN/3I1X2psguhG2G9GB1w8PNwpHe1CvpYX0rdA==
X-Received: by 2002:a17:902:6b0b:b0:16a:5c43:9aa6 with SMTP id o11-20020a1709026b0b00b0016a5c439aa6mr17291004plk.91.1656639284267;
        Thu, 30 Jun 2022 18:34:44 -0700 (PDT)
Received: from JMHNXMC7VH.bytedance.net ([139.177.225.243])
        by smtp.gmail.com with ESMTPSA id k2-20020a17090a658200b001ef3cec7f47sm2245820pjj.52.2022.06.30.18.34.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 30 Jun 2022 18:34:44 -0700 (PDT)
From:   Han Xin <hanxin.hx@bytedance.com>
To:     hanxin.hx@bytedance.com
Cc:     chiyutianyi@gmail.com, derrickstolee@github.com,
        git@vger.kernel.org, haiyangtand@gmail.com,
        jonathantanmy@google.com, me@ttaylorr.com,
        Junio C Hamano <gitster@pobox.com>, ps@pks.im
Subject: [PATCH v4 1/1] commit-graph.c: no lazy fetch in lookup_commit_in_graph()
Date:   Fri,  1 Jul 2022 09:34:30 +0800
Message-Id: <96d4bb71505d87ed501c058bbd89bfc13d08b24a.1656593279.git.hanxin.hx@bytedance.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1656593279.git.hanxin.hx@bytedance.com>
References: <cover.1656381667.git.hanxin.hx@bytedance.com> <cover.1656593279.git.hanxin.hx@bytedance.com>
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
 t/t5330-no-lazy-fetch-with-commit-graph.sh | 70 ++++++++++++++++++++++
 2 files changed, 71 insertions(+), 1 deletion(-)
 create mode 100755 t/t5330-no-lazy-fetch-with-commit-graph.sh

diff --git a/commit-graph.c b/commit-graph.c
index 92d4503336..2b04ef072d 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -898,7 +898,7 @@ struct commit *lookup_commit_in_graph(struct repository *repo, const struct obje
 		return NULL;
 	if (!search_commit_pos_in_graph(id, repo->objects->commit_graph, &pos))
 		return NULL;
-	if (!repo_has_object_file(repo, id))
+	if (!has_object(repo, id, 0))
 		return NULL;
 
 	commit = lookup_commit(repo, id);
diff --git a/t/t5330-no-lazy-fetch-with-commit-graph.sh b/t/t5330-no-lazy-fetch-with-commit-graph.sh
new file mode 100755
index 0000000000..be33334229
--- /dev/null
+++ b/t/t5330-no-lazy-fetch-with-commit-graph.sh
@@ -0,0 +1,70 @@
+#!/bin/sh
+
+test_description='test for no lazy fetch with the commit-graph'
+
+. ./test-lib.sh
+
+run_with_limited_processses () {
+	# bash and ksh use "ulimit -u", dash uses "ulimit -p"
+	if test -n "$BASH_VERSION"
+	then
+		ulimit_max_process="-u"
+	elif test -n "$KSH_VERSION"
+	then
+		ulimit_max_process="-u"
+	fi
+	(ulimit ${ulimit_max_process-"-p"} 512 && "$@")
+}
+
+test_lazy_prereq ULIMIT_PROCESSES '
+	run_with_limited_processses true
+'
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
+	git -C with-commit-graph cat-file -e $oid &&
+	echo "$(pwd)/without-commit/objects" \
+		>with-commit-graph/.git/objects/info/alternates &&
+	test_must_fail git -C with-commit-graph cat-file -e $oid
+'
+
+test_expect_success 'fetch any commit from promisor with the usage of the commit graph' '
+	# setup promisor and prepare any commit to fetch
+	git -C with-commit-graph remote add origin "$(pwd)/with-commit" &&
+	git -C with-commit-graph config remote.origin.promisor true &&
+	git -C with-commit-graph config remote.origin.partialclonefilter blob:none &&
+	test_commit -C with-commit any-commit &&
+	anycommit=$(git -C with-commit rev-parse HEAD) &&
+
+	run_with_limited_processses env GIT_TRACE="$(pwd)/trace.txt" \
+		git -C with-commit-graph fetch origin $anycommit 2>err &&
+	! grep "fatal: promisor-remote: unable to fork off fetch subprocess" err &&
+	grep "git fetch origin" trace.txt >actual &&
+	test_line_count = 1 actual
+'
+
+test_done
-- 
2.36.1

