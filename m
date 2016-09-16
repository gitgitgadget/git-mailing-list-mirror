Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA0532070F
	for <e@80x24.org>; Fri, 16 Sep 2016 00:12:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757332AbcIPAMe (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Sep 2016 20:12:34 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:34823 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755579AbcIPAM1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Sep 2016 20:12:27 -0400
Received: by mail-qk0-f195.google.com with SMTP id w204so4450396qka.2
        for <git@vger.kernel.org>; Thu, 15 Sep 2016 17:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=YD6fJzoAIKdCqvj4wRhV86RCAkq38NFsxJcRIdRz+A4=;
        b=Gll9Zm7CaJKBPasreSuWt4buiI3I43G7rMNnUwP11zbV2arrE/GbkRk/uZSXfrtfRT
         pK0q2131Gc0DY5BRmUjQlKh+vX9mmiTRc/NbLimHed6GGlBhktVOJWGMZsBNTVXMG2lj
         NlypUIhdNF0F1zn/d3Sl6kHGi3lIuz6UP9ZaEgv197Iqt3hT+IagcgrpvTmR1IpaOK2f
         QGiJEUYAkpiiUU2xc6aFBHCTOxJGi6TFWBSEwR9GmrwU60T/Rlm1+rUv9GF0psPNXb82
         wZYGFpzjFDmIU6CkNQvcgHX+dKlabqB9IJece0pdMdGK/UsXGm1kd2ZgcA3HsQVj8vwD
         rYgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=YD6fJzoAIKdCqvj4wRhV86RCAkq38NFsxJcRIdRz+A4=;
        b=UEzNpnrJAw4zAlrRoXfiBOBUs6otRX6YtMjPi7G1Cg9/PQlTd06CajH+A3AWrMdMWU
         WTaZDAQ7x6KgrQ46EMFHRkd7nnAYRKOqpLgFCMqM3LROHCexfvf1aBg59nlsk2l6i1pe
         TnES+L5r5Yb6VUdpx6WsVQMq4vgGVI8r0BYvaZnBVnwM42nHVKXhXzsI8GQICf2+KXlp
         N7nf8EY1UYUpulQwmnqsPOIeD6ZuvH7iMbYl9A922w4h65fvI808XCrCGyFgY7Wvrs95
         5/g6gaKKdzrOCQ1U1sx7wkFEuWsg7b/BePjZdaY5MHcTTWinPYPKOIfTqXcoK9SPyDpW
         qnBw==
X-Gm-Message-State: AE9vXwNrNZG3FQf+30o886cw494MAFJc4IfwuBBgHVMlOKbh1mrMcaT1j40k7W7TubqDpA==
X-Received: by 10.55.210.67 with SMTP id f64mr13545727qkj.166.1473984746779;
        Thu, 15 Sep 2016 17:12:26 -0700 (PDT)
Received: from localhost.localdomain (ool-457850cc.dyn.optonline.net. [69.120.80.204])
        by smtp.gmail.com with ESMTPSA id d27sm3227196qtd.37.2016.09.15.17.12.26
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 Sep 2016 17:12:26 -0700 (PDT)
From:   Kevin Wern <kevin.m.wern@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH 03/11] pkt-line: create gentle packet_read_line functions
Date:   Thu, 15 Sep 2016 20:12:14 -0400
Message-Id: <1473984742-12516-4-git-send-email-kevin.m.wern@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1473984742-12516-1-git-send-email-kevin.m.wern@gmail.com>
References: <1473984742-12516-1-git-send-email-kevin.m.wern@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Create a functions that can read malformed messages without dying.
Includes creation of flag PACKET_READ_GENTLE_ALL. For use handling
prime-clone (or other server error) responses.

Signed-off-by: Kevin Wern <kevin.m.wern@gmail.com>
---
 pkt-line.c | 47 ++++++++++++++++++++++++++++++++++++++---------
 pkt-line.h | 16 ++++++++++++++++
 2 files changed, 54 insertions(+), 9 deletions(-)

diff --git a/pkt-line.c b/pkt-line.c
index 62fdb37..96060e5 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -155,13 +155,17 @@ static int get_packet_data(int fd, char **src_buf, size_t *src_size,
 		*src_size -= ret;
 	} else {
 		ret = read_in_full(fd, dst, size);
-		if (ret < 0)
+		if (ret < 0) {
+			if (options & PACKET_READ_GENTLE_ALL)
+				return -1;
+
 			die_errno("read error");
+		}
 	}
 
 	/* And complain if we didn't get enough bytes to satisfy the read. */
 	if (ret < size) {
-		if (options & PACKET_READ_GENTLE_ON_EOF)
+		if (options & (PACKET_READ_GENTLE_ON_EOF | PACKET_READ_GENTLE_ALL))
 			return -1;
 
 		die("The remote end hung up unexpectedly");
@@ -205,15 +209,23 @@ int packet_read(int fd, char **src_buf, size_t *src_len,
 	if (ret < 0)
 		return ret;
 	len = packet_length(linelen);
-	if (len < 0)
+	if (len < 0) {
+		if (options & PACKET_READ_GENTLE_ALL)
+			return -1;
+
 		die("protocol error: bad line length character: %.4s", linelen);
+	}
 	if (!len) {
 		packet_trace("0000", 4, 0);
 		return 0;
 	}
 	len -= 4;
-	if (len >= size)
+	if (len >= size) {
+		if (options & PACKET_READ_GENTLE_ALL)
+			return -1;
+
 		die("protocol error: bad line length %d", len);
+	}
 	ret = get_packet_data(fd, src_buf, src_len, buffer, len, options);
 	if (ret < 0)
 		return ret;
@@ -229,22 +241,39 @@ int packet_read(int fd, char **src_buf, size_t *src_len,
 
 static char *packet_read_line_generic(int fd,
 				      char **src, size_t *src_len,
-				      int *dst_len)
+				      int *dst_len, int flags)
 {
 	int len = packet_read(fd, src, src_len,
 			      packet_buffer, sizeof(packet_buffer),
-			      PACKET_READ_CHOMP_NEWLINE);
+			      flags);
 	if (dst_len)
 		*dst_len = len;
-	return len ? packet_buffer : NULL;
+	return len > 0 ? packet_buffer : NULL;
 }
 
 char *packet_read_line(int fd, int *len_p)
 {
-	return packet_read_line_generic(fd, NULL, NULL, len_p);
+	return packet_read_line_generic(fd, NULL, NULL, len_p,
+			PACKET_READ_CHOMP_NEWLINE);
 }
 
 char *packet_read_line_buf(char **src, size_t *src_len, int *dst_len)
 {
-	return packet_read_line_generic(-1, src, src_len, dst_len);
+	return packet_read_line_generic(-1, src, src_len, dst_len,
+			PACKET_READ_CHOMP_NEWLINE);
+}
+
+char *packet_read_line_gentle(int fd, int *len_p)
+{
+	return packet_read_line_generic(fd, NULL, NULL, len_p,
+			PACKET_READ_CHOMP_NEWLINE |
+			PACKET_READ_GENTLE_ALL);
+}
+
+
+char *packet_read_line_buf_gentle(char **src, size_t *src_len, int *dst_len)
+{
+	return packet_read_line_generic(-1, src, src_len, dst_len,
+			PACKET_READ_CHOMP_NEWLINE |
+			PACKET_READ_GENTLE_ALL);
 }
diff --git a/pkt-line.h b/pkt-line.h
index 3cb9d91..553e42e 100644
--- a/pkt-line.h
+++ b/pkt-line.h
@@ -52,11 +52,15 @@ void packet_buf_write(struct strbuf *buf, const char *fmt, ...) __attribute__((f
  * condition 4 (truncated input), but instead return -1. However, we will still
  * die for the other 3 conditions.
  *
+ * If options contains PACKET_READ_GENTLE_ALL, we will not die on any of the
+ * conditions, but return -1 instead.
+ *
  * If options contains PACKET_READ_CHOMP_NEWLINE, a trailing newline (if
  * present) is removed from the buffer before returning.
  */
 #define PACKET_READ_GENTLE_ON_EOF (1u<<0)
 #define PACKET_READ_CHOMP_NEWLINE (1u<<1)
+#define PACKET_READ_GENTLE_ALL    (1u<<2)
 int packet_read(int fd, char **src_buffer, size_t *src_len, char
 		*buffer, unsigned size, int options);
 
@@ -75,6 +79,18 @@ char *packet_read_line(int fd, int *size);
  */
 char *packet_read_line_buf(char **src_buf, size_t *src_len, int *size);
 
+/*
+ * Same as packet_read_line, but does not die on any errors (uses
+ * PACKET_READ_GENTLE_ALL).
+ */
+char *packet_read_line_gentle(int fd, int *len_p);
+
+/*
+ * Same as packet_read_line_buf, but does not die on any errors (uses
+ * PACKET_READ_GENTLE_ALL).
+ */
+char *packet_read_line_buf_gentle(char **src_buf, size_t *src_len, int *size);
+
 #define DEFAULT_PACKET_MAX 1000
 #define LARGE_PACKET_MAX 65520
 extern char packet_buffer[LARGE_PACKET_MAX];
-- 
2.7.4

