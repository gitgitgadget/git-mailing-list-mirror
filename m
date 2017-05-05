Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 50B5F207FF
	for <e@80x24.org>; Fri,  5 May 2017 15:28:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754041AbdEEP2y (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 May 2017 11:28:54 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:33248 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754836AbdEEP2w (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2017 11:28:52 -0400
Received: by mail-qt0-f196.google.com with SMTP id a46so1235017qte.0
        for <git@vger.kernel.org>; Fri, 05 May 2017 08:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jcYsBRqxRkDbiAcXJMkNDZi9wuKxsajefpkNWfZemzY=;
        b=NN9np+0Clre8B3LXAvaRoRqEGAUu9/s3w21FraWD08DE3FlnA+eaENXUlZa2ap94gj
         qjycPd4W+38RxacZ51QAW/QW2b99ZOF4p4MEifqKBXCE6LnCAFAD0ljIcbG8N6bDF712
         eHmDIIC0CAXG67/cAe5GSceRYsD/XY/2J92TVljkbT5oBBIE3uS5hhEDthwORDZEiKsj
         ABSOxGUrBF11n+76aflBDgfBJCaUZAByVCmcMrnyX0aa4jRVoKAt2rmmTZbSqmLB0t5n
         fCOapMFldniNNC+cm63Wo4R4srGynWByU8CrEmMXPEajVBESvj1EU+G1T2qJF3MPKEcR
         mdDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jcYsBRqxRkDbiAcXJMkNDZi9wuKxsajefpkNWfZemzY=;
        b=ll1hz2xIuEkfFpSzjNjiwYNvyyMt8IS3LiywRhTL5JR0ICa8boc0A+tOVIDxDp1v0r
         o/IdlLOEegfkgdr6Km0Ln7MVyJPOL9fAx0qUBQFCUgcDVixKjF2l03PaxNsJn8CHFE5R
         +/K59B8TXupvYX3Qr3IJW/+0C9vAXv1F9dTEnJdS0oLvgDOLj4coA2yynwa6tr3e5/WR
         Cg4y3sKzEM0GqovxDOt8nE/fIFQ/25kmutWznJEM6LQzc4micRrIq1gJWNGWrZzwmb0d
         HhNxxUVD/vzv5eDe8hIyg0yKedRkQ38OLF7NxDVi67CKxm8o83dkqDwUZXunZMX08Pqh
         w7oQ==
X-Gm-Message-State: AN3rC/5R1uBGDxwlnJOtkZzwE036sacK6t4iPmTHCmRiXnp7pmtaXdwS
        6su4wFNJzutyPQ==
X-Received: by 10.200.41.8 with SMTP id y8mr43123579qty.220.1493998131185;
        Fri, 05 May 2017 08:28:51 -0700 (PDT)
Received: from localhost.localdomain ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id t68sm3392792qkc.44.2017.05.05.08.28.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 05 May 2017 08:28:50 -0700 (PDT)
From:   Ben Peart <peartben@gmail.com>
X-Google-Original-From: Ben Peart <benpeart@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, benpeart@microsoft.com,
        christian.couder@gmail.com, larsxschneider@gmail.com, peff@peff.net
Subject: [PATCH v7 10/10] convert: Update subprocess_read_status to not die on EOF
Date:   Fri,  5 May 2017 11:28:02 -0400
Message-Id: <20170505152802.6724-11-benpeart@microsoft.com>
X-Mailer: git-send-email 2.12.2.gvfs.2.20.g3624a68d62.dirty
In-Reply-To: <20170505152802.6724-1-benpeart@microsoft.com>
References: <20170505152802.6724-1-benpeart@microsoft.com>
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
index acf51416d1..85238e4976 100644
--- a/convert.c
+++ b/convert.c
@@ -635,7 +635,10 @@ static int apply_multi_file_filter(const char *path, const char *src, size_t len
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
@@ -644,7 +647,10 @@ static int apply_multi_file_filter(const char *path, const char *src, size_t len
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
index 536b60cced..92f8aea70a 100644
--- a/sub-process.c
+++ b/sub-process.c
@@ -21,13 +21,15 @@ struct subprocess_entry *subprocess_find_entry(struct hashmap *hashmap, const ch
 	return hashmap_get(hashmap, &key, NULL);
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
+		if ((len < 0) || !line)
 			break;
 		pair = strbuf_split_str(line, '=', 2);
 		if (pair[0] && pair[0]->len && pair[1]) {
@@ -39,6 +41,8 @@ void subprocess_read_status(int fd, struct strbuf *status)
 		}
 		strbuf_list_free(pair);
 	}
+
+	return (len < 0) ? len : 0;
 }
 
 void subprocess_stop(struct hashmap *hashmap, struct subprocess_entry *entry)
diff --git a/sub-process.h b/sub-process.h
index a88e782bfc..7d451e1cde 100644
--- a/sub-process.h
+++ b/sub-process.h
@@ -44,6 +44,6 @@ static inline struct child_process *subprocess_get_child_process(
  * key/value pairs and return the value from the last "status" packet
  */
 
-void subprocess_read_status(int fd, struct strbuf *status);
+int subprocess_read_status(int fd, struct strbuf *status);
 
 #endif
-- 
2.12.2.gvfs.2.20.g3624a68d62.dirty

