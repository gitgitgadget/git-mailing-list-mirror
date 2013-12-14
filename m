From: Antoine Pelisse <apelisse@gmail.com>
Subject: [PATCH] Prevent buffer overflows when path is too long
Date: Sat, 14 Dec 2013 12:31:16 +0100
Message-ID: <1387020676-5569-1-git-send-email-apelisse@gmail.com>
References: <xmqqwqjvuelv.fsf@gitster.dls.corp.google.com>
Cc: Antoine Pelisse <apelisse@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 14 12:31:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VrnRT-0005l0-Tw
	for gcvg-git-2@plane.gmane.org; Sat, 14 Dec 2013 12:31:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752993Ab3LNLb1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Dec 2013 06:31:27 -0500
Received: from mail-we0-f172.google.com ([74.125.82.172]:33913 "EHLO
	mail-we0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752794Ab3LNLb0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Dec 2013 06:31:26 -0500
Received: by mail-we0-f172.google.com with SMTP id w62so2905740wes.3
        for <git@vger.kernel.org>; Sat, 14 Dec 2013 03:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=feEVsA6A9EGv211ZSc1N52ogP8kPVY8m0fwAwxnd6Ew=;
        b=M4bkbbH84J2TLNJQ2+sXn17cDTMRV2duyN7D2dSP+M5DmakE3H9ewIo5ZP3bi83kg8
         lYmrTxk3Mj+oTL7iLVH0beP65Soc8AKXO0k1VtZzfF+osIMYqKP2YdPWNNv0Tzl7WHC3
         nOj5U/Qyf+7/p5TGMXbD6Gy87CeoOx4dNAHDK8/7B+81x31xcG3w2Flgo0HV/XID2a+7
         ZoKBR3L08n9adC2H/iuydZZ8eG58AK1VCMgOnig0CSh2pTv4puQK+JZ9mwrStMWpWAHB
         l1h1QrGtyj5BeSWi1EShUzTWWMldD34Tjvv2FExiffPynaeyejOfc3H5BIo4iie8IlVV
         8H7g==
X-Received: by 10.180.189.6 with SMTP id ge6mr5996408wic.1.1387020685252;
        Sat, 14 Dec 2013 03:31:25 -0800 (PST)
Received: from localhost.localdomain (freepel.fr. [82.247.80.218])
        by mx.google.com with ESMTPSA id xl18sm6229068wib.9.2013.12.14.03.31.22
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 14 Dec 2013 03:31:23 -0800 (PST)
X-Mailer: git-send-email 1.8.5.1.94.g19422b2
In-Reply-To: <xmqqwqjvuelv.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239305>

Some buffers created with PATH_MAX length are not checked when being
written, and can overflow if PATH_MAX is not big enough to hold the
path.

Replace those buffers by strbufs so that their size is automatically
grown if necessary. They are created as static local variables to avoid
reallocating memory on each call. Note that prefix_filename() returns
this static buffer so each callers should copy or use the string
immediately (this is currently true).

Reported-by: Wataru Noguchi <wnoguchi.0727@gmail.com>
Signed-off-by: Antoine Pelisse <apelisse@gmail.com>
---
 abspath.c        | 16 +++++++++-------
 diffcore-order.c | 11 ++++++-----
 unpack-trees.c   | 51 +++++++++++++++++++++++++++------------------------
 3 files changed, 42 insertions(+), 36 deletions(-)

diff --git a/abspath.c b/abspath.c
index e390994..9c908e3 100644
--- a/abspath.c
+++ b/abspath.c
@@ -215,23 +215,25 @@ const char *absolute_path(const char *path)
  */
 const char *prefix_filename(const char *pfx, int pfx_len, const char *arg)
 {
-	static char path[PATH_MAX];
+	static struct strbuf path = STRBUF_INIT;
 #ifndef GIT_WINDOWS_NATIVE
 	if (!pfx_len || is_absolute_path(arg))
 		return arg;
-	memcpy(path, pfx, pfx_len);
-	strcpy(path + pfx_len, arg);
+	strbuf_reset(&path);
+	strbuf_add(&path, pfx, pfx_len);
+	strbuf_addstr(&path, arg);
 #else
 	char *p;
 	/* don't add prefix to absolute paths, but still replace '\' by '/' */
+	strbuf_reset(&path);
 	if (is_absolute_path(arg))
 		pfx_len = 0;
 	else if (pfx_len)
-		memcpy(path, pfx, pfx_len);
-	strcpy(path + pfx_len, arg);
-	for (p = path + pfx_len; *p; p++)
+		strbuf_add(&path, pfx, pfx_len);
+	strbuf_addstr(&path, arg);
+	for (p = path.buf + pfx_len; *p; p++)
 		if (*p == '\\')
 			*p = '/';
 #endif
-	return path;
+	return path.buf;
 }
diff --git a/diffcore-order.c b/diffcore-order.c
index 23e9385..50c089b 100644
--- a/diffcore-order.c
+++ b/diffcore-order.c
@@ -73,15 +73,16 @@ struct pair_order {
 static int match_order(const char *path)
 {
 	int i;
-	char p[PATH_MAX];
+	static struct strbuf p = STRBUF_INIT;
 
 	for (i = 0; i < order_cnt; i++) {
-		strcpy(p, path);
-		while (p[0]) {
+		strbuf_reset(&p);
+		strbuf_addstr(&p, path);
+		while (p.buf[0]) {
 			char *cp;
-			if (!fnmatch(order[i], p, 0))
+			if (!fnmatch(order[i], p.buf, 0))
 				return i;
-			cp = strrchr(p, '/');
+			cp = strrchr(p.buf, '/');
 			if (!cp)
 				break;
 			*cp = 0;
diff --git a/unpack-trees.c b/unpack-trees.c
index ad3e9a0..164354d 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -830,23 +830,24 @@ static int unpack_callback(int n, unsigned long mask, unsigned long dirmask, str
 }
 
 static int clear_ce_flags_1(struct cache_entry **cache, int nr,
-			    char *prefix, int prefix_len,
+			    struct strbuf *prefix,
 			    int select_mask, int clear_mask,
 			    struct exclude_list *el, int defval);
 
 /* Whole directory matching */
 static int clear_ce_flags_dir(struct cache_entry **cache, int nr,
-			      char *prefix, int prefix_len,
+			      struct strbuf *prefix,
 			      char *basename,
 			      int select_mask, int clear_mask,
 			      struct exclude_list *el, int defval)
 {
 	struct cache_entry **cache_end;
 	int dtype = DT_DIR;
-	int ret = is_excluded_from_list(prefix, prefix_len,
+	int ret = is_excluded_from_list(prefix->buf, prefix->len,
 					basename, &dtype, el);
+	int rc;
 
-	prefix[prefix_len++] = '/';
+	strbuf_addch(prefix, '/');
 
 	/* If undecided, use matching result of parent dir in defval */
 	if (ret < 0)
@@ -854,7 +855,7 @@ static int clear_ce_flags_dir(struct cache_entry **cache, int nr,
 
 	for (cache_end = cache; cache_end != cache + nr; cache_end++) {
 		struct cache_entry *ce = *cache_end;
-		if (strncmp(ce->name, prefix, prefix_len))
+		if (strncmp(ce->name, prefix->buf, prefix->len))
 			break;
 	}
 
@@ -865,10 +866,12 @@ static int clear_ce_flags_dir(struct cache_entry **cache, int nr,
 	 * calling clear_ce_flags_1(). That function will call
 	 * the expensive is_excluded_from_list() on every entry.
 	 */
-	return clear_ce_flags_1(cache, cache_end - cache,
-				prefix, prefix_len,
-				select_mask, clear_mask,
-				el, ret);
+	rc = clear_ce_flags_1(cache, cache_end - cache,
+			      prefix,
+			      select_mask, clear_mask,
+			      el, ret);
+	strbuf_setlen(prefix, prefix->len - 1);
+	return rc;
 }
 
 /*
@@ -887,7 +890,7 @@ static int clear_ce_flags_dir(struct cache_entry **cache, int nr,
  * Top level path has prefix_len zero.
  */
 static int clear_ce_flags_1(struct cache_entry **cache, int nr,
-			    char *prefix, int prefix_len,
+			    struct strbuf *prefix,
 			    int select_mask, int clear_mask,
 			    struct exclude_list *el, int defval)
 {
@@ -907,10 +910,10 @@ static int clear_ce_flags_1(struct cache_entry **cache, int nr,
 			continue;
 		}
 
-		if (prefix_len && strncmp(ce->name, prefix, prefix_len))
+		if (prefix->len && strncmp(ce->name, prefix->buf, prefix->len))
 			break;
 
-		name = ce->name + prefix_len;
+		name = ce->name + prefix->len;
 		slash = strchr(name, '/');
 
 		/* If it's a directory, try whole directory match first */
@@ -918,29 +921,26 @@ static int clear_ce_flags_1(struct cache_entry **cache, int nr,
 			int processed;
 
 			len = slash - name;
-			memcpy(prefix + prefix_len, name, len);
+			strbuf_add(prefix, name, len);
 
-			/*
-			 * terminate the string (no trailing slash),
-			 * clear_c_f_dir needs it
-			 */
-			prefix[prefix_len + len] = '\0';
 			processed = clear_ce_flags_dir(cache, cache_end - cache,
-						       prefix, prefix_len + len,
-						       prefix + prefix_len,
+						       prefix,
+						       prefix->buf + prefix->len - len,
 						       select_mask, clear_mask,
 						       el, defval);
 
 			/* clear_c_f_dir eats a whole dir already? */
 			if (processed) {
 				cache += processed;
+				strbuf_setlen(prefix, prefix->len - len);
 				continue;
 			}
 
-			prefix[prefix_len + len++] = '/';
+			strbuf_addch(prefix, '/');
 			cache += clear_ce_flags_1(cache, cache_end - cache,
-						  prefix, prefix_len + len,
+						  prefix,
 						  select_mask, clear_mask, el, defval);
+			strbuf_setlen(prefix, prefix->len - len - 1);
 			continue;
 		}
 
@@ -961,9 +961,12 @@ static int clear_ce_flags(struct cache_entry **cache, int nr,
 			    int select_mask, int clear_mask,
 			    struct exclude_list *el)
 {
-	char prefix[PATH_MAX];
+	static struct strbuf prefix = STRBUF_INIT;
+
+	strbuf_reset(&prefix);
+
 	return clear_ce_flags_1(cache, nr,
-				prefix, 0,
+				&prefix,
 				select_mask, clear_mask,
 				el, 0);
 }
-- 
1.8.5.1.94.g19422b2
