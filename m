Return-Path: <SRS0=XLsf=DH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E65EC4363D
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 21:58:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39CCD20658
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 21:58:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730817AbgI3V6a (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Sep 2020 17:58:30 -0400
Received: from mga06.intel.com ([134.134.136.31]:3961 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728721AbgI3V6a (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Sep 2020 17:58:30 -0400
IronPort-SDR: A/YtteTVypytM4C+0ToL5nT0iZ69ufPiYO9djTNV3iU3f+XEDCEJN7+hEvdq71yyWedaIA7TEq
 TfjcyIEeTU+A==
X-IronPort-AV: E=McAfee;i="6000,8403,9760"; a="224154738"
X-IronPort-AV: E=Sophos;i="5.77,322,1596524400"; 
   d="scan'208";a="224154738"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2020 14:58:25 -0700
IronPort-SDR: ubWvXsHyBs2sgLvmpprJhi+U2qH6V1TGkdi/4t3sQ3KfyPxUeueCuca0aQVPFbhUHKNlRs6w6o
 q4iWMBNYt2lA==
X-IronPort-AV: E=Sophos;i="5.77,322,1596524400"; 
   d="scan'208";a="415827393"
Received: from jekeller-desk.amr.corp.intel.com ([10.166.241.4])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2020 14:58:24 -0700
From:   Jacob Keller <jacob.e.keller@intel.com>
To:     git@vger.kernel.org
Cc:     Jacob Keller <jacob.keller@gmail.com>
Subject: [v5] refspec: add support for negative refspecs
Date:   Wed, 30 Sep 2020 14:57:28 -0700
Message-Id: <20200930215728.108896-1-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.28.0.497.g54e85e7af1ac
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jacob Keller <jacob.keller@gmail.com>

Both fetch and push support pattern refspecs which allow fetching or
pushing references that match a specific pattern. Because these patterns
are globs, they have somewhat limited ability to express more complex
situations.

For example, suppose you wish to fetch all branches from a remote except
for a specific one. To allow this, you must setup a set of refspecs
which match only the branches you want. Because refspecs are either
explicit name matches, or simple globs, many patterns cannot be
expressed.

Add support for a new type of refspec, referred to as "negative"
refspecs. These are prefixed with a '^' and mean "exclude any ref
matching this refspec". They can only have one "side" which always
refers to the source. During a fetch, this refers to the name of the ref
on the remote. During a push, this refers to the name of the ref on the
local side.

With negative refspecs, users can express more complex patterns. For
example:

 git fetch origin refs/heads/*:refs/remotes/origin/* ^refs/heads/dontwant

will fetch all branches on origin into remotes/origin, but will exclude
fetching the branch named dontwant.

Refspecs today are commutative, meaning that order doesn't expressly
matter. Rather than forcing an implied order, negative refspecs will
always be applied last. That is, in order to match, a ref must match at
least one positive refspec, and match none of the negative refspecs.
This is similar to how negative pathspecs work.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---

Uuuugh, not my day. This time I actually fixed the commit instead of just
staging the changes to the index...

 Documentation/pull-fetch-param.txt |  16 +++
 builtin/fetch.c                    |  10 ++
 refspec.c                          |  34 +++++-
 refspec.h                          |  14 ++-
 remote.c                           | 108 ++++++++++++++++-
 remote.h                           |   9 +-
 t/t5582-fetch-negative-refspec.sh  | 189 +++++++++++++++++++++++++++++
 7 files changed, 367 insertions(+), 13 deletions(-)
 create mode 100755 t/t5582-fetch-negative-refspec.sh

diff --git a/Documentation/pull-fetch-param.txt b/Documentation/pull-fetch-param.txt
index 95ea84990298..95a7390b2c78 100644
--- a/Documentation/pull-fetch-param.txt
+++ b/Documentation/pull-fetch-param.txt
@@ -30,6 +30,22 @@ The colon can be omitted when <dst> is empty.  <src> is
 typically a ref, but it can also be a fully spelled hex object
 name.
 +
+A <refspec> may contain a `*` in its <src> to indicate a simple pattern
+match. Such a refspec functions like a glob that matches any ref with the
+same prefix. A pattern <refspec> must have a `*` in both the <src> and
+<dst>. It will map refs to the destination by replacing the `*` with the
+contents matched from the source.
++
+If a refspec is prefixed by `^`, it will be interpreted as a negative
+refspec. Rather than specifying which refs to fetch or which local refs to
+update, such a refspec will instead specify refs to exclude. A ref will be
+considered to match if it matches at least one positive refspec, and does
+not match any negative refspec. Negative refspecs can be useful to restrict
+the scope of a pattern refspec so that it will not include specific refs.
+Negative refspecs can themselves be pattern refspecs. However, they may only
+contain a <src> and do not specify a <dst>. Fully spelled out hex object
+names are also not supported.
++
 `tag <tag>` means the same as `refs/tags/<tag>:refs/tags/<tag>`;
 it requests fetching everything up to the given tag.
 +
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 1b00c2bee90b..e95bf8877ddd 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -537,6 +537,16 @@ static struct ref *get_ref_map(struct remote *remote,
 		tail = &rm->next;
 	}
 
+	/*
+	 * apply negative refspecs first, before we remove duplicates. This is
+	 * necessary as negative refspecs might remove an otherwise conflicting
+	 * duplicate.
+	 */
+	if (rs->nr)
+		ref_map = apply_negative_refspecs(ref_map, rs);
+	else
+		ref_map = apply_negative_refspecs(ref_map, &remote->fetch);
+
 	ref_map = ref_remove_duplicates(ref_map);
 
 	for (rm = ref_map; rm; rm = rm->next) {
diff --git a/refspec.c b/refspec.c
index 8d0affc34a6b..8af357a0a35d 100644
--- a/refspec.c
+++ b/refspec.c
@@ -8,6 +8,7 @@ static struct refspec_item s_tag_refspec = {
 	1,
 	0,
 	0,
+	0,
 	"refs/tags/*",
 	"refs/tags/*"
 };
@@ -32,10 +33,17 @@ static int parse_refspec(struct refspec_item *item, const char *refspec, int fet
 	if (*lhs == '+') {
 		item->force = 1;
 		lhs++;
+	} else if (*lhs == '^') {
+		item->negative = 1;
+		lhs++;
 	}
 
 	rhs = strrchr(lhs, ':');
 
+	/* negative refspecs only have one side */
+	if (item->negative && rhs)
+		return 0;
+
 	/*
 	 * Before going on, special case ":" (or "+:") as a refspec
 	 * for pushing matching refs.
@@ -55,7 +63,7 @@ static int parse_refspec(struct refspec_item *item, const char *refspec, int fet
 
 	llen = (rhs ? (rhs - lhs - 1) : strlen(lhs));
 	if (1 <= llen && memchr(lhs, '*', llen)) {
-		if ((rhs && !is_glob) || (!rhs && fetch))
+		if ((rhs && !is_glob) || (!rhs && !item->negative && fetch))
 			return 0;
 		is_glob = 1;
 	} else if (rhs && is_glob) {
@@ -66,6 +74,28 @@ static int parse_refspec(struct refspec_item *item, const char *refspec, int fet
 	item->src = xstrndup(lhs, llen);
 	flags = REFNAME_ALLOW_ONELEVEL | (is_glob ? REFNAME_REFSPEC_PATTERN : 0);
 
+	if (item->negative) {
+		struct object_id unused;
+
+		/*
+		 * Negative refspecs only have a LHS, which indicates a ref
+		 * (or pattern of refs) to exclude from other matches. This
+		 * can either be a simple ref, or a glob pattern. Exact sha1
+		 * match is not currently supported.
+		 */
+		if (!*item->src)
+			return 0; /* negative refspecs must not be empty */
+		else if (llen == the_hash_algo->hexsz && !get_oid_hex(item->src, &unused))
+			return 0; /* negative refpsecs cannot be exact sha1 */
+		else if (!check_refname_format(item->src, flags))
+			; /* valid looking ref is ok */
+		else
+			return 0;
+
+		/* the other rules below do not apply to negative refspecs */
+		return 1;
+	}
+
 	if (fetch) {
 		struct object_id unused;
 
@@ -223,7 +253,7 @@ void refspec_ref_prefixes(const struct refspec *rs,
 		const struct refspec_item *item = &rs->items[i];
 		const char *prefix = NULL;
 
-		if (item->exact_sha1)
+		if (item->exact_sha1 || item->negative)
 			continue;
 		if (rs->fetch == REFSPEC_FETCH)
 			prefix = item->src;
diff --git a/refspec.h b/refspec.h
index 7569248d11b1..955183239923 100644
--- a/refspec.h
+++ b/refspec.h
@@ -5,12 +5,13 @@
 extern const struct refspec_item *tag_refspec;
 
 /**
- * A struct refspec_item holds the parsed interpretation of a refspec.  If it will
- * force updates (starts with a '+'), force is true.  If it is a pattern
- * (sides end with '*') pattern is true.  src and dest are the two sides
- * (including '*' characters if present); if there is only one side, it is src,
- * and dst is NULL; if sides exist but are empty (i.e., the refspec either
- * starts or ends with ':'), the corresponding side is "".
+ * A struct refspec_item holds the parsed interpretation of a refspec.  If it
+ * will force updates (starts with a '+'), force is true.  If it is a pattern
+ * (sides end with '*') pattern is true.  If it is a negative refspec, (starts
+ * with '^'), negative is true.  src and dest are the two sides (including '*'
+ * characters if present); if there is only one side, it is src, and dst is
+ * NULL; if sides exist but are empty (i.e., the refspec either starts or ends
+ * with ':'), the corresponding side is "".
  *
  * remote_find_tracking(), given a remote and a struct refspec_item with either src
  * or dst filled out, will fill out the other such that the result is in the
@@ -22,6 +23,7 @@ struct refspec_item {
 	unsigned pattern : 1;
 	unsigned matching : 1;
 	unsigned exact_sha1 : 1;
+	unsigned negative : 1;
 
 	char *src;
 	char *dst;
diff --git a/remote.c b/remote.c
index eafc14cbe759..8be67f0892b4 100644
--- a/remote.c
+++ b/remote.c
@@ -682,6 +682,91 @@ static int match_name_with_pattern(const char *key, const char *name,
 	return ret;
 }
 
+static int refspec_match(const struct refspec_item *refspec,
+			 const char *name)
+{
+	if (refspec->pattern)
+		return match_name_with_pattern(refspec->src, name, NULL, NULL);
+
+	return !strcmp(refspec->src, name);
+}
+
+static int omit_name_by_refspec(const char *name, struct refspec *rs)
+{
+	int i;
+
+	for (i = 0; i < rs->nr; i++) {
+		if (rs->items[i].negative && refspec_match(&rs->items[i], name))
+			return 1;
+	}
+	return 0;
+}
+
+struct ref *apply_negative_refspecs(struct ref *ref_map, struct refspec *rs)
+{
+	struct ref **tail;
+
+	for (tail = &ref_map; *tail; ) {
+		struct ref *ref = *tail;
+
+		if (omit_name_by_refspec(ref->name, rs)) {
+			*tail = ref->next;
+			free(ref->peer_ref);
+			free(ref);
+		} else
+			tail = &ref->next;
+	}
+
+	return ref_map;
+}
+
+static int query_matches_negative_refspec(struct refspec *rs, struct refspec_item *query)
+{
+	int i, matched_negative = 0;
+	int find_src = !query->src;
+	struct string_list reversed = STRING_LIST_INIT_NODUP;
+	const char *needle = find_src ? query->dst : query->src;
+
+	/*
+	 * Check whether the queried ref matches any negative refpsec. If so,
+	 * then we should ultimately treat this as not matching the query at
+	 * all.
+	 *
+	 * Note that negative refspecs always match the source, but the query
+	 * item uses the destination. To handle this, we apply pattern
+	 * refspecs in reverse to figure out if the query source matches any
+	 * of the negative refspecs.
+	 */
+	for (i = 0; i < rs->nr; i++) {
+		struct refspec_item *refspec = &rs->items[i];
+		char *expn_name;
+
+		if (refspec->negative)
+			continue;
+
+		/* Note the reversal of src and dst */
+		if (refspec->pattern) {
+			const char *key = refspec->dst ? refspec->dst : refspec->src;
+			const char *value = refspec->src;
+
+			if (match_name_with_pattern(key, needle, value, &expn_name))
+				string_list_append_nodup(&reversed, expn_name);
+		} else {
+			if (!strcmp(needle, refspec->src))
+				string_list_append(&reversed, refspec->src);
+		}
+	}
+
+	for (i = 0; !matched_negative && i < reversed.nr; i++) {
+		if (omit_name_by_refspec(reversed.items[i].string, rs))
+			matched_negative = 1;
+	}
+
+	string_list_clear(&reversed, 0);
+
+	return matched_negative;
+}
+
 static void query_refspecs_multiple(struct refspec *rs,
 				    struct refspec_item *query,
 				    struct string_list *results)
@@ -692,6 +777,9 @@ static void query_refspecs_multiple(struct refspec *rs,
 	if (find_src && !query->dst)
 		BUG("query_refspecs_multiple: need either src or dst");
 
+	if (query_matches_negative_refspec(rs, query))
+		return;
+
 	for (i = 0; i < rs->nr; i++) {
 		struct refspec_item *refspec = &rs->items[i];
 		const char *key = find_src ? refspec->dst : refspec->src;
@@ -699,7 +787,7 @@ static void query_refspecs_multiple(struct refspec *rs,
 		const char *needle = find_src ? query->dst : query->src;
 		char **result = find_src ? &query->src : &query->dst;
 
-		if (!refspec->dst)
+		if (!refspec->dst || refspec->negative)
 			continue;
 		if (refspec->pattern) {
 			if (match_name_with_pattern(key, needle, value, result))
@@ -720,12 +808,15 @@ int query_refspecs(struct refspec *rs, struct refspec_item *query)
 	if (find_src && !query->dst)
 		BUG("query_refspecs: need either src or dst");
 
+	if (query_matches_negative_refspec(rs, query))
+		return -1;
+
 	for (i = 0; i < rs->nr; i++) {
 		struct refspec_item *refspec = &rs->items[i];
 		const char *key = find_src ? refspec->dst : refspec->src;
 		const char *value = find_src ? refspec->src : refspec->dst;
 
-		if (!refspec->dst)
+		if (!refspec->dst || refspec->negative)
 			continue;
 		if (refspec->pattern) {
 			if (match_name_with_pattern(key, needle, value, result)) {
@@ -1054,7 +1145,7 @@ static int match_explicit(struct ref *src, struct ref *dst,
 	const char *dst_value = rs->dst;
 	char *dst_guess;
 
-	if (rs->pattern || rs->matching)
+	if (rs->pattern || rs->matching || rs->negative)
 		return 0;
 
 	matched_src = matched_dst = NULL;
@@ -1130,6 +1221,10 @@ static char *get_ref_match(const struct refspec *rs, const struct ref *ref,
 	int matching_refs = -1;
 	for (i = 0; i < rs->nr; i++) {
 		const struct refspec_item *item = &rs->items[i];
+
+		if (item->negative)
+			continue;
+
 		if (item->matching &&
 		    (matching_refs == -1 || item->force)) {
 			matching_refs = i;
@@ -1335,7 +1430,7 @@ int check_push_refs(struct ref *src, struct refspec *rs)
 	for (i = 0; i < rs->nr; i++) {
 		struct refspec_item *item = &rs->items[i];
 
-		if (item->pattern || item->matching)
+		if (item->pattern || item->matching || item->negative)
 			continue;
 
 		ret |= match_explicit_lhs(src, item, NULL, NULL);
@@ -1437,6 +1532,8 @@ int match_push_refs(struct ref *src, struct ref **dst,
 		string_list_clear(&src_ref_index, 0);
 	}
 
+	*dst = apply_negative_refspecs(*dst, rs);
+
 	if (errs)
 		return -1;
 	return 0;
@@ -1806,6 +1903,9 @@ int get_fetch_map(const struct ref *remote_refs,
 {
 	struct ref *ref_map, **rmp;
 
+	if (refspec->negative)
+		return 0;
+
 	if (refspec->pattern) {
 		ref_map = get_expanded_map(remote_refs, refspec);
 	} else {
diff --git a/remote.h b/remote.h
index 5e3ea5a26deb..104e75e0f74d 100644
--- a/remote.h
+++ b/remote.h
@@ -193,6 +193,12 @@ int resolve_remote_symref(struct ref *ref, struct ref *list);
  */
 struct ref *ref_remove_duplicates(struct ref *ref_map);
 
+/*
+ * Remove all entries in the input list which match any negative refspec in
+ * the refspec list.
+ */
+struct ref *apply_negative_refspecs(struct ref *ref_map, struct refspec *rs);
+
 int query_refspecs(struct refspec *rs, struct refspec_item *query);
 char *apply_refspecs(struct refspec *rs, const char *name);
 
@@ -205,7 +211,8 @@ void set_ref_status_for_push(struct ref *remote_refs, int send_mirror,
 /*
  * Given a list of the remote refs and the specification of things to
  * fetch, makes a (separate) list of the refs to fetch and the local
- * refs to store into.
+ * refs to store into. Note that negative refspecs are ignored here, and
+ * should be handled separately.
  *
  * *tail is the pointer to the tail pointer of the list of results
  * beforehand, and will be set to the tail pointer of the list of
diff --git a/t/t5582-fetch-negative-refspec.sh b/t/t5582-fetch-negative-refspec.sh
new file mode 100755
index 000000000000..8c61e28fec85
--- /dev/null
+++ b/t/t5582-fetch-negative-refspec.sh
@@ -0,0 +1,189 @@
+#!/bin/sh
+# Copyright (c) 2020, Jacob Keller.
+
+test_description='"git fetch" with negative refspecs.
+
+'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+	echo >file original &&
+	git add file &&
+	git commit -a -m original
+'
+
+test_expect_success "clone and setup child repos" '
+	git clone . one &&
+	(
+		cd one &&
+		echo >file updated by one &&
+		git commit -a -m "updated by one" &&
+		git switch -c alternate &&
+		echo >file updated again by one &&
+		git commit -a -m "updated by one again" &&
+		git switch master
+	) &&
+	git clone . two &&
+	(
+		cd two &&
+		git config branch.master.remote one &&
+		git config remote.one.url ../one/.git/ &&
+		git config remote.one.fetch +refs/heads/*:refs/remotes/one/* &&
+		git config --add remote.one.fetch ^refs/heads/alternate
+	) &&
+	git clone . three
+'
+
+test_expect_success "fetch one" '
+	echo >file updated by origin &&
+	git commit -a -m "updated by origin" &&
+	(
+		cd two &&
+		test_must_fail git rev-parse --verify refs/remotes/one/alternate &&
+		git fetch one &&
+		test_must_fail git rev-parse --verify refs/remotes/one/alternate &&
+		git rev-parse --verify refs/remotes/one/master &&
+		mine=$(git rev-parse refs/remotes/one/master) &&
+		his=$(cd ../one && git rev-parse refs/heads/master) &&
+		test "z$mine" = "z$his"
+	)
+'
+
+test_expect_success "fetch with negative refspec on commandline" '
+	echo >file updated by origin again &&
+	git commit -a -m "updated by origin again" &&
+	(
+		cd three &&
+		alternate_in_one=$(cd ../one && git rev-parse refs/heads/alternate) &&
+		echo $alternate_in_one >expect &&
+		git fetch ../one/.git refs/heads/*:refs/remotes/one/* ^refs/heads/master &&
+		cut -f -1 .git/FETCH_HEAD >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success "fetch with negative sha1 refspec fails" '
+	echo >file updated by origin yet again &&
+	git commit -a -m "updated by origin yet again" &&
+	(
+		cd three &&
+		master_in_one=$(cd ../one && git rev-parse refs/heads/master) &&
+		test_must_fail git fetch ../one/.git refs/heads/*:refs/remotes/one/* ^$master_in_one
+	)
+'
+
+test_expect_success "fetch with negative pattern refspec" '
+	echo >file updated by origin once more &&
+	git commit -a -m "updated by origin once more" &&
+	(
+		cd three &&
+		alternate_in_one=$(cd ../one && git rev-parse refs/heads/alternate) &&
+		echo $alternate_in_one >expect &&
+		git fetch ../one/.git refs/heads/*:refs/remotes/one/* ^refs/heads/m* &&
+		cut -f -1 .git/FETCH_HEAD >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success "fetch with negative pattern refspec does not expand prefix" '
+	echo >file updated by origin another time &&
+	git commit -a -m "updated by origin another time" &&
+	(
+		cd three &&
+		alternate_in_one=$(cd ../one && git rev-parse refs/heads/alternate) &&
+		master_in_one=$(cd ../one && git rev-parse refs/heads/master) &&
+		echo $alternate_in_one >expect &&
+		echo $master_in_one >>expect &&
+		git fetch ../one/.git refs/heads/*:refs/remotes/one/* ^master &&
+		cut -f -1 .git/FETCH_HEAD >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success "fetch with negative refspec avoids duplicate conflict" '
+	cd "$D" &&
+	(
+		cd one &&
+		git branch dups/a &&
+		git branch dups/b &&
+		git branch dups/c &&
+		git branch other/a &&
+		git rev-parse --verify refs/heads/other/a >../expect &&
+		git rev-parse --verify refs/heads/dups/b >>../expect &&
+		git rev-parse --verify refs/heads/dups/c >>../expect
+	) &&
+	(
+		cd three &&
+		git fetch ../one/.git ^refs/heads/dups/a refs/heads/dups/*:refs/dups/* refs/heads/other/a:refs/dups/a &&
+		git rev-parse --verify refs/dups/a >../actual &&
+		git rev-parse --verify refs/dups/b >>../actual &&
+		git rev-parse --verify refs/dups/c >>../actual
+	) &&
+	test_cmp expect actual
+'
+
+test_expect_success "push --prune with negative refspec" '
+	(
+		cd two &&
+		git branch prune/a &&
+		git branch prune/b &&
+		git branch prune/c &&
+		git push ../three refs/heads/prune/* &&
+		git branch -d prune/a &&
+		git branch -d prune/b &&
+		git push --prune ../three refs/heads/prune/* ^refs/heads/prune/b
+	) &&
+	(
+		cd three &&
+		test_write_lines b c >expect &&
+		git for-each-ref --format="%(refname:lstrip=3)" refs/heads/prune/ >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success "push --prune with negative refspec apply to the destination" '
+	(
+		cd two &&
+		git branch ours/a &&
+		git branch ours/b &&
+		git branch ours/c &&
+		git push ../three refs/heads/ours/*:refs/heads/theirs/* &&
+		git branch -d ours/a &&
+		git branch -d ours/b &&
+		git push --prune ../three refs/heads/ours/*:refs/heads/theirs/* ^refs/heads/theirs/b
+	) &&
+	(
+		cd three &&
+		test_write_lines b c >expect &&
+		git for-each-ref --format="%(refname:lstrip=3)" refs/heads/theirs/ >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success "fetch --prune with negative refspec" '
+	(
+		cd two &&
+		git branch fetch/a &&
+		git branch fetch/b &&
+		git branch fetch/c
+	) &&
+	(
+		cd three &&
+		git fetch ../two/.git refs/heads/fetch/*:refs/heads/copied/*
+	) &&
+	(
+		cd two &&
+		git branch -d fetch/a &&
+		git branch -d fetch/b
+	) &&
+	(
+		cd three &&
+		test_write_lines b c >expect &&
+		git fetch -v ../two/.git --prune refs/heads/fetch/*:refs/heads/copied/* ^refs/heads/fetch/b &&
+		git for-each-ref --format="%(refname:lstrip=3)" refs/heads/copied/ >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_done
-- 
2.28.0.497.g54e85e7af1ac

