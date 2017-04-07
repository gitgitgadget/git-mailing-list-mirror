Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF78020966
	for <e@80x24.org>; Fri,  7 Apr 2017 12:04:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933492AbdDGMEl (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Apr 2017 08:04:41 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:33312 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933147AbdDGMEd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Apr 2017 08:04:33 -0400
Received: by mail-yb0-f194.google.com with SMTP id 206so1518419ybe.0
        for <git@vger.kernel.org>; Fri, 07 Apr 2017 05:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TBeDkGC9m73cXP0i6LO+N5+egFEvjbhy/4mDcRT3gmA=;
        b=n6pysXcSSWYEr1tPXZdiC3Grw33SU9P9axcWKjqdUmSlfywahRhpnwg6xIabe8NvUx
         eyv80r1PVf6af/OPDGlXsaI3V5byOYZpg6ZVZ8EEJ15IVtIGa731eKCkz2MT2hn1ZkF6
         37VC6Nsw9nTshnQynWguLnI4JcLLukmWbnm+a0TPbbp8N7VgYVnFnMvLaCgWSabLgjuC
         CKTSMjOaIEwluOobxzSTnvQUKSlmbcMYZTNlDLq8pOBgEDVOHe9msBoetgYBMyg7DcUf
         tpfBnzXzTZXJOB75Xh0m7K9w+1EYieEjMMwhjre46vN0IqL/kl0jHZhYJAO/j21zEXcZ
         /Hgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TBeDkGC9m73cXP0i6LO+N5+egFEvjbhy/4mDcRT3gmA=;
        b=VeNCZFJrtKidmRdRMVwSx05S/uxdDJ0pDOcJ+8lsfcscA1jQWbNvXtLlTizHWJ5VN4
         C7TSOsM8L49NzjuKvQhuF6vBb0hYwFSSdyy0nxrBa9H2AKPk2MX2EMfzj/xpqIWuusPc
         eI3iMFqtVv4ASLTU27CBCgYMhUDCIypG1Zf8+UrZs0shTaUUraY3x6UPyOc4cS5RIZQm
         nCm3ZUYBOs7x5u6IJ+BzRmp03FVrkJNCplAyzCxpxbtajp0Sg61J8mByI5wZxCb74XuK
         DxjIs1wt0tzTmuMaGHacpmnYBNTUsaF2/N5BxUDm92iYlgkilngU6CuKEbBYvCcVBxAW
         /5Hw==
X-Gm-Message-State: AN3rC/67SY7OwRzr6dKZa3AI1xVLwpwSUoe0bWnT19eHEr4o3NZZDIpHngGoacO03qoF4Q==
X-Received: by 10.37.202.213 with SMTP id a204mr2300963ybg.149.1491566672315;
        Fri, 07 Apr 2017 05:04:32 -0700 (PDT)
Received: from localhost.localdomain ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id z194sm1874038ywg.73.2017.04.07.05.04.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 07 Apr 2017 05:04:31 -0700 (PDT)
From:   Ben Peart <peartben@gmail.com>
X-Google-Original-From: Ben Peart <benpeart@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, benpeart@microsoft.com,
        christian.couder@gmail.com, larsxschneider@gmail.com
Subject: [PATCH v5 8/8] convert: Update subprocess_read_status to not die on EOF
Date:   Fri,  7 Apr 2017 08:03:54 -0400
Message-Id: <20170407120354.17736-9-benpeart@microsoft.com>
X-Mailer: git-send-email 2.12.0.windows.1.33.g243d9b384c
In-Reply-To: <20170407120354.17736-1-benpeart@microsoft.com>
References: <20170407120354.17736-1-benpeart@microsoft.com>
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
index 60bb650012..c5057cafcd 100644
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
2.12.0.windows.1.31.g1548525701.dirty

