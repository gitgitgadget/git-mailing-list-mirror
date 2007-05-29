From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [RFC] super indexes to span multiple packfiles
Date: Tue, 29 May 2007 03:16:22 -0400
Message-ID: <20070529071622.GA8905@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dana How <danahow@gmail.com>, Nicolas Pitre <nico@cam.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 29 09:21:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hsw15-00045g-Iz
	for gcvg-git@gmane.org; Tue, 29 May 2007 09:21:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752286AbXE2HQc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 29 May 2007 03:16:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754101AbXE2HQb
	(ORCPT <rfc822;git-outgoing>); Tue, 29 May 2007 03:16:31 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:40583 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752286AbXE2HQa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 May 2007 03:16:30 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HsvwN-0001N6-NX; Tue, 29 May 2007 03:16:24 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id BCB0020FBAE; Tue, 29 May 2007 03:16:22 -0400 (EDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48669>

Dana talking about some sort of global index that spans all packfiles
got me thinking.  Could we build a "super index" that covered all
known packfiles at the time it was created, but that doesn't really
hurt us when the packfiles are repacked?  Or that doesn't have to
be repacked every single time a packfile is added to the repository.

This patch introduces a new command `git super-index` which reads
all known pack-*.idx files and merges them together into a single
super-index.sdx file, located in $GIT_OBJECT_DIRECTORY/pack.
At runtime we load the first super-index.sdx file we come across
during our packfile scanning.  Using a single super-index works
because the super-index.sdx should contain data for this repository's
packs, and for all of its alternate's packs.

A super-index holds a list of packfile names that it will match at
the start of its data file.  A super-index can only be used for
the pack(s) mentioned there.  At runtime we try to lazily match
these pack SHA-1 names up to the struct packed_git.sha1 field,
giving us the struct packed_git* for direct index access.

The super-index does not hold the object offsets; instead it holds
an array of percentage shifts within the index fan-out ranges.
The shifts are normalized into the range 1-65535.

The basic idea is:

 1) Use the first byte of the input SHA-1 to index into the
    fan-out table of the super-index.sdx.

 2) Use the next sdx_prefix bytes of the SHA-1 to binary search
    through that region of the sdx file.  Since we are working
    only with the abbreviated prefix the memcmp() has less data to
    wade through.  We've also eliminated the common first byte,
    thanks to the fan-out table.

 3) The matching record in the sdx table holds sdx_packs uint16_t
    values.  The indexes in that list corresponding to the index
    of the pack SHA-1 names in the header of the sdx file; hence
    the first uint16_t goes to the first packfile, the second to
    the second, etc.  I call these "shifts".  I don't know why.

 4) If the shift value for a pack is 0 then that pack does not
    contain any objects that start with that prefix.  So a 0 shift
    means we do not need to scan the corresponding pack's .idx file
    for an object.

 5) If the shift is non-zero then there is at least one object in
    the corresponding packfile starting with the prefix and further
    searching in the specific packfile is required.  The shift is
    actually the percentage within the range of [lo, hi) in the
    pack's .idx of where the middle of that prefix's block appears.
    We use this as a seed value for mi, rather than (lo+hi)/2, as it
    gets us much much closer to the interesting SHA-1s in the .idx.

 6) We binary search the .idx in a traditional way, once we have
    selected a reasonable guess for the starting position.

 7) If a packfile cannot be found at runtime (e.g. it has been
    repacked away) we treat it's shift as though it were 0;
    the object is not in that packfile (since the packfile does
    not exist).

 8) If the sdx cannot give us the object, we fallback to standard
    packfile scanning.

In the single packfile case (everything repacked into one) this
is not faster; its actually slightly slower.  With a handful of
smaller recent packfiles (such as immediately after a git-fetch)
it breaks even with the stock code.  I haven't tested it yet with
a high number of packfiles (e.g. 20).  I suspect it won't gain us
a lot up there either...

So in short this shouldn't be applied, because its not any faster,
and is sometimes slower.  But I'm tossing it out here for discussion.
I'm also not documenting the new super-index command line program,
because I don't think this should be applied.  ;-)

----
 .gitignore             |    1 +
 Makefile               |    1 +
 builtin-pack-objects.c |    2 +-
 builtin-super-index.c  |  226 ++++++++++++++++++++++++++++++++++++++++++++++++
 builtin.h              |    1 +
 cache.h                |    2 +-
 git.c                  |    1 +
 pack-check.c           |    4 +-
 pack.h                 |   17 ++++
 sha1_file.c            |  208 ++++++++++++++++++++++++++++++++++++--------
 10 files changed, 423 insertions(+), 40 deletions(-)
 create mode 100644 builtin-super-index.c

diff --git a/.gitignore b/.gitignore
index 4dc0c39..3cd1b2c 100644
--- a/.gitignore
+++ b/.gitignore
@@ -126,6 +126,7 @@ git-ssh-push
 git-ssh-upload
 git-status
 git-stripspace
+git-super-index
 git-svn
 git-svnimport
 git-symbolic-ref
diff --git a/Makefile b/Makefile
index 29243c6..26ac766 100644
--- a/Makefile
+++ b/Makefile
@@ -371,6 +371,7 @@ BUILTIN_OBJS = \
 	builtin-shortlog.o \
 	builtin-show-branch.o \
 	builtin-stripspace.o \
+	builtin-super-index.o \
 	builtin-symbolic-ref.o \
 	builtin-tar-tree.o \
 	builtin-unpack-objects.o \
diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index d165f10..3b49336 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -756,7 +756,7 @@ static int add_object_entry(const unsigned char *sha1, enum object_type type,
 	}
 
 	for (p = packed_git; p; p = p->next) {
-		off_t offset = find_pack_entry_one(sha1, p);
+		off_t offset = find_pack_entry_one(sha1, p, 0);
 		if (offset) {
 			if (!found_pack) {
 				found_offset = offset;
diff --git a/builtin-super-index.c b/builtin-super-index.c
new file mode 100644
index 0000000..9f47760
--- /dev/null
+++ b/builtin-super-index.c
@@ -0,0 +1,226 @@
+#include "cache.h"
+#include "pack.h"
+#include "csum-file.h"
+
+struct sdx_entry {
+	unsigned char prefix[20];
+	uint16_t *splits;
+};
+
+static unsigned pack_cnt;
+static unsigned entry_cnt;
+static unsigned avail_cnt;
+static unsigned prefix_len = 5;
+static uint32_t *current;
+static struct packed_git **packs;
+static struct sdx_entry *entries;
+
+static unsigned split_avail;
+static uint16_t *split_free;
+
+static void select_packs()
+{
+	struct packed_git *p;
+	unsigned i;
+
+	prepare_packed_git();
+	for (p = packed_git; p; p = p->next)
+		pack_cnt++;
+
+	packs = xmalloc(pack_cnt * sizeof(packs[0]));
+	current = xcalloc(pack_cnt, sizeof(current[0]));
+	for (p = packed_git, i = 0; p; p = p->next, i++) {
+		packs[i] = p;
+		open_pack_index(p);
+	}
+}
+
+static void compute_pack(struct sdx_entry *ent, unsigned pack_idx)
+{
+	struct packed_git *p = packs[pack_idx];
+	const uint32_t *level1_ofs = p->index_data;
+	uint32_t hi, lo, mi, n = current[pack_idx];
+
+	/* Determine the end of the range that matches */
+	while (n < p->num_objects) {
+		const unsigned char *c = nth_packed_object_sha1(p, n);
+		if (memcmp(c, ent->prefix, prefix_len) > 0)
+			break;
+		n++;
+	}
+	if (n == current[pack_idx])
+		return;
+
+	/* Determine the position within the fan-out subrange */
+	if (p->index_version > 1)
+		level1_ofs += 2;
+	hi = ntohl(level1_ofs[*ent->prefix]);
+	lo = *ent->prefix ? ntohl(level1_ofs[*ent->prefix - 1]) : 0;
+	mi = (current[pack_idx] + n) / 2;
+	ent->splits[pack_idx] = (mi - lo) * 65535 / (hi - lo) + 1;
+
+	current[pack_idx] = n;
+}
+
+static int compute_next_entry()
+{
+	unsigned i;
+	const unsigned char *min = NULL;
+	struct sdx_entry *ent;
+
+	/* locate the minimum hash */
+	for (i = 0; i < pack_cnt; i++) {
+		struct packed_git *p = packs[i];
+		uint32_t n = current[i];
+		if (n < p->num_objects) {
+			const unsigned char *c = nth_packed_object_sha1(p, n);
+			if (!min || memcmp(c, min, prefix_len) < 0)
+				min = c;
+		}
+	}
+	if (!min)
+		return 0;
+
+	if (entry_cnt == avail_cnt) {
+		avail_cnt = avail_cnt * 3 / 2 + 128;
+		entries = xrealloc(entries, avail_cnt * sizeof(entries[0]));
+	}
+	if (split_avail < pack_cnt) {
+		split_avail = pack_cnt * (avail_cnt - entry_cnt);
+		split_free = xcalloc(split_avail, sizeof(split_free[0]));
+	}
+
+	ent = &entries[entry_cnt++];
+	hashcpy(ent->prefix, min);
+
+	ent->splits = split_free;
+	split_free += pack_cnt;
+	split_avail -= pack_cnt;
+
+	/* determine which packs match this entry */
+	for (i = 0; i < pack_cnt; i++)
+		compute_pack(ent, i);
+
+	return 1;
+}
+
+static int read_only(const char *path)
+{
+	mode_t mode = umask(0);
+
+	umask(mode);
+	mode = 0444 & ~mode;
+	if (chmod(path, mode))
+		return -1;
+	return adjust_shared_perm(path);
+}
+
+static void write_super_index()
+{
+	char tmpname[PATH_MAX];
+	struct sha1file *f;
+	uint32_t i, array[256];
+	int fd;
+	struct pack_sdx_header hdr;
+	struct sdx_entry *curr = entries, *last = entries + entry_cnt;
+
+	snprintf(tmpname, sizeof(tmpname), "%s/%s",
+		get_object_directory(),
+		"tmp_sdx_XXXXXX");
+	fd = mkstemp(tmpname);
+	if (fd < 0)
+		die("unable to create %s: %s\n", tmpname, strerror(errno));
+	f = sha1fd(fd, tmpname);
+
+	/* Our file header, for once we plan ahead! */
+	memset(&hdr, 0, sizeof(hdr));
+	hdr.sdx_signature = htonl(PACK_SDX_SIGNATURE);
+	hdr.sdx_version = htonl(1);
+	hdr.sdx_packs = htons(pack_cnt);
+	hdr.sdx_prefix = prefix_len - 1;
+	sha1write(f, &hdr, sizeof(hdr));
+
+	/* Immediately after is the pack SHA-1 names */
+	for (i = 0; i < pack_cnt; i++)
+		sha1write(f, packs[i]->sha1, sizeof(packs[i]->sha1));
+
+	/*
+	 * Write the first-level table (the list is sorted,
+	 * but we use a 256-entry lookup to be able to avoid
+	 * having to do eight extra binary search iterations).
+	 */
+	for (i = 0; i < 256; i++) {
+		while (curr < last && curr->prefix[0] == i)
+			curr++;
+		array[i] = htonl(curr - entries);
+	}
+	sha1write(f, array, 256 * 4);
+
+	/* Write the entries */
+	for (curr = entries; curr < last; curr++) {
+		sha1write(f, curr->prefix + 1, prefix_len - 1);
+		sha1write(f, curr->splits, pack_cnt);
+	}
+
+	sha1close(f, NULL, 1);
+	if (read_only(tmpname))
+		die("cannot make file readable: %s", strerror(errno));
+
+	if (move_temp_to_file(tmpname,
+		mkpath("%s/pack/super-index.sdx", get_object_directory())))
+		die("cannot save super-index.sdx");
+}
+
+static void show_super_index()
+{
+	unsigned i, j, multi_pack = 0;
+
+	for (i = 0; i < pack_cnt; i++)
+		printf("pack %s\n", sha1_to_hex(packs[i]->sha1));
+
+	for (i = 0; i < entry_cnt; i++) {
+		struct sdx_entry *ent = &entries[i];
+		char *prefix_str = sha1_to_hex(ent->prefix);
+		unsigned matches = 0;
+
+		prefix_str[2 * prefix_len] = 0;
+
+		printf("%s:", prefix_str);
+		for (j = 0; j < pack_cnt; j++) {
+			if (ent->splits[j]) {
+				matches++;
+				printf(" %3u", (int)ent->splits[j]);
+			} else
+				printf(" ----");
+		}
+		printf("\n");
+
+		if (matches > 1)
+			multi_pack++;
+	}
+
+	printf("%u packs, %u entries, %u%% unique\n",
+		pack_cnt, entry_cnt,
+		(entry_cnt - multi_pack) * 100 / entry_cnt);
+}
+
+static const char super_index_usage[] =
+"git-super-index";
+
+int cmd_super_index(int argc, char **argv, const char *prefix)
+{
+	select_packs();
+	if (!pack_cnt)
+		die("no packfiles to super-index");
+	if (pack_cnt == 1)
+		warning("only one packfile; a super-index is unnecessary");
+
+	while (compute_next_entry())
+		/* nothing */;
+	write_super_index();
+
+	if (0)
+		show_super_index();
+
+	return 0;
+}
diff --git a/builtin.h b/builtin.h
index d3f3a74..2a11187 100644
--- a/builtin.h
+++ b/builtin.h
@@ -71,6 +71,7 @@ extern int cmd_shortlog(int argc, const char **argv, const char *prefix);
 extern int cmd_show(int argc, const char **argv, const char *prefix);
 extern int cmd_show_branch(int argc, const char **argv, const char *prefix);
 extern int cmd_stripspace(int argc, const char **argv, const char *prefix);
+extern int cmd_super_index(int argc, const char **argv, const char *prefix);
 extern int cmd_symbolic_ref(int argc, const char **argv, const char *prefix);
 extern int cmd_tar_tree(int argc, const char **argv, const char *prefix);
 extern int cmd_unpack_objects(int argc, const char **argv, const char *prefix);
diff --git a/cache.h b/cache.h
index 0f4a05b..3c8a41d 100644
--- a/cache.h
+++ b/cache.h
@@ -490,7 +490,7 @@ extern unsigned char* use_pack(struct packed_git *, struct pack_window **, off_t
 extern void unuse_pack(struct pack_window **);
 extern struct packed_git *add_packed_git(const char *, int, int);
 extern const unsigned char *nth_packed_object_sha1(struct packed_git *, uint32_t);
-extern off_t find_pack_entry_one(const unsigned char *, struct packed_git *);
+extern off_t find_pack_entry_one(const unsigned char *, struct packed_git *, unsigned);
 extern void *unpack_entry(struct packed_git *, off_t, enum object_type *, unsigned long *);
 extern unsigned long unpack_object_header_gently(const unsigned char *buf, unsigned long len, enum object_type *type, unsigned long *sizep);
 extern unsigned long get_size_from_delta(struct packed_git *, struct pack_window **, off_t);
diff --git a/git.c b/git.c
index 29b55a1..c323479 100644
--- a/git.c
+++ b/git.c
@@ -284,6 +284,7 @@ static void handle_internal_command(int argc, const char **argv, char **envp)
 		{ "show-branch", cmd_show_branch, RUN_SETUP },
 		{ "show", cmd_show, RUN_SETUP | USE_PAGER },
 		{ "stripspace", cmd_stripspace },
+		{ "super-index", cmd_super_index, RUN_SETUP },
 		{ "symbolic-ref", cmd_symbolic_ref, RUN_SETUP },
 		{ "tar-tree", cmd_tar_tree },
 		{ "unpack-objects", cmd_unpack_objects, RUN_SETUP },
diff --git a/pack-check.c b/pack-check.c
index 7475348..ec61592 100644
--- a/pack-check.c
+++ b/pack-check.c
@@ -51,7 +51,7 @@ static int verify_packfile(struct packed_git *p,
 		sha1 = nth_packed_object_sha1(p, i);
 		if (!sha1)
 			die("internal error pack-check nth-packed-object");
-		offset = find_pack_entry_one(sha1, p);
+		offset = find_pack_entry_one(sha1, p, 0);
 		if (!offset)
 			die("internal error pack-check find-pack-entry-one");
 		data = unpack_entry(p, offset, &type, &size);
@@ -94,7 +94,7 @@ static void show_pack_info(struct packed_git *p)
 		sha1 = nth_packed_object_sha1(p, i);
 		if (!sha1)
 			die("internal error pack-check nth-packed-object");
-		offset = find_pack_entry_one(sha1, p);
+		offset = find_pack_entry_one(sha1, p, 0);
 		if (!offset)
 			die("internal error pack-check find-pack-entry-one");
 
diff --git a/pack.h b/pack.h
index d667fb8..b660833 100644
--- a/pack.h
+++ b/pack.h
@@ -43,6 +43,23 @@ struct pack_idx_header {
 };
 
 
+/*
+ * Super-pack index header
+ *
+ * This file points to multiple packfiles by name and provides a
+ * hint to tell us if it is likely that a given packfile contains
+ * a particular object.  This file is not an index file replacement,
+ * it is only a performance optimization hint.
+ */
+#define PACK_SDX_SIGNATURE 0x50534458	/* "PSDX" */
+struct pack_sdx_header {
+	uint32_t sdx_signature;
+	uint32_t sdx_version;
+	uint16_t sdx_packs;
+	uint8_t  sdx_prefix;
+	uint8_t  _unused_padding;
+};
+
 extern int verify_pack(struct packed_git *, int);
 extern void fixup_pack_header_footer(int, unsigned char *, const char *, uint32_t);
 
diff --git a/sha1_file.c b/sha1_file.c
index a3637d7..d296b32 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -405,6 +405,15 @@ static char *find_sha1_file(const unsigned char *sha1, struct stat *st)
 	return NULL;
 }
 
+struct super_index {
+	struct pack_sdx_header *sdx_header;
+	void *sdx_data;
+	unsigned char *sdx_pack_names;
+	struct packed_git **packs;
+	unsigned pack_cnt;
+};
+
+static struct super_index *super_idx;
 static unsigned int pack_used_ctr;
 static unsigned int pack_mmap_calls;
 static unsigned int peak_pack_open_windows;
@@ -831,6 +840,64 @@ void install_packed_git(struct packed_git *pack)
 	packed_git = pack;
 }
 
+static int open_super_index(const char *path)
+{
+	int fd = open(path, O_RDONLY);
+	struct stat st;
+	size_t sdx_size;
+	void *sdx_map;
+	struct pack_sdx_header *hdr;
+	unsigned char *sdx_data;
+	unsigned pack_cnt;
+
+	if (fd < 0)
+		return -1;
+	if (fstat(fd, &st)) {
+		close(fd);
+		return -1;
+	}
+
+	sdx_size = xsize_t(st.st_size);
+	if (sdx_size < 4 * 256 + 20) {
+		close(fd);
+		return error("super-index %s is too small", path);
+	}
+	sdx_map = mmap(NULL, sdx_size, PROT_READ, MAP_PRIVATE, fd, 0);
+	if (sdx_map == MAP_FAILED) {
+		release_pack_memory(sdx_size, fd);
+		sdx_map = mmap(NULL, sdx_size, PROT_READ, MAP_PRIVATE, fd, 0);
+		if (sdx_map == MAP_FAILED) {
+			close(fd);
+			return -1;
+		}
+	}
+	close(fd);
+
+	hdr = sdx_map;
+	if (hdr->sdx_signature != htonl(PACK_SDX_SIGNATURE)) {
+		munmap(sdx_map, sdx_size);
+		return error("super-index %s has incorrect signature", path);
+	}
+	if (hdr->sdx_version != htonl(1)) {
+		munmap(sdx_map, sdx_size);
+		return error("super-index file %s is version %u"
+				 " and is not supported by this binary"
+				 " (try upgrading GIT to a newer version)",
+				 path, ntohl(hdr->sdx_version));
+	}
+
+	pack_cnt = ntohs(hdr->sdx_packs);
+	sdx_data = (unsigned char*)(hdr + 1);
+
+	super_idx = xmalloc(sizeof(*super_idx));
+	super_idx->sdx_header = hdr;
+	super_idx->sdx_pack_names = sdx_data;
+	super_idx->sdx_data = sdx_data + pack_cnt * 20;
+	super_idx->pack_cnt = pack_cnt;
+	super_idx->packs = xcalloc(pack_cnt, sizeof(*super_idx->packs));
+	return 0;
+}
+
 static void prepare_packed_git_one(char *objdir, int local)
 {
 	char path[PATH_MAX];
@@ -852,6 +919,12 @@ static void prepare_packed_git_one(char *objdir, int local)
 		int namelen = strlen(de->d_name);
 		struct packed_git *p;
 
+		if (!super_idx && !strcmp(de->d_name, "super-index.sdx")) {
+			strcpy(path + len, de->d_name);
+			open_super_index(path);
+			continue;
+		}
+
 		if (!has_extension(de->d_name, ".idx"))
 			continue;
 
@@ -1260,7 +1333,7 @@ static off_t get_delta_base(struct packed_git *p,
 		*curpos += used;
 	} else if (type == OBJ_REF_DELTA) {
 		/* The base entry _must_ be in the same pack */
-		base_offset = find_pack_entry_one(base_info, p);
+		base_offset = find_pack_entry_one(base_info, p, 0);
 		if (!base_offset)
 			die("failed to find delta-pack base object %s",
 				sha1_to_hex(base_info));
@@ -1362,7 +1435,7 @@ const char *packed_object_info_detail(struct packed_git *p,
 			next_sha1 = use_pack(p, &w_curs, curpos, NULL);
 			if (*delta_chain_length == 0)
 				hashcpy(base_sha1, next_sha1);
-			obj_offset = find_pack_entry_one(next_sha1, p);
+			obj_offset = find_pack_entry_one(next_sha1, p, 0);
 			break;
 		}
 		(*delta_chain_length)++;
@@ -1633,11 +1706,12 @@ static off_t nth_packed_object_offset(const struct packed_git *p, uint32_t n)
 }
 
 off_t find_pack_entry_one(const unsigned char *sha1,
-				  struct packed_git *p)
+				  struct packed_git *p,
+				  unsigned shift)
 {
 	const uint32_t *level1_ofs = p->index_data;
 	const unsigned char *index = p->index_data;
-	unsigned hi, lo;
+	unsigned hi, lo, mi;
 
 	if (!index) {
 		if (open_pack_index(p))
@@ -1652,9 +1726,12 @@ off_t find_pack_entry_one(const unsigned char *sha1,
 	index += 4 * 256;
 	hi = ntohl(level1_ofs[*sha1]);
 	lo = ((*sha1 == 0x0) ? 0 : ntohl(level1_ofs[*sha1 - 1]));
+	if (shift)
+		mi = lo + (hi - lo) * (shift - 1) / 65535;
+	else
+		mi = (lo + hi) / 2;
 
 	do {
-		unsigned mi = (lo + hi) / 2;
 		unsigned x = (p->index_version > 1) ? (mi * 20) : (mi * 24 + 4);
 		int cmp = hashcmp(index + x, sha1);
 		if (!cmp)
@@ -1663,6 +1740,7 @@ off_t find_pack_entry_one(const unsigned char *sha1,
 			hi = mi;
 		else
 			lo = mi+1;
+		mi = (lo + hi) / 2;
 	} while (lo < hi);
 	return 0;
 }
@@ -1685,42 +1763,100 @@ static int matches_pack_name(struct packed_git *p, const char *ig)
 	return 1;
 }
 
-static int find_pack_entry(const unsigned char *sha1, struct pack_entry *e, const char **ignore_packed)
+static int find_in_pack(struct packed_git *p, unsigned shift, const unsigned char *sha1, struct pack_entry *e, const char **ignore_packed)
 {
-	struct packed_git *p;
 	off_t offset;
 
-	prepare_packed_git();
+	if (ignore_packed) {
+		const char **ig;
+		for (ig = ignore_packed; *ig; ig++)
+			if (!matches_pack_name(p, *ig))
+				break;
+		if (*ig)
+			return 0;
+	}
 
-	for (p = packed_git; p; p = p->next) {
-		if (ignore_packed) {
-			const char **ig;
-			for (ig = ignore_packed; *ig; ig++)
-				if (!matches_pack_name(p, *ig))
-					break;
-			if (*ig)
-				continue;
-		}
-		offset = find_pack_entry_one(sha1, p);
-		if (offset) {
-			/*
-			 * We are about to tell the caller where they can
-			 * locate the requested object.  We better make
-			 * sure the packfile is still here and can be
-			 * accessed before supplying that answer, as
-			 * it may have been deleted since the index
-			 * was loaded!
-			 */
-			if (p->pack_fd == -1 && open_packed_git(p)) {
-				error("packfile %s cannot be accessed", p->pack_name);
-				continue;
+	offset = find_pack_entry_one(sha1, p, shift);
+	if (!offset)
+		return 0;
+
+	/*
+	 * We are about to tell the caller where they can
+	 * locate the requested object.  We better make
+	 * sure the packfile is still here and can be
+	 * accessed before supplying that answer, as
+	 * it may have been deleted since the index
+	 * was loaded!
+	 */
+	if (p->pack_fd == -1 && open_packed_git(p)) {
+		error("packfile %s cannot be accessed", p->pack_name);
+		return 0;
+	}
+	e->offset = offset;
+	e->p = p;
+	hashcpy(e->sha1, sha1);
+	return 1;
+}
+
+static int find_superindex_entry(const unsigned char *sha1, struct pack_entry *e, const char **ignore_packed)
+{
+	const uint32_t *level1_ofs = super_idx->sdx_data;
+	const unsigned char *index = super_idx->sdx_data;
+	const unsigned pfx_len = super_idx->sdx_header->sdx_prefix;
+	const unsigned packs = super_idx->pack_cnt;
+	unsigned hi, lo;
+
+	index += 4 * 256;
+	hi = ntohl(level1_ofs[*sha1]);
+	lo = ((*sha1 == 0x0) ? 0 : ntohl(level1_ofs[*sha1 - 1]));
+
+	do {
+		unsigned mi = (lo + hi) / 2;
+		unsigned x = mi * (pfx_len + packs);
+		int cmp = memcmp(index + x, sha1 + 1, pfx_len);
+		if (!cmp) {
+			index += x + pfx_len;
+			for (x = 0; x < packs; x++, index += 2) {
+				unsigned shift = (*index << 8) | index[1];
+				struct packed_git *p;
+				if (!shift)
+					continue;
+				p = super_idx->packs[x];
+				if (!p) {
+					for (p = packed_git; p; p = p->next) {
+						if (!hashcmp(p->sha1,
+							super_idx->sdx_pack_names + x * 20))
+							break;
+					}
+					if (!p)
+						p = MAP_FAILED;
+					super_idx->packs[x] = p;
+				}
+				if (p == MAP_FAILED)
+					continue;
+				if (find_in_pack(p, shift, sha1, e, ignore_packed))
+					return 1;
 			}
-			e->offset = offset;
-			e->p = p;
-			hashcpy(e->sha1, sha1);
-			return 1;
+			return 0;
 		}
-	}
+		if (cmp > 0)
+			hi = mi;
+		else
+			lo = mi + 1;
+	} while (lo < hi);
+	return 0;
+}
+
+static int find_pack_entry(const unsigned char *sha1, struct pack_entry *e, const char **ignore_packed)
+{
+	struct packed_git *p;
+
+	prepare_packed_git();
+	if (super_idx && find_superindex_entry(sha1, e, ignore_packed))
+		return 1;
+	for (p = packed_git; p; p = p->next)
+		if (find_in_pack(p, 0, sha1, e, ignore_packed))
+			return 1;
 	return 0;
 }
 
@@ -1730,7 +1866,7 @@ struct packed_git *find_sha1_pack(const unsigned char *sha1,
 	struct packed_git *p;
 
 	for (p = packs; p; p = p->next) {
-		if (find_pack_entry_one(sha1, p))
+		if (find_pack_entry_one(sha1, p, 0))
 			return p;
 	}
 	return NULL;
-- 
1.5.2.838.g8a923
