Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 33CDE20188
	for <e@80x24.org>; Sun, 14 May 2017 03:17:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932206AbdENDRO (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 May 2017 23:17:14 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:33493 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758302AbdENDQY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 May 2017 23:16:24 -0400
Received: by mail-oi0-f66.google.com with SMTP id h4so14344284oib.0
        for <git@vger.kernel.org>; Sat, 13 May 2017 20:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nR8l+vV84KJJk1Boc48WYZDu5iiceZ7T532WY02OzOk=;
        b=qNoMhyFqaC1I3rp1mIOGWsGiKwLQiM/cYR3vS0f4shrzYToZXo71deRs0MK4fsXeUW
         0lKG/kYiHuyhWD9cRSRhr7b5rnLuA6hEovz2+Fa7w8zfUTSHPkFGvxr2IdVV4246mgF5
         3HSA5AFZKJz+QuN4eFRoa9Zr3tYnD/khzvamA+y8GXH/gMdqOhFyP+54V6viVfcHUPMn
         n6rXGJJzf25sZRTHSToaqKSt0gkJ9L3xbV+CrwY1EBlSmIvyYzJv7bplDGQolrPtukSm
         0L9m49vfO+MWUSeDqoxXSqeC4nrATylhAnRuGlwJ5Jz92lkL9O2asW/dij57oi/RmXaj
         TXDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nR8l+vV84KJJk1Boc48WYZDu5iiceZ7T532WY02OzOk=;
        b=OiGFRd2Lt9/SAg+vzhoB8eM09yc37QMxLylihw5r0maENaoRjepVWGwT6Ca9MwMXp/
         ciMnlAz8dZCwj4uBzqGo5jcZuCdwOE7ke75Wqx2TNFkFhF+6zY2BpiqusUkaPgp7lUGQ
         x6M2uJHfJCZRiZVJGTDQG0/qxSLLxyHqhCNPDrcq0gPo7nG8C8tTGEFYBwvALOIkTDEZ
         JSidzuqAI63LSxl/IKX1Pev6ionfI9hgQcWgFPlqwwAtC4MR/tH5AglKZhna3xylCuZz
         rWuPQfESx5mf3sGhlZLniBWG0wUfm+p7Ks4HrnrI4zwH9P0AuCxEoefa27Qa8DNNpOip
         5Jqw==
X-Gm-Message-State: AODbwcC8QXb15Jf44st0LSPP8yWiedurN3IL49j85sMM935ZwRX4paHD
        ga+hZlsqmPQ9vA==
X-Received: by 10.202.83.213 with SMTP id h204mr204191oib.59.1494731783795;
        Sat, 13 May 2017 20:16:23 -0700 (PDT)
Received: from whydoubt.T-mobile.com (ip68-12-240-88.ok.ok.cox.net. [68.12.240.88])
        by smtp.gmail.com with ESMTPSA id 67sm3735193otb.53.2017.05.13.20.16.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 May 2017 20:16:22 -0700 (PDT)
From:   Jeff Smith <whydoubt@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, Jeff Smith <whydoubt@gmail.com>
Subject: [RFC PATCH v2 14/22] blame: move progess updates to a scoreboard callback
Date:   Sat, 13 May 2017 22:15:05 -0500
Message-Id: <20170514031513.9042-15-whydoubt@gmail.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170514031513.9042-1-whydoubt@gmail.com>
References: <20170505052729.7576-1-whydoubt@gmail.com>
 <20170514031513.9042-1-whydoubt@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Allow the interface user to decide how to handle a progress update.

Signed-off-by: Jeff Smith <whydoubt@gmail.com>
---
 blame.h         |  3 +++
 builtin/blame.c | 24 ++++++++++++++----------
 2 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/blame.h b/blame.h
index e85db06..a0bd91b 100644
--- a/blame.h
+++ b/blame.h
@@ -138,6 +138,9 @@ struct blame_scoreboard {
 
 	/* callbacks */
 	void(*on_sanity_fail)(struct blame_scoreboard *, int);
+	void(*found_guilty_entry)(struct blame_entry *, void *);
+
+	void *found_guilty_entry_data;
 };
 
 #endif /* BLAME_H */
diff --git a/builtin/blame.c b/builtin/blame.c
index d7b3b5a..a40f743 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -1598,9 +1598,10 @@ static int emit_one_suspect_detail(struct blame_origin *suspect, int repeat)
  * The blame_entry is found to be guilty for the range.
  * Show it in incremental output.
  */
-static void found_guilty_entry(struct blame_entry *ent,
-			   struct progress_info *pi)
+static void found_guilty_entry(struct blame_entry *ent, void *data)
 {
+	struct progress_info *pi = (struct progress_info *)data;
+
 	if (incremental) {
 		struct blame_origin *suspect = ent->suspect;
 
@@ -1623,11 +1624,6 @@ static void assign_blame(struct blame_scoreboard *sb, int opt)
 {
 	struct rev_info *revs = sb->revs;
 	struct commit *commit = prio_queue_get(&sb->commits);
-	struct progress_info pi = { NULL, 0 };
-
-	if (show_progress)
-		pi.progress = start_progress_delay(_("Blaming lines"),
-						   sb->num_lines, 50, 1);
 
 	while (commit) {
 		struct blame_entry *ent;
@@ -1669,7 +1665,8 @@ static void assign_blame(struct blame_scoreboard *sb, int opt)
 			suspect->guilty = 1;
 			for (;;) {
 				struct blame_entry *next = ent->next;
-				found_guilty_entry(ent, &pi);
+				if (sb->found_guilty_entry)
+					sb->found_guilty_entry(ent, sb->found_guilty_entry_data);
 				if (next) {
 					ent = next;
 					continue;
@@ -1685,8 +1682,6 @@ static void assign_blame(struct blame_scoreboard *sb, int opt)
 		if (sb->debug) /* sanity */
 			sanity_check_refcnt(sb);
 	}
-
-	stop_progress(&pi.progress);
 }
 
 static const char *format_time(unsigned long time, const char *tz_str,
@@ -2419,6 +2414,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	char *final_commit_name = NULL;
 	enum object_type type;
 	struct commit *final_commit = NULL;
+	struct progress_info pi = { NULL, 0 };
 
 	struct string_list range_list = STRING_LIST_INIT_NODUP;
 	int output_option = 0, opt = 0;
@@ -2774,8 +2770,16 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 
 	read_mailmap(&mailmap, NULL);
 
+	sb.found_guilty_entry = &found_guilty_entry;
+	sb.found_guilty_entry_data = &pi;
+	if (show_progress)
+		pi.progress = start_progress_delay(_("Blaming lines"),
+						   sb.num_lines, 50, 1);
+
 	assign_blame(&sb, opt);
 
+	stop_progress(&pi.progress);
+
 	if (!incremental)
 		setup_pager();
 
-- 
2.9.3

