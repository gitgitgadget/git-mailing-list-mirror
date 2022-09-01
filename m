Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B3ACECAAD1
	for <git@archiver.kernel.org>; Thu,  1 Sep 2022 04:59:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232733AbiIAE7L (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Sep 2022 00:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbiIAE7G (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2022 00:59:06 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D87C114C6D
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 21:59:05 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id x5so12591729qtv.9
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 21:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=1PkTszXOfBFdziwolQmk/RQW12UAYu5GxbEPYVQct2g=;
        b=hD3ikJPTCie27VzxY8gyW9XGpoCtCElfE2aKk0QfmLu/JqlytNe9SjTrc7FOeIIiT9
         1jz0jAtxJpZZEG80h7P5a0YglcqIqBqt5LKUabCEDtfFMV294MqA0w4tM/dG/tXYlOmt
         vo1QJRKMAh+RabOFhnkn8HgDtBD69RsC+xcZFKvkp2WmW4KfGWUFeyCcouLXxBTXlPep
         vTJ0jsoLB2tKBQnil37A90Nps9733xrhEZxhxl/+2NcYT5PYfXFBFyWnRQEyI5G9uRdV
         8OHewHK1UPp5ijDc3IbajGxIfDLO/STU8Rtufyf7oujAVpCPoN66R0OtgybUDw5t6r5b
         cC8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=1PkTszXOfBFdziwolQmk/RQW12UAYu5GxbEPYVQct2g=;
        b=dtq13s93KIhY2y7pvE8Jccng/DZEoxR4j5U2RndshzL0MQquDw9MmAp4DtQYLhsM5x
         D282Z2ynkUtjRZDUGaiXITi4+xSOCg5Qefa9+snNn1MSUnAjKOozwoFTdoh5LbcZkuNG
         kcPByuP3CaV5UXXvrxBU/LJJxHCW+l0d40W9awasEyiu+rgQovcMFs/gD5kVaVzTqkPk
         eDr0CIBs+Bx7UxUJjyKAJ7XPUUs+znwQnSsanJd8VV8T2LJuU10yRPIP7rpTzFjgKzLQ
         vtua08GnZg68KxYjZ3KNQSkEQjWdm5hVO3XKJVRquv9PSAg3w6HRSC6v64/TwOAibCZp
         RXSA==
X-Gm-Message-State: ACgBeo3vIDLVtwcQAZWXvcWmlfulhXqSbEjNO1ET46f1CLdBKTONgf86
        1rUtSGKzV2oGld3pke1zm+wsYfcF7qk=
X-Google-Smtp-Source: AA6agR5+ekUxISKqW/LJ3SlzFPOMh1oUKRvWE9t7vRORKSWcQ91ORZFPBEhMJsESYegP7/WW9nBykQ==
X-Received: by 2002:a05:622a:199c:b0:344:7645:9ba1 with SMTP id u28-20020a05622a199c00b0034476459ba1mr22205414qtc.629.1662008344440;
        Wed, 31 Aug 2022 21:59:04 -0700 (PDT)
Received: from ffyuanda.localdomain (99-110-131-145.lightspeed.irvnca.sbcglobal.net. [99.110.131.145])
        by smtp.gmail.com with ESMTPSA id i5-20020a375405000000b006bb2f555ba4sm10752245qkb.41.2022.08.31.21.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 21:59:04 -0700 (PDT)
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
To:     git@vger.kernel.org
Cc:     derrickstolee@github.com, vdye@github.com,
        Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Subject: [PATCH v3 3/3] builtin/grep.c: walking tree instead of expanding index with --sparse
Date:   Wed, 31 Aug 2022 21:57:36 -0700
Message-Id: <20220901045736.523371-4-shaoxuan.yuan02@gmail.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220901045736.523371-1-shaoxuan.yuan02@gmail.com>
References: <20220817075633.217934-1-shaoxuan.yuan02@gmail.com>
 <20220901045736.523371-1-shaoxuan.yuan02@gmail.com>
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

p2000 tests demonstrate a ~91% execution time reduction for
`git grep --cached --sparse <pattern> -- <pathspec>` using tree-walking
logic.

Test                                                                          HEAD~   HEAD
---------------------------------------------------------------------------------------------------
2000.78: git grep --cached --sparse bogus -- f2/f1/f1/builtin/* (full-v3)     0.11    0.09 (≈)
2000.79: git grep --cached --sparse bogus -- f2/f1/f1/builtin/* (full-v4)     0.08    0.09 (≈)
2000.80: git grep --cached --sparse bogus -- f2/f1/f1/builtin/* (sparse-v3)   0.44    0.04 (-90.9%)
2000.81: git grep --cached --sparse bogus -- f2/f1/f1/builtin/* (sparse-v4)   0.46    0.04 (-91.3%)

- Command used for testing:

	git grep --cached --sparse bogus -- f2/f1/f1/builtin/*

The reason for specifying a pathspec is that, if we don't specify a
pathspec, then grep_tree() will walk all the trees and blobs to find the
pattern, and the time consumed doing so is not too different from using
the original ensure_full_index() method, which also spends most of the
time walking trees. However, when a pathspec is specified, this latest
logic will only walk the area of trees enclosed by the pathspec, and the
time consumed is reasonably a lot less.

That is, if we don't specify a pathspec, the performance difference [1]
is quite small: both methods walk all the trees and take generally same
amount of time (even with the index construction time included for
ensure_full_index()).

[1] Performance test result without pathspec:

	Test                                                    HEAD~  HEAD
	-----------------------------------------------------------------------------
	2000.78: git grep --cached --sparse bogus (full-v3)     6.17   5.19 (≈)
	2000.79: git grep --cached --sparse bogus (full-v4)     6.19   5.46 (≈)
	2000.80: git grep --cached --sparse bogus (sparse-v3)   6.57   6.44 (≈)
	2000.81: git grep --cached --sparse bogus (sparse-v4)   6.65   6.28 (≈)

Suggested-by: Derrick Stolee <derrickstolee@github.com>
Helped-by: Derrick Stolee <derrickstolee@github.com>
Helped-by: Victoria Dye <vdye@github.com>
Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
---
 builtin/grep.c                    | 32 ++++++++++++++++++++++++++-----
 t/perf/p2000-sparse-operations.sh |  1 +
 2 files changed, 28 insertions(+), 5 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index a0b4dbc1dc..8c0edccd8e 100644
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
 
@@ -537,8 +534,26 @@ static int grep_cache(struct grep_opt *opt,
 
 		strbuf_setlen(&name, name_base_len);
 		strbuf_addstr(&name, ce->name);
+		if (S_ISSPARSEDIR(ce->ce_mode)) {
+			enum object_type type;
+			struct tree_desc tree;
+			void *data;
+			unsigned long size;
+			struct strbuf base = STRBUF_INIT;
+
+			strbuf_addstr(&base, ce->name);
+
+			data = read_object_file(&ce->oid, &type, &size);
+			init_tree_desc(&tree, data, size);
 
-		if (S_ISREG(ce->ce_mode) &&
+			/*
+			 * sneak in the ce_mode using check_attr parameter
+			 */
+			hit |= grep_tree(opt, pathspec, &tree, &base,
+					 base.len, ce->ce_mode);
+			strbuf_release(&base);
+			free(data);
+		} else if (S_ISREG(ce->ce_mode) &&
 		    match_pathspec(repo->index, pathspec, name.buf, name.len, 0, NULL,
 				   S_ISDIR(ce->ce_mode) ||
 				   S_ISGITLINK(ce->ce_mode))) {
@@ -598,7 +613,14 @@ static int grep_tree(struct grep_opt *opt, const struct pathspec *pathspec,
 		int te_len = tree_entry_len(&entry);
 
 		if (match != all_entries_interesting) {
-			strbuf_addstr(&name, base->buf + tn_len);
+			if (S_ISSPARSEDIR(check_attr)) {
+				// object is a sparse directory entry
+				strbuf_addbuf(&name, base);
+			} else {
+				// object is a commit or a root tree
+				strbuf_addstr(&name, base->buf + tn_len);
+			}
+
 			match = tree_entry_interesting(repo->index,
 						       &entry, &name,
 						       0, pathspec);
diff --git a/t/perf/p2000-sparse-operations.sh b/t/perf/p2000-sparse-operations.sh
index fce8151d41..a0b71bb3b4 100755
--- a/t/perf/p2000-sparse-operations.sh
+++ b/t/perf/p2000-sparse-operations.sh
@@ -124,5 +124,6 @@ test_perf_on_all git read-tree -mu HEAD
 test_perf_on_all git checkout-index -f --all
 test_perf_on_all git update-index --add --remove $SPARSE_CONE/a
 test_perf_on_all "git rm -f $SPARSE_CONE/a && git checkout HEAD -- $SPARSE_CONE/a"
+test_perf_on_all git grep --cached --sparse bogus -- "f2/f1/f1/builtin/*"
 
 test_done
-- 
2.37.0

