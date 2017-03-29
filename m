Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62C7820958
	for <e@80x24.org>; Wed, 29 Mar 2017 15:54:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932265AbdC2PyZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Mar 2017 11:54:25 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:34906 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932172AbdC2PyY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Mar 2017 11:54:24 -0400
Received: by mail-qt0-f193.google.com with SMTP id r5so2538108qtb.2
        for <git@vger.kernel.org>; Wed, 29 Mar 2017 08:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kpY1LYoSa8nFjJaQRE7tGqWu6MDE7bFvDU0Z/DdPXIc=;
        b=V1FORzNm2bb40NqY0iI+FbufqBOdLblP6Vh14YoVvwuMbPP3lesYPAGbh2+5M3KHqE
         zSqJjPk/wu4LZNTas+di2lNJT7VmZMenB6bHt6EKZfE4o4Ky2k7/q6CofFPI/3CsE0EZ
         O6d56FBpscYUzIzKksCU1dyeWonUlyW1t8ME9uUgk97lhI5EJEE5or3kojRxs3EyudGZ
         t9+EFrmov1W+26TaQDZ0GZQhWKse4E4yPdG8yVz0eCogXI7Mz8P/N0hJTUzjmDALzyxV
         7K030HULryrKFfzwr3FrPWoZQu8fF0sX7TR+3naUB4p1NMZ0DU5pb5lniQJmng30HTtU
         UEtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kpY1LYoSa8nFjJaQRE7tGqWu6MDE7bFvDU0Z/DdPXIc=;
        b=LkRp+GdszkNJN2SWDECASMKDazdqxynx6xpd98do76gpykrVewabbpa7MdKx0G0YiK
         xm7Y/nqBUWLnUjvh0HptQjCarsdTinqSk/dNpxiLL5Ui4pMu0AXTuB19zgYninetbAM/
         QUqscA/Bexc08jIMEowyg0vHSoomED6EJ2w3w7fy7rKOdxr7AC+r9CVKkXftvUz1fiPm
         N04sMgqyzL6oTJWU6j/Jv8G4oC6qlqvKpjkAOhTzCpwxdOYMdh/stc40B3m/OcyrGSlF
         0e7V2xnC2cD1McDvJbhfdrCC+F/n5yhxCs0Zea8PT6tbeeJJEUbughpXeHP2loaIIVH7
         UU6w==
X-Gm-Message-State: AFeK/H33fWiKSOJ+NsA0L5lT3QECgnDroJkwm+L0Mk160hCFiDoavX4aNfoDo0oTz0Mh7w==
X-Received: by 10.200.52.246 with SMTP id x51mr1297569qtb.227.1490802862647;
        Wed, 29 Mar 2017 08:54:22 -0700 (PDT)
Received: from localhost.localdomain ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id o92sm5148566qkh.48.2017.03.29.08.54.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 29 Mar 2017 08:54:21 -0700 (PDT)
From:   Ben Peart <peartben@gmail.com>
X-Google-Original-From: Ben Peart <benpeart@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, benpeart@microsoft.com,
        christian.couder@gmail.com, larsxschneider@gmail.com
Subject: [PATCH v3 8/8] convert: Update subprocess_read_status to not die on EOF
Date:   Wed, 29 Mar 2017 11:53:30 -0400
Message-Id: <20170329155330.12860-9-benpeart@microsoft.com>
X-Mailer: git-send-email 2.12.1.gvfs.1.18.ge47db72
In-Reply-To: <20170329155330.12860-1-benpeart@microsoft.com>
References: <20170329155330.12860-1-benpeart@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Enable sub-processes to gracefully handle when the process dies by
updating subprocess_read_status to return an error on EOF instead of
dying.

Update apply_multi_file_filter to take advantage of the revised
subprocess_read_status.

Signed-off-by: Ben Peart <benpeart@microsoft.com>
---
 convert.c     | 10 ++++++++--
 sub-process.c | 10 +++++++---
 sub-process.h |  2 +-
 3 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/convert.c b/convert.c
index baa41da760..9e181e27ad 100644
--- a/convert.c
+++ b/convert.c
@@ -629,7 +629,10 @@ static int apply_multi_file_filter(const char *path, const char *src, size_t len
 	if (err)
 		goto done;
 
-	subprocess_read_status(process->out, &filter_status);
+	err = subprocess_read_status(process->out, &filter_status);
+	if (err)
+		goto done;
+
 	err = strcmp(filter_status.buf, "success");
 	if (err)
 		goto done;
@@ -638,7 +641,10 @@ static int apply_multi_file_filter(const char *path, const char *src, size_t len
 	if (err)
 		goto done;
 
-	subprocess_read_status(process->out, &filter_status);
+	err = subprocess_read_status(process->out, &filter_status);
+	if (err)
+		goto done;
+
 	err = strcmp(filter_status.buf, "success");
 
 done:
diff --git a/sub-process.c b/sub-process.c
index 2c4d27c193..202d7d0255 100644
--- a/sub-process.c
+++ b/sub-process.c
@@ -30,13 +30,15 @@ struct subprocess_entry *subprocess_find_entry(const char *cmd)
 	return hashmap_get(&subprocess_map, &key, NULL);
 }
 
-void subprocess_read_status(int fd, struct strbuf *status)
+int subprocess_read_status(int fd, struct strbuf *status)
 {
 	struct strbuf **pair;
 	char *line;
+	int len;
+
 	for (;;) {
-		line = packet_read_line(fd, NULL);
-		if (!line)
+		len = packet_read_line_gently(fd, NULL, &line);
+		if ((len == -1) || !line)
 			break;
 		pair = strbuf_split_str(line, '=', 2);
 		if (pair[0] && pair[0]->len && pair[1]) {
@@ -48,6 +50,8 @@ void subprocess_read_status(int fd, struct strbuf *status)
 		}
 		strbuf_list_free(pair);
 	}
+
+	return len == -1 ? len : 0;
 }
 
 void subprocess_stop(struct subprocess_entry *entry)
diff --git a/sub-process.h b/sub-process.h
index 0cf1760a0a..5a1eeeece0 100644
--- a/sub-process.h
+++ b/sub-process.h
@@ -41,6 +41,6 @@ static inline struct child_process *subprocess_get_child_process(
  * key/value pairs and return the value from the last "status" packet
  */
 
-void subprocess_read_status(int fd, struct strbuf *status);
+int subprocess_read_status(int fd, struct strbuf *status);
 
 #endif
-- 
2.12.1.gvfs.1.18.ge47db72

