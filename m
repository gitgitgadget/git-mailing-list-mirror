Return-Path: <SRS0=nsHh=4C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3202CC3B1B9
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 18:22:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1120F2168B
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 18:22:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394893AbgBNSWZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Feb 2020 13:22:25 -0500
Received: from cloud.peff.net ([104.130.231.41]:43706 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2393257AbgBNSWV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Feb 2020 13:22:21 -0500
Received: (qmail 22964 invoked by uid 109); 14 Feb 2020 18:22:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 14 Feb 2020 18:22:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23661 invoked by uid 111); 14 Feb 2020 18:31:18 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 14 Feb 2020 13:31:18 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 14 Feb 2020 13:22:20 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 06/15] rev-list: make --count work with --objects
Message-ID: <20200214182220.GF150965@coredump.intra.peff.net>
References: <20200214182147.GA654525@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200214182147.GA654525@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The current behavior from "rev-list --count --objects" is nonsensical:
we enumerate all of the objects except commits, but then give a count of
commits. This wasn't planned, and is just what the code happens to do.

Instead, let's give the answer the user almost certainly wanted: the
full count of objects.

Note that there are more complicated cases around cherry-marking, etc.
We'll punt on those for now, but let the user know that we can't produce
an answer (rather than giving them something useless).

We'll test both the new feature as well as a vanilla --count of commits,
since that surprisingly doesn't seem to be covered in the existing
tests.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/rev-list.c       | 13 +++++++++++++
 t/t6000-rev-list-misc.sh | 12 ++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 38c5ca5603..9452123988 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -253,11 +253,19 @@ static int finish_object(struct object *obj, const char *name, void *cb_data)
 static void show_object(struct object *obj, const char *name, void *cb_data)
 {
 	struct rev_list_info *info = cb_data;
+	struct rev_info *revs = info->revs;
+
 	if (finish_object(obj, name, cb_data))
 		return;
 	display_progress(progress, ++progress_counter);
 	if (info->flags & REV_LIST_QUIET)
 		return;
+
+	if (revs->count) {
+		revs->count_right++;
+		return;
+	}
+
 	if (arg_show_object_names)
 		show_object_with_name(stdout, obj, name);
 	else
@@ -584,6 +592,11 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 	if (revs.show_notes)
 		die(_("rev-list does not support display of notes"));
 
+	if (revs.count &&
+	    (revs.tag_objects || revs.tree_objects || revs.blob_objects) &&
+	    (revs.left_right || revs.cherry_mark))
+		die(_("marked counting is incompatible with --objects"));
+
 	if (filter_options.choice)
 		use_bitmap_index = 0;
 
diff --git a/t/t6000-rev-list-misc.sh b/t/t6000-rev-list-misc.sh
index b8cf82349b..383f2c457d 100755
--- a/t/t6000-rev-list-misc.sh
+++ b/t/t6000-rev-list-misc.sh
@@ -148,4 +148,16 @@ test_expect_success 'rev-list --end-of-options' '
 	test_cmp expect actual
 '
 
+test_expect_success 'rev-list --count' '
+	count=$(git rev-list --count HEAD) &&
+	git rev-list HEAD >actual &&
+	test_line_count = $count actual
+'
+
+test_expect_success 'rev-list --count --objects' '
+	count=$(git rev-list --count --objects HEAD) &&
+	git rev-list --objects HEAD >actual &&
+	test_line_count = $count actual
+'
+
 test_done
-- 
2.25.0.796.gcc29325708

