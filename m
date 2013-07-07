From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH 06/22] make sure partially read index is not changed
Date: Sun,  7 Jul 2013 10:11:44 +0200
Message-ID: <1373184720-29767-7-git-send-email-t.gummerer@gmail.com>
References: <1373184720-29767-1-git-send-email-t.gummerer@gmail.com>
Cc: trast@inf.ethz.ch, mhagger@alum.mit.edu, gitster@pobox.com,
	pclouds@gmail.com, robin.rosenberg@dewire.com, t.gummerer@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 07 10:13:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uvk5g-0005xI-7I
	for gcvg-git-2@plane.gmane.org; Sun, 07 Jul 2013 10:13:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751943Ab3GGINA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jul 2013 04:13:00 -0400
Received: from mail-ee0-f45.google.com ([74.125.83.45]:40949 "EHLO
	mail-ee0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751812Ab3GGIMo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jul 2013 04:12:44 -0400
Received: by mail-ee0-f45.google.com with SMTP id c1so2167314eek.32
        for <git@vger.kernel.org>; Sun, 07 Jul 2013 01:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=nvSAbTqkxXkJv4MbAYtpZJLbHXTAHC068HdHUjk0xC0=;
        b=h4oRnztVUVTlOdOWHWa/aDXVSQE7eVoJdIr6koLMRHo1u8MbbEPDyybvniVtlMRZA0
         6+8IHM79sADN4BI06MUYJ2husBtKFFTlvgYcShgoWbAHfZET12D/aLunu4Hg+UNe61d3
         jsr7by3OzJrnxY29sAuriPRm+RzpK1aLZtSB85tD1H89ft3htMozKr/nbzvKau05jTpb
         JubTwUj4iTR0MmzqS8vYA1BdQRzo4ngaG13uQmLyg6moys6Buzv2T+zG0X24KBdA2nkm
         WT35KPpufIbmH+H1wua7587ILjeIP3YwmdA1JbwUpAj1Rtdqwgf/1lLAbPM0vujWNtHv
         WTSQ==
X-Received: by 10.15.50.132 with SMTP id l4mr18979136eew.122.1373184763269;
        Sun, 07 Jul 2013 01:12:43 -0700 (PDT)
Received: from localhost (host252-23-dynamic.0-87-r.retail.telecomitalia.it. [87.0.23.252])
        by mx.google.com with ESMTPSA id c44sm30729892eeb.8.2013.07.07.01.12.41
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 07 Jul 2013 01:12:42 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.453.g1dfc63d
In-Reply-To: <1373184720-29767-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229736>

A partially read index file currently cannot be written to disk.  Make
sure that never happens, by re-reading the index file if the index file
wasn't read completely before changing the in-memory index.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 builtin/update-index.c | 4 ++++
 cache.h                | 4 +++-
 read-cache-v2.c        | 3 +++
 read-cache.c           | 8 ++++++++
 4 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index 5c7762e..03f6426 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -49,6 +49,8 @@ static int mark_ce_flags(const char *path, int flag, int mark)
 	int namelen = strlen(path);
 	int pos = cache_name_pos(path, namelen);
 	if (0 <= pos) {
+		if (active_cache_partially_read)
+			cache_change_filter_opts(NULL);
 		if (mark)
 			active_cache[pos]->ce_flags |= flag;
 		else
@@ -253,6 +255,8 @@ static void chmod_path(int flip, const char *path)
 	pos = cache_name_pos(path, strlen(path));
 	if (pos < 0)
 		goto fail;
+	if (active_cache_partially_read)
+		cache_change_filter_opts(NULL);
 	ce = active_cache[pos];
 	mode = ce->ce_mode;
 	if (!S_ISREG(mode))
diff --git a/cache.h b/cache.h
index d38dfbd..f6c3407 100644
--- a/cache.h
+++ b/cache.h
@@ -293,7 +293,8 @@ struct index_state {
 	struct cache_tree *cache_tree;
 	struct cache_time timestamp;
 	unsigned name_hash_initialized : 1,
-		 initialized : 1;
+		 initialized : 1,
+		 partially_read : 1;
 	struct hash_table name_hash;
 	struct hash_table dir_hash;
 	struct index_ops *ops;
@@ -315,6 +316,7 @@ extern void free_name_hash(struct index_state *istate);
 #define active_alloc (the_index.cache_alloc)
 #define active_cache_changed (the_index.cache_changed)
 #define active_cache_tree (the_index.cache_tree)
+#define active_cache_partially_read (the_index.partially_read)
 
 #define read_cache() read_index(&the_index)
 #define read_cache_from(path) read_index_from(&the_index, (path))
diff --git a/read-cache-v2.c b/read-cache-v2.c
index 1ed640d..2cc792d 100644
--- a/read-cache-v2.c
+++ b/read-cache-v2.c
@@ -273,6 +273,7 @@ static int read_index_v2(struct index_state *istate, void *mmap,
 		src_offset += 8;
 		src_offset += extsize;
 	}
+	istate->partially_read = 0;
 	return 0;
 unmap:
 	munmap(mmap, mmap_size);
@@ -495,6 +496,8 @@ static int write_index_v2(struct index_state *istate, int newfd)
 	struct stat st;
 	struct strbuf previous_name_buf = STRBUF_INIT, *previous_name;
 
+	if (istate->partially_read)
+		die("BUG: index: cannot write a partially read index");
 	for (i = removed = extended = 0; i < entries; i++) {
 		if (cache[i]->ce_flags & CE_REMOVE)
 			removed++;
diff --git a/read-cache.c b/read-cache.c
index b30ee75..4529fab 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -30,6 +30,8 @@ static void replace_index_entry(struct index_state *istate, int nr, struct cache
 {
 	struct cache_entry *old = istate->cache[nr];
 
+	if (istate->partially_read)
+		index_change_filter_opts(istate, NULL);
 	remove_name_hash(istate, old);
 	set_index_entry(istate, nr, ce);
 	istate->cache_changed = 1;
@@ -467,6 +469,8 @@ int remove_index_entry_at(struct index_state *istate, int pos)
 {
 	struct cache_entry *ce = istate->cache[pos];
 
+	if (istate->partially_read)
+		index_change_filter_opts(istate, NULL);
 	record_resolve_undo(istate, ce);
 	remove_name_hash(istate, ce);
 	istate->cache_changed = 1;
@@ -978,6 +982,8 @@ int add_index_entry(struct index_state *istate, struct cache_entry *ce, int opti
 {
 	int pos;
 
+	if (istate->partially_read)
+		index_change_filter_opts(istate, NULL);
 	if (option & ADD_CACHE_JUST_APPEND)
 		pos = istate->cache_nr;
 	else {
@@ -1184,6 +1190,8 @@ int refresh_index(struct index_state *istate, unsigned int flags, const char **p
 				/* If we are doing --really-refresh that
 				 * means the index is not valid anymore.
 				 */
+				if (istate->partially_read)
+					index_change_filter_opts(istate, NULL);
 				ce->ce_flags &= ~CE_VALID;
 				istate->cache_changed = 1;
 			}
-- 
1.8.3.453.g1dfc63d
