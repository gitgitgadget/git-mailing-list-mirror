Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64660C38145
	for <git@archiver.kernel.org>; Sat,  3 Sep 2022 00:38:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbiICAig (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Sep 2022 20:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231575AbiICAiU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Sep 2022 20:38:20 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CB1D9D8CC
        for <git@vger.kernel.org>; Fri,  2 Sep 2022 17:38:19 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-12243fcaa67so8727015fac.8
        for <git@vger.kernel.org>; Fri, 02 Sep 2022 17:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=XnTv8ehcNlZQLSeFJL+zZ7NGe148opnHVoIPp+6aRYI=;
        b=bNNazmYZyyBMCQhSe4mobbEdN+XEd4vX6zmZ2ZZl/0xzlcinIsteCCDG1R+zc3TBRb
         XpFxVky1U+pcaiPjHeOmAJvJD6m9AC8mCQvhTr/8xRzrJwUdFPbkerKaSJtLsNJb2VDd
         oJhpsgE8DEsZE1KPl5Msn8ituSsNWcwcqVqUeOlcNQN9u1Z0MPi4XGNWONFqTr2wabEn
         I7vsQvulEt/edi6dxymMjGksiFaKBtrbb9YqzOOsoWU1n+hJMlHMTZrKoBQXp64mCzYy
         axh/3cQPdledXHkx5GjDRLlUHvWQNJeSWNUOA3wjCwylOROq8Zu1zrz4zCI4IEYPT+C3
         rRMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=XnTv8ehcNlZQLSeFJL+zZ7NGe148opnHVoIPp+6aRYI=;
        b=NBhwp4hhJZFH2Y0rEeyS/zBSbH7r9YCAMQfbEXf8C5iUtaf48/vn9gG4Rwe41cFspI
         8IAnNxTW+alOh7ODVkt4w+d+pTx8GX73ZbaCCvsyU492QN6N4F9pMcK4GYkDExwKfwQ/
         g60ExxjiOp2MBq+mMuEp1L7w+9VcpvW7N2cw7IIA8402Ohk1uoRQZlQ0FrBbpfkGdUgB
         adsbcRzicX0QX2VcYEglAqdo/m5A6fFsCG1Mwu2fkI6Mz0YACy5bajKOmw9aGF3wiUAJ
         eMRrSeuCtKJnsQKo1QHnr7kgki/o//etS3y8uSc3Iw477GwH0wmjvkkHFEQeU/mlIVKR
         ftNw==
X-Gm-Message-State: ACgBeo3r3PC3OHm9w524Vcws6zl+lOrVo6zjT7vwM9/HzaWbVO7ipGkD
        r4yDtS1GI4X7GBsCGnsDqdRsfEfKUjg=
X-Google-Smtp-Source: AA6agR5SjybcC5nB2lvczwmdwxCu4hlN3M1sS8eqKKZ7hA1pU8tGhqlqdtculfhea5iROenRB8qf/Q==
X-Received: by 2002:a05:6808:23d5:b0:343:6e35:c726 with SMTP id bq21-20020a05680823d500b003436e35c726mr3195408oib.26.1662165498734;
        Fri, 02 Sep 2022 17:38:18 -0700 (PDT)
Received: from ffyuanda.localdomain (99-110-131-145.lightspeed.irvnca.sbcglobal.net. [99.110.131.145])
        by smtp.gmail.com with ESMTPSA id n6-20020a4ad626000000b00435785e7b49sm1172472oon.19.2022.09.02.17.38.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 17:38:18 -0700 (PDT)
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
To:     git@vger.kernel.org
Cc:     derrickstolee@github.com, vdye@github.com, gitster@pobox.com,
        Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Subject: [PATCH v4 3/3] builtin/grep.c: walking tree instead of expanding index with --sparse
Date:   Fri,  2 Sep 2022 17:36:23 -0700
Message-Id: <20220903003623.64750-4-shaoxuan.yuan02@gmail.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220903003623.64750-1-shaoxuan.yuan02@gmail.com>
References: <20220817075633.217934-1-shaoxuan.yuan02@gmail.com>
 <20220903003623.64750-1-shaoxuan.yuan02@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Before this patch, whenever --sparse is used, `git-grep` utilizes the
ensure_full_index() method to expand the index and search all the
entries. Because this method requires walking all the trees and
constructing the index, it is the slow part within the whole command.

To achieve better performance, this patch uses grep_tree() to search the
sparse directory entries and get rid of the ensure_full_index() method.

Why grep_tree() is a better choice over ensure_full_index()?

1) grep_tree() is as correct as ensure_full_index(). grep_tree() looks
   into every sparse-directory entry (represented by a tree) recursively
   when looping over the index, and the result of doing so matches the
   result of expanding the index.

2) grep_tree() utilizes pathspecs to limit the scope of searching.
   ensure_full_index() always expands the index when --sparse is used,
   that means it will always walk all the trees and blobs in the repo
   without caring if the user only wants a subset of the content, i.e.
   using a pathspec. On the other hand, grep_tree() will only search
   the contents that match the pathspec, and thus possibly walking fewer
   trees.

3) grep_tree() does not construct and copy back a new index, while
   ensure_full_index() does. This also saves some time.

----------------
Performance test

- Summary:

p2000 tests demonstrate a ~71% execution time reduction for
`git grep --cached --sparse bogus -- "f2/f1/f1/*"` using tree-walking
logic. However, notice that this result varies depending on the pathspec
given. See below "Command used for testing" for more details.

Test                              HEAD~   HEAD
-------------------------------------------------------
2000.78: git grep ... (full-v3)   0.35    0.39 (≈)
2000.79: git grep ... (full-v4)   0.36    0.30 (≈)
2000.80: git grep ... (sparse-v3) 0.88    0.23 (-73.8%)
2000.81: git grep ... (sparse-v4) 0.83    0.26 (-68.6%)

- Command used for testing:

	git grep --cached --sparse bogus -- "f2/f1/f1/*"

The reason for specifying a pathspec is that, if we don't specify a
pathspec, then grep_tree() will walk all the trees and blobs to find the
pattern, and the time consumed doing so is not too different from using
the original ensure_full_index() method, which also spends most of the
time walking trees. However, when a pathspec is specified, this latest
logic will only walk the area of trees enclosed by the pathspec, and the
time consumed is reasonably a lot less.

Generally speaking, because the performance gain is acheived by walking
less trees, which are specified by the pathspec, the HEAD time v.s.
HEAD~ time in sparse-v[3|4], should be proportional to
"pathspec enclosed area" v.s. "all area", respectively. Namely, the
wider the <pathspec> is encompassing, the less the performance
difference between HEAD~ and HEAD, and vice versa.

That is, if we don't specify a pathspec, the performance difference [1]
is indistinguishable: both methods walk all the trees and take generally
same amount of time (even with the index construction time included for
ensure_full_index()).

[1] Performance test result without pathspec (hence walking all trees):

	Command used:

		git grep --cached --sparse bogus

	Test                                HEAD~  HEAD
	---------------------------------------------------
	2000.78: git grep ... (full-v3)     6.17   5.19 (≈)
	2000.79: git grep ... (full-v4)     6.19   5.46 (≈)
	2000.80: git grep ... (sparse-v3)   6.57   6.44 (≈)
	2000.81: git grep ... (sparse-v4)   6.65   6.28 (≈)

Suggested-by: Derrick Stolee <derrickstolee@github.com>
Helped-by: Derrick Stolee <derrickstolee@github.com>
Helped-by: Victoria Dye <vdye@github.com>
Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
---
 builtin/grep.c                           | 17 +++++++++++++----
 t/perf/p2000-sparse-operations.sh        |  1 +
 t/t1092-sparse-checkout-compatibility.sh | 10 +++++++++-
 3 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index a0b4dbc1dc..d8c086abff 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -522,9 +522,6 @@ static int grep_cache(struct grep_opt *opt,
 	if (repo_read_index(repo) < 0)
 		die(_("index file corrupt"));
 
-	if (grep_sparse)
-		ensure_full_index(repo->index);
-
 	for (nr = 0; nr < repo->index->cache_nr; nr++) {
 		const struct cache_entry *ce = repo->index->cache[nr];
 
@@ -537,8 +534,20 @@ static int grep_cache(struct grep_opt *opt,
 
 		strbuf_setlen(&name, name_base_len);
 		strbuf_addstr(&name, ce->name);
+		if (S_ISSPARSEDIR(ce->ce_mode)) {
+			enum object_type type;
+			struct tree_desc tree;
+			void *data;
+			unsigned long size;
+
+			data = read_object_file(&ce->oid, &type, &size);
+			init_tree_desc(&tree, data, size);
 
-		if (S_ISREG(ce->ce_mode) &&
+			hit |= grep_tree(opt, pathspec, &tree, &name, 0, 0);
+			strbuf_reset(&name);
+			strbuf_addstr(&name, ce->name);
+			free(data);
+		} else if (S_ISREG(ce->ce_mode) &&
 		    match_pathspec(repo->index, pathspec, name.buf, name.len, 0, NULL,
 				   S_ISDIR(ce->ce_mode) ||
 				   S_ISGITLINK(ce->ce_mode))) {
diff --git a/t/perf/p2000-sparse-operations.sh b/t/perf/p2000-sparse-operations.sh
index fce8151d41..3242cfe91a 100755
--- a/t/perf/p2000-sparse-operations.sh
+++ b/t/perf/p2000-sparse-operations.sh
@@ -124,5 +124,6 @@ test_perf_on_all git read-tree -mu HEAD
 test_perf_on_all git checkout-index -f --all
 test_perf_on_all git update-index --add --remove $SPARSE_CONE/a
 test_perf_on_all "git rm -f $SPARSE_CONE/a && git checkout HEAD -- $SPARSE_CONE/a"
+test_perf_on_all git grep --cached --sparse bogus -- "f2/f1/f1/*"
 
 test_done
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 63becc3138..56e4614276 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -1987,7 +1987,15 @@ test_expect_success 'grep is not expanded' '
 
 	# All files within the folder1/* pathspec are sparse,
 	# so this command does not find any matches
-	ensure_not_expanded ! grep a -- folder1/*
+	ensure_not_expanded ! grep a -- folder1/* &&
+
+	# test out-of-cone pathspec with or without wildcard
+	ensure_not_expanded grep --sparse --cached a -- "folder1/a" &&
+	ensure_not_expanded grep --sparse --cached a -- "folder1/*" &&
+
+	# test in-cone pathspec with or without wildcard
+	ensure_not_expanded grep --sparse --cached a -- "deep/a" &&
+	ensure_not_expanded grep --sparse --cached a -- "deep/*"
 '
 
 test_done
-- 
2.37.0

