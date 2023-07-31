Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CB32C001E0
	for <git@archiver.kernel.org>; Mon, 31 Jul 2023 22:45:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231621AbjGaWpK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Jul 2023 18:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjGaWpE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jul 2023 18:45:04 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C335210D
        for <git@vger.kernel.org>; Mon, 31 Jul 2023 15:44:43 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C0E9D1C584;
        Mon, 31 Jul 2023 18:44:22 -0400 (EDT)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=QcORpVvEKRpy6Cov0NGCD/tr6
        NmoUrfPoI7sEC9L7zM=; b=NKgicAsl5x+Pa8N+Xaq+C2PPaENFpZ2PGZVHjfFLn
        GUhjYYMKAnYVeVd5/w1jAvwu1zZ+0ZgyO1RQkIPGZoTPJs3+WRlzhPtBIyAYG3Kb
        0RL5SzuBNB2BpgfhRs8Dgr6IN/CymaYzuHSm9M/K24CbK6nC4Y1AZcdS0kRf/1V/
        Pk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B97E31C583;
        Mon, 31 Jul 2023 18:44:22 -0400 (EDT)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 5D14A1C581;
        Mon, 31 Jul 2023 18:44:19 -0400 (EDT)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH 4/7] update-index: remove stale fallback code for "--unresolve"
Date:   Mon, 31 Jul 2023 15:44:06 -0700
Message-ID: <20230731224409.4181277-5-gitster@pobox.com>
X-Mailer: git-send-email 2.41.0-478-gee48e70a82
In-Reply-To: <20230731224409.4181277-1-gitster@pobox.com>
References: <20230731224409.4181277-1-gitster@pobox.com>
MIME-Version: 1.0
X-Pobox-Relay-ID: C92FC97A-2FF3-11EE-B479-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
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
 builtin/update-index.c | 114 +++++------------------------------------
 1 file changed, 12 insertions(+), 102 deletions(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index ecd1c0c2d3..def7f98504 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -608,9 +608,6 @@ static const char * const update_index_usage[] =3D {
 	NULL
 };
=20
-static struct object_id head_oid;
-static struct object_id merge_head_oid;
-
 static struct cache_entry *read_one_ent(const char *which,
 					struct object_id *ent, const char *path,
 					int namelen, int stage)
@@ -639,107 +636,19 @@ static struct cache_entry *read_one_ent(const char=
 *which,
 	return ce;
 }
=20
-static int read_head_pointers(void)
-{
-	static int result =3D -2; /* unknown yet */
-
-	if (result =3D=3D -2) {
-		result =3D -1;
-		if (read_ref("HEAD", &head_oid))
-			return error("No HEAD -- no initial commit yet?");
-		if (read_ref("MERGE_HEAD", &merge_head_oid))
-			return error("Not in the middle of a merge");
-		result =3D 0;
-	}
-	return result;
-}
-
 static int unresolve_one(const char *path)
 {
-	int namelen =3D strlen(path);
-	int pos;
-	int ret =3D 0;
-	struct cache_entry *ce_2 =3D NULL, *ce_3 =3D NULL;
-	struct resolve_undo_info *ru =3D NULL;
-
-	if (the_index.resolve_undo) {
-		struct string_list_item *item;
-		item =3D string_list_lookup(the_index.resolve_undo, path);
-		if (item) {
-			ru =3D item->util;
-			item->util =3D NULL;
-		}
-	}
-
-	/* resolve-undo record exists for the path */
-	if (ru) {
-		ret =3D unmerge_index_entry(&the_index, path, ru);
-		free(ru);
-		return ret;
-	}
-
-	/* See if there is such entry in the index. */
-	pos =3D index_name_pos(&the_index, path, namelen);
-	if (0 <=3D pos) {
-		; /* resolve-undo record was used already -- fall back */
-	} else {
-		/* Is it unmerged? */
-		pos =3D -pos - 1;
-		if (pos < the_index.cache_nr) {
-			const struct cache_entry *ce =3D the_index.cache[pos];
-			if (ce_namelen(ce) =3D=3D namelen &&
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
-		ret =3D -1;
-		goto free_return;
-	}
-
-	ce_2 =3D read_one_ent("our", &head_oid, path, namelen, 2);
-	ce_3 =3D read_one_ent("their", &merge_head_oid, path, namelen, 3);
-
-	if (!ce_2 || !ce_3) {
-		ret =3D -1;
-		goto free_return;
-	}
-	if (oideq(&ce_2->oid, &ce_3->oid) &&
-	    ce_2->ce_mode =3D=3D ce_3->ce_mode) {
-		fprintf(stderr, "%s: identical in both, skipping.\n",
-			path);
-		goto free_return;
-	}
-
-	remove_file_from_index(&the_index, path);
-	if (add_index_entry(&the_index, ce_2, ADD_CACHE_OK_TO_ADD)) {
-		error("%s: cannot add our version to the index.", path);
-		ret =3D -1;
-		goto free_return;
-	}
-	if (!add_index_entry(&the_index, ce_3, ADD_CACHE_OK_TO_ADD))
-		return 0;
-	error("%s: cannot add their version to the index.", path);
-	ret =3D -1;
- free_return:
-	discard_cache_entry(ce_2);
-	discard_cache_entry(ce_3);
-	return ret;
+	struct string_list_item *item;
+	int res =3D 0;
+
+	if (!the_index.resolve_undo)
+		return res;
+	item =3D string_list_lookup(the_index.resolve_undo, path);
+	if (!item)
+		return res; /* no resolve-undo record for the path */
+	res =3D unmerge_index_entry(&the_index, path, item->util);
+	FREE_AND_NULL(item->util);
+	return res;
 }
=20
 static int do_unresolve(int ac, const char **av,
@@ -766,6 +675,7 @@ static int do_reupdate(const char **paths,
 	int pos;
 	int has_head =3D 1;
 	struct pathspec pathspec;
+	struct object_id head_oid;
=20
 	parse_pathspec(&pathspec, 0,
 		       PATHSPEC_PREFER_CWD,
--=20
2.41.0-478-gee48e70a82

