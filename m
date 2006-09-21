From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 3/5] Tell between packed, unpacked and symbolic refs.
Date: Thu, 21 Sep 2006 00:06:04 -0700
Message-ID: <7vslilaecj.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0609111158390.3960@g5.osdl.org>
	<Pine.LNX.4.64.0609111632050.27779@g5.osdl.org>
	<7vy7shr5zw.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0609180934360.4388@g5.osdl.org>
	<7v64fhd7ns.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 21 09:06:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQIdX-0004D0-GH
	for gcvg-git@gmane.org; Thu, 21 Sep 2006 09:06:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750763AbWIUHGL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Sep 2006 03:06:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750769AbWIUHGL
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Sep 2006 03:06:11 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:24546 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1750763AbWIUHGF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Sep 2006 03:06:05 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060921070605.XTQG26416.fed1rmmtao12.cox.net@fed1rmimpo01.cox.net>;
          Thu, 21 Sep 2006 03:06:05 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Qv5q1V00K1kojtg0000000
	Thu, 21 Sep 2006 03:05:51 -0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27458>

This adds a "int *flag" parameter to resolve_ref() and makes
for_each_ref() family to call callback function with an extra
"int flag" parameter.  They are used to give two bits of
information (REF_ISSYMREF and REF_ISPACKED) about the ref.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 builtin-fmt-merge-msg.c |    2 +-
 builtin-name-rev.c      |    2 +-
 builtin-pack-refs.c     |    3 ++-
 builtin-prune.c         |    2 +-
 builtin-push.c          |    2 +-
 builtin-rev-parse.c     |    2 +-
 builtin-show-branch.c   |   22 +++++++++++-----------
 builtin-symbolic-ref.c  |    6 +++++-
 cache.h                 |    2 +-
 describe.c              |    2 +-
 fetch-pack.c            |    4 ++--
 fetch.c                 |    2 +-
 fsck-objects.c          |    7 ++++---
 http-push.c             |    2 +-
 receive-pack.c          |    4 ++--
 refs.c                  |   44 +++++++++++++++++++++++++++++++-------------
 refs.h                  |    4 +++-
 revision.c              |    2 +-
 send-pack.c             |    2 +-
 server-info.c           |    2 +-
 sha1_name.c             |    2 +-
 upload-pack.c           |    2 +-
 wt-status.c             |    2 +-
 23 files changed, 75 insertions(+), 49 deletions(-)

diff --git a/builtin-fmt-merge-msg.c b/builtin-fmt-merge-msg.c
index b93c17c..3d3097d 100644
--- a/builtin-fmt-merge-msg.c
+++ b/builtin-fmt-merge-msg.c
@@ -277,7 +277,7 @@ int cmd_fmt_merge_msg(int argc, const ch
 		usage(fmt_merge_msg_usage);
 
 	/* get current branch */
-	current_branch = resolve_ref("HEAD", head_sha1, 1);
+	current_branch = resolve_ref("HEAD", head_sha1, 1, NULL);
 	if (!strncmp(current_branch, "refs/heads/", 11))
 		current_branch += 11;
 
diff --git a/builtin-name-rev.c b/builtin-name-rev.c
index 9e3e537..618aa31 100644
--- a/builtin-name-rev.c
+++ b/builtin-name-rev.c
@@ -75,7 +75,7 @@ copy_data:
 	}
 }
 
-static int name_ref(const char *path, const unsigned char *sha1, void *cb_data)
+static int name_ref(const char *path, const unsigned char *sha1, int flags, void *cb_data)
 {
 	struct object *o = parse_object(sha1);
 	int tags_only = *(int*)cb_data;
diff --git a/builtin-pack-refs.c b/builtin-pack-refs.c
index b3d5470..9871089 100644
--- a/builtin-pack-refs.c
+++ b/builtin-pack-refs.c
@@ -9,7 +9,8 @@ static void remove_lock_file(void)
 		unlink(lock_path);
 }
 
-static int handle_one_ref(const char *path, const unsigned char *sha1, void *cb_data)
+static int handle_one_ref(const char *path, const unsigned char *sha1,
+			  int flags, void *cb_data)
 {
 	FILE *refs_file = cb_data;
 
diff --git a/builtin-prune.c b/builtin-prune.c
index e21c29b..e79b515 100644
--- a/builtin-prune.c
+++ b/builtin-prune.c
@@ -174,7 +174,7 @@ static void walk_commit_list(struct rev_
 	}
 }
 
-static int add_one_ref(const char *path, const unsigned char *sha1, void *cb_data)
+static int add_one_ref(const char *path, const unsigned char *sha1, int flag, void *cb_data)
 {
 	struct object *object = parse_object(sha1);
 	if (!object)
diff --git a/builtin-push.c b/builtin-push.c
index 88fc8e2..581c44b 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -27,7 +27,7 @@ static void add_refspec(const char *ref)
 	refspec_nr = nr;
 }
 
-static int expand_one_ref(const char *ref, const unsigned char *sha1, void *cb_data)
+static int expand_one_ref(const char *ref, const unsigned char *sha1, int flag, void *cb_data)
 {
 	/* Ignore the "refs/" at the beginning of the refname */
 	ref += 5;
diff --git a/builtin-rev-parse.c b/builtin-rev-parse.c
index c771274..3b716fb 100644
--- a/builtin-rev-parse.c
+++ b/builtin-rev-parse.c
@@ -137,7 +137,7 @@ static void show_default(void)
 	}
 }
 
-static int show_reference(const char *refname, const unsigned char *sha1, void *cb_data)
+static int show_reference(const char *refname, const unsigned char *sha1, int flag, void *cb_data)
 {
 	show_rev(NORMAL, sha1, refname);
 	return 0;
diff --git a/builtin-show-branch.c b/builtin-show-branch.c
index b3548ae..5d6ce56 100644
--- a/builtin-show-branch.c
+++ b/builtin-show-branch.c
@@ -346,7 +346,7 @@ static void sort_ref_range(int bottom, i
 	      compare_ref_name);
 }
 
-static int append_ref(const char *refname, const unsigned char *sha1, void *cb_data)
+static int append_ref(const char *refname, const unsigned char *sha1, int flag, void *cb_data)
 {
 	struct commit *commit = lookup_commit_reference_gently(sha1, 1);
 	int i;
@@ -369,7 +369,7 @@ static int append_ref(const char *refnam
 	return 0;
 }
 
-static int append_head_ref(const char *refname, const unsigned char *sha1, void *cb_data)
+static int append_head_ref(const char *refname, const unsigned char *sha1, int flag, void *cb_data)
 {
 	unsigned char tmp[20];
 	int ofs = 11;
@@ -380,14 +380,14 @@ static int append_head_ref(const char *r
 	 */
 	if (get_sha1(refname + ofs, tmp) || hashcmp(tmp, sha1))
 		ofs = 5;
-	return append_ref(refname + ofs, sha1, cb_data);
+	return append_ref(refname + ofs, sha1, flag, cb_data);
 }
 
-static int append_tag_ref(const char *refname, const unsigned char *sha1, void *cb_data)
+static int append_tag_ref(const char *refname, const unsigned char *sha1, int flag, void *cb_data)
 {
 	if (strncmp(refname, "refs/tags/", 10))
 		return 0;
-	return append_ref(refname + 5, sha1, cb_data);
+	return append_ref(refname + 5, sha1, flag, cb_data);
 }
 
 static const char *match_ref_pattern = NULL;
@@ -401,7 +401,7 @@ static int count_slash(const char *s)
 	return cnt;
 }
 
-static int append_matching_ref(const char *refname, const unsigned char *sha1, void *cb_data)
+static int append_matching_ref(const char *refname, const unsigned char *sha1, int flag, void *cb_data)
 {
 	/* we want to allow pattern hold/<asterisk> to show all
 	 * branches under refs/heads/hold/, and v0.99.9? to show
@@ -417,10 +417,10 @@ static int append_matching_ref(const cha
 	if (fnmatch(match_ref_pattern, tail, 0))
 		return 0;
 	if (!strncmp("refs/heads/", refname, 11))
-		return append_head_ref(refname, sha1, cb_data);
+		return append_head_ref(refname, sha1, flag, cb_data);
 	if (!strncmp("refs/tags/", refname, 10))
-		return append_tag_ref(refname, sha1, cb_data);
-	return append_ref(refname, sha1, cb_data);
+		return append_tag_ref(refname, sha1, flag, cb_data);
+	return append_ref(refname, sha1, flag, cb_data);
 }
 
 static void snarf_refs(int head, int tag)
@@ -487,7 +487,7 @@ static void append_one_rev(const char *a
 {
 	unsigned char revkey[20];
 	if (!get_sha1(av, revkey)) {
-		append_ref(av, revkey, NULL);
+		append_ref(av, revkey, 0, NULL);
 		return;
 	}
 	if (strchr(av, '*') || strchr(av, '?') || strchr(av, '[')) {
@@ -630,7 +630,7 @@ int cmd_show_branch(int ac, const char *
 		ac--; av++;
 	}
 
-	head_p = resolve_ref("HEAD", head_sha1, 1);
+	head_p = resolve_ref("HEAD", head_sha1, 1, NULL);
 	if (head_p) {
 		head_len = strlen(head_p);
 		memcpy(head, head_p, head_len + 1);
diff --git a/builtin-symbolic-ref.c b/builtin-symbolic-ref.c
index 13163ba..d8be052 100644
--- a/builtin-symbolic-ref.c
+++ b/builtin-symbolic-ref.c
@@ -1,5 +1,6 @@
 #include "builtin.h"
 #include "cache.h"
+#include "refs.h"
 
 static const char git_symbolic_ref_usage[] =
 "git-symbolic-ref name [ref]";
@@ -7,10 +8,13 @@ static const char git_symbolic_ref_usage
 static void check_symref(const char *HEAD)
 {
 	unsigned char sha1[20];
-	const char *refs_heads_master = resolve_ref(HEAD, sha1, 0);
+	int flag;
+	const char *refs_heads_master = resolve_ref(HEAD, sha1, 0, &flag);
 
 	if (!refs_heads_master)
 		die("No such ref: %s", HEAD);
+	else if (!(flag & REF_ISSYMREF))
+		die("ref %s is not a symbolic ref", HEAD);
 	puts(refs_heads_master);
 }
 
diff --git a/cache.h b/cache.h
index 282eed6..6def155 100644
--- a/cache.h
+++ b/cache.h
@@ -286,7 +286,7 @@ extern int get_sha1(const char *str, uns
 extern int get_sha1_hex(const char *hex, unsigned char *sha1);
 extern char *sha1_to_hex(const unsigned char *sha1);	/* static buffer result! */
 extern int read_ref(const char *filename, unsigned char *sha1);
-extern const char *resolve_ref(const char *path, unsigned char *sha1, int);
+extern const char *resolve_ref(const char *path, unsigned char *sha1, int, int *);
 extern int create_symref(const char *ref, const char *refs_heads_master);
 extern int validate_symref(const char *ref);
 
diff --git a/describe.c b/describe.c
index ea0f2ce..f4029ee 100644
--- a/describe.c
+++ b/describe.c
@@ -53,7 +53,7 @@ static void add_to_known_names(const cha
 	names = ++idx;
 }
 
-static int get_name(const char *path, const unsigned char *sha1, void *cb_data)
+static int get_name(const char *path, const unsigned char *sha1, int flag, void *cb_data)
 {
 	struct commit *commit = lookup_commit_reference_gently(sha1, 1);
 	struct object *object;
diff --git a/fetch-pack.c b/fetch-pack.c
index 6264ea1..99ac08b 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -42,7 +42,7 @@ static void rev_list_push(struct commit 
 	}
 }
 
-static int rev_list_insert_ref(const char *path, const unsigned char *sha1, void *cb_data)
+static int rev_list_insert_ref(const char *path, const unsigned char *sha1, int flag, void *cb_data)
 {
 	struct object *o = deref_tag(parse_object(sha1), path, 0);
 
@@ -253,7 +253,7 @@ done:
 
 static struct commit_list *complete;
 
-static int mark_complete(const char *path, const unsigned char *sha1, void *cb_data)
+static int mark_complete(const char *path, const unsigned char *sha1, int flag, void *cb_data)
 {
 	struct object *o = parse_object(sha1);
 
diff --git a/fetch.c b/fetch.c
index 36d1e76..a2cbdfb 100644
--- a/fetch.c
+++ b/fetch.c
@@ -201,7 +201,7 @@ static int interpret_target(char *target
 	return -1;
 }
 
-static int mark_complete(const char *path, const unsigned char *sha1, void *cb_data)
+static int mark_complete(const char *path, const unsigned char *sha1, int flag, void *cb_data)
 {
 	struct commit *commit = lookup_commit_reference_gently(sha1, 1);
 	if (commit) {
diff --git a/fsck-objects.c b/fsck-objects.c
index bb0c94e..46b628c 100644
--- a/fsck-objects.c
+++ b/fsck-objects.c
@@ -402,7 +402,7 @@ static void fsck_dir(int i, char *path)
 
 static int default_refs;
 
-static int fsck_handle_ref(const char *refname, const unsigned char *sha1, void *cb_data)
+static int fsck_handle_ref(const char *refname, const unsigned char *sha1, int flag, void *cb_data)
 {
 	struct object *obj;
 
@@ -458,9 +458,10 @@ static void fsck_object_dir(const char *
 static int fsck_head_link(void)
 {
 	unsigned char sha1[20];
-	const char *head_points_at = resolve_ref("HEAD", sha1, 1);
+	int flag;
+	const char *head_points_at = resolve_ref("HEAD", sha1, 1, &flag);
 
-	if (!head_points_at)
+	if (!head_points_at || !(flag & REF_ISSYMREF))
 		return error("HEAD is not a symbolic ref");
 	if (strncmp(head_points_at, "refs/heads/", 11))
 		return error("HEAD points to something strange (%s)",
diff --git a/http-push.c b/http-push.c
index 460c9be..ecefdfd 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1864,7 +1864,7 @@ static int update_remote(unsigned char *
 static struct ref *local_refs, **local_tail;
 static struct ref *remote_refs, **remote_tail;
 
-static int one_local_ref(const char *refname, const unsigned char *sha1, void *cb_data)
+static int one_local_ref(const char *refname, const unsigned char *sha1, int flag, void *cb_data)
 {
 	struct ref *ref;
 	int len = strlen(refname) + 1;
diff --git a/receive-pack.c b/receive-pack.c
index 7abc921..abbcb6a 100644
--- a/receive-pack.c
+++ b/receive-pack.c
@@ -12,7 +12,7 @@ static int report_status;
 static char capabilities[] = "report-status";
 static int capabilities_sent;
 
-static int show_ref(const char *path, const unsigned char *sha1, void *cb_data)
+static int show_ref(const char *path, const unsigned char *sha1, int flag, void *cb_data)
 {
 	if (capabilities_sent)
 		packet_write(1, "%s %s\n", sha1_to_hex(sha1), path);
@@ -27,7 +27,7 @@ static void write_head_info(void)
 {
 	for_each_ref(show_ref, NULL);
 	if (!capabilities_sent)
-		show_ref("capabilities^{}", null_sha1, NULL);
+		show_ref("capabilities^{}", null_sha1, 0, NULL);
 
 }
 
diff --git a/refs.c b/refs.c
index 85564f0..40f16af 100644
--- a/refs.c
+++ b/refs.c
@@ -5,6 +5,7 @@ #include <errno.h>
 
 struct ref_list {
 	struct ref_list *next;
+	unsigned char flag; /* ISSYMREF? ISPACKED? */
 	unsigned char sha1[20];
 	char name[FLEX_ARRAY];
 };
@@ -36,7 +37,8 @@ static const char *parse_ref_line(char *
 	return line;
 }
 
-static struct ref_list *add_ref(const char *name, const unsigned char *sha1, struct ref_list *list)
+static struct ref_list *add_ref(const char *name, const unsigned char *sha1,
+				int flag, struct ref_list *list)
 {
 	int len;
 	struct ref_list **p = &list, *entry;
@@ -58,6 +60,7 @@ static struct ref_list *add_ref(const ch
 	entry = xmalloc(sizeof(struct ref_list) + len);
 	hashcpy(entry->sha1, sha1);
 	memcpy(entry->name, name, len);
+	entry->flag = flag;
 	entry->next = *p;
 	*p = entry;
 	return list;
@@ -78,7 +81,7 @@ static struct ref_list *get_packed_refs(
 				const char *name = parse_ref_line(refline, sha1);
 				if (!name)
 					continue;
-				list = add_ref(name, sha1, list);
+				list = add_ref(name, sha1, REF_ISPACKED, list);
 			}
 			fclose(f);
 			refs = list;
@@ -104,6 +107,7 @@ static struct ref_list *get_ref_dir(cons
 		while ((de = readdir(dir)) != NULL) {
 			unsigned char sha1[20];
 			struct stat st;
+			int flag;
 			int namelen;
 
 			if (de->d_name[0] == '.')
@@ -120,11 +124,11 @@ static struct ref_list *get_ref_dir(cons
 				list = get_ref_dir(ref, list);
 				continue;
 			}
-			if (read_ref(ref, sha1) < 0) {
+			if (!resolve_ref(ref, sha1, 1, &flag)) {
 				error("%s points nowhere!", ref);
 				continue;
 			}
-			list = add_ref(ref, sha1, list);
+			list = add_ref(ref, sha1, flag, list);
 		}
 		free(ref);
 		closedir(dir);
@@ -147,12 +151,15 @@ static struct ref_list *get_loose_refs(v
 /* We allow "recursive" symbolic refs. Only within reason, though */
 #define MAXDEPTH 5
 
-const char *resolve_ref(const char *ref, unsigned char *sha1, int reading)
+const char *resolve_ref(const char *ref, unsigned char *sha1, int reading, int *flag)
 {
 	int depth = MAXDEPTH, len;
 	char buffer[256];
 	static char ref_buffer[256];
 
+	if (flag)
+		*flag = 0;
+
 	for (;;) {
 		const char *path = git_path("%s", ref);
 		struct stat st;
@@ -174,6 +181,8 @@ const char *resolve_ref(const char *ref,
 			while (list) {
 				if (!strcmp(ref, list->name)) {
 					hashcpy(sha1, list->sha1);
+					if (flag)
+						*flag |= REF_ISPACKED;
 					return ref;
 				}
 				list = list->next;
@@ -191,6 +200,8 @@ const char *resolve_ref(const char *ref,
 				buffer[len] = 0;
 				strcpy(ref_buffer, buffer);
 				ref = ref_buffer;
+				if (flag)
+					*flag |= REF_ISSYMREF;
 				continue;
 			}
 		}
@@ -219,6 +230,8 @@ const char *resolve_ref(const char *ref,
 		buf[len] = 0;
 		memcpy(ref_buffer, buf, len + 1);
 		ref = ref_buffer;
+		if (flag)
+			*flag |= REF_ISSYMREF;
 	}
 	if (len < 40 || get_sha1_hex(buffer, sha1))
 		return NULL;
@@ -270,12 +283,13 @@ #endif
 
 int read_ref(const char *ref, unsigned char *sha1)
 {
-	if (resolve_ref(ref, sha1, 1))
+	if (resolve_ref(ref, sha1, 1, NULL))
 		return 0;
 	return -1;
 }
 
-static int do_for_each_ref(const char *base, each_ref_fn fn, int trim, void *cb_data)
+static int do_for_each_ref(const char *base, each_ref_fn fn, int trim,
+			   void *cb_data)
 {
 	int retval;
 	struct ref_list *packed = get_packed_refs();
@@ -303,7 +317,8 @@ static int do_for_each_ref(const char *b
 			error("%s does not point to a valid object!", entry->name);
 			continue;
 		}
-		retval = fn(entry->name + trim, entry->sha1, cb_data);
+		retval = fn(entry->name + trim, entry->sha1,
+			    entry->flag, cb_data);
 		if (retval)
 			return retval;
 	}
@@ -311,7 +326,8 @@ static int do_for_each_ref(const char *b
 	packed = packed ? packed : loose;
 	while (packed) {
 		if (!strncmp(base, packed->name, trim)) {
-			retval = fn(packed->name + trim, packed->sha1, cb_data);
+			retval = fn(packed->name + trim, packed->sha1,
+				    packed->flag, cb_data);
 			if (retval)
 				return retval;
 		}
@@ -323,8 +339,10 @@ static int do_for_each_ref(const char *b
 int head_ref(each_ref_fn fn, void *cb_data)
 {
 	unsigned char sha1[20];
-	if (!read_ref("HEAD", sha1))
-		return fn("HEAD", sha1, cb_data);
+	int flag;
+
+	if (resolve_ref("HEAD", sha1, 1, &flag))
+		return fn("HEAD", sha1, flag, cb_data);
 	return 0;
 }
 
@@ -415,7 +433,7 @@ int check_ref_format(const char *ref)
 static struct ref_lock *verify_lock(struct ref_lock *lock,
 	const unsigned char *old_sha1, int mustexist)
 {
-	if (!resolve_ref(lock->ref_name, lock->old_sha1, mustexist)) {
+	if (!resolve_ref(lock->ref_name, lock->old_sha1, mustexist, NULL)) {
 		error("Can't verify ref %s", lock->ref_name);
 		unlock_ref(lock);
 		return NULL;
@@ -441,7 +459,7 @@ static struct ref_lock *lock_ref_sha1_ba
 	lock = xcalloc(1, sizeof(struct ref_lock));
 	lock->lock_fd = -1;
 
-	ref = resolve_ref(ref, lock->old_sha1, mustexist);
+	ref = resolve_ref(ref, lock->old_sha1, mustexist, NULL);
 	if (!ref) {
 		int last_errno = errno;
 		error("unable to resolve reference %s: %s",
diff --git a/refs.h b/refs.h
index 886c857..305d408 100644
--- a/refs.h
+++ b/refs.h
@@ -14,7 +14,9 @@ struct ref_lock {
  * Calls the specified function for each ref file until it returns nonzero,
  * and returns the value
  */
-typedef int each_ref_fn(const char *refname, const unsigned char *sha1, void *cb_data);
+#define REF_ISSYMREF 01
+#define REF_ISPACKED 02
+typedef int each_ref_fn(const char *refname, const unsigned char *sha1, int flags, void *cb_data);
 extern int head_ref(each_ref_fn, void *);
 extern int for_each_ref(each_ref_fn, void *);
 extern int for_each_tag_ref(each_ref_fn, void *);
diff --git a/revision.c b/revision.c
index 0e84b8a..cb13b90 100644
--- a/revision.c
+++ b/revision.c
@@ -466,7 +466,7 @@ static void limit_list(struct rev_info *
 static int all_flags;
 static struct rev_info *all_revs;
 
-static int handle_one_ref(const char *path, const unsigned char *sha1, void *cb_data)
+static int handle_one_ref(const char *path, const unsigned char *sha1, int flag, void *cb_data)
 {
 	struct object *object = get_reference(all_revs, path, sha1, all_flags);
 	add_pending_object(all_revs, object, "");
diff --git a/send-pack.c b/send-pack.c
index ee13093..fbd792c 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -215,7 +215,7 @@ static int ref_newer(const unsigned char
 static struct ref *local_refs, **local_tail;
 static struct ref *remote_refs, **remote_tail;
 
-static int one_local_ref(const char *refname, const unsigned char *sha1, void *cb_data)
+static int one_local_ref(const char *refname, const unsigned char *sha1, int flag, void *cb_data)
 {
 	struct ref *ref;
 	int len = strlen(refname) + 1;
diff --git a/server-info.c b/server-info.c
index 7667b41..6cd38be 100644
--- a/server-info.c
+++ b/server-info.c
@@ -7,7 +7,7 @@ #include "tag.h"
 /* refs */
 static FILE *info_ref_fp;
 
-static int add_info_ref(const char *path, const unsigned char *sha1, void *cb_data)
+static int add_info_ref(const char *path, const unsigned char *sha1, int flag, void *cb_data)
 {
 	struct object *o = parse_object(sha1);
 
diff --git a/sha1_name.c b/sha1_name.c
index b497528..84d24c6 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -276,7 +276,7 @@ static int get_sha1_basic(const char *st
 
 	for (p = fmt; *p; p++) {
 		this_result = refs_found ? sha1_from_ref : sha1;
-		ref = resolve_ref(mkpath(*p, len, str), this_result, 1);
+		ref = resolve_ref(mkpath(*p, len, str), this_result, 1, NULL);
 		if (ref) {
 			if (!refs_found++)
 				real_ref = xstrdup(ref);
diff --git a/upload-pack.c b/upload-pack.c
index 10237eb..9412a9b 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -416,7 +416,7 @@ static void receive_needs(void)
 	}
 }
 
-static int send_ref(const char *refname, const unsigned char *sha1, void *cb_data)
+static int send_ref(const char *refname, const unsigned char *sha1, int flag, void *cb_data)
 {
 	static const char *capabilities = "multi_ack thin-pack side-band side-band-64k";
 	struct object *o = parse_object(sha1);
diff --git a/wt-status.c b/wt-status.c
index 050922d..d8e284c 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -41,7 +41,7 @@ void wt_status_prepare(struct wt_status 
 
 	s->is_initial = get_sha1("HEAD", sha1) ? 1 : 0;
 
-	head = resolve_ref("HEAD", sha1, 0);
+	head = resolve_ref("HEAD", sha1, 0, NULL);
 	s->branch = head ? xstrdup(head) : NULL;
 
 	s->reference = "HEAD";
-- 
1.4.2.1.g4dc7
