Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2529AC001DE
	for <git@archiver.kernel.org>; Fri, 28 Jul 2023 19:49:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233897AbjG1Tt1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Jul 2023 15:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjG1Tt0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jul 2023 15:49:26 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F94D3C07
        for <git@vger.kernel.org>; Fri, 28 Jul 2023 12:49:25 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 620421A87A6;
        Fri, 28 Jul 2023 15:49:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=DsEy1vsUG9H+2/ys9XbVeHINDxmmQuFe+AqEPe
        /KW84=; b=g0M81vcpCwSOS7/4WUC4cloM7QHh1eYqwnPtXsyV+6Y7yGjMk4HMtv
        B8oPygXYrRwGok3JvNcj6Hg6uJjCLDcZelnFWxYC4r3/8RW5gPJXLvzUHb+z3G0D
        4Sa+5LA3Vo6ZmdLeiCgLj5nNLQGJ4z2rvLcIhJrnZIisxqjIkZHbo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 59A381A87A5;
        Fri, 28 Jul 2023 15:49:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A93001A87A4;
        Fri, 28 Jul 2023 15:49:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH 3/2] update-index: remove stale fallback code for "--unresolve"
References: <xmqq3519auz5.fsf@gitster.g> <xmqqtttp9g6r.fsf@gitster.g>
Date:   Fri, 28 Jul 2023 12:49:22 -0700
In-Reply-To: <xmqqtttp9g6r.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
        27 Jul 2023 14:51:08 -0700")
Message-ID: <xmqqo7jv4y0t.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DA077A34-2D7F-11EE-8F2C-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The "update-index --unresolve" is a relatively old feature that was
introduced in Git v1.4.1 (June 2006), which predates the
resolve-undo extension introduced in Git v1.7.0 (February 2010).
The original code that was limited only to work during a merge (and
not during a rebase or a cherry-pick) has been kept as the fallback
codepath to be used as a transition measure.

By now, for more than 10 years we have stored resolve-undo extension
in the index file, and the fallback code way outlived its usefulness.

Remove it, together with two file-scope static global variables.
One of these variables is still used by surviving function, but it
does not have to be a global at all, so move it to local to that
function.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/update-index.c | 103 ++++-------------------------------------
 1 file changed, 8 insertions(+), 95 deletions(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index d02ac55313..79c25a2a58 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -609,9 +609,6 @@ static const char * const update_index_usage[] = {
 	NULL
 };
 
-static struct object_id head_oid;
-static struct object_id merge_head_oid;
-
 static struct cache_entry *read_one_ent(const char *which,
 					struct object_id *ent, const char *path,
 					int namelen, int stage)
@@ -640,102 +637,17 @@ static struct cache_entry *read_one_ent(const char *which,
 	return ce;
 }
 
-static int read_head_pointers(void)
-{
-	static int result = -2; /* unknown yet */
-
-	if (result == -2) {
-		result = -1;
-		if (read_ref("HEAD", &head_oid))
-			return error("No HEAD -- no initial comit yet?");
-		if (read_ref("MERGE_HEAD", &merge_head_oid))
-			return error("Not in the middle of a merge");
-		result = 0;
-	}
-	return result;
-}
-
 static int unresolve_one(const char *path)
 {
-	int namelen = strlen(path);
-	int pos;
-	int ret = 0;
-	struct cache_entry *ce_2 = NULL, *ce_3 = NULL;
-	struct resolve_undo_info *ru = NULL;
-
-	if (the_index.resolve_undo) {
-		struct string_list_item *item;
-		item = string_list_lookup(the_index.resolve_undo, path);
-		if (item)
-			ru = item->util;
-	}
-
-	/* resolve-undo record exists for the path */
-	if (ru)
-		return unmerge_index_entry(&the_index, path, ru);
+	struct string_list_item *item;
 
-	/* See if there is such entry in the index. */
-	pos = index_name_pos(&the_index, path, namelen);
-	if (0 <= pos) {
-		; /* resolve-undo record was used already -- fall back */
-	} else {
-		/* Is it unmerged? */
-		pos = -pos - 1;
-		if (pos < the_index.cache_nr) {
-			const struct cache_entry *ce = the_index.cache[pos];
-			if (ce_namelen(ce) == namelen &&
-			    !memcmp(ce->name, path, namelen)) {
-				fprintf(stderr,
-					"%s: skipping still unmerged path.\n",
-					path);
-			}
-			goto free_return;
-		}
-		/* No, such a path does not exist -- removed */
-	}
-
-	/*
-	 * We are not using resolve-undo information but just
-	 * populating the stages #2 and #3 from HEAD and MERGE_HEAD.
-	 *
-	 * This is a flawed replacement of true "unresolve", as we do
-	 * not have a way to recreate the stage #1 for the common
-	 * ancestor (which may not be a unique merge-base between the
-	 * two).
-	 */
-	if (read_head_pointers()) {
-		ret = -1;
-		goto free_return;
-	}
-
-	ce_2 = read_one_ent("our", &head_oid, path, namelen, 2);
-	ce_3 = read_one_ent("their", &merge_head_oid, path, namelen, 3);
-
-	if (!ce_2 || !ce_3) {
-		ret = -1;
-		goto free_return;
-	}
-	if (oideq(&ce_2->oid, &ce_3->oid) &&
-	    ce_2->ce_mode == ce_3->ce_mode) {
-		fprintf(stderr, "%s: identical in both, skipping.\n",
-			path);
-		goto free_return;
-	}
-
-	remove_file_from_index(&the_index, path);
-	if (add_index_entry(&the_index, ce_2, ADD_CACHE_OK_TO_ADD)) {
-		error("%s: cannot add our version to the index.", path);
-		ret = -1;
-		goto free_return;
-	}
-	if (!add_index_entry(&the_index, ce_3, ADD_CACHE_OK_TO_ADD))
+	if (!the_index.resolve_undo)
 		return 0;
-	error("%s: cannot add their version to the index.", path);
-	ret = -1;
- free_return:
-	discard_cache_entry(ce_2);
-	discard_cache_entry(ce_3);
-	return ret;
+	item = string_list_lookup(the_index.resolve_undo, path);
+	if (!item)
+		return 0; /* no resolve-undo record for the path */
+
+	return unmerge_index_entry(&the_index, path, item->util);
 }
 
 static int do_unresolve(int ac, const char **av,
@@ -762,6 +674,7 @@ static int do_reupdate(const char **paths,
 	int pos;
 	int has_head = 1;
 	struct pathspec pathspec;
+	struct object_id head_oid;
 
 	parse_pathspec(&pathspec, 0,
 		       PATHSPEC_PREFER_CWD,
-- 
2.41.0-478-gee48e70a82

