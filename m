Return-Path: <SRS0=jbtA=B7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3375C433E1
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 21:53:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91E99207CD
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 21:53:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbgHUVxd (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Aug 2020 17:53:33 -0400
Received: from mga14.intel.com ([192.55.52.115]:37971 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726187AbgHUVxc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Aug 2020 17:53:32 -0400
IronPort-SDR: 6cVmH4trqyGGMEFZvbAhOARjtoAiqFCF7ngUl7dP3I9DxkDrcoNznmpGh9JrssXdUoodrTcWrg
 JqGdwIZTiFjQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9720"; a="154905446"
X-IronPort-AV: E=Sophos;i="5.76,338,1592895600"; 
   d="scan'208";a="154905446"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2020 14:53:01 -0700
IronPort-SDR: YteJmc6JbzTpotPI9lVBSVe9uD+Ho0EhLB0UOquVvAb15R9p9AMxjp/UhWkzC/l3hoAy68rESN
 RusSd942FWXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,338,1592895600"; 
   d="scan'208";a="280370336"
Received: from jekeller-desk.amr.corp.intel.com ([10.166.241.33])
  by fmsmga008.fm.intel.com with ESMTP; 21 Aug 2020 14:53:01 -0700
From:   Jacob Keller <jacob.e.keller@intel.com>
To:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>
Cc:     Jacob Keller <jacob.keller@gmail.com>
Subject: [RFC v2 0/1] implement support for negative refspecs
Date:   Fri, 21 Aug 2020 14:52:46 -0700
Message-Id: <20200821215247.758978-1-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.28.0.218.ge27853923b9d.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jacob Keller <jacob.keller@gmail.com>

This series introduces support for negative refspecs. It builds on top of a
couple of minor refspec cleanups which I posted at [1].

The primary motivator for negative refspecs is to allow additional control
over refspec patterns. Today, both fetch and push support refspecs with
patterns. This allows expressing a fetch of simple globs. Because refspec
patterns are simple and not regular expressions, it is not possible to
express some cases that a user might wish.

Suppose you want to fetch all remote branches *except* for a
specific one. For example, a repository which has renamed its primary branch
to "main" but has left the older branch "master" in order to avoid breaking
existing workflows. You wish to have only main, but not master, in your
local copy. To do this, you could modify your remote config to explicitly
list every branch you want to fetch except for the refs/heads/master. If
there are many branches, this would be tedious. Further, it requires manual
intervention for each new branch.

With negative refspecs, you can simply fetch
refs/heads/*:refs/remotes/origin/* along with ^refs/heads/master and git
will now exclude that branch from the fetch.

[1]: https://lore.kernel.org/git/20200821214820.757222-1-jacob.e.keller@intel.com/T/#t

Range diff since v1:

1:  6a53c459e868 ! 1:  04cdd0313529 refspec: add support for negative refspecs
    @@ Commit message
         This is similar to how negative pathspecs work.
     
         Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
      ## builtin/fetch.c ##
     @@ builtin/fetch.c: static struct ref *get_ref_map(struct remote *remote,
      		tail = &rm->next;
      	}
      
    -+	/* apply any negative refspecs now to prune the list of refs */
    -+	ref_map = apply_negative_refspecs(ref_map, rs);
    ++	/*
    ++	 * apply negative refspecs first, before we remove duplicates. This is
    ++	 * necessary as negative refspecs might remove an otherwise conflicting
    ++	 * duplicate.
    ++	 */
    ++	if (rs->nr)
    ++		ref_map = apply_negative_refspecs(ref_map, rs);
    ++	else
    ++		ref_map = apply_negative_refspecs(ref_map, &remote->fetch);
     +
      	ref_map = ref_remove_duplicates(ref_map);
      
    @@ refspec.c: static int parse_refspec(struct refspec_item *item, const char *refsp
      	 * Before going on, special case ":" (or "+:") as a refspec
      	 * for pushing matching refs.
     @@ refspec.c: static int parse_refspec(struct refspec_item *item, const char *refspec, int fet
    + 
    + 	llen = (rhs ? (rhs - lhs - 1) : strlen(lhs));
    + 	if (1 <= llen && memchr(lhs, '*', llen)) {
    +-		if ((rhs && !is_glob) || (!rhs && fetch))
    ++		if ((rhs && !is_glob) || (!rhs && !item->negative && fetch))
    + 			return 0;
    + 		is_glob = 1;
    + 	} else if (rhs && is_glob) {
    +@@ refspec.c: static int parse_refspec(struct refspec_item *item, const char *refspec, int fet
      	item->src = xstrndup(lhs, llen);
      	flags = REFNAME_ALLOW_ONELEVEL | (is_glob ? REFNAME_REFSPEC_PATTERN : 0);
      
    @@ refspec.c: static int parse_refspec(struct refspec_item *item, const char *refsp
      	if (fetch) {
      		struct object_id unused;
      
    +@@ refspec.c: void refspec_ref_prefixes(const struct refspec *rs,
    + 		const struct refspec_item *item = &rs->items[i];
    + 		const char *prefix = NULL;
    + 
    +-		if (item->exact_sha1)
    ++		if (item->exact_sha1 || item->negative)
    + 			continue;
    + 		if (rs->fetch == REFSPEC_FETCH)
    + 			prefix = item->src;
     
      ## refspec.h ##
     @@
    @@ refspec.h: struct refspec_item {
      	char *dst;
     
      ## remote.c ##
    -@@ remote.c: static int match_explicit(struct ref *src, struct ref *dst,
    - 	const char *dst_value = rs->dst;
    - 	char *dst_guess;
    - 
    --	if (rs->pattern || rs->matching)
    -+	if (rs->pattern || rs->matching || rs->negative)
    - 		return 0;
    - 
    - 	matched_src = matched_dst = NULL;
    -@@ remote.c: static char *get_ref_match(const struct refspec *rs, const struct ref *ref,
    - 	int matching_refs = -1;
    - 	for (i = 0; i < rs->nr; i++) {
    - 		const struct refspec_item *item = &rs->items[i];
    -+
    -+		if (item->negative)
    -+			continue;
    -+
    - 		if (item->matching &&
    - 		    (matching_refs == -1 || item->force)) {
    - 			matching_refs = i;
    -@@ remote.c: int match_push_refs(struct ref *src, struct ref **dst,
    - 		string_list_clear(&src_ref_index, 0);
    - 	}
    - 
    -+	*dst = apply_negative_refspecs(*dst, rs);
    -+
    - 	if (errs)
    - 		return -1;
    - 	return 0;
    -@@ remote.c: int get_fetch_map(const struct ref *remote_refs,
    - {
    - 	struct ref *ref_map, **rmp;
    - 
    -+	if (refspec->negative)
    -+		return 0;
    -+
    - 	if (refspec->pattern) {
    - 		ref_map = get_expanded_map(remote_refs, refspec);
    - 	} else {
    -@@ remote.c: int get_fetch_map(const struct ref *remote_refs,
    - 	return 0;
    +@@ remote.c: static int match_name_with_pattern(const char *key, const char *name,
    + 	return ret;
      }
      
     +static int refspec_match(const struct refspec_item *refspec,
    @@ remote.c: int get_fetch_map(const struct ref *remote_refs,
     +	return ref_map;
     +}
     +
    - int resolve_remote_symref(struct ref *ref, struct ref *list)
    + static void query_refspecs_multiple(struct refspec *rs,
    + 				    struct refspec_item *query,
    + 				    struct string_list *results)
      {
    - 	if (!ref->symref)
    +-	int i;
    ++	int i, matched_negative = 0;
    + 	int find_src = !query->src;
    ++	struct string_list reversed = STRING_LIST_INIT_NODUP;
    ++	const char *needle = find_src ? query->dst : query->src;
    ++	char **result = find_src ? &query->src : &query->dst;
    + 
    + 	if (find_src && !query->dst)
    + 		BUG("query_refspecs_multiple: need either src or dst");
    + 
    ++	/*
    ++	 * If a ref matches any of the negative refspecs, then we should treat
    ++	 * it as not matching this query. Note that negative refspecs apply to
    ++	 * the source but we're checking only the destination. Reverse and
    ++	 * capture any pattern refspecs in order to see if the source would
    ++	 * have matched a negative refspec.
    ++	 */
    ++	for (i = 0; i < rs->nr; i++) {
    ++		struct refspec_item *refspec = &rs->items[i];
    ++		char *expn_name;
    ++
    ++		if (refspec->negative)
    ++			continue;
    ++
    ++		/* Note the reversal of src and dst */
    ++		if (refspec->pattern) {
    ++			const char *key = refspec->dst ?: refspec->src;
    ++			const char *value = refspec->src;
    ++
    ++			if (match_name_with_pattern(key, needle, value, &expn_name))
    ++				string_list_append_nodup(&reversed, expn_name);
    ++		} else {
    ++			if (!strcmp(needle, refspec->src))
    ++				string_list_append(&reversed, refspec->src);
    ++		}
    ++	}
    ++
    ++	for (i = 0; !matched_negative && i < reversed.nr; i++) {
    ++		if (omit_name_by_refspec(reversed.items[i].string, rs))
    ++			matched_negative = 1;
    ++	}
    ++
    ++	string_list_clear(&reversed, 0);
    ++
    ++	if (matched_negative)
    ++		return;
    ++
    + 	for (i = 0; i < rs->nr; i++) {
    + 		struct refspec_item *refspec = &rs->items[i];
    + 		const char *key = find_src ? refspec->dst : refspec->src;
    + 		const char *value = find_src ? refspec->src : refspec->dst;
    +-		const char *needle = find_src ? query->dst : query->src;
    +-		char **result = find_src ? &query->src : &query->dst;
    + 
    +-		if (!refspec->dst)
    ++		if (!refspec->dst || refspec->negative)
    + 			continue;
    + 		if (refspec->pattern) {
    + 			if (match_name_with_pattern(key, needle, value, result))
    +@@ remote.c: static void query_refspecs_multiple(struct refspec *rs,
    + 
    + int query_refspecs(struct refspec *rs, struct refspec_item *query)
    + {
    +-	int i;
    ++	int i, matched_negative = 0;
    + 	int find_src = !query->src;
    ++	struct string_list reversed = STRING_LIST_INIT_NODUP;
    + 	const char *needle = find_src ? query->dst : query->src;
    + 	char **result = find_src ? &query->src : &query->dst;
    + 
    + 	if (find_src && !query->dst)
    + 		BUG("query_refspecs: need either src or dst");
    + 
    ++	/*
    ++	 * If a ref matches any of the negative refspecs, then we should treat
    ++	 * it as not matching this query. Note that negative refspecs apply to
    ++	 * the source but we're checking only the destination. Reverse and
    ++	 * capture any pattern refspecs in order to see if the source would
    ++	 * have matched a negative refspec.
    ++	 */
    ++	for (i = 0; i < rs->nr; i++) {
    ++		struct refspec_item *refspec = &rs->items[i];
    ++		char *expn_name;
    ++
    ++		if (refspec->negative)
    ++			continue;
    ++
    ++		/* Note the reversal of src and dst */
    ++		if (refspec->pattern) {
    ++			const char *key = refspec->dst ?: refspec->src;
    ++			const char *value = refspec->src;
    ++
    ++			if (match_name_with_pattern(key, needle, value, &expn_name))
    ++				string_list_append_nodup(&reversed, expn_name);
    ++		} else {
    ++			if (!strcmp(needle, refspec->src))
    ++				string_list_append(&reversed, refspec->src);
    ++		}
    ++	}
    ++
    ++	for (i = 0; !matched_negative && i < reversed.nr; i++) {
    ++		if (omit_name_by_refspec(reversed.items[i].string, rs))
    ++			matched_negative = 1;
    ++	}
    ++
    ++	string_list_clear(&reversed, 0);
    ++
    ++	if (matched_negative)
    ++		return -1;
    ++
    + 	for (i = 0; i < rs->nr; i++) {
    + 		struct refspec_item *refspec = &rs->items[i];
    + 		const char *key = find_src ? refspec->dst : refspec->src;
    + 		const char *value = find_src ? refspec->src : refspec->dst;
    + 
    +-		if (!refspec->dst)
    ++		if (!refspec->dst || refspec->negative)
    + 			continue;
    + 		if (refspec->pattern) {
    + 			if (match_name_with_pattern(key, needle, value, result)) {
    +@@ remote.c: static int match_explicit(struct ref *src, struct ref *dst,
    + 	const char *dst_value = rs->dst;
    + 	char *dst_guess;
    + 
    +-	if (rs->pattern || rs->matching)
    ++	if (rs->pattern || rs->matching || rs->negative)
    + 		return 0;
    + 
    + 	matched_src = matched_dst = NULL;
    +@@ remote.c: static char *get_ref_match(const struct refspec *rs, const struct ref *ref,
    + 	int matching_refs = -1;
    + 	for (i = 0; i < rs->nr; i++) {
    + 		const struct refspec_item *item = &rs->items[i];
    ++
    ++		if (item->negative)
    ++			continue;
    ++
    + 		if (item->matching &&
    + 		    (matching_refs == -1 || item->force)) {
    + 			matching_refs = i;
    +@@ remote.c: int check_push_refs(struct ref *src, struct refspec *rs)
    + 	for (i = 0; i < rs->nr; i++) {
    + 		struct refspec_item *item = &rs->items[i];
    + 
    +-		if (item->pattern || item->matching)
    ++		if (item->pattern || item->matching || item->negative)
    + 			continue;
    + 
    + 		ret |= match_explicit_lhs(src, item, NULL, NULL);
    +@@ remote.c: int match_push_refs(struct ref *src, struct ref **dst,
    + 		string_list_clear(&src_ref_index, 0);
    + 	}
    + 
    ++	*dst = apply_negative_refspecs(*dst, rs);
    ++
    + 	if (errs)
    + 		return -1;
    + 	return 0;
    +@@ remote.c: int get_fetch_map(const struct ref *remote_refs,
    + {
    + 	struct ref *ref_map, **rmp;
    + 
    ++	if (refspec->negative)
    ++		return 0;
    ++
    + 	if (refspec->pattern) {
    + 		ref_map = get_expanded_map(remote_refs, refspec);
    + 	} else {
     
      ## remote.h ##
     @@ remote.h: int resolve_remote_symref(struct ref *ref, struct ref *list);
    @@ remote.h: void set_ref_status_for_push(struct ref *remote_refs, int send_mirror,
       *
       * *tail is the pointer to the tail pointer of the list of results
       * beforehand, and will be set to the tail pointer of the list of
    +
    + ## t/t5582-fetch-negative-refspec.sh (new) ##
    +@@
    ++#!/bin/sh
    ++# Copyright (c) 2020, Jacob Keller.
    ++
    ++test_description='"git fetch" with negative refspecs.
    ++
    ++'
    ++
    ++. ./test-lib.sh
    ++
    ++test_expect_success setup '
    ++	echo >file original &&
    ++	git add file &&
    ++	git commit -a -m original
    ++'
    ++
    ++test_expect_success "clone and setup child repos" '
    ++	git clone . one &&
    ++	(
    ++		cd one &&
    ++		echo >file updated by one &&
    ++		git commit -a -m "updated by one" &&
    ++		git switch -c alternate &&
    ++		echo >file updated again by one &&
    ++		git commit -a -m "updated by one again" &&
    ++		git switch master
    ++	) &&
    ++	git clone . two &&
    ++	(
    ++		cd two &&
    ++		git config branch.master.remote one &&
    ++		git config remote.one.url ../one/.git/ &&
    ++		git config remote.one.fetch +refs/heads/*:refs/remotes/one/* &&
    ++		git config --add remote.one.fetch ^refs/heads/alternate
    ++	) &&
    ++	git clone . three
    ++'
    ++
    ++test_expect_success "fetch one" '
    ++	echo >file updated by origin &&
    ++	git commit -a -m "updated by origin" &&
    ++	(
    ++		cd two &&
    ++		test_must_fail git rev-parse --verify refs/remotes/one/alternate &&
    ++		git fetch one &&
    ++		test_must_fail git rev-parse --verify refs/remotes/one/alternate &&
    ++		git rev-parse --verify refs/remotes/one/master &&
    ++		mine=$(git rev-parse refs/remotes/one/master) &&
    ++		his=$(cd ../one && git rev-parse refs/heads/master) &&
    ++		test "z$mine" = "z$his"
    ++	)
    ++'
    ++
    ++test_expect_success "fetch with negative refspec on commandline" '
    ++	echo >file updated by origin again &&
    ++	git commit -a -m "updated by origin again" &&
    ++	(
    ++		cd three &&
    ++		alternate_in_one=$(cd ../one && git rev-parse refs/heads/alternate) &&
    ++		echo $alternate_in_one >expect &&
    ++		git fetch ../one/.git refs/heads/*:refs/remotes/one/* ^refs/heads/master &&
    ++		cut -f -1 .git/FETCH_HEAD >actual &&
    ++		test_cmp expect actual
    ++	)
    ++'
    ++
    ++test_expect_success "fetch with negative refspec avoids duplicate conflict" '
    ++	cd "$D" &&
    ++	(
    ++		cd one &&
    ++		git branch dups/a &&
    ++		git branch dups/b &&
    ++		git branch dups/c &&
    ++		git branch other/a &&
    ++		git rev-parse --verify refs/heads/other/a >../expect &&
    ++		git rev-parse --verify refs/heads/dups/b >>../expect &&
    ++		git rev-parse --verify refs/heads/dups/c >>../expect
    ++	) &&
    ++	(
    ++		cd three &&
    ++		git fetch ../one/.git ^refs/heads/dups/a refs/heads/dups/*:refs/dups/* refs/heads/other/a:refs/dups/a &&
    ++		git rev-parse --verify refs/dups/a >../actual &&
    ++		git rev-parse --verify refs/dups/b >>../actual &&
    ++		git rev-parse --verify refs/dups/c >>../actual
    ++	) &&
    ++	test_cmp expect actual
    ++'
    ++
    ++test_expect_success "push --prune with negative refspec" '
    ++	(
    ++		cd two &&
    ++		git branch prune/a &&
    ++		git branch prune/b &&
    ++		git branch prune/c &&
    ++		git push ../three refs/heads/prune/* &&
    ++		git branch -d prune/a &&
    ++		git branch -d prune/b &&
    ++		git push --prune ../three refs/heads/prune/* ^refs/heads/prune/b
    ++	) &&
    ++	(
    ++		cd three &&
    ++		test_write_lines b c >expect &&
    ++		git for-each-ref --format="%(refname:lstrip=3)" refs/heads/prune/ >actual &&
    ++		test_cmp expect actual
    ++	)
    ++'
    ++
    ++test_expect_success "push --prune with negative refspec apply to the destination" '
    ++	(
    ++		cd two &&
    ++		git branch ours/a &&
    ++		git branch ours/b &&
    ++		git branch ours/c &&
    ++		git push ../three refs/heads/ours/*:refs/heads/theirs/* &&
    ++		git branch -d ours/a &&
    ++		git branch -d ours/b &&
    ++		git push --prune ../three refs/heads/ours/*:refs/heads/theirs/* ^refs/heads/theirs/b
    ++	) &&
    ++	(
    ++		cd three &&
    ++		test_write_lines b c >expect &&
    ++		git for-each-ref --format="%(refname:lstrip=3)" refs/heads/theirs/ >actual &&
    ++		test_cmp expect actual
    ++	)
    ++'
    ++
    ++test_expect_success "fetch --prune with negative refspec" '
    ++	(
    ++		cd two &&
    ++		git branch fetch/a &&
    ++		git branch fetch/b &&
    ++		git branch fetch/c
    ++	) &&
    ++	(
    ++		cd three &&
    ++		git fetch ../two/.git refs/heads/fetch/*:refs/heads/copied/*
    ++	) &&
    ++	(
    ++		cd two &&
    ++		git branch -d fetch/a &&
    ++		git branch -d fetch/b
    ++	) &&
    ++	(
    ++		cd three &&
    ++		test_write_lines b c >expect &&
    ++		git fetch -v ../two/.git --prune refs/heads/fetch/*:refs/heads/copied/* ^refs/heads/fetch/b &&
    ++		git for-each-ref --format="%(refname:lstrip=3)" refs/heads/copied/ >actual &&
    ++		test_cmp expect actual
    ++	)
    ++'
    ++
    ++test_done

Jacob Keller (1):
  refspec: add support for negative refspecs

 builtin/fetch.c                   |  10 ++
 refspec.c                         |  34 ++++++-
 refspec.h                         |  14 +--
 remote.c                          | 139 +++++++++++++++++++++++++--
 remote.h                          |   9 +-
 t/t5582-fetch-negative-refspec.sh | 151 ++++++++++++++++++++++++++++++
 6 files changed, 340 insertions(+), 17 deletions(-)
 create mode 100755 t/t5582-fetch-negative-refspec.sh


base-commit: 3a7f6cbded99451cc61ac8b03d3451d13e532055
-- 
2.28.0.218.ge27853923b9d.dirty

