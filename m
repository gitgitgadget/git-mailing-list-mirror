Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87F30C6FA8B
	for <git@archiver.kernel.org>; Fri, 23 Sep 2022 04:16:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231852AbiIWEQH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Sep 2022 00:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbiIWEQE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Sep 2022 00:16:04 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B1BB11C178
        for <git@vger.kernel.org>; Thu, 22 Sep 2022 21:16:03 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id o64so14939018oib.12
        for <git@vger.kernel.org>; Thu, 22 Sep 2022 21:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=/MKT2wz1tzDCAJifjlXIrLAwInXSu0o/bLqY882v3xQ=;
        b=WQIfIzo6ghQfKXp2fIALEy/W+i+hQ6js6TBxWEJKuykVixisZh1zth8LZH39MVKfOM
         2kAA6k22tEF/joxvNYdPUgEqBUqvvFYAKlpM8oYzE4qwqKk1sQzTTjZrHlLBsZ8+IAbl
         j/vLiaOyZzmON2+v2yPGatEnnxk/IRYGmv3gaeA42xO+iKr0GqmVMuVAw63QqbLs6IWV
         zfPJU2vCcwRUo8E50n7OXHH2W86T82LNqkAnE5JAl6XMDTOCgh1wC8a8Jl93z7W3bLMT
         MufPwUWyLUzy+YVnTIhd+VArvLT19ShjWH84yKbjGQ33L9w4z6w/BM6GcsX8rJ4arpYA
         /ZVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=/MKT2wz1tzDCAJifjlXIrLAwInXSu0o/bLqY882v3xQ=;
        b=7zzfGOILFcm6RwmovNIE0oSfEtbPg4+i/WPLWuWvK9sevvd35U3mmOGg6BnDRKexe4
         eV16uUh/TRLsNoyNzESXYoEqncaFmMTlfmEk+ymahkPjEYeyp9f8ChnxZxJwV3Vy85vl
         fYBHR8SeljyPrCHDogl+ATxvASZ5BAUP6PDDqFEEKP16b7ED5YNlvRkWPZTa7BSlV7W2
         LFHnxjJl7ghZsJ9/tZxWZUHneGCP7lcyseXUfcjEhCjsqtDVUwGsDjW+xAyaX3PGW4PX
         yBWsUcGART8Uns+rwEv45CS36ePhTowSGwvY30Qq1PrvAdJtlZQj9JkQevZ/NqZw9IK2
         zXkg==
X-Gm-Message-State: ACrzQf1tjoZgM7c6GUJAvCRD97GNUti6XCQqCoYvO5QQ/hL8iev4jY9D
        tHEGtSbN5vNwys/dhPlOQcjgdZql+R0=
X-Google-Smtp-Source: AMsMyM6d2pDQNEWLJ1/oEePJeNX88eo4ixGEvtrrHV8NLwATZ2xkWVRd4wtzb4EO2DqBP6TDbE3fxw==
X-Received: by 2002:a05:6808:2012:b0:34f:ca73:ee55 with SMTP id q18-20020a056808201200b0034fca73ee55mr3360771oiw.229.1663906562353;
        Thu, 22 Sep 2022 21:16:02 -0700 (PDT)
Received: from ffyuanda.localdomain (99-110-131-145.lightspeed.irvnca.sbcglobal.net. [99.110.131.145])
        by smtp.gmail.com with ESMTPSA id j1-20020a9d7381000000b00655dda40f54sm3533514otk.78.2022.09.22.21.16.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 21:16:01 -0700 (PDT)
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
To:     git@vger.kernel.org, newren@gmail.com, avarab@gmail.com
Cc:     derrickstolee@github.com, gitster@pobox.com, vdye@github.com,
        Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Subject: [PATCH v6 1/1] builtin/grep.c: integrate with sparse index
Date:   Thu, 22 Sep 2022 21:15:51 -0700
Message-Id: <20220923041551.27790-2-shaoxuan.yuan02@gmail.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220923041551.27790-1-shaoxuan.yuan02@gmail.com>
References: <20220923041551.27790-1-shaoxuan.yuan02@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Turn on sparse index and remove ensure_full_index().

Before this patch, `git-grep` utilizes the ensure_full_index() method to
expand the index and search all the entries. Because this method
requires walking all the trees and constructing the index, it is the
slow part within the whole command.

To achieve better performance, this patch uses grep_tree() to search the
sparse directory entries and get rid of the ensure_full_index() method.

Why grep_tree() is a better choice over ensure_full_index()?

1) grep_tree() is as correct as ensure_full_index(). grep_tree() looks
   into every sparse-directory entry (represented by a tree) recursively
   when looping over the index, and the result of doing so matches the
   result of expanding the index.

2) grep_tree() utilizes pathspecs to limit the scope of searching.
   ensure_full_index() always expands the index, which means it will
   always walk all the trees and blobs in the repo without caring if
   the user only wants a subset of the content, i.e. using a pathspec.
   On the other hand, grep_tree() will only search the contents that
   match the pathspec, and thus possibly walking fewer trees.

3) grep_tree() does not construct and copy back a new index, while
   ensure_full_index() does. This also saves some time.

----------------
Performance test

- Summary:

p2000 tests demonstrate a ~71% execution time reduction for
`git grep --cached bogus -- "f2/f1/f1/*"` using tree-walking logic.
However, notice that this result varies depending on the pathspec
given. See below "Command used for testing" for more details.

Test                              HEAD~   HEAD
-------------------------------------------------------
2000.78: git grep ... (full-v3)   0.35    0.39 (≈)
2000.79: git grep ... (full-v4)   0.36    0.30 (≈)
2000.80: git grep ... (sparse-v3) 0.88    0.23 (-73.8%)
2000.81: git grep ... (sparse-v4) 0.83    0.26 (-68.6%)

- Command used for testing:

	git grep --cached bogus -- "f2/f1/f1/*"

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

		git grep --cached bogus

	Test                                HEAD~  HEAD
	---------------------------------------------------
	2000.78: git grep ... (full-v3)     6.17   5.19 (≈)
	2000.79: git grep ... (full-v4)     6.19   5.46 (≈)
	2000.80: git grep ... (sparse-v3)   6.57   6.44 (≈)
	2000.81: git grep ... (sparse-v4)   6.65   6.28 (≈)

--------------------------
NEEDSWORK about submodules

There are a few NEEDSWORKs that belong to improvements beyond this
topic. See the NEEDSWORK in builtin/grep.c::grep_submodule() for
more context. The other two NEEDSWORKs in t1092 are also relative.

Suggested-by: Derrick Stolee <derrickstolee@github.com>
Helped-by: Derrick Stolee <derrickstolee@github.com>
Helped-by: Victoria Dye <vdye@github.com>
Helped-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
---
 builtin/grep.c                           | 48 +++++++++++++++-
 t/perf/p2000-sparse-operations.sh        |  1 +
 t/t1092-sparse-checkout-compatibility.sh | 72 ++++++++++++++++++++++++
 3 files changed, 118 insertions(+), 3 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index e6bcdf860c..5fa927d4e2 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -458,6 +458,33 @@ static int grep_submodule(struct grep_opt *opt,
 	 * subrepo's odbs to the in-memory alternates list.
 	 */
 	obj_read_lock();
+
+	/*
+	 * NEEDSWORK: when reading a submodule, the sparsity settings in the
+	 * superproject are incorrectly forgotten or misused. For example:
+	 *
+	 * 1. "command_requires_full_index"
+	 * 	When this setting is turned on for `grep`, only the superproject
+	 *	knows it. All the submodules are read with their own configs
+	 *	and get prepare_repo_settings()'d. Therefore, these submodules
+	 *	"forget" the sparse-index feature switch. As a result, the index
+	 *	of these submodules are expanded unexpectedly.
+	 *
+	 * 2. "core_apply_sparse_checkout"
+	 *	When running `grep` in the superproject, this setting is
+	 *	populated using the superproject's configs. However, once
+	 *	initialized, this config is globally accessible and is read by
+	 *	prepare_repo_settings() for the submodules. For instance, if a
+	 *	submodule is using a sparse-checkout, however, the superproject
+	 *	is not, the result is that the config from the superproject will
+	 *	dictate the behavior for the submodule, making it "forget" its
+	 *	sparse-checkout state.
+	 *
+	 * 3. "core_sparse_checkout_cone"
+	 *	ditto.
+	 *
+	 * Note that this list is not exhaustive.
+	 */
 	repo_read_gitmodules(subrepo, 0);
 
 	/*
@@ -520,8 +547,6 @@ static int grep_cache(struct grep_opt *opt,
 	if (repo_read_index(repo) < 0)
 		die(_("index file corrupt"));
 
-	/* TODO: audit for interaction with sparse-index. */
-	ensure_full_index(repo->index);
 	for (nr = 0; nr < repo->index->cache_nr; nr++) {
 		const struct cache_entry *ce = repo->index->cache[nr];
 
@@ -530,8 +555,20 @@ static int grep_cache(struct grep_opt *opt,
 
 		strbuf_setlen(&name, name_base_len);
 		strbuf_addstr(&name, ce->name);
+		if (S_ISSPARSEDIR(ce->ce_mode)) {
+			enum object_type type;
+			struct tree_desc tree;
+			void *data;
+			unsigned long size;
 
-		if (S_ISREG(ce->ce_mode) &&
+			data = read_object_file(&ce->oid, &type, &size);
+			init_tree_desc(&tree, data, size);
+
+			hit |= grep_tree(opt, pathspec, &tree, &name, 0, 0);
+			strbuf_setlen(&name, name_base_len);
+			strbuf_addstr(&name, ce->name);
+			free(data);
+		} else if (S_ISREG(ce->ce_mode) &&
 		    match_pathspec(repo->index, pathspec, name.buf, name.len, 0, NULL,
 				   S_ISDIR(ce->ce_mode) ||
 				   S_ISGITLINK(ce->ce_mode))) {
@@ -984,6 +1021,11 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 			     PARSE_OPT_KEEP_DASHDASH |
 			     PARSE_OPT_STOP_AT_NON_OPTION);
 
+	if (the_repository->gitdir) {
+		prepare_repo_settings(the_repository);
+		the_repository->settings.command_requires_full_index = 0;
+	}
+
 	if (use_index && !startup_info->have_repository) {
 		int fallback = 0;
 		git_config_get_bool("grep.fallbacktonoindex", &fallback);
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
index b9350c075c..711b52fb46 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -162,6 +162,19 @@ init_repos () {
 	git -C sparse-index sparse-checkout set deep
 }
 
+init_repos_as_submodules () {
+	git reset --hard &&
+	init_repos &&
+	git submodule add ./full-checkout &&
+	git submodule add ./sparse-checkout &&
+	git submodule add ./sparse-index &&
+
+	git submodule status >actual &&
+	grep full-checkout actual &&
+	grep sparse-checkout actual &&
+	grep sparse-index actual
+}
+
 run_on_sparse () {
 	(
 		cd sparse-checkout &&
@@ -1981,4 +1994,63 @@ test_expect_success 'sparse index is not expanded: rm' '
 	ensure_not_expanded rm -r deep
 '
 
+test_expect_success 'grep with and --cached' '
+	init_repos &&
+
+	test_all_match git grep --cached a &&
+	test_all_match git grep --cached a -- "folder1/*"
+'
+
+test_expect_success 'grep is not expanded' '
+	init_repos &&
+
+	ensure_not_expanded grep a &&
+	ensure_not_expanded grep a -- deep/* &&
+
+	# All files within the folder1/* pathspec are sparse,
+	# so this command does not find any matches
+	ensure_not_expanded ! grep a -- folder1/* &&
+
+	# test out-of-cone pathspec with or without wildcard
+	ensure_not_expanded grep --cached a -- "folder1/a" &&
+	ensure_not_expanded grep --cached a -- "folder1/*" &&
+
+	# test in-cone pathspec with or without wildcard
+	ensure_not_expanded grep --cached a -- "deep/a" &&
+	ensure_not_expanded grep --cached a -- "deep/*"
+'
+
+# NEEDSWORK: when running `grep` in the superproject with --recurse-submodules,
+# Git expands the index of the submodules unexpectedly. Even though `grep`
+# builtin is marked as "command_requires_full_index = 0", this config is only
+# useful for the superproject. Namely, the submodules have their own configs,
+# which are _not_ populated by the one-time sparse-index feature switch.
+test_expect_failure 'grep within submodules is not expanded' '
+	init_repos_as_submodules &&
+
+	# do not use ensure_not_expanded() here, becasue `grep` should be
+	# run in the superproject, not in "./sparse-index"
+	GIT_TRACE2_EVENT="$(pwd)/trace2.txt" \
+	git grep --cached --recurse-submodules a -- "*/folder1/*" &&
+	test_region ! index ensure_full_index trace2.txt
+'
+
+# NEEDSWORK: this test is not actually testing the code. The design purpose
+# of this test is to verify the grep result when the submodules are using a
+# sparse-index. Namely, we want "folder1/" as a tree (a sparse directory); but
+# because of the index expansion, we are now grepping the "folder1/a" blob.
+# Because of the problem stated above 'grep within submodules is not expanded',
+# we don't have the ideal test environment yet.
+test_expect_success 'grep sparse directory within submodules' '
+	init_repos_as_submodules &&
+
+	cat >expect <<-\EOF &&
+	full-checkout/folder1/a:a
+	sparse-checkout/folder1/a:a
+	sparse-index/folder1/a:a
+	EOF
+	git grep --cached --recurse-submodules a -- "*/folder1/*" >actual &&
+	test_cmp actual expect
+'
+
 test_done
-- 
2.37.0

