Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97FB1C001DE
	for <git@archiver.kernel.org>; Mon, 31 Jul 2023 22:45:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231401AbjGaWpH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Jul 2023 18:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjGaWpE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jul 2023 18:45:04 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 054741BE6
        for <git@vger.kernel.org>; Mon, 31 Jul 2023 15:44:43 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id ECC283221C;
        Mon, 31 Jul 2023 18:44:16 -0400 (EDT)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=E3oAXECXVXvohWtNzkBkuZ9oh
        xJ12ecY8zGQuL+3wTQ=; b=BUSRPp0Mf31P6rta9pt13ZdMRXHx513trbTvVJe3t
        2Ld+dypPbPVvzPIbR1DwZG9Vn25Gdd2k5FXDxU//LYWHYC66LK78IRyZjpZmu+XT
        P9aTegBJRnVJzFpexhuQXCtvPIH6lIVj1nl8/mSF7ITI9GtKUITpArZftfrXejwH
        7c=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DEA723221B;
        Mon, 31 Jul 2023 18:44:16 -0400 (EDT)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 851293221A;
        Mon, 31 Jul 2023 18:44:13 -0400 (EDT)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH 2/7] resolve-undo: allow resurrecting conflicted state that resolved to deletion
Date:   Mon, 31 Jul 2023 15:44:04 -0700
Message-ID: <20230731224409.4181277-3-gitster@pobox.com>
X-Mailer: git-send-email 2.41.0-478-gee48e70a82
In-Reply-To: <20230731224409.4181277-1-gitster@pobox.com>
References: <20230731224409.4181277-1-gitster@pobox.com>
MIME-Version: 1.0
X-Pobox-Relay-ID: C5B4FCD4-2FF3-11EE-AAC9-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
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
active_cache[] array.  This obviously cannot salvage the state of
conflicted paths that were resolved by removing them.  For example,
a delete-modify conflict, in which the change whose "modify" side
made is a trivial typofix, may legitimately be resolved to remove
the path, and resolve-undo extension does record the two (mode,
object name) tuples for the common ancestor version and their
version, lacking our version.  But after recording such a removal of
the path, you should be able to use resolve-undo data to recreate
the conflicted state.

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
 resolve-undo.c | 48 +++++++++++++++++++++++++++++++++++++++++++-----
 resolve-undo.h |  1 +
 2 files changed, 44 insertions(+), 5 deletions(-)

diff --git a/resolve-undo.c b/resolve-undo.c
index 70a6db526d..3b0244e210 100644
--- a/resolve-undo.c
+++ b/resolve-undo.c
@@ -182,19 +182,57 @@ void unmerge_marked_index(struct index_state *istat=
e)
 	}
 }
=20
+int unmerge_index_entry(struct index_state *istate, const char *path,
+			struct resolve_undo_info *ru)
+{
+	int i =3D index_name_pos(istate, path, strlen(path));
+
+	if (i < 0) {
+		/* unmerged? */
+		i =3D -i - 1;
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
+	for (i =3D 0; i < 3; i++) {
+		struct cache_entry *ce;
+		if (!ru->mode[i])
+			continue;
+		ce =3D make_cache_entry(istate, ru->mode[i], &ru->oid[i],
+				      path, i + 1, 0);
+		if (add_index_entry(istate, ce, ADD_CACHE_OK_TO_ADD))
+			return error("cannot unmerge '%s'", path);
+	}
+	return 0;
+}
+
 void unmerge_index(struct index_state *istate, const struct pathspec *pa=
thspec)
 {
-	int i;
+	struct string_list_item *item;
=20
 	if (!istate->resolve_undo)
 		return;
=20
 	/* TODO: audit for interaction with sparse-index. */
 	ensure_full_index(istate);
-	for (i =3D 0; i < istate->cache_nr; i++) {
-		const struct cache_entry *ce =3D istate->cache[i];
-		if (!ce_path_match(istate, ce, pathspec, NULL))
+
+	for_each_string_list_item(item, istate->resolve_undo) {
+		const char *path =3D item->string;
+		struct resolve_undo_info *ru =3D item->util;
+		if (!item->util)
+			continue;
+		if (!match_pathspec(istate, pathspec,
+				    item->string, strlen(item->string),
+				    0, NULL, 0))
 			continue;
-		i =3D unmerge_index_entry_at(istate, i);
+		unmerge_index_entry(istate, path, ru);
+		free(ru);
+		item->util =3D NULL;
 	}
 }
diff --git a/resolve-undo.h b/resolve-undo.h
index c5deafc92f..1ae321c88b 100644
--- a/resolve-undo.h
+++ b/resolve-undo.h
@@ -18,6 +18,7 @@ void resolve_undo_write(struct strbuf *, struct string_=
list *);
 struct string_list *resolve_undo_read(const char *, unsigned long);
 void resolve_undo_clear_index(struct index_state *);
 int unmerge_index_entry_at(struct index_state *, int);
+int unmerge_index_entry(struct index_state *, const char *, struct resol=
ve_undo_info *);
 void unmerge_index(struct index_state *, const struct pathspec *);
 void unmerge_marked_index(struct index_state *);
=20
--=20
2.41.0-478-gee48e70a82

