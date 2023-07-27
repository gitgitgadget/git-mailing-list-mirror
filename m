Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA94DEB64DD
	for <git@archiver.kernel.org>; Thu, 27 Jul 2023 21:46:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231347AbjG0Vq3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Jul 2023 17:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbjG0Vq2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jul 2023 17:46:28 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A76B52135
        for <git@vger.kernel.org>; Thu, 27 Jul 2023 14:46:27 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 204AE22DEC;
        Thu, 27 Jul 2023 17:46:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=D
        9KACuvo9SrMqm1diBjgSZ+nQvcirkqZLiLPSbLCBiY=; b=kQ0M87EIxDE21yP+Z
        236F+3bLck11Pmz5/qPyhtMf1AsiSkPBz+mff5ug6TsIrXXBd9Z/O8VNRZiIWeCd
        CT7I1xH9IAvcfbKXNd73Gyanv4wRUwP/EnpxMay/x+Aa9g5ZJ8vwXp8dnxSW2FCt
        iphV1dhKAOpdHrCEoOAeENWEmw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0B62322DEB;
        Thu, 27 Jul 2023 17:46:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 7E13022DE9;
        Thu, 27 Jul 2023 17:46:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH 1/2] resolve-undo: allow resurrecting conflicted state that
 resolved to deletion
Date:   Thu, 27 Jul 2023 14:46:22 -0700
Message-ID: <xmqq3519auz5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 07C1CAC4-2CC7-11EE-A3A4-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The resolve-undo index extension records up to three (mode, object
name) tuples for non-zero stages for each path that was resolved,
to be used to recreate the original conflicted state later when the
user requests.

The unmerge_index_entry_at() function uses the resolve-undo data to
do so, but it assumes that the path for which the conflicted state
needs to be recreated can be specified by the position in the
active_cache[] array.  This obviously cannot salvage a conflicted
state that was resolved by removing them.  A delete-modify conflict,
in which the change whose "modify" side made is a trivial typofix,
may legitimately be resolved to remove the path, and resolve-undo
extension does record the two (mode, object name) tuples for the
common ancestor version and their version, lacking our version.

Introduce a new unmerge_index_entry() helper function that takes the
path (which does not necessarily have to exist in the active_cache[]
array) and resolve-undo data, and use it to reimplement unmerge_index()
public function that is used by "git rerere".

The limited interface is still kept for now, as it is used by "git
checkout -m" and "git update-index --unmerge", but these two codepaths
will be updated to lift the assumption to allow conflicts that resolved
to deletion can be recreated.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * No new tests, as unmerge_index() that is used by "git rerere"
   already exercises the codepath.  We'll use the new function also
   in "update-index" in a future patch.

 resolve-undo.c | 46 +++++++++++++++++++++++++++++++++++++++++-----
 resolve-undo.h |  1 +
 2 files changed, 42 insertions(+), 5 deletions(-)

diff --git a/resolve-undo.c b/resolve-undo.c
index 7817f5d6db..9ceab129ac 100644
--- a/resolve-undo.c
+++ b/resolve-undo.c
@@ -184,19 +184,55 @@ void unmerge_marked_index(struct index_state *istate)
 	}
 }
 
+int unmerge_index_entry(struct index_state *istate, const char *path,
+			struct resolve_undo_info *ru)
+{
+	int i = index_name_pos(istate, path, strlen(path));
+
+	if (i < 0) {
+		/* unmerged? */
+		i = -i - 1;
+		if (i < istate->cache_nr &&
+		    !strcmp(istate->cache[i]->name, path))
+			/* yes, it is already unmerged */
+			return 0;
+		/* fallthru: resolved to removal */
+	} else {
+		/* merged - remove it to replace it with unmerged entries */
+		remove_index_entry_at(istate, i);
+	}
+
+	for (i = 0; i < 3; i++) {
+		struct cache_entry *ce;
+		if (!ru->mode[i])
+			continue;
+		ce = make_cache_entry(istate, ru->mode[i], &ru->oid[i],
+				      path, i + 1, 0);
+		if (add_index_entry(istate, ce, ADD_CACHE_OK_TO_ADD))
+			return error("cannot unmerge '%s'", path);
+	}
+	return 0;
+}
+
 void unmerge_index(struct index_state *istate, const struct pathspec *pathspec)
 {
-	int i;
+	struct string_list_item *item;
 
 	if (!istate->resolve_undo)
 		return;
 
 	/* TODO: audit for interaction with sparse-index. */
 	ensure_full_index(istate);
-	for (i = 0; i < istate->cache_nr; i++) {
-		const struct cache_entry *ce = istate->cache[i];
-		if (!ce_path_match(istate, ce, pathspec, NULL))
+
+	for_each_string_list_item(item, istate->resolve_undo) {
+		const char *path = item->string;
+		struct resolve_undo_info *ru = item->util;
+		if (!item->util)
+			continue;
+		if (!match_pathspec(istate, pathspec,
+				    item->string, strlen(item->string),
+				    0, NULL, 0))
 			continue;
-		i = unmerge_index_entry_at(istate, i);
+		unmerge_index_entry(istate, path, ru);
 	}
 }
diff --git a/resolve-undo.h b/resolve-undo.h
index c5deafc92f..1ae321c88b 100644
--- a/resolve-undo.h
+++ b/resolve-undo.h
@@ -18,6 +18,7 @@ void resolve_undo_write(struct strbuf *, struct string_list *);
 struct string_list *resolve_undo_read(const char *, unsigned long);
 void resolve_undo_clear_index(struct index_state *);
 int unmerge_index_entry_at(struct index_state *, int);
+int unmerge_index_entry(struct index_state *, const char *, struct resolve_undo_info *);
 void unmerge_index(struct index_state *, const struct pathspec *);
 void unmerge_marked_index(struct index_state *);
 
-- 
2.41.0-459-gb4fce4b6e4

