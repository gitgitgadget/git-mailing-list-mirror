From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 4/6] Add update-server-info.
Date: Sat, 23 Jul 2005 17:54:41 -0700
Message-ID: <7vzmsdja5q.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 24 02:54:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DwUlZ-0004QM-3y
	for gcvg-git@gmane.org; Sun, 24 Jul 2005 02:54:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262114AbVGXAyr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Jul 2005 20:54:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262143AbVGXAyr
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jul 2005 20:54:47 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:51704 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S262114AbVGXAyo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jul 2005 20:54:44 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050724005439.TEKF8651.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 23 Jul 2005 20:54:39 -0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

The git-update-server-info command prepares informational files
to help clients discover the contents of a repository, and pull
from it via a dumb transport protocols.  Currently, the
following files are produced.

 - The $repo/info/refs file lists the name of heads and tags
   available in the $repo/refs/ directory, along with their
   SHA1.  This can be used by git-ls-remote command running on
   the client side.

 - The $repo/info/rev-cache file describes the commit ancestry
   reachable from references in the $repo/refs/ directory.  This
   file is in an append-only binary format to make the server
   side friendly to rsync mirroring scheme, and can be read by
   git-show-rev-cache command.

 - The $repo/objects/info/pack file lists the name of the packs
   available, the interdependencies among them, and the head
   commits and tags contained in them.  Along with the other two
   files, this is designed to help clients to make smart pull
   decisions.

The git-receive-pack command is changed to invoke it at the end,
so just after a push to a public repository finishes via "git
push", the server info is automatically updated.

In addition, building of the rev-cache file can be done by a
standalone git-build-rev-cache command separately.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 Makefile             |   11 +
 build-rev-cache.c    |   56 +++++
 cache.h              |    3 
 receive-pack.c       |    1 
 rev-cache.c          |  320 ++++++++++++++++++++++++++++
 rev-cache.h          |   29 +++
 server-info.c        |  565 ++++++++++++++++++++++++++++++++++++++++++++++++++
 show-rev-cache.c     |   18 ++
 update-server-info.c |   23 ++
 9 files changed, 1025 insertions(+), 1 deletions(-)
 create mode 100644 build-rev-cache.c
 create mode 100644 rev-cache.c
 create mode 100644 rev-cache.h
 create mode 100644 server-info.c
 create mode 100644 show-rev-cache.c
 create mode 100644 update-server-info.c

895f412b3df0a9a4884db6231bb590fd1e388db7
diff --git a/Makefile b/Makefile
--- a/Makefile
+++ b/Makefile
@@ -50,7 +50,8 @@ PROG=   git-update-cache git-diff-files 
 	git-diff-stages git-rev-parse git-patch-id git-pack-objects \
 	git-unpack-objects git-verify-pack git-receive-pack git-send-pack \
 	git-prune-packed git-fetch-pack git-upload-pack git-clone-pack \
-	git-show-index git-daemon git-var git-peek-remote
+	git-show-index git-daemon git-var git-peek-remote \
+	git-update-server-info git-show-rev-cache git-build-rev-cache
 
 all: $(PROG)
 
@@ -65,6 +66,9 @@ LIB_FILE=libgit.a
 LIB_H=cache.h object.h blob.h tree.h commit.h tag.h delta.h epoch.h csum-file.h \
 	pack.h pkt-line.h refs.h
 
+LIB_H += rev-cache.h
+LIB_OBJS += rev-cache.o
+
 LIB_H += strbuf.h
 LIB_OBJS += strbuf.o
 
@@ -76,6 +80,7 @@ LIB_OBJS += diff.o diffcore-rename.o dif
 	count-delta.o diffcore-break.o diffcore-order.o
 
 LIB_OBJS += gitenv.o
+LIB_OBJS += server-info.o
 
 LIBS = $(LIB_FILE)
 LIBS += -lz
@@ -152,6 +157,9 @@ git-prune-packed: prune-packed.c
 git-fetch-pack: fetch-pack.c
 git-var: var.c
 git-peek-remote: peek-remote.c
+git-update-server-info: update-server-info.c
+git-build-rev-cache: build-rev-cache.c
+git-show-rev-cache: show-rev-cache.c
 
 git-http-pull: LIBS += -lcurl
 git-rev-list: LIBS += -lssl
@@ -165,6 +173,7 @@ object.o: $(LIB_H)
 read-cache.o: $(LIB_H)
 sha1_file.o: $(LIB_H)
 usage.o: $(LIB_H)
+rev-cache.o: $(LIB_H)
 strbuf.o: $(LIB_H)
 gitenv.o: $(LIB_H)
 entry.o: $(LIB_H)
diff --git a/build-rev-cache.c b/build-rev-cache.c
new file mode 100644
--- /dev/null
+++ b/build-rev-cache.c
@@ -0,0 +1,56 @@
+#include "refs.h"
+#include "cache.h"
+#include "commit.h"
+#include "rev-cache.h"
+
+static void process_head_list(int verbose)
+{
+	char buf[512];
+
+	while (fgets(buf, sizeof(buf), stdin)) {
+		unsigned char sha1[20];
+		struct commit *commit;
+
+		if (get_sha1_hex(buf, sha1)) {
+			error("ignoring: %s", buf);
+			continue;
+		}
+		if (!(commit = lookup_commit_reference(sha1))) {
+			error("not a commit: %s", sha1_to_hex(sha1));
+			continue;
+		}
+		record_rev_cache(commit->object.sha1, verbose ? stderr : NULL);
+	}
+}
+
+
+static const char *build_rev_cache_usage =
+"git-build-rev-cache <rev-cache-file> < list-of-heads";
+
+int main(int ac, char **av)
+{
+	int verbose = 0;
+	const char *path;
+
+	while (1 < ac && av[1][0] == '-') {
+		if (!strcmp(av[1], "-v"))
+			verbose = 1;
+		else
+			usage(build_rev_cache_usage);
+		ac--; av++;
+	}
+
+	if (ac != 2)
+		usage(build_rev_cache_usage);
+
+	path = av[1];
+
+	/* read existing rev-cache */
+	read_rev_cache(path, NULL, 0);
+
+	process_head_list(verbose);
+
+	/* update the rev-cache database by appending newly found one to it */
+	write_rev_cache(path, path);
+	return 0;
+}
diff --git a/cache.h b/cache.h
--- a/cache.h
+++ b/cache.h
@@ -308,4 +308,7 @@ extern int find_pack_entry_one(const uns
 extern void *unpack_entry_gently(struct pack_entry *, char *, unsigned long *);
 extern void packed_object_info_detail(struct pack_entry *, char *, unsigned long *, unsigned long *, int *, unsigned char *);
 
+/* Dumb servers support */
+extern int update_server_info(int);
+
 #endif /* CACHE_H */
diff --git a/receive-pack.c b/receive-pack.c
--- a/receive-pack.c
+++ b/receive-pack.c
@@ -110,6 +110,7 @@ static void execute_commands(void)
 		update(cmd->ref_name, cmd->old_sha1, cmd->new_sha1);
 		cmd = cmd->next;
 	}
+	update_server_info(0);
 }
 
 static void read_head_info(void)
diff --git a/rev-cache.c b/rev-cache.c
new file mode 100644
--- /dev/null
+++ b/rev-cache.c
@@ -0,0 +1,320 @@
+#include "refs.h"
+#include "cache.h"
+#include "rev-cache.h"
+
+struct rev_cache **rev_cache;
+int nr_revs, alloc_revs;
+
+struct rev_list_elem *rle_free;
+
+#define BATCH_SIZE 512
+
+int find_rev_cache(const unsigned char *sha1)
+{
+	int lo = 0, hi = nr_revs;
+	while (lo < hi) {
+		int mi = (lo + hi) / 2;
+		struct rev_cache *ri = rev_cache[mi];
+		int cmp = memcmp(sha1, ri->sha1, 20);
+		if (!cmp)
+			return mi;
+		if (cmp < 0)
+			hi = mi;
+		else
+			lo = mi + 1;
+	}
+	return -lo - 1;
+}
+
+static struct rev_list_elem *alloc_list_elem(void)
+{
+	struct rev_list_elem *rle;
+	if (!rle_free) {
+		int i;
+
+		rle = xmalloc(sizeof(*rle) * BATCH_SIZE);
+		for (i = 0; i < BATCH_SIZE - 1; i++) {
+			rle[i].ri = NULL;
+			rle[i].next = &rle[i + 1];
+		}
+		rle[BATCH_SIZE - 1].ri = NULL;
+		rle[BATCH_SIZE - 1].next = NULL;
+		rle_free = rle;
+	}
+	rle = rle_free;
+	rle_free = rle->next;
+	return rle;
+}
+
+static struct rev_cache *create_rev_cache(const unsigned char *sha1)
+{
+	struct rev_cache *ri;
+	int pos = find_rev_cache(sha1);
+
+	if (0 <= pos)
+		return rev_cache[pos];
+	pos = -pos - 1;
+	if (alloc_revs <= ++nr_revs) {
+		alloc_revs = alloc_nr(alloc_revs);
+		rev_cache = xrealloc(rev_cache, sizeof(ri) * alloc_revs);
+	}
+	if (pos < nr_revs)
+		memmove(rev_cache + pos + 1, rev_cache + pos,
+			(nr_revs - pos - 1) * sizeof(ri));
+	ri = xcalloc(1, sizeof(*ri));
+	memcpy(ri->sha1, sha1, 20);
+	rev_cache[pos] = ri;
+	return ri;
+}
+
+static unsigned char last_sha1[20];
+
+static void write_one_rev_cache(FILE *rev_cache_file, struct rev_cache *ri)
+{
+	unsigned char flag;
+	struct rev_list_elem *rle;
+
+	if (ri->written)
+		return;
+
+	if (ri->parsed) {
+		/* We use last_sha1 compression only for the first parent;
+		 * otherwise the resulting rev-cache would lose the parent
+		 * order information.
+		 */
+		if (ri->parents &&
+		    !memcmp(ri->parents->ri->sha1, last_sha1, 20))
+			flag = (ri->num_parents - 1) | 0x80;
+		else
+			flag = ri->num_parents;
+
+		fwrite(ri->sha1, 20, 1, rev_cache_file);
+		fwrite(&flag, 1, 1, rev_cache_file);
+		for (rle = ri->parents; rle; rle = rle->next) {
+			if (flag & 0x80 && rle == ri->parents)
+				continue;
+			fwrite(rle->ri->sha1, 20, 1, rev_cache_file);
+		}
+		memcpy(last_sha1, ri->sha1, 20);
+		ri->written = 1;
+	}
+	/* recursively write children depth first */
+	for (rle = ri->children; rle; rle = rle->next)
+		write_one_rev_cache(rev_cache_file, rle->ri);
+}
+
+void write_rev_cache(const char *newpath, const char *oldpath)
+{
+	/* write the following commit ancestry information in
+	 * $GIT_DIR/info/rev-cache.
+	 *
+	 * The format is:
+	 * 20-byte SHA1 (commit ID)
+	 * 1-byte flag:
+	 * - bit 0-6 records "number of parent commit SHA1s to
+	 *   follow" (i.e. up to 127 children can be listed).
+	 * - when the bit 7 is on, then "the entry immediately
+	 *   before this entry is one of the parents of this
+         *   commit".
+	 * N x 20-byte SHA1 (parent commit IDs)
+	 */
+	FILE *rev_cache_file;
+	int i;
+	struct rev_cache *ri;
+
+	if (!strcmp(newpath, oldpath)) {
+		/* If we are doing it in place */
+		rev_cache_file = fopen(newpath, "a");
+	}
+	else {
+		char buf[8096];
+		size_t sz;
+		FILE *oldfp = fopen(oldpath, "r");
+		rev_cache_file = fopen(newpath, "w");
+		if (oldfp) {
+			while (1) {
+				sz = fread(buf, 1, sizeof(buf), oldfp);
+				if (sz == 0)
+					break;
+				fwrite(buf, 1, sz, rev_cache_file);
+			}
+			fclose(oldfp);
+		}
+	}
+
+	memset(last_sha1, 0, 20);
+
+	/* Go through available rev_cache structures, starting from
+	 * parentless ones first, so that we would get most out of
+	 * last_sha1 optimization by the depth first behaviour of
+	 * write_one_rev_cache().
+	 */
+	for (i = 0; i < nr_revs; i++) {
+		ri = rev_cache[i];
+		if (ri->num_parents)
+			continue;
+		write_one_rev_cache(rev_cache_file, ri);
+	}
+	/* Then the rest */
+	for (i = 0; i < nr_revs; i++) {
+		ri = rev_cache[i];
+		write_one_rev_cache(rev_cache_file, ri);
+	}
+	fclose(rev_cache_file);
+}
+
+static void add_parent(struct rev_cache *child,
+		       const unsigned char *parent_sha1)
+{
+	struct rev_cache *parent = create_rev_cache(parent_sha1);
+	struct rev_list_elem *e = alloc_list_elem();
+
+	/* Keep the parent list ordered in the same way the commit
+	 * object records them.
+	 */
+	e->ri = parent;
+	e->next = NULL;
+	if (!child->parents_tail)
+		child->parents = e;
+	else
+		child->parents_tail->next = e;
+	child->parents_tail = e;
+	child->num_parents++;
+
+	/* There is no inherent order of the children so we just
+	 * LIFO them together.
+	 */
+	e = alloc_list_elem();
+	e->next = parent->children;
+	parent->children = e;
+	e->ri = child;
+	parent->num_children++;
+}
+
+int read_rev_cache(const char *path, FILE *dumpfile, int dry_run)
+{
+	unsigned char *map;
+	int fd;
+	struct stat st;
+	unsigned long ofs, len;
+	struct rev_cache *ri = NULL;
+
+	fd = open(path, O_RDONLY);
+	if (fd < 0) {
+		if (dry_run)
+			return error("cannot open %s", path);
+		if (errno == ENOENT)
+			return 0;
+		return -1;
+	}
+	if (fstat(fd, &st)) {
+		close(fd);
+		return -1;
+	}
+	map = mmap(NULL, st.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
+	if (map == MAP_FAILED) {
+		close(fd);
+		return -1;
+	}
+	close(fd);
+
+	memset(last_sha1, 0, 20);
+	ofs = 0;
+	len = st.st_size;
+	while (ofs < len) {
+		unsigned char sha1[20];
+		int flag, cnt, i;
+		if (len < ofs + 21)
+			die("rev-cache too short");
+		memcpy(sha1, map + ofs, 20);
+		flag = map[ofs + 20];
+		ofs += 21;
+		cnt = (flag & 0x7f) + ((flag & 0x80) != 0);
+		if (len < ofs + (flag & 0x7f) * 20)
+			die("rev-cache too short to have %d more parents",
+			    (flag & 0x7f));
+		if (dumpfile)
+			fprintf(dumpfile, "%s", sha1_to_hex(sha1));
+		if (!dry_run) {
+			ri = create_rev_cache(sha1);
+			if (!ri)
+				die("cannot create rev-cache for %s",
+				    sha1_to_hex(sha1));
+			ri->written = ri->parsed = 1;
+		}
+		i = 0;
+		if (flag & 0x80) {
+			if (!dry_run)
+				add_parent(ri, last_sha1);
+			if (dumpfile)
+				fprintf(dumpfile, " %s",
+					sha1_to_hex(last_sha1));
+			i++;
+		}
+		while (i++ < cnt) {
+			if (!dry_run)
+				add_parent(ri, map + ofs);
+			if (dumpfile)
+				fprintf(dumpfile, " %s",
+					sha1_to_hex(last_sha1));
+			ofs += 20;
+		}
+		if (dumpfile)
+			fprintf(dumpfile, "\n");
+		memcpy(last_sha1, sha1, 20);
+	}
+	if (ofs != len)
+		die("rev-cache truncated?");
+	munmap(map, len);
+	return 0;
+}
+
+int record_rev_cache(const unsigned char *sha1, FILE *dumpfile)
+{
+	unsigned char parent[20];
+	char type[20];
+	unsigned long size, ofs;
+	unsigned int cnt, i;
+	void *buf;
+	struct rev_cache *ri;
+
+	buf = read_sha1_file(sha1, type, &size);
+	if (!buf)
+		return error("%s: not found", sha1_to_hex(sha1));
+	if (strcmp(type, "commit")) {
+		free(buf);
+		return error("%s: not a commit but a %s",
+			     sha1_to_hex(sha1), type);
+	}
+	ri = create_rev_cache(sha1);
+	if (ri->parsed)
+		return 0;
+	if (dumpfile)
+		fprintf(dumpfile, "commit %s\n", sha1_to_hex(sha1));
+
+	cnt = 0;
+	ofs = 46; /* "tree " + hex-sha1 + "\n" */
+	while (!memcmp(buf + ofs, "parent ", 7) &&
+	       !get_sha1_hex(buf + ofs + 7, parent)) {
+		ofs += 48;
+		cnt++;
+	}
+	if (cnt * 48 + 46 != ofs) {
+		free(buf);
+		die("internal error in record_rev_cache");
+	}
+
+	ri = create_rev_cache(sha1);
+	ri->parsed = 1;
+
+	for (i = 0; i < cnt; i++) {
+		unsigned char parent_sha1[20];
+
+		ofs = 46 + i * 48 + 7;
+		get_sha1_hex(buf + ofs, parent_sha1);
+		add_parent(ri, parent_sha1);
+		record_rev_cache(parent_sha1, dumpfile);
+	}
+	free(buf);
+	return 0;
+}
diff --git a/rev-cache.h b/rev-cache.h
new file mode 100644
--- /dev/null
+++ b/rev-cache.h
@@ -0,0 +1,29 @@
+#ifndef REV_CACHE_H
+#define REV_CACHE_H
+
+extern struct rev_cache {
+	struct rev_cache *head_list;
+	struct rev_list_elem *children;
+	struct rev_list_elem *parents;
+	struct rev_list_elem *parents_tail;
+	unsigned short num_parents;
+	unsigned short num_children;
+	unsigned int written : 1;
+	unsigned int parsed : 1;
+	unsigned int work : 30;
+	void *work_ptr;
+	unsigned char sha1[20];
+} **rev_cache;
+extern int nr_revs, alloc_revs;
+
+struct rev_list_elem {
+	struct rev_list_elem *next;
+	struct rev_cache *ri;
+};
+
+extern int find_rev_cache(const unsigned char *);
+extern int read_rev_cache(const char *, FILE *, int);
+extern int record_rev_cache(const unsigned char *, FILE *);
+extern void write_rev_cache(const char *new, const char *old);
+
+#endif
diff --git a/server-info.c b/server-info.c
new file mode 100644
--- /dev/null
+++ b/server-info.c
@@ -0,0 +1,565 @@
+#include "cache.h"
+#include "refs.h"
+#include "object.h"
+#include "commit.h"
+#include "rev-cache.h"
+
+/* refs */
+static FILE *info_ref_fp;
+static unsigned long info_ref_time;
+static int info_ref_is_stale = 0;
+
+static int stat_ref(const char *path, const unsigned char *sha1)
+{
+	struct stat st;
+	if (!stat(path, &st) && info_ref_time < st.st_mtime)
+		info_ref_is_stale = 1;
+	return 0;
+}
+
+static int add_info_ref(const char *path, const unsigned char *sha1)
+{
+	fprintf(info_ref_fp, "%s	%s\n", sha1_to_hex(sha1), path);
+	return 0;
+}
+
+static int update_info_refs(int force)
+{
+	struct stat st;
+	char *path0 = strdup(git_path("info/refs"));
+	int len = strlen(path0);
+	char *path1 = xmalloc(len + 2);
+
+	strcpy(path1, path0);
+	strcpy(path1 + len, "+");
+
+	if (!force) {
+		if (stat(path0, &st)) {
+			if (errno == ENOENT)
+				info_ref_is_stale = 1;
+			else
+				return error("cannot stat %s", path0);
+		}
+		else {
+			info_ref_time = st.st_mtime;
+			for_each_ref(stat_ref);
+		}
+		if (!info_ref_is_stale)
+			return 0;
+	}
+
+	safe_create_leading_directories(path0);
+	info_ref_fp = fopen(path1, "w");
+	if (!info_ref_fp)
+		return error("unable to update %s", path0);
+	for_each_ref(add_info_ref);
+	fclose(info_ref_fp);
+	rename(path1, path0);
+	free(path0);
+	free(path1);
+	return 0;
+}
+
+/* packs */
+struct pack_info {
+	unsigned long latest;
+	struct packed_git *p;
+	int old_num;
+	int new_num;
+	int nr_alloc;
+	int nr_heads;
+	unsigned char (*head)[20];
+	char dep[0]; /* more */
+} **info;
+static int num_pack;
+static const char *objdir;
+static int objdirlen;
+
+static struct object *parse_object_cheap(const unsigned char *sha1)
+{
+	struct object *o;
+
+	if ((o = parse_object(sha1)) == NULL)
+		return NULL;
+	if (o->type == commit_type) {
+		struct commit *commit = (struct commit *)o;
+		free(commit->buffer);
+		commit->buffer = NULL;
+	}
+	return o;
+}
+
+static struct pack_info *find_pack_by_name(const char *name)
+{
+	int i;
+	for (i = 0; i < num_pack; i++) {
+		struct packed_git *p = info[i]->p;
+		/* skip "/pack/" after ".git/objects" */
+		if (!strcmp(p->pack_name + objdirlen + 6, name))
+			return info[i];
+	}
+	return NULL;
+}
+
+static struct pack_info *find_pack_by_old_num(int old_num)
+{
+	int i;
+	for (i = 0; i < num_pack; i++)
+		if (info[i]->old_num == old_num)
+			return info[i];
+	return NULL;
+}
+
+static int add_head_def(struct pack_info *this, unsigned char *sha1)
+{
+	if (this->nr_alloc <= this->nr_heads) {
+		this->nr_alloc = alloc_nr(this->nr_alloc);
+		this->head = xrealloc(this->head, this->nr_alloc * 20);
+	}
+	memcpy(this->head[this->nr_heads++], sha1, 20);
+	return 0;
+}
+
+/* Returns non-zero when we detect that the info in the
+ * old file is useless.
+ */
+static int parse_pack_def(const char *line, int old_cnt)
+{
+	struct pack_info *i = find_pack_by_name(line + 2);
+	if (i) {
+		i->old_num = old_cnt;
+		return 0;
+	}
+	else {
+		/* The file describes a pack that is no longer here;
+		 * dependencies between packs needs to be recalculated.
+		 */
+		return 1;
+	}
+}
+
+/* Returns non-zero when we detect that the info in the
+ * old file is useless.
+ */
+static int parse_depend_def(char *line)
+{
+	unsigned long num;
+	char *cp, *ep;
+	struct pack_info *this, *that;
+
+	cp = line + 2;
+	num = strtoul(cp, &ep, 10);
+	if (ep == cp)
+		return error("invalid input %s", line);
+	this = find_pack_by_old_num(num);
+	if (!this)
+		return 0;
+	while (ep && *(cp = ep)) {
+		num = strtoul(cp, &ep, 10);
+		if (ep == cp)
+			break;
+		that = find_pack_by_old_num(num);
+		if (!that)
+			/* The pack this one depends on does not
+			 * exist; this should not happen because
+			 * we write out the list of packs first and
+			 * then dependency information, but it means
+			 * the file is useless anyway.
+			 */
+			return 1;
+		this->dep[that->new_num] = 1;
+	}
+	return 0;
+}
+
+/* Returns non-zero when we detect that the info in the
+ * old file is useless.
+ */
+static int parse_head_def(char *line)
+{
+	unsigned char sha1[20];
+	unsigned long num;
+	char *cp, *ep;
+	struct pack_info *this;
+	struct object *o;
+
+	cp = line + 2;
+	num = strtoul(cp, &ep, 10);
+	if (ep == cp || *ep++ != ' ')
+		return error("invalid input ix %s", line);
+	this = find_pack_by_old_num(num);
+	if (!this)
+		return 1; /* You know the drill. */
+	if (get_sha1_hex(ep, sha1) || ep[40] != ' ')
+		return error("invalid input sha1 %s (%s)", line, ep);
+	if ((o = parse_object_cheap(sha1)) == NULL)
+		return error("no such object: %s", line);
+	return add_head_def(this, sha1);
+}
+
+/* Returns non-zero when we detect that the info in the
+ * old file is useless.
+ */
+static int read_pack_info_file(const char *infofile)
+{
+	FILE *fp;
+	char line[1000];
+	int old_cnt = 0;
+
+	fp = fopen(infofile, "r");
+	if (!fp)
+		return 1; /* nonexisting is not an error. */
+
+	while (fgets(line, sizeof(line), fp)) {
+		int len = strlen(line);
+		if (line[len-1] == '\n')
+			line[len-1] = 0;
+
+		switch (line[0]) {
+		case 'P': /* P name */
+			if (parse_pack_def(line, old_cnt++))
+				goto out_stale;
+			break;
+		case 'D': /* D ix dep-ix1 dep-ix2... */
+			if (parse_depend_def(line))
+				goto out_stale;
+			break;
+		case 'T': /* T ix sha1 type */
+			if (parse_head_def(line))
+				goto out_stale;
+			break;
+		default:
+			error("unrecognized: %s", line);
+			break;
+		}
+	}
+	fclose(fp);
+	return 0;
+ out_stale:
+	fclose(fp);
+	return 1;
+}
+
+/* We sort the packs according to the date of the latest commit.  That
+ * in turn indicates how young the pack is, and in general we would
+ * want to depend on younger packs.
+ */
+static unsigned long get_latest_commit_date(struct packed_git *p)
+{
+	unsigned char sha1[20];
+	struct object *o;
+	int num = num_packed_objects(p);
+	int i;
+	unsigned long latest = 0;
+
+	for (i = 0; i < num; i++) {
+		if (nth_packed_object_sha1(p, i, sha1))
+			die("corrupt pack file %s?", p->pack_name);
+		if ((o = parse_object_cheap(sha1)) == NULL)
+			die("cannot parse %s", sha1_to_hex(sha1));
+		if (o->type == commit_type) {
+			struct commit *commit = (struct commit *)o;
+			if (latest < commit->date)
+				latest = commit->date;
+		}
+	}
+	return latest;
+}
+
+static int compare_info(const void *a_, const void *b_)
+{
+	struct pack_info * const* a = a_;
+	struct pack_info * const* b = b_;
+
+	if (0 <= (*a)->old_num && 0 <= (*b)->old_num)
+		/* Keep the order in the original */
+		return (*a)->old_num - (*b)->old_num;
+	else if (0 <= (*a)->old_num)
+		/* Only A existed in the original so B is obviously newer */
+		return -1;
+	else if (0 <= (*b)->old_num)
+		/* The other way around. */
+		return 1;
+
+	if ((*a)->latest < (*b)->latest)
+		return -1;
+	else if ((*a)->latest == (*b)->latest)
+		return 0;
+	else
+		return 1;
+}
+
+static void init_pack_info(const char *infofile, int force)
+{
+	struct packed_git *p;
+	int stale;
+	int i = 0;
+	char *dep_temp;
+
+	objdir = get_object_directory();
+	objdirlen = strlen(objdir);
+
+	prepare_packed_git();
+	for (p = packed_git; p; p = p->next) {
+		/* we ignore things on alternate path since they are
+		 * not available to the pullers in general.
+		 */
+		if (strncmp(p->pack_name, objdir, objdirlen) ||
+		    strncmp(p->pack_name + objdirlen, "/pack/", 6))
+			continue;
+		i++;
+	}
+	num_pack = i;
+	info = xcalloc(num_pack, sizeof(struct pack_info *));
+	for (i = 0, p = packed_git; p; p = p->next) {
+		if (strncmp(p->pack_name, objdir, objdirlen) ||
+		    p->pack_name[objdirlen] != '/')
+			continue;
+		info[i] = xcalloc(1, sizeof(struct pack_info) + num_pack);
+		info[i]->p = p;
+		info[i]->old_num = -1;
+		i++;
+	}
+
+	if (infofile && !force)
+		stale = read_pack_info_file(infofile);
+	else
+		stale = 1;
+
+	for (i = 0; i < num_pack; i++) {
+		if (stale) {
+			info[i]->old_num = -1;
+			memset(info[i]->dep, 0, num_pack);
+			info[i]->nr_heads = 0;
+		}
+		if (info[i]->old_num < 0)
+			info[i]->latest = get_latest_commit_date(info[i]->p);
+	}
+
+	qsort(info, num_pack, sizeof(info[0]), compare_info);
+	for (i = 0; i < num_pack; i++)
+		info[i]->new_num = i;
+
+	/* we need to fix up the dependency information
+	 * for the old ones.
+	 */
+	dep_temp = NULL;
+	for (i = 0; i < num_pack; i++) {
+		int old;
+
+		if (info[i]->old_num < 0)
+			continue;
+		if (! dep_temp)
+			dep_temp = xmalloc(num_pack);
+		memset(dep_temp, 0, num_pack);
+		for (old = 0; old < num_pack; old++) {
+			struct pack_info *base;
+			if (!info[i]->dep[old])
+				continue;
+			base = find_pack_by_old_num(old);
+			if (!base)
+				die("internal error renumbering");
+			dep_temp[base->new_num] = 1;
+		}
+		memcpy(info[i]->dep, dep_temp, num_pack);
+	}
+	free(dep_temp);
+}
+
+static void write_pack_info_file(FILE *fp)
+{
+	int i, j;
+	for (i = 0; i < num_pack; i++)
+		fprintf(fp, "P %s\n", info[i]->p->pack_name + objdirlen + 6);
+
+	for (i = 0; i < num_pack; i++) {
+		fprintf(fp, "D %1d", i);
+		for (j = 0; j < num_pack; j++) {
+			if ((i == j) || !(info[i]->dep[j]))
+				continue;
+			fprintf(fp, " %1d", j);
+		}
+		fputc('\n', fp);
+	}
+
+	for (i = 0; i < num_pack; i++) {
+		struct pack_info *this = info[i];
+		for (j = 0; j < this->nr_heads; j++) {
+			struct object *o = lookup_object(this->head[j]);
+			fprintf(fp, "T %1d %s %s\n",
+				i, sha1_to_hex(this->head[j]), o->type);
+		}
+	}
+
+}
+
+#define REFERENCED 01
+#define INTERNAL  02
+#define EMITTED   04
+
+static void show(struct object *o, int pack_ix)
+{
+	/*
+	 * We are interested in objects that are not referenced,
+	 * and objects that are referenced but not internal.
+	 */
+	if (o->flags & EMITTED)
+		return;
+
+	if (!(o->flags & REFERENCED))
+		add_head_def(info[pack_ix], o->sha1);
+	else if ((o->flags & REFERENCED) && !(o->flags & INTERNAL)) {
+		int i;
+
+		/* Which pack contains this object?  That is what
+		 * pack_ix can depend on.  We earlier sorted info
+		 * array from youngest to oldest, so try newer packs
+		 * first to favor them here.
+		 */
+		for (i = num_pack - 1; 0 <= i; i--) {
+			struct packed_git *p = info[i]->p;
+			struct pack_entry ent;
+			if (find_pack_entry_one(o->sha1, &ent, p)) {
+				info[pack_ix]->dep[i] = 1;
+				break;
+			}
+		}
+	}
+	o->flags |= EMITTED;
+}
+
+static void find_pack_info_one(int pack_ix)
+{
+	unsigned char sha1[20];
+	struct object *o;
+	struct object_list *ref;
+	int i;
+	struct packed_git *p = info[pack_ix]->p;
+	int num = num_packed_objects(p);
+
+	/* Scan objects, clear flags from all the edge ones and
+	 * internal ones, possibly marked in the previous round.
+	 */
+	for (i = 0; i < num; i++) {
+		if (nth_packed_object_sha1(p, i, sha1))
+			die("corrupt pack file %s?", p->pack_name);
+		if ((o = lookup_object(sha1)) == NULL)
+			die("cannot parse %s", sha1_to_hex(sha1));
+		for (ref = o->refs; ref; ref = ref->next)
+			ref->item->flags = 0;
+		o->flags = 0;
+	}
+
+	/* Mark all the internal ones */
+	for (i = 0; i < num; i++) {
+		if (nth_packed_object_sha1(p, i, sha1))
+			die("corrupt pack file %s?", p->pack_name);
+		if ((o = lookup_object(sha1)) == NULL)
+			die("cannot find %s", sha1_to_hex(sha1));
+		for (ref = o->refs; ref; ref = ref->next)
+			ref->item->flags |= REFERENCED;
+		o->flags |= INTERNAL;
+	}
+
+	for (i = 0; i < num; i++) {
+		if (nth_packed_object_sha1(p, i, sha1))
+			die("corrupt pack file %s?", p->pack_name);
+		if ((o = lookup_object(sha1)) == NULL)
+			die("cannot find %s", sha1_to_hex(sha1));
+
+		show(o, pack_ix);
+		for (ref = o->refs; ref; ref = ref->next)
+			show(ref->item, pack_ix);
+	}
+
+}
+
+static void find_pack_info(void)
+{
+	int i;
+	for (i = 0; i < num_pack; i++) {
+		/* The packed objects are cast in stone, and a head
+		 * in a pack will stay as head, so is the set of missing
+		 * objects.  If the repo has been reorganized and we
+		 * are missing some packs available back then, we have
+		 * already discarded the info read from the file, so
+		 * we will find (old_num < 0) in that case.
+		 */
+		if (0 <= info[i]->old_num)
+			continue;
+		find_pack_info_one(i);
+	}
+}
+
+static int update_info_packs(int force)
+{
+	char infofile[PATH_MAX];
+	char name[PATH_MAX];
+	int namelen;
+	FILE *fp;
+
+	namelen = sprintf(infofile, "%s/info/packs", get_object_directory());
+	strcpy(name, infofile);
+	strcpy(name + namelen, "+");
+
+	init_pack_info(infofile, force);
+	find_pack_info();
+
+	safe_create_leading_directories(name);
+	fp = fopen(name, "w");
+	if (!fp)
+		return error("cannot open %s", name);
+	write_pack_info_file(fp);
+	fclose(fp);
+	rename(name, infofile);
+	return 0;
+}
+
+/* rev-cache */
+static int record_rev_cache_ref(const char *path, const unsigned char *sha1)
+{
+	struct commit *commit;
+	if (!(commit = lookup_commit_reference(sha1)))
+		return error("not a commit: %s", sha1_to_hex(sha1));
+	return record_rev_cache(commit->object.sha1, NULL);
+}
+
+static int update_info_revs(int force)
+{
+	char *path0 = strdup(git_path("info/rev-cache"));
+	int len = strlen(path0);
+	char *path1 = xmalloc(len + 2);
+
+	strcpy(path1, path0);
+	strcpy(path1 + len, "+");
+
+	/* read existing rev-cache */
+	if (!force)
+		read_rev_cache(path0, NULL, 0);
+	safe_create_leading_directories(path0);
+
+	for_each_ref(record_rev_cache_ref);
+
+	/* update the rev-cache database */
+	write_rev_cache(path1, force ? "/dev/null" : path0);
+	rename(path1, path0);
+	free(path1);
+	free(path0);
+	return 0;
+}
+
+/* public */
+int update_server_info(int force)
+{
+	/* We would add more dumb-server support files later,
+	 * including index of available pack files and their
+	 * intended audiences.
+	 */
+	int errs = 0;
+
+	errs = errs | update_info_refs(force);
+	errs = errs | update_info_packs(force);
+	errs = errs | update_info_revs(force);
+
+	return errs;
+}
diff --git a/show-rev-cache.c b/show-rev-cache.c
new file mode 100644
--- /dev/null
+++ b/show-rev-cache.c
@@ -0,0 +1,18 @@
+#include "cache.h"
+#include "rev-cache.h"
+
+static char *show_rev_cache_usage =
+"git-show-rev-cache <rev-cache-file>";
+
+int main(int ac, char **av)
+{
+	while (1 < ac && av[0][1] == '-') {
+		/* do flags here */
+		break;
+		ac--; av++;
+	}
+	if (ac != 2)
+		usage(show_rev_cache_usage);
+
+	return read_rev_cache(av[1], stdout, 1);
+}
diff --git a/update-server-info.c b/update-server-info.c
new file mode 100644
--- /dev/null
+++ b/update-server-info.c
@@ -0,0 +1,23 @@
+#include "cache.h"
+
+static const char update_server_info_usage[] =
+"git-update-server-info [--force]";
+
+int main(int ac, char **av)
+{
+	int i;
+	int force = 0;
+	for (i = 1; i < ac; i++) {
+		if (av[i][0] == '-') {
+			if (!strcmp("--force", av[i]) ||
+			    !strcmp("-f", av[i]))
+				force = 1;
+			else
+				usage(update_server_info_usage);
+		}
+	}
+	if (i != ac)
+		usage(update_server_info_usage);
+
+	return !!update_server_info(force);
+}
