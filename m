From: Tomas Carnecky <tom@dbservice.com>
Subject: [PATCH 5/6] Introduce the git fast-import-helper
Date: Sun,  3 Oct 2010 14:21:50 +0200
Message-ID: <1286108511-55876-5-git-send-email-tom@dbservice.com>
References: <4CA86A12.6080905@dbservice.com>
Cc: Tomas Carnecky <tom@dbservice.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 03 14:22:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2NaE-0005Mv-BF
	for gcvg-git-2@lo.gmane.org; Sun, 03 Oct 2010 14:22:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753354Ab0JCMWT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Oct 2010 08:22:19 -0400
Received: from gw.ptr-62-65-141-13.customer.ch.netstream.com ([62.65.141.13]:60853
	"EHLO calvin.caurea.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752833Ab0JCMWM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Oct 2010 08:22:12 -0400
Received: by calvin.caurea.org (Postfix, from userid 501)
	id 04EF3245A754; Sun,  3 Oct 2010 14:22:10 +0200 (CEST)
X-Mailer: git-send-email 1.7.3.37.gb6088b
In-Reply-To: <4CA86A12.6080905@dbservice.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157868>

The g-f-i-h is a heavily modified (and simplified where possible) copy
of git-fast-import. It has a few very important changes which make it
suitable to be used in the new generation of remote helpers.

1) It does not update refs itself. Instead, for each 'mark' it sees, it
   writes the SHA1 of the corresponding git object to stdout. The remote
   helper can read this data and pass it along to core git for example.

2) It does not read/write mark files itself. Managing the marks is now
   up to the application which uses g-f-i-h. To support that, a new
   command was added: 'mark <name> <sha1>'. It can be used to feed
   g-f-i-h with existing marks from earlier sessions. Also, marks
   can now be arbitrary strings and not just numbers. This allows remote
   helpers to use for example whole revision strings (r42 for svn or
   mercurial changeset IDs).

3) Memory management has been significantly simplified. No more pools
   and custom allocators. It uses plain malloc/free. Uses `struct
   hash_table` instead of custom data structures. This may make it
   a bit slower than the original, but on the other hand it reduces
   the complexity of the source code.

Signed-off-by: Tomas Carnecky <tom@dbservice.com>
---
 .gitignore           |    1 +
 Makefile             |    1 +
 fast-import-helper.c | 2201 ++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 2203 insertions(+), 0 deletions(-)
 create mode 100644 fast-import-helper.c

diff --git a/.gitignore b/.gitignore
index 20560b8..c8aa8c7 100644
--- a/.gitignore
+++ b/.gitignore
@@ -42,6 +42,7 @@
 /git-describe
 /git-fast-export
 /git-fast-import
+/git-fast-import-helper
 /git-fetch
 /git-fetch--tool
 /git-fetch-pack
diff --git a/Makefile b/Makefile
index 8a56b9a..f8a9c40 100644
--- a/Makefile
+++ b/Makefile
@@ -402,6 +402,7 @@ EXTRA_PROGRAMS =
 PROGRAMS += $(EXTRA_PROGRAMS)
 
 PROGRAM_OBJS += fast-import.o
+PROGRAM_OBJS += fast-import-helper.o
 PROGRAM_OBJS += imap-send.o
 PROGRAM_OBJS += shell.o
 PROGRAM_OBJS += show-index.o
diff --git a/fast-import-helper.c b/fast-import-helper.c
new file mode 100644
index 0000000..b1f86a0
--- /dev/null
+++ b/fast-import-helper.c
@@ -0,0 +1,2201 @@
+
+#include "builtin.h"
+#include "cache.h"
+#include "object.h"
+#include "blob.h"
+#include "tree.h"
+#include "commit.h"
+#include "delta.h"
+#include "pack.h"
+#include "refs.h"
+#include "csum-file.h"
+#include "quote.h"
+#include "exec_cmd.h"
+#include "hash.h"
+#include "tree-walk.h"
+
+#define DEPTH_BITS 13
+#define MAX_DEPTH ((1<<DEPTH_BITS)-1)
+
+struct fi_object
+{
+	struct fi_object *next;
+	struct pack_idx_entry idx;
+	uint32_t type : TYPE_BITS,
+		depth : DEPTH_BITS;
+};
+
+struct last_object
+{
+	struct strbuf data;
+	off_t offset;
+	unsigned int depth;
+	unsigned no_swap : 1;
+};
+
+/* An atom uniquely identifies an array of data (usually strings). */
+struct fi_atom
+{
+	struct fi_atom *next;
+	unsigned short len;
+	char data[FLEX_ARRAY];
+};
+
+/* The stream can use marks to mark objects (blobs, commits) with a unique
+ * string. After the object is added to the object database and we know its
+ * SHA1, we report that to stdout. */
+struct fi_mark
+{
+	struct fi_mark *next;
+	struct fi_atom *atom;
+	unsigned char sha1[20];
+};
+
+struct fi_tree;
+struct fi_tree_entry
+{
+	struct fi_tree *tree;
+	
+	struct fi_atom *name;
+	struct fi_tree_entry_ms
+	{
+		unsigned int mode;
+		unsigned char sha1[20];
+	} versions[2];
+};
+
+struct fi_tree
+{
+	struct fi_tree *next;
+	unsigned int entry_capacity;
+	unsigned int entry_count;
+	unsigned int delta_depth;
+	struct fi_tree_entry *entries[FLEX_ARRAY];
+};
+
+struct fi_branch
+{
+	struct fi_branch *table_next_branch;
+	struct fi_branch *active_next_branch;
+	const char *name;
+	struct fi_tree_entry branch_tree;
+	uintmax_t num_notes;
+	unsigned active : 1;
+	unsigned char sha1[20];
+};
+
+struct fi_tag
+{
+	struct fi_tag *next_tag;
+	const char *name;
+	unsigned char sha1[20];
+};
+
+struct hash_list
+{
+	struct hash_list *next;
+	unsigned char sha1[20];
+};
+
+typedef enum {
+	WHENSPEC_RAW = 1,
+	WHENSPEC_RFC2822,
+	WHENSPEC_NOW
+} whenspec_type;
+
+/* Configured limits on output */
+static unsigned long max_depth = 10;
+static off_t max_packsize = 32 * 1024 * 1024;
+static uintmax_t big_file_threshold = 512 * 1024 * 1024;
+static int force_update;
+static int pack_compression_level = Z_DEFAULT_COMPRESSION;
+static int pack_compression_seen;
+
+/* The .pack file being generated */
+static struct sha1file *pack_file;
+static struct packed_git *pack_data;
+static off_t pack_size;
+
+/* Our last blob */
+static struct last_object last_blob = { STRBUF_INIT, 0, 0, 0 };
+
+/* Branch data */
+static struct hash_table branches;
+static unsigned long max_active_branches = 5;
+static unsigned long cur_active_branches;
+static struct fi_branch *active_branches;
+
+/* Tag data */
+static struct hash_table tags;
+
+/* Input stream parsing */
+static whenspec_type whenspec = WHENSPEC_RAW;
+static struct strbuf command_buf = STRBUF_INIT;
+
+static void end_packfile(void);
+static struct fi_atom *to_atom(const char *s, unsigned short len);
+static enum object_type fi_sha1_object_type(unsigned char sha1[20]);
+
+
+static int git_pack_config(const char *k, const char *v, void *cb)
+{
+	if (!strcmp(k, "pack.depth")) {
+		max_depth = git_config_int(k, v);
+		if (max_depth > MAX_DEPTH)
+			max_depth = MAX_DEPTH;
+		return 0;
+	}
+	if (!strcmp(k, "pack.compression")) {
+		int level = git_config_int(k, v);
+		if (level == -1)
+			level = Z_DEFAULT_COMPRESSION;
+		else if (level < 0 || level > Z_BEST_COMPRESSION)
+			die("bad pack compression level %d", level);
+		pack_compression_level = level;
+		pack_compression_seen = 1;
+		return 0;
+	}
+	if (!strcmp(k, "pack.indexversion")) {
+		pack_idx_default_version = git_config_int(k, v);
+		if (pack_idx_default_version > 2)
+			die("bad pack.indexversion=%"PRIu32,
+			    pack_idx_default_version);
+		return 0;
+	}
+	if (!strcmp(k, "pack.packsizelimit")) {
+		max_packsize = git_config_ulong(k, v);
+		return 0;
+	}
+	if (!strcmp(k, "core.bigfilethreshold")) {
+		long n = git_config_int(k, v);
+		big_file_threshold = 0 < n ? n : 0;
+	}
+	return git_default_config(k, v, cb);
+}
+
+static NORETURN void die_nicely(const char *err, va_list params)
+{
+	static int zombie;
+	char message[2 * PATH_MAX];
+
+	vsnprintf(message, sizeof(message), err, params);
+	fputs("fatal: ", stderr);
+	fputs(message, stderr);
+	fputc('\n', stderr);
+
+	if (!zombie) {
+		zombie = 1;
+		end_packfile();
+	}
+	exit(128);
+}
+
+
+/**
+ * Misc methods
+ */
+
+static unsigned int hc_str(const char *s, size_t len)
+{
+	unsigned int r = 0;
+	while (len-- > 0)
+		r = r * 31 + *s++;
+	return r;
+}
+
+
+/**
+ * Command buffer
+ */
+
+static int read_next_command(void)
+{
+	static int stdin_eof = 0;
+
+	if (stdin_eof) {
+		return EOF;
+	}
+
+	do {
+		strbuf_detach(&command_buf, NULL);
+		stdin_eof = strbuf_getline(&command_buf, stdin, '\n');
+		if (stdin_eof)
+			return EOF;
+	} while (command_buf.buf[0] == '#');
+	//fprintf(stderr, "Command: %s\n", command_buf.buf);
+
+	return 0;
+}
+
+static void skip_optional_lf(void)
+{
+	if (command_buf.buf[0] == '\n')
+		read_next_command();
+}
+
+
+/**
+ * Object cache
+ */
+
+static struct hash_table objects;
+
+static struct fi_object *new_object(unsigned char *sha1)
+{
+	struct fi_object *e = malloc(sizeof(struct fi_object));
+	hashcpy(e->idx.sha1, sha1);
+	return e;
+}
+
+static struct fi_object *find_object(unsigned char *sha1)
+{
+	unsigned int hash = *(unsigned int *) sha1;
+	struct fi_object *head = lookup_hash(hash, &objects);
+
+	while (head) {
+		if (!hashcmp(sha1, head->idx.sha1))
+			return head;
+
+		head = head->next;
+	}
+
+	return NULL;
+}
+
+static struct fi_object *insert_object(unsigned char *sha1)
+{
+	unsigned int hash = *(unsigned int *) sha1;
+	struct fi_object *oe, *head = lookup_hash(hash, &objects);
+	void **ptr;
+
+	oe = head;
+	while (oe) {
+		if (!hashcmp(sha1, oe->idx.sha1))
+			return oe;
+
+		oe = oe->next;
+	}
+
+	oe = new_object(sha1);
+	oe->next = head;
+	oe->idx.offset = 0;
+
+	ptr = insert_hash(hash, oe, &objects);
+	if (ptr)
+		*ptr = oe;
+
+	return oe;
+}
+
+static int free_object(void *data)
+{
+	free(data);
+	return 0;
+}
+
+
+/**
+ * Atoms
+ */
+
+static struct hash_table atoms;
+
+static struct fi_atom *to_atom(const char *s, unsigned short len)
+{
+	unsigned int hash = hc_str(s, len);
+	struct fi_atom *atom, *head = lookup_hash(hash, &atoms);
+
+	atom = head;
+	while (atom) {
+		if (atom->len == len && !strncmp(s, atom->data, len))
+			return atom;
+		atom = atom->next;
+	}
+
+	atom = malloc(sizeof(struct fi_atom) + len + 1);
+	atom->len = len;
+	strncpy(atom->data, s, len);
+	atom->data[len] = 0;
+	atom->next = head;
+
+	insert_hash(hash, atom, &atoms);
+
+	return atom;
+}
+
+/**
+ * Mark cache
+ */
+
+static struct hash_table marks;
+
+static void insert_mark(struct fi_atom *atom, unsigned char sha1[20])
+{
+	unsigned int hash = hc_str(atom->data, atom->len);
+	struct fi_mark *mark, *head = lookup_hash(hash, &marks);
+	void **ptr;
+	
+	/* If the mark already exists, overwrite its value. */
+	mark = head;
+	while (mark) {
+		if (atom == mark->atom) {
+			hashcpy(mark->sha1, sha1);
+			goto out;
+		}
+		
+	}
+	
+	mark = malloc(sizeof(struct fi_mark));
+	mark->next = head;
+	mark->atom = atom;
+	hashcpy(mark->sha1, sha1);
+
+	ptr = insert_hash(hash, mark, &marks);
+	if (ptr)
+		*ptr = mark;
+
+out:
+	/* Dump the mark mapping to stdout. */
+	fprintf(stdout, "mark :%s %s\n", atom->data, sha1_to_hex(sha1));
+	//fprintf(stderr, "mark :%s %s\n", atom->data, sha1_to_hex(sha1));
+	fflush(stdout); fflush(stderr);
+}
+
+
+/* Parse an atom in the string, set *atom and return the end of the atom. */
+static const char *parse_mark_to_atom(const char *s, struct fi_atom **atom)
+{
+	const char *end = strchr(s, ' ');
+	unsigned int len = end ? end - s : strlen(s);
+	*atom = to_atom(s, len);
+	return s + len;
+}
+
+static const char *find_mark(const char *mark, unsigned char sha1[20])
+{
+	struct fi_atom *atom;
+	const char *end = parse_mark_to_atom(mark, &atom);
+	unsigned int hash = hc_str(mark, end - mark);
+	struct fi_mark *head = lookup_hash(hash, &marks);
+
+	while (head) {
+		if (head->atom == atom) {
+			hashcpy(sha1, head->sha1);
+			return end;
+		}
+		head = head->next;
+	}
+	
+	die("Did not find mark '%s'", mark);
+}
+
+
+/**
+ * Branch cache
+ */
+
+static struct fi_branch *lookup_branch(const char *name)
+{
+	unsigned int hash = hc_str(name, strlen(name));
+	struct fi_branch *b = lookup_hash(hash, &branches);
+
+	while (b) {
+		if (!strcmp(name, b->name))
+			return b;
+		b = b->table_next_branch;
+	}
+
+	return NULL;
+}
+
+static struct fi_branch *new_branch(const char *name)
+{
+	unsigned int hash = hc_str(name, strlen(name));
+	struct fi_branch *b = lookup_branch(name);
+	void **ptr;
+
+	if (b)
+		die("Invalid attempt to create duplicate branch: %s", name);
+	switch (check_ref_format(name)) {
+	case 0: break; /* its valid */
+	case CHECK_REF_FORMAT_ONELEVEL:
+		break; /* valid, but too few '/', allow anyway */
+	default:
+		die("Branch name doesn't conform to GIT standards: %s", name);
+	}
+
+	b = calloc(1, sizeof(struct fi_branch));
+	b->name = strdup(name);
+	b->table_next_branch = lookup_hash(hash, &branches);
+	b->branch_tree.versions[0].mode = S_IFDIR;
+	b->branch_tree.versions[1].mode = S_IFDIR;
+	b->num_notes = 0;
+	b->active = 0;
+	ptr = insert_hash(hash, b, &branches);
+	if (ptr)
+		*ptr = b;
+		
+	return b;
+}
+
+
+/**
+ * Tree cache
+ */
+
+static struct fi_tree *new_tree_content(unsigned int cnt)
+{
+	struct fi_tree *t;
+
+	t = malloc(sizeof(*t) + sizeof(t->entries[0]) * cnt);
+	t->next = NULL;
+	t->entry_capacity = cnt;
+	t->entry_count = 0;
+	t->delta_depth = 0;
+
+	return t;
+}
+
+static void release_tree_entry(struct fi_tree_entry *e);
+static void release_tree_content(struct fi_tree *t)
+{
+	free(t);
+}
+
+static void release_tree_content_recursive(struct fi_tree *t)
+{
+	unsigned int i;
+	for (i = 0; i < t->entry_count; i++)
+		release_tree_entry(t->entries[i]);
+	release_tree_content(t);
+}
+
+static struct fi_tree *grow_tree_content(
+	struct fi_tree *t,
+	int amt)
+{
+	struct fi_tree *r = new_tree_content(t->entry_count + amt);
+	r->entry_count = t->entry_count;
+	r->delta_depth = t->delta_depth;
+	memcpy(r->entries,t->entries,t->entry_count*sizeof(t->entries[0]));
+	release_tree_content(t);
+	return r;
+}
+
+static struct fi_tree_entry *new_tree_entry(void)
+{
+	return xmalloc(sizeof(struct fi_tree_entry));
+}
+
+static void release_tree_entry(struct fi_tree_entry *e)
+{
+	free(e);
+}
+
+static struct fi_tree *dup_tree_content(struct fi_tree *s)
+{
+	struct fi_tree *d;
+	struct fi_tree_entry *a, *b;
+	unsigned int i;
+
+	if (!s)
+		return NULL;
+	d = new_tree_content(s->entry_count);
+	for (i = 0; i < s->entry_count; i++) {
+		a = s->entries[i];
+		b = new_tree_entry();
+		memcpy(b, a, sizeof(*a));
+		if (a->tree && is_null_sha1(b->versions[1].sha1))
+			b->tree = dup_tree_content(a->tree);
+		else
+			b->tree = NULL;
+		d->entries[i] = b;
+	}
+	d->entry_count = s->entry_count;
+	d->delta_depth = s->delta_depth;
+
+	return d;
+}
+
+
+/**
+ * Pack file handling
+ */
+
+static void start_packfile(void)
+{
+	static char tmpfile[PATH_MAX];
+	struct pack_header hdr;
+	int pack_fd;
+
+	pack_fd = odb_mkstemp(tmpfile, sizeof(tmpfile), "pack/tmp_pack_XXXXXX");
+	pack_data = xcalloc(1, sizeof(struct packed_git) + strlen(tmpfile) + 2);
+	strcpy(pack_data->pack_name, tmpfile);
+	pack_data->pack_fd = pack_fd;
+	pack_file = sha1fd(pack_fd, pack_data->pack_name);
+
+	hdr.hdr_signature = htonl(PACK_SIGNATURE);
+	hdr.hdr_version = htonl(2);
+	hdr.hdr_entries = 0;
+	sha1write(pack_file, &hdr, sizeof(hdr));
+
+	pack_size = sizeof(hdr);
+
+	for_each_hash(&objects, free_object);
+	free_hash(&objects);
+}
+
+static struct pack_idx_entry **create_index_iter;
+static int fi_add_to_index(void *data)
+{
+	struct fi_object *oe = data;
+	while (oe) {
+		*create_index_iter++ = &oe->idx;
+		oe = oe->next;
+	}
+	
+	return 0;
+}
+
+static const char *create_index(void)
+{
+	const char *tmpfile;
+	struct pack_idx_entry **idx, **last;
+
+	/* Build the table of object IDs. */
+	idx = xmalloc(objects.nr * sizeof(*idx));
+	create_index_iter = idx;
+	for_each_hash(&objects, fi_add_to_index);
+	last = idx + objects.nr;
+	if (create_index_iter != last)
+		die("internal consistency error creating the index");
+
+	tmpfile = write_idx_file(NULL, idx, objects.nr, pack_data->sha1);
+	free(idx);
+	return tmpfile;
+}
+
+static char *keep_pack(const char *curr_index_name)
+{
+	static char name[PATH_MAX];
+	static const char *keep_msg = "fast-import";
+	int keep_fd;
+
+	keep_fd = odb_pack_keep(name, sizeof(name), pack_data->sha1);
+	if (keep_fd < 0)
+		die_errno("cannot create keep file");
+	write_or_die(keep_fd, keep_msg, strlen(keep_msg));
+	if (close(keep_fd))
+		die_errno("failed to write keep file");
+
+	snprintf(name, sizeof(name), "%s/pack/pack-%s.pack",
+		 get_object_directory(), sha1_to_hex(pack_data->sha1));
+	if (move_temp_to_file(pack_data->pack_name, name))
+		die("cannot store pack file");
+
+	snprintf(name, sizeof(name), "%s/pack/pack-%s.idx",
+		 get_object_directory(), sha1_to_hex(pack_data->sha1));
+	if (move_temp_to_file(curr_index_name, name))
+		die("cannot store index file");
+	free((void *)curr_index_name);
+	return name;
+}
+
+static void end_packfile(void)
+{
+	struct packed_git *new_p;
+
+	clear_delta_base_cache();
+	if (objects.nr) {
+		unsigned char cur_pack_sha1[20];
+		char *idx_name;
+
+		close_pack_windows(pack_data);
+		sha1close(pack_file, cur_pack_sha1, 0);
+		fixup_pack_header_footer(pack_data->pack_fd, pack_data->sha1,
+				    pack_data->pack_name, objects.nr,
+				    cur_pack_sha1, pack_size);
+		close(pack_data->pack_fd);
+		idx_name = keep_pack(create_index());
+
+		/* Register the packfile with core git's machinery. */
+		new_p = add_packed_git(idx_name, strlen(idx_name), 1);
+		if (!new_p)
+			die("core git rejected index %s", idx_name);
+		install_packed_git(new_p);
+	}
+	else {
+		close(pack_data->pack_fd);
+		unlink_or_warn(pack_data->pack_name);
+	}
+	free(pack_data);
+
+	/* We can't carry a delta across packfiles. */
+	strbuf_release(&last_blob.data);
+	last_blob.offset = 0;
+	last_blob.depth = 0;
+}
+
+static void cycle_packfile(void)
+{
+	end_packfile();
+	start_packfile();
+}
+
+
+/**
+ * Methods for storing objects
+ */
+
+static int store_object(
+	enum object_type type,
+	struct strbuf *dat,
+	struct last_object *last,
+	unsigned char *sha1out,
+	struct fi_atom *atom)
+{
+	void *out, *delta = NULL;
+	struct fi_object *e;
+	unsigned char hdr[96];
+	unsigned char sha1[20];
+	unsigned long hdrlen, deltalen;
+	git_SHA_CTX c;
+	z_stream s;
+
+
+	/* Construct the header. */
+	hdrlen = sprintf((char *)hdr,"%s %lu", typename(type),
+		(unsigned long)dat->len) + 1;
+	
+	/* Compute the hash of the object. */
+	git_SHA1_Init(&c);
+	git_SHA1_Update(&c, hdr, hdrlen);
+	git_SHA1_Update(&c, dat->buf, dat->len);
+	git_SHA1_Final(sha1, &c);
+
+	if (sha1out)
+		hashcpy(sha1out, sha1);
+	if (atom)
+		insert_mark(atom, sha1);
+
+	/* Determine if we should auto-checkpoint. */
+	if ((max_packsize && (pack_size + 60 + dat->len + hdrlen) > max_packsize)
+		|| (pack_size + 60 + dat->len + hdrlen) < pack_size) {
+		cycle_packfile();
+	}
+	
+	/* Insert the object into our cache, return if it already exists. */
+	e = insert_object(sha1);
+
+	if (e->idx.offset)
+		return 1;
+
+	e->type = type;
+	e->idx.offset = pack_size;
+
+	memset(&s, 0, sizeof(s));
+	deflateInit(&s, pack_compression_level);
+	
+	/* Compress the data, try to create a delta against the last object. */
+	if (last && last->data.buf && last->depth < max_depth && dat->len > 20) {
+		delta = diff_delta(last->data.buf, last->data.len,
+			dat->buf, dat->len, &deltalen, dat->len - 20);
+	}
+
+	/* diff_delta() above can fail and return NULL! */
+	if (delta) {
+		s.next_in = delta;
+		s.avail_in = deltalen;
+	} else {
+		s.next_in = (void *)dat->buf;
+		s.avail_in = dat->len;
+	}
+
+	s.avail_out = deflateBound(&s, s.avail_in);
+	s.next_out = out = xmalloc(s.avail_out);
+	while (deflate(&s, Z_FINISH) == Z_OK)
+		; /* nothing */
+	deflateEnd(&s);
+
+	/* Write the object to the packfile. */
+	crc32_begin(pack_file);
+	if (delta) {
+		off_t ofs = e->idx.offset - last->offset;
+		unsigned pos = sizeof(hdr) - 1;
+
+		e->depth = last->depth + 1;
+
+		hdrlen = encode_in_pack_object_header(OBJ_OFS_DELTA, deltalen, hdr);
+		sha1write(pack_file, hdr, hdrlen);
+		pack_size += hdrlen;
+
+		hdr[pos] = ofs & 127;
+		while (ofs >>= 7)
+			hdr[--pos] = 128 | (--ofs & 127);
+		sha1write(pack_file, hdr + pos, sizeof(hdr) - pos);
+		pack_size += sizeof(hdr) - pos;
+
+		free(delta);
+	} else {
+		e->depth = 0;
+		hdrlen = encode_in_pack_object_header(type, dat->len, hdr);
+		sha1write(pack_file, hdr, hdrlen);
+		pack_size += hdrlen;
+	}
+
+	sha1write(pack_file, out, s.total_out);
+	pack_size += s.total_out;
+	free(out);
+
+	/* Update the cached object. */
+	e->idx.crc32 = crc32_end(pack_file);
+
+	if (last) {
+		if (last->no_swap) {
+			last->data = *dat;
+		} else {
+			strbuf_swap(&last->data, dat);
+		}
+		last->offset = e->idx.offset;
+		last->depth = e->depth;
+	}
+
+	return 0;
+}
+
+static void truncate_pack(off_t to, git_SHA_CTX *ctx)
+{
+	if (ftruncate(pack_data->pack_fd, to)
+	 || lseek(pack_data->pack_fd, to, SEEK_SET) != to)
+		die_errno("cannot truncate pack to skip duplicate");
+	pack_size = to;
+
+	/* yes this is a layering violation */
+	pack_file->total = to;
+	pack_file->offset = 0;
+	pack_file->ctx = *ctx;
+}
+
+static void stream_blob(uintmax_t len, unsigned char *sha1out, struct fi_atom *atom)
+{
+	size_t in_sz = 64 * 1024, out_sz = 64 * 1024;
+	unsigned char *in_buf = xmalloc(in_sz);
+	unsigned char *out_buf = xmalloc(out_sz);
+	struct fi_object *e;
+	unsigned char sha1[20];
+	unsigned long hdrlen;
+	off_t offset;
+	git_SHA_CTX c;
+	git_SHA_CTX pack_file_ctx;
+	z_stream s;
+	int status = Z_OK;
+
+	/* Determine if we should auto-checkpoint. */
+	if ((max_packsize && (pack_size + 60 + len) > max_packsize)
+		|| (pack_size + 60 + len) < pack_size)
+		cycle_packfile();
+
+	offset = pack_size;
+
+	/* preserve the pack_file SHA1 ctx in case we have to truncate later */
+	sha1flush(pack_file);
+	pack_file_ctx = pack_file->ctx;
+
+	hdrlen = snprintf((char *)out_buf, out_sz, "blob %" PRIuMAX, len) + 1;
+	if (out_sz <= hdrlen)
+		die("impossibly large object header");
+
+	git_SHA1_Init(&c);
+	git_SHA1_Update(&c, out_buf, hdrlen);
+
+	crc32_begin(pack_file);
+
+	memset(&s, 0, sizeof(s));
+	deflateInit(&s, pack_compression_level);
+
+	hdrlen = encode_in_pack_object_header(OBJ_BLOB, len, out_buf);
+	if (out_sz <= hdrlen)
+		die("impossibly large object header");
+
+	s.next_out = out_buf + hdrlen;
+	s.avail_out = out_sz - hdrlen;
+
+	while (status != Z_STREAM_END) {
+		if (0 < len && !s.avail_in) {
+			size_t cnt = in_sz < len ? in_sz : (size_t)len;
+			size_t n = fread(in_buf, 1, cnt, stdin);
+			if (!n && feof(stdin))
+				die("EOF in data (%" PRIuMAX " bytes remaining)", len);
+
+			git_SHA1_Update(&c, in_buf, n);
+			s.next_in = in_buf;
+			s.avail_in = n;
+			len -= n;
+		}
+
+		status = deflate(&s, len ? 0 : Z_FINISH);
+
+		if (!s.avail_out || status == Z_STREAM_END) {
+			size_t n = s.next_out - out_buf;
+			sha1write(pack_file, out_buf, n);
+			pack_size += n;
+			s.next_out = out_buf;
+			s.avail_out = out_sz;
+		}
+
+		switch (status) {
+		case Z_OK:
+		case Z_BUF_ERROR:
+		case Z_STREAM_END:
+			continue;
+		default:
+			die("unexpected deflate failure: %d", status);
+		}
+	}
+	deflateEnd(&s);
+	git_SHA1_Final(sha1, &c);
+
+	if (sha1out)
+		hashcpy(sha1out, sha1);
+	if (atom)
+		insert_mark(atom, sha1);
+
+	e = insert_object(sha1);
+
+	if (e->idx.offset) {
+		truncate_pack(offset, &pack_file_ctx);
+	} else {
+		e->depth = 0;
+		e->type = OBJ_BLOB;
+		e->idx.offset = offset;
+		e->idx.crc32 = crc32_end(pack_file);
+	}
+
+	free(in_buf);
+	free(out_buf);
+}
+
+/* All calls must be guarded by find_object() or find_mark() to
+ * ensure the 'struct fi_object' passed was written by this
+ * process instance.  We unpack the entry by the offset, avoiding
+ * the need for the corresponding .idx file.  This unpacking rule
+ * works because we only use OBJ_REF_DELTA within the packfiles
+ * created by fast-import.
+ *
+ * oe must not be NULL.  Such an oe usually comes from giving
+ * an unknown SHA-1 to find_object() or an undefined mark to
+ * find_mark().  Callers must test for this condition and use
+ * the standard read_sha1_file() when it happens.
+ *
+ * oe->pack_id must not be MAX_PACK_ID.  Such an oe is usually from
+ * find_mark(), where the mark was reloaded from an existing marks
+ * file and is referencing an object that this fast-import process
+ * instance did not write out to a packfile.  Callers must test for
+ * this condition and use read_sha1_file() instead.
+ */
+static void *fi_unpack_entry(
+	struct fi_object *oe,
+	enum object_type *type,
+	unsigned long *size)
+{
+	if (pack_data->pack_size < (pack_size + 20)) {
+		/* The object is stored in the packfile we are writing to
+		 * and we have modified it since the last time we scanned
+		 * back to read a previously written object.  If an old
+		 * window covered [p->pack_size, p->pack_size + 20) its
+		 * data is stale and is not valid.  Closing all windows
+		 * and updating the packfile length ensures we can read
+		 * the newly written data.
+		 */
+		close_pack_windows(pack_data);
+		sha1flush(pack_file);
+
+		/* We have to offer 20 bytes additional on the end of
+		 * the packfile as the core unpacker code assumes the
+		 * footer is present at the file end and must promise
+		 * at least 20 bytes within any window it maps.  But
+		 * we don't actually create the footer here.
+		 */
+		pack_data->pack_size = pack_size + 20;
+	}
+	
+	return unpack_entry(pack_data, oe->idx.offset, type, size);
+}
+
+/* Same as read_sha1_file() except that it first looks in our local cache
+ * which holds objects from our current pack. Git doesn't know anything
+ * about those objects until we finish the pack and register it with Git. */
+static void *fi_read_sha1_file(unsigned char sha1[20], enum object_type *type,
+									unsigned long *size)
+{
+	struct fi_object *obj = find_object(sha1);
+	if (obj)
+		return fi_unpack_entry(obj, type, size);
+
+	return read_sha1_file(sha1, type, size);
+}
+
+static enum object_type fi_sha1_object_type(unsigned char sha1[20])
+{
+	struct fi_object *obj = find_object(sha1);
+	if (obj) {
+		return obj->type;
+	}
+
+	return sha1_object_info(sha1, NULL);
+}
+
+
+/**
+ * Tree handling
+ */
+
+static void load_tree(struct fi_tree_entry *root)
+{
+	unsigned char *sha1 = root->versions[1].sha1;
+	struct fi_tree *t;
+	unsigned long size;
+	enum object_type type;
+	char *buf;
+	const char *c;
+
+	root->tree = t = new_tree_content(8);
+	if (is_null_sha1(sha1))
+		return;
+
+	buf = fi_read_sha1_file(sha1, &type, &size);
+	if (!buf || type != OBJ_TREE)
+		die("Can't load tree %s", sha1_to_hex(sha1));
+
+	c = buf;
+	while (c != (buf + size)) {
+		struct fi_tree_entry *e = new_tree_entry();
+
+		if (t->entry_count == t->entry_capacity)
+			root->tree = t = grow_tree_content(t, t->entry_count);
+		t->entries[t->entry_count++] = e;
+
+		e->tree = NULL;
+		c = decode_tree_mode(c, &e->versions[1].mode);
+		if (!c)
+			die("Corrupt mode in %s", sha1_to_hex(sha1));
+		e->versions[0].mode = e->versions[1].mode;
+		e->name = to_atom(c, strlen(c));
+		c += e->name->len + 1;
+		hashcpy(e->versions[0].sha1, (unsigned char *)c);
+		hashcpy(e->versions[1].sha1, (unsigned char *)c);
+		c += 20;
+	}
+	free(buf);
+}
+
+static int tecmp0 (const void *_a, const void *_b)
+{
+	struct fi_tree_entry *a = *((struct fi_tree_entry**)_a);
+	struct fi_tree_entry *b = *((struct fi_tree_entry**)_b);
+	return base_name_compare(
+		a->name->data, a->name->len, a->versions[0].mode,
+		b->name->data, b->name->len, b->versions[0].mode);
+}
+
+static int tecmp1 (const void *_a, const void *_b)
+{
+	struct fi_tree_entry *a = *((struct fi_tree_entry**)_a);
+	struct fi_tree_entry *b = *((struct fi_tree_entry**)_b);
+	return base_name_compare(
+		a->name->data, a->name->len, a->versions[1].mode,
+		b->name->data, b->name->len, b->versions[1].mode);
+}
+
+static void mktree(struct fi_tree *t, int v, struct strbuf *b)
+{
+	size_t maxlen = 0;
+	unsigned int i;
+
+	if (!v)
+		qsort(t->entries,t->entry_count,sizeof(t->entries[0]),tecmp0);
+	else
+		qsort(t->entries,t->entry_count,sizeof(t->entries[0]),tecmp1);
+
+	for (i = 0; i < t->entry_count; i++) {
+		if (t->entries[i]->versions[v].mode)
+			maxlen += t->entries[i]->name->len + 34;
+	}
+
+	strbuf_reset(b);
+	strbuf_grow(b, maxlen);
+	for (i = 0; i < t->entry_count; i++) {
+		struct fi_tree_entry *e = t->entries[i];
+		if (!e->versions[v].mode)
+			continue;
+		strbuf_addf(b, "%o %s%c", (unsigned int)e->versions[v].mode,
+					e->name->data, '\0');
+		strbuf_add(b, e->versions[v].sha1, 20);
+	}
+}
+
+static void store_tree(struct fi_tree_entry *root)
+{
+	struct fi_tree *t = root->tree;
+	unsigned int i, j, del;
+	struct last_object lo = { STRBUF_INIT, 0, 0, /* no_swap */ 1 };
+	struct fi_object *le;
+	struct strbuf new_tree = STRBUF_INIT;
+
+	if (!is_null_sha1(root->versions[1].sha1))
+		return;
+
+	for (i = 0; i < t->entry_count; i++) {
+		if (t->entries[i]->tree)
+			store_tree(t->entries[i]);
+	}
+
+	le = find_object(root->versions[0].sha1);
+	if (S_ISDIR(root->versions[0].mode) && le) {
+		mktree(t, 0, &lo.data);
+		lo.offset = le->idx.offset;
+		lo.depth = t->delta_depth;
+	}
+
+	mktree(t, 1, &new_tree);
+	store_object(OBJ_TREE, &new_tree, &lo, root->versions[1].sha1, NULL);
+
+	t->delta_depth = lo.depth;
+	for (i = 0, j = 0, del = 0; i < t->entry_count; i++) {
+		struct fi_tree_entry *e = t->entries[i];
+		if (e->versions[1].mode) {
+			e->versions[0].mode = e->versions[1].mode;
+			hashcpy(e->versions[0].sha1, e->versions[1].sha1);
+			t->entries[j++] = e;
+		} else {
+			release_tree_entry(e);
+			del++;
+		}
+	}
+	t->entry_count -= del;
+}
+
+static int tree_content_set(
+	struct fi_tree_entry *root,
+	const char *p,
+	const unsigned char *sha1,
+	const uint16_t mode,
+	struct fi_tree *subtree)
+{
+	struct fi_tree *t = root->tree;
+	const char *slash1;
+	unsigned int i, n;
+	struct fi_tree_entry *e;
+
+	slash1 = strchr(p, '/');
+	if (slash1)
+		n = slash1 - p;
+	else
+		n = strlen(p);
+	if (!n)
+		die("Empty path component found in input");
+	if (!slash1 && !S_ISDIR(mode) && subtree)
+		die("Non-directories cannot have subtrees");
+
+	for (i = 0; i < t->entry_count; i++) {
+		e = t->entries[i];
+		if (e->name->len == n && !strncmp(p, e->name->data, n)) {
+			if (!slash1) {
+				if (!S_ISDIR(mode)
+						&& e->versions[1].mode == mode
+						&& !hashcmp(e->versions[1].sha1, sha1))
+					return 0;
+				e->versions[1].mode = mode;
+				hashcpy(e->versions[1].sha1, sha1);
+				if (e->tree)
+					release_tree_content_recursive(e->tree);
+				e->tree = subtree;
+				hashclr(root->versions[1].sha1);
+				return 1;
+			}
+			if (!S_ISDIR(e->versions[1].mode)) {
+				e->tree = new_tree_content(8);
+				e->versions[1].mode = S_IFDIR;
+			}
+			if (!e->tree)
+				load_tree(e);
+			if (tree_content_set(e, slash1 + 1, sha1, mode, subtree)) {
+				hashclr(root->versions[1].sha1);
+				return 1;
+			}
+			return 0;
+		}
+	}
+
+	if (t->entry_count == t->entry_capacity)
+		root->tree = t = grow_tree_content(t, t->entry_count);
+	e = new_tree_entry();
+	e->name = to_atom(p, n);
+	e->versions[0].mode = 0;
+	hashclr(e->versions[0].sha1);
+	t->entries[t->entry_count++] = e;
+	if (slash1) {
+		e->tree = new_tree_content(8);
+		e->versions[1].mode = S_IFDIR;
+		tree_content_set(e, slash1 + 1, sha1, mode, subtree);
+	} else {
+		e->tree = subtree;
+		e->versions[1].mode = mode;
+		hashcpy(e->versions[1].sha1, sha1);
+	}
+	hashclr(root->versions[1].sha1);
+	return 1;
+}
+
+static int tree_content_remove(
+	struct fi_tree_entry *root,
+	const char *p,
+	struct fi_tree_entry *backup_leaf)
+{
+	struct fi_tree *t = root->tree;
+	const char *slash1;
+	unsigned int i, n;
+	struct fi_tree_entry *e;
+
+	slash1 = strchr(p, '/');
+	if (slash1)
+		n = slash1 - p;
+	else
+		n = strlen(p);
+
+	for (i = 0; i < t->entry_count; i++) {
+		e = t->entries[i];
+		if (e->name->len == n && !strncmp(p, e->name->data, n)) {
+			if (slash1 && !S_ISDIR(e->versions[1].mode))
+				/*
+				 * If p names a file in some subdirectory, and a
+				 * file or symlink matching the name of the
+				 * parent directory of p exists, then p cannot
+				 * exist and need not be deleted.
+				 */
+				return 1;
+			if (!slash1 || !S_ISDIR(e->versions[1].mode))
+				goto del_entry;
+			if (!e->tree)
+				load_tree(e);
+			if (tree_content_remove(e, slash1 + 1, backup_leaf)) {
+				for (n = 0; n < e->tree->entry_count; n++) {
+					if (e->tree->entries[n]->versions[1].mode) {
+						hashclr(root->versions[1].sha1);
+						return 1;
+					}
+				}
+				backup_leaf = NULL;
+				goto del_entry;
+			}
+			return 0;
+		}
+	}
+	return 0;
+
+del_entry:
+	if (backup_leaf)
+		memcpy(backup_leaf, e, sizeof(*backup_leaf));
+	else if (e->tree)
+		release_tree_content_recursive(e->tree);
+	e->tree = NULL;
+	e->versions[1].mode = 0;
+	hashclr(e->versions[1].sha1);
+	hashclr(root->versions[1].sha1);
+	return 1;
+}
+
+static int tree_content_get(
+	struct fi_tree_entry *root,
+	const char *p,
+	struct fi_tree_entry *leaf)
+{
+	struct fi_tree *t = root->tree;
+	const char *slash1;
+	unsigned int i, n;
+	struct fi_tree_entry *e;
+
+	slash1 = strchr(p, '/');
+	if (slash1)
+		n = slash1 - p;
+	else
+		n = strlen(p);
+
+	for (i = 0; i < t->entry_count; i++) {
+		e = t->entries[i];
+		if (e->name->len == n && !strncmp(p, e->name->data, n)) {
+			if (!slash1) {
+				memcpy(leaf, e, sizeof(*leaf));
+				if (e->tree && is_null_sha1(e->versions[1].sha1))
+					leaf->tree = dup_tree_content(e->tree);
+				else
+					leaf->tree = NULL;
+				return 1;
+			}
+			if (!S_ISDIR(e->versions[1].mode))
+				return 0;
+			if (!e->tree)
+				load_tree(e);
+			return tree_content_get(e, slash1 + 1, leaf);
+		}
+	}
+	return 0;
+}
+
+/* Parse the optional mark from the stream and return the associated atom. */
+static struct fi_atom *parse_mark(void)
+{
+	struct fi_atom *atom = NULL;
+
+	if (!prefixcmp(command_buf.buf, "mark :")) {
+		atom = to_atom(command_buf.buf + 6, strlen(command_buf.buf + 6));
+		read_next_command();
+	}
+
+	return atom;
+}
+
+static int parse_data(struct strbuf *sb, uintmax_t limit, uintmax_t *len_res)
+{
+	strbuf_reset(sb);
+
+	if (prefixcmp(command_buf.buf, "data "))
+		die("Expected 'data n' command, found: %s", command_buf.buf);
+
+	if (!prefixcmp(command_buf.buf + 5, "<<")) {
+		char *term = xstrdup(command_buf.buf + 5 + 2);
+		size_t term_len = command_buf.len - 5 - 2;
+
+		strbuf_detach(&command_buf, NULL);
+		for (;;) {
+			if (strbuf_getline(&command_buf, stdin, '\n') == EOF)
+				die("EOF in data (terminator '%s' not found)", term);
+			if (term_len == command_buf.len
+				&& !strcmp(term, command_buf.buf))
+				break;
+			strbuf_addbuf(sb, &command_buf);
+			strbuf_addch(sb, '\n');
+		}
+		free(term);
+	}
+	else {
+		uintmax_t len = strtoumax(command_buf.buf + 5, NULL, 10);
+		size_t n = 0, length = (size_t)len;
+
+		if (limit && limit < len) {
+			*len_res = len;
+			return 0;
+		}
+		if (length < len)
+			die("data is too large to use in this context");
+
+		while (n < length) {
+			size_t s = strbuf_fread(sb, length - n, stdin);
+			if (!s && feof(stdin))
+				die("EOF in data (%lu bytes remaining)",
+					(unsigned long)(length - n));
+			n += s;
+		}
+	}
+
+	read_next_command();
+	skip_optional_lf();
+	return 1;
+}
+
+static int validate_raw_date(const char *src, char *result, int maxlen)
+{
+	const char *orig_src = src;
+	char *endp;
+	unsigned long num;
+
+	errno = 0;
+
+	num = strtoul(src, &endp, 10);
+	/* NEEDSWORK: perhaps check for reasonable values? */
+	if (errno || endp == src || *endp != ' ')
+		return -1;
+
+	src = endp + 1;
+	if (*src != '-' && *src != '+')
+		return -1;
+
+	num = strtoul(src + 1, &endp, 10);
+	if (errno || endp == src + 1 || *endp || (endp - orig_src) >= maxlen ||
+	    1400 < num)
+		return -1;
+
+	strcpy(result, orig_src);
+	return 0;
+}
+
+static char *parse_ident(const char *buf)
+{
+	const char *gt;
+	size_t name_len;
+	char *ident;
+
+	gt = strrchr(buf, '>');
+	if (!gt)
+		die("Missing > in ident string: %s", buf);
+	gt++;
+	if (*gt != ' ')
+		die("Missing space after > in ident string: %s", buf);
+	gt++;
+	name_len = gt - buf;
+	ident = xmalloc(name_len + 24);
+	strncpy(ident, buf, name_len);
+
+	switch (whenspec) {
+	case WHENSPEC_RAW:
+		if (validate_raw_date(gt, ident + name_len, 24) < 0)
+			die("Invalid raw date \"%s\" in ident: %s", gt, buf);
+		break;
+	case WHENSPEC_RFC2822:
+		if (parse_date(gt, ident + name_len, 24) < 0)
+			die("Invalid rfc2822 date \"%s\" in ident: %s", gt, buf);
+		break;
+	case WHENSPEC_NOW:
+		if (strcmp("now", gt))
+			die("Date in ident must be 'now': %s", buf);
+		datestamp(ident + name_len, 24);
+		break;
+	}
+
+	return ident;
+}
+
+static void parse_and_store_blob(
+	struct last_object *last,
+	unsigned char *sha1out,
+	struct fi_atom *atom)
+{
+	static struct strbuf buf = STRBUF_INIT;
+	uintmax_t len;
+
+	if (parse_data(&buf, big_file_threshold, &len))
+		store_object(OBJ_BLOB, &buf, last, sha1out, atom);
+	else {
+		if (last) {
+			strbuf_release(&last->data);
+			last->offset = 0;
+			last->depth = 0;
+		}
+		stream_blob(len, sha1out, atom);
+		skip_optional_lf();
+	}
+}
+
+static void unload_one_branch(void)
+{
+	while (cur_active_branches
+		&& cur_active_branches >= max_active_branches) {
+		struct fi_branch *e, *p = active_branches;
+
+		if (p) {
+			e = p->active_next_branch;
+			p->active_next_branch = e->active_next_branch;
+		} else {
+			e = active_branches;
+			active_branches = e->active_next_branch;
+		}
+		e->active = 0;
+		e->active_next_branch = NULL;
+		if (e->branch_tree.tree) {
+			release_tree_content_recursive(e->branch_tree.tree);
+			e->branch_tree.tree = NULL;
+		}
+		cur_active_branches--;
+	}
+}
+
+static void load_branch(struct fi_branch *b)
+{
+	load_tree(&b->branch_tree);
+	if (!b->active) {
+		b->active = 1;
+		b->active_next_branch = active_branches;
+		active_branches = b;
+		cur_active_branches++;
+	}
+}
+
+static unsigned char convert_num_notes_to_fanout(uintmax_t num_notes)
+{
+	unsigned char fanout = 0;
+	while ((num_notes >>= 8))
+		fanout++;
+	return fanout;
+}
+
+static void construct_path_with_fanout(const char *hex_sha1,
+		unsigned char fanout, char *path)
+{
+	unsigned int i = 0, j = 0;
+	if (fanout >= 20)
+		die("Too large fanout (%u)", fanout);
+	while (fanout) {
+		path[i++] = hex_sha1[j++];
+		path[i++] = hex_sha1[j++];
+		path[i++] = '/';
+		fanout--;
+	}
+	memcpy(path + i, hex_sha1 + j, 40 - j);
+	path[i + 40 - j] = '\0';
+}
+
+static uintmax_t do_change_note_fanout(
+		struct fi_tree_entry *orig_root, struct fi_tree_entry *root,
+		char *hex_sha1, unsigned int hex_sha1_len,
+		char *fullpath, unsigned int fullpath_len,
+		unsigned char fanout)
+{
+	struct fi_tree *t = root->tree;
+	struct fi_tree_entry *e, leaf;
+	unsigned int i, tmp_hex_sha1_len, tmp_fullpath_len;
+	uintmax_t num_notes = 0;
+	unsigned char sha1[20];
+	char realpath[60];
+
+	for (i = 0; t && i < t->entry_count; i++) {
+		e = t->entries[i];
+		tmp_hex_sha1_len = hex_sha1_len + e->name->len;
+		tmp_fullpath_len = fullpath_len;
+
+		/*
+		 * We're interested in EITHER existing note entries (entries
+		 * with exactly 40 hex chars in path, not including directory
+		 * separators), OR directory entries that may contain note
+		 * entries (with < 40 hex chars in path).
+		 * Also, each path component in a note entry must be a multiple
+		 * of 2 chars.
+		 */
+		if (!e->versions[1].mode ||
+		    tmp_hex_sha1_len > 40 ||
+		    e->name->len % 2)
+			continue;
+
+		/* This _may_ be a note entry, or a subdir containing notes */
+		memcpy(hex_sha1 + hex_sha1_len, e->name->data,
+		       e->name->len);
+		if (tmp_fullpath_len)
+			fullpath[tmp_fullpath_len++] = '/';
+		memcpy(fullpath + tmp_fullpath_len, e->name->data,
+		       e->name->len);
+		tmp_fullpath_len += e->name->len;
+		fullpath[tmp_fullpath_len] = '\0';
+
+		if (tmp_hex_sha1_len == 40 && !get_sha1_hex(hex_sha1, sha1)) {
+			/* This is a note entry */
+			construct_path_with_fanout(hex_sha1, fanout, realpath);
+			if (!strcmp(fullpath, realpath)) {
+				/* Note entry is in correct location */
+				num_notes++;
+				continue;
+			}
+
+			/* Rename fullpath to realpath */
+			if (!tree_content_remove(orig_root, fullpath, &leaf))
+				die("Failed to remove path %s", fullpath);
+			tree_content_set(orig_root, realpath,
+				leaf.versions[1].sha1,
+				leaf.versions[1].mode,
+				leaf.tree);
+		} else if (S_ISDIR(e->versions[1].mode)) {
+			/* This is a subdir that may contain note entries */
+			if (!e->tree)
+				load_tree(e);
+			num_notes += do_change_note_fanout(orig_root, e,
+				hex_sha1, tmp_hex_sha1_len,
+				fullpath, tmp_fullpath_len, fanout);
+		}
+
+		/* The above may have reallocated the current tree_content */
+		t = root->tree;
+	}
+	return num_notes;
+}
+
+static uintmax_t change_note_fanout(struct fi_tree_entry *root,
+		unsigned char fanout)
+{
+	char hex_sha1[40], path[60];
+	return do_change_note_fanout(root, root, hex_sha1, 0, path, 0, fanout);
+}
+
+static void file_change_m(struct fi_branch *b)
+{
+	const char *p = command_buf.buf + 2;
+	static struct strbuf uq = STRBUF_INIT;
+	const char *endp;
+	struct fi_object *oe = NULL;
+	unsigned char sha1[20];
+	unsigned int mode, inline_data = 0;
+
+	p = decode_tree_mode(p, &mode);
+	if (!p)
+		die("Corrupt mode: %s", command_buf.buf);
+	switch (mode) {
+	case 0644:
+	case 0755:
+		mode |= S_IFREG;
+	case S_IFREG | 0644:
+	case S_IFREG | 0755:
+	case S_IFLNK:
+	case S_IFDIR:
+	case S_IFGITLINK:
+		/* ok */
+		break;
+	default:
+		die("Corrupt mode: %s", command_buf.buf);
+	}
+
+	if (*p == ':') {
+		p = find_mark(p + 1, sha1);
+	} else if (!prefixcmp(p, "inline")) {
+		inline_data = 1;
+		p += 6;
+	} else {
+		if (get_sha1_hex(p, sha1))
+			die("Invalid SHA1: %s", command_buf.buf);
+		p += 40;
+	}
+	if (*p++ != ' ')
+		die("Missing space after SHA1: %s", command_buf.buf);
+
+	strbuf_reset(&uq);
+	if (!unquote_c_style(&uq, p, &endp)) {
+		if (*endp)
+			die("Garbage after path in: %s", command_buf.buf);
+		p = uq.buf;
+	}
+
+	if (S_ISGITLINK(mode)) {
+		if (inline_data)
+			die("Git links cannot be specified 'inline': %s",
+				command_buf.buf);
+		else if (oe) {
+			if (oe->type != OBJ_COMMIT)
+				die("Not a commit (actually a %s): %s",
+					typename(oe->type), command_buf.buf);
+		}
+		/*
+		 * Accept the sha1 without checking; it expected to be in
+		 * another repository.
+		 */
+	} else if (inline_data) {
+		if (S_ISDIR(mode))
+			die("Directories cannot be specified 'inline': %s",
+				command_buf.buf);
+		if (p != uq.buf) {
+			strbuf_addstr(&uq, p);
+			p = uq.buf;
+		}
+		read_next_command();
+		parse_and_store_blob(&last_blob, sha1, 0);
+	} else {
+		enum object_type expected = S_ISDIR(mode) ?
+						OBJ_TREE: OBJ_BLOB;
+		enum object_type type = fi_sha1_object_type(sha1);
+		if (type < 0)
+			die("%s not found: %s",
+					S_ISDIR(mode) ?  "Tree" : "Blob",
+					command_buf.buf);
+		if (type != expected)
+			die("Not a %s (actually a %s): %s %s",
+				typename(expected), typename(type),
+				command_buf.buf, sha1_to_hex(sha1));
+	}
+
+	tree_content_set(&b->branch_tree, p, sha1, mode, NULL);
+}
+
+static void file_change_d(struct fi_branch *b)
+{
+	const char *p = command_buf.buf + 2;
+	static struct strbuf uq = STRBUF_INIT;
+	const char *endp;
+
+	strbuf_reset(&uq);
+	if (!unquote_c_style(&uq, p, &endp)) {
+		if (*endp)
+			die("Garbage after path in: %s", command_buf.buf);
+		p = uq.buf;
+	}
+	tree_content_remove(&b->branch_tree, p, NULL);
+}
+
+static void file_change_cr(struct fi_branch *b, int rename)
+{
+	const char *s, *d;
+	static struct strbuf s_uq = STRBUF_INIT;
+	static struct strbuf d_uq = STRBUF_INIT;
+	const char *endp;
+	struct fi_tree_entry leaf;
+
+	s = command_buf.buf + 2;
+	strbuf_reset(&s_uq);
+	if (!unquote_c_style(&s_uq, s, &endp)) {
+		if (*endp != ' ')
+			die("Missing space after source: %s", command_buf.buf);
+	} else {
+		endp = strchr(s, ' ');
+		if (!endp)
+			die("Missing space after source: %s", command_buf.buf);
+		strbuf_add(&s_uq, s, endp - s);
+	}
+	s = s_uq.buf;
+
+	endp++;
+	if (!*endp)
+		die("Missing dest: %s", command_buf.buf);
+
+	d = endp;
+	strbuf_reset(&d_uq);
+	if (!unquote_c_style(&d_uq, d, &endp)) {
+		if (*endp)
+			die("Garbage after dest in: %s", command_buf.buf);
+		d = d_uq.buf;
+	}
+
+	memset(&leaf, 0, sizeof(leaf));
+	if (rename)
+		tree_content_remove(&b->branch_tree, s, &leaf);
+	else
+		tree_content_get(&b->branch_tree, s, &leaf);
+	if (!leaf.versions[1].mode)
+		die("Path %s not in branch", s);
+	tree_content_set(&b->branch_tree, d,
+		leaf.versions[1].sha1,
+		leaf.versions[1].mode,
+		leaf.tree);
+}
+
+static void note_change_n(struct fi_branch *b, unsigned char old_fanout)
+{
+	const char *p = command_buf.buf + 2;
+	static struct strbuf uq = STRBUF_INIT;
+	struct fi_object *oe = oe;
+	struct fi_branch *s;
+	unsigned char sha1[20], commit_sha1[20];
+	char path[60];
+	uint16_t inline_data = 0;
+	unsigned char new_fanout;
+
+	/* <dataref> or 'inline' */
+	if (*p == ':') {
+		p = find_mark(p + 1, sha1);
+	} else if (!prefixcmp(p, "inline")) {
+		inline_data = 1;
+		p += 6;
+	} else {
+		if (get_sha1_hex(p, sha1))
+			die("Invalid SHA1: %s", command_buf.buf);
+		oe = find_object(sha1);
+		p += 40;
+	}
+	if (*p++ != ' ')
+		die("Missing space after SHA1: %s", command_buf.buf);
+
+	/* <committish> */
+	s = lookup_branch(p);
+	if (s) {
+		hashcpy(commit_sha1, s->sha1);
+	} else if (*p == ':') {
+		find_mark(p + 1, commit_sha1);
+	} else if (!get_sha1(p, commit_sha1)) {
+		enum object_type type;
+		type = fi_sha1_object_type(commit_sha1);
+		if (type != OBJ_COMMIT)
+			die("Can only add notes to commits");
+	} else
+		die("Invalid ref name or SHA1 expression: %s", p);
+
+	if (inline_data) {
+		if (p != uq.buf) {
+			strbuf_addstr(&uq, p);
+			p = uq.buf;
+		}
+		read_next_command();
+		parse_and_store_blob(&last_blob, sha1, 0);
+	} else if (oe) {
+		if (oe->type != OBJ_BLOB)
+			die("Not a blob (actually a %s): %s",
+				typename(oe->type), command_buf.buf);
+	} else if (!is_null_sha1(sha1)) {
+		enum object_type type = fi_sha1_object_type(sha1);
+		if (type < 0)
+			die("Blob not found: %s", command_buf.buf);
+		if (type != OBJ_BLOB)
+			die("Not a blob (actually a %s): %s",
+			    typename(type), command_buf.buf);
+	}
+
+	construct_path_with_fanout(sha1_to_hex(commit_sha1), old_fanout, path);
+	if (tree_content_remove(&b->branch_tree, path, NULL))
+		b->num_notes--;
+
+	if (is_null_sha1(sha1))
+		return; /* nothing to insert */
+
+	b->num_notes++;
+	new_fanout = convert_num_notes_to_fanout(b->num_notes);
+	construct_path_with_fanout(sha1_to_hex(commit_sha1), new_fanout, path);
+	tree_content_set(&b->branch_tree, path, sha1, S_IFREG | 0644, NULL);
+}
+
+static void file_change_deleteall(struct fi_branch *b)
+{
+	release_tree_content_recursive(b->branch_tree.tree);
+	hashclr(b->branch_tree.versions[0].sha1);
+	hashclr(b->branch_tree.versions[1].sha1);
+	load_tree(&b->branch_tree);
+	b->num_notes = 0;
+}
+
+static void parse_from_commit(struct fi_branch *b, char *buf, unsigned long size)
+{
+	if (!buf || size < 46)
+		die("Not a valid commit: %s", sha1_to_hex(b->sha1));
+	if (memcmp("tree ", buf, 5)
+		|| get_sha1_hex(buf + 5, b->branch_tree.versions[1].sha1))
+		die("The commit %s is corrupt", sha1_to_hex(b->sha1));
+	hashcpy(b->branch_tree.versions[0].sha1,
+		b->branch_tree.versions[1].sha1);
+}
+
+static void parse_from_existing(struct fi_branch *b)
+{
+	if (is_null_sha1(b->sha1)) {
+		hashclr(b->branch_tree.versions[0].sha1);
+		hashclr(b->branch_tree.versions[1].sha1);
+	} else {
+		unsigned long size;
+		enum object_type type;
+		char *buf;
+
+		buf = fi_read_sha1_file(b->sha1, &type, &size);
+		parse_from_commit(b, buf, size);
+		free(buf);
+	}
+}
+
+static int parse_from(struct fi_branch *b)
+{
+	const char *from;
+	struct fi_branch *s;
+
+	if (prefixcmp(command_buf.buf, "from "))
+		return 0;
+
+	if (b->branch_tree.tree) {
+		release_tree_content_recursive(b->branch_tree.tree);
+		b->branch_tree.tree = NULL;
+	}
+
+	from = strchr(command_buf.buf, ' ') + 1;
+	s = lookup_branch(from);
+	if (b == s)
+		die("Can't create a branch from itself: %s", b->name);
+	else if (s) {
+		unsigned char *t = s->branch_tree.versions[1].sha1;
+		hashcpy(b->sha1, s->sha1);
+		hashcpy(b->branch_tree.versions[0].sha1, t);
+		hashcpy(b->branch_tree.versions[1].sha1, t);
+	} else if (*from == ':') {
+		find_mark(from + 1, b->sha1);
+		if (!is_null_sha1(b->sha1)) {
+			unsigned long size;
+			enum object_type type;
+			char *buf = fi_read_sha1_file(b->sha1, &type, &size);
+			parse_from_commit(b, buf, size);
+			free(buf);
+		} else
+			parse_from_existing(b);
+	} else if (!get_sha1(from, b->sha1))
+		parse_from_existing(b);
+	else
+		die("Invalid ref name or SHA1 expression: %s", from);
+
+	read_next_command();
+	return 1;
+}
+
+static struct hash_list *parse_merge(unsigned int *count)
+{
+	struct hash_list *list = NULL, *n, *e = e;
+	const char *from;
+	struct fi_branch *s;
+
+	*count = 0;
+	while (!prefixcmp(command_buf.buf, "merge ")) {
+		from = strchr(command_buf.buf, ' ') + 1;
+		n = xmalloc(sizeof(*n));
+		s = lookup_branch(from);
+		if (s)
+			hashcpy(n->sha1, s->sha1);
+		else if (*from == ':') {
+			find_mark(from + 1, n->sha1);
+		} else if (!get_sha1(from, n->sha1)) {
+			unsigned long size;
+			char *buf = read_object_with_reference(n->sha1,
+				commit_type, &size, n->sha1);
+			if (!buf || size < 46)
+				die("Not a valid commit: %s", from);
+			free(buf);
+		} else
+			die("Invalid ref name or SHA1 expression: %s", from);
+
+		n->next = NULL;
+		if (list)
+			e->next = n;
+		else
+			list = n;
+		e = n;
+		(*count)++;
+		read_next_command();
+	}
+	return list;
+}
+
+static int fi_command_commit(void)
+{
+	static struct strbuf msg = STRBUF_INIT;
+	static struct strbuf new_data = STRBUF_INIT;
+	struct fi_branch *b;
+	struct fi_atom *atom;
+	char *sp;
+	char *author = NULL;
+	char *committer = NULL;
+	struct hash_list *merge_list = NULL;
+	unsigned int merge_count;
+	unsigned char prev_fanout, new_fanout;
+
+	/* Obtain the branch name from the rest of our command */
+	sp = strchr(command_buf.buf, ' ') + 1;
+	b = lookup_branch(sp);
+	if (!b)
+		b = new_branch(sp);
+
+	read_next_command();
+	atom = parse_mark();
+	if (!prefixcmp(command_buf.buf, "author ")) {
+		author = parse_ident(command_buf.buf + 7);
+		read_next_command();
+	}
+	if (!prefixcmp(command_buf.buf, "committer ")) {
+		committer = parse_ident(command_buf.buf + 10);
+		read_next_command();
+	}
+	if (!committer)
+		die("Expected committer but didn't get one");
+	parse_data(&msg, 0, NULL);
+	//read_next_command();
+	parse_from(b);
+	merge_list = parse_merge(&merge_count);
+
+	/* ensure the branch is active/loaded */
+	if (!b->branch_tree.tree || !max_active_branches) {
+		unload_one_branch();
+		load_branch(b);
+	}
+
+	prev_fanout = convert_num_notes_to_fanout(b->num_notes);
+
+	/* file_change* */
+	while (command_buf.len > 0) {
+		if (!prefixcmp(command_buf.buf, "M "))
+			file_change_m(b);
+		else if (!prefixcmp(command_buf.buf, "D "))
+			file_change_d(b);
+		else if (!prefixcmp(command_buf.buf, "R "))
+			file_change_cr(b, 1);
+		else if (!prefixcmp(command_buf.buf, "C "))
+			file_change_cr(b, 0);
+		else if (!prefixcmp(command_buf.buf, "N "))
+			note_change_n(b, prev_fanout);
+		else if (!strcmp("deleteall", command_buf.buf))
+			file_change_deleteall(b);
+		else
+			break;
+
+		if (read_next_command() == EOF)
+			break;
+	}
+
+	new_fanout = convert_num_notes_to_fanout(b->num_notes);
+	if (new_fanout != prev_fanout)
+		b->num_notes = change_note_fanout(&b->branch_tree, new_fanout);
+
+	/* build the tree and the commit */
+	store_tree(&b->branch_tree);
+	hashcpy(b->branch_tree.versions[0].sha1,
+		b->branch_tree.versions[1].sha1);
+
+	strbuf_reset(&new_data);
+	strbuf_addf(&new_data, "tree %s\n",
+		sha1_to_hex(b->branch_tree.versions[1].sha1));
+	if (!is_null_sha1(b->sha1))
+		strbuf_addf(&new_data, "parent %s\n", sha1_to_hex(b->sha1));
+	while (merge_list) {
+		struct hash_list *next = merge_list->next;
+		strbuf_addf(&new_data, "parent %s\n", sha1_to_hex(merge_list->sha1));
+		free(merge_list);
+		merge_list = next;
+	}
+	strbuf_addf(&new_data,
+		"author %s\n"
+		"committer %s\n"
+		"\n",
+		author ? author : committer, committer);
+	strbuf_addbuf(&new_data, &msg);
+	free(author);
+	free(committer);
+
+	store_object(OBJ_COMMIT, &new_data, NULL, b->sha1, atom);
+
+	read_next_command();
+	return 0;
+}
+
+static int fi_command_tag(void)
+{
+	static struct strbuf msg = STRBUF_INIT;
+	static struct strbuf new_data = STRBUF_INIT;
+	char *sp;
+	const char *from;
+	char *tagger;
+	struct fi_branch *s;
+	struct fi_tag *t;
+	int hash;
+	unsigned char sha1[20];
+	enum object_type type;
+
+	/* Obtain the new tag name from the rest of our command */
+	sp = strchr(command_buf.buf, ' ') + 1;
+	hash = hc_str(sp, strlen(sp));
+
+	t = malloc(sizeof(struct fi_tag));
+	t->next_tag = lookup_hash(hash, &tags);
+	t->name = strdup(sp);
+	insert_hash(hash, t, &tags);
+	
+	read_next_command();
+
+	/* from ... */
+	if (prefixcmp(command_buf.buf, "from "))
+		die("Expected from command, got %s", command_buf.buf);
+	from = strchr(command_buf.buf, ' ') + 1;
+	s = lookup_branch(from);
+	if (s) {
+		hashcpy(sha1, s->sha1);
+	} else if (*from == ':') {
+		find_mark(from + 1, sha1);
+	} else if (get_sha1(from, sha1)) {
+		die("Invalid ref name or SHA1 expression: %s", from);
+	}
+
+	type = fi_sha1_object_type(sha1);
+	read_next_command();
+
+	/* tagger ... */
+	if (!prefixcmp(command_buf.buf, "tagger ")) {
+		tagger = parse_ident(command_buf.buf + 7);
+		read_next_command();
+	} else
+		tagger = NULL;
+
+	/* tag payload/message */
+	parse_data(&msg, 0, NULL);
+
+	/* build the tag object */
+	strbuf_reset(&new_data);
+
+	strbuf_addf(&new_data,
+		    "object %s\n"
+		    "type %s\n"
+		    "tag %s\n",
+		    sha1_to_hex(sha1), typename(type), t->name);
+	if (tagger)
+		strbuf_addf(&new_data,
+			    "tagger %s\n", tagger);
+	strbuf_addch(&new_data, '\n');
+	strbuf_addbuf(&new_data, &msg);
+	free(tagger);
+
+	store_object(OBJ_TAG, &new_data, NULL, t->sha1, NULL);
+
+	read_next_command();
+	return 0;
+}
+
+static int fi_command_reset(void)
+{
+	struct fi_branch *b;
+	char *sp;
+
+	/* Obtain the branch name from the rest of our command */
+	sp = strchr(command_buf.buf, ' ') + 1;
+	b = lookup_branch(sp);
+	if (b) {
+		hashclr(b->sha1);
+		hashclr(b->branch_tree.versions[0].sha1);
+		hashclr(b->branch_tree.versions[1].sha1);
+		if (b->branch_tree.tree) {
+			release_tree_content_recursive(b->branch_tree.tree);
+			b->branch_tree.tree = NULL;
+		}
+	}
+	else
+		b = new_branch(sp);
+	read_next_command();
+	parse_from(b);
+
+	return 0;
+}
+
+static int fi_command_blob(void)
+{
+	struct fi_atom *atom;
+
+	read_next_command();
+	atom = parse_mark();
+	parse_and_store_blob(&last_blob, NULL, atom);
+	
+	read_next_command();
+	return 0;
+}
+
+static int fi_command_checkpoint(void)
+{
+	if (objects.nr) {
+		cycle_packfile();
+	}
+	skip_optional_lf();
+	
+	read_next_command();
+	return 0;
+}
+
+static int fi_command_progress(void)
+{
+	skip_optional_lf();
+	read_next_command();
+	return 0;
+}
+
+static int fi_command_feature(void)
+{
+	char *feature = command_buf.buf + 8;
+
+	if (!prefixcmp(feature, "date-format=")) {
+		char *fmt = feature + 12;
+		if (!strcmp(fmt, "raw")) {
+			whenspec = WHENSPEC_RAW;
+		} else if (!strcmp(fmt, "rfc2822")) {
+			whenspec = WHENSPEC_RFC2822;
+		} else if (!strcmp(fmt, "now")) {
+			whenspec = WHENSPEC_NOW;
+		} else {
+			return 1;
+		}
+	} else if (!prefixcmp(feature, "force")) {
+		force_update = 1;
+	} else {
+		return 1;
+	}
+
+	read_next_command();
+	return 0;
+}
+
+static int fi_command_option(void)
+{
+	read_next_command();
+	return 0;
+}
+
+/* mark SP :<name> SP <value> LF 	*/
+static int fi_command_mark(void)
+{
+	struct fi_atom *atom;
+	unsigned char sha1[20];
+	char *end = strchr(command_buf.buf + 6, ' ');
+
+	atom = to_atom(command_buf.buf + 6, end - command_buf.buf - 6);
+	if (get_sha1(end + 1, sha1))
+		die("Invalid mark command: %s", command_buf.buf);
+
+	insert_mark(atom, sha1);
+
+	read_next_command();
+	return 0;
+}
+
+/* List of commands we understand. */
+struct fi_command {
+	const char *cmd;
+	int (*func)(void);
+} fi_command[] = {
+	{ "commit",		fi_command_commit },
+	{ "tag",		fi_command_tag },
+	{ "reset",		fi_command_reset },
+	{ "blob",		fi_command_blob },
+	{ "checkpoint",		fi_command_checkpoint },
+	{ "progress",		fi_command_progress },
+	{ "feature",		fi_command_feature },
+	{ "option",		fi_command_option },
+	{ "mark",		fi_command_mark },
+};
+
+static struct fi_command *find_command(const char *cmd)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(fi_command); ++i) {
+		if (!prefixcmp(command_buf.buf, fi_command[i].cmd)) {
+			return &fi_command[i];
+		}
+	}
+
+	return NULL;
+}
+
+int main(int argc, const char **argv)
+{
+	git_extract_argv0_path(argv[0]);
+
+	setup_git_directory();
+	git_config(git_pack_config, NULL);
+	if (!pack_compression_seen && core_compression_seen)
+		pack_compression_level = core_compression_level;
+
+	set_die_routine(die_nicely);
+
+	/* Initialize hash tables. */
+	init_hash(&atoms);
+	init_hash(&tags);
+	init_hash(&branches);
+	init_hash(&marks);
+	init_hash(&objects);
+	
+	prepare_packed_git();
+	start_packfile();
+	
+	read_next_command();
+	while (command_buf.len > 0) {
+		struct fi_command *cmd = find_command(command_buf.buf);
+		if (!cmd)
+			die("Unsupported command: %s", command_buf.buf);
+
+		int err = (*cmd->func)();
+		if (err)
+			die("Command failed");
+
+		fflush(stdout);
+	}
+	
+	end_packfile();
+
+	return 0;
+}
-- 
1.7.3.37.gb6088b
