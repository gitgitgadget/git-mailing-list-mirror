Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5561A1F4BD
	for <e@80x24.org>; Fri,  4 Oct 2019 03:29:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729191AbfJDD3y (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Oct 2019 23:29:54 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51514 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727758AbfJDD3x (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Oct 2019 23:29:53 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AE7262599A;
        Thu,  3 Oct 2019 23:29:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vHFDDw2ILYKLRxZbcrR+e2YADyE=; b=P6ePei
        h/d9yAHhBOAnBnyb2jwpzsa4CXSr+r00eyRTDu/s1TtMS0zpE2JHjxSg6TQvWHre
        FJJqzeLPSxiAj/gMXmPWZTD3an73U5CfiPCA1L+ABaKjVzrkDz/sn6K4VAOQ1ibZ
        xUI+ABqgN4eoICqNeb2Ws6m0hnAThcTkZipuA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=OES2AUh7wC0beCCngPK5n+oJtsP2HfL3
        LT0Sv3KHBsJQtDTSXshlI5aner8J2V5jQ4nwnI6fYr/YMCg2sP3HjUgZwP6fc0EZ
        rWR8Y1lgKL1f662zoM+lfBW7h1qzuxKB8v+kB3LBMpxm8qIVs3ESrnHzYq9iVVeD
        3QLhXGFjtIY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A622125999;
        Thu,  3 Oct 2019 23:29:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1765025998;
        Thu,  3 Oct 2019 23:29:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Wong <e@80x24.org>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>, git@vger.kernel.org
Subject: Re: [PATCH v2 18/19] OFFSETOF_VAR macro to simplify hashmap iterators
References: <20190924010324.22619-1-e@80x24.org>
        <20190924010324.22619-19-e@80x24.org>
        <xmqqr23t8g0t.fsf@gitster-ct.c.googlers.com>
        <20191004025115.GA26605@dcvr>
Date:   Fri, 04 Oct 2019 12:29:50 +0900
In-Reply-To: <20191004025115.GA26605@dcvr> (Eric Wong's message of "Fri, 4 Oct
        2019 02:51:15 +0000")
Message-ID: <xmqqk19l89xt.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 39FFD478-E657-11E9-A4B1-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Wong <e@80x24.org> writes:

> That seems too tedious.  I'm learning towards just initializing
> var = NULL in the start of the for-loop:
>
> @@ -449,7 +449,8 @@ static inline struct hashmap_entry *hashmap_iter_first(struct hashmap *map,
>   * containing a @member which is a "struct hashmap_entry"
>   */
>  #define hashmap_for_each_entry(map, iter, var, member) \
> -	for (var = hashmap_iter_first_entry_offset(map, iter, \
> +	for (var = NULL /* squelch uninitialized warnings for OFFSETOF_VAR */, \
> +		var = hashmap_iter_first_entry_offset(map, iter, \
>  						OFFSETOF_VAR(var, member)); \

That looks a bit too ugly for my taste.  I've added an updated
version (see below) and then rebased the whole thing on top of it.

"hashmap: use *_entry APIs for iteration" needs a trivial textual
conflict resolved, but otherwise the result looked OK.

-- >8 --
From: Junio C Hamano <gitster@pobox.com>
Date: Fri, 4 Oct 2019 10:12:25 +0900
Subject: [PATCH] treewide: initialize pointers to hashmap entries

There are not strictly necessary to avoid use of uninitialized
variables, but some compilers (e.g. clang 6.0.1) apparently have
trouble in construct we will use in the OFFSETOF_VAR() macro, i.e.

    ((uintptr_t)&(ptr)->member - (uintptr_t)(ptr))

when the ptr is uninitialized, treating such a "ptr" as "used".

It is just as bogus to subtract NULL from the address of the
"member" field pretending the structure sits at NULL address
as doing so with a structure that sits at a random address, but
apparently clang issues a warning with an advice to initialize the
pointer to NULL, so let's do that.

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
index 93dc16b59c..cb85303a06 100644
--- a/attr.c
+++ b/attr.c
@@ -159,7 +159,7 @@ static void all_attrs_init(struct attr_hashmap *map, struct attr_check *check)
 	 * field and fill each entry with its corresponding git_attr.
 	 */
 	if (size != check->all_attrs_nr) {
-		struct attr_hash_entry *e;
+		struct attr_hash_entry *e = NULL;
 		struct hashmap_iter iter;
 		hashmap_iter_init(&map->map, &iter);
 
diff --git a/blame.c b/blame.c
index 36a2e7ef11..9b912867f7 100644
--- a/blame.c
+++ b/blame.c
@@ -447,7 +447,7 @@ static int fingerprint_similarity(struct fingerprint *a, struct fingerprint *b)
 {
 	int intersection = 0;
 	struct hashmap_iter iter;
-	const struct fingerprint_entry *entry_a, *entry_b;
+	const struct fingerprint_entry *entry_a, *entry_b = NULL;
 
 	hashmap_iter_init(&b->map, &iter);
 
@@ -466,7 +466,7 @@ static void fingerprint_subtract(struct fingerprint *a, struct fingerprint *b)
 {
 	struct hashmap_iter iter;
 	struct fingerprint_entry *entry_a;
-	const struct fingerprint_entry *entry_b;
+	const struct fingerprint_entry *entry_b = NULL;
 
 	hashmap_iter_init(&b->map, &iter);
 
diff --git a/builtin/describe.c b/builtin/describe.c
index 200154297d..0369ed66ce 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -327,7 +327,7 @@ static void describe_commit(struct object_id *oid, struct strbuf *dst)
 	if (!have_util) {
 		struct hashmap_iter iter;
 		struct commit *c;
-		struct commit_name *n;
+		struct commit_name *n = NULL;
 
 		init_commit_names(&commit_names);
 		n = hashmap_iter_first(&names, &iter);
diff --git a/builtin/difftool.c b/builtin/difftool.c
index 16eb8b70ea..fbb4c87a86 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -337,7 +337,7 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
 	FILE *fp;
 	struct hashmap working_tree_dups, submodules, symlinks2;
 	struct hashmap_iter iter;
-	struct pair_entry *entry;
+	struct pair_entry *entry = NULL;
 	struct index_state wtindex;
 	struct checkout lstate, rstate;
 	int rc, flags = RUN_GIT_CMD, err = 0;
diff --git a/config.c b/config.c
index 3900e4947b..6c92d2825d 100644
--- a/config.c
+++ b/config.c
@@ -1934,7 +1934,7 @@ void git_configset_init(struct config_set *cs)
 
 void git_configset_clear(struct config_set *cs)
 {
-	struct config_set_element *entry;
+	struct config_set_element *entry = NULL;
 	struct hashmap_iter iter;
 	if (!cs->hash_initialized)
 		return;
diff --git a/merge-recursive.c b/merge-recursive.c
index 6b812d67e3..ea17d9c30f 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -2118,7 +2118,7 @@ static void handle_directory_level_conflicts(struct merge_options *opt,
 					     struct tree *merge)
 {
 	struct hashmap_iter iter;
-	struct dir_rename_entry *head_ent;
+	struct dir_rename_entry *head_ent = NULL;
 	struct dir_rename_entry *merge_ent;
 
 	struct string_list remove_from_head = STRING_LIST_INIT_NODUP;
@@ -2556,7 +2556,7 @@ static struct string_list *get_renames(struct merge_options *opt,
 	int i;
 	struct hashmap collisions;
 	struct hashmap_iter iter;
-	struct collision_entry *e;
+	struct collision_entry *e = NULL;
 	struct string_list *renames;
 
 	compute_collisions(&collisions, dir_renames, pairs);
@@ -2828,7 +2828,7 @@ static void initial_cleanup_rename(struct diff_queue_struct *pairs,
 				   struct hashmap *dir_renames)
 {
 	struct hashmap_iter iter;
-	struct dir_rename_entry *e;
+	struct dir_rename_entry *e = NULL;
 
 	hashmap_iter_init(dir_renames, &iter);
 	while ((e = hashmap_iter_next(&iter))) {
diff --git a/revision.c b/revision.c
index 07412297f0..b9b538c4d2 100644
--- a/revision.c
+++ b/revision.c
@@ -122,7 +122,7 @@ static void paths_and_oids_init(struct hashmap *map)
 static void paths_and_oids_clear(struct hashmap *map)
 {
 	struct hashmap_iter iter;
-	struct path_and_oids_entry *entry;
+	struct path_and_oids_entry *entry = NULL;
 	hashmap_iter_init(map, &iter);
 
 	while ((entry = (struct path_and_oids_entry *)hashmap_iter_next(&iter))) {
@@ -205,7 +205,7 @@ void mark_trees_uninteresting_sparse(struct repository *r,
 	unsigned has_interesting = 0, has_uninteresting = 0;
 	struct hashmap map;
 	struct hashmap_iter map_iter;
-	struct path_and_oids_entry *entry;
+	struct path_and_oids_entry *entry = NULL;
 	struct object_id *oid;
 	struct oidset_iter iter;
 
diff --git a/submodule-config.c b/submodule-config.c
index 4264ee216f..af86fe9ac1 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -85,7 +85,7 @@ static void free_one_config(struct submodule_entry *entry)
 static void submodule_cache_clear(struct submodule_cache *cache)
 {
 	struct hashmap_iter iter;
-	struct submodule_entry *entry;
+	struct submodule_entry *entry = NULL;
 
 	if (!cache->initialized)
 		return;
diff --git a/t/helper/test-hashmap.c b/t/helper/test-hashmap.c
index aaf17b0ddf..6407e0b426 100644
--- a/t/helper/test-hashmap.c
+++ b/t/helper/test-hashmap.c
@@ -159,7 +159,7 @@ int cmd__hashmap(int argc, const char **argv)
 	while (strbuf_getline(&line, stdin) != EOF) {
 		char *cmd, *p1 = NULL, *p2 = NULL;
 		unsigned int hash = 0;
-		struct test_entry *entry;
+		struct test_entry *entry = NULL;
 
 		/* break line into command and up to two parameters */
 		cmd = strtok(line.buf, DELIM);
diff --git a/t/helper/test-lazy-init-name-hash.c b/t/helper/test-lazy-init-name-hash.c
index b99a37080d..95ab81ee7a 100644
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
2.23.0-681-g60d083e3f0

