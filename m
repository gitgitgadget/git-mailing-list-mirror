Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0A1BEE49A0
	for <git@archiver.kernel.org>; Thu, 24 Aug 2023 20:56:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243618AbjHXUzc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Aug 2023 16:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243600AbjHXUzD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Aug 2023 16:55:03 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DA93199F
        for <git@vger.kernel.org>; Thu, 24 Aug 2023 13:55:01 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 63A0D1A0E6C;
        Thu, 24 Aug 2023 16:54:59 -0400 (EDT)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=VcpTRbsLL8LxA6piqJv/JztIS
        RoLkFjv7IPzC/QLXSs=; b=AAZc1PMFbhcPNOxCIKRG1m6ewOt/3VDKl0gBXG4Py
        13pw+g0LLzZllFQ4dC3UwwT2n7sIcC2dI9ZgtIqyG8ulqvfD+uaFSZZ9w+DrU4ZB
        vwzK0TnhZXFTmGrNML5aXCyQSoxiXXLSNrAeiuFqls2HZJ+2rPs3hLeaDZXh9zVp
        x0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5C3951A0E6B;
        Thu, 24 Aug 2023 16:54:59 -0400 (EDT)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BA4AD1A0E6A;
        Thu, 24 Aug 2023 16:54:58 -0400 (EDT)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH 1/4] rerere: simplify check_one_conflict() helper function
Date:   Thu, 24 Aug 2023 13:54:53 -0700
Message-ID: <20230824205456.1231371-2-gitster@pobox.com>
X-Mailer: git-send-email 2.42.0-29-gcd9da15a85
In-Reply-To: <20230824205456.1231371-1-gitster@pobox.com>
References: <20230824205456.1231371-1-gitster@pobox.com>
MIME-Version: 1.0
X-Pobox-Relay-ID: 7CAB08E6-42C0-11EE-BF88-25B3960A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The helper function is responsible for inspecting the index and
deciding if the path is merged, is conflicted in a way that we would
want to handle, or is conflicted in a way that we cannot handle.

Currently, only conflicts with both stage #2 and stage #3 are
handled, but eventually we would want to be able to deal with
delete-modify conflicts (i.e. only one of stages #2 and #3 exist).
Streamline the implementation of the function to make it easier to
extend.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 rerere.c | 34 +++++++++++++++-------------------
 1 file changed, 15 insertions(+), 19 deletions(-)

diff --git a/rerere.c b/rerere.c
index b525dd9230..73cdc8392f 100644
--- a/rerere.c
+++ b/rerere.c
@@ -499,9 +499,11 @@ static int handle_file(struct index_state *istate,
 }
=20
 /*
- * Look at a cache entry at "i" and see if it is not conflicting,
- * conflicting and we are willing to handle, or conflicting and
- * we are unable to handle, and return the determination in *type.
+ * Look at a cache entry at "i" and see if it is not conflicting
+ * (RESOLVED), conflicting and we are willing to handle (THREE_STAGED),
+ * or conflicting and we are unable to handle (PUNTED), and return the
+ * determination in *type.
+ *
  * Return the cache index to be looked at next, by skipping the
  * stages we have already looked at in this invocation of this
  * function.
@@ -509,6 +511,7 @@ static int handle_file(struct index_state *istate,
 static int check_one_conflict(struct index_state *istate, int i, int *ty=
pe)
 {
 	const struct cache_entry *e =3D istate->cache[i];
+	unsigned int seen_stages =3D 0;
=20
 	if (!ce_stage(e)) {
 		*type =3D RESOLVED;
@@ -516,24 +519,17 @@ static int check_one_conflict(struct index_state *i=
state, int i, int *type)
 	}
=20
 	*type =3D PUNTED;
-	while (i < istate->cache_nr && ce_stage(istate->cache[i]) =3D=3D 1)
-		i++;
-
-	/* Only handle regular files with both stages #2 and #3 */
-	if (i + 1 < istate->cache_nr) {
-		const struct cache_entry *e2 =3D istate->cache[i];
-		const struct cache_entry *e3 =3D istate->cache[i + 1];
-		if (ce_stage(e2) =3D=3D 2 &&
-		    ce_stage(e3) =3D=3D 3 &&
-		    ce_same_name(e, e3) &&
-		    S_ISREG(e2->ce_mode) &&
-		    S_ISREG(e3->ce_mode))
-			*type =3D THREE_STAGED;
+	for (; i < istate->cache_nr; i++) {
+		const struct cache_entry *n =3D istate->cache[i];
+		if (!ce_same_name(n, e))
+			break;
+		if (S_ISREG(n->ce_mode))
+			seen_stages |=3D 1u << (ce_stage(n) - 1);
 	}
=20
-	/* Skip the entries with the same name */
-	while (i < istate->cache_nr && ce_same_name(e, istate->cache[i]))
-		i++;
+	if ((seen_stages & 6) =3D=3D 6)
+		*type =3D THREE_STAGED; /* has both stages #2 and #3 */
+
 	return i;
 }
=20
--=20
2.42.0-29-gcd9da15a85

