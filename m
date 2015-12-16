From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v2 01/11] strbuf: introduce strbuf_split_str_without_term()
Date: Wed, 16 Dec 2015 20:59:52 +0530
Message-ID: <1450279802-29414-2-git-send-email-Karthik.188@gmail.com>
References: <1450279802-29414-1-git-send-email-Karthik.188@gmail.com>
Cc: gitster@pobox.com, sunshine@sunshineco.com,
	Karthik Nayak <Karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 16 16:29:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9E1Z-0001Nn-Tw
	for gcvg-git-2@plane.gmane.org; Wed, 16 Dec 2015 16:29:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933803AbbLPP3o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Dec 2015 10:29:44 -0500
Received: from mail-pa0-f52.google.com ([209.85.220.52]:35650 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933118AbbLPP3m (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Dec 2015 10:29:42 -0500
Received: by mail-pa0-f52.google.com with SMTP id tl7so2904370pab.2
        for <git@vger.kernel.org>; Wed, 16 Dec 2015 07:29:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PPiyqBWFOOdFwseWPTXgxYNVCzKCSP5bh3m3bcqy2ng=;
        b=gwdJnXw+NkzfGcqxlE4c1G1HmTcVJLQwxrl+4h9l9iKqwVmoA4MG5cCgtc7xKMPkBK
         lRyAGTTgQ4ZTKVM8VPBYsOkGjeUWy6PNu0KV/TNvAoBMToJTRM/0D35gZzGZT35TSME1
         WBjk0eOi8vjQP4P0JQI4hhWeXAq8dpWyG/CAqcpWTuSkwLK+yJ2QVe+WGdmDhfnTFhfg
         O0bKlMImRXm97d9zIuD4FzOMBUaVpClRK+q9PPAFMJHwQbNClUwjL5ZeyRt9luDvE/h6
         rYkkqzbMLZBeogUryDiM6lH541GM2NU4auBZZgP08tmWatF3rkz/PmXDagQFLjsBsrNr
         MdsA==
X-Received: by 10.66.100.135 with SMTP id ey7mr64745299pab.108.1450279782099;
        Wed, 16 Dec 2015 07:29:42 -0800 (PST)
Received: from ashley.localdomain ([106.51.233.145])
        by smtp.gmail.com with ESMTPSA id x12sm5620612pfi.95.2015.12.16.07.29.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 16 Dec 2015 07:29:41 -0800 (PST)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.6.4
In-Reply-To: <1450279802-29414-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282564>

The current implementation of 'strbuf_split_buf()' includes the
terminator at the end of each strbuf post splitting. Add an option
wherein we can drop the terminator if desired. In this context
introduce a wrapper function 'strbuf_split_str_without_term()' which
splits a given string into strbufs without including the terminator.

Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
---
 strbuf.c |  7 ++++---
 strbuf.h | 25 ++++++++++++++++---------
 2 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/strbuf.c b/strbuf.c
index b552a13..b62508e 100644
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
@@ -123,14 +123,15 @@ struct strbuf **strbuf_split_buf(const char *str, size_t slen,
 
 	while (slen) {
 		int len = slen;
+		const char *end = NULL;
 		if (max <= 0 || nr + 1 < max) {
-			const char *end = memchr(str, terminator, slen);
+			end = memchr(str, terminator, slen);
 			if (end)
 				len = end - str + 1;
 		}
 		t = xmalloc(sizeof(struct strbuf));
 		strbuf_init(t, len);
-		strbuf_add(t, str, len);
+		strbuf_add(t, str, len - !!end * !!omit_term);
 		ALLOC_GROW(ret, nr + 2, alloc);
 		ret[nr++] = t;
 		str += len;
diff --git a/strbuf.h b/strbuf.h
index 6ae7a72..a865a74 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -450,11 +450,12 @@ static inline int strbuf_strip_suffix(struct strbuf *sb, const char *suffix)
 /**
  * Split str (of length slen) at the specified terminator character.
  * Return a null-terminated array of pointers to strbuf objects
- * holding the substrings.  The substrings include the terminator,
- * except for the last substring, which might be unterminated if the
- * original string did not end with a terminator.  If max is positive,
- * then split the string into at most max substrings (with the last
- * substring containing everything following the (max-1)th terminator
+ * holding the substrings.  The substrings include the terminator if
+ * the value of omit_term is '0' else the terminator is excluded.  The
+ * last substring, might be unterminated if the original string did
+ * not end with a terminator.  If max is positive, then split the
+ * string into at most max substrings (with the last substring
+ * containing everything following the (max-1)th terminator
  * character).
  *
  * The most generic form is `strbuf_split_buf`, which takes an arbitrary
@@ -465,19 +466,25 @@ static inline int strbuf_strip_suffix(struct strbuf *sb, const char *suffix)
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
2.6.4
