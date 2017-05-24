Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,UNWANTED_LANGUAGE_BODY shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E8F120281
	for <e@80x24.org>; Wed, 24 May 2017 05:17:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S969190AbdEXFRZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 May 2017 01:17:25 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:34509 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S969167AbdEXFQ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 May 2017 01:16:58 -0400
Received: by mail-oi0-f65.google.com with SMTP id w10so31062742oif.1
        for <git@vger.kernel.org>; Tue, 23 May 2017 22:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jSA7h03Vb0AcfqE4KeYfI5yz7gHGmnjrb7K6ahNiP9s=;
        b=ZNxLkfEOrYOm8jFP0bmDozmapPNFtgUiYiIu6+GC8eTFbTgOuTiFRtwISWZYas27nH
         Yx/swgPQsfcJe/5cvNoKRLUYHz0ilTSxEeK/UH6tIfT5FCYgBN3QlM9W1e4ich9fKpFH
         SAqauWbaMQVVnkGtt/pVjOyw8/ifhAbsZx6XqJGmh+TFQdT6zMyW9WbUyubR/TvCuS4P
         uxHTfDOguhJPnLFNYil1fym1VSvJ+D2lscklhPb72ZoXhjrOxh9lxAz+fV+Pesy2+KUM
         11/vRm2B7yKMl5mad/ikmi1rpddwDdUJSvzmq7FDoE9DNHf37r7VyVFK4XMw+PUbrzcf
         NLgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jSA7h03Vb0AcfqE4KeYfI5yz7gHGmnjrb7K6ahNiP9s=;
        b=pnQ9sSm8SsYaUXCLHDMM6YppdhiVzPR5jvuPQBBbn01Kpi0JPThnfaD7MjoGvhEzLa
         9HZFot4UZdns1K4+Jg4VtNFLw8MFU7m6gtYJ5HpszSaukrrnXqkgjUumYoV0iubSr5v7
         Ww1Wi/okoUPBodevZeKjZrRLorJoSjhTnF6uFuGM3DJmUhJVd7v/PZbfduD57EKC0Rvh
         eSpCMvJIHhvasWoKOIH5g8K7q2tSP2G+CJBwJLajfBkFI2/BBSiBCRChNU73f1Skzz4h
         zFWGpPlCUHlbYl6KfRJaAvVaaduakGWK0xXxuAgDSRuER7R/QyslCDt0YBUtKsUTkWQ3
         agrg==
X-Gm-Message-State: AODbwcDDLpe/x7QosqndxXqqh6UP1ne0+H3GSP2YBsOqyea4q/6MyD4U
        0swH6aaQz6tqmGqxNVI=
X-Received: by 10.157.24.15 with SMTP id b15mr3995440ote.147.1495603002282;
        Tue, 23 May 2017 22:16:42 -0700 (PDT)
Received: from whydoubt.T-mobile.com (ip68-12-240-88.ok.ok.cox.net. [68.12.240.88])
        by smtp.gmail.com with ESMTPSA id f81sm1429917oih.1.2017.05.23.22.16.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 May 2017 22:16:41 -0700 (PDT)
From:   Jeff Smith <whydoubt@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, Jeff Smith <whydoubt@gmail.com>
Subject: [PATCH 18/29] blame: move progess updates to a scoreboard callback
Date:   Wed, 24 May 2017 00:15:26 -0500
Message-Id: <20170524051537.29978-19-whydoubt@gmail.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170524051537.29978-1-whydoubt@gmail.com>
References: <20170524051537.29978-1-whydoubt@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Allow the interface user to decide how to handle a progress update.

Signed-off-by: Jeff Smith <whydoubt@gmail.com>
---
 builtin/blame.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 1b53325..d05907b 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -391,6 +391,9 @@ struct blame_scoreboard {
 
 	/* callbacks */
 	void(*on_sanity_fail)(struct blame_scoreboard *, int);
+	void(*found_guilty_entry)(struct blame_entry *, void *);
+
+	void *found_guilty_entry_data;
 };
 
 static void sanity_check_refcnt(struct blame_scoreboard *);
@@ -1729,9 +1732,10 @@ static int emit_one_suspect_detail(struct blame_origin *suspect, int repeat)
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
 
@@ -1754,11 +1758,6 @@ static void assign_blame(struct blame_scoreboard *sb, int opt)
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
@@ -1800,7 +1799,8 @@ static void assign_blame(struct blame_scoreboard *sb, int opt)
 			suspect->guilty = 1;
 			for (;;) {
 				struct blame_entry *next = ent->next;
-				found_guilty_entry(ent, &pi);
+				if (sb->found_guilty_entry)
+					sb->found_guilty_entry(ent, sb->found_guilty_entry_data);
 				if (next) {
 					ent = next;
 					continue;
@@ -1816,8 +1816,6 @@ static void assign_blame(struct blame_scoreboard *sb, int opt)
 		if (sb->debug) /* sanity */
 			sanity_check_refcnt(sb);
 	}
-
-	stop_progress(&pi.progress);
 }
 
 static const char *format_time(timestamp_t time, const char *tz_str,
@@ -2550,6 +2548,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	char *final_commit_name = NULL;
 	enum object_type type;
 	struct commit *final_commit = NULL;
+	struct progress_info pi = { NULL, 0 };
 
 	struct string_list range_list = STRING_LIST_INIT_NODUP;
 	int output_option = 0, opt = 0;
@@ -2905,8 +2904,16 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 
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

