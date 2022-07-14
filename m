Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98683C433EF
	for <git@archiver.kernel.org>; Thu, 14 Jul 2022 11:49:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239076AbiGNLtl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jul 2022 07:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239080AbiGNLtc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jul 2022 07:49:32 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F6045B7A9
        for <git@vger.kernel.org>; Thu, 14 Jul 2022 04:49:31 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id j3so2029305oif.8
        for <git@vger.kernel.org>; Thu, 14 Jul 2022 04:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KO2qBG28g6qAxc5L1BmBGNS42LcfPGD1JhFZFOyt59w=;
        b=TLJt6gKsOzNEOTxek0jV0/zx2Spsi45QDOrCoXV1E8lRNruoumByN3xQiSWFWmCG4S
         Dh4aavrY+NmtpU8DhtSUADnS7gdNMv/UDctua+NMAkBVhZ91ucC9zVGx09erseGf7ek5
         3gc6QRc0TRYGg7TXsRa1j0vYwZi+XYUfd7HTVlHZpMXcEl/eXg8X0RBTQEsoaxvubZnJ
         izW3y5v4VxBhytYHP4KKxkAIYEt8AUerx4nihHr6H9xSQPNWauvtJ6yysS089ST9c7SO
         ZTmEdAHrfdHRnrY/GA7xSzdZFmVOcU/4Ct3KIiLGsblAA9NbNQC7UjDtB0o1toQRu6pw
         9ZJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KO2qBG28g6qAxc5L1BmBGNS42LcfPGD1JhFZFOyt59w=;
        b=CrC/p+6cGF/XpJJEMdI2StSag4J79wP+BRBkw2cCxaxIZ6CA0/ZCdHG9CD7um7blKk
         sE18wTV2L0eASHI34o9Nqy6etrsaAASeUy7bPHwdWyOKRY57FlgFn2quT7tXXNughDtj
         0AWZEdSIyqhAfl8JK0n/ZW6U+/8ToeYs+n/Ox0ZBJiWedJ/K7NUIf9oMsK6I1zIaS5tw
         UsGA3GXcAdne2G3OE2jlihGgjtUJFxNr29RxQFJ1tbZ1ESfSDeS1ymrkEpIyj1xpWHK+
         aeI+Y344wLx/XRurvYOTF5qbfTdDf6x/u3PsCCnwt8oI7PEslFTbBdG1KQqT6F3JwPCl
         7efQ==
X-Gm-Message-State: AJIora+Ildacaj7sPkLh0NXM0hF2vayRt5IXY5rqe121J1IdYi2rY8Ox
        qeOIjVZIlbBhmOMxnegV/Zep8w==
X-Google-Smtp-Source: AGRyM1v9iFIyBOddhDpbJA45gdLNV4rTP3Dm12YaV+EEFmoMfhQJbDmK4HGKeWO20IGdWIkHlekBMg==
X-Received: by 2002:a05:6808:114b:b0:337:ab89:d5be with SMTP id u11-20020a056808114b00b00337ab89d5bemr4385374oiu.299.1657799370787;
        Thu, 14 Jul 2022 04:49:30 -0700 (PDT)
Received: from mango.meuintelbras.local ([177.32.109.17])
        by smtp.gmail.com with ESMTPSA id o23-20020a9d4117000000b00616c5ce1d83sm548035ote.68.2022.07.14.04.49.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 04:49:30 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, avarab@gmail.com
Subject: [PATCH v2 3/3] checkout: fix two bugs on the final count of updated entries
Date:   Thu, 14 Jul 2022 08:49:12 -0300
Message-Id: <b182d74e967aaa38d54c502f45a0b94af5845833.1657799213.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <cover.1657799213.git.matheus.bernardino@usp.br>
References: <cover.1657799213.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

At the end of `git checkout <pathspec>`, we get a message informing how
many entries were updated in the working tree. However, this number can
be inaccurate for two reasons:

1) Delayed entries currently get counted twice.
2) Failed entries are included in the count.

The first problem happens because the counter is first incremented
before inserting the entry in the delayed checkout queue, and once again
when finish_delayed_checkout() calls checkout_entry(). And the second
happens because the counter is incremented too early in
checkout_entry(), before the entry was in fact checked out. Fix that by
moving the count increment further down in the call stack and removing
the duplicate increment on delayed entries. Note that we have to keep
a per-entry reference for the counter (both on parallel checkout and
delayed checkout) because not all entries are always accumulated at the
same counter. See checkout_worktree(), at builtin/checkout.c for an
example.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 builtin/checkout.c                  |  2 +-
 convert.h                           |  6 ++++-
 entry.c                             | 34 +++++++++++++++++------------
 entry.h                             |  3 +--
 parallel-checkout.c                 | 10 ++++++---
 parallel-checkout.h                 |  4 +++-
 t/t0021-conversion.sh               |  2 +-
 t/t2080-parallel-checkout-basics.sh |  2 +-
 unpack-trees.c                      |  2 +-
 9 files changed, 40 insertions(+), 25 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 2eefda81d8..df3f1663d7 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -417,7 +417,7 @@ static int checkout_worktree(const struct checkout_opts *opts,
 	mem_pool_discard(&ce_mem_pool, should_validate_cache_entries());
 	remove_marked_cache_entries(&the_index, 1);
 	remove_scheduled_dirs();
-	errs |= finish_delayed_checkout(&state, &nr_checkouts, opts->show_progress);
+	errs |= finish_delayed_checkout(&state, opts->show_progress);
 
 	if (opts->count_checkout_paths) {
 		if (nr_unmerged)
diff --git a/convert.h b/convert.h
index 5ee1c32205..0a6e4086b8 100644
--- a/convert.h
+++ b/convert.h
@@ -53,7 +53,11 @@ struct delayed_checkout {
 	enum ce_delay_state state;
 	/* List of filter drivers that signaled delayed blobs. */
 	struct string_list filters;
-	/* List of delayed blobs identified by their path. */
+	/*
+	 * List of delayed blobs identified by their path. The `util` member
+	 * holds a counter pointer which must be incremented when/if the
+	 * associated blob gets checked out.
+	 */
 	struct string_list paths;
 };
 
diff --git a/entry.c b/entry.c
index 1c9df62b30..616e4f073c 100644
--- a/entry.c
+++ b/entry.c
@@ -157,12 +157,11 @@ static int remove_available_paths(struct string_list_item *item, void *cb_data)
 
 	available = string_list_lookup(available_paths, item->string);
 	if (available)
-		available->util = (void *)item->string;
+		available->util = item->util;
 	return !available;
 }
 
-int finish_delayed_checkout(struct checkout *state, int *nr_checkouts,
-			    int show_progress)
+int finish_delayed_checkout(struct checkout *state, int show_progress)
 {
 	int errs = 0;
 	unsigned processed_paths = 0;
@@ -227,7 +226,7 @@ int finish_delayed_checkout(struct checkout *state, int *nr_checkouts,
 						       strlen(path->string), 0);
 				if (ce) {
 					display_progress(progress, ++processed_paths);
-					errs |= checkout_entry(ce, state, NULL, nr_checkouts);
+					errs |= checkout_entry(ce, state, NULL, path->util);
 					filtered_bytes += ce->ce_stat_data.sd_size;
 					display_throughput(progress, filtered_bytes);
 				} else
@@ -266,7 +265,8 @@ void update_ce_after_write(const struct checkout *state, struct cache_entry *ce,
 
 /* Note: ca is used (and required) iff the entry refers to a regular file. */
 static int write_entry(struct cache_entry *ce, char *path, struct conv_attrs *ca,
-		       const struct checkout *state, int to_tempfile)
+		       const struct checkout *state, int to_tempfile,
+		       int *nr_checkouts)
 {
 	unsigned int ce_mode_s_ifmt = ce->ce_mode & S_IFMT;
 	struct delayed_checkout *dco = state->delayed_checkout;
@@ -279,6 +279,7 @@ static int write_entry(struct cache_entry *ce, char *path, struct conv_attrs *ca
 	struct stat st;
 	const struct submodule *sub;
 	struct checkout_metadata meta;
+	static int scratch_nr_checkouts;
 
 	clone_checkout_metadata(&meta, &state->meta, &ce->oid);
 
@@ -333,9 +334,15 @@ static int write_entry(struct cache_entry *ce, char *path, struct conv_attrs *ca
 			ret = async_convert_to_working_tree_ca(ca, ce->name,
 							       new_blob, size,
 							       &buf, &meta, dco);
-			if (ret && string_list_has_string(&dco->paths, ce->name)) {
-				free(new_blob);
-				goto delayed;
+			if (ret) {
+				struct string_list_item *item =
+					string_list_lookup(&dco->paths, ce->name);
+				if (item) {
+					item->util = nr_checkouts ? nr_checkouts
+							: &scratch_nr_checkouts;
+					free(new_blob);
+					goto delayed;
+				}
 			}
 		} else {
 			ret = convert_to_working_tree_ca(ca, ce->name, new_blob,
@@ -392,6 +399,8 @@ static int write_entry(struct cache_entry *ce, char *path, struct conv_attrs *ca
 					   ce->name);
 		update_ce_after_write(state, ce , &st);
 	}
+	if (nr_checkouts)
+		(*nr_checkouts)++;
 delayed:
 	return 0;
 }
@@ -476,7 +485,7 @@ int checkout_entry_ca(struct cache_entry *ce, struct conv_attrs *ca,
 			convert_attrs(state->istate, &ca_buf, ce->name);
 			ca = &ca_buf;
 		}
-		return write_entry(ce, topath, ca, state, 1);
+		return write_entry(ce, topath, ca, state, 1, nr_checkouts);
 	}
 
 	strbuf_reset(&path);
@@ -540,18 +549,15 @@ int checkout_entry_ca(struct cache_entry *ce, struct conv_attrs *ca,
 
 	create_directories(path.buf, path.len, state);
 
-	if (nr_checkouts)
-		(*nr_checkouts)++;
-
 	if (S_ISREG(ce->ce_mode) && !ca) {
 		convert_attrs(state->istate, &ca_buf, ce->name);
 		ca = &ca_buf;
 	}
 
-	if (!enqueue_checkout(ce, ca))
+	if (!enqueue_checkout(ce, ca, nr_checkouts))
 		return 0;
 
-	return write_entry(ce, path.buf, ca, state, 0);
+	return write_entry(ce, path.buf, ca, state, 0, nr_checkouts);
 }
 
 void unlink_entry(const struct cache_entry *ce)
diff --git a/entry.h b/entry.h
index 252fd24c2e..9be4659881 100644
--- a/entry.h
+++ b/entry.h
@@ -43,8 +43,7 @@ static inline int checkout_entry(struct cache_entry *ce,
 }
 
 void enable_delayed_checkout(struct checkout *state);
-int finish_delayed_checkout(struct checkout *state, int *nr_checkouts,
-			    int show_progress);
+int finish_delayed_checkout(struct checkout *state, int show_progress);
 
 /*
  * Unlink the last component and schedule the leading directories for
diff --git a/parallel-checkout.c b/parallel-checkout.c
index 31a3d0ee1b..4f6819f240 100644
--- a/parallel-checkout.c
+++ b/parallel-checkout.c
@@ -143,7 +143,8 @@ static int is_eligible_for_parallel_checkout(const struct cache_entry *ce,
 	}
 }
 
-int enqueue_checkout(struct cache_entry *ce, struct conv_attrs *ca)
+int enqueue_checkout(struct cache_entry *ce, struct conv_attrs *ca,
+		     int *checkout_counter)
 {
 	struct parallel_checkout_item *pc_item;
 
@@ -159,6 +160,7 @@ int enqueue_checkout(struct cache_entry *ce, struct conv_attrs *ca)
 	memcpy(&pc_item->ca, ca, sizeof(pc_item->ca));
 	pc_item->status = PC_ITEM_PENDING;
 	pc_item->id = parallel_checkout.nr;
+	pc_item->checkout_counter = checkout_counter;
 	parallel_checkout.nr++;
 
 	return 0;
@@ -200,7 +202,8 @@ static int handle_results(struct checkout *state)
 
 		switch(pc_item->status) {
 		case PC_ITEM_WRITTEN:
-			/* Already handled */
+			if (pc_item->checkout_counter)
+				(*pc_item->checkout_counter)++;
 			break;
 		case PC_ITEM_COLLIDED:
 			/*
@@ -225,7 +228,8 @@ static int handle_results(struct checkout *state)
 			 * add any extra overhead.
 			 */
 			ret |= checkout_entry_ca(pc_item->ce, &pc_item->ca,
-						 state, NULL, NULL);
+						 state, NULL,
+						 pc_item->checkout_counter);
 			advance_progress_meter();
 			break;
 		case PC_ITEM_PENDING:
diff --git a/parallel-checkout.h b/parallel-checkout.h
index 80f539bcb7..c575284005 100644
--- a/parallel-checkout.h
+++ b/parallel-checkout.h
@@ -31,7 +31,8 @@ void init_parallel_checkout(void);
  * entry is not eligible for parallel checkout. Otherwise, enqueue the entry
  * for later write and return 0.
  */
-int enqueue_checkout(struct cache_entry *ce, struct conv_attrs *ca);
+int enqueue_checkout(struct cache_entry *ce, struct conv_attrs *ca,
+		     int *checkout_counter);
 size_t pc_queue_size(void);
 
 /*
@@ -68,6 +69,7 @@ struct parallel_checkout_item {
 	struct cache_entry *ce;
 	struct conv_attrs ca;
 	size_t id; /* position in parallel_checkout.items[] of main process */
+	int *checkout_counter;
 
 	/* Output fields, sent from workers. */
 	enum pc_item_status status;
diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
index 00df9b5c18..1c840348bd 100755
--- a/t/t0021-conversion.sh
+++ b/t/t0021-conversion.sh
@@ -1132,7 +1132,7 @@ do
 	'
 done
 
-test_expect_failure PERL 'delayed checkout correctly reports the number of updated entries' '
+test_expect_success PERL 'delayed checkout correctly reports the number of updated entries' '
 	rm -rf repo &&
 	git init repo &&
 	(
diff --git a/t/t2080-parallel-checkout-basics.sh b/t/t2080-parallel-checkout-basics.sh
index 7d6d26e1a4..c683e60007 100755
--- a/t/t2080-parallel-checkout-basics.sh
+++ b/t/t2080-parallel-checkout-basics.sh
@@ -230,7 +230,7 @@ test_expect_success SYMLINKS 'parallel checkout checks for symlinks in leading d
 # check the final report including sequential, parallel, and delayed entries
 # all at the same time. So we must have finer control of the parallel checkout
 # variables.
-test_expect_failure PERL '"git checkout ." report should not include failed entries' '
+test_expect_success PERL '"git checkout ." report should not include failed entries' '
 	write_script rot13-filter.pl "$PERL_PATH" \
 		<"$TEST_DIRECTORY"/t0021/rot13-filter.pl &&
 
diff --git a/unpack-trees.c b/unpack-trees.c
index d561ca01ed..8a454e03bf 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -487,7 +487,7 @@ static int check_updates(struct unpack_trees_options *o,
 		errs |= run_parallel_checkout(&state, pc_workers, pc_threshold,
 					      progress, &cnt);
 	stop_progress(&progress);
-	errs |= finish_delayed_checkout(&state, NULL, o->verbose_update);
+	errs |= finish_delayed_checkout(&state, o->verbose_update);
 	git_attr_set_direction(GIT_ATTR_CHECKIN);
 
 	if (o->clone)
-- 
2.37.0

