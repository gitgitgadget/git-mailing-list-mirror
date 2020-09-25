Return-Path: <SRS0=RFRG=DC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2562C4741F
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 21:08:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 839A92371F
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 21:08:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728855AbgIYVIl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Sep 2020 17:08:41 -0400
Received: from mga02.intel.com ([134.134.136.20]:21629 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728212AbgIYVIg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Sep 2020 17:08:36 -0400
IronPort-SDR: ijKV/zfBegH05ZNK9k16n3iCRJdIVriyrtnq5kFAVCFS8F7MeLMagY6n95Ykk/RY7XP/Nr2XtW
 E/vlHhDgIehg==
X-IronPort-AV: E=McAfee;i="6000,8403,9755"; a="149295044"
X-IronPort-AV: E=Sophos;i="5.77,303,1596524400"; 
   d="scan'208";a="149295044"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2020 14:08:35 -0700
IronPort-SDR: TaIHKEgws3E9iwT/vjL6z67ax/aiBHSnAKcaglUZI5uoRCJ3hq4U70rW0IMMqZSluubieFrUZc
 XDd/f96XYEKQ==
X-IronPort-AV: E=Sophos;i="5.77,303,1596524400"; 
   d="scan'208";a="512385104"
Received: from jekeller-desk.amr.corp.intel.com ([10.166.241.4])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2020 14:08:35 -0700
From:   Jacob Keller <jacob.e.keller@intel.com>
To:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Cc:     Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH v3 0/1] implement negative refspecs
Date:   Fri, 25 Sep 2020 14:07:39 -0700
Message-Id: <20200925210740.1939450-1-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.28.0.497.g54e85e7af1ac
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jacob Keller <jacob.keller@gmail.com>

This series introduces support for a new refspec concept, the negative
refspec. It is a respin of a series posted at [1].

The primary motivation for negative refspecs is to allow restricting the
space that a pattern patch refspec will match over. Both fetch and push
support pattern refspecs which allow matching refs using a simple glob.
Since these only use a single '*' which greedily matches any string, many
types of matches cannot be expressed.

Negative refspecs exist to allow more control over what refs get fetched or
pushed when using pattern refspecs. They function in a similar manner as
negative pathspecs.

Suppose you want to fetch all remote branches from a repository, except for
one specific branch. For example, a repository who recently renamed its
primary branch to "main", but has left the older "master" name in order to
avoid breaking existing workflows. You wish to only fetch "main". You do not
need the "master" branch name anymore because you've updated your work flow.
However, fetching both main and master can lead to some annoyance with tab
completion.

You could modify your remote config to explicitly fetch the set of branches
you care about. However, this means any new branch added to the remote will
not be fetched until you update your config, which requires manual
intervention.

With a negative refspec, you can simply fetch all branches *except* for
refs/heads/master, i.e.

  git fetch refs/heads/*:refs/remotes/origin/* ^refs/heads/master

Negative refspecs restrict the set of refs that are matched for a given
fetch or push. For a fetch, this refers to the name of the ref on the
remote. For a push this refers to the name of the local ref being pushed
out.

A negative refspec is indicated by prefixing the refspec with a ^. Only
regular or pattern refspecs are supported. Support for sha1 identification
of objects is not implemented in this patch. Additionally, negative refspecs
do not expand using normal rules and thus should be the fully spelled out
refspec name.

[1]: https://lore.kernel.org/git/20200821215247.758978-1-jacob.e.keller@intel.com/

Range Diff since v2

1:  7650f8bdf7fd ! 1:  1ff179f8af9e refspec: add support for negative refspecs
    @@ Commit message
         This is similar to how negative pathspecs work.
     
         Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
    +
    + ## Documentation/pull-fetch-param.txt ##
    +@@ Documentation/pull-fetch-param.txt: The colon can be omitted when <dst> is empty.  <src> is
    + typically a ref, but it can also be a fully spelled hex object
    + name.
    + +
    ++A <refspec> may contain a `*` in its <src> to indicate a simple pattern
    ++match. Such a refspec functions like a glob that matches any ref with the
    ++same prefix. A pattern <refspec> must have a `*` in both the <src> and
    ++<dst>. It will map refs to the destination by replacing the `*` with the
    ++contents matched from the source.
    +++
    ++If a refspec is prefixed by `^`, it will be interpreted as a negative
    ++refspec. Rather than specifying which refs to fetch or which local refs to
    ++update, such a refspec will instead specify refs to exclude. A ref will be
    ++considered to match if it matches at least one positive refspec, and does
    ++not match any negative refspec. Negative refspecs can be useful to restrict
    ++the scope of a pattern refspec so that it will not include specific refs.
    ++Negative refspecs can themselves be pattern refspecs. However, they may only
    ++contain a <src> and do not specify a <dst>. Fully spelled out hex object
    ++names are also not supported.
    +++
    + `tag <tag>` means the same as `refs/tags/<tag>:refs/tags/<tag>`;
    + it requests fetching everything up to the given tag.
    + +
     
      ## builtin/fetch.c ##
     @@ builtin/fetch.c: static struct ref *get_ref_map(struct remote *remote,
    @@ builtin/fetch.c: static struct ref *get_ref_map(struct remote *remote,
     +
      	ref_map = ref_remove_duplicates(ref_map);
      
    - 	refname_hash_init(&existing_refs);
    + 	for (rm = ref_map; rm; rm = rm->next) {
     
      ## refspec.c ##
     @@ refspec.c: static struct refspec_item s_tag_refspec = {
    @@ refspec.c: static int parse_refspec(struct refspec_item *item, const char *refsp
     +		/*
     +		 * Negative refspecs only have a LHS, which indicates a ref
     +		 * (or pattern of refs) to exclude from other matches. This
    -+		 * can either be a simple ref, a glob pattern, or even an
    -+		 * exact sha1 match.
    ++		 * can either be a simple ref, or a glob pattern. Exact sha1
    ++		 * match is not currently supported.
     +		 */
     +		if (!*item->src)
     +			return 0; /* negative refspecs must not be empty */
     +		else if (llen == the_hash_algo->hexsz && !get_oid_hex(item->src, &unused))
    -+			item->exact_sha1 = 1; /* ok */
    ++			return 0; /* negative refpsecs cannot be exact sha1 */
     +		else if (!check_refname_format(item->src, flags))
     +			; /* valid looking ref is ok */
     +		else
     +			return 0;
     +
    -+		/* other rules for negative refspecs don't apply */
    ++		/* the other rules below do not apply to negative refspecs */
     +		return 1;
     +	}
     +
    @@ remote.c: static int match_name_with_pattern(const char *key, const char *name,
     +	return ref_map;
     +}
     +
    - static void query_refspecs_multiple(struct refspec *rs,
    - 				    struct refspec_item *query,
    - 				    struct string_list *results)
    - {
    --	int i;
    ++static int query_matches_negative_refspec(struct refspec *rs, struct refspec_item *query)
    ++{
     +	int i, matched_negative = 0;
    - 	int find_src = !query->src;
    ++	int find_src = !query->src;
     +	struct string_list reversed = STRING_LIST_INIT_NODUP;
     +	const char *needle = find_src ? query->dst : query->src;
    -+	char **result = find_src ? &query->src : &query->dst;
    - 
    - 	if (find_src && !query->dst)
    - 		BUG("query_refspecs_multiple: need either src or dst");
    - 
    ++
     +	/*
    -+	 * If a ref matches any of the negative refspecs, then we should treat
    -+	 * it as not matching this query. Note that negative refspecs apply to
    -+	 * the source but we're checking only the destination. Reverse and
    -+	 * capture any pattern refspecs in order to see if the source would
    -+	 * have matched a negative refspec.
    ++	 * Check whether the queried ref matches any negative refpsec. If so,
    ++	 * then we should ultimately treat this as not matching the query at
    ++	 * all.
    ++	 *
    ++	 * Note that negative refspecs always match the source, but the query
    ++	 * item uses the destination. To handle this, we apply pattern
    ++	 * refspecs in reverse to figure out if the query source matches any
    ++	 * of the negative refspecs.
     +	 */
     +	for (i = 0; i < rs->nr; i++) {
     +		struct refspec_item *refspec = &rs->items[i];
    @@ remote.c: static int match_name_with_pattern(const char *key, const char *name,
     +
     +	string_list_clear(&reversed, 0);
     +
    -+	if (matched_negative)
    ++	return matched_negative;
    ++}
    ++
    + static void query_refspecs_multiple(struct refspec *rs,
    + 				    struct refspec_item *query,
    + 				    struct string_list *results)
    +@@ remote.c: static void query_refspecs_multiple(struct refspec *rs,
    + 	if (find_src && !query->dst)
    + 		BUG("query_refspecs_multiple: need either src or dst");
    + 
    ++	if (query_matches_negative_refspec(rs, query))
     +		return;
     +
      	for (i = 0; i < rs->nr; i++) {
      		struct refspec_item *refspec = &rs->items[i];
      		const char *key = find_src ? refspec->dst : refspec->src;
    - 		const char *value = find_src ? refspec->src : refspec->dst;
    --		const char *needle = find_src ? query->dst : query->src;
    --		char **result = find_src ? &query->src : &query->dst;
    +@@ remote.c: static void query_refspecs_multiple(struct refspec *rs,
    + 		const char *needle = find_src ? query->dst : query->src;
    + 		char **result = find_src ? &query->src : &query->dst;
      
     -		if (!refspec->dst)
     +		if (!refspec->dst || refspec->negative)
      			continue;
      		if (refspec->pattern) {
      			if (match_name_with_pattern(key, needle, value, result))
    -@@ remote.c: static void query_refspecs_multiple(struct refspec *rs,
    - 
    - int query_refspecs(struct refspec *rs, struct refspec_item *query)
    - {
    --	int i;
    -+	int i, matched_negative = 0;
    - 	int find_src = !query->src;
    -+	struct string_list reversed = STRING_LIST_INIT_NODUP;
    - 	const char *needle = find_src ? query->dst : query->src;
    - 	char **result = find_src ? &query->src : &query->dst;
    - 
    +@@ remote.c: int query_refspecs(struct refspec *rs, struct refspec_item *query)
      	if (find_src && !query->dst)
      		BUG("query_refspecs: need either src or dst");
      
    -+	/*
    -+	 * If a ref matches any of the negative refspecs, then we should treat
    -+	 * it as not matching this query. Note that negative refspecs apply to
    -+	 * the source but we're checking only the destination. Reverse and
    -+	 * capture any pattern refspecs in order to see if the source would
    -+	 * have matched a negative refspec.
    -+	 */
    -+	for (i = 0; i < rs->nr; i++) {
    -+		struct refspec_item *refspec = &rs->items[i];
    -+		char *expn_name;
    -+
    -+		if (refspec->negative)
    -+			continue;
    -+
    -+		/* Note the reversal of src and dst */
    -+		if (refspec->pattern) {
    -+			const char *key = refspec->dst ?: refspec->src;
    -+			const char *value = refspec->src;
    -+
    -+			if (match_name_with_pattern(key, needle, value, &expn_name))
    -+				string_list_append_nodup(&reversed, expn_name);
    -+		} else {
    -+			if (!strcmp(needle, refspec->src))
    -+				string_list_append(&reversed, refspec->src);
    -+		}
    -+	}
    -+
    -+	for (i = 0; !matched_negative && i < reversed.nr; i++) {
    -+		if (omit_name_by_refspec(reversed.items[i].string, rs))
    -+			matched_negative = 1;
    -+	}
    -+
    -+	string_list_clear(&reversed, 0);
    -+
    -+	if (matched_negative)
    ++	if (query_matches_negative_refspec(rs, query))
     +		return -1;
     +
      	for (i = 0; i < rs->nr; i++) {
    @@ t/t5582-fetch-negative-refspec.sh (new)
     +	)
     +'
     +
    ++test_expect_success "fetch with negative sha1 refspec fails" '
    ++	echo >file updated by origin yet again &&
    ++	git commit -a -m "updated by origin yet again" &&
    ++	(
    ++		cd three &&
    ++		master_in_one=$(cd ../one && git rev-parse refs/heads/master) &&
    ++		test_must_fail git fetch ../one/.git refs/heads/*:refs/remotes/one/* ^$master_in_one
    ++	)
    ++'
    ++
    ++test_expect_success "fetch with negative pattern refspec" '
    ++	echo >file updated by origin once more &&
    ++	git commit -a -m "updated by origin once more" &&
    ++	(
    ++		cd three &&
    ++		alternate_in_one=$(cd ../one && git rev-parse refs/heads/alternate) &&
    ++		echo $alternate_in_one >expect &&
    ++		git fetch ../one/.git refs/heads/*:refs/remotes/one/* ^refs/heads/m* &&
    ++		cut -f -1 .git/FETCH_HEAD >actual &&
    ++		test_cmp expect actual
    ++	)
    ++'
    ++
    ++test_expect_success "fetch with negative pattern refspec does not expand prefix" '
    ++	echo >file updated by origin another time &&
    ++	git commit -a -m "updated by origin another time" &&
    ++	(
    ++		cd three &&
    ++		alternate_in_one=$(cd ../one && git rev-parse refs/heads/alternate) &&
    ++		master_in_one=$(cd ../one && git rev-parse refs/heads/master) &&
    ++		echo $alternate_in_one >expect &&
    ++		echo $master_in_one >>expect &&
    ++		git fetch ../one/.git refs/heads/*:refs/remotes/one/* ^master &&
    ++		cut -f -1 .git/FETCH_HEAD >actual &&
    ++		test_cmp expect actual
    ++	)
    ++'
    ++
     +test_expect_success "fetch with negative refspec avoids duplicate conflict" '
     +	cd "$D" &&
     +	(
2:  ef767ce8f8ed < -:  ------------ SQUASH???

Jacob Keller (1):
  refspec: add support for negative refspecs

 Documentation/pull-fetch-param.txt |  16 +++
 builtin/fetch.c                    |  10 ++
 refspec.c                          |  34 +++++-
 refspec.h                          |  14 ++-
 remote.c                           | 108 ++++++++++++++++-
 remote.h                           |   9 +-
 t/t5582-fetch-negative-refspec.sh  | 189 +++++++++++++++++++++++++++++
 7 files changed, 367 insertions(+), 13 deletions(-)
 create mode 100755 t/t5582-fetch-negative-refspec.sh


base-commit: e1cfff676549cdcd702cbac105468723ef2722f4
-- 
2.28.0.497.g54e85e7af1ac

