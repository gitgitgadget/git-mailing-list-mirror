Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00F43C001DE
	for <git@archiver.kernel.org>; Mon, 31 Jul 2023 22:45:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbjGaWpG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Jul 2023 18:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231253AbjGaWpD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jul 2023 18:45:03 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FDF9211E
        for <git@vger.kernel.org>; Mon, 31 Jul 2023 15:44:42 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5F2D11A7979;
        Mon, 31 Jul 2023 18:44:18 -0400 (EDT)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=kJu6zrvQK05jbEduffYUX9Aou
        yfaVIfyQNNAvaTIIJo=; b=g+qBVFHgLHWTNsjPoeHvPHIjmeyphby9EYs1Rre1X
        MXpK6EaTd1NwGhI3rmJi0eUzVXta97UW/TTLEj4UhUQwvKR6JAWvCcYbdm64CS+E
        82wewhLn0QXKnoHIgMfAqNN4O7Aw0Tsu/OD3oz5RVvwQjmP3/+4T3rYdHBsMmtyd
        LY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 57EFF1A796F;
        Mon, 31 Jul 2023 18:44:18 -0400 (EDT)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BBEC71A795C;
        Mon, 31 Jul 2023 18:44:16 -0400 (EDT)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH 3/7] update-index: use unmerge_index_entry() to support removal
Date:   Mon, 31 Jul 2023 15:44:05 -0700
Message-ID: <20230731224409.4181277-4-gitster@pobox.com>
X-Mailer: git-send-email 2.41.0-478-gee48e70a82
In-Reply-To: <20230731224409.4181277-1-gitster@pobox.com>
References: <20230731224409.4181277-1-gitster@pobox.com>
MIME-Version: 1.0
X-Pobox-Relay-ID: C7A141F6-2FF3-11EE-844A-307A8E0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"update-index --unresolve" uses the unmerge_index_entry_at() that
assumes that the path to be unresolved must be in the index, which
makes it impossible to unresolve a path that was resolved as removal.

Rewrite unresolve_one() to use the unmerge_index_entry() to support
unresolving such a path.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/update-index.c    | 38 ++++++++++++++++++++++----------------
 t/t2030-unresolve-info.sh | 37 +++++++++++++++++++++++++++++++++----
 2 files changed, 55 insertions(+), 20 deletions(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index 47cd68e9d5..ecd1c0c2d3 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -660,26 +660,31 @@ static int unresolve_one(const char *path)
 	int pos;
 	int ret =3D 0;
 	struct cache_entry *ce_2 =3D NULL, *ce_3 =3D NULL;
+	struct resolve_undo_info *ru =3D NULL;
+
+	if (the_index.resolve_undo) {
+		struct string_list_item *item;
+		item =3D string_list_lookup(the_index.resolve_undo, path);
+		if (item) {
+			ru =3D item->util;
+			item->util =3D NULL;
+		}
+	}
+
+	/* resolve-undo record exists for the path */
+	if (ru) {
+		ret =3D unmerge_index_entry(&the_index, path, ru);
+		free(ru);
+		return ret;
+	}
=20
 	/* See if there is such entry in the index. */
 	pos =3D index_name_pos(&the_index, path, namelen);
 	if (0 <=3D pos) {
-		/* already merged */
-		pos =3D unmerge_index_entry_at(&the_index, pos);
-		if (pos < the_index.cache_nr) {
-			const struct cache_entry *ce =3D the_index.cache[pos];
-			if (ce_stage(ce) &&
-			    ce_namelen(ce) =3D=3D namelen &&
-			    !memcmp(ce->name, path, namelen))
-				return 0;
-		}
-		/* no resolve-undo information; fall back */
+		; /* resolve-undo record was used already -- fall back */
 	} else {
-		/* If there isn't, either it is unmerged, or
-		 * resolved as "removed" by mistake.  We do not
-		 * want to do anything in the former case.
-		 */
-		pos =3D -pos-1;
+		/* Is it unmerged? */
+		pos =3D -pos - 1;
 		if (pos < the_index.cache_nr) {
 			const struct cache_entry *ce =3D the_index.cache[pos];
 			if (ce_namelen(ce) =3D=3D namelen &&
@@ -687,9 +692,10 @@ static int unresolve_one(const char *path)
 				fprintf(stderr,
 					"%s: skipping still unmerged path.\n",
 					path);
-				goto free_return;
 			}
+			goto free_return;
 		}
+		/* No, such a path does not exist -- removed */
 	}
=20
 	/*
diff --git a/t/t2030-unresolve-info.sh b/t/t2030-unresolve-info.sh
index d4e7760df5..3eda385ca2 100755
--- a/t/t2030-unresolve-info.sh
+++ b/t/t2030-unresolve-info.sh
@@ -37,11 +37,17 @@ prime_resolve_undo () {
 	git checkout second^0 &&
 	test_tick &&
 	test_must_fail git merge third^0 &&
-	echo merge does not leave anything &&
 	check_resolve_undo empty &&
-	echo different >fi/le &&
-	git add fi/le &&
-	echo resolving records &&
+
+	# how should the conflict be resolved?
+	case "$1" in
+	remove)
+		rm -f file/le && git rm fi/le
+		;;
+	*) # modify
+		echo different >fi/le && git add fi/le
+		;;
+	esac
 	check_resolve_undo recorded fi/le initial:fi/le second:fi/le third:fi/l=
e
 }
=20
@@ -122,6 +128,8 @@ test_expect_success 'add records checkout -m undoes' =
'
 test_expect_success 'unmerge with plumbing' '
 	prime_resolve_undo &&
 	git update-index --unresolve fi/le &&
+	git ls-files --resolve-undo fi/le >actual &&
+	test_must_be_empty actual &&
 	git ls-files -u >actual &&
 	test_line_count =3D 3 actual
 '
@@ -130,6 +138,27 @@ test_expect_success 'unmerge can be done even after =
committing' '
 	prime_resolve_undo &&
 	git commit -m "record to nuke MERGE_HEAD" &&
 	git update-index --unresolve fi/le &&
+	git ls-files --resolve-undo fi/le >actual &&
+	test_must_be_empty actual &&
+	git ls-files -u >actual &&
+	test_line_count =3D 3 actual
+'
+
+test_expect_success 'unmerge removal' '
+	prime_resolve_undo remove &&
+	git update-index --unresolve fi/le &&
+	git ls-files --resolve-undo fi/le >actual &&
+	test_must_be_empty actual &&
+	git ls-files -u >actual &&
+	test_line_count =3D 3 actual
+'
+
+test_expect_success 'unmerge removal after committing' '
+	prime_resolve_undo remove &&
+	git commit -m "record to nuke MERGE_HEAD" &&
+	git update-index --unresolve fi/le &&
+	git ls-files --resolve-undo fi/le >actual &&
+	test_must_be_empty actual &&
 	git ls-files -u >actual &&
 	test_line_count =3D 3 actual
 '
--=20
2.41.0-478-gee48e70a82

