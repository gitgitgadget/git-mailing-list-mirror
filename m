From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Avoid allocating 0 bytes, was Re: [PATCH 4/4] git-compat-util.h:
 dietlibc-friendly x{malloc,realloc,calloc}
Date: Mon, 26 Dec 2005 19:16:52 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0512261916440.8435@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20051224121007.GA19136@mail.yhbt.net> <20051224121454.GC3963@mail.yhbt.net>
 <7v3bkis631.fsf@assigned-by-dhcp.cox.net> <20051224211546.GG3963@mail.yhbt.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 26 19:17:06 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eqwu7-0004g0-GI
	for gcvg-git@gmane.org; Mon, 26 Dec 2005 19:17:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932080AbVLZSQ7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Dec 2005 13:16:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932081AbVLZSQ7
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Dec 2005 13:16:59 -0500
Received: from mail.gmx.net ([213.165.64.21]:4012 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932080AbVLZSQ7 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Dec 2005 13:16:59 -0500
Received: (qmail invoked by alias); 26 Dec 2005 18:16:57 -0000
Received: from lxweb002.wuerzburg.citynet.de (EHLO localhost) [81.209.129.202]
  by mail.gmx.net (mp011) with SMTP; 26 Dec 2005 19:16:57 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Eric Wong <normalperson@yhbt.net>
In-Reply-To: <20051224211546.GG3963@mail.yhbt.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14057>


This is the result of a relatively quick audit of the source code. There
might still be a few odd places lurking out there, but I am quite certain
I caught most if not all.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

 csum-file.c         |    3 +++
 diff.c              |    6 +++--
 diffcore-order.c    |    8 ++++++-
 diffcore-pathspec.c |   12 +++++++----
 index-pack.c        |   11 ++++++----
 pack-objects.c      |    6 ++++-
 read-tree.c         |   17 +++++++++------
 sha1_file.c         |   56 ++++++++++++++++++++++++++-------------------------
 tree-diff.c         |    4 ++++
 unpack-objects.c    |    2 +-
 10 files changed, 76 insertions(+), 49 deletions(-)

751737aeec4dd3cc1afd1d1d3fa529cfc74535e0
diff --git a/csum-file.c b/csum-file.c
index 5f9249a..2c0f097 100644
--- a/csum-file.c
+++ b/csum-file.c
@@ -121,6 +121,9 @@ int sha1write_compressed(struct sha1file
 	unsigned long maxsize;
 	void *out;
 
+	if (size == 0)
+		return 0;
+
 	memset(&stream, 0, sizeof(stream));
 	deflateInit(&stream, Z_DEFAULT_COMPRESSION);
 	maxsize = deflateBound(&stream, size);
diff --git a/diff.c b/diff.c
index c815918..daee05b 100644
--- a/diff.c
+++ b/diff.c
@@ -504,9 +504,9 @@ static void prepare_temp_file(const char
 		}
 		if (S_ISLNK(st.st_mode)) {
 			int ret;
-			char *buf, buf_[1024];
-			buf = ((sizeof(buf_) < st.st_size) ?
-			       xmalloc(st.st_size) : buf_);
+			char buf[MAXPATHLEN + 1];
+			if (st.st_size > MAXPATHLEN)
+				die("Unbelievably long symlink: %", name);
 			ret = readlink(name, buf, st.st_size);
 			if (ret < 0)
 				die("readlink(%s)", name);
diff --git a/diffcore-order.c b/diffcore-order.c
index b381223..94a4996 100644
--- a/diffcore-order.c
+++ b/diffcore-order.c
@@ -61,6 +61,8 @@ static void prepare_order(const char *or
 		}
 		if (pass == 0) {
 			order_cnt = cnt;
+			if (cnt == 0)
+				return;
 			order = xmalloc(sizeof(*order) * cnt);
 		}
 	}
@@ -105,9 +107,13 @@ static int compare_pair_order(const void
 void diffcore_order(const char *orderfile)
 {
 	struct diff_queue_struct *q = &diff_queued_diff;
-	struct pair_order *o = xmalloc(sizeof(*o) * q->nr);
+	struct pair_order *o;
 	int i;
 
+	if (q->nr == 0)
+		return;
+
+	o = xmalloc(sizeof(*o) * q->nr);
 	prepare_order(orderfile);
 	for (i = 0; i < q->nr; i++) {
 		o[i].pair = q->queue[i];
diff --git a/diffcore-pathspec.c b/diffcore-pathspec.c
index 68fe009..a12337a 100644
--- a/diffcore-pathspec.c
+++ b/diffcore-pathspec.c
@@ -48,10 +48,14 @@ void diffcore_pathspec(const char **path
 	for (i = 0; pathspec[i]; i++)
 		;
 	speccnt = i;
-	spec = xmalloc(sizeof(*spec) * speccnt);
-	for (i = 0; pathspec[i]; i++) {
-		spec[i].spec = pathspec[i];
-		spec[i].len = strlen(pathspec[i]);
+	if (speccnt == 0)
+		spec = NULL;
+	else {
+		spec = xmalloc(sizeof(*spec) * speccnt);
+		for (i = 0; pathspec[i]; i++) {
+			spec[i].spec = pathspec[i];
+			spec[i].len = strlen(pathspec[i]);
+		}
 	}
 
 	for (i = 0; i < q->nr; i++) {
diff --git a/index-pack.c b/index-pack.c
index d4ce3af..2927632 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -103,7 +103,7 @@ static void *unpack_entry_data(unsigned 
 	unsigned long pack_limit = pack_size - 20;
 	unsigned long pos = *current_pos;
 	z_stream stream;
-	void *buf = xmalloc(size);
+	void *buf = xmalloc(size ? size : 1);
 
 	memset(&stream, 0, sizeof(stream));
 	stream.next_out = buf;
@@ -353,7 +353,8 @@ static void write_index_file(const char 
 {
 	struct sha1file *f;
 	struct object_entry **sorted_by_sha =
-		xcalloc(nr_objects, sizeof(struct object_entry *));
+		xcalloc(nr_objects ? nr_objects : 1,
+				sizeof(struct object_entry *));
 	struct object_entry **list = sorted_by_sha;
 	struct object_entry **last = sorted_by_sha + nr_objects;
 	unsigned int array[256];
@@ -448,8 +449,10 @@ int main(int argc, char **argv)
 
 	open_pack_file();
 	parse_pack_header();
-	objects = xcalloc(nr_objects, sizeof(struct object_entry));
-	deltas = xcalloc(nr_objects, sizeof(struct delta_entry));
+	objects = xcalloc(nr_objects ? nr_objects : 1,
+			sizeof(struct object_entry));
+	deltas = xcalloc(nr_objects ? nr_objects : 1,
+			sizeof(struct delta_entry));
 	parse_pack_objects();
 	free(deltas);
 	write_index_file(index_name, sha1);
diff --git a/pack-objects.c b/pack-objects.c
index caf3b6b..f5a147f 100644
--- a/pack-objects.c
+++ b/pack-objects.c
@@ -406,7 +406,8 @@ static void prepare_pack(int window, int
 
 	fprintf(stderr, "Packing %d objects\n", nr_objects);
 
-	sorted_by_type = create_sorted_list(type_size_sort);
+	if (nr_objects > 0)
+		sorted_by_type = create_sorted_list(type_size_sort);
 	if (window && depth)
 		find_deltas(sorted_by_type, window+1, depth);
 	write_pack_file();
@@ -540,7 +541,8 @@ int main(int argc, char **argv)
 	if (non_empty && !nr_objects)
 		return 0;
 
-	sorted_by_sha = create_sorted_list(sha1_sort);
+	if (nr_objects > 0)
+		sorted_by_sha = create_sorted_list(sha1_sort);
 	SHA1_Init(&ctx);
 	list = sorted_by_sha;
 	for (i = 0; i < nr_objects; i++) {
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
diff --git a/sha1_file.c b/sha1_file.c
index 8bebbb2..0d60884 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1371,35 +1371,37 @@ int write_sha1_file(void *buf, unsigned 
 		return -1;
 	}
 
-	/* Set it up */
-	memset(&stream, 0, sizeof(stream));
-	deflateInit(&stream, Z_BEST_COMPRESSION);
-	size = deflateBound(&stream, len+hdrlen);
-	compressed = xmalloc(size);
-
-	/* Compress it */
-	stream.next_out = compressed;
-	stream.avail_out = size;
-
-	/* First header.. */
-	stream.next_in = hdr;
-	stream.avail_in = hdrlen;
-	while (deflate(&stream, 0) == Z_OK)
-		/* nothing */;
-
-	/* Then the data itself.. */
-	stream.next_in = buf;
-	stream.avail_in = len;
-	while (deflate(&stream, Z_FINISH) == Z_OK)
-		/* nothing */;
-	deflateEnd(&stream);
-	size = stream.total_out;
+	if (len + hdrlen > 0) {
+		/* Set it up */
+		memset(&stream, 0, sizeof(stream));
+		deflateInit(&stream, Z_BEST_COMPRESSION);
+		size = deflateBound(&stream, len+hdrlen);
+		compressed = xmalloc(size);
+
+		/* Compress it */
+		stream.next_out = compressed;
+		stream.avail_out = size;
 
-	if (write(fd, compressed, size) != size)
-		die("unable to write file");
+		/* First header.. */
+		stream.next_in = hdr;
+		stream.avail_in = hdrlen;
+		while (deflate(&stream, 0) == Z_OK)
+			/* nothing */;
+
+		/* Then the data itself.. */
+		stream.next_in = buf;
+		stream.avail_in = len;
+		while (deflate(&stream, Z_FINISH) == Z_OK)
+			/* nothing */;
+		deflateEnd(&stream);
+		size = stream.total_out;
+
+		if (write(fd, compressed, size) != size)
+			die("unable to write file");
+		free(compressed);
+	}
 	fchmod(fd, 0444);
 	close(fd);
-	free(compressed);
 
 	return move_temp_to_file(tmpfile, filename);
 }
@@ -1429,7 +1431,7 @@ int write_sha1_to_fd(int fd, const unsig
 		memset(&stream, 0, sizeof(stream));
 		deflateInit(&stream, Z_BEST_COMPRESSION);
 		size = deflateBound(&stream, len + hdrlen);
-		temp_obj = buf = xmalloc(size);
+		temp_obj = buf = xmalloc(size ? size : 1);
 
 		/* Compress it */
 		stream.next_out = buf;
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
diff --git a/unpack-objects.c b/unpack-objects.c
index 5c5cb12..572eeee 100644
--- a/unpack-objects.c
+++ b/unpack-objects.c
@@ -53,7 +53,7 @@ static void use(int bytes)
 static void *get_data(unsigned long size)
 {
 	z_stream stream;
-	void *buf = xmalloc(size);
+	void *buf = xmalloc(size ? size : 1);
 
 	memset(&stream, 0, sizeof(stream));
 
-- 
1.0.GIT
