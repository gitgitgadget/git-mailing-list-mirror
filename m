Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEE0AEB64D9
	for <git@archiver.kernel.org>; Fri,  7 Jul 2023 22:21:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbjGGWV3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Jul 2023 18:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjGGWV0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jul 2023 18:21:26 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D8462108
        for <git@vger.kernel.org>; Fri,  7 Jul 2023 15:21:25 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DA48F19942F;
        Fri,  7 Jul 2023 18:21:24 -0400 (EDT)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=MjQ02guHtDsLCUcBywsNyP19l
        NVXhpSaTI6kGgfN1uA=; b=Jr36zEmlvuEgt3gXFDML0AX+w/sSBlNKRRqnRs/Jl
        Fbov2FUQOa2W3OngjWT17ibbDAsHDKPakiQ0U+/LdgXfnUm/g8Q+5nyhozZdA6sX
        RgCYqDB4E7SufyfKPJbbjMDRw5Xqy5PDbnTMk3l6hJ+E0fkpKe/afHEgp+5Pd7fY
        Kw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D16E319942E;
        Fri,  7 Jul 2023 18:21:24 -0400 (EDT)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.127.75.226])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3F06719942D;
        Fri,  7 Jul 2023 18:21:24 -0400 (EDT)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH 2/2] tree-walk: drop unused base_offset from do_match()
Date:   Fri,  7 Jul 2023 15:21:16 -0700
Message-ID: <20230707222116.4129415-3-gitster@pobox.com>
X-Mailer: git-send-email 2.41.0-318-g061c58647e
In-Reply-To: <20230707222116.4129415-1-gitster@pobox.com>
References: <20230707222116.4129415-1-gitster@pobox.com>
MIME-Version: 1.0
X-Pobox-Relay-ID: 9BA25FC8-1D14-11EE-9B3A-307A8E0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The tree-walk.c:do_match() function takes base_offset but just like
tree_entry_interesting() we dealt with earlier, nobody passes a
value other than 0 in it.  Get rid of the parameter to avoid having
to worry about potential bugs lurking unexercised.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 tree-walk.c | 33 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/tree-walk.c b/tree-walk.c
index 1797f2b9c5..f48e8c580e 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -1016,17 +1016,17 @@ static int match_wildcard_base(const struct paths=
pec_item *item,
 /*
  * Is a tree entry interesting given the pathspec we have?
  *
- * Pre-condition: either baselen =3D=3D base_offset (i.e. empty path)
+ * Pre-condition: either baselen =3D=3D 0 (i.e. empty path)
  * or base[baselen-1] =3D=3D '/' (i.e. with trailing slash).
  */
 static enum interesting do_match(struct index_state *istate,
 				 const struct name_entry *entry,
-				 struct strbuf *base, int base_offset,
+				 struct strbuf *base,
 				 const struct pathspec *ps,
 				 int exclude)
 {
 	int i;
-	int pathlen, baselen =3D base->len - base_offset;
+	int pathlen, baselen =3D base->len;
 	enum interesting never_interesting =3D ps->has_wildcard ?
 		entry_not_interesting : all_entries_not_interesting;
=20
@@ -1044,7 +1044,7 @@ static enum interesting do_match(struct index_state=
 *istate,
 		    !(ps->magic & PATHSPEC_MAXDEPTH) ||
 		    ps->max_depth =3D=3D -1)
 			return all_entries_interesting;
-		return within_depth(base->buf + base_offset, baselen,
+		return within_depth(base->buf, baselen,
 				    !!S_ISDIR(entry->mode),
 				    ps->max_depth) ?
 			entry_interesting : entry_not_interesting;
@@ -1055,7 +1055,7 @@ static enum interesting do_match(struct index_state=
 *istate,
 	for (i =3D ps->nr - 1; i >=3D 0; i--) {
 		const struct pathspec_item *item =3D ps->items+i;
 		const char *match =3D item->match;
-		const char *base_str =3D base->buf + base_offset;
+		const char *base_str =3D base->buf;
 		int matchlen =3D item->len, matched =3D 0;
=20
 		if ((!exclude &&   item->magic & PATHSPEC_EXCLUDE) ||
@@ -1148,9 +1148,9 @@ static enum interesting do_match(struct index_state=
 *istate,
=20
 		strbuf_add(base, entry->path, pathlen);
=20
-		if (!git_fnmatch(item, match, base->buf + base_offset,
+		if (!git_fnmatch(item, match, base->buf,
 				 item->nowildcard_len)) {
-			strbuf_setlen(base, base_offset + baselen);
+			strbuf_setlen(base, baselen);
 			goto interesting;
 		}
=20
@@ -1162,13 +1162,13 @@ static enum interesting do_match(struct index_sta=
te *istate,
 		 * be performed in the submodule itself.
 		 */
 		if (ps->recurse_submodules && S_ISGITLINK(entry->mode) &&
-		    !ps_strncmp(item, match, base->buf + base_offset,
+		    !ps_strncmp(item, match, base->buf,
 				item->nowildcard_len)) {
-			strbuf_setlen(base, base_offset + baselen);
+			strbuf_setlen(base, baselen);
 			goto interesting;
 		}
=20
-		strbuf_setlen(base, base_offset + baselen);
+		strbuf_setlen(base, baselen);
=20
 		/*
 		 * Match all directories. We'll try to match files
@@ -1204,9 +1204,9 @@ static enum interesting do_match(struct index_state=
 *istate,
 				return entry_interesting;
=20
 			strbuf_add(base, entry->path, pathlen);
-			ret =3D match_pathspec_attrs(istate, base->buf + base_offset,
-						   base->len - base_offset, item);
-			strbuf_setlen(base, base_offset + baselen);
+			ret =3D match_pathspec_attrs(istate, base->buf,
+						   base->len, item);
+			strbuf_setlen(base, baselen);
 			if (!ret)
 				continue;
 		}
@@ -1218,7 +1218,7 @@ static enum interesting do_match(struct index_state=
 *istate,
 /*
  * Is a tree entry interesting given the pathspec we have?
  *
- * Pre-condition: either baselen =3D=3D base_offset (i.e. empty path)
+ * Pre-condition: either baselen =3D=3D 0 (i.e. empty path)
  * or base[baselen-1] =3D=3D '/' (i.e. with trailing slash).
  */
 enum interesting tree_entry_interesting(struct index_state *istate,
@@ -1227,8 +1227,7 @@ enum interesting tree_entry_interesting(struct inde=
x_state *istate,
 					const struct pathspec *ps)
 {
 	enum interesting positive, negative;
-	const int base_offset =3D 0;
-	positive =3D do_match(istate, entry, base, base_offset, ps, 0);
+	positive =3D do_match(istate, entry, base, ps, 0);
=20
 	/*
 	 * case | entry | positive | negative | result
@@ -1265,7 +1264,7 @@ enum interesting tree_entry_interesting(struct inde=
x_state *istate,
 	    positive <=3D entry_not_interesting) /* #1, #2, #11, #12 */
 		return positive;
=20
-	negative =3D do_match(istate, entry, base, base_offset, ps, 1);
+	negative =3D do_match(istate, entry, base, ps, 1);
=20
 	/* #8, #18 */
 	if (positive =3D=3D all_entries_interesting &&
--=20
2.41.0-318-g061c58647e

