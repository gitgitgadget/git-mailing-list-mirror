Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CFDF420966
	for <e@80x24.org>; Thu, 30 Mar 2017 15:54:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934281AbdC3Pyl (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Mar 2017 11:54:41 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:35115 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933723AbdC3Pyj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Mar 2017 11:54:39 -0400
Received: by mail-qt0-f194.google.com with SMTP id r5so6773417qtb.2
        for <git@vger.kernel.org>; Thu, 30 Mar 2017 08:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=H0um1TEc3tk55mq2XeJKmNLdd8427JNu8FkUqKHwUx4=;
        b=mVmN6YVQJHsiPsLEtaBhWEFJlQ4Kt2sr9dBv3CDPLVDZgXlyFG7UDg7LeJLiAxXxRB
         vHeZ9NocSpRrpC7iNsfZ9dIyZx2QmDfPtG8xyOc9rRTO3KzhuNTe/Avr+4wNFXRYTiL5
         eOIL3zrJeqjyb1x+tQwTkRxHpltZm8us1WjPxE1yiaQ1sfbttvF2Me9bMZzj/8qoSB0P
         Wft0gxOuFM48nE844DbaVKV3YcrzozTGuomnK6euxbHQAsKzX6KcKJznFQ6zOM0VZ7jc
         sMKAdzQM2PT3NQTgWUaoQpBiOfN/UM/xn5FHBoCEHsGG+96JPahg/AKiYZ76cRtXnltY
         rIcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=H0um1TEc3tk55mq2XeJKmNLdd8427JNu8FkUqKHwUx4=;
        b=GVKvlhdf/amjVNM/wzGyEChCgSSFyty0fIrvErhx1pfhs4vEjJnWLWWE81XdCP6nte
         oh8NIoFhlopcjXaBgZDxD2+pkEohCv8VNSPWm+s4N7X+Lt2RrDuZ3GIJ5ASBYHtFa9j/
         2Y+LMGatre+S2e9MzbsNMQIhW1byA8V8HBEq7V7yVOJ/Zq5y+KGx3XnZZCHz8/9cR11V
         qfA+nBqhjZtQRQG8Y8Nd8DoGidmoNdAOpqXT5c4P/rkg/otn6jd3mkxEGyaSaPML5lU1
         Z6ER70N9W7r/TNcf0DPvXg0P/+iUYANzUSDjhfU33Horpe1bV2FSRUT7EUdPGAEeta5Q
         eojA==
X-Gm-Message-State: AFeK/H3vhipq27q50osAgny6kt0T4XKLpPJCX6YWK3qduxO9wf1/1dUI4Hes+gxkEt/5bA==
X-Received: by 10.237.49.105 with SMTP id 96mr381019qtg.291.1490889277834;
        Thu, 30 Mar 2017 08:54:37 -0700 (PDT)
Received: from localhost.localdomain ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id k5sm1665671qtb.12.2017.03.30.08.54.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 30 Mar 2017 08:54:36 -0700 (PDT)
From:   Ben Peart <peartben@gmail.com>
X-Google-Original-From: Ben Peart <benpeart@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, benpeart@microsoft.com,
        christian.couder@gmail.com, larsxschneider@gmail.com
Subject: [PATCH v4 8/8] convert: Update subprocess_read_status to not die on EOF
Date:   Thu, 30 Mar 2017 11:54:17 -0400
Message-Id: <20170330155417.8928-10-benpeart@microsoft.com>
X-Mailer: git-send-email 2.12.1.gvfs.1.18.ge47db72
In-Reply-To: <20170330155417.8928-1-benpeart@microsoft.com>
References: <20170330155417.8928-1-benpeart@microsoft.com>
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
index a9e998cd75..ce919383fa 100644
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

