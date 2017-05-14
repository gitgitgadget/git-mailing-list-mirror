Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 299D620188
	for <e@80x24.org>; Sun, 14 May 2017 03:16:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758708AbdENDQV (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 May 2017 23:16:21 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:33989 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758460AbdENDQQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 May 2017 23:16:16 -0400
Received: by mail-oi0-f65.google.com with SMTP id w10so14325842oif.1
        for <git@vger.kernel.org>; Sat, 13 May 2017 20:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iBpB2fqf8FcIf1/Q/AbWfl7VhMV3whg3fgnIAVDcCdc=;
        b=ZCZQQvbvbWxMiRZ8KytXsvIbNSMoFJAyR1kG9x9th3afPnP2fopLtHVYWXET7YRsco
         uHfD6eBbLBY1C0nV7CSno6e7Ukl1Leue0DSajmLekAx6YE8oAB0C8xyGwfTX/HiqfGOi
         cphUmFIgtAKn5f6tZVZDgYsxipTdDbEXrevXH14Ppon645dV6Q1sVKCO23Do4ZA1SaNr
         ALZvQbdOl1vdzKeldL1pjlrNzJnpttdqxjny0h8nSsYccgS6u7YUccGiZBH+nny4eYL8
         gNtq3kFblTQXeXHNZEfi/xCHmG47m4IPTzSCzmx0Sr8mm7iHQGwtUcLf9/CglYeat46X
         qZMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iBpB2fqf8FcIf1/Q/AbWfl7VhMV3whg3fgnIAVDcCdc=;
        b=GTbgIgnccWrAD5SZYw6NzDqRBIundognxzINkXRr0IvLOe1/1GCYEiALTCJ+1hVocb
         BuF/f27o1m9tgsv0vcyzMsGWttSBZQQ+8MSyx4aJkCXwbjAPB7aKnQcDurw8/eY1qhqk
         MbRL2zV6pEHWBKB//MX4EYqQdSsbw+mroYgSy3VZhOhWPywYQfCi+98PqC60ZRwJ0N5r
         mfcb+tRaChyHwCidU5TfgWYx8aL5A8NmgydUREf2cEmSvjEf+G/C/wReCmBAJ8ZxwCOf
         Zr1s0Fx3XhF5HklKM6G3GfT/m1aFoacJBx1S47A/4IsYqHF+T25K4nBGyHFpBG83scgb
         YpnA==
X-Gm-Message-State: AODbwcC3LgX0HrYUQh2owLBhGQ1UpGqC6XtDFZPVWoJ81G/jRuzvO+SJ
        V3jJKVU9g1Lw2A==
X-Received: by 10.202.196.83 with SMTP id u80mr4671667oif.207.1494731775363;
        Sat, 13 May 2017 20:16:15 -0700 (PDT)
Received: from whydoubt.T-mobile.com (ip68-12-240-88.ok.ok.cox.net. [68.12.240.88])
        by smtp.gmail.com with ESMTPSA id 67sm3735193otb.53.2017.05.13.20.16.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 May 2017 20:16:14 -0700 (PDT)
From:   Jeff Smith <whydoubt@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, Jeff Smith <whydoubt@gmail.com>
Subject: [RFC PATCH v2 07/22] blame: move copy/move thresholds to scoreboard
Date:   Sat, 13 May 2017 22:14:58 -0500
Message-Id: <20170514031513.9042-8-whydoubt@gmail.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170514031513.9042-1-whydoubt@gmail.com>
References: <20170505052729.7576-1-whydoubt@gmail.com>
 <20170514031513.9042-1-whydoubt@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Copy and move score thresholds are used in parts of blame that are being
moved to libgit, and should be accessible via the scoreboard structure.

Signed-off-by: Jeff Smith <whydoubt@gmail.com>
---
 blame.h         | 10 ++++++++++
 builtin/blame.c | 36 ++++++++++++++++--------------------
 2 files changed, 26 insertions(+), 20 deletions(-)

diff --git a/blame.h b/blame.h
index 3438052..fde7d1d 100644
--- a/blame.h
+++ b/blame.h
@@ -7,6 +7,9 @@
 #include "revision.h"
 #include "prio-queue.h"
 
+#define BLAME_DEFAULT_MOVE_SCORE	20
+#define BLAME_DEFAULT_COPY_SCORE	40
+
 /*
  * One blob in a commit that is being suspected
  */
@@ -115,6 +118,13 @@ struct blame_scoreboard {
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
 
 #endif /* BLAME_H */
diff --git a/builtin/blame.c b/builtin/blame.c
index 12add06..949e179 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -67,14 +67,8 @@ static struct string_list mailmap = STRING_LIST_INIT_NODUP;
 #define PICKAXE_BLAME_COPY_HARDER	04
 #define PICKAXE_BLAME_COPY_HARDEST	010
 
-/*
- * blame for a blame_entry with score lower than these thresholds
- * is not passed to the parent using move/copy logic.
- */
 static unsigned blame_move_score;
 static unsigned blame_copy_score;
-#define BLAME_DEFAULT_MOVE_SCORE	20
-#define BLAME_DEFAULT_COPY_SCORE	40
 
 /* Remember to update object flag allocation in object.h */
 #define METAINFO_SHOWN		(1u<<12)
@@ -1047,7 +1041,7 @@ static void find_move_in_parent(struct blame_scoreboard *sb,
 			next = e->next;
 			find_copy_in_blob(sb, e, parent, split, &file_p);
 			if (split[1].suspect &&
-			    blame_move_score < ent_score(sb, &split[1])) {
+			    sb->move_score < ent_score(sb, &split[1])) {
 				split_blame(blamed, &unblamedtail, split, e);
 			} else {
 				e->next = leftover;
@@ -1056,7 +1050,7 @@ static void find_move_in_parent(struct blame_scoreboard *sb,
 			decref_split(split);
 		}
 		*unblamedtail = NULL;
-		toosmall = filter_small(sb, toosmall, &unblamed, blame_move_score);
+		toosmall = filter_small(sb, toosmall, &unblamed, sb->move_score);
 	} while (unblamed);
 	target->suspects = reverse_blame(leftover, NULL);
 }
@@ -1177,7 +1171,7 @@ static void find_copy_in_parent(struct blame_scoreboard *sb,
 		for (j = 0; j < num_ents; j++) {
 			struct blame_entry *split = blame_list[j].split;
 			if (split[1].suspect &&
-			    blame_copy_score < ent_score(sb, &split[1])) {
+			    sb->copy_score < ent_score(sb, &split[1])) {
 				split_blame(blamed, &unblamedtail, split,
 					    blame_list[j].ent);
 			} else {
@@ -1188,7 +1182,7 @@ static void find_copy_in_parent(struct blame_scoreboard *sb,
 		}
 		free(blame_list);
 		*unblamedtail = NULL;
-		toosmall = filter_small(sb, toosmall, &unblamed, blame_copy_score);
+		toosmall = filter_small(sb, toosmall, &unblamed, sb->copy_score);
 	} while (unblamed);
 	target->suspects = reverse_blame(leftover, NULL);
 	diff_flush(&diff_opts);
@@ -1345,7 +1339,7 @@ static void pass_blame(struct blame_scoreboard *sb, struct blame_origin *origin,
 	 * Optionally find moves in parents' files.
 	 */
 	if (opt & PICKAXE_BLAME_MOVE) {
-		filter_small(sb, &toosmall, &origin->suspects, blame_move_score);
+		filter_small(sb, &toosmall, &origin->suspects, sb->move_score);
 		if (origin->suspects) {
 			for (i = 0, sg = first_scapegoat(revs, commit);
 			     i < num_sg && sg;
@@ -1364,12 +1358,12 @@ static void pass_blame(struct blame_scoreboard *sb, struct blame_origin *origin,
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
@@ -2566,11 +2560,6 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
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
@@ -2624,6 +2613,8 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	revs.disable_stdin = 1;
 	setup_revisions(argc, argv, &revs, NULL);
 	memset(&sb, 0, sizeof(sb));
+	sb.move_score = BLAME_DEFAULT_MOVE_SCORE;
+	sb.copy_score = BLAME_DEFAULT_COPY_SCORE;
 
 	sb.revs = &revs;
 	if (!reverse) {
@@ -2762,6 +2753,11 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
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

