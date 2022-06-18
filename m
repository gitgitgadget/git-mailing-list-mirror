Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0F29C43334
	for <git@archiver.kernel.org>; Sat, 18 Jun 2022 03:02:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383989AbiFRDCB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jun 2022 23:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383680AbiFRDB5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jun 2022 23:01:57 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E6A66C54F
        for <git@vger.kernel.org>; Fri, 17 Jun 2022 20:01:56 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id b12-20020a17090a6acc00b001ec2b181c98so4477897pjm.4
        for <git@vger.kernel.org>; Fri, 17 Jun 2022 20:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z/7F/ITDqmPq56GXMZ80S93DQpqjKQ3DEa9AGG0oXyw=;
        b=q8iwVAjLvgV7/xzcf6Wfip6aQ4sbLkqaP6H1DOF0mBBkz3+v9JAtUiWej2P8HqAJJG
         w+80B31K5+AP6L0QuKd9OBkEA0O5r98QT0nXrpCJAJO0CRO8FDYZYhvarwTzljAWzdJK
         T2ByYxJdNuZeYmpKufT/ClRec6sMc6ZSowiib3O5ESSt53VyfvawEX9/mjfSYI091rfS
         T8C52GrhWjrdNPIac31TMpBcRsEg9tMj/GI3UAgJdp3KOKFSOTGfNCK5Mufwdm3p5EcP
         YXyMyetPPYQZQg7dS/kPNjxI2WMavuwrw8hUuwfEkgj5eeF9Iy2YM+r5IPWyD32CiO75
         RUqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z/7F/ITDqmPq56GXMZ80S93DQpqjKQ3DEa9AGG0oXyw=;
        b=re7LnJaCh7qUmPKQ3CT/UIQhcmP7lxQ9QvBwwLHSGZibDNh4idAIDxjqOxtVP6t6TO
         23TB28sB8o1VDS6vxQCaWK4SmjV5Kk6p9UwtApKoTbeGUCXjpNPrj8BvFhkck+V1emlM
         J7ezl6R1BH7a72ryucAIIiYduiDhYEzruFUHDZ1OZ6styUUuxpaVFtmL8Sit6E4bqehQ
         bFvciukGWtfxTGwwn9Co3Y1tpiHNWj6JKN2xiqCeHL0gp/eAZSQy45ghYVVbf97dLApx
         w9GovUITvnKhnDClidBFjigFLrdbGgU1BWZZwMH6MCsdKlL+1haVUYfe6V/ViGGLHsU8
         Rtzg==
X-Gm-Message-State: AJIora8LOC3NO2YqQIm+XqtD44Uon1BsAvkEFnWCzxOTv6AGDXdvcP95
        kcaTlxmWPB3k67LqWEEeO/WnwffQ4hQOYuUR
X-Google-Smtp-Source: AGRyM1sDW+gmUgu7Pz+jcoPO/R9gMalII9ZUrUJGZ+72Vw79j85IF3cadFHanVot/uT9zZOM+rol0w==
X-Received: by 2002:a17:90b:3a87:b0:1e8:789d:c60 with SMTP id om7-20020a17090b3a8700b001e8789d0c60mr13769819pjb.77.1655521315689;
        Fri, 17 Jun 2022 20:01:55 -0700 (PDT)
Received: from localhost.localdomain ([2409:8a28:809:e270:4502:67a3:f75:2bfb])
        by smtp.gmail.com with ESMTPSA id ix6-20020a170902f80600b001615f64aaabsm4187874plb.244.2022.06.17.20.01.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 17 Jun 2022 20:01:55 -0700 (PDT)
From:   Han Xin <hanxin.hx@bytedance.com>
To:     hanxin.hx@bytedance.com
Cc:     chiyutianyi@gmail.com, derrickstolee@github.com,
        git@vger.kernel.org, haiyangtand@gmail.com,
        jonathantanmy@google.com, me@ttaylorr.com, ps@pks.im
Subject: [PATCH v1] commit-graph.c: no lazy fetch in lookup_commit_in_graph()
Date:   Sat, 18 Jun 2022 11:01:30 +0800
Message-Id: <20220618030130.36419-1-hanxin.hx@bytedance.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1655350442.git.hanxin.hx@bytedance.com>
References: <cover.1655350442.git.hanxin.hx@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If a commit is in the commit graph, we would expect the commit to also
be present. So we should use has_object() instead of
repo_has_object_file(), which will help us avoid getting into an endless
loop of lazy fetch.

We can see the endless loop issue via this[1].

1. https://lore.kernel.org/git/20220612161707.21807-1-chiyutianyi@gmail.com/

Signed-off-by: Han Xin <hanxin.hx@bytedance.com>
---
 commit-graph.c                             |  2 +-
 t/t5329-no-lazy-fetch-with-commit-graph.sh | 50 ++++++++++++++++++++++
 2 files changed, 51 insertions(+), 1 deletion(-)
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
index 0000000000..ea5940b9f1
--- /dev/null
+++ b/t/t5329-no-lazy-fetch-with-commit-graph.sh
@@ -0,0 +1,50 @@
+#!/bin/sh
+
+test_description='test for no lazy fetch with the commit-graph'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	git init --bare dest.git &&
+	test_commit one &&
+	git checkout -b tmp &&
+	test_commit two &&
+	git push dest.git --all
+'
+
+test_expect_success 'prepare a alternates repository without commit two' '
+	git clone --bare dest.git alternates &&
+	oid=$(git -C alternates rev-parse refs/heads/tmp) &&
+	git -C alternates update-ref -d refs/heads/tmp &&
+	git -C alternates gc --prune=now &&
+	pack=$(echo alternates/objects/pack/*.pack) &&
+	git verify-pack -v "$pack" >have &&
+	! grep "$oid" have
+'
+
+test_expect_success 'prepare a repository with a commit-graph contains commit two' '
+	git init source &&
+	echo "$(pwd)/dest.git/objects" >source/.git/objects/info/alternates &&
+	git -C source remote add origin "$(pwd)/dest.git" &&
+	git -C source config remote.origin.promisor true &&
+	git -C source config remote.origin.partialclonefilter blob:none &&
+	# the source repository has the whole refs contains refs/heads/tmp
+	git -C source fetch origin &&
+	(
+		cd source &&
+		test_commit three &&
+		git -c gc.writeCommitGraph=true gc
+	)
+'
+
+test_expect_success 'change the alternates of source to that without commit two' '
+	# now we have a commit-graph in the source repository but without the commit two
+	echo "$(pwd)/alternates/objects" >source/.git/objects/info/alternates
+'
+
+test_expect_success 'fetch the missing commit' '
+	git -C source fetch origin $oid 2>fetch.out &&
+	grep "$oid" fetch.out
+'
+
+test_done
-- 
2.36.1

