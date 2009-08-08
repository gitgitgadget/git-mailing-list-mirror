From: "Nick Edelen" <sirnot@gmail.com>
Subject: [PATCH 2/6 (v2)] bare minimum revision cache system, no integration
 with git
Date: Sat, 08 Aug 2009 09:31:37 +0200
Message-ID: <op.uyb1uz10tdk399@sirnot.private>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
To: "Junio C Hamano" <gitster@pobox.com>,
	"Nicolas Pitre" <nico@cam.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Sam Vilain" <sam@vilain.net>,
	"Michael J Gruber" <git@drmic
X-From: git-owner@vger.kernel.org Sat Aug 08 09:32:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZgPS-0007cU-4h
	for gcvg-git-2@gmane.org; Sat, 08 Aug 2009 09:32:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754681AbZHHHbr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Aug 2009 03:31:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754646AbZHHHbr
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Aug 2009 03:31:47 -0400
Received: from mail-ew0-f214.google.com ([209.85.219.214]:50170 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754566AbZHHHbo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Aug 2009 03:31:44 -0400
Received: by ewy10 with SMTP id 10so1992751ewy.37
        for <git@vger.kernel.org>; Sat, 08 Aug 2009 00:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:to:subject:from
         :content-type:mime-version:content-transfer-encoding:message-id
         :user-agent;
        bh=EHG4CiWzLKIW2l2j+RIn2vKYYllMu/XV/B9hSETdzU0=;
        b=U0TEBy81vtFHBS2UIjxpnCUXyqwXXS/G4DVYDmiV8xTrEE92zXHxbTkfG1RlVVa0+p
         h3+l584KZdO4Pnt+gg9M1UqAlTu5aZC88zd3/9GBIC/Z5R5ZKvFoamQIN3MEqZZIk1ra
         EoZsM0gE9KQ5i43b+/SvSswLMlT7GMBla6Djc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:to:subject:from:content-type:mime-version
         :content-transfer-encoding:message-id:user-agent;
        b=kperZZs+nLh1Qw1ZpFw0o0bn6hvkjJazOpJoL8DG0irWHmuY6dv/ac6A5tU28bBpHL
         q8zI8CF75C5UcIiCd7PvM2HlWJcctZdJ3Ol6bl5uNlHnX6+f4FBEntBi5cqdwySqodsZ
         2PwTzwQDdZn2GVLVvXuS3sikBIZuPqo96IzOw=
Received: by 10.210.92.8 with SMTP id p8mr2489801ebb.15.1249716703032;
        Sat, 08 Aug 2009 00:31:43 -0700 (PDT)
Received: from sirnot.private (dhcp-077-251-020-197.chello.nl [77.251.20.197])
        by mx.google.com with ESMTPS id 5sm5054135eyf.58.2009.08.08.00.31.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 08 Aug 2009 00:31:42 -0700 (PDT)
User-Agent: Opera Mail/9.63 (Win32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125256>

Second in the revision cache series, this particular patch provides:
 - minimal API: caching only commit topo data
 - minimal porcelain: add and walk cache slices
 - appropriate tests

Signed-off-by: Nick Edelen <sirnot@gmail.com>

---
Corresponds to 2/5 in previous patchset.  The python test file has been 
eliminated, as discussion by Johannes and Micheal.

 Makefile                  |    2 +
 builtin-rev-cache.c       |  197 ++++++++
 builtin.h                 |    1 +
 commit.c                  |    4 +-
 git.c                     |    1 +
 rev-cache.c               | 1145 +++++++++++++++++++++++++++++++++++++++++++++
 revision.c                |    2 +-
 revision.h                |   44 ++-
 t/t6015-rev-cache-list.sh |  104 ++++
 9 files changed, 1497 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index daf4296..386700a 100644
--- a/Makefile
+++ b/Makefile
@@ -533,6 +533,7 @@ LIB_OBJS += reflog-walk.o
 LIB_OBJS += refs.o
 LIB_OBJS += remote.o
 LIB_OBJS += rerere.o
+LIB_OBJS += rev-cache.o
 LIB_OBJS += revision.o
 LIB_OBJS += run-command.o
 LIB_OBJS += server-info.o
@@ -623,6 +624,7 @@ BUILTIN_OBJS += builtin-reflog.o
 BUILTIN_OBJS += builtin-remote.o
 BUILTIN_OBJS += builtin-rerere.o
 BUILTIN_OBJS += builtin-reset.o
+BUILTIN_OBJS += builtin-rev-cache.o
 BUILTIN_OBJS += builtin-rev-list.o
 BUILTIN_OBJS += builtin-rev-parse.o
 BUILTIN_OBJS += builtin-revert.o
diff --git a/builtin-rev-cache.c b/builtin-rev-cache.c
new file mode 100755
index 0000000..2338871
--- /dev/null
+++ b/builtin-rev-cache.c
@@ -0,0 +1,197 @@
+#include "cache.h"
+#include "object.h"
+#include "commit.h"
+#include "diff.h"
+#include "revision.h"
+
+/* porcelain for rev-cache.c */
+static int handle_add(int argc, const char *argv[]) /* args beyond this command */
+{
+	struct rev_info revs;
+	struct rev_cache_info rci;
+	char dostdin = 0;
+	unsigned int flags = 0;
+	int i, retval;
+	unsigned char cache_sha1[20];
+	
+	init_revisions(&revs, 0);
+	init_rci(&rci);
+	
+	for (i = 0; i < argc; i++) {
+		if (!strcmp(argv[i], "--stdin"))
+			dostdin = 1;
+		else if (!strcmp(argv[i], "--fresh"))
+			starts_from_slices(&revs, UNINTERESTING);
+		else if (!strcmp(argv[i], "--not"))
+			flags ^= UNINTERESTING;
+		else if (!strcmp(argv[i], "--legs"))
+			rci.legs = 1;
+		else if (!strcmp(argv[i], "--noobjects"))
+			rci.objects = 0;
+		else if (!strcmp(argv[i], "--all")) {
+			const char *args[2];
+			int argn = 0;
+			
+			args[argn++] = "rev-list";
+			args[argn++] = "--all";
+			setup_revisions(argn, args, &revs, 0);
+		} else
+			handle_revision_arg(argv[i], &revs, flags, 1);
+	}
+	
+	if (dostdin) {
+		char line[1000];
+		
+		flags = 0;
+		while (fgets(line, sizeof(line), stdin)) {
+			int len = strlen(line);
+			while (len && (line[len - 1] == '\n' || line[len - 1] == '\r'))
+				line[--len] = 0;
+			
+			if (!len)
+				break;
+			
+			if (!strcmp(line, "--not"))
+				flags ^= UNINTERESTING;
+			else
+				handle_revision_arg(line, &revs, flags, 1);
+		}
+	}
+	
+	retval = make_cache_slice(&rci, &revs, 0, 0, cache_sha1);
+	if (retval < 0)
+		return retval;
+	
+	printf("%s\n", sha1_to_hex(cache_sha1));
+	
+	return 0;
+}
+
+static int handle_walk(int argc, const char *argv[])
+{
+	struct commit *commit;
+	struct rev_info revs;
+	struct commit_list *queue, *work, **qp;
+	unsigned char *sha1p, *sha1pt;
+	unsigned long date = 0;
+	unsigned int flags = 0;
+	int retval, slop = 5, i;
+	
+	init_revisions(&revs, 0);
+	
+	for (i = 0; i < argc; i++) {
+		if (!strcmp(argv[i], "--not"))
+			flags ^= UNINTERESTING;
+		else if (!strcmp(argv[i], "--objects"))
+			revs.tree_objects = revs.blob_objects = 1;
+		else
+			handle_revision_arg(argv[i], &revs, flags, 1);
+	}
+	
+	work = 0;
+	sha1p = 0;
+	for (i = 0; i < revs.pending.nr; i++) {
+		commit = lookup_commit(revs.pending.objects[i].item->sha1);
+		
+		sha1pt = get_cache_slice(commit);
+		if (!sha1pt)
+			die("%s: not in a cache slice", sha1_to_hex(commit->object.sha1));
+		
+		if (!i)
+			sha1p = sha1pt;
+		else if (sha1p != sha1pt)
+			die("walking porcelain is /per/ cache slice; commits cannot be spread out amoung several");
+		
+		insert_by_date(commit, &work);
+	}
+	
+	if (!sha1p)
+		die("nothing to traverse!");
+	
+	queue = 0;
+	qp = &queue;
+	commit = pop_commit(&work);
+	retval = traverse_cache_slice(&revs, sha1p, commit, &date, &slop, &qp, &work);
+	if (retval < 0)
+		return retval;
+	
+	printf("queue:\n");
+	while ((commit = pop_commit(&queue)) != 0) {
+		printf("%s\n", sha1_to_hex(commit->object.sha1));
+	}
+	
+	printf("work:\n");
+	while ((commit = pop_commit(&work)) != 0) {
+		printf("%s\n", sha1_to_hex(commit->object.sha1));
+	}
+	
+	printf("pending:\n");
+	for (i = 0; i < revs.pending.nr; i++) {
+		struct object *obj = revs.pending.objects[i].item;
+		
+		/* unfortunately, despite our careful generation, object duplication *is* a possibility...
+		 * (eg. same object introduced into two different branches) */
+		if (obj->flags & SEEN)
+			continue;
+		
+		printf("%s\n", sha1_to_hex(revs.pending.objects[i].item->sha1));
+		obj->flags |= SEEN;
+	}
+	
+	return 0;
+}
+
+static int handle_help(void)
+{
+	char *usage = "\
+usage:\n\
+git-rev-cache COMMAND [options] [<commit-id>...]\n\
+commands:\n\
+  add    - add revisions to the cache.  reads commit ids from stdin, \n\
+           formatted as: START START ... --not END END ...\n\
+           options:\n\
+            --all             use all branch heads as starts\n\
+            --fresh           exclude everything already in a cache slice\n\
+            --stdin           also read commit ids from stdin (same form as cmd)\n\
+            --legs            ensure branch is entirely self-contained\n\
+            --noobjects       don't add non-commit objects to slice\n\
+  walk   - walk a cache slice based on set of commits; formatted as add\n\
+           options:\n\
+           --objects          include non-commit objects in traversals\n\
+  fuse   - coagulate cache slices into a single cache.\n\
+           options:\n\
+            --all             include all objects in repository\n\
+            --noobjects       don't add non-commit objects to slice\n\
+            --ignore-size[=N] ignore slices of size >= N; defaults to ~5MB\n\
+  index  - regnerate the cache index.";
+	
+	puts(usage);
+	
+	return 0;
+}
+
+int cmd_rev_cache(int argc, const char *argv[], const char *prefix)
+{
+	const char *arg;
+	int r;
+	
+	git_config(git_default_config, NULL);
+	
+	if (argc > 1)
+		arg = argv[1];
+	else
+		arg = "";
+	
+	argc -= 2;
+	argv += 2;
+	if (!strcmp(arg, "add"))
+		r = handle_add(argc, argv);
+	else if (!strcmp(arg, "walk"))
+		r = handle_walk(argc, argv);
+	else
+		return handle_help();
+	
+	fprintf(stderr, "final return value: %d\n", r);
+	
+	return 0;
+}
diff --git a/builtin.h b/builtin.h
index 20427d2..00ecc9c 100644
--- a/builtin.h
+++ b/builtin.h
@@ -87,6 +87,7 @@ extern int cmd_remote(int argc, const char **argv, const char *prefix);
 extern int cmd_config(int argc, const char **argv, const char *prefix);
 extern int cmd_rerere(int argc, const char **argv, const char *prefix);
 extern int cmd_reset(int argc, const char **argv, const char *prefix);
+extern int cmd_rev_cache(int argc, const char **argv, const char *prefix);
 extern int cmd_rev_list(int argc, const char **argv, const char *prefix);
 extern int cmd_rev_parse(int argc, const char **argv, const char *prefix);
 extern int cmd_revert(int argc, const char **argv, const char *prefix);
diff --git a/commit.c b/commit.c
index e2bcbe8..65d223e 100644
--- a/commit.c
+++ b/commit.c
@@ -251,7 +251,9 @@ int parse_commit_buffer(struct commit *item, void *buffer, unsigned long size)
 			     sha1_to_hex(item->object.sha1));
 	item->tree = lookup_tree(parent);
 	bufptr += 46; /* "tree " + "hex sha1" + "\n" */
-	pptr = &item->parents;
+ 	pptr = &item->parents;
+	while (pop_commit(pptr))
+		; /* clear anything from cache */
 
 	graft = lookup_commit_graft(item->object.sha1);
 	while (bufptr + 48 < tail && !memcmp(bufptr, "parent ", 7)) {
diff --git a/git.c b/git.c
index 807d875..da3a9fb 100644
--- a/git.c
+++ b/git.c
@@ -342,6 +342,7 @@ static void handle_internal_command(int argc, const char **argv)
 		{ "repo-config", cmd_config },
 		{ "rerere", cmd_rerere, RUN_SETUP },
 		{ "reset", cmd_reset, RUN_SETUP },
+		{ "rev-cache", cmd_rev_cache, RUN_SETUP }, 
 		{ "rev-list", cmd_rev_list, RUN_SETUP },
 		{ "rev-parse", cmd_rev_parse },
 		{ "revert", cmd_revert, RUN_SETUP | NEED_WORK_TREE },
diff --git a/rev-cache.c b/rev-cache.c
new file mode 100755
index 0000000..5d9e150
--- /dev/null
+++ b/rev-cache.c
@@ -0,0 +1,1145 @@
+#include "cache.h"
+#include "object.h"
+#include "commit.h"
+#include "tree.h"
+#include "tree-walk.h"
+#include "blob.h"
+#include "tag.h"
+#include "diff.h"
+#include "revision.h"
+#include "run-command.h"
+
+
+/* single index maps objects to cache files */
+struct index_header {
+	char signature[8]; /* REVINDEX */
+	unsigned char version;
+	uint32_t ofs_objects;
+	
+	uint32_t object_nr;
+	unsigned char cache_nr;
+	
+	uint32_t max_date;
+};
+
+struct index_entry {
+	unsigned char sha1[20];
+	unsigned is_start : 1;
+	unsigned cache_index : 7;
+	uint32_t pos;
+};
+
+
+/* structure for actual cache file */
+struct cache_slice_header {
+	char signature[8]; /* REVCACHE */
+	unsigned char version;
+	uint32_t ofs_objects;
+	
+	uint32_t object_nr;
+	uint16_t path_nr;
+	uint32_t size;
+	
+	unsigned char sha1[20];
+};
+
+struct object_entry {
+	unsigned type : 3;
+	unsigned is_end : 1;
+	unsigned is_start : 1;
+	unsigned uninteresting : 1;
+	unsigned include : 1;
+	unsigned flags : 1; /* unused */
+	unsigned char sha1[20];
+	
+	unsigned merge_nr : 6;
+	unsigned split_nr : 7;
+	unsigned size_size : 3;
+	
+	uint32_t date;
+	uint16_t path;
+	
+	/* merge paths */
+	/* split paths */
+	/* size */
+};
+
+/* list resembles pack index format */
+static uint32_t fanout[0xff + 2];
+
+static unsigned char *idx_map;
+static int idx_size;
+static struct index_header idx_head;
+static unsigned char *idx_caches;
+static char no_idx;
+
+static struct strbuf *g_buffer;
+
+#define SUPPORTED_REVCACHE_VERSION 		1
+#define SUPPORTED_REVINDEX_VERSION		1
+
+#define PATH_WIDTH		sizeof(uint16_t)
+#define PATH_SIZE(x)	(PATH_WIDTH * (x))
+
+#define OE_SIZE		sizeof(struct object_entry)
+#define IE_SIZE		sizeof(struct index_entry)
+
+#define OE_CAST(p)	((struct object_entry *)(p))
+#define IE_CAST(p)	((struct index_entry *)(p))
+
+#define ACTUAL_OBJECT_ENTRY_SIZE(e)		(OE_SIZE + PATH_SIZE((e)->merge_nr + (e)->split_nr) + (e)->size_size)
+
+#define SLOP		5
+
+/* initialization */
+
+static int get_index_head(unsigned char *map, int len, struct index_header *head, uint32_t *fanout, unsigned char **caches)
+{
+	struct index_header whead;
+	int i, index = sizeof(struct index_header);
+	
+	memcpy(&whead, map, sizeof(struct index_header));
+	if (memcmp(whead.signature, "REVINDEX", 8) || whead.version > SUPPORTED_REVINDEX_VERSION)
+		return -1;
+	
+	memcpy(head->signature, "REVINDEX", 8);
+	head->version = whead.version;
+	head->ofs_objects = ntohl(whead.ofs_objects);
+	head->object_nr = ntohl(whead.object_nr);
+	head->cache_nr = whead.cache_nr;
+	head->max_date = ntohl(whead.max_date);
+	
+	if (len < index + head->cache_nr * 20 + 0x100 * sizeof(uint32_t))
+		return -2;
+	
+	*caches = xmalloc(head->cache_nr * 20);
+	memcpy(*caches, map + index, head->cache_nr * 20);
+	index += head->cache_nr * 20;
+	
+	memcpy(fanout, map + index, 0x100 * sizeof(uint32_t));
+	for (i = 0; i <= 0xff; i++)
+		fanout[i] = ntohl(fanout[i]);
+	fanout[0x100] = len;
+	
+	return 0;
+}
+
+/* added in init_index */
+static void cleanup_cache_slices(void)
+{
+	if (idx_map) {
+		free(idx_caches);
+		munmap(idx_map, idx_size);
+		idx_map = 0;
+	}
+	
+}
+
+static int init_index(void)
+{
+	int fd;
+	struct stat fi;
+	
+	fd = open(git_path("rev-cache/index"), O_RDONLY);
+	if (fd == -1 || fstat(fd, &fi))
+		goto end;
+	if (fi.st_size < sizeof(struct index_header))
+		goto end;
+	
+	idx_size = fi.st_size;
+	idx_map = xmmap(0, idx_size, PROT_READ, MAP_PRIVATE, fd, 0);
+	close(fd);
+	if (idx_map == MAP_FAILED)
+		goto end;
+	if (get_index_head(idx_map, fi.st_size, &idx_head, fanout, &idx_caches))
+		goto end;
+	
+	atexit(cleanup_cache_slices);
+	
+	return 0;
+	
+end:
+	idx_map = 0;
+	no_idx = 1;
+	return -1;
+}
+
+/* this assumes index is already loaded */
+static struct index_entry *search_index(unsigned char *sha1)
+{
+	int start, end, starti, endi, i, len, r;
+	struct index_entry *ie;
+	
+	if (!idx_map)
+		return 0;
+	
+	/* binary search */
+	start = fanout[(int)sha1[0]];
+	end = fanout[(int)sha1[0] + 1];
+	len = (end - start) / IE_SIZE;
+	if (!len || len * IE_SIZE != end - start)
+		return 0;
+	
+	starti = 0;
+	endi = len - 1;
+	for (;;) {
+		i = (endi + starti) / 2;
+		ie = IE_CAST(idx_map + start + i * IE_SIZE);
+		r = hashcmp(sha1, ie->sha1);
+		
+		if (r) {
+			if (starti + 1 == endi) {
+				starti++;
+				continue;
+			} else if (starti == endi)
+				break;
+			
+			if (r > 0)
+				starti = i;
+			else /* r < 0 */
+				endi = i;
+		} else
+			return ie;
+	}
+	
+	return 0;
+}
+
+unsigned char *get_cache_slice(struct commit *commit)
+{
+	struct index_entry *ie;
+	
+	if (!idx_map) {
+		if (no_idx)
+			return 0;
+		init_index();
+	}
+	
+	if (commit->date > idx_head.max_date)
+		return 0;
+	
+	ie = search_index(commit->object.sha1);
+	
+	if (ie && ie->cache_index < idx_head.cache_nr)
+		return idx_caches + ie->cache_index * 20;
+	
+	return 0;
+}
+
+
+/* traversal */
+
+static int setup_traversal(struct cache_slice_header *head, unsigned char *map, struct commit *commit, struct commit_list **work)
+{
+	struct index_entry *iep;
+	struct object_entry *oep;
+	struct commit_list *prev, *wp, **wpp;
+	int retval;
+	
+	/* printf("adding %s\n", sha1_to_hex(commit->object.sha1)); */
+	iep = search_index(commit->object.sha1);
+	oep = OE_CAST(map + ntohl(iep->pos));
+	oep->include = 1;
+	retval = ntohl(iep->pos);
+	
+	/* include any others in the work array */
+	prev = 0;
+	wpp = work;
+	wp = *work;
+	while (wp) {
+		struct object *obj = &wp->item->object;
+		struct commit *co;
+		int t;
+		
+		/* is this in our cache slice? */
+		iep = search_index(obj->sha1);
+		if (!iep || hashcmp(idx_caches + iep->cache_index * 20, head->sha1)) {
+			prev = wp;
+			wp = wp->next;
+			wpp = &wp;
+ 			continue;
+		}
+		
+		t = ntohl(iep->pos);
+		oep = OE_CAST(map + t);
+		
+		oep->include = 1;
+		oep->uninteresting = !!(obj->flags & UNINTERESTING);
+		if (t < retval)
+			retval = t;
+		
+		/* remove from work list */
+		co = pop_commit(wpp);
+		wp = *wpp;
+		if (prev)
+			prev->next = wp;
+	}
+	
+	return retval;
+}
+
+#define IPATH				0x40
+#define UPATH				0x80
+
+#define GET_COUNT(x)		((x) & 0x3f)
+#define SET_COUNT(x, s)		((x) = ((x) & ~0x3f) | ((s) & 0x3f))
+
+static int traverse_cache_slice_1(struct cache_slice_header *head, unsigned char *map, 
+	struct rev_info *revs, struct commit *commit, 
+	unsigned long *date_so_far, int *slop_so_far, 
+	struct commit_list ***queue, struct commit_list **work)
+{
+	struct commit_list *insert_cache = 0;
+	struct commit **last_objects, *co;
+	int i, total_path_nr = head->path_nr, retval = -1;
+	char consume_children = 0;
+	unsigned char *paths;
+	
+	paths = xcalloc(total_path_nr, PATH_WIDTH);
+	last_objects = xcalloc(total_path_nr, sizeof(struct commit *));
+	
+	i = setup_traversal(head, map, commit, work);
+	
+	/* i already set */
+	while (i < head->size) {
+		struct object_entry *entry = OE_CAST(map + i);
+		int path = ntohs(entry->path);
+		struct object *obj;
+		int index = i;
+		
+		i += ACTUAL_OBJECT_ENTRY_SIZE(entry);
+		
+		/* add extra objects if necessary */
+		if (entry->type != OBJ_COMMIT)
+			continue;
+		else
+			consume_children = 0;
+		
+		if (path >= total_path_nr)
+			goto end;
+		
+		/* in one of our branches? 
+		 * uninteresting trumps interesting */
+		if (entry->include)
+			paths[path] |= entry->uninteresting ? UPATH : IPATH;
+		else if (!paths[path])
+			continue;
+		
+		/* date stuff */
+		if (revs->max_age != -1 && ntohl(entry->date) < revs->max_age)
+			paths[path] |= UPATH;
+		
+		/* lookup object */
+		co = lookup_commit(entry->sha1);
+		obj = &co->object;
+		
+		if (obj->flags & UNINTERESTING)
+			paths[path] |= UPATH;
+		
+		if ((paths[path] & IPATH) && (paths[path] & UPATH)) {
+			paths[path] = UPATH;
+			
+			/* mark edge */
+			if (last_objects[path]) {
+				parse_commit(last_objects[path]);
+				
+				last_objects[path]->object.flags &= ~FACE_VALUE;
+				last_objects[path] = 0;
+			}
+		}
+		
+		/* now we gotta re-assess the whole interesting thing... */
+		entry->uninteresting = !!(paths[path] & UPATH);
+		
+		/* first close paths */
+		if (entry->split_nr) {
+			int j, off = index + OE_SIZE + PATH_SIZE(entry->merge_nr);
+			
+			for (j = 0; j < entry->split_nr; j++) {
+				unsigned short p = ntohs(*(unsigned short *)(map + off + PATH_SIZE(j)));
+				
+				if (p >= total_path_nr)
+					goto end;
+				
+				/* boundary commit? */
+				if ((paths[p] & IPATH) && entry->uninteresting) {
+					if (last_objects[p]) {
+						parse_commit(last_objects[p]);
+						
+						last_objects[p]->object.flags &= ~FACE_VALUE;
+						last_objects[p] = 0;
+					}
+				} else if (last_objects[p] && !last_objects[p]->object.parsed)
+					commit_list_insert(co, &last_objects[p]->parents);
+				
+				/* can't close a merge path until all are parents have been encountered */
+				if (GET_COUNT(paths[p])) {
+					SET_COUNT(paths[p], GET_COUNT(paths[p]) - 1);
+					
+					if (GET_COUNT(paths[p]))
+						continue;
+				}
+				
+				paths[p] = 0;
+				last_objects[p] = 0;
+			}
+		}
+		
+		/* make topo relations */
+		if (last_objects[path] && !last_objects[path]->object.parsed)
+			commit_list_insert(co, &last_objects[path]->parents);
+		
+		/* initialize commit */
+		if (!entry->is_end) {
+			co->date = ntohl(entry->date);
+ 			obj->flags |= ADDED | FACE_VALUE;
+		} else
+			parse_commit(co);
+		
+		obj->flags |= SEEN;
+ 		
+ 		if (entry->uninteresting)
+ 			obj->flags |= UNINTERESTING;
+		
+		/* we need to know what the edges are */
+		last_objects[path] = co;
+		
+		/* add to list */
+		if (!(obj->flags & UNINTERESTING) || revs->show_all) {
+			if (entry->is_end)
+				insert_by_date_cached(co, work, insert_cache, &insert_cache);
+			else
+				*queue = &commit_list_insert(co, *queue)->next;
+			
+			/* add children to list as well */
+			if (obj->flags & UNINTERESTING)
+				consume_children = 0;
+			else 
+				consume_children = 1;
+		}
+		
+		/* open parents */
+		if (entry->merge_nr) {
+			int j, off = index + OE_SIZE;
+			char flag = entry->uninteresting ? UPATH : IPATH;
+			
+			for (j = 0; j < entry->merge_nr; j++) {
+				unsigned short p = ntohs(*(unsigned short *)(map + off + PATH_SIZE(j)));
+				
+				if (p >= total_path_nr)
+					goto end;
+				
+				if (paths[p] & flag)
+					continue;
+				
+				paths[p] |= flag;
+			}
+			
+			/* make sure we don't use this path before all our parents have had their say */
+			SET_COUNT(paths[path], entry->merge_nr);
+		}
+		
+	}
+	
+	retval = 0;
+	
+end:
+	free(paths);
+	free(last_objects);
+	
+	return retval;
+}
+
+static int get_cache_slice_header(unsigned char *cache_sha1, unsigned char *map, int len, struct cache_slice_header *head)
+{
+	int t;
+	
+	memcpy(head, map, sizeof(struct cache_slice_header));
+	head->ofs_objects = ntohl(head->ofs_objects);
+	head->object_nr = ntohl(head->object_nr);
+	head->size = ntohl(head->size);
+	head->path_nr = ntohs(head->path_nr);
+	
+	if (memcmp(head->signature, "REVCACHE", 8))
+		return -1;
+	if (head->version > SUPPORTED_REVCACHE_VERSION)
+		return -2;
+	if (hashcmp(head->sha1, cache_sha1))
+		return -3;
+	t = sizeof(struct cache_slice_header);
+	if (t != head->ofs_objects || t >= len)
+		return -4;
+	
+	head->size = len;
+	
+	return 0;
+}
+
+int traverse_cache_slice(struct rev_info *revs, 
+	unsigned char *cache_sha1, struct commit *commit, 
+	unsigned long *date_so_far, int *slop_so_far, 
+	struct commit_list ***queue, struct commit_list **work)
+{
+	int fd = -1, retval = -3;
+	struct stat fi;
+	struct cache_slice_header head;
+	struct rev_cache_info *rci;
+	unsigned char *map = MAP_FAILED;
+	
+	/* the index should've been loaded already to find cache_sha1, but it's good 
+	 * to be absolutely sure... */
+	if (!idx_map)
+		init_index();
+	if (!idx_map)
+		return -1;
+	
+	/* load options */
+	rci = &revs->rev_cache_info;
+	
+	memset(&head, 0, sizeof(struct cache_slice_header));
+	
+	fd = open(git_path("rev-cache/%s", sha1_to_hex(cache_sha1)), O_RDONLY);
+	if (fd == -1)
+		goto end;
+	if (fstat(fd, &fi) || fi.st_size < sizeof(struct cache_slice_header))
+		goto end;
+	
+	map = xmmap(0, fi.st_size, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);
+	if (map == MAP_FAILED)
+		goto end;
+	if (get_cache_slice_header(cache_sha1, map, fi.st_size, &head))
+		goto end;
+	
+	retval = traverse_cache_slice_1(&head, map, revs, commit, date_so_far, slop_so_far, queue, work);
+	
+end:
+	if (map != MAP_FAILED)
+		munmap(map, fi.st_size);
+	if (fd != -1)
+		close(fd);
+	
+	return retval;
+}
+
+
+
+/* generation */
+
+struct path_track {
+	struct commit *commit;
+	int path; /* for decrementing paths */
+	struct strbuf path_str; /* for closing children */
+	
+	struct path_track *next, *prev;
+};
+
+static unsigned char *paths;
+static int path_nr = 1, path_sz;
+
+static struct path_track *children_to_close, *paths_to_dec;
+static struct path_track *path_track_alloc;
+
+#define PATH_IN_USE			0x80 /* biggest bit we can get as a char */
+
+static int get_new_path(void)
+{
+	int i;
+	
+	for (i = 1; i < path_nr; i++)
+		if (!paths[i])
+			break;
+	
+	if (i == path_nr) {
+		if (path_nr >= path_sz) {
+			path_sz += 50;
+			paths = xrealloc(paths, path_sz);
+			memset(paths + path_sz - 50, 0, 50);
+		}
+		path_nr++;
+	}
+	
+	paths[i] = PATH_IN_USE;
+	return i;
+}
+
+static void remove_path_track(struct path_track **ppt, char total_free)
+{
+	struct path_track *t = *ppt;
+	
+	if (t->next)
+		t->next->prev = t->prev;
+	if (t->prev)
+		t->prev->next = t->next;
+	
+	t = t->next;
+	
+	if (total_free)
+		free(*ppt);
+	else {
+		(*ppt)->next = path_track_alloc;
+		path_track_alloc = *ppt;	
+	}
+	
+	*ppt = t;
+}
+
+static struct path_track *find_path_track(struct path_track *head, struct commit *commit)
+{
+	while (head) {
+		if (head->commit == commit)
+			return head;
+		head = head->next;
+	}
+	
+	return 0;
+}
+
+static struct path_track *make_path_track(struct path_track **head, struct commit *commit)
+{
+	struct path_track *pt;
+	
+	if (path_track_alloc) {
+		pt = path_track_alloc;
+		path_track_alloc = pt->next;
+	} else
+		pt = xmalloc(sizeof(struct path_track));
+	
+	memset(pt, 0, sizeof(struct path_track));
+	pt->commit = commit;
+	
+	pt->next = *head;
+	if (*head)
+		(*head)->prev = pt;
+	*head = pt;
+	
+	return pt;
+}
+
+static void add_child_to_close(struct commit *commit, int path)
+{
+	struct path_track *pt = find_path_track(children_to_close, commit);
+	unsigned short write_path;
+	
+	if (!pt) {
+		pt = make_path_track(&children_to_close, commit);
+		strbuf_init(&pt->path_str, 0);
+	}
+	
+	write_path = htons((unsigned short)path);
+	strbuf_add(&pt->path_str, &write_path, PATH_WIDTH);
+}
+
+static void add_path_to_dec(struct commit *commit, int path)
+{
+	make_path_track(&paths_to_dec, commit);
+	paths_to_dec->path = path;
+}
+
+static void handle_paths(struct commit *commit, struct object_entry *object, struct strbuf *merge_str, struct strbuf *split_str)
+{
+	int parent_nr, open_parent_nr, this_path;
+	struct commit_list *list;
+	struct commit *first_parent;
+	struct path_track **ppt, *pt;
+	
+	/* we can only re-use a closed path once all it's children have been encountered, 
+	 * as we need to keep track of commit boundaries */
+	ppt = &paths_to_dec;
+	pt = *ppt;
+	while (pt) {
+		if (pt->commit == commit) {
+			if (paths[pt->path] != PATH_IN_USE)
+				paths[pt->path]--;
+			remove_path_track(ppt, 0);
+			pt = *ppt;
+		} else {
+			pt = pt->next;
+			ppt = &pt;
+		}
+	}
+	
+	/* the commit struct has no way of keeping track of children -- necessary for closing 
+	 * unused paths and tracking path boundaries -- so we have to do it here */
+	ppt = &children_to_close;
+	pt = *ppt;
+	while (pt) {
+		if (pt->commit != commit) {
+			pt = pt->next;
+			ppt = &pt;
+			continue;
+		}
+		
+		object->split_nr = pt->path_str.len / PATH_WIDTH;
+		strbuf_add(split_str, pt->path_str.buf, pt->path_str.len);
+		
+		strbuf_release(&pt->path_str);
+		remove_path_track(ppt, 0);
+		break;
+	}
+	
+	/* initialize our self! */
+	if (!commit->indegree) {
+		commit->indegree = get_new_path();
+		object->is_start = 1;
+	}
+	
+	this_path = commit->indegree;
+	paths[this_path] = PATH_IN_USE;
+	object->path = htons(this_path);
+	
+	/* count interesting parents */
+	parent_nr = open_parent_nr = 0;
+	first_parent = 0;
+	for (list = commit->parents; list; list = list->next) {
+		if (list->item->object.flags & UNINTERESTING) {
+			object->is_end = 1;
+			continue;
+		}
+		
+		parent_nr++;
+		if (!list->item->indegree)
+			open_parent_nr++;
+		if (!first_parent)
+			first_parent = list->item;
+	}
+	
+	if (!parent_nr)
+		return;
+	
+	if (parent_nr == 1 && open_parent_nr == 1) {
+		first_parent->indegree = this_path;
+		return;
+	}
+	
+	/* make merge list */
+	object->merge_nr = parent_nr;
+	paths[this_path] = parent_nr;
+	
+	for (list = commit->parents; list; list = list->next) {
+		struct commit *p = list->item;
+		unsigned short write_path;
+		
+		if (p->object.flags & UNINTERESTING)
+			continue;
+		
+		/* unfortunately due to boundary tracking we can't re-use merge paths
+		 * (unable to guarantee last parent path = this -> last won't always be able to 
+		 * set this as a boundary object */
+		if (!p->indegree)
+			p->indegree = get_new_path();
+		
+		write_path = htons((unsigned short)p->indegree);
+		strbuf_add(merge_str, &write_path, PATH_WIDTH);
+		
+		/* make sure path is properly ended */
+		add_child_to_close(p, this_path);
+		add_path_to_dec(p, this_path);
+	}
+	
+}
+
+
+static void add_object_entry(const unsigned char *sha1, int type, struct object_entry *nothisone, 
+	struct strbuf *merge_str, struct strbuf *split_str)
+{
+	struct object_entry object;
+	
+	if (!nothisone) {
+		memset(&object, 0, sizeof(object));
+		hashcpy(object.sha1, sha1);
+		object.type = type;
+		
+		if (merge_str)
+			object.merge_nr = merge_str->len / PATH_WIDTH;
+		if (split_str)
+			object.split_nr = split_str->len / PATH_WIDTH;
+		
+		nothisone = &object;
+	}
+	
+	strbuf_add(g_buffer, nothisone, sizeof(object));
+	
+	if (merge_str && merge_str->len)
+		strbuf_add(g_buffer, merge_str->buf, merge_str->len);
+	if (split_str && split_str->len)
+		strbuf_add(g_buffer, split_str->buf, split_str->len);
+	
+}
+
+static void init_revcache_directory(void)
+{
+	struct stat fi;
+	
+	if (stat(git_path("rev-cache"), &fi) || !S_ISDIR(fi.st_mode))
+		if (mkdir(git_path("rev-cache"), 0666))
+			die("can't make rev-cache directory");
+	
+}
+
+void init_rci(struct rev_cache_info *rci)
+{
+	rci->objects = 1;
+	rci->legs = 0;
+	rci->make_index = 1;
+	
+	rci->save_unique = 0;
+	rci->add_to_pending = 1;
+	
+	rci->ignore_size = 0;
+}
+
+int make_cache_slice(struct rev_cache_info *rci, 
+	struct rev_info *revs, struct commit_list **starts, struct commit_list **ends, 
+	unsigned char *cache_sha1)
+{
+	struct commit_list *list;
+	struct rev_info therevs;
+	struct strbuf buffer, startlist, endlist;
+	struct cache_slice_header head;
+	struct commit *commit;
+	unsigned char sha1[20];
+	struct strbuf merge_paths, split_paths;
+	int object_nr, total_sz, fd;
+	char file[PATH_MAX], *newfile;
+	struct rev_cache_info *trci, def_rci;
+	git_SHA_CTX ctx;
+	
+	if (!rci) {
+		rci = &def_rci;
+		init_rci(rci);
+	}
+	
+	init_revcache_directory();
+	strcpy(file, git_path("rev-cache/XXXXXX"));
+	fd = xmkstemp(file);
+	
+	strbuf_init(&buffer, 0);
+	strbuf_init(&startlist, 0);
+	strbuf_init(&endlist, 0);
+	strbuf_init(&merge_paths, 0);
+	strbuf_init(&split_paths, 0);
+	g_buffer = &buffer;
+	
+	if (!revs) {
+		revs = &therevs;
+		init_revisions(revs, 0);
+		
+		/* we're gonna assume no one else has already traversed this... */
+		for (list = *starts; list; list = list->next)
+			add_pending_object(revs, &list->item->object, 0);
+		
+		for (list = *ends; list; list = list->next) {
+			list->item->object.flags |= UNINTERESTING;
+			add_pending_object(revs, &list->item->object, 0);
+		}
+	}
+	
+	/* write head placeholder */
+	memset(&head, 0, sizeof(head));
+	head.ofs_objects = htonl(sizeof(head));
+	xwrite(fd, &head, sizeof(head));
+	
+	/* init revisions! */
+	revs->tree_objects = 1;
+	revs->blob_objects = 1;
+	revs->topo_order = 1;
+	revs->lifo = 1;
+	
+	/* re-use info from other caches if possible */
+	trci = &revs->rev_cache_info;
+	init_rci(trci);
+	trci->save_unique = 1;
+	trci->add_to_pending = 0;
+	
+	setup_revisions(0, 0, revs, 0);
+	if (prepare_revision_walk(revs))
+		die("died preparing revision walk");
+	
+	object_nr = total_sz = 0;
+	while ((commit = get_revision(revs)) != 0) {
+		struct object_entry object;
+		
+		strbuf_setlen(&merge_paths, 0);
+		strbuf_setlen(&split_paths, 0);
+		
+		memset(&object, 0, sizeof(object));
+		object.type = OBJ_COMMIT;
+		object.date = htonl(commit->date);
+		hashcpy(object.sha1, commit->object.sha1);
+		
+		handle_paths(commit, &object, &merge_paths, &split_paths);
+		
+		if (object.is_end)
+			strbuf_add(&endlist, object.sha1, 20);
+		if (object.is_start)
+			strbuf_add(&startlist, object.sha1, 20);
+		
+		commit->indegree = 0;
+		
+		add_object_entry(0, 0, &object, &merge_paths, &split_paths);
+		object_nr++;
+		
+		/* print every ~1MB or so */
+		if (buffer.len > 1000000) {
+			write_in_full(fd, buffer.buf, buffer.len);
+			total_sz += buffer.len;
+			
+			strbuf_setlen(&buffer, 0);
+		}
+	}
+	
+	if (buffer.len) {
+		write_in_full(fd, buffer.buf, buffer.len);
+		total_sz += buffer.len;
+	}
+	
+	/* go ahead a free some stuff... */
+	strbuf_release(&buffer);
+	strbuf_release(&merge_paths);
+	strbuf_release(&split_paths);
+	if (path_sz)
+		free(paths);
+	while (path_track_alloc)
+		remove_path_track(&path_track_alloc, 1);
+	
+	/* the meaning of the hash name is more or less irrelevant, it's the uniqueness that matters */
+	strbuf_add(&endlist, startlist.buf, startlist.len);
+	git_SHA1_Init(&ctx);
+	git_SHA1_Update(&ctx, endlist.buf, endlist.len);
+	git_SHA1_Final(sha1, &ctx);
+	
+	/* now actually initialize header */
+	strcpy(head.signature, "REVCACHE");
+	head.version = SUPPORTED_REVCACHE_VERSION;
+	
+	head.object_nr = htonl(object_nr);
+	head.size = htonl(ntohl(head.ofs_objects) + total_sz);
+	head.path_nr = htons(path_nr);
+	hashcpy(head.sha1, sha1);
+	
+	/* some info! */
+	fprintf(stderr, "objects: %d\n", object_nr);
+	fprintf(stderr, "paths: %d\n", path_nr);
+	
+	lseek(fd, 0, SEEK_SET);
+	xwrite(fd, &head, sizeof(head));
+	
+	if (rci->make_index && make_cache_index(rci, sha1, fd, ntohl(head.size)) < 0)
+		die("can't update index");
+	
+	close(fd);
+	
+	newfile = git_path("rev-cache/%s", sha1_to_hex(sha1));
+	if (rename(file, newfile))
+		die("can't move temp file");
+	
+	/* let our caller know what we've just made */
+	if (cache_sha1)
+		hashcpy(cache_sha1, sha1);
+	
+	strbuf_release(&endlist);
+	strbuf_release(&startlist);
+	
+	return 0;
+}
+
+
+static int index_sort_hash(const void *a, const void *b)
+{
+	return hashcmp(IE_CAST(a)->sha1, IE_CAST(b)->sha1);
+}
+
+static int write_cache_index(struct strbuf *body)
+{
+	struct index_header whead;
+	struct lock_file *lk;
+	int fd, i;
+	
+	/* clear index map if loaded */
+	if (idx_map) {
+		munmap(idx_map, idx_size);
+		idx_map = 0;
+	}
+	
+	lk = xcalloc(sizeof(struct lock_file), 1);
+	fd = hold_lock_file_for_update(lk, git_path("rev-cache/index"), 0);
+	if (fd < 0) {
+		free(lk);
+		return -1;
+	}
+	
+	/* endianness yay! */
+	memset(&whead, 0, sizeof(whead));
+	memcpy(whead.signature, "REVINDEX", 8);
+	whead.version = idx_head.version;
+	whead.ofs_objects = htonl(idx_head.ofs_objects);
+	whead.object_nr = htonl(idx_head.object_nr);
+	whead.cache_nr = idx_head.cache_nr;
+	whead.max_date = htonl(idx_head.max_date);
+	
+	write(fd, &whead, sizeof(struct index_header));
+	write_in_full(fd, idx_caches, idx_head.cache_nr * 20);
+	
+	for (i = 0; i <= 0xff; i++)
+		fanout[i] = htonl(fanout[i]);
+	write_in_full(fd, fanout, 0x100 * sizeof(uint32_t));
+	
+	write_in_full(fd, body->buf, body->len);
+	
+	if (commit_lock_file(lk) < 0)
+		return -2;
+	
+	/* lk freed by lockfile.c */
+	
+	return 0;
+}
+
+int make_cache_index(struct rev_cache_info *rci, unsigned char *cache_sha1, 
+	int fd, unsigned int size)
+{
+	struct strbuf buffer;
+	int i, cache_index, cur;
+	unsigned char *map;
+	unsigned long max_date;
+	
+	if (!idx_map)
+		init_index();
+	
+	lseek(fd, 0, SEEK_SET);
+	map = xmmap(0, size, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);
+	if (map == MAP_FAILED)
+		return -1;
+	
+	strbuf_init(&buffer, 0);
+	if (idx_map) {
+		strbuf_add(&buffer, idx_map + fanout[0], fanout[0x100] - fanout[0]);
+	} else {
+		/* not an update */
+		memset(&idx_head, 0, sizeof(struct index_header));
+		idx_caches = 0;
+		
+		strcpy(idx_head.signature, "REVINDEX");
+		idx_head.version = SUPPORTED_REVINDEX_VERSION;
+		idx_head.ofs_objects = sizeof(struct index_header) + 0x100 * sizeof(uint32_t);
+	}
+	
+	/* are we remaking a slice? */
+	for (i = 0; i < idx_head.cache_nr; i++)
+		if (!hashcmp(idx_caches + i * 20, cache_sha1))
+			break;
+	
+	if (i == idx_head.cache_nr) {
+		cache_index = idx_head.cache_nr++;
+		idx_head.ofs_objects += 20;
+		
+		idx_caches = xrealloc(idx_caches, idx_head.cache_nr * 20);
+		hashcpy(idx_caches + cache_index * 20, cache_sha1);
+	} else
+		cache_index = i;
+	
+	i = sizeof(struct cache_slice_header); /* offset */
+	max_date = idx_head.max_date;
+	while (i < size) {
+		struct index_entry index_entry, *entry;
+		struct object_entry *object_entry = OE_CAST(map + i);
+		unsigned long date;
+		int pos = i;
+		
+		i += ACTUAL_OBJECT_ENTRY_SIZE(object_entry);
+		
+		if (object_entry->type != OBJ_COMMIT)
+			continue;
+		
+		/* don't include ends; otherwise we'll find ourselves in loops */
+		if (object_entry->is_end)
+			continue;
+		
+		/* handle index duplication
+		 * -> keep old copy unless new one is an end -- based on expected usage, older ones will be more 
+		 * likely to lead to greater slice traversals than new ones
+		 * should we allow more intelligent overriding? */
+		date = ntohl(object_entry->date);
+		if (date > idx_head.max_date) {
+ 			entry = 0;
+			if (date > max_date)
+				max_date = date;
+		} else
+			entry = search_index(object_entry->sha1);
+		
+		if (entry && !object_entry->is_start)
+			continue;
+		else if (entry) /* mmm, pointer arithmetic... tasty */  /* (entry-idx_map = offset, so cast is valid) */
+			entry = IE_CAST(buffer.buf + (unsigned int)((unsigned char *)entry - idx_map) - fanout[0]);
+		else
+			entry = &index_entry;
+		
+		memset(entry, 0, sizeof(index_entry));
+		hashcpy(entry->sha1, object_entry->sha1);
+		entry->is_start = object_entry->is_start;
+		entry->cache_index = cache_index;
+		entry->pos = htonl(pos);
+		
+		if (entry == &index_entry) {
+			strbuf_add(&buffer, entry, sizeof(index_entry));
+			idx_head.object_nr++;
+		}
+		
+	}
+	
+	idx_head.max_date = max_date;
+	qsort(buffer.buf, buffer.len / IE_SIZE, IE_SIZE, index_sort_hash);
+	
+	/* generate fanout */
+	cur = 0x00;
+	for (i = 0; i < buffer.len; i += IE_SIZE) {
+		struct index_entry *entry = IE_CAST(buffer.buf + i);
+		
+		while (cur <= entry->sha1[0])
+			fanout[cur++] = i + idx_head.ofs_objects;
+	}
+	
+	while (cur <= 0xff)
+		fanout[cur++] = idx_head.ofs_objects + buffer.len;
+	
+	/* BOOM! */
+	if (write_cache_index(&buffer))
+		return -1;
+	
+	munmap(map, size);
+	strbuf_release(&buffer);
+	
+	/* idx_map is unloaded without cleanup_cache_slices(), so regardless of previous index existence 
+	 * we can still free this up */
+	free(idx_caches);
+	
+	return 0;
+}
+
+
+/* add start-commits from each cache slice (uninterestingness will be propogated) */
+void starts_from_slices(struct rev_info *revs, unsigned int flags)
+{
+	struct commit *commit;
+	int i;
+	
+	if (!idx_map)
+		init_index();
+	if (!idx_map)
+		return;
+	
+	/* haven't implemented which yet; no need really... */
+	for (i = idx_head.ofs_objects; i < idx_size; i += IE_SIZE) {
+		struct index_entry *entry = IE_CAST(idx_map + i);
+		
+		if (!entry->is_start)
+			continue;
+		
+		commit = lookup_commit(entry->sha1);
+		if (!commit)
+			continue;
+		
+		commit->object.flags |= flags;
+		add_pending_object(revs, &commit->object, 0);
+	}
+	
+}
diff --git a/revision.c b/revision.c
index 9f5dac5..485bf72 100644
--- a/revision.c
+++ b/revision.c
@@ -432,7 +432,7 @@ static void try_to_simplify_commit(struct rev_info *revs, struct commit *commit)
 	commit->object.flags |= TREESAME;
 }
 
-static void insert_by_date_cached(struct commit *p, struct commit_list **head,
+void insert_by_date_cached(struct commit *p, struct commit_list **head,
 		    struct commit_list *cached_base, struct commit_list **cache)
 {
 	struct commit_list *new_entry;
diff --git a/revision.h b/revision.h
index fb74492..200042a 100644
--- a/revision.h
+++ b/revision.h
@@ -13,11 +13,26 @@
 #define CHILD_SHOWN	(1u<<6)
 #define ADDED		(1u<<7)	/* Parents already parsed and added? */
 #define SYMMETRIC_LEFT	(1u<<8)
-#define ALL_REV_FLAGS	((1u<<9)-1)
+#define FACE_VALUE	(1u<<9)
+#define ALL_REV_FLAGS	((1u<<10)-1)
 
 struct rev_info;
 struct log_info;
 
+struct rev_cache_info {
+	/* generation flags */
+	unsigned objects : 1, 
+		legs : 1, 
+		make_index : 1;
+	
+	/* traversal flags */
+	unsigned save_unique : 1, 
+		add_to_pending : 1;
+	
+	/* fuse options */
+	unsigned int ignore_size;
+};
+
 struct rev_info {
 	/* Starting list */
 	struct commit_list *commits;
@@ -73,6 +88,10 @@ struct rev_info {
 			dense_combined_merges:1,
 			always_show_header:1;
 
+	/* rev-cache flags */
+	unsigned int for_pack:1, 
+		dont_cache_me:1;
+
 	/* Format info */
 	unsigned int	shown_one:1,
 			show_merge:1,
@@ -116,6 +135,9 @@ struct rev_info {
 	struct reflog_walk_info *reflog_info;
 	struct decoration children;
 	struct decoration merge_simplification;
+	
+	/* caching info, used ONLY by traverse_cache_slice */
+	struct rev_cache_info rev_cache_info;
 };
 
 #define REV_TREE_SAME		0
@@ -167,4 +189,24 @@ enum commit_action {
 
 extern enum commit_action simplify_commit(struct rev_info *revs, struct commit *commit);
 
+extern void insert_by_date_cached(struct commit *p, struct commit_list **head,
+		    struct commit_list *cached_base, struct commit_list **cache);
+
+/* rev-cache.c */
+
+extern unsigned char *get_cache_slice(struct commit *commit);
+extern int traverse_cache_slice(struct rev_info *revs, 
+	unsigned char *cache_sha1, struct commit *commit, 
+	unsigned long *date_so_far, int *slop_so_far, 
+	struct commit_list ***queue, struct commit_list **work);
+
+extern void init_rci(struct rev_cache_info *rci);
+extern int make_cache_slice(struct rev_cache_info *rci, 
+	struct rev_info *revs, struct commit_list **tops, struct commit_list **bottoms, 
+	unsigned char *cache_sha1);
+extern int make_cache_index(struct rev_cache_info *rci, unsigned char *cache_sha1, 
+	int fd, unsigned int size);
+
+extern void starts_from_slices(struct rev_info *revs, unsigned int flags);
+
 #endif
diff --git a/t/t6015-rev-cache-list.sh b/t/t6015-rev-cache-list.sh
new file mode 100755
index 0000000..ccac4de
--- /dev/null
+++ b/t/t6015-rev-cache-list.sh
@@ -0,0 +1,104 @@
+#!/bin/sh
+
+test_description='git rev-cache tests'
+. ./test-lib.sh
+
+test_cmp_sorted() {
+	grep -io "[a-f0-9]*" $1 | sort >.tmpfile1 && 
+	grep -io "[a-f0-9]*" $2 | sort >.tmpfile2 && 
+	test_cmp .tmpfile1 .tmpfile2
+}
+
+# we want a totally wacked out branch structure...
+# we need branching and merging of sizes up through 3, tree 
+# addition/deletion, and enough branching to exercise path 
+# reuse
+test_expect_success 'init repo' '
+	echo bla >file && 
+	git add . && 
+	git commit -m "bla" && 
+
+	git branch b1 && 
+	git checkout b1 && 
+	echo blu >file2 && 
+	mkdir d1 && 
+	echo bang >d1/filed1 && 
+	git add . && 
+	git commit -m "blu" && 
+	
+	git checkout master && 
+	git branch b2 && 
+	git checkout b2 && 
+	echo kaplaa >>file && 
+	git commit -a -m "kaplaa" && 
+	
+	git checkout master && 
+	mkdir smoke && 
+	echo omg >smoke/bong && 
+	git add . && 
+	git commit -m "omg" && 
+	
+	git branch b4 && 
+	git checkout b4 && 
+	echo shazam >file8 && 
+	git add . && 
+	git commit -m "shazam" && 
+	git merge -m "merge b2" b2 && 
+	
+	echo bam >smoke/pipe && 
+	git add .
+	git commit -m "bam" && 
+	
+	git checkout master && 
+	echo pow >file7 && 
+	git add . && 
+	git commit -m "pow" && 
+	git merge -m "merge b4" b4 && 
+
+	git checkout b1 && 
+	echo stuff >d1/filed1 && 
+	git commit -a -m "stuff" && 
+
+	git branch b11 && 
+	git checkout b11 && 
+	echo wazzup >file3 &&
+	git add file3 && 
+	git commit -m "wazzup" && 
+
+	git checkout b1 && 
+	mkdir d1/d2 && 
+	echo lol >d1/d2/filed2 && 
+	git add . && 
+	git commit -m "lol" && 
+
+	git checkout master && 
+	git merge -m "triple merge" b1 b11 && 
+	git rm -r d1 &&  
+	git commit -a -m "oh noes"
+'
+
+git-rev-list HEAD --not HEAD~3 >proper_commit_list_limited
+git-rev-list HEAD >proper_commit_list
+
+test_expect_success 'make cache slice' '
+	git-rev-cache add HEAD 2>output.err && 
+	grep "final return value: 0" output.err
+'
+
+test_expect_success 'remake cache slice' '
+	git-rev-cache add --sizes HEAD 2>output.err && 
+	grep "final return value: 0" output.err
+'
+
+#check core mechanics and rev-list hook for commits
+test_expect_success 'test rev-caches walker directly (limited)' '
+	git-rev-cache walk HEAD --not HEAD~3 >list && 
+	test_cmp_sorted list proper_commit_list_limited
+'
+
+test_expect_success 'test rev-caches walker directly (unlimited)' '
+	git-rev-cache walk HEAD >list &&  
+	test_cmp_sorted list proper_commit_list
+'
+
+test_done
-- 
tg: (e658002..) t/revcache/basic (depends on: master)
