Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C152EC43334
	for <git@archiver.kernel.org>; Thu, 16 Jun 2022 03:39:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358467AbiFPDjd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jun 2022 23:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350569AbiFPDjY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jun 2022 23:39:24 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20B3A1CFDF
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 20:39:24 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id 187so357368pfu.9
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 20:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Yb1EbTs3FbmhWARjFziHnHYJ4IETCtm0biCtbmvFWy4=;
        b=ZA3gT0KRcsqrWitTY9uzBDX4B7EcWN7YVOB4Qfj1CJYzOb4V6nm9Dx7etmYLV+s8Cg
         KQwvGWfYzLxkpneN331muPG3xklOdSupRr5nNJieDQwF1Biunl6EMdR0ElFr4LdktQRb
         GVu37uvN9HdPRwy9qRxtkHQNHZSI6UF2zQ1D/kMGfJ4+0vizysfp8lGv8Mb5oADx269O
         WfTU5efF6a28UrHgOnUm1OBDcB6YrlgKUPkZkU9xSXoXWHpWyaqij5MWXo3YYBjzI0fa
         H/LweXHofWZSfNu/2rHIi4mFCWEfeaehou5Fx4uO5jy7mwdoXAsORkK2pLUhGjyPyJ8V
         5iEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Yb1EbTs3FbmhWARjFziHnHYJ4IETCtm0biCtbmvFWy4=;
        b=MUw5uwxPXp7mdai/7Z90vXwwSQ5LgInFAkRFj5KG7eWwJf/NgcTs/2+PsNabMbmy1D
         BP772KzAbhYdCoEo5PK65xdfniStBdy8nvzLiB7irrX/ScIJtv07F1xDNXzrM8SVJfnM
         4Ukzr8tPZJ/H+SLVqms306RAToWqZl5yuW+5avvifprEgYdSXW3VZkdx6GnCWJuKikSa
         6aIHFJtXXKLF/NWNW96gJgeDpB9OTb8k/P1BULr7WJJD2dE1aaQ/CNnypxBhg1gGNrZq
         bZESEGGqrQ0Z6HiBbnFZMnv8gxaAig+Nm+5YTaBzZEn4+PDUtvbZ0pwL108QpQgAIshi
         ICBQ==
X-Gm-Message-State: AJIora8H+FdmkDJ6fCaIh+4VBqfJf++fOFeZsQauYnX9q4IgxsdroDB6
        15eXucXWHOi+SS7d0Ig/siYBPA==
X-Google-Smtp-Source: AGRyM1uupYLMyHq17Hh9dRpJXKTUHgMdn4U/Acaq/38Mm7Id0YU8euTiEFi4pRFuIm9bVMuVU8Yd/w==
X-Received: by 2002:a05:6a00:4406:b0:51c:244f:85d8 with SMTP id br6-20020a056a00440600b0051c244f85d8mr2838643pfb.36.1655350763601;
        Wed, 15 Jun 2022 20:39:23 -0700 (PDT)
Received: from JMHNXMC7VH.bytedance.net ([139.177.225.227])
        by smtp.gmail.com with ESMTPSA id p4-20020a170902780400b0016760c06b76sm393163pll.194.2022.06.15.20.39.20
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 15 Jun 2022 20:39:23 -0700 (PDT)
From:   Han Xin <hanxin.hx@bytedance.com>
To:     me@ttaylorr.com
Cc:     chiyutianyi@gmail.com, derrickstolee@github.com,
        git@vger.kernel.org, haiyangtand@gmail.com,
        jonathantanmy@google.com, ps@pks.im,
        Han Xin <hanxin.hx@bytedance.com>
Subject: [RFC PATCH 2/2] fetch-pack.c: pass "oi_flags" to lookup_commit_in_graph()
Date:   Thu, 16 Jun 2022 11:38:33 +0800
Message-Id: <03ec01ab398bc4967f7ac8ccab510cac2d6785be.1655350442.git.hanxin.hx@bytedance.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1655350442.git.hanxin.hx@bytedance.com>
References: <cover.1655350442.git.hanxin.hx@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As the custom "oi_flags" is missed by lookup_commit_in_graph(), we will
get another lazy fetch round if we found the commit in commit graph but
miss it in the local object repository.

We can see the issue via[1].

1. https://lore.kernel.org/git/20220612161707.21807-1-chiyutianyi@gmail.com/

Signed-off-by: Han Xin <hanxin.hx@bytedance.com>
---
 fetch-pack.c                       | 10 +++----
 t/t5583-fetch-with-commit-graph.sh | 47 ++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+), 5 deletions(-)
 create mode 100644 t/t5583-fetch-with-commit-graph.sh

diff --git a/fetch-pack.c b/fetch-pack.c
index 4a62fb182e..ca1234e456 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -123,7 +123,7 @@ static struct commit *deref_without_lazy_fetch_extended(const struct object_id *
 	struct object_info info = { .typep = type };
 	struct commit *commit;
 
-	commit = lookup_commit_in_graph(the_repository, oid, 0);
+	commit = lookup_commit_in_graph(the_repository, oid, oi_flags);
 	if (commit)
 		return commit;
 
@@ -704,6 +704,7 @@ static void mark_complete_and_common_ref(struct fetch_negotiator *negotiator,
 	struct ref *ref;
 	int old_save_commit_buffer = save_commit_buffer;
 	timestamp_t cutoff = 0;
+	int oi_flags = OBJECT_INFO_SKIP_FETCH_OBJECT | OBJECT_INFO_QUICK;
 
 	if (args->refetch)
 		return;
@@ -714,13 +715,12 @@ static void mark_complete_and_common_ref(struct fetch_negotiator *negotiator,
 	for (ref = *refs; ref; ref = ref->next) {
 		struct commit *commit;
 
-		commit = lookup_commit_in_graph(the_repository, &ref->old_oid, 0);
+		commit = lookup_commit_in_graph(the_repository, &ref->old_oid,
+						oi_flags);
 		if (!commit) {
 			struct object *o;
 
-			if (!has_object_file_with_flags(&ref->old_oid,
-						OBJECT_INFO_QUICK |
-						OBJECT_INFO_SKIP_FETCH_OBJECT))
+			if (!has_object_file_with_flags(&ref->old_oid, oi_flags))
 				continue;
 			o = parse_object(the_repository, &ref->old_oid);
 			if (!o || o->type != OBJ_COMMIT)
diff --git a/t/t5583-fetch-with-commit-graph.sh b/t/t5583-fetch-with-commit-graph.sh
new file mode 100644
index 0000000000..cb2beafa8d
--- /dev/null
+++ b/t/t5583-fetch-with-commit-graph.sh
@@ -0,0 +1,47 @@
+#!/bin/sh
+
+test_description='test for fetching missing object with a full commit-graph'
+
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	git init --bare dest.git &&
+	test_commit one &&
+	git checkout -b testbranch &&
+	test_commit two &&
+	git push dest.git --all
+'
+
+test_expect_success 'prepare a alternates repository without testbranch' '
+	git clone -b $GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME dest.git alternates &&
+	oid=$(git -C alternates rev-parse refs/remotes/origin/testbranch) &&
+	git -C alternates update-ref -d refs/remotes/origin/testbranch &&
+	git -C alternates gc --prune=now
+'
+
+test_expect_success 'prepare a repository with a full commit-graph' '
+	git init source &&
+	echo "$(pwd)/dest.git/objects" >source/.git/objects/info/alternates &&
+	git -C source remote add origin "$(pwd)/dest.git" &&
+	git -C source config remote.origin.promisor true &&
+	git -C source config remote.origin.partialclonefilter blob:none &&
+	git -C source fetch origin &&
+	(
+		cd source &&
+		test_commit three &&
+		git -c gc.writeCommitGraph=true gc
+	)
+'
+
+test_expect_success 'change the alternates to that without commit two' '
+	echo "$(pwd)/alternates/.git/objects" >source/.git/objects/info/alternates
+'
+
+test_expect_success 'fetch the missing object' '
+	git -C source fetch origin $oid
+'
+
+test_done
-- 
2.36.1

