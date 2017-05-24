Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D535820281
	for <e@80x24.org>; Wed, 24 May 2017 05:16:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S969145AbdEXFQi (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 May 2017 01:16:38 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:34465 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S969135AbdEXFQc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 May 2017 01:16:32 -0400
Received: by mail-oi0-f66.google.com with SMTP id w10so31062294oif.1
        for <git@vger.kernel.org>; Tue, 23 May 2017 22:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xGEZHtgtJi7hVnZMsSt4K6xviQA7n8hejBC7qEvWw5c=;
        b=Xwjt6/sm1j22l/WvsuBBZdcayNu9LfsT9cUA6ubtV9v+TQgZ2XbFS/rxcCRruhkCTe
         XtXw3Mq6A81sxr6uhtQoOwBisYDonHtP356Z/sueJypyAgwVmBont7rRHT/f2i+vC9gx
         NL+wJ3Lnc+zLfLBRiB1ngEj1t/uzsBNoHWq0teYh7n2Arm6oBt8CuM/FwhgYAhG8jLY8
         Ke69uh4qobnosi5oYh1bI0A2xMoV3ymAzubUv91XCc7GV+Selgo0jyJ//f0LANXRWlVF
         iaDkZ1+Qpxc5kehFgo0NWyUvQaHycG8Q4UQw2UBEwo+AQYVxuGnOPsS7zkNxK8o7hU6p
         ElDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xGEZHtgtJi7hVnZMsSt4K6xviQA7n8hejBC7qEvWw5c=;
        b=qB81fmjDDKbYh7poPnqbDoednZhKFbWfiah4+DQ4nCqu7XCQwJ5wES0gTtzPw+GqDG
         6wxzhmulQDXKxwve9L086cdSKtXtgvoVht9LmSFKIidJEngDV12rIeE4RpW+/AnWDveP
         VVMq6MbYwiWNkY/l2n8nvQW/o7R+qLp3aoVYJ3FW0VUFVVN6FilLHbed2bMtBWqAb6kH
         3tmyOoNcfaOe5uyyuSNzaGgMj0rO0M2hYGHNFPs7zy0Pwe9igfEPYULT47MN+tWq37FX
         s6EdkYd757KSphbhZxBKxSCAgJ56b4nDB2yvROm83iAmwkvOHAKrf53PuuwlMmZTPn+4
         flZA==
X-Gm-Message-State: AODbwcDOVto5JhSmPRcu8GOHN5IOjdcOqzhV90sVB9iP3vMw9Ukn9oaL
        p3802Opp+hjXqA==
X-Received: by 10.157.40.5 with SMTP id m5mr4138578otb.111.1495602991359;
        Tue, 23 May 2017 22:16:31 -0700 (PDT)
Received: from whydoubt.T-mobile.com (ip68-12-240-88.ok.ok.cox.net. [68.12.240.88])
        by smtp.gmail.com with ESMTPSA id f81sm1429917oih.1.2017.05.23.22.16.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 May 2017 22:16:30 -0700 (PDT)
From:   Jeff Smith <whydoubt@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, Jeff Smith <whydoubt@gmail.com>
Subject: [PATCH 11/29] blame: move copy/move thresholds to scoreboard
Date:   Wed, 24 May 2017 00:15:19 -0500
Message-Id: <20170524051537.29978-12-whydoubt@gmail.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170524051537.29978-1-whydoubt@gmail.com>
References: <20170524051537.29978-1-whydoubt@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Copy and move score thresholds are used in parts of blame that are being
moved to libgit, and should be accessible via the scoreboard structure.

Signed-off-by: Jeff Smith <whydoubt@gmail.com>
---
 builtin/blame.c | 41 +++++++++++++++++++++++------------------
 1 file changed, 23 insertions(+), 18 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index f0c9ab8..643f847 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -66,10 +66,6 @@ static struct string_list mailmap = STRING_LIST_INIT_NODUP;
 #define PICKAXE_BLAME_COPY_HARDER	04
 #define PICKAXE_BLAME_COPY_HARDEST	010
 
-/*
- * blame for a blame_entry with score lower than these thresholds
- * is not passed to the parent using move/copy logic.
- */
 static unsigned blame_move_score;
 static unsigned blame_copy_score;
 #define BLAME_DEFAULT_MOVE_SCORE	20
@@ -375,6 +371,13 @@ struct blame_scoreboard {
 	int num_read_blob;
 	int num_get_patch;
 	int num_commits;
+
+	/*
+	 * blame for a blame_entry with score lower than these thresholds
+	 * is not passed to the parent using move/copy logic.
+	 */
+	unsigned move_score;
+	unsigned copy_score;
 };
 
 static void sanity_check_refcnt(struct blame_scoreboard *);
@@ -1156,7 +1159,7 @@ static void find_move_in_parent(struct blame_scoreboard *sb,
 			next = e->next;
 			find_copy_in_blob(sb, e, parent, split, &file_p);
 			if (split[1].suspect &&
-			    blame_move_score < blame_entry_score(sb, &split[1])) {
+			    sb->move_score < blame_entry_score(sb, &split[1])) {
 				split_blame(blamed, &unblamedtail, split, e);
 			} else {
 				e->next = leftover;
@@ -1165,7 +1168,7 @@ static void find_move_in_parent(struct blame_scoreboard *sb,
 			decref_split(split);
 		}
 		*unblamedtail = NULL;
-		toosmall = filter_small(sb, toosmall, &unblamed, blame_move_score);
+		toosmall = filter_small(sb, toosmall, &unblamed, sb->move_score);
 	} while (unblamed);
 	target->suspects = reverse_blame(leftover, NULL);
 }
@@ -1286,7 +1289,7 @@ static void find_copy_in_parent(struct blame_scoreboard *sb,
 		for (j = 0; j < num_ents; j++) {
 			struct blame_entry *split = blame_list[j].split;
 			if (split[1].suspect &&
-			    blame_copy_score < blame_entry_score(sb, &split[1])) {
+			    sb->copy_score < blame_entry_score(sb, &split[1])) {
 				split_blame(blamed, &unblamedtail, split,
 					    blame_list[j].ent);
 			} else {
@@ -1297,7 +1300,7 @@ static void find_copy_in_parent(struct blame_scoreboard *sb,
 		}
 		free(blame_list);
 		*unblamedtail = NULL;
-		toosmall = filter_small(sb, toosmall, &unblamed, blame_copy_score);
+		toosmall = filter_small(sb, toosmall, &unblamed, sb->copy_score);
 	} while (unblamed);
 	target->suspects = reverse_blame(leftover, NULL);
 	diff_flush(&diff_opts);
@@ -1454,7 +1457,7 @@ static void pass_blame(struct blame_scoreboard *sb, struct blame_origin *origin,
 	 * Optionally find moves in parents' files.
 	 */
 	if (opt & PICKAXE_BLAME_MOVE) {
-		filter_small(sb, &toosmall, &origin->suspects, blame_move_score);
+		filter_small(sb, &toosmall, &origin->suspects, sb->move_score);
 		if (origin->suspects) {
 			for (i = 0, sg = first_scapegoat(revs, commit);
 			     i < num_sg && sg;
@@ -1473,12 +1476,12 @@ static void pass_blame(struct blame_scoreboard *sb, struct blame_origin *origin,
 	 * Optionally find copies from parents' files.
 	 */
 	if (opt & PICKAXE_BLAME_COPY) {
-		if (blame_copy_score > blame_move_score)
-			filter_small(sb, &toosmall, &origin->suspects, blame_copy_score);
-		else if (blame_copy_score < blame_move_score) {
+		if (sb->copy_score > sb->move_score)
+			filter_small(sb, &toosmall, &origin->suspects, sb->copy_score);
+		else if (sb->copy_score < sb->move_score) {
 			origin->suspects = blame_merge(origin->suspects, toosmall);
 			toosmall = NULL;
-			filter_small(sb, &toosmall, &origin->suspects, blame_copy_score);
+			filter_small(sb, &toosmall, &origin->suspects, sb->copy_score);
 		}
 		if (!origin->suspects)
 			goto finish;
@@ -2675,11 +2678,6 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 		opt |= (PICKAXE_BLAME_COPY | PICKAXE_BLAME_MOVE |
 			PICKAXE_BLAME_COPY_HARDER);
 
-	if (!blame_move_score)
-		blame_move_score = BLAME_DEFAULT_MOVE_SCORE;
-	if (!blame_copy_score)
-		blame_copy_score = BLAME_DEFAULT_COPY_SCORE;
-
 	/*
 	 * We have collected options unknown to us in argv[1..unk]
 	 * which are to be passed to revision machinery if we are
@@ -2733,6 +2731,8 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	revs.disable_stdin = 1;
 	setup_revisions(argc, argv, &revs, NULL);
 	memset(&sb, 0, sizeof(sb));
+	sb.move_score = BLAME_DEFAULT_MOVE_SCORE;
+	sb.copy_score = BLAME_DEFAULT_COPY_SCORE;
 
 	sb.revs = &revs;
 	if (!reverse) {
@@ -2871,6 +2871,11 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	sb.ent = NULL;
 	sb.path = path;
 
+	if (blame_move_score)
+		sb.move_score = blame_move_score;
+	if (blame_copy_score)
+		sb.copy_score = blame_copy_score;
+
 	read_mailmap(&mailmap, NULL);
 
 	assign_blame(&sb, opt);
-- 
2.9.3

