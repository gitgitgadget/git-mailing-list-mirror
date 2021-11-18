Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B5B9C433FE
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 16:52:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7900E61B31
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 16:52:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234029AbhKRQxS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Nov 2021 11:53:18 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:57646 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233798AbhKRQww (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Nov 2021 11:52:52 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id B99C11FD57
        for <git@vger.kernel.org>; Thu, 18 Nov 2021 16:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637254188; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fhny/z4JRByPragM5njdv8TFYMb262mT72nZ5Crjcj4=;
        b=nuNu0o//O7HN1pH70Iltzital/zfraykHkbMDjh4BvYimIZzgjeevYOJrE66RZPHXWz3EL
        G1onKrxNso/UsSOHwyxuAbJLANSgy8m7VRJy6TZeOBLXmxwIAw8LRisI/1EnnjE6mlYmB0
        G3dghGifEThCK659ozL1Nbj64JSo5Xo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637254188;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fhny/z4JRByPragM5njdv8TFYMb262mT72nZ5Crjcj4=;
        b=DTuNKswOXscZogNbYRzwK0j/Ldqo4/ZoQYm7NkpAGBYwL1VGOmtFmyOIigXbrP8+nT/hF6
        ziKyKT+bxUZwtlBQ==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id ADBDDA3BA2;
        Thu, 18 Nov 2021 16:49:48 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id CE0A61F2CCB; Thu, 18 Nov 2021 17:49:47 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     git@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>
Subject: [PATCH 26/27] bisect: Debug stochastic bisection
Date:   Thu, 18 Nov 2021 17:49:39 +0100
Message-Id: <20211118164940.8818-27-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211118164940.8818-1-jack@suse.cz>
References: <20211118164940.8818-1-jack@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add debug prints for debugging stochastic bisection.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 bisect.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/bisect.c b/bisect.c
index 6ed740106795..4d2ba5dbd77e 100644
--- a/bisect.c
+++ b/bisect.c
@@ -620,6 +620,21 @@ static int sw_rev_bmp_cmp(const void *data, const struct hashmap_entry *ap,
 	return 0;
 }
 
+static void show_cluster(struct sw_rev_bmp_hash_entry *entry)
+{
+	int i;
+
+	if (!DEBUG_BISECT)
+		return;
+
+	fprintf(stderr, "cluster prob %"FPNUM_FMT" members %u reaching revs ",
+		entry->cluster_p_bad, entry->count);
+	for (i = 0; i < ptest_revs.nr; i++)
+		if (sw_rev_bmp_test(entry->commit_weight, i))
+			fprintf(stderr, "%.8s ", oid_to_hex(ptest_revs.oid + i));
+	fprintf(stderr, "\n");
+}
+
 /*
  * Compute for each commit a probability it is the bad one given tests
  * performed so far.
@@ -697,6 +712,7 @@ static struct commit_list *compute_commit_weights(struct commit_list *list)
 	hashmap_for_each_entry(&reach_map, &reach_iter, found_entry, entry) {
 		found_entry->cluster_p_bad = fp_div(found_entry->cluster_p_bad,
 						    cluster_prob_sum);
+		show_cluster(found_entry);
 	}
 
 	/* Uniformly distribute the probability among all nodes of a cluster */
@@ -1111,6 +1127,30 @@ static struct commit_list *managed_skipped(struct commit_list *list,
 	return skip_away(list, count);
 }
 
+static void print_object(struct object *obj)
+{
+	unsigned flags = obj->flags;
+
+	fprintf(stderr, "%c%c%c%c ",
+		(flags & TREESAME) ? ' ' : 'T',
+		(flags & UNINTERESTING) ? 'U' : ' ',
+		(flags & SEEN) ? 'S' : ' ',
+		(flags & COUNTED) ? 'C' : ' ');
+	fprintf(stderr, "%.8s\n", oid_to_hex(&obj->oid));
+}
+
+static void show_object_array(const char *str, struct object_array *array)
+{
+	int i;
+
+	if (!DEBUG_BISECT)
+		return;
+
+	fprintf(stderr, "%s\n", str);
+	for (i = 0; i < array->nr; i++)
+		print_object(array->objects[i].item);
+}
+
 static void bisect_rev_setup(struct repository *r, struct rev_info *revs,
 			     const char *prefix,
 			     const char *bad_format, const char *good_format,
@@ -1139,12 +1179,16 @@ static void bisect_rev_setup(struct repository *r, struct rev_info *revs,
 
 	setup_revisions(rev_argv.nr, rev_argv.v, revs, NULL);
 	/* XXX leak rev_argv, as "revs" may still be pointing to it */
+	show_list("setup_revisions commits", 0, 0, revs->commits);
+	show_object_array("setup_revisions pending", &revs->pending);
 }
 
 static void bisect_common(struct rev_info *revs)
 {
 	if (prepare_revision_walk(revs))
 		die("revision walk setup failed");
+	show_list("bisect_common commits", 0, 0, revs->commits);
+	show_object_array("bisect_common pending", &revs->pending);
 	if (revs->tree_objects)
 		mark_edges_uninteresting(revs, NULL, 0);
 }
@@ -1462,6 +1506,12 @@ void read_bisect_terms(const char **read_bad, const char **read_good)
 	fclose(fp);
 }
 
+static int debug_print_oid(const struct object_id *oid, void *data)
+{
+	fprintf(stderr, "%s\n", oid_to_hex(oid));
+	return 0;
+}
+
 /*
  * We use the convention that return BISECT_INTERNAL_SUCCESS_1ST_BAD_FOUND (-10) means
  * the bisection process finished successfully.
@@ -1493,6 +1543,12 @@ enum bisect_error bisect_next_all(struct repository *r, const char *prefix)
 	if (read_bisect_refs())
 		die(_("reading bisect refs failed"));
 	read_bisect_confidences();
+	if (DEBUG_BISECT) {
+		debug_bisect("good revs:\n");
+		oid_array_for_each(&good_revs, debug_print_oid, NULL);
+		debug_bisect("p-test revs:\n");
+		oid_array_for_each(&ptest_revs, debug_print_oid, NULL);
+	}
 
 	if (file_exists(git_path_bisect_first_parent()))
 		bisect_flags |= FIND_BISECTION_FIRST_PARENT_ONLY;
-- 
2.26.2

