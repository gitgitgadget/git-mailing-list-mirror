Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3166BEB64DD
	for <git@archiver.kernel.org>; Thu, 27 Jul 2023 21:51:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbjG0VvP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Jul 2023 17:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjG0VvO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jul 2023 17:51:14 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96C372135
        for <git@vger.kernel.org>; Thu, 27 Jul 2023 14:51:13 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4B8EB22E7F;
        Thu, 27 Jul 2023 17:51:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=5Glvn+ARik6YlsAnmdCZqw9AgUbBLkv7RvDjN8
        JY27Q=; b=GD0xwDpeHu4Zndbf8Vx53dIxD1XL9c4oc3zdoEbGDmIB+vQ4HQhkoy
        tbJExDY+d+5vMu7wsz5HP8+/GM46PgAUsDJ5kWaUikB/fxSWja/48Nm9YUuWRc4v
        XoV0aT65J4PwACf9QKbBL5oLBbmMVkdj3dgKTRQj4aK8JbGuuTpI0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 43DF222E7E;
        Thu, 27 Jul 2023 17:51:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C700122E7C;
        Thu, 27 Jul 2023 17:51:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH 2/2] update-index: use unmerge_index_entry() to support removal
References: <xmqq3519auz5.fsf@gitster.g>
Date:   Thu, 27 Jul 2023 14:51:08 -0700
In-Reply-To: <xmqq3519auz5.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
        27 Jul 2023 14:46:22 -0700")
Message-ID: <xmqqtttp9g6r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B2677852-2CC7-11EE-9190-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"update-index --unresolve" used the unmerge_index_entry_at() that
assumed that the path to be unresolved must be in the index, which
made it impossible to unresolve a path that was resolved as removal.

Rewrite unresolve_one() to use the unmerge_index_entry() to support
unresolving such a path.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 * Now getting rid of unmerge_index_entry_at() is a bigger task.  The
   only remaining user of it is the "checkout -m -- $path" codepath.

 builtin/update-index.c    | 33 +++++++++++++++++----------------
 t/t2030-unresolve-info.sh | 29 +++++++++++++++++++++++++----
 2 files changed, 42 insertions(+), 20 deletions(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index 853ec9eb7a..d02ac55313 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -661,26 +661,26 @@ static int unresolve_one(const char *path)
 	int pos;
 	int ret = 0;
 	struct cache_entry *ce_2 = NULL, *ce_3 = NULL;
+	struct resolve_undo_info *ru = NULL;
+
+	if (the_index.resolve_undo) {
+		struct string_list_item *item;
+		item = string_list_lookup(the_index.resolve_undo, path);
+		if (item)
+			ru = item->util;
+	}
+
+	/* resolve-undo record exists for the path */
+	if (ru)
+		return unmerge_index_entry(&the_index, path, ru);
 
 	/* See if there is such entry in the index. */
 	pos = index_name_pos(&the_index, path, namelen);
 	if (0 <= pos) {
-		/* already merged */
-		pos = unmerge_index_entry_at(&the_index, pos);
-		if (pos < the_index.cache_nr) {
-			const struct cache_entry *ce = the_index.cache[pos];
-			if (ce_stage(ce) &&
-			    ce_namelen(ce) == namelen &&
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
-		pos = -pos-1;
+		/* Is it unmerged? */
+		pos = -pos - 1;
 		if (pos < the_index.cache_nr) {
 			const struct cache_entry *ce = the_index.cache[pos];
 			if (ce_namelen(ce) == namelen &&
@@ -688,9 +688,10 @@ static int unresolve_one(const char *path)
 				fprintf(stderr,
 					"%s: skipping still unmerged path.\n",
 					path);
-				goto free_return;
 			}
+			goto free_return;
 		}
+		/* No, such a path does not exist -- removed */
 	}
 
 	/*
diff --git a/t/t2030-unresolve-info.sh b/t/t2030-unresolve-info.sh
index d4e7760df5..6a3af64e0f 100755
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
 	check_resolve_undo recorded fi/le initial:fi/le second:fi/le third:fi/le
 }
 
@@ -134,6 +140,21 @@ test_expect_success 'unmerge can be done even after committing' '
 	test_line_count = 3 actual
 '
 
+test_expect_success 'unmerge removal' '
+	prime_resolve_undo remove &&
+	git update-index --unresolve fi/le &&
+	git ls-files -u actual &&
+	test_line_count = 3 actual
+'
+
+test_expect_success 'unmerge removal after committing' '
+	prime_resolve_undo remove &&
+	git commit -m "record to nuke MERGE_HEAD" &&
+	git update-index --unresolve fi/le &&
+	git ls-files -u actual &&
+	test_line_count = 3 actual
+'
+
 test_expect_success 'rerere and rerere forget' '
 	mkdir .git/rr-cache &&
 	prime_resolve_undo &&
-- 
2.41.0-459-gb4fce4b6e4

