From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 1/3] Introduce release_all_objects()
Date: Sun, 2 Dec 2007 02:54:27 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712020254120.27959@racer.site>
References: <20071127150229.GA14859@laptop> <20071127160423.GA22807@laptop>
 <Pine.LNX.4.64.0711271617350.27959@racer.site> <20071128000731.GD9174@efreet.light.src>
 <7v8x4jb295.fsf@gitster.siamese.dyndns.org>
 <fcaeb9bf0711280036p33583824ge59af93bbe3f0a78@mail.gmail.com>
 <7vfxyq2c9b.fsf@gitster.siamese.dyndns.org>
 <fcaeb9bf0711281917p56cc4228m6c401286439e2a34@mail.gmail.com>
 <alpine.LFD.0.99999.0711290905510.9605@xanadu.home> <7vd4tsvfvk.fsf@gitster.siamese.dyndns.org>
 <DB613F3E-85CC-4AF0-928C-4F4E4C8E9FB8@orakel.ntnu.no>
 <Pine.LNX.4.64.0711301207020.27959@racer.site> <7vlk8f9m52.fsf@gitster.siamese.dyndns.org>
 <Pine.LNX.4.64.0712010959180.27959@racer.site> <7vzlwu43i4.fsf@gitster.siamese.dyndns.org>
 <Pine.LNX.4.64.0712012300440.27959@racer.site> <Pine.LNX.4.64.0712012314190.27959@racer.site>
 <Pine.LNX.4.64.0712020146240.27959@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Eyvind Bernhardsen <eyvind-git-list@orakel.ntnu.no>,
	Nicolas Pitre <nico@cam.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Jan Hudec <bulb@ucw.cz>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 02 03:55:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iyez7-0007RL-3c
	for gcvg-git-2@gmane.org; Sun, 02 Dec 2007 03:55:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753793AbXLBCyt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Dec 2007 21:54:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753732AbXLBCyt
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Dec 2007 21:54:49 -0500
Received: from mail.gmx.net ([213.165.64.20]:55137 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753493AbXLBCyr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Dec 2007 21:54:47 -0500
Received: (qmail invoked by alias); 02 Dec 2007 02:54:46 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp029) with SMTP; 02 Dec 2007 03:54:46 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18QJjYITVkQQhETvCMxjxoNx3MIaf0uTntNyEU7h/
	7NtBWQAUBR9Btz
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0712020146240.27959@racer.site>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66749>


The new function release_all_objects() can be used to flush the object
cache.  This will be needed for the upcoming change in execv_git_cmd(),
which should call the builtin functions directly instead of calling
execvp().

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	Guess how surprised I was when "free(commit);" would work the
	first time, but not the second...

	ATM I use an ugly way to cope with the static "nr" variables
	in alloc.c: I just do not free() the last block.

	It might be a better idea to refactor the (quite ugly) code in
	alloc.c to have global structures a la

		#define BLOCKING 1024

		struct object_block {
			size_t struct_size;
			int nr;
			/* first (uint32_t *) is pointer to previous block */
			void *block;
		};

		static void *alloc_node(struct object_block *block)
		{
			if (!block || block->nr >= BLOCKING) {
				void *next = xmalloc(sizeof(void *)
					+ BLOCKING * block->struct_size);
				*(void **)next = block->block;
				block->block = next;
				block->nr = 0;
			}
			return block->block + sizeof(void *)
				+ block->struct_size * block->nr++;
		}

		static void release_nodes(struct object_block *block)
		{
			while (block->block) {
				void *previous = *(void **)block->block;
				free(block->block);
				block->block = previous;
			}
			block->nr = 0; /* not strictly necessary */
		}

		#define DEFINE_ALLOCATOR(type)				\
		static object_block type##s = { sizeof(struct type) };	\
		struct type *alloc_##type##_node(void)			\
		{							\
			return alloc_node(&type##s);			\
		}

		DEFINE_ALLOCATOR(object)
		DEFINE_ALLOCATOR(blob)
		DEFINE_ALLOCATOR(tree)
		DEFINE_ALLOCATOR(commit)
		DEFINE_ALLOCATOR(tag)

	but I am waaay too tired to brush this up, test it and submit it
	(hint, hint).

 alloc.c  |   31 ++++++++++++++++++++++++++++++-
 blob.c   |    3 +++
 blob.h   |    1 +
 cache.h  |    6 ++++++
 commit.c |    8 ++++++++
 commit.h |    2 ++
 object.c |   24 ++++++++++++++++++++++++
 object.h |    2 ++
 tag.c    |    8 ++++++++
 tag.h    |    2 ++
 tree.c   |    6 ++++++
 tree.h   |    1 +
 12 files changed, 93 insertions(+), 1 deletions(-)

diff --git a/alloc.c b/alloc.c
index 216c23a..8c5e5e0 100644
--- a/alloc.c
+++ b/alloc.c
@@ -20,6 +20,7 @@
 
 #define DEFINE_ALLOCATOR(name, type)				\
 static unsigned int name##_allocs;				\
+static void *last_alloced_##name;				\
 void *alloc_##name##_node(void)					\
 {								\
 	static int nr;						\
@@ -28,13 +29,32 @@ void *alloc_##name##_node(void)					\
 								\
 	if (!nr) {						\
 		nr = BLOCKING;					\
-		block = xmalloc(BLOCKING * sizeof(type));	\
+		struct {					\
+			void *previous;				\
+			type block[BLOCKING];			\
+		} *buf = xmalloc(sizeof(*buf));			\
+		buf->previous = last_alloced_##name;		\
+		last_alloced_##name = buf;			\
+		block = buf->block;				\
 	}							\
 	nr--;							\
 	name##_allocs++;					\
 	ret = block++;						\
 	memset(ret, 0, sizeof(type));				\
 	return ret;						\
+}								\
+								\
+void release_all_##name##_nodes(void)				\
+{								\
+	void *buf = last_alloced_##name;			\
+	if (!buf)						\
+		return;						\
+	buf = *(void **)buf;					\
+	while (buf) {						\
+		void *next = *(void **)buf;			\
+		free(buf);					\
+		buf = next;					\
+	}							\
 }
 
 union any_object {
@@ -74,3 +94,12 @@ void alloc_report(void)
 	REPORT(commit);
 	REPORT(tag);
 }
+
+void release_all_nodes(void)
+{
+	release_all_blob_nodes();
+	release_all_tree_nodes();
+	release_all_commit_nodes();
+	release_all_tag_nodes();
+	release_all_object_nodes();
+}
diff --git a/blob.c b/blob.c
index bd7d078..63756e6 100644
--- a/blob.c
+++ b/blob.c
@@ -18,6 +18,9 @@ struct blob *lookup_blob(const unsigned char *sha1)
 	return (struct blob *) obj;
 }
 
+void release_blob(struct blob *blob) {
+}
+
 int parse_blob_buffer(struct blob *item, void *buffer, unsigned long size)
 {
 	item->object.parsed = 1;
diff --git a/blob.h b/blob.h
index ea5d9e9..7560671 100644
--- a/blob.h
+++ b/blob.h
@@ -10,6 +10,7 @@ struct blob {
 };
 
 struct blob *lookup_blob(const unsigned char *sha1);
+void release_blob(struct blob *blob);
 
 int parse_blob_buffer(struct blob *item, void *buffer, unsigned long size);
 
diff --git a/cache.h b/cache.h
index 4e59646..cc50f1c 100644
--- a/cache.h
+++ b/cache.h
@@ -613,6 +613,12 @@ extern void *alloc_tree_node(void);
 extern void *alloc_commit_node(void);
 extern void *alloc_tag_node(void);
 extern void *alloc_object_node(void);
+extern void release_all_blob_nodes(void);
+extern void release_all_tree_nodes(void);
+extern void release_all_commit_nodes(void);
+extern void release_all_tag_nodes(void);
+extern void release_all_object_nodes(void);
+extern void release_all_nodes(void);
 extern void alloc_report(void);
 
 /* trace.c */
diff --git a/commit.c b/commit.c
index f074811..59c2236 100644
--- a/commit.c
+++ b/commit.c
@@ -48,6 +48,14 @@ struct commit *lookup_commit(const unsigned char *sha1)
 	return check_commit(obj, sha1, 0);
 }
 
+void release_commit(struct commit *commit)
+{
+	if (commit->parents)
+		free_commit_list(commit->parents);
+	if (commit->buffer)
+		free(commit->buffer);
+}
+
 static unsigned long parse_commit_date(const char *buf)
 {
 	unsigned long date;
diff --git a/commit.h b/commit.h
index 10e2b5d..363b9fb 100644
--- a/commit.h
+++ b/commit.h
@@ -21,6 +21,7 @@ struct commit {
 	char *buffer;
 };
 
+
 extern int save_commit_buffer;
 extern const char *commit_type;
 
@@ -35,6 +36,7 @@ struct commit *lookup_commit(const unsigned char *sha1);
 struct commit *lookup_commit_reference(const unsigned char *sha1);
 struct commit *lookup_commit_reference_gently(const unsigned char *sha1,
 					      int quiet);
+void release_commit(struct commit *commit);
 
 int parse_commit_buffer(struct commit *item, void *buffer, unsigned long size);
 
diff --git a/object.c b/object.c
index 16793d9..f217122 100644
--- a/object.c
+++ b/object.c
@@ -192,6 +192,30 @@ struct object *parse_object(const unsigned char *sha1)
 	return NULL;
 }
 
+void release_all_objects(void)
+{
+	int i;
+	for (i = 0; i < obj_hash_size; i++)
+		if (obj_hash[i]) {
+			switch (obj_hash[i]->type) {
+			case OBJ_BLOB:
+				release_blob((struct blob *)obj_hash[i]);
+				break;
+			case OBJ_COMMIT:
+				release_commit((struct commit *)obj_hash[i]);
+				break;
+			/*case OBJ_TREE:
+				release_tree((struct tree *)obj_hash[i]);
+				break;
+			case OBJ_TAG:
+				release_tag((struct tag *)obj_hash[i]);
+				break;*/
+			}
+			obj_hash[i] = NULL;
+		}
+	release_all_nodes();
+}
+
 struct object_list *object_list_insert(struct object *item,
 				       struct object_list **list_p)
 {
diff --git a/object.h b/object.h
index 397bbfa..ad6184c 100644
--- a/object.h
+++ b/object.h
@@ -44,6 +44,8 @@ extern unsigned int get_max_object_index(void);
 extern struct object *get_indexed_object(unsigned int);
 extern struct object_refs *lookup_object_refs(struct object *);
 
+extern void release_all_objects(void);
+
 /** Internal only **/
 struct object *lookup_object(const unsigned char *sha1);
 
diff --git a/tag.c b/tag.c
index f62bcdd..8bc6840 100644
--- a/tag.c
+++ b/tag.c
@@ -33,6 +33,14 @@ struct tag *lookup_tag(const unsigned char *sha1)
         return (struct tag *) obj;
 }
 
+void release_tag(struct tag *tag)
+{
+	if (tag->tag)
+		free(tag->tag);
+	if (tag->signature)
+		free(tag->signature);
+}
+
 int parse_tag_buffer(struct tag *item, void *data, unsigned long size)
 {
 	int typelen, taglen;
diff --git a/tag.h b/tag.h
index 7a0cb00..fbc6048 100644
--- a/tag.h
+++ b/tag.h
@@ -12,6 +12,8 @@ struct tag {
 	char *signature; /* not actually implemented */
 };
 
+void release_tag(struct tag *tag);
+
 extern struct tag *lookup_tag(const unsigned char *sha1);
 extern int parse_tag_buffer(struct tag *item, void *data, unsigned long size);
 extern int parse_tag(struct tag *item);
diff --git a/tree.c b/tree.c
index 8c0819f..ee99bc6 100644
--- a/tree.c
+++ b/tree.c
@@ -202,6 +202,12 @@ struct tree *lookup_tree(const unsigned char *sha1)
 	return (struct tree *) obj;
 }
 
+void release_tree(struct tree *tree)
+{
+	if (tree->buffer)
+		free(tree->buffer);
+}
+
 /*
  * NOTE! Tree refs to external git repositories
  * (ie gitlinks) do not count as real references.
diff --git a/tree.h b/tree.h
index dd25c53..f8372a2 100644
--- a/tree.h
+++ b/tree.h
@@ -12,6 +12,7 @@ struct tree {
 };
 
 struct tree *lookup_tree(const unsigned char *sha1);
+void release_tree(struct tree *tree);
 
 int parse_tree_buffer(struct tree *item, void *buffer, unsigned long size);
 
-- 
1.5.3.6.2112.ge2263
