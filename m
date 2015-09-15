From: Jeff King <peff@peff.net>
Subject: [PATCH 63/67] fsck: drop inode-sorting code
Date: Tue, 15 Sep 2015 12:14:13 -0400
Message-ID: <20150915161413.GK29753@sigill.intra.peff.net>
References: <20150915152125.GA27504@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 15 18:14:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZbssA-0000K3-1I
	for gcvg-git-2@plane.gmane.org; Tue, 15 Sep 2015 18:14:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753201AbbIOQOQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Sep 2015 12:14:16 -0400
Received: from cloud.peff.net ([50.56.180.127]:59474 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752786AbbIOQOP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Sep 2015 12:14:15 -0400
Received: (qmail 14604 invoked by uid 102); 15 Sep 2015 16:14:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 15 Sep 2015 11:14:15 -0500
Received: (qmail 8005 invoked by uid 107); 15 Sep 2015 16:14:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 15 Sep 2015 12:14:24 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 15 Sep 2015 12:14:13 -0400
Content-Disposition: inline
In-Reply-To: <20150915152125.GA27504@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277968>

Fsck tries to access loose objects in order of inode number,
with the hope that this would make cold cache access faster
on a spinning disk. This dates back to 7e8c174 (fsck-cache:
sort entries by inode number, 2005-05-02), which predates
the invention of packfiles.

These days, there's not much point in trying to optimize
cold cache for a large number of loose objects. You are much
better off to simply pack the objects, which will reduce the
disk footprint _and_ provide better locality of data access.

So while you can certainly construct pathological cases
where this code might help, it is not worth the trouble
anymore.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/fsck.c | 70 ++--------------------------------------------------------
 1 file changed, 2 insertions(+), 68 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index a019f4a..73c3596 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -39,14 +39,6 @@ static int show_dangling = 1;
 #define ERROR_REACHABLE 02
 #define ERROR_PACK 04
 
-#ifdef NO_D_INO_IN_DIRENT
-#define SORT_DIRENT 0
-#define DIRENT_SORT_HINT(de) 0
-#else
-#define SORT_DIRENT 1
-#define DIRENT_SORT_HINT(de) ((de)->d_ino)
-#endif
-
 static int fsck_config(const char *var, const char *value, void *cb)
 {
 	if (strcmp(var, "fsck.skiplist") == 0) {
@@ -373,64 +365,6 @@ static int fsck_obj_buffer(const unsigned char *sha1, enum object_type type,
 	return fsck_obj(obj);
 }
 
-/*
- * This is the sorting chunk size: make it reasonably
- * big so that we can sort well..
- */
-#define MAX_SHA1_ENTRIES (1024)
-
-struct sha1_entry {
-	unsigned long ino;
-	unsigned char sha1[20];
-};
-
-static struct {
-	unsigned long nr;
-	struct sha1_entry *entry[MAX_SHA1_ENTRIES];
-} sha1_list;
-
-static int ino_compare(const void *_a, const void *_b)
-{
-	const struct sha1_entry *a = _a, *b = _b;
-	unsigned long ino1 = a->ino, ino2 = b->ino;
-	return ino1 < ino2 ? -1 : ino1 > ino2 ? 1 : 0;
-}
-
-static void fsck_sha1_list(void)
-{
-	int i, nr = sha1_list.nr;
-
-	if (SORT_DIRENT)
-		qsort(sha1_list.entry, nr,
-		      sizeof(struct sha1_entry *), ino_compare);
-	for (i = 0; i < nr; i++) {
-		struct sha1_entry *entry = sha1_list.entry[i];
-		unsigned char *sha1 = entry->sha1;
-
-		sha1_list.entry[i] = NULL;
-		if (fsck_sha1(sha1))
-			errors_found |= ERROR_OBJECT;
-		free(entry);
-	}
-	sha1_list.nr = 0;
-}
-
-static void add_sha1_list(unsigned char *sha1, unsigned long ino)
-{
-	struct sha1_entry *entry = xmalloc(sizeof(*entry));
-	int nr;
-
-	entry->ino = ino;
-	hashcpy(entry->sha1, sha1);
-	nr = sha1_list.nr;
-	if (nr == MAX_SHA1_ENTRIES) {
-		fsck_sha1_list();
-		nr = 0;
-	}
-	sha1_list.entry[nr] = entry;
-	sha1_list.nr = ++nr;
-}
-
 static inline int is_loose_object_file(struct dirent *de,
 				       char *name, unsigned char *sha1)
 {
@@ -459,7 +393,8 @@ static void fsck_dir(int i, char *path)
 		if (is_dot_or_dotdot(de->d_name))
 			continue;
 		if (is_loose_object_file(de, name, sha1)) {
-			add_sha1_list(sha1, DIRENT_SORT_HINT(de));
+			if (fsck_sha1(sha1))
+				errors_found |= ERROR_OBJECT;
 			continue;
 		}
 		if (starts_with(de->d_name, "tmp_obj_"))
@@ -573,7 +508,6 @@ static void fsck_object_dir(const char *path)
 		display_progress(progress, i+1);
 	}
 	stop_progress(&progress);
-	fsck_sha1_list();
 }
 
 static int fsck_head_link(void)
-- 
2.6.0.rc2.408.ga2926b9
