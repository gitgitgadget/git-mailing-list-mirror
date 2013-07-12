From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v2 07/19] make sure partially read index is not changed
Date: Fri, 12 Jul 2013 19:26:52 +0200
Message-ID: <1373650024-3001-8-git-send-email-t.gummerer@gmail.com>
References: <1373650024-3001-1-git-send-email-t.gummerer@gmail.com>
Cc: t.gummerer@gmail.com, trast@inf.ethz.ch, mhagger@alum.mit.edu,
	gitster@pobox.com, pclouds@gmail.com, robin.rosenberg@dewire.com,
	sunshine@sunshineco.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 12 19:28:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uxh92-0003Pd-Jf
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jul 2013 19:28:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933310Ab3GLR2c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jul 2013 13:28:32 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:42144 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932650Ab3GLR2c (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jul 2013 13:28:32 -0400
Received: by mail-pa0-f44.google.com with SMTP id lj1so9176798pab.3
        for <git@vger.kernel.org>; Fri, 12 Jul 2013 10:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=lgSTyk7FhzlyvXEjcRxvPYkrBdZPegkQqSjuGfChVEA=;
        b=QOCUWJ2RitQFC3AA/xhYBSf+9SxPBfdIHm+ABHDpdTZjCyjyTna/wdZf2mRokOr5G5
         62haksvbdSQhXmC2Ct2VcSg6JC3fCQnpTBRsxc4OyAmAFmbGIScz9aGHuLxqZqkWwLHV
         MjcIs6C4z1oG6mHd/sOuTBjCChcRZV1bs/AEqsdpMxOaiXZ5BVqnMprqfdlIcJqjxWxp
         UzKT1ofZwvGgt5pNZkguXfLHsSSVQszEvqZIsojik26miDeXFoYTebPiF9I/tl5cg+DK
         1Mch9HskvmA1gG5fUOpUn6T6JfKH3CLV73n9ixwBJW9WUFw/IT6w3Vul8WojNE3FtHJn
         Y6cQ==
X-Received: by 10.66.164.71 with SMTP id yo7mr6554300pab.92.1373650111480;
        Fri, 12 Jul 2013 10:28:31 -0700 (PDT)
Received: from localhost ([2001:470:6d:596:9227:e4ff:feea:9196])
        by mx.google.com with ESMTPSA id qb15sm49194951pab.13.2013.07.12.10.28.22
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 12 Jul 2013 10:28:30 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.453.g1dfc63d
In-Reply-To: <1373650024-3001-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230217>

A partially read index file currently cannot be written to disk.  Make
sure that never happens, by erroring out when a caller tries to change a
partially read index.  The caller is responsible for reading the whole
index when it's trying to change it later.

Forcing the caller to load the right part of the index file instead of
re-reading it when changing it, gives a bit of a performance advantage,
by avoiding to read parts of the index twice.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 builtin/update-index.c |  4 ++++
 cache.h                |  1 +
 read-cache-v2.c        |  2 ++
 read-cache.c           | 10 ++++++++++
 4 files changed, 17 insertions(+)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index 5c7762e..4c6e3a6 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -49,6 +49,8 @@ static int mark_ce_flags(const char *path, int flag, int mark)
 	int namelen = strlen(path);
 	int pos = cache_name_pos(path, namelen);
 	if (0 <= pos) {
+		if (active_cache_partially_read)
+			die("BUG: Can't change a partially read index");
 		if (mark)
 			active_cache[pos]->ce_flags |= flag;
 		else
@@ -253,6 +255,8 @@ static void chmod_path(int flip, const char *path)
 	pos = cache_name_pos(path, strlen(path));
 	if (pos < 0)
 		goto fail;
+	if (active_cache_partially_read)
+		die("BUG: Can't change a partially read index");
 	ce = active_cache[pos];
 	mode = ce->ce_mode;
 	if (!S_ISREG(mode))
diff --git a/cache.h b/cache.h
index d305d21..455b772 100644
--- a/cache.h
+++ b/cache.h
@@ -311,6 +311,7 @@ extern void free_name_hash(struct index_state *istate);
 #define active_alloc (the_index.cache_alloc)
 #define active_cache_changed (the_index.cache_changed)
 #define active_cache_tree (the_index.cache_tree)
+#define active_cache_partially_read (the_index.filter_opts)
 
 #define read_cache() read_index(&the_index)
 #define read_cache_from(path) read_index_from(&the_index, (path))
diff --git a/read-cache-v2.c b/read-cache-v2.c
index 51b618f..f3c0685 100644
--- a/read-cache-v2.c
+++ b/read-cache-v2.c
@@ -479,6 +479,8 @@ static int write_index_v2(struct index_state *istate, int newfd)
 	struct stat st;
 	struct strbuf previous_name_buf = STRBUF_INIT, *previous_name;
 
+	if (istate->filter_opts)
+		die("BUG: index: cannot write a partially read index");
 	for (i = removed = extended = 0; i < entries; i++) {
 		if (cache[i]->ce_flags & CE_REMOVE)
 			removed++;
diff --git a/read-cache.c b/read-cache.c
index 9053d43..ab716ed 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -30,6 +30,8 @@ static void replace_index_entry(struct index_state *istate, int nr, struct cache
 {
 	struct cache_entry *old = istate->cache[nr];
 
+	if (istate->filter_opts)
+		die("BUG: Can't change a partially read index");
 	remove_name_hash(istate, old);
 	set_index_entry(istate, nr, ce);
 	istate->cache_changed = 1;
@@ -467,6 +469,8 @@ int remove_index_entry_at(struct index_state *istate, int pos)
 {
 	struct cache_entry *ce = istate->cache[pos];
 
+	if (istate->filter_opts)
+		die("BUG: Can't change a partially read index");
 	record_resolve_undo(istate, ce);
 	remove_name_hash(istate, ce);
 	istate->cache_changed = 1;
@@ -973,6 +977,8 @@ int add_index_entry(struct index_state *istate, struct cache_entry *ce, int opti
 {
 	int pos;
 
+	if (istate->filter_opts)
+		die("BUG: Can't change a partially read index");
 	if (option & ADD_CACHE_JUST_APPEND)
 		pos = istate->cache_nr;
 	else {
@@ -1173,6 +1179,8 @@ int refresh_index(struct index_state *istate, unsigned int flags, const char **p
 				/* If we are doing --really-refresh that
 				 * means the index is not valid anymore.
 				 */
+				if (istate->filter_opts)
+					die("BUG: Can't change a partially read index");
 				ce->ce_flags &= ~CE_VALID;
 				istate->cache_changed = 1;
 			}
@@ -1331,6 +1339,8 @@ int read_index_filtered_from(struct index_state *istate, const char *path,
 	void *mmap;
 	size_t mmap_size;
 
+	if (istate->filter_opts)
+		die("BUG: Can't re-read partially read index");
 	errno = EBUSY;
 	if (istate->initialized)
 		return istate->cache_nr;
-- 
1.8.3.453.g1dfc63d
