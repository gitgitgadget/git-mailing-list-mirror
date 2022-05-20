Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B7B3C433EF
	for <git@archiver.kernel.org>; Fri, 20 May 2022 23:18:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238117AbiETXSX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 May 2022 19:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354056AbiETXSQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 May 2022 19:18:16 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49AA61A077A
        for <git@vger.kernel.org>; Fri, 20 May 2022 16:18:03 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id y20so8297847qvx.3
        for <git@vger.kernel.org>; Fri, 20 May 2022 16:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IM3XAO3pf5U8RlWtshzVWA/j+5inRqkRH3HxSPeZTZ4=;
        b=ADgEjm4uY5vNGCUJxUxkpTOFJPlzOXt8rjOJdeQaVfVKnAMXQtn90/B6l04YlpnOLn
         PJwEwnOtoeLVs5abs8z2mCSJOKnnItRoETgZwiqsIsGpWhqTvMi5Ojcr+po5ge80zp2V
         xvJqC4ImpmvqlTUw/FI3D65V0IujISbzlPqY2HE2EZHebeFGjOgK3bROw833cAsYWLF3
         wnUn1QMQrVPBCFLh+WM1wYQTCNc/MZ0DwQ4au9Rz9yffSSMTIJRwiLJ6sjfvk4wq4B8I
         ncVqVr2ato4+XG5n3AnD69fIczyYc5vz5XMCCGei9eG2cx+GNB0MGz5qL+/oms+EDy0l
         KkRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IM3XAO3pf5U8RlWtshzVWA/j+5inRqkRH3HxSPeZTZ4=;
        b=yzQs9HcDkBGmRVA7oAcsNePtwcc1xop0pSxYNXJ5ZeOSP9wBRjQrzpVRCr/9NnQJh/
         aU28tKpbSXGb+jJk/J139QMQilxrIS6BwXkawiRM5tGipYuYgjH7dJTWajr90+5YVe9X
         fhldboPzWg2jGG68KM528btldl3MDvRk2Xu1II1ZKlaPkkv4YjY6XZs8tu2DQy5T8GfE
         XJJjFb7omJ5UFLxuOgPFmo2BtYPITunlY0EqSFN+fth2UAvDhetndlV9cpCV3d1jaeg5
         N8TRoUMyTh7i5cGY6lU1llpo5yoIWMvmvYpNp4eBIJdmRJrMyarFXGgYhFdnExwgc12b
         t6/w==
X-Gm-Message-State: AOAM530/bube5uN4afSwT1Eej1HoNx8Slu/eVo6X8tzgEkTwQz6Tfydh
        cdRpRfcJLGABHnGgrCjO102VnmIULM5wxpLo
X-Google-Smtp-Source: ABdhPJzW4kWqG3E/fazzXZsaUPPac/WN2J7H7VlQq6zwPTe26vZlVgzGs+F3L1Q/4uM6Rtw2cxrBPg==
X-Received: by 2002:ad4:5b85:0:b0:461:f4ee:4663 with SMTP id 5-20020ad45b85000000b00461f4ee4663mr9743319qvp.21.1653088681505;
        Fri, 20 May 2022 16:18:01 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id c1-20020a05620a200100b006a34a22bc60sm466449qka.9.2022.05.20.16.18.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 16:18:01 -0700 (PDT)
Date:   Fri, 20 May 2022 19:18:00 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, derrickstolee@github.com, gitster@pobox.com,
        jrnieder@gmail.com, larsxschneider@gmail.com, tytso@mit.edu
Subject: [PATCH v5 11/17] builtin/pack-objects.c: --cruft with expiration
Message-ID: <1434e3762389a6f5cd4236aada6d3ab1afad5681.1653088640.git.me@ttaylorr.com>
References: <cover.1638224692.git.me@ttaylorr.com>
 <cover.1653088640.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1653088640.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a previous patch, pack-objects learned how to generate a cruft pack
so long as no objects are dropped.

This patch teaches pack-objects to handle the case where a non-never
`--cruft-expiration` value is passed. This case is slightly more
complicated than before, because we want pack-objects to save
unreachable objects which would have been pruned when there is another
recent (i.e., non-prunable) unreachable object which reaches the other.
We'll call these objects "unreachable but reachable-from-recent".

Here is how pack-objects handles `--cruft-expiration`:

  - Instead of adding all objects outside of the kept pack(s) into the
    packing list, only handle the ones whose mtime is within the grace
    period.

  - Construct a reachability traversal whose tips are the
    unreachable-but-recent objects.

  - Then, walk along that traversal, stopping if we reach an object in
    the kept pack. At each step along the traversal, we add the object
    we are visiting to the packing list.

In the majority of these cases, any object we visit in this traversal
will already be in our packing list. But we will sometimes encounter
reachable-from-recent cruft objects, which we want to retain even if
they aged out of the grace period.

The most subtle point of this process is that we actually don't need to
bother to update the rescued object's mtime. Even though we will write
an .mtimes file with a value that is older than the expiration window,
it will continue to survive cruft repacks so long as any objects which
reach it haven't aged out.

That is, a future repack will also exclude that object from the initial
packing list, only to discover it later on when doing the reachability
traversal.

Finally, stopping early once an object is found in a kept pack is safe
to do because the kept packs ordinarily represent which packs will
survive after repacking. Assuming that it _isn't_ safe to halt a
traversal early would mean that there is some ancestor object which is
missing, which implies repository corruption (i.e., the complete set of
reachable objects isn't present).

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/pack-objects.c        |  84 +++++++++++++++++++-
 reachable.h                   |   4 +-
 t/t5329-pack-objects-cruft.sh | 143 ++++++++++++++++++++++++++++++++++
 3 files changed, 228 insertions(+), 3 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 3b8bf6a3dd..8decc9dc0c 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3447,6 +3447,44 @@ static void add_cruft_object_entry(const struct object_id *oid, enum object_type
 	return;
 }
 
+static void show_cruft_object(struct object *obj, const char *name, void *data)
+{
+	/*
+	 * if we did not record it earlier, it's at least as old as our
+	 * expiration value. Rather than find it exactly, just use that
+	 * value.  This may bump it forward from its real mtime, but it
+	 * will still be "too old" next time we run with the same
+	 * expiration.
+	 *
+	 * if obj does appear in the packing list, this call is a noop (or may
+	 * set the namehash).
+	 */
+	add_cruft_object_entry(&obj->oid, obj->type, NULL, 0, name, cruft_expiration);
+}
+
+static void show_cruft_commit(struct commit *commit, void *data)
+{
+	show_cruft_object((struct object*)commit, NULL, data);
+}
+
+static int cruft_include_check_obj(struct object *obj, void *data)
+{
+	return !has_object_kept_pack(&obj->oid, IN_CORE_KEEP_PACKS);
+}
+
+static int cruft_include_check(struct commit *commit, void *data)
+{
+	return cruft_include_check_obj((struct object*)commit, data);
+}
+
+static void set_cruft_mtime(const struct object *object,
+			    struct packed_git *pack,
+			    off_t offset, time_t mtime)
+{
+	add_cruft_object_entry(&object->oid, object->type, pack, offset, NULL,
+			       mtime);
+}
+
 static void mark_pack_kept_in_core(struct string_list *packs, unsigned keep)
 {
 	struct string_list_item *item = NULL;
@@ -3472,6 +3510,50 @@ static void enumerate_cruft_objects(void)
 	stop_progress(&progress_state);
 }
 
+static void enumerate_and_traverse_cruft_objects(struct string_list *fresh_packs)
+{
+	struct packed_git *p;
+	struct rev_info revs;
+	int ret;
+
+	repo_init_revisions(the_repository, &revs, NULL);
+
+	revs.tag_objects = 1;
+	revs.tree_objects = 1;
+	revs.blob_objects = 1;
+
+	revs.include_check = cruft_include_check;
+	revs.include_check_obj = cruft_include_check_obj;
+
+	revs.ignore_missing_links = 1;
+
+	if (progress)
+		progress_state = start_progress(_("Enumerating cruft objects"), 0);
+	ret = add_unseen_recent_objects_to_traversal(&revs, cruft_expiration,
+						     set_cruft_mtime, 1);
+	stop_progress(&progress_state);
+
+	if (ret)
+		die(_("unable to add cruft objects"));
+
+	/*
+	 * Re-mark only the fresh packs as kept so that objects in
+	 * unknown packs do not halt the reachability traversal early.
+	 */
+	for (p = get_all_packs(the_repository); p; p = p->next)
+		p->pack_keep_in_core = 0;
+	mark_pack_kept_in_core(fresh_packs, 1);
+
+	if (prepare_revision_walk(&revs))
+		die(_("revision walk setup failed"));
+	if (progress)
+		progress_state = start_progress(_("Traversing cruft objects"), 0);
+	nr_seen = 0;
+	traverse_commit_list(&revs, show_cruft_commit, show_cruft_object, NULL);
+
+	stop_progress(&progress_state);
+}
+
 static void read_cruft_objects(void)
 {
 	struct strbuf buf = STRBUF_INIT;
@@ -3523,7 +3605,7 @@ static void read_cruft_objects(void)
 	mark_pack_kept_in_core(&discard_packs, 0);
 
 	if (cruft_expiration)
-		die("--cruft-expiration not yet implemented");
+		enumerate_and_traverse_cruft_objects(&fresh_packs);
 	else
 		enumerate_cruft_objects();
 
diff --git a/reachable.h b/reachable.h
index b776761baa..020a887b99 100644
--- a/reachable.h
+++ b/reachable.h
@@ -1,10 +1,10 @@
 #ifndef REACHEABLE_H
 #define REACHEABLE_H
 
-#include "object.h"
-
 struct progress;
 struct rev_info;
+struct object;
+struct packed_git;
 
 typedef void report_recent_object_fn(const struct object *, struct packed_git *,
 				     off_t, time_t);
diff --git a/t/t5329-pack-objects-cruft.sh b/t/t5329-pack-objects-cruft.sh
index 003ca7344e..939cdc297a 100755
--- a/t/t5329-pack-objects-cruft.sh
+++ b/t/t5329-pack-objects-cruft.sh
@@ -214,5 +214,148 @@ basic_cruft_pack_tests () {
 }
 
 basic_cruft_pack_tests never
+basic_cruft_pack_tests 2.weeks.ago
+
+test_expect_success 'cruft tags rescue tagged objects' '
+	git init repo &&
+	test_when_finished "rm -fr repo" &&
+	(
+		cd repo &&
+
+		test_commit packed &&
+		git repack -Ad &&
+
+		test_commit tagged &&
+		git tag -a annotated -m tag &&
+
+		git rev-list --objects --no-object-names packed.. >objects &&
+		while read oid
+		do
+			test-tool chmtime -1000 \
+				"$objdir/$(test_oid_to_path $oid)"
+		done <objects &&
+
+		test-tool chmtime -500 \
+			"$objdir/$(test_oid_to_path $(git rev-parse annotated))" &&
+
+		keep="$(basename "$(ls $packdir/pack-*.pack)")" &&
+		cruft="$(echo $keep | git pack-objects --cruft \
+			--cruft-expiration=750.seconds.ago \
+			$packdir/pack)" &&
+		test-tool pack-mtimes "pack-$cruft.mtimes" >actual.raw &&
+		cut -f1 -d" " <actual.raw | sort >actual &&
+
+		(
+			cat objects &&
+			git rev-parse annotated
+		) >expect.raw &&
+		sort <expect.raw >expect &&
+
+		test_cmp expect actual &&
+		cat actual
+	)
+'
+
+test_expect_success 'cruft commits rescue parents, trees' '
+	git init repo &&
+	test_when_finished "rm -fr repo" &&
+	(
+		cd repo &&
+
+		test_commit packed &&
+		git repack -Ad &&
+
+		test_commit old &&
+		test_commit new &&
+
+		git rev-list --objects --no-object-names packed..new >objects &&
+		while read object
+		do
+			test-tool chmtime -1000 \
+				"$objdir/$(test_oid_to_path $object)"
+		done <objects &&
+		test-tool chmtime +500 "$objdir/$(test_oid_to_path \
+			$(git rev-parse HEAD))" &&
+
+		keep="$(basename "$(ls $packdir/pack-*.pack)")" &&
+		cruft="$(echo $keep | git pack-objects --cruft \
+			--cruft-expiration=750.seconds.ago \
+			$packdir/pack)" &&
+		test-tool pack-mtimes "pack-$cruft.mtimes" >actual.raw &&
+
+		cut -d" " -f1 <actual.raw | sort >actual &&
+		sort <objects >expect &&
+
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'cruft trees rescue sub-trees, blobs' '
+	git init repo &&
+	test_when_finished "rm -fr repo" &&
+	(
+		cd repo &&
+
+		test_commit packed &&
+		git repack -Ad &&
+
+		mkdir -p dir/sub &&
+		echo foo >foo &&
+		echo bar >dir/bar &&
+		echo baz >dir/sub/baz &&
+
+		test_tick &&
+		git add . &&
+		git commit -m "pruned" &&
+
+		test-tool chmtime -1000 "$objdir/$(test_oid_to_path $(git rev-parse HEAD))" &&
+		test-tool chmtime -1000 "$objdir/$(test_oid_to_path $(git rev-parse HEAD^{tree}))" &&
+		test-tool chmtime -1000 "$objdir/$(test_oid_to_path $(git rev-parse HEAD:foo))" &&
+		test-tool chmtime  -500 "$objdir/$(test_oid_to_path $(git rev-parse HEAD:dir))" &&
+		test-tool chmtime -1000 "$objdir/$(test_oid_to_path $(git rev-parse HEAD:dir/bar))" &&
+		test-tool chmtime -1000 "$objdir/$(test_oid_to_path $(git rev-parse HEAD:dir/sub))" &&
+		test-tool chmtime -1000 "$objdir/$(test_oid_to_path $(git rev-parse HEAD:dir/sub/baz))" &&
+
+		keep="$(basename "$(ls $packdir/pack-*.pack)")" &&
+		cruft="$(echo $keep | git pack-objects --cruft \
+			--cruft-expiration=750.seconds.ago \
+			$packdir/pack)" &&
+		test-tool pack-mtimes "pack-$cruft.mtimes" >actual.raw &&
+		cut -f1 -d" " <actual.raw | sort >actual &&
+
+		git rev-parse HEAD:dir HEAD:dir/bar HEAD:dir/sub HEAD:dir/sub/baz >expect.raw &&
+		sort <expect.raw >expect &&
+
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'expired objects are pruned' '
+	git init repo &&
+	test_when_finished "rm -fr repo" &&
+	(
+		cd repo &&
+
+		test_commit packed &&
+		git repack -Ad &&
+
+		test_commit pruned &&
+
+		git rev-list --objects --no-object-names packed..pruned >objects &&
+		while read object
+		do
+			test-tool chmtime -1000 \
+				"$objdir/$(test_oid_to_path $object)"
+		done <objects &&
+
+		keep="$(basename "$(ls $packdir/pack-*.pack)")" &&
+		cruft="$(echo $keep | git pack-objects --cruft \
+			--cruft-expiration=750.seconds.ago \
+			$packdir/pack)" &&
+
+		test-tool pack-mtimes "pack-$cruft.mtimes" >actual &&
+		test_must_be_empty actual
+	)
+'
 
 test_done
-- 
2.36.1.94.gb0d54bedca

