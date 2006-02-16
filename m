From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] pack-objects: reuse data from existing pack.
Date: Wed, 15 Feb 2006 17:43:25 -0800
Message-ID: <7vbqx8m62q.fsf@assigned-by-dhcp.cox.net>
References: <7vd5hpm2x0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 16 02:43:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F9YBG-0004Oy-B7
	for gcvg-git@gmane.org; Thu, 16 Feb 2006 02:43:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751357AbWBPBne (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Feb 2006 20:43:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751360AbWBPBne
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Feb 2006 20:43:34 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:53234 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1751357AbWBPBne (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Feb 2006 20:43:34 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060216014220.PKWC15695.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 15 Feb 2006 20:42:20 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vd5hpm2x0.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Wed, 15 Feb 2006 00:39:23 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16258>

When generating a new pack, notice if we have already the wanted
object in existing packs.  If the object has a delitified
representation, and its base object is also what we are going to
pack, then reuse the existing deltified representation
unconditionally, bypassing all the expensive find_deltas() and
try_deltas() routines.

Also, when writing out such deltified representation and
undeltified representation, if a matching data already exists in
an existing pack, just write it out without uncompressing &
recompressing.

Without this patch:

    $ git-rev-list --objects v1.0.0 >RL
    $ time git-pack-objects p <RL

    Generating pack...
    Done counting 12233 objects.
    Packing 12233 objects....................
    60a88b3979df41e22d1edc3967095e897f720192

    real    0m32.751s
    user    0m27.090s
    sys     0m2.750s

With this patch:

    $ git-rev-list --objects v1.0.0 >RL
    $ time ../git.junio/git-pack-objects q <RL

    Generating pack...
    Done counting 12233 objects.
    Packing 12233 objects.....................
    60a88b3979df41e22d1edc3967095e897f720192
    Total 12233, written 12233, reused 12177

    real    0m4.007s
    user    0m3.360s
    sys     0m0.090s

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 * This may depend on one cleanup patch I have not sent out, but
   I am so excited that I could not help sending this out first.

   Admittedly this is hot off the press, I have not had enough
   time to beat this too hard, but the resulting pack from the
   above passed unpack-objects, index-pack and verify-pack.

 pack-objects.c |  317 ++++++++++++++++++++++++++++++++++++++++++++++----------
 pack.h         |    4 +
 sha1_file.c    |   19 +++
 3 files changed, 283 insertions(+), 57 deletions(-)

0d574a3c3ec6924118d06ee0487d02d2fbb12646
diff --git a/pack-objects.c b/pack-objects.c
index c5a5e61..f2a45a2 100644
--- a/pack-objects.c
+++ b/pack-objects.c
@@ -9,13 +9,16 @@ static const char pack_usage[] = "git-pa
 
 struct object_entry {
 	unsigned char sha1[20];
-	unsigned long size;
-	unsigned long offset;
-	unsigned int depth;
-	unsigned int hash;
+	unsigned long size;	/* uncompressed size */
+	unsigned long offset;	/* offset into the final pack file (nonzero if already written) */
+	unsigned int depth;	/* delta depth */
+	unsigned int hash;	/* name hint hash */
 	enum object_type type;
-	unsigned long delta_size;
-	struct object_entry *delta;
+	unsigned long delta_size;	/* delta data size (uncompressed) */
+	struct object_entry *delta;	/* delta base object */
+	struct packed_git *in_pack; 	/* already in pack */
+	enum object_type in_pack_type;	/* could be delta */
+	unsigned int in_pack_offset;
 };
 
 static unsigned char object_list_sha1[20];
@@ -29,6 +32,105 @@ static const char *base_name;
 static unsigned char pack_file_sha1[20];
 static int progress = 1;
 
+static int *object_ix = NULL;
+static int object_ix_hashsz = 0;
+
+struct pack_revindex {
+	struct packed_git *p;
+	unsigned long *revindex;
+} *pack_revindex = NULL;
+static int pack_revindex_hashsz = 0;
+
+static int pack_revindex_ix(struct packed_git *p)
+{
+	unsigned int ui = (unsigned int) p;
+	int i;
+	ui = ui ^ (ui >> 16);
+	i = (int)(ui % pack_revindex_hashsz);
+	while (pack_revindex[i].p) {
+		if (pack_revindex[i].p == p)
+			return i;
+		if (++i == pack_revindex_hashsz)
+			i = 0;
+	}
+	return -1 - i;
+}
+
+static void prepare_pack_ix(void)
+{
+	int num;
+	struct packed_git *p;
+	for (num = 0, p = packed_git; p; p = p->next)
+		num++;
+	if (!num)
+		return;
+	pack_revindex_hashsz = num * 11;
+	pack_revindex = xcalloc(sizeof(*pack_revindex), pack_revindex_hashsz);
+	for (p = packed_git; p; p = p->next) {
+		num = pack_revindex_ix(p);
+		num = - 1 - num;
+		pack_revindex[num].p = p;
+	}
+	/* revindex elements are lazily initialized */
+}
+
+static int cmp_offset(const void *a_, const void *b_)
+{
+	unsigned long a = *(unsigned long *) a_;
+	unsigned long b = *(unsigned long *) b_;
+	if (a < b)
+		return -1;
+	else if (a == b)
+		return 0;
+	else
+		return 1;
+}
+
+static void prepare_pack_revindex(struct pack_revindex *rix)
+{
+	struct packed_git *p = rix->p;
+	int num_ent = num_packed_objects(p);
+	int i;
+	void *index = p->index_base + 256;
+
+	rix->revindex = xmalloc(sizeof(unsigned long) * (num_ent + 1));
+	for (i = 0; i < num_ent; i++) {
+		long hl = *((long *)(index + 24 * i));
+		rix->revindex[i] = ntohl(hl);
+	}
+	rix->revindex[num_ent] = p->pack_size - 20;
+	qsort(rix->revindex, num_ent, sizeof(unsigned long), cmp_offset);
+}
+
+static unsigned long find_packed_object_size(struct packed_git *p,
+					     unsigned long ofs)
+{
+	int num;
+	int lo, hi;
+	struct pack_revindex *rix;
+	unsigned long *revindex;
+	num = pack_revindex_ix(p);
+	if (num < 0)
+		die("internal error: pack revindex uninitialized");
+	rix = &pack_revindex[num];
+	if (!rix->revindex)
+		prepare_pack_revindex(rix);
+	revindex = rix->revindex;
+	lo = 0;
+	hi = num_packed_objects(p) + 1;
+	do {
+		int mi = (lo + hi) / 2;
+		if (revindex[mi] == ofs) {
+			return revindex[mi+1] - ofs;
+		}
+		else if (ofs < revindex[mi])
+			hi = mi;
+		else
+			lo = mi + 1;
+	} while (lo < hi);
+	die("internal error: pack revindex corrupt");
+}
+
 static void *delta_against(void *buf, unsigned long size, struct object_entry *entry)
 {
 	unsigned long othersize, delta_size;
@@ -74,39 +176,59 @@ static int encode_header(enum object_typ
 	return n;
 }
 
+static int written = 0;
+static int reused = 0;
+
 static unsigned long write_object(struct sha1file *f, struct object_entry *entry)
 {
 	unsigned long size;
 	char type[10];
-	void *buf = read_sha1_file(entry->sha1, type, &size);
+	void *buf;
 	unsigned char header[10];
 	unsigned hdrlen, datalen;
 	enum object_type obj_type;
 
-	if (!buf)
-		die("unable to read %s", sha1_to_hex(entry->sha1));
-	if (size != entry->size)
-		die("object %s size inconsistency (%lu vs %lu)", sha1_to_hex(entry->sha1), size, entry->size);
-
-	/*
-	 * The object header is a byte of 'type' followed by zero or
-	 * more bytes of length.  For deltas, the 20 bytes of delta sha1
-	 * follows that.
-	 */
 	obj_type = entry->type;
-	if (entry->delta) {
-		buf = delta_against(buf, size, entry);
-		size = entry->delta_size;
-		obj_type = OBJ_DELTA;
-	}
-	hdrlen = encode_header(obj_type, size, header);
-	sha1write(f, header, hdrlen);
-	if (entry->delta) {
-		sha1write(f, entry->delta, 20);
-		hdrlen += 20;
+	if (!entry->in_pack ||
+	    (obj_type != entry->in_pack_type)) {
+		buf = read_sha1_file(entry->sha1, type, &size);
+		if (!buf)
+			die("unable to read %s", sha1_to_hex(entry->sha1));
+		if (size != entry->size)
+			die("object %s size inconsistency (%lu vs %lu)",
+			    sha1_to_hex(entry->sha1), size, entry->size);
+		if (entry->delta) {
+			buf = delta_against(buf, size, entry);
+			size = entry->delta_size;
+			obj_type = OBJ_DELTA;
+		}
+		/*
+		 * The object header is a byte of 'type' followed by zero or
+		 * more bytes of length.  For deltas, the 20 bytes of delta
+		 * sha1 follows that.
+		 */
+		hdrlen = encode_header(obj_type, size, header);
+		sha1write(f, header, hdrlen);
+
+		if (entry->delta) {
+			sha1write(f, entry->delta, 20);
+			hdrlen += 20;
+		}
+		datalen = sha1write_compressed(f, buf, size);
+		free(buf);
+	}
+	else {
+		struct packed_git *p = entry->in_pack;
+		use_packed_git(p);
+
+		datalen = find_packed_object_size(p, entry->in_pack_offset);
+		buf = p->pack_base + entry->in_pack_offset;
+		sha1write(f, buf, datalen);
+		unuse_packed_git(p);
+		hdrlen = 0; /* not really */
+		reused++;
 	}
-	datalen = sha1write_compressed(f, buf, size);
-	free(buf);
+	written++;
 	return hdrlen + datalen;
 }
 
@@ -196,18 +318,21 @@ static int add_object_entry(unsigned cha
 {
 	unsigned int idx = nr_objects;
 	struct object_entry *entry;
-
-	if (incremental || local) {
-		struct packed_git *p;
-
-		for (p = packed_git; p; p = p->next) {
-			struct pack_entry e;
-
-			if (find_pack_entry_one(sha1, &e, p)) {
-				if (incremental)
-					return 0;
-				if (local && !p->pack_local)
-					return 0;
+	struct packed_git *p;
+	unsigned int found_offset;
+	struct packed_git *found_pack;
+
+	found_pack = NULL;
+	for (p = packed_git; p; p = p->next) {
+		struct pack_entry e;
+		if (find_pack_entry_one(sha1, &e, p)) {
+			if (incremental)
+				return 0;
+			if (local && !p->pack_local)
+				return 0;
+			if (!found_pack) {
+				found_offset = e.offset;
+				found_pack = e.p;
 			}
 		}
 	}
@@ -221,30 +346,99 @@ static int add_object_entry(unsigned cha
 	memset(entry, 0, sizeof(*entry));
 	memcpy(entry->sha1, sha1, 20);
 	entry->hash = hash;
+	if (found_pack) {
+		entry->in_pack = found_pack;
+		entry->in_pack_offset = found_offset;
+	}
 	nr_objects = idx+1;
 	return 1;
 }
 
+static int locate_object_entry_hash(unsigned char *sha1)
+{
+	int i;
+	unsigned int ui;
+	memcpy(&ui, sha1, sizeof(unsigned int));
+	i = ui % object_ix_hashsz;
+	while (0 < object_ix[i]) {
+		if (!memcmp(sha1, objects[object_ix[i]-1].sha1, 20))
+			return i;
+		if (++i == object_ix_hashsz)
+			i = 0;
+	}
+	return -1 - i;
+}
+
+static struct object_entry *locate_object_entry(unsigned char *sha1)
+{
+	int i = locate_object_entry_hash(sha1);
+	if (0 <= i)
+		return &objects[object_ix[i]-1];
+	return NULL;
+}
+
 static void check_object(struct object_entry *entry)
 {
 	char type[20];
 
-	if (!sha1_object_info(entry->sha1, type, &entry->size)) {
-		if (!strcmp(type, "commit")) {
-			entry->type = OBJ_COMMIT;
-		} else if (!strcmp(type, "tree")) {
-			entry->type = OBJ_TREE;
-		} else if (!strcmp(type, "blob")) {
-			entry->type = OBJ_BLOB;
-		} else if (!strcmp(type, "tag")) {
-			entry->type = OBJ_TAG;
-		} else
-			die("unable to pack object %s of type %s",
-			    sha1_to_hex(entry->sha1), type);
+	if (entry->in_pack) {
+		/* Check if it is delta, and the base is also an object
+		 * we are going to pack.  If so we will reuse the existing
+		 * delta.
+		 */
+		unsigned char base[20];
+		unsigned long size;
+		struct object_entry *base_entry;
+		if (!check_reuse_pack_delta(entry->in_pack,
+					    entry->in_pack_offset,
+					    base, &size,
+					    &entry->in_pack_type) &&
+		    (base_entry = locate_object_entry(base))) {
+			/* we do not know yet, but it does not matter */
+			entry->depth = 1;
+			/* uncompressed size */
+			entry->size = entry->delta_size = size;
+			entry->delta = base_entry;
+			entry->type = OBJ_DELTA; /* !! */
+			return;
+		}
+		/* Otherwise we would do the usual */
 	}
-	else
+
+	if (sha1_object_info(entry->sha1, type, &entry->size))
 		die("unable to get type of object %s",
 		    sha1_to_hex(entry->sha1));
+
+	if (!strcmp(type, "commit")) {
+		entry->type = OBJ_COMMIT;
+	} else if (!strcmp(type, "tree")) {
+		entry->type = OBJ_TREE;
+	} else if (!strcmp(type, "blob")) {
+		entry->type = OBJ_BLOB;
+	} else if (!strcmp(type, "tag")) {
+		entry->type = OBJ_TAG;
+	} else
+		die("unable to pack object %s of type %s",
+		    sha1_to_hex(entry->sha1), type);
+}
+
+static void hash_objects(void)
+{
+	int i;
+	struct object_entry *oe;
+
+	object_ix_hashsz = nr_objects * 2;
+	object_ix = xcalloc(sizeof(int), object_ix_hashsz);
+	for (i = 0, oe = objects; i < nr_objects; i++, oe++) {
+		int ix = locate_object_entry_hash(oe->sha1);
+		if (0 <= ix) {
+			error("the same object '%s' added twice",
+			      sha1_to_hex(oe->sha1));
+			continue;
+		}
+		ix = -1 - ix;
+		object_ix[ix] = i + 1;
+	}
 }
 
 static void get_object_details(void)
@@ -252,6 +446,8 @@ static void get_object_details(void)
 	int i;
 	struct object_entry *entry = objects;
 
+	hash_objects();
+	prepare_pack_ix();
 	for (i = 0; i < nr_objects; i++)
 		check_object(entry++);
 }
@@ -382,6 +578,11 @@ static void find_deltas(struct object_en
 			eye_candy -= nr_objects / 20;
 			fputc('.', stderr);
 		}
+
+		if (entry->delta)
+			/* we already know what we need to know */
+			continue;
+
 		free(n->data);
 		n->entry = entry;
 		n->data = read_sha1_file(entry->sha1, type, &size);
@@ -411,10 +612,12 @@ static void find_deltas(struct object_en
 
 static void prepare_pack(int window, int depth)
 {
-	get_object_details();
-
 	if (progress)
 		fprintf(stderr, "Packing %d objects", nr_objects);
+	get_object_details();
+	if (progress)
+		fprintf(stderr, ".");
+
 	sorted_by_type = create_sorted_list(type_size_sort);
 	if (window && depth)
 		find_deltas(sorted_by_type, window+1, depth);
@@ -599,5 +802,7 @@ int main(int argc, char **argv)
 			puts(sha1_to_hex(object_list_sha1));
 		}
 	}
+	fprintf(stderr, "Total %d, written %d, reused %d\n",
+		nr_objects, written, reused);
 	return 0;
 }
diff --git a/pack.h b/pack.h
index 9dafa2b..694e0c5 100644
--- a/pack.h
+++ b/pack.h
@@ -29,5 +29,7 @@ struct pack_header {
 };
 
 extern int verify_pack(struct packed_git *, int);
-
+extern int check_reuse_pack_delta(struct packed_git *, unsigned long,
+				  unsigned char *, unsigned long *,
+				  enum object_type *);
 #endif
diff --git a/sha1_file.c b/sha1_file.c
index 64cf245..0a3a721 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -826,6 +826,25 @@ static unsigned long unpack_object_heade
 	return offset;
 }
 
+int check_reuse_pack_delta(struct packed_git *p, unsigned long offset,
+			   unsigned char *base, unsigned long *sizep,
+			   enum object_type *kindp)
+{
+	unsigned long ptr;
+	int status = -1;
+
+	use_packed_git(p);
+	ptr = offset;
+	ptr = unpack_object_header(p, ptr, kindp, sizep);
+	if (*kindp != OBJ_DELTA)
+		goto done;
+	memcpy(base, p->pack_base + ptr, 20);
+	status = 0;
+ done:
+	unuse_packed_git(p);
+	return status;
+}
+
 void packed_object_info_detail(struct pack_entry *e,
 			       char *type,
 			       unsigned long *size,
-- 
1.2.0.gcfba7
