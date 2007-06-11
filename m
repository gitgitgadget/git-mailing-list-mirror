From: Jeff King <peff@peff.net>
Subject: [PATCH 1/3] refactor dir_add_name
Date: Mon, 11 Jun 2007 09:39:44 -0400
Message-ID: <20070611133944.GA7008@coredump.intra.peff.net>
References: <20070611123045.GA28814@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonas Fonseca <fonseca@diku.dk>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Jun 11 15:40:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hxk7k-0006x6-R3
	for gcvg-git@gmane.org; Mon, 11 Jun 2007 15:40:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751491AbXFKNjr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jun 2007 09:39:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751506AbXFKNjr
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jun 2007 09:39:47 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2592 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751491AbXFKNjq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2007 09:39:46 -0400
Received: (qmail 2532 invoked from network); 11 Jun 2007 13:39:58 -0000
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 11 Jun 2007 13:39:58 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 11 Jun 2007 09:39:44 -0400
Content-Disposition: inline
In-Reply-To: <20070611123045.GA28814@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49852>

This is in preparation for keeping two entry lists in the
dir object.

This patch adds and uses the alloc_grow macro, which
implements the commonly used idiom of growing a dynamic
array using the alloc_nr function (not just in dir.c, but
everywhere).

We also move creation of a dir_entry to dir_entry_new.

Signed-off-by: Jeff King <peff@peff.net>
---

If we like the alloc_grow approach, there are a lot of places where we
can drop a 3-5 line conditional into a single line. I find it much more
readable, but others may disagree.

 cache.h |    6 ++++++
 dir.c   |   23 +++++++++++------------
 2 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/cache.h b/cache.h
index 5e7381e..f771519 100644
--- a/cache.h
+++ b/cache.h
@@ -224,6 +224,12 @@ extern void verify_filename(const char *prefix, const char *name);
 extern void verify_non_filename(const char *prefix, const char *name);
 
 #define alloc_nr(x) (((x)+16)*3/2)
+#define alloc_grow(x, nr, alloc) do { \
+	if(nr >= alloc) { \
+		alloc = alloc_nr(alloc); \
+		x = xrealloc((x), alloc * sizeof(*(x))); \
+	} \
+} while(0)
 
 /* Initialize and use the cache information */
 extern int read_index(struct index_state *);
diff --git a/dir.c b/dir.c
index f543f50..e810258 100644
--- a/dir.c
+++ b/dir.c
@@ -271,27 +271,26 @@ int excluded(struct dir_struct *dir, const char *pathname)
 	return 0;
 }
 
-struct dir_entry *dir_add_name(struct dir_struct *dir, const char *pathname, int len)
-{
+static
+struct dir_entry *dir_entry_new(const char *pathname, int len) {
 	struct dir_entry *ent;
-
-	if (cache_name_pos(pathname, len) >= 0)
-		return NULL;
-
-	if (dir->nr == dir->alloc) {
-		int alloc = alloc_nr(dir->alloc);
-		dir->alloc = alloc;
-		dir->entries = xrealloc(dir->entries, alloc*sizeof(ent));
-	}
 	ent = xmalloc(sizeof(*ent) + len + 1);
 	ent->ignored = ent->ignored_dir = 0;
 	ent->len = len;
 	memcpy(ent->name, pathname, len);
 	ent->name[len] = 0;
-	dir->entries[dir->nr++] = ent;
 	return ent;
 }
 
+struct dir_entry *dir_add_name(struct dir_struct *dir, const char *pathname, int len)
+{
+	if (cache_name_pos(pathname, len) >= 0)
+		return NULL;
+
+	alloc_grow(dir->entries, dir->nr, dir->alloc);
+	return dir->entries[dir->nr++] = dir_entry_new(pathname, len);
+}
+
 enum exist_status {
 	index_nonexistent = 0,
 	index_directory,
-- 
1.5.2.1.958.gbaa74-dirty
