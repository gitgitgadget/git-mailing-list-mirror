From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [RFC][PATCH 09/10] Sparse: fix some "symbol 's' shadows an earlier
 one" warnings
Date: Fri, 08 Jun 2007 23:25:48 +0100
Message-ID: <4669D76C.6060801@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Jun 09 01:39:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hwo3I-0007D2-T6
	for gcvg-git@gmane.org; Sat, 09 Jun 2007 01:39:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754636AbXFHXjb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jun 2007 19:39:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754585AbXFHXjb
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jun 2007 19:39:31 -0400
Received: from anchor-fallback-96.mail.demon.net ([194.217.242.83]:41022 "EHLO
	anchor-fallback-96.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754414AbXFHXja (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Jun 2007 19:39:30 -0400
X-Greylist: delayed 4179 seconds by postgrey-1.27 at vger.kernel.org; Fri, 08 Jun 2007 19:39:29 EDT
Received: from anchor-post-30.mail.demon.net ([194.217.242.88]:1566 "EHLO
	anchor-post-30.mail.demon.net") by anchor-fallback-96.mail.demon.net
	with ESMTP id S799638AbXFHWco (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jun 2007 22:32:44 +0000
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-30.mail.demon.net with esmtp (Exim 4.42)
	id 1HwmyA-0005pO-1L; Fri, 08 Jun 2007 22:30:13 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49521>


Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 builtin-apply.c         |   18 +++++++++---------
 builtin-blame.c         |    3 ++-
 builtin-diff.c          |    1 -
 builtin-fetch--tool.c   |    3 +--
 builtin-fmt-merge-msg.c |    2 +-
 builtin-for-each-ref.c  |   10 +++++-----
 builtin-fsck.c          |    7 +++----
 builtin-grep.c          |    6 +++---
 builtin-mailinfo.c      |   16 ++++++++--------
 builtin-pack-objects.c  |   10 +++++-----
 builtin-show-branch.c   |    8 +++++---
 combine-diff.c          |    2 +-
 config.c                |    4 ++--
 convert-objects.c       |   10 +++++-----
 daemon.c                |    1 -
 fetch-pack.c            |   16 ++++++++--------
 fetch.c                 |    6 +++---
 pack-check.c            |    9 ++++-----
 reflog-walk.c           |    6 +++---
 revision.c              |    4 ++--
 20 files changed, 70 insertions(+), 72 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index 0399743..5700d43 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -1393,7 +1393,7 @@ static const char minuses[]= "--------------------------------------------------
 
 static void show_stats(struct patch *patch)
 {
-	const char *prefix = "";
+	const char *intro = "";
 	char *name = patch->new_name;
 	char *qname = NULL;
 	int len, max, add, del, total;
@@ -1416,7 +1416,7 @@ static void show_stats(struct patch *patch)
 		max = 50;
 	if (len > max) {
 		char *slash;
-		prefix = "...";
+		intro = "...";
 		max -= 3;
 		name += len - max;
 		slash = strchr(name, '/');
@@ -1442,9 +1442,9 @@ static void show_stats(struct patch *patch)
 		del = total - add;
 	}
 	if (patch->is_binary)
-		printf(" %s%-*s |  Bin\n", prefix, len, name);
+		printf(" %s%-*s |  Bin\n", intro, len, name);
 	else
-		printf(" %s%-*s |%5d %.*s%.*s\n", prefix,
+		printf(" %s%-*s |%5d %.*s%.*s\n", intro,
 		       len, name, patch->lines_added + patch->lines_deleted,
 		       add, pluses, del, minuses);
 	free(qname);
@@ -1771,7 +1771,7 @@ static int apply_one_fragment(struct buffer_desc *desc, struct fragment *frag, i
 			offset = -1;
 		if (offset >= 0) {
 			int diff = newsize - oldsize;
-			unsigned long size = desc->size + diff;
+			unsigned long buf_size = desc->size + diff;
 			unsigned long alloc = desc->alloc;
 
 			/* Warn if it was necessary to reduce the number
@@ -1783,16 +1783,16 @@ static int apply_one_fragment(struct buffer_desc *desc, struct fragment *frag, i
 					" to apply fragment at %d\n",
 					leading, trailing, pos + lines);
 
-			if (size > alloc) {
-				alloc = size + 8192;
+			if (buf_size > alloc) {
+				alloc = buf_size + 8192;
 				desc->alloc = alloc;
 				buf = xrealloc(buf, alloc);
 				desc->buffer = buf;
 			}
-			desc->size = size;
+			desc->size = buf_size;
 			memmove(buf + offset + newsize,
 				buf + offset + oldsize,
-				size - offset - newsize);
+				buf_size - offset - newsize);
 			memcpy(buf + offset, newlines, newsize);
 			offset = 0;
 
diff --git a/builtin-blame.c b/builtin-blame.c
index 35471fc..d4d11a7 100644
--- a/builtin-blame.c
+++ b/builtin-blame.c
@@ -1185,7 +1185,7 @@ static void pass_blame(struct scoreboard *sb, struct origin *origin, int opt)
 	int i, pass;
 	struct commit *commit = origin->commit;
 	struct commit_list *parent;
-	struct origin *parent_origin[MAXPARENT], *porigin;
+	struct origin *parent_origin[MAXPARENT];
 
 	memset(parent_origin, 0, sizeof(parent_origin));
 
@@ -1201,6 +1201,7 @@ static void pass_blame(struct scoreboard *sb, struct origin *origin, int opt)
 		     i < MAXPARENT && parent;
 		     parent = parent->next, i++) {
 			struct commit *p = parent->item;
+			struct origin *porigin;
 			int j, same;
 
 			if (parent_origin[i])
diff --git a/builtin-diff.c b/builtin-diff.c
index e00a212..6a1c116 100644
--- a/builtin-diff.c
+++ b/builtin-diff.c
@@ -226,7 +226,6 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 	 * default to HEAD by hand.  Eek.
 	 */
 	if (!rev.pending.nr) {
-		int i;
 		for (i = 1; i < argc; i++) {
 			const char *arg = argv[i];
 			if (!strcmp(arg, "--"))
diff --git a/builtin-fetch--tool.c b/builtin-fetch--tool.c
index a1d51d0..3b2b952 100644
--- a/builtin-fetch--tool.c
+++ b/builtin-fetch--tool.c
@@ -289,7 +289,7 @@ static int fetch_native_store(FILE *fp,
 			continue;
 		if (!strcmp(buffer, "keep")) {
 			char *od = get_object_directory();
-			int len = strlen(od) + strlen(cp) + 50;
+			len = strlen(od) + strlen(cp) + 50;
 			keep = xmalloc(len);
 			sprintf(keep, "%s/pack/pack-%s.keep", od, cp);
 			continue;
@@ -476,7 +476,6 @@ static int pick_rref(int sha1_only, const char *rref, const char *ls_remote_resu
 	while (1) {
 		const char *next;
 		int rreflen;
-		int i;
 
 		while (*rref && isspace(*rref))
 			rref++;
diff --git a/builtin-fmt-merge-msg.c b/builtin-fmt-merge-msg.c
index 5c145d2..a8b9b5b 100644
--- a/builtin-fmt-merge-msg.c
+++ b/builtin-fmt-merge-msg.c
@@ -138,7 +138,7 @@ static int handle_line(char *line)
 	}
 
 	if (!strcmp(".", src) || !strcmp(src, origin)) {
-		int len = strlen(origin);
+		len = strlen(origin);
 		if (origin[0] == '\'' && origin[len - 1] == '\'') {
 			char *new_origin = xmalloc(len - 1);
 			memcpy(new_origin, origin + 1, len - 2);
diff --git a/builtin-for-each-ref.c b/builtin-for-each-ref.c
index 3ca77b5..b74e5f9 100644
--- a/builtin-for-each-ref.c
+++ b/builtin-for-each-ref.c
@@ -268,17 +268,17 @@ static void grab_commit_values(struct atom_value *val, int deref, struct object
 		}
 		else if (!strcmp(name, "parent")) {
 			int num = num_parents(commit);
-			int i;
+			int j;
 			struct commit_list *parents;
 			char *s = xmalloc(42 * num);
 			v->s = s;
-			for (i = 0, parents = commit->parents;
+			for (j = 0, parents = commit->parents;
 			     parents;
-			     parents = parents->next, i = i + 42) {
+			     parents = parents->next, j = j + 42) {
 				struct commit *parent = parents->item;
-				strcpy(s+i, sha1_to_hex(parent->object.sha1));
+				strcpy(s+j, sha1_to_hex(parent->object.sha1));
 				if (parents->next)
-					s[i+40] = ' ';
+					s[j+40] = ' ';
 			}
 		}
 	}
diff --git a/builtin-fsck.c b/builtin-fsck.c
index 776a435..2a3890e 100644
--- a/builtin-fsck.c
+++ b/builtin-fsck.c
@@ -669,9 +669,9 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 			verify_pack(p, 0);
 
 		for (p = packed_git; p; p = p->next) {
-			uint32_t i, num = p->num_objects;
-			for (i = 0; i < num; i++)
-				fsck_sha1(nth_packed_object_sha1(p, i));
+			uint32_t j, num = p->num_objects;
+			for (j = 0; j < num; j++)
+				fsck_sha1(nth_packed_object_sha1(p, j));
 		}
 	}
 
@@ -708,7 +708,6 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 	}
 
 	if (keep_cache_objects) {
-		int i;
 		read_cache();
 		for (i = 0; i < active_nr; i++) {
 			unsigned int mode;
diff --git a/builtin-grep.c b/builtin-grep.c
index e13cb31..84e346b 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -275,10 +275,10 @@ static int external_grep(struct grep_opt *opt, const char **paths, int cached)
 			continue;
 		name = ce->name;
 		if (name[0] == '-') {
-			int len = ce_namelen(ce);
-			name = xmalloc(len + 3);
+			int name_len = ce_namelen(ce);
+			name = xmalloc(name_len + 3);
 			memcpy(name, "./", 2);
-			memcpy(name + 2, ce->name, len + 1);
+			memcpy(name + 2, ce->name, name_len + 1);
 		}
 		argv[argc++] = name;
 		if (argc < MAXARGS && !ce_stage(ce))
diff --git a/builtin-mailinfo.c b/builtin-mailinfo.c
index c95e477..8df8984 100644
--- a/builtin-mailinfo.c
+++ b/builtin-mailinfo.c
@@ -70,14 +70,14 @@ static int bogus_from(char *line)
 
 static int handle_from(char *in_line)
 {
-	char line[1000];
+	char from_line[1000];
 	char *at;
 	char *dst;
 
-	strcpy(line, in_line);
-	at = strchr(line, '@');
+	strcpy(from_line, in_line);
+	at = strchr(from_line, '@');
 	if (!at)
-		return bogus_from(line);
+		return bogus_from(from_line);
 
 	/*
 	 * If we already have one email, don't take any confusing lines
@@ -88,7 +88,7 @@ static int handle_from(char *in_line)
 	/* Pick up the string around '@', possibly delimited with <>
 	 * pair; that is the email part.  White them out while copying.
 	 */
-	while (at > line) {
+	while (at > from_line) {
 		char c = at[-1];
 		if (isspace(c))
 			break;
@@ -116,8 +116,8 @@ static int handle_from(char *in_line)
 	 * email part, so trim from both ends, possibly removing
 	 * the () pair at the end.
 	 */
-	at = line + strlen(line);
-	while (at > line) {
+	at = from_line + strlen(from_line);
+	while (at > from_line) {
 		unsigned char c = *--at;
 		if (!isspace(c)) {
 			at[(c == ')') ? 0 : 1] = 0;
@@ -125,7 +125,7 @@ static int handle_from(char *in_line)
 		}
 	}
 
-	at = line;
+	at = from_line;
 	for (;;) {
 		unsigned char c = *at;
 		if (!c || !isspace(c)) {
diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 966f843..ccf583f 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -1004,17 +1004,17 @@ static void add_pbase_object(struct tree_desc *tree,
 		}
 		if (S_ISDIR(entry.mode)) {
 			struct tree_desc sub;
-			struct pbase_tree_cache *tree;
+			struct pbase_tree_cache *t;
 			const char *down = name+cmplen+1;
 			int downlen = name_cmp_len(down);
 
-			tree = pbase_tree_get(entry.sha1);
-			if (!tree)
+			t = pbase_tree_get(entry.sha1);
+			if (!t)
 				return;
-			init_tree_desc(&sub, tree->tree_data, tree->tree_size);
+			init_tree_desc(&sub, t->tree_data, t->tree_size);
 
 			add_pbase_object(&sub, down, downlen, fullname);
-			pbase_tree_put(tree);
+			pbase_tree_put(t);
 		}
 	}
 }
diff --git a/builtin-show-branch.c b/builtin-show-branch.c
index c892f1f..3ec3448 100644
--- a/builtin-show-branch.c
+++ b/builtin-show-branch.c
@@ -875,9 +875,11 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 	all_revs = all_mask & ~((1u << REV_SHIFT) - 1);
 
 	while (seen) {
-		struct commit *commit = pop_one_commit(&seen);
-		int this_flag = commit->object.flags;
-		int is_merge_point = ((this_flag & all_revs) == all_revs);
+		int this_flag, is_merge_point;
+
+		commit = pop_one_commit(&seen);
+		this_flag = commit->object.flags;
+		is_merge_point = ((this_flag & all_revs) == all_revs);
 
 		shown_merge_point |= is_merge_point;
 
diff --git a/combine-diff.c b/combine-diff.c
index ea3ca5f..63ea310 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -699,7 +699,7 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
 			 !fstat(fd, &st)) {
 			size_t len = xsize_t(st.st_size);
 			size_t sz = 0;
-			int is_file, i;
+			int is_file;
 
 			elem->mode = canon_mode(st.st_mode);
 			/* if symlinks don't work, assume symlink if all parents
diff --git a/config.c b/config.c
index 5754ec2..5e6a675 100644
--- a/config.c
+++ b/config.c
@@ -152,7 +152,7 @@ static int get_extended_base_var(char *name, int baselen, int c)
 	name[baselen++] = '.';
 
 	for (;;) {
-		int c = get_next_char();
+		c = get_next_char();
 		if (c == '\n')
 			return -1;
 		if (c == '"')
@@ -753,7 +753,7 @@ int git_config_set_multivar(const char* key, const char* value,
 		struct stat st;
 		char* contents;
 		size_t contents_sz, copy_begin, copy_end;
-		int i, new_line = 0;
+		int new_line = 0;
 
 		if (value_regex == NULL)
 			store.value_regex = NULL;
diff --git a/convert-objects.c b/convert-objects.c
index cefbceb..90aecc4 100644
--- a/convert-objects.c
+++ b/convert-objects.c
@@ -180,15 +180,15 @@ static unsigned long parse_oldstyle_date(const char *buf)
 				return mktime(&tm);
 			buf = next;
 		} else {
-			const char **p = timezones;
+			const char **t = timezones;
 			while (isspace(*buf))
 				buf++;
-			while (*p) {
-				if (!memcmp(buf, *p, strlen(*p))) {
-					buf += strlen(*p);
+			while (*t) {
+				if (!memcmp(buf, *t, strlen(*t))) {
+					buf += strlen(*t);
 					break;
 				}
-				p++;
+				t++;
 			}
 		}
 		fmt++;
diff --git a/daemon.c b/daemon.c
index 9daa850..c09ab5c 100644
--- a/daemon.c
+++ b/daemon.c
@@ -903,7 +903,6 @@ static int service_loop(int socknum, int *socklist)
 	signal(SIGCHLD, child_handler);
 
 	for (;;) {
-		int i;
 
 		if (poll(pfd, socknum, -1) < 0) {
 			if (errno != EINTR) {
diff --git a/fetch-pack.c b/fetch-pack.c
index 75649a6..fc1696e 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -147,7 +147,7 @@ static int find_common(int fd[2], unsigned char *result_sha1,
 {
 	int fetching;
 	int count = 0, flushes = 0, retval;
-	const unsigned char *sha1;
+	const unsigned char *rev;
 	unsigned in_vain = 0;
 	int got_continue = 0;
 
@@ -223,10 +223,10 @@ static int find_common(int fd[2], unsigned char *result_sha1,
 
 	flushes = 0;
 	retval = -1;
-	while ((sha1 = get_rev())) {
-		packet_write(fd[1], "have %s\n", sha1_to_hex(sha1));
+	while ((rev = get_rev())) {
+		packet_write(fd[1], "have %s\n", sha1_to_hex(rev));
 		if (verbose)
-			fprintf(stderr, "have %s\n", sha1_to_hex(sha1));
+			fprintf(stderr, "have %s\n", sha1_to_hex(rev));
 		in_vain++;
 		if (!(31 & ++count)) {
 			int ack;
@@ -759,7 +759,7 @@ int main(int argc, char **argv)
 	if (!ret && depth > 0) {
 		struct cache_time mtime;
 		char *shallow = git_path("shallow");
-		int fd;
+		int lock_fd;
 
 		mtime.sec = st.st_mtime;
 #ifdef USE_NSEC
@@ -775,12 +775,12 @@ int main(int argc, char **argv)
 			  )
 			die("shallow file was changed during fetch");
 
-		fd = hold_lock_file_for_update(&lock, shallow, 1);
-		if (!write_shallow_commits(fd, 0)) {
+		lock_fd = hold_lock_file_for_update(&lock, shallow, 1);
+		if (!write_shallow_commits(lock_fd, 0)) {
 			unlink(shallow);
 			rollback_lock_file(&lock);
 		} else {
-			close(fd);
+			close(lock_fd);
 			commit_lock_file(&lock);
 		}
 	}
diff --git a/fetch.c b/fetch.c
index 8e29d31..c2742f5 100644
--- a/fetch.c
+++ b/fetch.c
@@ -47,9 +47,9 @@ static int process_tree(struct tree *tree)
 		struct object *obj = NULL;
 
 		if (S_ISDIR(entry.mode)) {
-			struct tree *tree = lookup_tree(entry.sha1);
-			if (tree)
-				obj = &tree->object;
+			struct tree *t = lookup_tree(entry.sha1);
+			if (t)
+				obj = &t->object;
 		}
 		else {
 			struct blob *blob = lookup_blob(entry.sha1);
diff --git a/pack-check.c b/pack-check.c
index d04536b..ef7179e 100644
--- a/pack-check.c
+++ b/pack-check.c
@@ -7,7 +7,7 @@ static int verify_packfile(struct packed_git *p,
 	off_t index_size = p->index_size;
 	const unsigned char *index_base = p->index_data;
 	SHA_CTX ctx;
-	unsigned char sha1[20];
+	unsigned char pack_sha1[20];
 	off_t offset = 0, pack_sig = p->pack_size - 20;
 	uint32_t nr_objects, i;
 	int err;
@@ -27,11 +27,11 @@ static int verify_packfile(struct packed_git *p,
 			remaining -= (unsigned int)(offset - pack_sig);
 		SHA1_Update(&ctx, in, remaining);
 	}
-	SHA1_Final(sha1, &ctx);
-	if (hashcmp(sha1, use_pack(p, w_curs, pack_sig, NULL)))
+	SHA1_Final(pack_sha1, &ctx);
+	if (hashcmp(pack_sha1, use_pack(p, w_curs, pack_sig, NULL)))
 		return error("Packfile %s SHA1 mismatch with itself",
 			     p->pack_name);
-	if (hashcmp(sha1, index_base + index_size - 40))
+	if (hashcmp(pack_sha1, index_base + index_size - 40))
 		return error("Packfile %s SHA1 mismatch with idx",
 			     p->pack_name);
 	unuse_pack(w_curs);
@@ -46,7 +46,6 @@ static int verify_packfile(struct packed_git *p,
 		void *data;
 		enum object_type type;
 		unsigned long size;
-		off_t offset;
 
 		sha1 = nth_packed_object_sha1(p, i);
 		if (!sha1)
diff --git a/reflog-walk.c b/reflog-walk.c
index c983858..a2c1f17 100644
--- a/reflog-walk.c
+++ b/reflog-walk.c
@@ -240,11 +240,11 @@ void fake_reflog_parent(struct reflog_walk_info *info, struct commit *commit)
 	commit->object.flags &= ~(ADDED | SEEN | SHOWN);
 }
 
-void show_reflog_message(struct reflog_walk_info* info, int oneline,
+void show_reflog_message(struct reflog_walk_info* winfo, int oneline,
 	int relative_date)
 {
-	if (info && info->last_commit_reflog) {
-		struct commit_reflog *commit_reflog = info->last_commit_reflog;
+	if (winfo && winfo->last_commit_reflog) {
+		struct commit_reflog *commit_reflog = winfo->last_commit_reflog;
 		struct reflog_info *info;
 
 		info = &commit_reflog->reflogs->items[commit_reflog->recno+1];
diff --git a/revision.c b/revision.c
index 1bfe80c..13b7b37 100644
--- a/revision.c
+++ b/revision.c
@@ -79,9 +79,9 @@ void mark_tree_uninteresting(struct tree *tree)
 	tree->buffer = NULL;
 }
 
-void mark_parents_uninteresting(struct commit *commit)
+void mark_parents_uninteresting(struct commit *c)
 {
-	struct commit_list *parents = commit->parents;
+	struct commit_list *parents = c->parents;
 
 	while (parents) {
 		struct commit *commit = parents->item;
-- 
1.5.2
