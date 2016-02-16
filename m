From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v5 01/12] strbuf: introduce strbuf_split_str_omit_term()
Date: Wed, 17 Feb 2016 00:30:04 +0530
Message-ID: <1455649215-23260-2-git-send-email-Karthik.188@gmail.com>
References: <1455649215-23260-1-git-send-email-Karthik.188@gmail.com>
Cc: gitster@pobox.com, sunshine@sunshineco.com,
	Karthik Nayak <Karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 16 19:59:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVkqh-00082n-By
	for gcvg-git-2@plane.gmane.org; Tue, 16 Feb 2016 19:59:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933169AbcBPS7l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2016 13:59:41 -0500
Received: from mail-pf0-f170.google.com ([209.85.192.170]:33732 "EHLO
	mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753079AbcBPS7k (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2016 13:59:40 -0500
Received: by mail-pf0-f170.google.com with SMTP id q63so109678466pfb.0
        for <git@vger.kernel.org>; Tue, 16 Feb 2016 10:59:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+XhJbC0KhQfyRsVvsNRToiCLzd0NRxflj2wZ0N8HWrg=;
        b=SeFxmoUOwj++elFPqQbn6Ky2GEiDDkL5LLw3+LHxfGNDWK59umWma/LEV7sp+PifO/
         YBZrTXBbJh2KO2kLAwu2ZKOk4zZo3ExSryLeOvJCju9WtISttQEFHvFTqjceYn8GUSKK
         2k3ZJFJWYxamxdGi35oi+o4qHbeB5NcP1bTJ3SfDT2SpaULGK7MhneAXtJj7+0NX8JN5
         16wq631F5CL3t1ssBjVtZeuNwLsh7xAIBTElFHpCjyrMRzNKVl7Mhyx0Ur1h/tRW8nB7
         vbi4lC9DJ+XS2wRLfoE5wnAd4+Md/M3ppcQ5UYVsl9fCDtgYiqUJmOINRhIp6+mYKYXJ
         ns6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+XhJbC0KhQfyRsVvsNRToiCLzd0NRxflj2wZ0N8HWrg=;
        b=jlGbpgRDolc/mQ47V3uo/hzL9LUfqHlSogw0H98W9eJswc0kDfyPydeAcvmhv0tSYt
         gSi4wLKuCgmloWSZRfd6xjmA3K5DG2iQgfFlCI4rDy5W6Dzx25gXiFjfDYONYefaN4sG
         tCmI6oZJkp+FiaXLYuE5omYgkRie6MetM/P5RSHy5FYT+A7qqHXnGkJvMQw4WZQoZQLt
         gF4NE70vjInRWMdnCjponRbMu7ZTzT5kjhKypZMk4Cnq7iiuB4SjYt/6oLTiogCbecAh
         M+zuhCgH8BXHpUUPInH42VfEm1j5WjnUxrghD9cfLi99N+XHSUQ2CyZKdIgIQXewqgJl
         bk+Q==
X-Gm-Message-State: AG10YORQTgnFAQaoaFJ/ltwWB56k5klhHVZOtrs5kcrRor4qbWUBZYj2w9xoOh65LHUEWA==
X-Received: by 10.98.64.202 with SMTP id f71mr33404689pfd.113.1455649180247;
        Tue, 16 Feb 2016 10:59:40 -0800 (PST)
Received: from ashley.localdomain ([106.51.133.38])
        by smtp.gmail.com with ESMTPSA id 27sm47469677pfh.48.2016.02.16.10.59.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 16 Feb 2016 10:59:39 -0800 (PST)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.7.1
In-Reply-To: <1455649215-23260-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286412>

The current implementation of 'strbuf_split_buf()' includes the
terminator at the end of each strbuf post splitting. Add an option
wherein we can drop the terminator if desired. In this context
introduce a wrapper function 'strbuf_split_str_omit_term()' which
splits a given string into strbufs without including the terminator.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
---
 strbuf.c | 14 +++++++++-----
 strbuf.h | 25 ++++++++++++++++---------
 2 files changed, 25 insertions(+), 14 deletions(-)

diff --git a/strbuf.c b/strbuf.c
index bab316d..4a93e2a 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -115,7 +115,7 @@ void strbuf_tolower(struct strbuf *sb)
 }
 
 struct strbuf **strbuf_split_buf(const char *str, size_t slen,
-				 int terminator, int max)
+				 int terminator, int max, int omit_term)
 {
 	struct strbuf **ret = NULL;
 	size_t nr = 0, alloc = 0;
@@ -123,14 +123,18 @@ struct strbuf **strbuf_split_buf(const char *str, size_t slen,
 
 	while (slen) {
 		int len = slen;
+		int copylen = len;
+		const char *end = NULL;
 		if (max <= 0 || nr + 1 < max) {
-			const char *end = memchr(str, terminator, slen);
-			if (end)
+			end = memchr(str, terminator, slen);
+			if (end) {
 				len = end - str + 1;
+				copylen = len - !!omit_term;
+			}
 		}
 		t = xmalloc(sizeof(struct strbuf));
-		strbuf_init(t, len);
-		strbuf_add(t, str, len);
+		strbuf_init(t, copylen);
+		strbuf_add(t, str, copylen);
 		ALLOC_GROW(ret, nr + 2, alloc);
 		ret[nr++] = t;
 		str += len;
diff --git a/strbuf.h b/strbuf.h
index f72fd14..6115e72 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -466,11 +466,12 @@ static inline int strbuf_strip_suffix(struct strbuf *sb, const char *suffix)
 /**
  * Split str (of length slen) at the specified terminator character.
  * Return a null-terminated array of pointers to strbuf objects
- * holding the substrings.  The substrings include the terminator,
- * except for the last substring, which might be unterminated if the
- * original string did not end with a terminator.  If max is positive,
- * then split the string into at most max substrings (with the last
- * substring containing everything following the (max-1)th terminator
+ * holding the substrings.  If omit_term is true, the terminator will
+ * be stripped from all substrings. Otherwise, substrings will include
+ * the terminator, except for the final substring, if the original
+ * string lacked a terminator.  If max is positive, then split the
+ * string into at most max substrings (with the last substring
+ * containing everything following the (max-1)th terminator
  * character).
  *
  * The most generic form is `strbuf_split_buf`, which takes an arbitrary
@@ -481,19 +482,25 @@ static inline int strbuf_strip_suffix(struct strbuf *sb, const char *suffix)
  * For lighter-weight alternatives, see string_list_split() and
  * string_list_split_in_place().
  */
-extern struct strbuf **strbuf_split_buf(const char *, size_t,
-					int terminator, int max);
+extern struct strbuf **strbuf_split_buf(const char *str, size_t slen,
+					int terminator, int max, int omit_term);
+
+static inline struct strbuf **strbuf_split_str_omit_term(const char *str,
+							    int terminator, int max)
+{
+	return strbuf_split_buf(str, strlen(str), terminator, max, 1);
+}
 
 static inline struct strbuf **strbuf_split_str(const char *str,
 					       int terminator, int max)
 {
-	return strbuf_split_buf(str, strlen(str), terminator, max);
+	return strbuf_split_buf(str, strlen(str), terminator, max, 0);
 }
 
 static inline struct strbuf **strbuf_split_max(const struct strbuf *sb,
 						int terminator, int max)
 {
-	return strbuf_split_buf(sb->buf, sb->len, terminator, max);
+	return strbuf_split_buf(sb->buf, sb->len, terminator, max, 0);
 }
 
 static inline struct strbuf **strbuf_split(const struct strbuf *sb,
-- 
2.7.1
