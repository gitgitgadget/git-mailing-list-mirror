Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA9E11F4BD
	for <e@80x24.org>; Fri,  4 Oct 2019 01:20:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730138AbfJDBSk (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Oct 2019 21:18:40 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:57564 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729936AbfJDBSk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Oct 2019 21:18:40 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4CD6995083;
        Thu,  3 Oct 2019 21:18:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=NJQittVmC4uHOZwsNCAY9NTC44s=; b=a4xXYV
        TBGMqMxw6Zjzr8RWC4hDPWZNCAUcaO1+Yuz1grfu2DF1dWAu6dT8r30uchIM6Q3K
        yVMJSDigkTLBaqiG1juX85kPD/MrifhO1lUIFUqklvz8/gkVzv2R1jM+RfKaGa5A
        QN+b/EGKeUB07ou6W5UbshuztqJ0lAcnn/oaw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DI4+ygK6JoApnz7ObM3UC5UX75mmLTj2
        RX/6HvbR0xGeNm13nXxJYWh9bPUav5mbWsQ7Yd//6eq7DlLaZl7bFLyZztEVlQih
        vf86J6PivnzUzqr/gJ5BYQdQy4/QtntNJDI8pzYlWGq5lQvjl6Oi+bq0ZxxLfqn6
        nX4IpDeUNJA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4723595082;
        Thu,  3 Oct 2019 21:18:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 69A259507F;
        Thu,  3 Oct 2019 21:18:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Wong <e@80x24.org>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>, git@vger.kernel.org
Subject: Re: [PATCH v2 18/19] OFFSETOF_VAR macro to simplify hashmap iterators
References: <20190924010324.22619-1-e@80x24.org>
        <20190924010324.22619-19-e@80x24.org>
Date:   Fri, 04 Oct 2019 10:18:26 +0900
In-Reply-To: <20190924010324.22619-19-e@80x24.org> (Eric Wong's message of
        "Tue, 24 Sep 2019 01:03:23 +0000")
Message-ID: <xmqqr23t8g0t.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DEF8501C-E644-11E9-ABE6-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Wong <e@80x24.org> writes:

> In the future, list iterator macros (e.g. list_for_each_entry)
> may also be implemented using OFFSETOF_VAR to save hackers the
> trouble of using container_of/list_entry macros and without
> relying on non-portable `__typeof__'.

Can we add something like this as a preliminary preparation step
before the series?

Subject: [PATCH] treewide: initialize pointers to hashmap entries

There are not strictly necessary, but some compilers (e.g. clang
6.0.1) apparently have trouble in construct we will use in the
OFFSETOF_VAR() macro, i.e.

    ((uintptr_t)&(ptr)->member - (uintptr_t)(ptr))

when the ptr is uninitialized.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 attr.c                              | 2 +-
 blame.c                             | 4 ++--
 builtin/describe.c                  | 2 +-
 builtin/difftool.c                  | 2 +-
 config.c                            | 2 +-
 merge-recursive.c                   | 6 +++---
 revision.c                          | 4 ++--
 submodule-config.c                  | 2 +-
 t/helper/test-hashmap.c             | 2 +-
 t/helper/test-lazy-init-name-hash.c | 4 ++--
 10 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/attr.c b/attr.c
index 15f0efdf60..0c367fb84a 100644
--- a/attr.c
+++ b/attr.c
@@ -161,7 +161,7 @@ static void all_attrs_init(struct attr_hashmap *map, struct attr_check *check)
 	 * field and fill each entry with its corresponding git_attr.
 	 */
 	if (size != check->all_attrs_nr) {
-		struct attr_hash_entry *e;
+		struct attr_hash_entry *e = NULL;
 		struct hashmap_iter iter;
 
 		REALLOC_ARRAY(check->all_attrs, size);
diff --git a/blame.c b/blame.c
index 6384f48133..a5f8672419 100644
--- a/blame.c
+++ b/blame.c
@@ -448,7 +448,7 @@ static int fingerprint_similarity(struct fingerprint *a, struct fingerprint *b)
 {
 	int intersection = 0;
 	struct hashmap_iter iter;
-	const struct fingerprint_entry *entry_a, *entry_b;
+	const struct fingerprint_entry *entry_a, *entry_b = NULL;
 
 	hashmap_for_each_entry(&b->map, &iter, entry_b,
 				entry /* member name */) {
@@ -467,7 +467,7 @@ static void fingerprint_subtract(struct fingerprint *a, struct fingerprint *b)
 {
 	struct hashmap_iter iter;
 	struct fingerprint_entry *entry_a;
-	const struct fingerprint_entry *entry_b;
+	const struct fingerprint_entry *entry_b = NULL;
 
 	hashmap_iter_init(&b->map, &iter);
 
diff --git a/builtin/describe.c b/builtin/describe.c
index 1caf98f716..42e6cc3a4f 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -330,7 +330,7 @@ static void describe_commit(struct object_id *oid, struct strbuf *dst)
 	if (!have_util) {
 		struct hashmap_iter iter;
 		struct commit *c;
-		struct commit_name *n;
+		struct commit_name *n = NULL;
 
 		init_commit_names(&commit_names);
 		hashmap_for_each_entry(&names, &iter, n,
diff --git a/builtin/difftool.c b/builtin/difftool.c
index c280e682b2..30f3bd6219 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -344,7 +344,7 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
 	FILE *fp;
 	struct hashmap working_tree_dups, submodules, symlinks2;
 	struct hashmap_iter iter;
-	struct pair_entry *entry;
+	struct pair_entry *entry = NULL;
 	struct index_state wtindex;
 	struct checkout lstate, rstate;
 	int rc, flags = RUN_GIT_CMD, err = 0;
diff --git a/config.c b/config.c
index a4fa464ed2..6ceefb7cff 100644
--- a/config.c
+++ b/config.c
@@ -1936,7 +1936,7 @@ void git_configset_init(struct config_set *cs)
 
 void git_configset_clear(struct config_set *cs)
 {
-	struct config_set_element *entry;
+	struct config_set_element *entry = NULL;
 	struct hashmap_iter iter;
 	if (!cs->hash_initialized)
 		return;
diff --git a/merge-recursive.c b/merge-recursive.c
index 8787a40b0c..bc826fb7ac 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -2127,7 +2127,7 @@ static void handle_directory_level_conflicts(struct merge_options *opt,
 					     struct tree *merge)
 {
 	struct hashmap_iter iter;
-	struct dir_rename_entry *head_ent;
+	struct dir_rename_entry *head_ent = NULL;
 	struct dir_rename_entry *merge_ent;
 
 	struct string_list remove_from_head = STRING_LIST_INIT_NODUP;
@@ -2566,7 +2566,7 @@ static struct string_list *get_renames(struct merge_options *opt,
 	int i;
 	struct hashmap collisions;
 	struct hashmap_iter iter;
-	struct collision_entry *e;
+	struct collision_entry *e = NULL;
 	struct string_list *renames;
 
 	compute_collisions(&collisions, dir_renames, pairs);
@@ -2838,7 +2838,7 @@ static void initial_cleanup_rename(struct diff_queue_struct *pairs,
 				   struct hashmap *dir_renames)
 {
 	struct hashmap_iter iter;
-	struct dir_rename_entry *e;
+	struct dir_rename_entry *e = NULL;
 
 	hashmap_for_each_entry(dir_renames, &iter, e,
 				ent /* member name */) {
diff --git a/revision.c b/revision.c
index 6688f89d0d..70f478666b 100644
--- a/revision.c
+++ b/revision.c
@@ -127,7 +127,7 @@ static void paths_and_oids_init(struct hashmap *map)
 static void paths_and_oids_clear(struct hashmap *map)
 {
 	struct hashmap_iter iter;
-	struct path_and_oids_entry *entry;
+	struct path_and_oids_entry *entry = NULL;
 
 	hashmap_for_each_entry(map, &iter, entry, ent /* member name */) {
 		oidset_clear(&entry->trees);
@@ -210,7 +210,7 @@ void mark_trees_uninteresting_sparse(struct repository *r,
 	unsigned has_interesting = 0, has_uninteresting = 0;
 	struct hashmap map;
 	struct hashmap_iter map_iter;
-	struct path_and_oids_entry *entry;
+	struct path_and_oids_entry *entry = NULL;
 	struct object_id *oid;
 	struct oidset_iter iter;
 
diff --git a/submodule-config.c b/submodule-config.c
index 401a9b2382..4d4d3b7dd7 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -89,7 +89,7 @@ static void free_one_config(struct submodule_entry *entry)
 static void submodule_cache_clear(struct submodule_cache *cache)
 {
 	struct hashmap_iter iter;
-	struct submodule_entry *entry;
+	struct submodule_entry *entry = NULL;
 
 	if (!cache->initialized)
 		return;
diff --git a/t/helper/test-hashmap.c b/t/helper/test-hashmap.c
index cc577c8956..a3bed8cc70 100644
--- a/t/helper/test-hashmap.c
+++ b/t/helper/test-hashmap.c
@@ -161,7 +161,7 @@ int cmd__hashmap(int argc, const char **argv)
 	while (strbuf_getline(&line, stdin) != EOF) {
 		char *cmd, *p1 = NULL, *p2 = NULL;
 		unsigned int hash = 0;
-		struct test_entry *entry;
+		struct test_entry *entry = NULL;
 
 		/* break line into command and up to two parameters */
 		cmd = strtok(line.buf, DELIM);
diff --git a/t/helper/test-lazy-init-name-hash.c b/t/helper/test-lazy-init-name-hash.c
index cd1b4c9736..2cb1fa3d8c 100644
--- a/t/helper/test-lazy-init-name-hash.c
+++ b/t/helper/test-lazy-init-name-hash.c
@@ -29,8 +29,8 @@ static void dump_run(void)
 		char name[FLEX_ARRAY];
 	};
 
-	struct dir_entry *dir;
-	struct cache_entry *ce;
+	struct dir_entry *dir = NULL;
+	struct cache_entry *ce = NULL;
 
 	read_cache();
 	if (single) {
-- 
2.23.0-680-gad10c89764

