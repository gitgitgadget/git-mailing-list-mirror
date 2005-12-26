From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] avoid asking ?alloc() for zero bytes.
Date: Mon, 26 Dec 2005 14:03:17 -0800
Message-ID: <7vslsfikii.fsf_-_@assigned-by-dhcp.cox.net>
References: <20051224121007.GA19136@mail.yhbt.net>
	<20051224121454.GC3963@mail.yhbt.net>
	<7v3bkis631.fsf@assigned-by-dhcp.cox.net>
	<20051224211546.GG3963@mail.yhbt.net>
	<Pine.LNX.4.63.0512261916440.8435@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vzmmnisix.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0512262134290.19331@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 26 23:03:31 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Er0RG-0002Kq-Nl
	for gcvg-git@gmane.org; Mon, 26 Dec 2005 23:03:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751084AbVLZWDU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Dec 2005 17:03:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751086AbVLZWDU
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Dec 2005 17:03:20 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:15770 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1751084AbVLZWDU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Dec 2005 17:03:20 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051226220106.FND20050.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 26 Dec 2005 17:01:06 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0512262134290.19331@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Mon, 26 Dec 2005 21:34:41 +0100
	(CET)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14061>

Avoid asking for zero bytes when that change simplifies overall
logic.  Later we would change the wrapper to ask for 1 byte on
platforms that return NULL for zero byte request.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 * Here is what I have now that roughly corresponds to your
   patch, which has been somewhat tested.

   The final phase of making sure we return something from
   x*alloc() is not done yet.

 diff.c              |    6 +++---
 diffcore-order.c    |    6 +++++-
 diffcore-pathspec.c |    3 +++
 index-pack.c        |   22 ++++++++++++++--------
 read-tree.c         |   17 ++++++++++-------
 tree-diff.c         |    4 ++++
 6 files changed, 39 insertions(+), 19 deletions(-)

da95c79803d90ce8eaf82b0c04dbde11c096ad87
diff --git a/diff.c b/diff.c
index c815918..bfc864d 100644
--- a/diff.c
+++ b/diff.c
@@ -504,9 +504,9 @@ static void prepare_temp_file(const char
 		}
 		if (S_ISLNK(st.st_mode)) {
 			int ret;
-			char *buf, buf_[1024];
-			buf = ((sizeof(buf_) < st.st_size) ?
-			       xmalloc(st.st_size) : buf_);
+			char buf[PATH_MAX + 1]; /* ought to be SYMLINK_MAX */
+			if (sizeof(buf) <= st.st_size)
+				die("symlink too long: %s", name);
 			ret = readlink(name, buf, st.st_size);
 			if (ret < 0)
 				die("readlink(%s)", name);
diff --git a/diffcore-order.c b/diffcore-order.c
index b381223..0bc2b22 100644
--- a/diffcore-order.c
+++ b/diffcore-order.c
@@ -105,9 +105,13 @@ static int compare_pair_order(const void
 void diffcore_order(const char *orderfile)
 {
 	struct diff_queue_struct *q = &diff_queued_diff;
-	struct pair_order *o = xmalloc(sizeof(*o) * q->nr);
+	struct pair_order *o;
 	int i;
 
+	if (!q->nr)
+		return;
+
+	o = xmalloc(sizeof(*o) * q->nr);
 	prepare_order(orderfile);
 	for (i = 0; i < q->nr; i++) {
 		o[i].pair = q->queue[i];
diff --git a/diffcore-pathspec.c b/diffcore-pathspec.c
index 68fe009..139fe88 100644
--- a/diffcore-pathspec.c
+++ b/diffcore-pathspec.c
@@ -48,6 +48,9 @@ void diffcore_pathspec(const char **path
 	for (i = 0; pathspec[i]; i++)
 		;
 	speccnt = i;
+	if (!speccnt)
+		return;
+
 	spec = xmalloc(sizeof(*spec) * speccnt);
 	for (i = 0; pathspec[i]; i++) {
 		spec[i].spec = pathspec[i];
diff --git a/index-pack.c b/index-pack.c
index d4ce3af..541d7bc 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -352,18 +352,24 @@ static int sha1_compare(const void *_a, 
 static void write_index_file(const char *index_name, unsigned char *sha1)
 {
 	struct sha1file *f;
-	struct object_entry **sorted_by_sha =
-		xcalloc(nr_objects, sizeof(struct object_entry *));
-	struct object_entry **list = sorted_by_sha;
-	struct object_entry **last = sorted_by_sha + nr_objects;
+	struct object_entry **sorted_by_sha, **list, **last;
 	unsigned int array[256];
 	int i;
 	SHA_CTX ctx;
 
-	for (i = 0; i < nr_objects; ++i)
-		sorted_by_sha[i] = &objects[i];
-	qsort(sorted_by_sha, nr_objects, sizeof(sorted_by_sha[0]),
-	      sha1_compare);
+	if (nr_objects) {
+		sorted_by_sha =
+			xcalloc(nr_objects, sizeof(struct object_entry *));
+		list = sorted_by_sha;
+		last = sorted_by_sha + nr_objects;
+		for (i = 0; i < nr_objects; ++i)
+			sorted_by_sha[i] = &objects[i];
+		qsort(sorted_by_sha, nr_objects, sizeof(sorted_by_sha[0]),
+		      sha1_compare);
+
+	}
+	else
+		sorted_by_sha = list = last = NULL;
 
 	unlink(index_name);
 	f = sha1create("%s", index_name);
diff --git a/read-tree.c b/read-tree.c
index e3b9c0d..a46c6fe 100644
--- a/read-tree.c
+++ b/read-tree.c
@@ -294,17 +294,20 @@ static int unpack_trees(merge_fn_t fn)
 {
 	int indpos = 0;
 	unsigned len = object_list_length(trees);
-	struct tree_entry_list **posns = 
-		xmalloc(len * sizeof(struct tree_entry_list *));
+	struct tree_entry_list **posns;
 	int i;
 	struct object_list *posn = trees;
 	merge_size = len;
-	for (i = 0; i < len; i++) {
-		posns[i] = ((struct tree *) posn->item)->entries;
-		posn = posn->next;
+
+	if (len) {
+		posns = xmalloc(len * sizeof(struct tree_entry_list *));
+		for (i = 0; i < len; i++) {
+			posns[i] = ((struct tree *) posn->item)->entries;
+			posn = posn->next;
+		}
+		if (unpack_trees_rec(posns, len, "", fn, &indpos))
+			return -1;
 	}
-	if (unpack_trees_rec(posns, len, "", fn, &indpos))
-		return -1;
 
 	if (trivial_merges_only && nontrivial_merge)
 		die("Merge requires file-level merging");
diff --git a/tree-diff.c b/tree-diff.c
index 0ef06a9..382092b 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -263,6 +263,10 @@ void diff_tree_setup_paths(const char **
 
 		paths = p;
 		nr_paths = count_paths(paths);
+		if (nr_paths == 0) {
+			pathlens = NULL;
+			return;
+		}
 		pathlens = xmalloc(nr_paths * sizeof(int));
 		for (i=0; i<nr_paths; i++)
 			pathlens[i] = strlen(paths[i]);
-- 
1.0.GIT
