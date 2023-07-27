Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 740D2C04A94
	for <git@archiver.kernel.org>; Thu, 27 Jul 2023 19:24:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231748AbjG0TYG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Jul 2023 15:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbjG0TYF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jul 2023 15:24:05 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 265FFE2
        for <git@vger.kernel.org>; Thu, 27 Jul 2023 12:24:04 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 568251A486E;
        Thu, 27 Jul 2023 15:24:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=K
        /5dUD0zAUZOuuMCCCaYalnMHrkLbVUXJ1QiRpfd9Dw=; b=Z/lD3AaU7ekoIC5/a
        r2DyiJYX9A+2UyRSJp+nsn2GVgsJZlI2sTznItv+FgvTJyCqXK/iOs3Qp9ONp/AA
        7OttLCGs+U4BPV+nrKrzoiKLOhv36KAcyI/3d6Bqm1lh7NykNQHDS0/wOtShjtzi
        U4Briu0o/HXisUfgfR+FIPLG4M=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4A4A31A486B;
        Thu, 27 Jul 2023 15:24:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 93C781A4866;
        Thu, 27 Jul 2023 15:24:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH] update-index: do not read HEAD and MERGE_HEAD unconditionally
Date:   Thu, 27 Jul 2023 12:24:01 -0700
Message-ID: <xmqqila5b1ke.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 24F9883E-2CB3-11EE-A035-C65BE52EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When "update-index --unresolve $path" cannot find the resolve-undo
record for the path the user requested to unresolve, it stuffs the
blobs from HEAD and MERGE_HEAD to stage #2 and stage #3 as a
fallback.  For this reason, the operation does not even start unless
both "HEAD" and "MERGE_HEAD" exist.

This is suboptimal in a few ways:

 * It does not recreate stage #1.  Even though it is a correct
   design decision not to do so (because it is impossible to
   recreate in general cases, without knowing how we got there,
   including what merge strategy was used), it is much less useful
   not to have that information in the index.

 * It limits the "unresolve" operation only during a conflicted "git
   merge" and nothing else.  Other operations like "rebase",
   "cherry-pick", and "switch -m" may result in conflicts, and the
   user may want to unresolve the conflict that they incorrectly
   resolved in order to redo the resolution, but the fallback would
   not kick in.

 * Most importantly, the entire "unresolve" operation is disabled
   after a conflicted merge is committed and MERGE_HEAD is removed,
   even though the index has perfectly usable resolve-undo records.

By lazily reading the HEAD and MERGE_HEAD only when we need to go to
the fallback codepath, we will allow cases where resolve-undo
records are available (which is 100% of the time, unless the user is
reading from an index file created by Git more than 10 years ago) to
proceed even after a conflicted merge was committed, during other
mergy operations that do not use MERGE_HEAD, or after the result of
such mergy operations has been committed.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 * Once the codepath starts using resolve-undo data for recovering
   from "resolved to removal", I think we can fully remove this
   fallback codepath.  But we'd need to first move away from the
   unmerge_index_entry_at() that assumes that the path to be
   unresolved must be in the index.  That should happen in future
   patches.

 builtin/update-index.c    | 46 ++++++++++++++++++++++++---------------
 t/t2030-unresolve-info.sh |  8 +++++++
 2 files changed, 36 insertions(+), 18 deletions(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index aee3cb8cbd..853ec9eb7a 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -640,6 +640,21 @@ static struct cache_entry *read_one_ent(const char *which,
 	return ce;
 }
 
+static int read_head_pointers(void)
+{
+	static int result = -2; /* unknown yet */
+
+	if (result == -2) {
+		result = -1;
+		if (read_ref("HEAD", &head_oid))
+			return error("No HEAD -- no initial comit yet?");
+		if (read_ref("MERGE_HEAD", &merge_head_oid))
+			return error("Not in the middle of a merge");
+		result = 0;
+	}
+	return result;
+}
+
 static int unresolve_one(const char *path)
 {
 	int namelen = strlen(path);
@@ -678,10 +693,20 @@ static int unresolve_one(const char *path)
 		}
 	}
 
-	/* Grab blobs from given path from HEAD and MERGE_HEAD,
-	 * stuff HEAD version in stage #2,
-	 * stuff MERGE_HEAD version in stage #3.
+	/*
+	 * We are not using resolve-undo information but just
+	 * populating the stages #2 and #3 from HEAD and MERGE_HEAD.
+	 *
+	 * This is a flawed replacement of true "unresolve", as we do
+	 * not have a way to recreate the stage #1 for the common
+	 * ancestor (which may not be a unique merge-base between the
+	 * two).
 	 */
+	if (read_head_pointers()) {
+		ret = -1;
+		goto free_return;
+	}
+
 	ce_2 = read_one_ent("our", &head_oid, path, namelen, 2);
 	ce_3 = read_one_ent("their", &merge_head_oid, path, namelen, 3);
 
@@ -712,27 +737,12 @@ static int unresolve_one(const char *path)
 	return ret;
 }
 
-static void read_head_pointers(void)
-{
-	if (read_ref("HEAD", &head_oid))
-		die("No HEAD -- no initial commit yet?");
-	if (read_ref("MERGE_HEAD", &merge_head_oid)) {
-		fprintf(stderr, "Not in the middle of a merge.\n");
-		exit(0);
-	}
-}
-
 static int do_unresolve(int ac, const char **av,
 			const char *prefix, int prefix_length)
 {
 	int i;
 	int err = 0;
 
-	/* Read HEAD and MERGE_HEAD; if MERGE_HEAD does not exist, we
-	 * are not doing a merge, so exit with success status.
-	 */
-	read_head_pointers();
-
 	for (i = 1; i < ac; i++) {
 		const char *arg = av[i];
 		char *p = prefix_path(prefix, prefix_length, arg);
diff --git a/t/t2030-unresolve-info.sh b/t/t2030-unresolve-info.sh
index 2d8c70b03a..d4e7760df5 100755
--- a/t/t2030-unresolve-info.sh
+++ b/t/t2030-unresolve-info.sh
@@ -126,6 +126,14 @@ test_expect_success 'unmerge with plumbing' '
 	test_line_count = 3 actual
 '
 
+test_expect_success 'unmerge can be done even after committing' '
+	prime_resolve_undo &&
+	git commit -m "record to nuke MERGE_HEAD" &&
+	git update-index --unresolve fi/le &&
+	git ls-files -u >actual &&
+	test_line_count = 3 actual
+'
+
 test_expect_success 'rerere and rerere forget' '
 	mkdir .git/rr-cache &&
 	prime_resolve_undo &&
-- 
2.41.0-459-gb4fce4b6e4

