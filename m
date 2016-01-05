From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v3 01/15] strbuf: introduce strbuf_split_str_omit_term()
Date: Tue,  5 Jan 2016 13:33:00 +0530
Message-ID: <1451980994-26865-2-git-send-email-Karthik.188@gmail.com>
References: <1451980994-26865-1-git-send-email-Karthik.188@gmail.com>
Cc: gitster@pobox.com, sunshine@sunshineco.com,
	Karthik Nayak <Karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 05 09:02:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aGMZy-0007lQ-F6
	for gcvg-git-2@plane.gmane.org; Tue, 05 Jan 2016 09:02:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751963AbcAEICv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jan 2016 03:02:51 -0500
Received: from mail-pf0-f176.google.com ([209.85.192.176]:33118 "EHLO
	mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751592AbcAEICs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jan 2016 03:02:48 -0500
Received: by mail-pf0-f176.google.com with SMTP id q63so180367165pfb.0
        for <git@vger.kernel.org>; Tue, 05 Jan 2016 00:02:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2Tn+qCrpssAHruL2Me+PHIKtbe/Kz6Qg8XtovGBusBY=;
        b=OUZW/dwhbrnV/+yxeLWdQRLR1TzqGUQz1i9rYpe8EWJgtvGB9Xa28GaAraXZ7TLSrc
         lg4e3NpV/rRV++/0dEFl+ewF0JBin+sW5VXImNXNpcf5j7mtJ0+zjKVtPb23jayllAKy
         b7+9rsK5ST7i7SNXjeANjr3+toou/8Dg0Dv3D8Hsr24LdDcSxIkk8xrkEoOWSqrsEU9g
         iRds//i8ltvHMtnU4+dnM62o3eqrzq+jlVHtrP1P/eO4iQs71gmw3m4uPjjoW9gXSRxY
         41mIEgq02TravWCLmAHMImk0G34SG64V2T1o6newJdZnaV9sAUsDasZ09/IZ/D9jGHNF
         5RQg==
X-Received: by 10.98.68.198 with SMTP id m67mr133227939pfi.56.1451980966132;
        Tue, 05 Jan 2016 00:02:46 -0800 (PST)
Received: from ashley.localdomain ([106.51.242.38])
        by smtp.gmail.com with ESMTPSA id q190sm125814275pfq.59.2016.01.05.00.02.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 05 Jan 2016 00:02:45 -0800 (PST)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.6.4
In-Reply-To: <1451980994-26865-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283352>

The current implementation of 'strbuf_split_buf()' includes the
terminator at the end of each strbuf post splitting. Add an option
wherein we can drop the terminator if desired. In this context
introduce a wrapper function 'strbuf_split_str_omit_term()' which
splits a given string into strbufs without including the terminator.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
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
index 6ae7a72..1de816d 100644
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
+ * holding the substrings.  If omit_term is true, the terminator will
+ * be stripped from all substrings. Otherwise, substrings will include
+ * the terminator, except for the final substring, if the original
+ * string lacked a terminator.  If max is positive, then split the
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
