From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH/RFC 06/10] strbuf: introduce strbuf_split_str_without_term()
Date: Thu, 12 Nov 2015 01:14:32 +0530
Message-ID: <1447271075-15364-7-git-send-email-Karthik.188@gmail.com>
References: <1447271075-15364-1-git-send-email-Karthik.188@gmail.com>
Cc: matthieu.moy@grenoble-inp.fr, gitster@pobox.com,
	Karthik Nayak <Karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 11 20:44:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZwbJu-00062Z-Is
	for gcvg-git-2@plane.gmane.org; Wed, 11 Nov 2015 20:44:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752552AbbKKToe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Nov 2015 14:44:34 -0500
Received: from mail-pa0-f68.google.com ([209.85.220.68]:34968 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752449AbbKKTod (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Nov 2015 14:44:33 -0500
Received: by padhk6 with SMTP id hk6so5331458pad.2
        for <git@vger.kernel.org>; Wed, 11 Nov 2015 11:44:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rdzybTloyqe+x5sZk6aNBDD10/J4o95mXsyVH1wnxq0=;
        b=XMU34qc3xGxq3gEnYGye8E8D6fKnRFyHOoSLL+e6j7Pta1zrFq0DmzxJkRxd/WqLiN
         jEWvgVU0IeSgjD6ceP8Kt8x8xB9Vts19pFkikPwXvDU6GRBjgemfxT+Yx9+9FSCzbADs
         GuN2Hvyuhf3yyvuObQ4UoGUxR51gcIo+98dncGeeRlr5NtacUX+oy7dypor8ileXsP6p
         FIcJPZkp+Fdu92aUe5zM8/JKKV9fEh48ClYFyt5ir5fhP9Bq7EI6l9OLO+OlaNRNyG0j
         URGuAyareIn5cxHyk2f2pBQ6chjk0uF2XPi1Rb4qHhJAl/BjzebWSHusEa7Tpirofltv
         Iz4A==
X-Received: by 10.68.189.1 with SMTP id ge1mr17024509pbc.42.1447271073050;
        Wed, 11 Nov 2015 11:44:33 -0800 (PST)
Received: from ashley.localdomain ([106.51.241.110])
        by smtp.gmail.com with ESMTPSA id j5sm278998pbq.74.2015.11.11.11.44.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 Nov 2015 11:44:32 -0800 (PST)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.6.2
In-Reply-To: <1447271075-15364-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281189>

The current implementation of 'strbuf_split_buf()' includes the
terminator at the end of each strbuf post splitting. Include an option
wherein we can drop the terminator if required. In this context
introduce a wrapper function 'strbuf_split_str_without_term()' which
splits a given string into strbufs without including the terminator.

Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
---
 ref-filter.c |  5 +----
 strbuf.c     | 17 +++++++++++++----
 strbuf.h     | 14 ++++++++++----
 3 files changed, 24 insertions(+), 12 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 0523d54..4e8b3c9 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -892,14 +892,11 @@ static void populate_value(struct ref_array_item *ref)
 			 * TODO: Implement a function similar to strbuf_split_str()
 			 * which would omit the separator from the end of each value.
 			 */
-			s = to_free = strbuf_split_str(valp, ',', 0);
+			s = to_free = strbuf_split_str_without_term(valp, ',', 0);
 
 			align->position = ALIGN_LEFT;
 
 			while (*s) {
-				/*  Strip trailing comma */
-				if (s[1])
-					strbuf_setlen(s[0], s[0]->len - 1);
 				if (!strtoul_ui(s[0]->buf, 10, (unsigned int *)&width))
 					;
 				else if (!strcmp(s[0]->buf, "left"))
diff --git a/strbuf.c b/strbuf.c
index b552a13..d31336f 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -115,7 +115,7 @@ void strbuf_tolower(struct strbuf *sb)
 }
 
 struct strbuf **strbuf_split_buf(const char *str, size_t slen,
-				 int terminator, int max)
+				 int terminator, int max, int with_term)
 {
 	struct strbuf **ret = NULL;
 	size_t nr = 0, alloc = 0;
@@ -123,18 +123,27 @@ struct strbuf **strbuf_split_buf(const char *str, size_t slen,
 
 	while (slen) {
 		int len = slen;
+		int term = with_term;
 		if (max <= 0 || nr + 1 < max) {
 			const char *end = memchr(str, terminator, slen);
 			if (end)
-				len = end - str + 1;
+				len = end - str + term;
+			else
+				/*  When no terminator present, we must add the last character */
+				term = 1;
 		}
 		t = xmalloc(sizeof(struct strbuf));
 		strbuf_init(t, len);
 		strbuf_add(t, str, len);
 		ALLOC_GROW(ret, nr + 2, alloc);
 		ret[nr++] = t;
-		str += len;
-		slen -= len;
+		if (!term) {
+			str += len + 1;
+			slen -= len + 1;
+		} else {
+			str += len;
+			slen -= len;
+		}
 	}
 	ALLOC_GROW(ret, nr + 1, alloc); /* In case string was empty */
 	ret[nr] = NULL;
diff --git a/strbuf.h b/strbuf.h
index 6ae7a72..63e1e69 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -465,19 +465,25 @@ static inline int strbuf_strip_suffix(struct strbuf *sb, const char *suffix)
  * For lighter-weight alternatives, see string_list_split() and
  * string_list_split_in_place().
  */
-extern struct strbuf **strbuf_split_buf(const char *, size_t,
-					int terminator, int max);
+extern struct strbuf **strbuf_split_buf(const char *str, size_t slen,
+					int terminator, int max, int with_term);
+
+static inline struct strbuf **strbuf_split_str_without_term(const char *str,
+							    int terminator, int max)
+{
+	return strbuf_split_buf(str, strlen(str), terminator, max, 0);
+}
 
 static inline struct strbuf **strbuf_split_str(const char *str,
 					       int terminator, int max)
 {
-	return strbuf_split_buf(str, strlen(str), terminator, max);
+	return strbuf_split_buf(str, strlen(str), terminator, max, 1);
 }
 
 static inline struct strbuf **strbuf_split_max(const struct strbuf *sb,
 						int terminator, int max)
 {
-	return strbuf_split_buf(sb->buf, sb->len, terminator, max);
+	return strbuf_split_buf(sb->buf, sb->len, terminator, max, 1);
 }
 
 static inline struct strbuf **strbuf_split(const struct strbuf *sb,
-- 
2.6.2
