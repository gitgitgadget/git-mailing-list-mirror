Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94C27EB64DA
	for <git@archiver.kernel.org>; Fri,  7 Jul 2023 22:21:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbjGGWV1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Jul 2023 18:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjGGWVZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jul 2023 18:21:25 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B862C1BE1
        for <git@vger.kernel.org>; Fri,  7 Jul 2023 15:21:24 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7554629FDD;
        Fri,  7 Jul 2023 18:21:24 -0400 (EDT)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=G4ZVWTDk+DJMa82oNJGxlhz3X
        gF/T4O/H9yOVIAubKw=; b=hYBeImvFvkjGkN2VnjHisaRExJ7WxCRATByyIWAkG
        FytoqUGekX7ywagveT7g5LiohF+CqWQY9pBR/S+zjoUwaVpojC6IHUezUaizUh14
        cDpp/v2dFk5pV/bWLFLrvW9P56brB6q7M6rC9t/orpf5QETCDS5cmHb5cYqMP+z7
        mc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6EE2229FDC;
        Fri,  7 Jul 2023 18:21:24 -0400 (EDT)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.127.75.226])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0C89029FD7;
        Fri,  7 Jul 2023 18:21:21 -0400 (EDT)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH 1/2] tree-walk: lose base_offset that is never used in tree_entry_interesting
Date:   Fri,  7 Jul 2023 15:21:15 -0700
Message-ID: <20230707222116.4129415-2-gitster@pobox.com>
X-Mailer: git-send-email 2.41.0-318-g061c58647e
In-Reply-To: <20230707222116.4129415-1-gitster@pobox.com>
References: <20230707222116.4129415-1-gitster@pobox.com>
MIME-Version: 1.0
X-Pobox-Relay-ID: 99B8B6DA-1D14-11EE-B74D-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The tree_entry_interesting() function takes base_offset, allowing
its callers to potentially pass a non-zero number to skip the early
part of the path string.

The feature is never exercised and we do not even know what bugs are
lurking there, as all callers pass 0 to the parameter.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/grep.c | 2 +-
 list-objects.c | 2 +-
 tree-diff.c    | 2 +-
 tree-walk.c    | 5 +++--
 tree-walk.h    | 2 +-
 tree.c         | 2 +-
 6 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 22645c6244..5f47317c2f 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -644,7 +644,7 @@ static int grep_tree(struct grep_opt *opt, const stru=
ct pathspec *pathspec,
 			strbuf_addstr(&name, base->buf + tn_len);
 			match =3D tree_entry_interesting(repo->index,
 						       &entry, &name,
-						       0, pathspec);
+						       pathspec);
 			strbuf_setlen(&name, name_base_len);
=20
 			if (match =3D=3D all_entries_not_interesting)
diff --git a/list-objects.c b/list-objects.c
index 672a4cd529..e60a6cd5b4 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -102,7 +102,7 @@ static void process_tree_contents(struct traversal_co=
ntext *ctx,
 	while (tree_entry(&desc, &entry)) {
 		if (match !=3D all_entries_interesting) {
 			match =3D tree_entry_interesting(ctx->revs->repo->index,
-						       &entry, base, 0,
+						       &entry, base,
 						       &ctx->revs->diffopt.pathspec);
 			if (match =3D=3D all_entries_not_interesting)
 				break;
diff --git a/tree-diff.c b/tree-diff.c
index 966946848a..8fc159b86e 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -317,7 +317,7 @@ static void skip_uninteresting(struct tree_desc *t, s=
truct strbuf *base,
=20
 	while (t->size) {
 		match =3D tree_entry_interesting(opt->repo->index, &t->entry,
-					       base, 0, &opt->pathspec);
+					       base, &opt->pathspec);
 		if (match) {
 			if (match =3D=3D all_entries_not_interesting)
 				t->size =3D 0;
diff --git a/tree-walk.c b/tree-walk.c
index 42ed86ef58..1797f2b9c5 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -435,7 +435,7 @@ static inline int prune_traversal(struct index_state =
*istate,
 	if (still_interesting < 0)
 		return still_interesting;
 	return tree_entry_interesting(istate, e, base,
-				      0, info->pathspec);
+				      info->pathspec);
 }
=20
 int traverse_trees(struct index_state *istate,
@@ -1223,10 +1223,11 @@ static enum interesting do_match(struct index_sta=
te *istate,
  */
 enum interesting tree_entry_interesting(struct index_state *istate,
 					const struct name_entry *entry,
-					struct strbuf *base, int base_offset,
+					struct strbuf *base,
 					const struct pathspec *ps)
 {
 	enum interesting positive, negative;
+	const int base_offset =3D 0;
 	positive =3D do_match(istate, entry, base, base_offset, ps, 0);
=20
 	/*
diff --git a/tree-walk.h b/tree-walk.h
index 01a9d8eb44..74cdceb3fe 100644
--- a/tree-walk.h
+++ b/tree-walk.h
@@ -224,7 +224,7 @@ enum interesting {
=20
 enum interesting tree_entry_interesting(struct index_state *istate,
 					const struct name_entry *,
-					struct strbuf *, int,
+					struct strbuf *,
 					const struct pathspec *ps);
=20
 #endif
diff --git a/tree.c b/tree.c
index e118914a76..c745462f96 100644
--- a/tree.c
+++ b/tree.c
@@ -32,7 +32,7 @@ int read_tree_at(struct repository *r,
 	while (tree_entry(&desc, &entry)) {
 		if (retval !=3D all_entries_interesting) {
 			retval =3D tree_entry_interesting(r->index, &entry,
-							base, 0, pathspec);
+							base, pathspec);
 			if (retval =3D=3D all_entries_not_interesting)
 				break;
 			if (retval =3D=3D entry_not_interesting)
--=20
2.41.0-318-g061c58647e

