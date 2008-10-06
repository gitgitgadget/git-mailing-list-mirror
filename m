From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH] Replace xmalloc/memset(0) pairs with xcalloc
Date: Mon, 06 Oct 2008 18:39:10 -0500
Message-ID: <48R7WYLSZ5lElWvJbfurso2ZPBQbzSCmtOgIsqTWyaA8yfW6Ndq1aA@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Oct 07 01:41:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kmzgj-0000bJ-6w
	for gcvg-git-2@gmane.org; Tue, 07 Oct 2008 01:40:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754650AbYJFXjO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Oct 2008 19:39:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753468AbYJFXjO
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Oct 2008 19:39:14 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:57507 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753109AbYJFXjN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Oct 2008 19:39:13 -0400
Received: by mail.nrlssc.navy.mil id m96NdBk6022281; Mon, 6 Oct 2008 18:39:11 -0500
X-OriginalArrivalTime: 06 Oct 2008 23:39:11.0238 (UTC) FILETIME=[BBCECA60:01C9280C]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97642>

Many call sites immediately initialize allocated memory with zero after
calling xmalloc. A single call to xcalloc can replace this two-call
sequence.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---
 builtin-merge.c          |    3 +--
 builtin-pack-objects.c   |    4 +---
 builtin-unpack-objects.c |    3 +--
 merge-tree.c             |    3 +--
 remote.c                 |    3 +--
 5 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/builtin-merge.c b/builtin-merge.c
index 5c65a58..dcf8987 100644
--- a/builtin-merge.c
+++ b/builtin-merge.c
@@ -123,8 +123,7 @@ static struct strategy *get_strategy(const char *name)
 		exit(1);
 	}
 
-	ret = xmalloc(sizeof(struct strategy));
-	memset(ret, 0, sizeof(struct strategy));
+	ret = xcalloc(1, sizeof(struct strategy));
 	ret->name = xstrdup(name);
 	return ret;
 }
diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 1158e42..59c30d1 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -1369,12 +1369,10 @@ static void find_deltas(struct object_entry **list, unsigned *list_size,
 			int window, int depth, unsigned *processed)
 {
 	uint32_t i, idx = 0, count = 0;
-	unsigned int array_size = window * sizeof(struct unpacked);
 	struct unpacked *array;
 	unsigned long mem_usage = 0;
 
-	array = xmalloc(array_size);
-	memset(array, 0, array_size);
+	array = xcalloc(window, sizeof(struct unpacked));
 
 	for (;;) {
 		struct object_entry *entry = *list++;
diff --git a/builtin-unpack-objects.c b/builtin-unpack-objects.c
index d2796b6..9f4bdd3 100644
--- a/builtin-unpack-objects.c
+++ b/builtin-unpack-objects.c
@@ -477,8 +477,7 @@ static void unpack_all(void)
 
 	if (!quiet)
 		progress = start_progress("Unpacking objects", nr_objects);
-	obj_list = xmalloc(nr_objects * sizeof(*obj_list));
-	memset(obj_list, 0, nr_objects * sizeof(*obj_list));
+	obj_list = xcalloc(nr_objects, sizeof(*obj_list));
 	for (i = 0; i < nr_objects; i++) {
 		unpack_one(i);
 		display_progress(progress, i + 1);
diff --git a/merge-tree.c b/merge-tree.c
index 02fc10f..2d1413e 100644
--- a/merge-tree.c
+++ b/merge-tree.c
@@ -158,9 +158,8 @@ static int same_entry(struct name_entry *a, struct name_entry *b)
 
 static struct merge_list *create_entry(unsigned stage, unsigned mode, const unsigned char *sha1, const char *path)
 {
-	struct merge_list *res = xmalloc(sizeof(*res));
+	struct merge_list *res = xcalloc(1, sizeof(*res));
 
-	memset(res, 0, sizeof(*res));
 	res->stage = stage;
 	res->path = path;
 	res->mode = mode;
diff --git a/remote.c b/remote.c
index c45d96e..a2d7ab1 100644
--- a/remote.c
+++ b/remote.c
@@ -751,8 +751,7 @@ int remote_find_tracking(struct remote *remote, struct refspec *refspec)
 
 struct ref *alloc_ref(unsigned namelen)
 {
-	struct ref *ret = xmalloc(sizeof(struct ref) + namelen);
-	memset(ret, 0, sizeof(struct ref) + namelen);
+	struct ref *ret = xcalloc(1, sizeof(struct ref) + namelen);
 	return ret;
 }
 
-- 
1.6.0.2.445.g1e1e0
