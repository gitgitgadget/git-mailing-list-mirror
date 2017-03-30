Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D16A20966
	for <e@80x24.org>; Thu, 30 Mar 2017 15:54:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934301AbdC3Pyq (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Mar 2017 11:54:46 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:33017 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934029AbdC3Pyc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Mar 2017 11:54:32 -0400
Received: by mail-qk0-f196.google.com with SMTP id p22so6885987qka.0
        for <git@vger.kernel.org>; Thu, 30 Mar 2017 08:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qcLzqfh2e2/0i+j4OPVV3IuZMufQ5C/UAyI14hbgVjo=;
        b=bLolCtandBEZKsvS8L9qZdGZXIWFI8wKlsrgWSeTlAMNisPDwMkE1Otme1dHxJT5aI
         xLBDNnXFw9JtnJ/ptxMsEn0SXUEZNt9ThDoafCI0eidrsO6fWF80iGVL8cRjyXJ9DjWj
         Es8AkbSaDicI4IJTpLMQJBJ0P8rAnIbLwu0qKOGOK7Mnuf8NOoHadrKuCPaR4SCExx9v
         GQwS811s8aQNcgkXysZLWaVvcEkx6ilv7jVMDwbjCKqO7GgnK78nNDCTPX2G2oBIzAIv
         DrT9i1LyiGss11ir12XFVexAGvn70pfjF7ZQ8vwWOqBMSiWJVDGnGi9eL0VyQ+RB5LJo
         xghQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qcLzqfh2e2/0i+j4OPVV3IuZMufQ5C/UAyI14hbgVjo=;
        b=fyAlWTEnaoNbIjpEW5ODcG+jNptj0AtIrw770VLkEDaB/T2gNpVft4KyreGbs9T4Gv
         qYhtichU7h+mDw0wM/yCUuoEBiDN9iwDrQumH9snL07qQ7JHfWz9+njSrgEZMzRheq8P
         mYRXHWTFcFouITunNSyMnhMXxPY7enIMFxhpatgJJiv0rmYZqHMuK7pxqHvG8cwbHYTk
         OPNVMo/fH6V9mnx4uve2oCrRjgvqLweJVO8//5lGajY4SyM7Pm4A6h123vJhYBSKZvx4
         dgDlwxbfpT9kb2gCba/XHMvkwpf3on3XL+4PVh3Fwgz4SeoBtyF8zoajIiV90TFUmm28
         pDdw==
X-Gm-Message-State: AFeK/H2QanWoozx573MD56tj5RLkmbi1UKngQgPioTo8YfSs7C3w5mH7dRSQFdND+uzbLQ==
X-Received: by 10.55.88.66 with SMTP id m63mr443157qkb.270.1490889270718;
        Thu, 30 Mar 2017 08:54:30 -0700 (PDT)
Received: from localhost.localdomain ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id k5sm1665671qtb.12.2017.03.30.08.54.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 30 Mar 2017 08:54:30 -0700 (PDT)
From:   Ben Peart <peartben@gmail.com>
X-Google-Original-From: Ben Peart <benpeart@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, benpeart@microsoft.com,
        christian.couder@gmail.com, larsxschneider@gmail.com
Subject: [PATCH v4 2/8] convert: move packet_write_list() into pkt-line as packet_writel()
Date:   Thu, 30 Mar 2017 11:54:11 -0400
Message-Id: <20170330155417.8928-4-benpeart@microsoft.com>
X-Mailer: git-send-email 2.12.1.gvfs.1.18.ge47db72
In-Reply-To: <20170330155417.8928-1-benpeart@microsoft.com>
References: <20170330155417.8928-1-benpeart@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add packet_writel() which writes multiple lines in a single call and
then calls packet_flush_gently(). Update convert.c to use the new
packet_writel() function from pkt-line.

Signed-off-by: Ben Peart <benpeart@microsoft.com>
---
 convert.c  | 23 ++---------------------
 pkt-line.c | 19 +++++++++++++++++++
 pkt-line.h |  1 +
 3 files changed, 22 insertions(+), 21 deletions(-)

diff --git a/convert.c b/convert.c
index 8d652bf27c..793c29ebfd 100644
--- a/convert.c
+++ b/convert.c
@@ -521,25 +521,6 @@ static struct cmd2process *find_multi_file_filter_entry(struct hashmap *hashmap,
 	return hashmap_get(hashmap, &key, NULL);
 }
 
-static int packet_write_list(int fd, const char *line, ...)
-{
-	va_list args;
-	int err;
-	va_start(args, line);
-	for (;;) {
-		if (!line)
-			break;
-		if (strlen(line) > LARGE_PACKET_DATA_MAX)
-			return -1;
-		err = packet_write_fmt_gently(fd, "%s\n", line);
-		if (err)
-			return err;
-		line = va_arg(args, const char*);
-	}
-	va_end(args);
-	return packet_flush_gently(fd);
-}
-
 static void read_multi_file_filter_status(int fd, struct strbuf *status)
 {
 	struct strbuf **pair;
@@ -616,7 +597,7 @@ static struct cmd2process *start_multi_file_filter(struct hashmap *hashmap, cons
 
 	sigchain_push(SIGPIPE, SIG_IGN);
 
-	err = packet_write_list(process->in, "git-filter-client", "version=2", NULL);
+	err = packet_writel(process->in, "git-filter-client", "version=2", NULL);
 	if (err)
 		goto done;
 
@@ -632,7 +613,7 @@ static struct cmd2process *start_multi_file_filter(struct hashmap *hashmap, cons
 	if (err)
 		goto done;
 
-	err = packet_write_list(process->in, "capability=clean", "capability=smudge", NULL);
+	err = packet_writel(process->in, "capability=clean", "capability=smudge", NULL);
 
 	for (;;) {
 		cap_buf = packet_read_line(process->out, NULL);
diff --git a/pkt-line.c b/pkt-line.c
index 58842544b4..2788aa1af6 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -171,6 +171,25 @@ int packet_write_fmt_gently(int fd, const char *fmt, ...)
 	return status;
 }
 
+int packet_writel(int fd, const char *line, ...)
+{
+	va_list args;
+	int err;
+	va_start(args, line);
+	for (;;) {
+		if (!line)
+			break;
+		if (strlen(line) > LARGE_PACKET_DATA_MAX)
+			return -1;
+		err = packet_write_fmt_gently(fd, "%s\n", line);
+		if (err)
+			return err;
+		line = va_arg(args, const char*);
+	}
+	va_end(args);
+	return packet_flush_gently(fd);
+}
+
 static int packet_write_gently(const int fd_out, const char *buf, size_t size)
 {
 	static char packet_write_buffer[LARGE_PACKET_MAX];
diff --git a/pkt-line.h b/pkt-line.h
index 12b18991f6..cb3eda9695 100644
--- a/pkt-line.h
+++ b/pkt-line.h
@@ -25,6 +25,7 @@ void packet_buf_flush(struct strbuf *buf);
 void packet_buf_write(struct strbuf *buf, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
 int packet_flush_gently(int fd);
 int packet_write_fmt_gently(int fd, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
+int packet_writel(int fd, const char *line, ...);
 int write_packetized_from_fd(int fd_in, int fd_out);
 int write_packetized_from_buf(const char *src_in, size_t len, int fd_out);
 
-- 
2.12.1.gvfs.1.18.ge47db72

