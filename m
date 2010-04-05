From: Nick Edelen <sirnot@gmail.com>
Subject: [PATCH 2/7 (v5)] basic api and porcelain
Date: Mon, 05 Apr 2010 20:58:05 +0100
Message-ID: <4BBA40CD.5040301@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Junio C Hamano <gitster@pobox.com>, Nicolas Pitre <nico@cam.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sam Vilain <sam@vilain.net>,
	Michael J Gruber <git@drmicha.warpmail
X-From: git-owner@vger.kernel.org Mon Apr 05 21:58:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NysRF-0000WJ-M6
	for gcvg-git-2@lo.gmane.org; Mon, 05 Apr 2010 21:58:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756371Ab0DET6L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Apr 2010 15:58:11 -0400
Received: from mail-ew0-f220.google.com ([209.85.219.220]:33419 "EHLO
	mail-ew0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756369Ab0DET6F (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Apr 2010 15:58:05 -0400
Received: by mail-ew0-f220.google.com with SMTP id 20so121824ewy.1
        for <git@vger.kernel.org>; Mon, 05 Apr 2010 12:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding;
        bh=WxyKW+anCbZ0NhgGLLfIqtqjB5Rp8QF6q7j7O9Hqt6E=;
        b=eznJcMyAWMn+pm8MCF1sxMZzj57q1GPIDgzHq1ZGbCY2iCUcLhfIHcsYoGkv7hUKkO
         DFtQxn+Z1M8HugeSiWWB34tJ3xLsT1ZLQ1DSCYSDQr7C7Amm7eN93cotQbavebW52u9J
         pHkaVd8/Jbw47IaUxn5GE/ykquWbJ/xNEpDh0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        b=GFhvBQzXOPjutyVYoGw9V4B7cpkBNmJJ3sdyS5FmOl2yPknBTM69ZQMhZVWupPubEH
         WDaVk6bpOWAsVnLkubo8q59N5/fu9Oe4TAqYlujHxsl8Wvx3OvAOehLG4CSurrXxI8Pc
         /Ijy7I7Oi4+2PaQoSpFlinREir1aPP5jNh64w=
Received: by 10.213.46.13 with SMTP id h13mr1678150ebf.83.1270497484447;
        Mon, 05 Apr 2010 12:58:04 -0700 (PDT)
Received: from [192.168.55.86] (dhcp-077-251-020-197.chello.nl [77.251.20.197])
        by mx.google.com with ESMTPS id 13sm6445383ewy.1.2010.04.05.12.58.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 05 Apr 2010 12:58:03 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144060>

Provides:
 - minimal API: caching only commit topo data
 - minimal porcelain: add and walk cache slices
 - appropriate tests

Signed-off-by: Nick Edelen <sirnot@gmail.com>

---
 Makefile                  |    2 +
 builtin.h                 |    1 +
 builtin/rev-cache.c       |  210 ++++++++
 commit.c                  |    2 +
 git.c                     |    1 +
 rev-cache.c               | 1273 +++++++++++++++++++++++++++++++++++++++++++++
 rev-cache.h               |  105 ++++
 revision.c                |    2 +-
 revision.h                |   26 +-
 t/t6019-rev-cache-list.sh |  106 ++++
 10 files changed, 1726 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index e210a42..4d87da4 100644
--- a/Makefile
+++ b/Makefile
@@ -597,6 +597,7 @@ LIB_OBJS += refs.o
 LIB_OBJS += remote.o
 LIB_OBJS += replace_object.o
 LIB_OBJS += rerere.o
+LIB_OBJS += rev-cache.o
 LIB_OBJS += resolve-undo.o
 LIB_OBJS += revision.o
 LIB_OBJS += run-command.o
@@ -697,6 +698,7 @@ BUILTIN_OBJS += builtin/reflog.o
 BUILTIN_OBJS += builtin/remote.o
 BUILTIN_OBJS += builtin/replace.o
 BUILTIN_OBJS += builtin/rerere.o
+BUILTIN_OBJS += builtin/rev-cache.o
 BUILTIN_OBJS += builtin/reset.o
 BUILTIN_OBJS += builtin/rev-list.o
 BUILTIN_OBJS += builtin/rev-parse.o
diff --git a/builtin.h b/builtin.h
index 464588b..1fea332 100644
--- a/builtin.h
+++ b/builtin.h
@@ -112,6 +112,7 @@ extern int cmd_remote(int argc, const char **argv, const char *prefix);
 extern int cmd_config(int argc, const char **argv, const char *prefix);
 extern int cmd_rerere(int argc, const char **argv, const char *prefix);
 extern int cmd_reset(int argc, const char **argv, const char *prefix);
+extern int cmd_rev_cache(int argc, const char **argv, const char *prefix);
 extern int cmd_rev_list(int argc, const char **argv, const char *prefix);
 extern int cmd_rev_parse(int argc, const char **argv, const char *prefix);
 extern int cmd_revert(int argc, const char **argv, const char *prefix);
diff --git a/builtin/rev-cache.c b/builtin/rev-cache.c
new file mode 100644
index 0000000..e322467
--- /dev/null
+++ b/builtin/rev-cache.c
@@ -0,0 +1,210 @@
+#include "cache.h"
+#include "object.h"
+#include "commit.h"
+#include "diff.h"
+#include "revision.h"
+#include "rev-cache.h"
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
+	struct commit_list *starts = 0, *ends = 0;
+	struct commit *commit;
+
+	init_revisions(&revs, 0);
+	init_rev_cache_info(&rci);
+
+	for (i = 0; i < argc; i++) {
+		if (!strcmp(argv[i], "--stdin"))
+			dostdin = 1;
+		else if (!strcmp(argv[i], "--fresh") || !strcmp(argv[i], "--incremental"))
+			starts_from_slices(&revs, UNINTERESTING);
+		else if (!strcmp(argv[i], "--not"))
+			flags ^= UNINTERESTING;
+		else if (!strcmp(argv[i], "--legs") || !strcmp(argv[i], "--close"))
+			rci.legs = 1;
+		else if (!strcmp(argv[i], "--no-objects"))
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
+	retval = make_cache_slice(&rci, &revs, &starts, &ends, cache_sha1);
+	if (retval < 0)
+		return retval;
+
+	printf("%s\n", sha1_to_hex(cache_sha1));
+
+	fprintf(stderr, "endpoints:\n");
+	while ((commit = pop_commit(&starts)))
+		fprintf(stderr, "S %s\n", sha1_to_hex(commit->object.sha1));
+	while ((commit = pop_commit(&ends)))
+		fprintf(stderr, "E %s\n", sha1_to_hex(commit->object.sha1));
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
+	revs.pending.nr = 0;
+	queue = 0;
+	qp = &queue;
+	commit = pop_commit(&work);
+	retval = traverse_cache_slice(&revs, sha1p, commit, &date, &slop, &qp, &work);
+	if (retval < 0)
+		return retval;
+
+	fprintf(stderr, "queue:\n");
+	while ((commit = pop_commit(&queue)) != 0) {
+		printf("%s\n", sha1_to_hex(commit->object.sha1));
+	}
+
+	fprintf(stderr, "work:\n");
+	while ((commit = pop_commit(&work)) != 0) {
+		printf("%s\n", sha1_to_hex(commit->object.sha1));
+	}
+
+	fprintf(stderr, "pending:\n");
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
+git-rev-cache COMMAND [options] [<commit>...]\n\
+commands:\n\
+  add    - add revisions to the cache.  reads commit ids from stdin, \n\
+           START = 'interesting', END = boundary of 'uninterestingness'\n\
+           options:\n\
+            --all                  use all branch heads as starts\n\
+            --fresh/--incremental  exclude everything already in a cache slice\n\
+            --stdin                also read commit ids from stdin (same form\n\
+                                   as cmd)\n\
+            --legs/--close         ensure branch is entirely self-contained\n\
+            --no-objects           don't add non-commit objects to slice\n\
+  walk   - walk a cache slice based on set of commits; formatted as add\n\
+           options:\n\
+           --objects               include non-commit objects in traversals\n\
+  fuse   - coalesce cache slices into a single cache.\n\
+           options:\n\
+            --all                  include all objects in repository\n\
+            --no-objects           don't add non-commit objects to slice\n\
+            --ignore-size[=N]      ignore slices of size >= N; defaults to ~5MB\n\
+            --keep-size[=N]\n\
+  index  - regnerate the cache index.\n\
+  alt    - create a slice pointer to slice identified by a passed path";
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
diff --git a/commit.c b/commit.c
index 731191e..263dd74 100644
--- a/commit.c
+++ b/commit.c
@@ -251,6 +251,8 @@ int parse_commit_buffer(struct commit *item, void *buffer, unsigned long size)
 	item->tree = lookup_tree(parent);
 	bufptr += 46; /* "tree " + "hex sha1" + "\n" */
 	pptr = &item->parents;
+	while (pop_commit(pptr))
+		; /* clear anything from cache */
 
 	graft = lookup_commit_graft(item->object.sha1);
 	while (bufptr + 48 < tail && !memcmp(bufptr, "parent ", 7)) {
diff --git a/git.c b/git.c
index 6bae305..5b77f49 100644
--- a/git.c
+++ b/git.c
@@ -363,6 +363,7 @@ static void handle_internal_command(int argc, const char **argv)
 		{ "repo-config", cmd_config },
 		{ "rerere", cmd_rerere, RUN_SETUP },
 		{ "reset", cmd_reset, RUN_SETUP },
+		{ "rev-cache", cmd_rev_cache, RUN_SETUP },
 		{ "rev-list", cmd_rev_list, RUN_SETUP },
 		{ "rev-parse", cmd_rev_parse },
 		{ "revert", cmd_revert, RUN_SETUP | NEED_WORK_TREE },
diff --git a/rev-cache.c b/rev-cache.c
new file mode 100644
index 0000000..aa98585
--- /dev/null
+++ b/rev-cache.c
@@ -0,0 +1,1273 @@
+#include "cache.h"
+#include "object.h"
+#include "commit.h"
+#include "tree.h"
+#include "tree-walk.h"
+#include "blob.h"
+#include "tag.h"
+#include "diff.h"
+#include "revision.h"
+#include "rev-cache.h"
+#include "run-command.h"
+
+/* list resembles pack index format */
+static uint32_t fanout[0xff + 2];
+
+static unsigned char *idx_map;
+static int idx_size;
+static struct rc_index_header idx_head;
+static unsigned char *idx_caches;
+static char no_idx;
+
+static struct strbuf *acc_buffer;
+
+#define SLOP			5
+
+#define INDEX_ENTRY_SIZE		(\
+	20 +						\
+	1 +							\
+	4							\
+)
+
+#define OBJECT_ENTRY_SIZE	(\
+	1 +						\
+	20 +					\
+	1 +						\
+	1 +						\
+	1 +						\
+	4 +						\
+	2						\
+)
+
+#define SLICE_HEADER_SIZE		(\
+	8 +							\
+	1 +							\
+	4 +							\
+	4 +							\
+	2 +							\
+	4 +							\
+	20							\
+)
+
+#define INDEX_HEADER_SIZE		(\
+	8 +							\
+	1 +							\
+	4 +							\
+	4 +							\
+	1 +							\
+	4							\
+)
+
+/* initialization */
+
+#define UNPACK_UINT32(p)		((uint32_t)*(p) << 24 | (uint32_t)*((p) + 1) << 16 | \
+									(uint32_t)*((p) + 2) << 8 | (uint32_t)*((p) + 3))
+
+#define PACK_UINT32(p, n)		do {		\
+	*(p) = (unsigned char)((n) >> 24);			\
+	*((p) + 1) = (unsigned char)((n) >> 16);	\
+	*((p) + 2) = (unsigned char)((n) >> 8);		\
+	*((p) + 3) = (unsigned char)(n);			\
+} while (0)
+
+#define UNPACK_UINT16(p)		((uint16_t)*(p) << 8 | (uint16_t)*((p) + 1))
+
+#define PACK_UINT16(p, n)		do {		\
+	*(p) = (unsigned char)((n) >> 8);			\
+	*((p) + 1) = (unsigned char)(n);			\
+} while (0)
+
+struct rc_index_entry *from_disked_rc_index_entry(unsigned char *src, struct rc_index_entry *dst)
+{
+	static struct rc_index_entry entry[4];
+	static int cur;
+
+	if (!dst)
+		dst = &entry[cur++ & 0x3];
+
+	dst->sha1 = (unsigned char *)src;
+	dst->is_start = !!(src[20] & 0x80);
+	dst->cache_index = src[20] & 0x7f;
+	dst->pos = UNPACK_UINT32(src + 21);
+
+	return dst;
+}
+
+unsigned char *to_disked_rc_index_entry(struct rc_index_entry *src, unsigned char **dstp)
+{
+	static unsigned char entry[4][INDEX_ENTRY_SIZE];
+	static int cur;
+	unsigned char *dst = *dstp;
+
+	if (!dstp || !*dstp) {
+		dst = entry[cur++ & 0x3];
+
+		if (dstp)
+			*dstp = dst;
+	} else
+		dst = *dstp;
+
+	if (dst != src->sha1)
+		hashcpy(dst, src->sha1);
+	dst[20] = (unsigned char)src->is_start << 7 | (unsigned char)src->cache_index;
+	PACK_UINT32(dst + 21, src->pos);
+
+	return dst;
+}
+
+struct rc_object_entry *from_disked_rc_object_entry(unsigned char *src, struct rc_object_entry *dst)
+{
+	static struct rc_object_entry entry[4];
+	static int cur;
+
+	if (!dst)
+		dst = &entry[cur++ & 0x3];
+
+	dst->type = *src >> 5;
+	dst->is_end = !!(*src & 0x10);
+	dst->is_start = !!(*src & 0x08);
+	dst->flag = *src & 0x07;
+
+	dst->sha1 = (unsigned char *)(src + 1);
+	dst->merge_nr = *(src + 21);
+	dst->split_nr = *(src + 22);
+
+	dst->size_size = *(src + 23) >> 5;
+	dst->padding = *(src + 23) & 0x1f;
+
+	dst->date = UNPACK_UINT32(src + 24);
+	dst->path = UNPACK_UINT16(src + 28);
+
+	return dst;
+}
+
+unsigned char *to_disked_rc_object_entry(struct rc_object_entry *src, unsigned char **dstp)
+{
+	static unsigned char entry[4][OBJECT_ENTRY_SIZE];
+	static int cur;
+	unsigned char *dst;
+
+	if (!dstp || !*dstp) {
+		dst = entry[cur++ & 0x3];
+
+		if (dstp)
+			*dstp = dst;
+	} else
+		dst = *dstp;
+
+	*dst  = (unsigned char)src->type << 5;
+	*dst |= (unsigned char)src->is_end << 4;
+	*dst |= (unsigned char)src->is_start << 3;
+	*dst |= (unsigned char)src->flag;
+
+	if (dst + 1 != src->sha1)
+		hashcpy(dst + 1, src->sha1);
+	*(dst + 21) = src->merge_nr;
+	*(dst + 22) = src->split_nr;
+
+	*(dst + 23)  = (unsigned char)src->size_size << 5;
+	*(dst + 23) |= (unsigned char)src->padding;
+
+	PACK_UINT32(dst + 24, src->date);
+	PACK_UINT16(dst + 28, src->path);
+
+	return dst;
+}
+
+static int get_index_head(unsigned char *map, int len, struct rc_index_header *head, uint32_t *fanout, unsigned char **caches)
+{
+	int i, index = INDEX_HEADER_SIZE;
+
+	if (memcmp(map, "REVINDEX", 8) || *(map + 8) != SUPPORTED_REVINDEX_VERSION)
+		return -1;
+
+	memcpy(head->signature, "REVINDEX", 8);
+	head->version = *(map + 8);
+	head->ofs_objects = UNPACK_UINT32(map + 9);
+	head->object_nr = UNPACK_UINT32(map + 13);
+	head->cache_nr = *(map + 17);
+	head->max_date = UNPACK_UINT32(map + 18);
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
+	if (fi.st_size < INDEX_HEADER_SIZE)
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
+static unsigned char *search_index_1(unsigned char *sha1)
+{
+	int start, end, starti, endi, i, len, r;
+	unsigned char *iep;
+
+	if (!idx_map)
+		return 0;
+
+	/* binary search */
+	start = fanout[(int)sha1[0]];
+	end = fanout[(int)sha1[0] + 1];
+	len = (end - start) / INDEX_ENTRY_SIZE;
+	if (!len || len * INDEX_ENTRY_SIZE != end - start)
+		return 0;
+
+	starti = 0;
+	endi = len - 1;
+	for (;;) {
+		i = (endi + starti) / 2;
+		iep = idx_map + start + i * INDEX_ENTRY_SIZE;
+		r = hashcmp(sha1, iep);
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
+			return iep;
+	}
+
+	return 0;
+}
+
+static struct rc_index_entry *search_index(unsigned char *sha1)
+{
+	unsigned char *ied = search_index_1(sha1);
+
+	if (ied)
+		return from_disked_rc_index_entry(ied, 0);
+
+	return 0;
+}
+
+unsigned char *get_cache_slice(struct commit *commit)
+{
+	struct rc_index_entry *ie;
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
+	if (ie && ie->cache_index < idx_head.cache_nr)
+		return idx_caches + ie->cache_index * 20;
+
+	return 0;
+}
+
+
+/* traversal */
+
+struct entrance_point {
+	int pos;
+	char uninteresting;
+};
+
+static int eps_sort_callback(const void *a, const void *b)
+{
+	struct entrance_point *aep, *bep;
+
+	aep = (struct entrance_point *)a;
+	bep = (struct entrance_point *)b;
+
+	if (aep->pos == bep->pos)
+		return 0;
+
+	return aep->pos > bep->pos ? 1 : -1;
+}
+
+static int setup_traversal(struct rc_slice_header *head, struct entrance_point **peps, int *peplen,
+	struct commit *commit, struct commit_list **work)
+{
+	struct rc_index_entry *iep;
+	struct commit_list *prev, *wp, **wpp;
+	struct entrance_point *eps;
+	int retval, curep = 1, eplen = 10;
+
+	eps = xcalloc(1, eplen * sizeof(struct entrance_point));
+	iep = search_index(commit->object.sha1);
+
+	/* the .uniniteresting bit isn't strictly necessary, as we check the object during traversal as well,
+	 * but we might as well initialize it while we're at it */
+	eps[0].pos = iep->pos;
+	eps[0].uninteresting = !!(commit->object.flags & UNINTERESTING);
+	retval = iep->pos;
+
+	/* include any others in the work array */
+	prev = 0;
+	wpp = work;
+	wp = *work;
+	while (wp) {
+		struct object *obj = &wp->item->object;
+		struct commit *co;
+
+		/* is this in our cache slice? */
+		iep = search_index(obj->sha1);
+		if (!iep || hashcmp(idx_caches + iep->cache_index * 20, head->sha1)) {
+			prev = wp;
+			wp = wp->next;
+			wpp = &wp;
+			continue;
+		}
+
+		if (iep->pos < retval)
+			retval = iep->pos;
+
+		/* mark this for later */
+		if (curep == eplen) {
+			eplen += 10;
+			eps = xrealloc(eps, eplen * sizeof(struct entrance_point));
+		}
+
+		eps[curep].pos = iep->pos;
+		eps[curep].uninteresting = !!(obj->flags & UNINTERESTING);
+		curep++;
+
+		/* remove from work list */
+		co = pop_commit(wpp);
+		wp = *wpp;
+		if (prev)
+			prev->next = wp;
+	}
+
+	qsort(eps, curep, sizeof(struct entrance_point), eps_sort_callback);
+	*peps = eps;
+	*peplen = curep;
+	return retval;
+}
+
+#define IPATH				0x40
+#define UPATH				0x80
+
+#define GET_COUNT(x)		((x) & 0x3f)
+#define SET_COUNT(x, s)		((x) = ((x) & ~0x3f) | ((s) & 0x3f))
+
+static int traverse_cache_slice_1(struct rc_slice_header *head, unsigned char *map,
+	struct rev_info *revs, struct commit *commit,
+	unsigned long *date_so_far, int *slop_so_far,
+	struct commit_list ***queue, struct commit_list **work)
+{
+	struct commit_list *insert_cache = 0;
+	struct commit **last_objects, *co;
+	int i, total_path_nr = head->path_nr, retval = -1;
+	char consume_children = 0;
+	unsigned char *paths;
+	struct entrance_point *eps;
+	int eplen, curep = 0;
+
+	i = setup_traversal(head, &eps, &eplen, commit, work);
+	if (i < 0)
+		return -1;
+
+	paths = xcalloc(total_path_nr, sizeof(uint16_t));
+	last_objects = xcalloc(total_path_nr, sizeof(struct commit *));
+
+	/* i already set */
+	while (i < head->size) {
+		struct rc_object_entry *entry = RC_OBTAIN_OBJECT_ENTRY(map + i);
+		int path = entry->path;
+		struct object *obj;
+		int index = i;
+		char uninteresting;
+
+		i += RC_ACTUAL_OBJECT_ENTRY_SIZE(entry);
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
+		if (curep < eplen && index == eps[curep].pos)
+			paths[path] |= eps[curep++].uninteresting ? UPATH : IPATH;
+		else if (!paths[path])
+			continue;
+
+		/* date stuff */
+		if (revs->max_age != -1 && entry->date < revs->max_age)
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
+		uninteresting = !!(paths[path] & UPATH);
+
+		/* first close paths */
+		if (entry->split_nr) {
+			int j, off = index + OBJECT_ENTRY_SIZE + RC_PATH_SIZE(entry->merge_nr);
+
+			for (j = 0; j < entry->split_nr; j++) {
+				unsigned short p = ntohs(*(uint16_t *)(map + off + RC_PATH_SIZE(j)));
+
+				if (p >= total_path_nr)
+					goto end;
+
+				/* boundary commit? */
+				if ((paths[p] & IPATH) && uninteresting) {
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
+			co->date = entry->date;
+			obj->flags |= ADDED | FACE_VALUE;
+		} else
+			parse_commit(co);
+
+		obj->flags |= SEEN;
+
+		if (uninteresting)
+			obj->flags |= UNINTERESTING;
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
+			int j, off = index + OBJECT_ENTRY_SIZE;
+			char flag = uninteresting ? UPATH : IPATH;
+
+			for (j = 0; j < entry->merge_nr; j++) {
+				unsigned short p = ntohs(*(uint16_t *)(map + off + RC_PATH_SIZE(j)));
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
+	free(eps);
+
+	return retval;
+}
+
+static int get_cache_slice_header(unsigned char *cache_sha1, unsigned char *map, int len, struct rc_slice_header *head)
+{
+	int t;
+
+	memcpy(head->signature, map, 8);
+	head->version = *(map + 8);
+	head->ofs_objects = UNPACK_UINT32(map + 9);
+
+	head->object_nr = UNPACK_UINT32(map + 13);
+	head->path_nr = UNPACK_UINT16(map + 17);
+	head->size = UNPACK_UINT32(map + 19);
+
+	hashcpy(head->sha1, map + 23);
+
+	if (memcmp(head->signature, "REVCACHE", 8))
+		return -1;
+	if (head->version != SUPPORTED_REVCACHE_VERSION)
+		return -2;
+	if (hashcmp(head->sha1, cache_sha1))
+		return -3;
+	t = SLICE_HEADER_SIZE;
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
+	struct rc_slice_header head;
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
+	memset(&head, 0, sizeof(struct rc_slice_header));
+
+	fd = open(git_path("rev-cache/%s", sha1_to_hex(cache_sha1)), O_RDONLY);
+	if (fd == -1)
+		goto end;
+	if (fstat(fd, &fi) || fi.st_size < SLICE_HEADER_SIZE)
+		goto end;
+
+	map = xmmap(0, fi.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
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
+	int path; /* for keeping track of children */
+
+	struct path_track *next, *prev;
+};
+
+static unsigned char *paths;
+static int path_nr = 1, path_sz;
+
+static struct path_track *path_track;
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
+static void add_path_to_track(struct commit *commit, int path)
+{
+	make_path_track(&path_track, commit);
+	path_track->path = path;
+}
+
+static void handle_paths(struct commit *commit, struct rc_object_entry *object, struct strbuf *merge_str, struct strbuf *split_str)
+{
+	int child_nr, parent_nr, open_parent_nr, this_path;
+	struct commit_list *list;
+	struct commit *first_parent;
+	struct path_track **ppt, *pt;
+
+	/* we can only re-use a closed path once all it's children have been encountered,
+	 * as we need to keep track of commit boundaries */
+	ppt = &path_track;
+	pt = *ppt;
+	child_nr = 0;
+	while (pt) {
+		if (pt->commit == commit) {
+			uint16_t write_path;
+
+			if (paths[pt->path] != PATH_IN_USE)
+				paths[pt->path]--;
+
+			/* make sure we can handle this */
+			child_nr++;
+			if (child_nr > 0x7f)
+				die("%s: too many branches!  rev-cache can only handle %d parents/children per commit",
+					sha1_to_hex(object->sha1), 0x7f);
+
+			/* add to split list */
+			object->split_nr++;
+			write_path = htons((uint16_t)pt->path);
+			strbuf_add(split_str, &write_path, sizeof(uint16_t));
+
+			remove_path_track(ppt, 0);
+			pt = *ppt;
+		} else {
+			pt = pt->next;
+			ppt = &pt;
+		}
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
+	object->path = this_path;
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
+	/* bail out on obscene parent/child #s */
+	if (parent_nr > 0x7f)
+		die("%s: too many parents in merge!  rev-cache can only handle %d parents/children per commit",
+			sha1_to_hex(object->sha1), 0x7f);
+
+	/* make merge list */
+	object->merge_nr = parent_nr;
+	paths[this_path] = parent_nr;
+
+	for (list = commit->parents; list; list = list->next) {
+		struct commit *p = list->item;
+		uint16_t write_path;
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
+		write_path = htons((uint16_t)p->indegree);
+		strbuf_add(merge_str, &write_path, sizeof(uint16_t));
+
+		/* make sure path is properly ended */
+		add_path_to_track(p, this_path);
+	}
+
+}
+
+
+static void add_object_entry(const unsigned char *sha1, int type, struct rc_object_entry *nothisone,
+	struct strbuf *merge_str, struct strbuf *split_str)
+{
+	struct rc_object_entry object;
+
+	if (!nothisone) {
+		memset(&object, 0, sizeof(object));
+		object.sha1 = (unsigned char *)sha1;
+		object.type = type;
+
+		if (merge_str)
+			object.merge_nr = merge_str->len / sizeof(uint16_t);
+		if (split_str)
+			object.split_nr = split_str->len / sizeof(uint16_t);
+
+		nothisone = &object;
+	}
+
+	strbuf_add(acc_buffer, to_disked_rc_object_entry(nothisone, 0), OBJECT_ENTRY_SIZE);
+
+	if (merge_str && merge_str->len)
+		strbuf_add(acc_buffer, merge_str->buf, merge_str->len);
+	if (split_str && split_str->len)
+		strbuf_add(acc_buffer, split_str->buf, split_str->len);
+
+}
+
+static void init_revcache_directory(void)
+{
+	struct stat fi;
+
+	if (stat(git_path("rev-cache"), &fi) || !S_ISDIR(fi.st_mode))
+		if (mkdir(git_path("rev-cache"), 0777))
+			die("can't make rev-cache directory");
+
+}
+
+void init_rev_cache_info(struct rev_cache_info *rci)
+{
+	rci->objects = 1;
+	rci->legs = 0;
+	rci->make_index = 1;
+
+	rci->add_to_pending = 1;
+
+	rci->ignore_size = 0;
+}
+
+void maybe_fill_with_defaults(struct rev_cache_info *rci)
+{
+	static struct rev_cache_info def_rci;
+
+	if (rci)
+		return;
+
+	init_rev_cache_info(&def_rci);
+	rci = &def_rci;
+}
+
+int make_cache_slice(struct rev_cache_info *rci,
+	struct rev_info *revs, struct commit_list **starts, struct commit_list **ends,
+	unsigned char *cache_sha1)
+{
+	struct rev_info therevs;
+	struct strbuf buffer, startlist, endlist;
+	struct rc_slice_header head;
+	struct commit *commit;
+	unsigned char sha1[20], whead[SLICE_HEADER_SIZE];
+	struct strbuf merge_paths, split_paths;
+	int object_nr, total_sz, fd;
+	char file[PATH_MAX], *newfile;
+	struct rev_cache_info *trci;
+	git_SHA_CTX ctx;
+
+	maybe_fill_with_defaults(rci);
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
+	acc_buffer = &buffer;
+
+	if (!revs) {
+		revs = &therevs;
+		init_revisions(revs, 0);
+
+		/* we're gonna assume no one else has already traversed this... */
+		while ((commit = pop_commit(starts)))
+			add_pending_object(revs, &commit->object, 0);
+
+		while ((commit = pop_commit(ends))) {
+			commit->object.flags |= UNINTERESTING;
+			add_pending_object(revs, &commit->object, 0);
+		}
+	}
+
+	/* write head placeholder */
+	memset(&head, 0, sizeof(head));
+	memset(&whead, 0, SLICE_HEADER_SIZE);
+	head.ofs_objects = SLICE_HEADER_SIZE;
+	xwrite(fd, &whead, SLICE_HEADER_SIZE);
+
+	/* init revisions! */
+	revs->tree_objects = 1;
+	revs->blob_objects = 1;
+	revs->topo_order = 1;
+	revs->lifo = 1;
+
+	/* re-use info from other caches if possible */
+	trci = &revs->rev_cache_info;
+	init_rev_cache_info(trci);
+	trci->add_to_pending = 0;
+
+	setup_revisions(0, 0, revs, 0);
+	if (prepare_revision_walk(revs))
+		die("died preparing revision walk");
+
+	object_nr = total_sz = 0;
+	while ((commit = get_revision(revs)) != 0) {
+		struct rc_object_entry object;
+
+		strbuf_setlen(&merge_paths, 0);
+		strbuf_setlen(&split_paths, 0);
+
+		memset(&object, 0, sizeof(object));
+		object.type = OBJ_COMMIT;
+		object.date = commit->date;
+		object.sha1 = commit->object.sha1;
+
+		handle_paths(commit, &object, &merge_paths, &split_paths);
+
+		if (object.is_end) {
+			strbuf_add(&endlist, object.sha1, 20);
+			if (ends)
+				commit_list_insert(commit, ends);
+		}
+		/* the two *aren't* mutually exclusive */
+		if (object.is_start) {
+			strbuf_add(&startlist, object.sha1, 20);
+			if (starts)
+				commit_list_insert(commit, starts);
+		}
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
+	/* initialize header */
+	strcpy(head.signature, "REVCACHE");
+	head.version = SUPPORTED_REVCACHE_VERSION;
+
+	head.object_nr = object_nr;
+	head.size = head.ofs_objects + total_sz;
+	head.path_nr = path_nr;
+	hashcpy(head.sha1, sha1);
+
+	/* ...and whead */
+	memcpy(whead, "REVCACHE", 8);
+	*(whead + 8) = head.version;
+	PACK_UINT32(whead + 9, head.ofs_objects);
+
+	PACK_UINT32(whead + 13, head.object_nr);
+	PACK_UINT16(whead + 17, head.path_nr);
+
+	PACK_UINT32(whead + 19, head.size);
+	hashcpy(whead + 23, head.sha1);
+
+	/* some info! */
+	fprintf(stderr, "objects: %d\n", object_nr);
+	fprintf(stderr, "paths: %d\n", path_nr);
+
+	lseek(fd, 0, SEEK_SET);
+	xwrite(fd, &whead, SLICE_HEADER_SIZE);
+
+	if (rci->make_index && make_cache_index(rci, sha1, fd, head.size) < 0)
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
+	return hashcmp(((struct rc_index_entry_ondisk *)a)->sha1, ((struct rc_index_entry_ondisk *)b)->sha1);
+}
+
+static int write_cache_index(struct strbuf *body)
+{
+	unsigned char whead[INDEX_HEADER_SIZE];
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
+	memcpy(whead, "REVINDEX", 8);
+	*(whead + 8) = idx_head.version;
+	PACK_UINT32(whead + 9, idx_head.ofs_objects);
+	PACK_UINT32(whead + 13, idx_head.object_nr);
+	*(whead + 17) = idx_head.cache_nr;
+	PACK_UINT32(whead + 18, idx_head.max_date);
+
+	write(fd, &whead, INDEX_HEADER_SIZE);
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
+	map = xmmap(0, size, PROT_READ, MAP_PRIVATE, fd, 0);
+	if (map == MAP_FAILED)
+		return -1;
+
+	strbuf_init(&buffer, 0);
+	if (idx_map) {
+		strbuf_add(&buffer, idx_map + fanout[0], fanout[0x100] - fanout[0]);
+	} else {
+		/* not an update */
+		memset(&idx_head, 0, sizeof(struct rc_index_header));
+		idx_caches = 0;
+
+		strcpy(idx_head.signature, "REVINDEX");
+		idx_head.version = SUPPORTED_REVINDEX_VERSION;
+		idx_head.ofs_objects = INDEX_HEADER_SIZE + 0x100 * sizeof(uint32_t);
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
+		fprintf(stderr, "bla: %d\n", idx_head.cache_nr * 20);
+		idx_caches = xrealloc(idx_caches, idx_head.cache_nr * 20);
+		hashcpy(idx_caches + cache_index * 20, cache_sha1);
+	} else
+		cache_index = i;
+
+	i = SLICE_HEADER_SIZE; /* offset */
+	max_date = idx_head.max_date;
+	while (i < size) {
+		struct rc_index_entry index_entry, *entry;
+		unsigned char *disked_entry;
+		struct rc_object_entry *object_entry = RC_OBTAIN_OBJECT_ENTRY(map + i);
+		unsigned long date;
+		int off, pos = i;
+
+		i += RC_ACTUAL_OBJECT_ENTRY_SIZE(object_entry);
+
+		if (object_entry->type != OBJ_COMMIT)
+			continue;
+
+		/* don't include ends; otherwise we'll find ourselves in loops */
+		if (object_entry->is_end)
+			continue;
+
+		/* handle index duplication
+		 * -> keep old copy unless new one is a start -- based on expected usage, older ones will be more
+		 * likely to lead to greater slice traversals than new ones */
+		date = object_entry->date;
+		if (date > idx_head.max_date) {
+			disked_entry = 0;
+			if (date > max_date)
+				max_date = date;
+		} else
+			disked_entry = search_index_1(object_entry->sha1);
+
+		if (disked_entry && !object_entry->is_start)
+			continue;
+		else if (disked_entry) {
+			/* mmm, pointer arithmetic... tasty */  /* (entry - idx_map = offset, so cast is valid) */
+			off = (unsigned int)((unsigned char *)disked_entry - idx_map) - fanout[0];
+			disked_entry = (unsigned char *)(buffer.buf + off);
+			entry = from_disked_rc_index_entry(disked_entry, 0);
+		} else
+			entry = &index_entry;
+
+		memset(entry, 0, sizeof(index_entry));
+		entry->sha1 = object_entry->sha1;
+		entry->is_start = object_entry->is_start;
+		entry->cache_index = cache_index;
+		entry->pos = pos;
+
+		if (entry == &index_entry) {
+			strbuf_add(&buffer, to_disked_rc_index_entry(entry, 0), INDEX_ENTRY_SIZE);
+			idx_head.object_nr++;
+		} else
+			to_disked_rc_index_entry(entry, &disked_entry);
+
+	}
+
+	idx_head.max_date = max_date;
+	qsort(buffer.buf, buffer.len / INDEX_ENTRY_SIZE, INDEX_ENTRY_SIZE, index_sort_hash);
+
+	/* generate fanout */
+	cur = 0x00;
+	for (i = 0; i < buffer.len; i += INDEX_ENTRY_SIZE) {
+		struct rc_index_entry_ondisk *entry = (struct rc_index_entry_ondisk *)(buffer.buf + i);
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
+	for (i = idx_head.ofs_objects; i < idx_size; i += INDEX_ENTRY_SIZE) {
+		struct rc_index_entry *entry = RC_OBTAIN_INDEX_ENTRY(idx_map + i);
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
diff --git a/rev-cache.h b/rev-cache.h
new file mode 100644
index 0000000..76f4fb4
--- /dev/null
+++ b/rev-cache.h
@@ -0,0 +1,105 @@
+#ifndef REV_CACHE_H
+#define REV_CACHE_H
+
+#define SUPPORTED_REVCACHE_VERSION 		1
+#define SUPPORTED_REVINDEX_VERSION		1
+
+#define RC_PATH_SIZE(x)	(2 * (x))
+
+#define RC_OBTAIN_OBJECT_ENTRY(p)			from_disked_rc_object_entry((unsigned char *)(p), 0)
+#define RC_OBTAIN_INDEX_ENTRY(p)			from_disked_rc_index_entry((unsigned char *)(p), 0)
+
+#define RC_ACTUAL_OBJECT_ENTRY_SIZE(e)		(OBJECT_ENTRY_SIZE + RC_PATH_SIZE((e)->merge_nr + (e)->split_nr) + (e)->size_size)
+
+/* single index maps objects to cache files */
+struct rc_index_header {
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
+struct rc_index_entry_ondisk {
+	unsigned char sha1[20];
+	unsigned char flags;
+	uint32_t pos;
+};
+
+struct rc_index_entry {
+	unsigned char *sha1;
+	unsigned is_start:1;
+	unsigned cache_index:7;
+	uint32_t pos;
+};
+
+
+/* structure for actual cache file */
+struct rc_slice_header {
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
+struct rc_object_entry_ondisk {
+	unsigned char flags;
+	unsigned char sha1[20];
+
+	unsigned char merge_nr;
+	unsigned char split_nr;
+	unsigned char sizes;
+
+	uint32_t date;
+	uint16_t path;
+};
+
+struct rc_object_entry {
+	unsigned type:3;
+	unsigned is_end:1;
+	unsigned is_start:1;
+	unsigned flag:3; /* unused */
+	unsigned char *sha1; /* 20 byte */
+
+	unsigned char merge_nr; /* : 7 */
+	unsigned char split_nr; /* : 7 */
+	unsigned size_size:3;
+	unsigned padding:5;
+
+	uint32_t date;
+	uint16_t path;
+
+	/* merge paths */
+	/* split paths */
+	/* size */
+};
+
+struct rc_index_entry *from_disked_rc_index_entry(unsigned char *src, struct rc_index_entry *dst);
+unsigned char *to_disked_rc_index_entry(struct rc_index_entry *src, unsigned char **dst);
+struct rc_object_entry *from_disked_rc_object_entry(unsigned char *src, struct rc_object_entry *dst);
+unsigned char *to_disked_rc_object_entry(struct rc_object_entry *src, unsigned char **dst);
+
+extern unsigned char *get_cache_slice(struct commit *commit);
+extern int traverse_cache_slice(struct rev_info *revs,
+	unsigned char *cache_sha1, struct commit *commit,
+	unsigned long *date_so_far, int *slop_so_far,
+	struct commit_list ***queue, struct commit_list **work);
+
+extern void init_rev_cache_info(struct rev_cache_info *rci);
+extern int make_cache_slice(struct rev_cache_info *rci,
+	struct rev_info *revs, struct commit_list **starts, struct commit_list **ends,
+	unsigned char *cache_sha1);
+extern int make_cache_index(struct rev_cache_info *rci, unsigned char *cache_sha1,
+	int fd, unsigned int size);
+
+extern void starts_from_slices(struct rev_info *revs, unsigned int flags);
+
+#endif
diff --git a/revision.c b/revision.c
index f4b8b38..cd3dba8 100644
--- a/revision.c
+++ b/revision.c
@@ -444,7 +444,7 @@ static void try_to_simplify_commit(struct rev_info *revs, struct commit *commit)
 	commit->object.flags |= TREESAME;
 }
 
-static void insert_by_date_cached(struct commit *p, struct commit_list **head,
+void insert_by_date_cached(struct commit *p, struct commit_list **head,
 		    struct commit_list *cached_base, struct commit_list **cache)
 {
 	struct commit_list *new_entry;
diff --git a/revision.h b/revision.h
index 568f1c9..0662c8c 100644
--- a/revision.h
+++ b/revision.h
@@ -14,7 +14,8 @@
 #define CHILD_SHOWN	(1u<<6)
 #define ADDED		(1u<<7)	/* Parents already parsed and added? */
 #define SYMMETRIC_LEFT	(1u<<8)
-#define ALL_REV_FLAGS	((1u<<9)-1)
+#define FACE_VALUE	(1u<<9)
+#define ALL_REV_FLAGS	((1u<<10)-1)
 
 #define DECORATE_SHORT_REFS	1
 #define DECORATE_FULL_REFS	2
@@ -23,6 +24,19 @@ struct rev_info;
 struct log_info;
 struct string_list;
 
+struct rev_cache_info {
+	/* generation flags */
+	unsigned objects : 1,
+		legs : 1,
+		make_index : 1;
+
+	/* traversal flags */
+	unsigned add_to_pending : 1;
+
+	/* fuse options */
+	unsigned int ignore_size;
+};
+
 struct rev_info {
 	/* Starting list */
 	struct commit_list *commits;
@@ -79,6 +93,10 @@ struct rev_info {
 			dense_combined_merges:1,
 			always_show_header:1;
 
+	/* rev-cache flags */
+	unsigned int for_pack:1,
+		dont_cache_me:1;
+
 	/* Format info */
 	unsigned int	shown_one:1,
 			show_merge:1,
@@ -131,6 +149,9 @@ struct rev_info {
 
 	/* notes-specific options: which refs to show */
 	struct display_notes_opt notes_opt;
+	
+	/* caching info, used ONLY by traverse_cache_slice */
+	struct rev_cache_info rev_cache_info;
 };
 
 #define REV_TREE_SAME		0
@@ -186,4 +207,7 @@ enum commit_action {
 extern enum commit_action get_commit_action(struct rev_info *revs, struct commit *commit);
 extern enum commit_action simplify_commit(struct rev_info *revs, struct commit *commit);
 
+extern void insert_by_date_cached(struct commit *p, struct commit_list **head,
+		    struct commit_list *cached_base, struct commit_list **cache);
+
 #endif
diff --git a/t/t6019-rev-cache-list.sh b/t/t6019-rev-cache-list.sh
new file mode 100644
index 0000000..8017e62
--- /dev/null
+++ b/t/t6019-rev-cache-list.sh
@@ -0,0 +1,106 @@
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
+git rev-list HEAD --not HEAD~3 >proper_commit_list_limited
+git rev-list HEAD >proper_commit_list
+git rev-list HEAD --objects >proper_object_list
+
+test_expect_success 'make cache slice' '
+	git rev-cache add HEAD 2>output.err &&
+	grep "final return value: 0" output.err
+'
+
+test_expect_success 'remake cache slice' '
+	git rev-cache add HEAD 2>output.err &&
+	grep "final return value: 0" output.err
+'
+
+#check core mechanics and rev-list hook for commits
+test_expect_success 'test rev-caches walker directly (limited)' '
+	git rev-cache walk HEAD --not HEAD~3 >list &&
+	test_cmp_sorted list proper_commit_list_limited
+'
+
+test_expect_success 'test rev-caches walker directly (unlimited)' '
+	git rev-cache walk HEAD >list &&
+	test_cmp_sorted list proper_commit_list
+'
+
+test_done
+
-- 
tg: (bac39ea..) t/rc/basic (depends on: t/rc/docs)
