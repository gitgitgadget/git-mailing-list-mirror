From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 2/5] Add callback data to for_each_ref() family.
Date: Thu, 21 Sep 2006 00:06:03 -0700
Message-ID: <7vy7sdaeck.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0609111158390.3960@g5.osdl.org>
	<Pine.LNX.4.64.0609111632050.27779@g5.osdl.org>
	<7vy7shr5zw.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0609180934360.4388@g5.osdl.org>
	<7v64fhd7ns.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 21 09:06:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQIdY-0004D0-W3
	for gcvg-git@gmane.org; Thu, 21 Sep 2006 09:06:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750762AbWIUHGJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Sep 2006 03:06:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750769AbWIUHGI
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Sep 2006 03:06:08 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:31484 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1750762AbWIUHGE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Sep 2006 03:06:04 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060921070604.ICFX12581.fed1rmmtao02.cox.net@fed1rmimpo01.cox.net>;
          Thu, 21 Sep 2006 03:06:04 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Qv5p1V00D1kojtg0000000
	Thu, 21 Sep 2006 03:05:50 -0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27462>

This is a long overdue fix to the API for for_each_ref() family
of functions.  It allows the callers to specify a callback data
pointer, so that the caller does not have to use static
variables to communicate with the callback funciton.

The updated for_each_ref() family takes a function of type

	int (*fn)(const char *, const unsigned char *, void *)

and a void pointer as parameters, and calls the function with
the name of the ref and its SHA-1 with the caller-supplied void
pointer as parameters.

The commit updates two callers, builtin-name-rev.c and
builtin-pack-refs.c as an example.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 builtin-name-rev.c    |    8 ++++----
 builtin-pack-refs.c   |    8 +++++---
 builtin-prune.c       |    4 ++--
 builtin-push.c        |    4 ++--
 builtin-rev-parse.c   |   10 +++++-----
 builtin-show-branch.c |   26 +++++++++++++-------------
 describe.c            |    4 ++--
 fetch-pack.c          |    8 ++++----
 fetch.c               |    4 ++--
 fsck-objects.c        |    4 ++--
 http-push.c           |    4 ++--
 receive-pack.c        |    6 +++---
 refs.c                |   31 ++++++++++++++++++-------------
 refs.h                |   11 ++++++-----
 revision.c            |    4 ++--
 send-pack.c           |    4 ++--
 server-info.c         |    4 ++--
 upload-pack.c         |    6 +++---
 18 files changed, 79 insertions(+), 71 deletions(-)

diff --git a/builtin-name-rev.c b/builtin-name-rev.c
index 52886b6..9e3e537 100644
--- a/builtin-name-rev.c
+++ b/builtin-name-rev.c
@@ -75,11 +75,10 @@ copy_data:
 	}
 }
 
-static int tags_only;
-
-static int name_ref(const char *path, const unsigned char *sha1)
+static int name_ref(const char *path, const unsigned char *sha1, void *cb_data)
 {
 	struct object *o = parse_object(sha1);
+	int tags_only = *(int*)cb_data;
 	int deref = 0;
 
 	if (tags_only && strncmp(path, "refs/tags/", 10))
@@ -131,6 +130,7 @@ int cmd_name_rev(int argc, const char **
 {
 	struct object_array revs = { 0, 0, NULL };
 	int as_is = 0, all = 0, transform_stdin = 0;
+	int tags_only = 0;
 
 	git_config(git_default_config);
 
@@ -186,7 +186,7 @@ int cmd_name_rev(int argc, const char **
 		add_object_array((struct object *)commit, *argv, &revs);
 	}
 
-	for_each_ref(name_ref);
+	for_each_ref(name_ref, &tags_only);
 
 	if (transform_stdin) {
 		char buffer[2048];
diff --git a/builtin-pack-refs.c b/builtin-pack-refs.c
index 0f5d827..b3d5470 100644
--- a/builtin-pack-refs.c
+++ b/builtin-pack-refs.c
@@ -1,7 +1,6 @@
 #include "cache.h"
 #include "refs.h"
 
-static FILE *refs_file;
 static const char *result_path, *lock_path;
 
 static void remove_lock_file(void)
@@ -10,8 +9,10 @@ static void remove_lock_file(void)
 		unlink(lock_path);
 }
 
-static int handle_one_ref(const char *path, const unsigned char *sha1)
+static int handle_one_ref(const char *path, const unsigned char *sha1, void *cb_data)
 {
+	FILE *refs_file = cb_data;
+
 	fprintf(refs_file, "%s %s\n", sha1_to_hex(sha1), path);
 	return 0;
 }
@@ -19,6 +20,7 @@ static int handle_one_ref(const char *pa
 int cmd_pack_refs(int argc, const char **argv, const char *prefix)
 {
 	int fd;
+	FILE *refs_file;
 
 	result_path = xstrdup(git_path("packed-refs"));
 	lock_path = xstrdup(mkpath("%s.lock", result_path));
@@ -31,7 +33,7 @@ int cmd_pack_refs(int argc, const char *
 	refs_file = fdopen(fd, "w");
 	if (!refs_file)
 		die("unable to create ref-pack file structure (%s)", strerror(errno));
-	for_each_ref(handle_one_ref);
+	for_each_ref(handle_one_ref, refs_file);
 	fsync(fd);
 	fclose(refs_file);
 	if (rename(lock_path, result_path) < 0)
diff --git a/builtin-prune.c b/builtin-prune.c
index 6228c79..e21c29b 100644
--- a/builtin-prune.c
+++ b/builtin-prune.c
@@ -174,7 +174,7 @@ static void walk_commit_list(struct rev_
 	}
 }
 
-static int add_one_ref(const char *path, const unsigned char *sha1)
+static int add_one_ref(const char *path, const unsigned char *sha1, void *cb_data)
 {
 	struct object *object = parse_object(sha1);
 	if (!object)
@@ -240,7 +240,7 @@ int cmd_prune(int argc, const char **arg
 	revs.tree_objects = 1;
 
 	/* Add all external refs */
-	for_each_ref(add_one_ref);
+	for_each_ref(add_one_ref, NULL);
 
 	/* Add all refs from the index file */
 	add_cache_refs();
diff --git a/builtin-push.c b/builtin-push.c
index c43f256..88fc8e2 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -27,7 +27,7 @@ static void add_refspec(const char *ref)
 	refspec_nr = nr;
 }
 
-static int expand_one_ref(const char *ref, const unsigned char *sha1)
+static int expand_one_ref(const char *ref, const unsigned char *sha1, void *cb_data)
 {
 	/* Ignore the "refs/" at the beginning of the refname */
 	ref += 5;
@@ -51,7 +51,7 @@ static void expand_refspecs(void)
 	}
 	if (!tags)
 		return;
-	for_each_ref(expand_one_ref);
+	for_each_ref(expand_one_ref, NULL);
 }
 
 static void set_refspecs(const char **refs, int nr)
diff --git a/builtin-rev-parse.c b/builtin-rev-parse.c
index fd3ccc8..c771274 100644
--- a/builtin-rev-parse.c
+++ b/builtin-rev-parse.c
@@ -137,7 +137,7 @@ static void show_default(void)
 	}
 }
 
-static int show_reference(const char *refname, const unsigned char *sha1)
+static int show_reference(const char *refname, const unsigned char *sha1, void *cb_data)
 {
 	show_rev(NORMAL, sha1, refname);
 	return 0;
@@ -299,19 +299,19 @@ int cmd_rev_parse(int argc, const char *
 				continue;
 			}
 			if (!strcmp(arg, "--all")) {
-				for_each_ref(show_reference);
+				for_each_ref(show_reference, NULL);
 				continue;
 			}
 			if (!strcmp(arg, "--branches")) {
-				for_each_branch_ref(show_reference);
+				for_each_branch_ref(show_reference, NULL);
 				continue;
 			}
 			if (!strcmp(arg, "--tags")) {
-				for_each_tag_ref(show_reference);
+				for_each_tag_ref(show_reference, NULL);
 				continue;
 			}
 			if (!strcmp(arg, "--remotes")) {
-				for_each_remote_ref(show_reference);
+				for_each_remote_ref(show_reference, NULL);
 				continue;
 			}
 			if (!strcmp(arg, "--show-prefix")) {
diff --git a/builtin-show-branch.c b/builtin-show-branch.c
index 4d8db0c..b3548ae 100644
--- a/builtin-show-branch.c
+++ b/builtin-show-branch.c
@@ -346,7 +346,7 @@ static void sort_ref_range(int bottom, i
 	      compare_ref_name);
 }
 
-static int append_ref(const char *refname, const unsigned char *sha1)
+static int append_ref(const char *refname, const unsigned char *sha1, void *cb_data)
 {
 	struct commit *commit = lookup_commit_reference_gently(sha1, 1);
 	int i;
@@ -369,7 +369,7 @@ static int append_ref(const char *refnam
 	return 0;
 }
 
-static int append_head_ref(const char *refname, const unsigned char *sha1)
+static int append_head_ref(const char *refname, const unsigned char *sha1, void *cb_data)
 {
 	unsigned char tmp[20];
 	int ofs = 11;
@@ -380,14 +380,14 @@ static int append_head_ref(const char *r
 	 */
 	if (get_sha1(refname + ofs, tmp) || hashcmp(tmp, sha1))
 		ofs = 5;
-	return append_ref(refname + ofs, sha1);
+	return append_ref(refname + ofs, sha1, cb_data);
 }
 
-static int append_tag_ref(const char *refname, const unsigned char *sha1)
+static int append_tag_ref(const char *refname, const unsigned char *sha1, void *cb_data)
 {
 	if (strncmp(refname, "refs/tags/", 10))
 		return 0;
-	return append_ref(refname + 5, sha1);
+	return append_ref(refname + 5, sha1, cb_data);
 }
 
 static const char *match_ref_pattern = NULL;
@@ -401,7 +401,7 @@ static int count_slash(const char *s)
 	return cnt;
 }
 
-static int append_matching_ref(const char *refname, const unsigned char *sha1)
+static int append_matching_ref(const char *refname, const unsigned char *sha1, void *cb_data)
 {
 	/* we want to allow pattern hold/<asterisk> to show all
 	 * branches under refs/heads/hold/, and v0.99.9? to show
@@ -417,22 +417,22 @@ static int append_matching_ref(const cha
 	if (fnmatch(match_ref_pattern, tail, 0))
 		return 0;
 	if (!strncmp("refs/heads/", refname, 11))
-		return append_head_ref(refname, sha1);
+		return append_head_ref(refname, sha1, cb_data);
 	if (!strncmp("refs/tags/", refname, 10))
-		return append_tag_ref(refname, sha1);
-	return append_ref(refname, sha1);
+		return append_tag_ref(refname, sha1, cb_data);
+	return append_ref(refname, sha1, cb_data);
 }
 
 static void snarf_refs(int head, int tag)
 {
 	if (head) {
 		int orig_cnt = ref_name_cnt;
-		for_each_ref(append_head_ref);
+		for_each_ref(append_head_ref, NULL);
 		sort_ref_range(orig_cnt, ref_name_cnt);
 	}
 	if (tag) {
 		int orig_cnt = ref_name_cnt;
-		for_each_ref(append_tag_ref);
+		for_each_ref(append_tag_ref, NULL);
 		sort_ref_range(orig_cnt, ref_name_cnt);
 	}
 }
@@ -487,7 +487,7 @@ static void append_one_rev(const char *a
 {
 	unsigned char revkey[20];
 	if (!get_sha1(av, revkey)) {
-		append_ref(av, revkey);
+		append_ref(av, revkey, NULL);
 		return;
 	}
 	if (strchr(av, '*') || strchr(av, '?') || strchr(av, '[')) {
@@ -495,7 +495,7 @@ static void append_one_rev(const char *a
 		int saved_matches = ref_name_cnt;
 		match_ref_pattern = av;
 		match_ref_slash = count_slash(av);
-		for_each_ref(append_matching_ref);
+		for_each_ref(append_matching_ref, NULL);
 		if (saved_matches == ref_name_cnt &&
 		    ref_name_cnt < MAX_REVS)
 			error("no matching refs with %s", av);
diff --git a/describe.c b/describe.c
index ab192f8..ea0f2ce 100644
--- a/describe.c
+++ b/describe.c
@@ -53,7 +53,7 @@ static void add_to_known_names(const cha
 	names = ++idx;
 }
 
-static int get_name(const char *path, const unsigned char *sha1)
+static int get_name(const char *path, const unsigned char *sha1, void *cb_data)
 {
 	struct commit *commit = lookup_commit_reference_gently(sha1, 1);
 	struct object *object;
@@ -113,7 +113,7 @@ static void describe(const char *arg, in
 
 	if (!initialized) {
 		initialized = 1;
-		for_each_ref(get_name);
+		for_each_ref(get_name, NULL);
 		qsort(name_array, names, sizeof(*name_array), compare_names);
 	}
 
diff --git a/fetch-pack.c b/fetch-pack.c
index e8708aa..6264ea1 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -42,7 +42,7 @@ static void rev_list_push(struct commit 
 	}
 }
 
-static int rev_list_insert_ref(const char *path, const unsigned char *sha1)
+static int rev_list_insert_ref(const char *path, const unsigned char *sha1, void *cb_data)
 {
 	struct object *o = deref_tag(parse_object(sha1), path, 0);
 
@@ -143,7 +143,7 @@ static int find_common(int fd[2], unsign
 	unsigned in_vain = 0;
 	int got_continue = 0;
 
-	for_each_ref(rev_list_insert_ref);
+	for_each_ref(rev_list_insert_ref, NULL);
 
 	fetching = 0;
 	for ( ; refs ; refs = refs->next) {
@@ -253,7 +253,7 @@ done:
 
 static struct commit_list *complete;
 
-static int mark_complete(const char *path, const unsigned char *sha1)
+static int mark_complete(const char *path, const unsigned char *sha1, void *cb_data)
 {
 	struct object *o = parse_object(sha1);
 
@@ -365,7 +365,7 @@ static int everything_local(struct ref *
 		}
 	}
 
-	for_each_ref(mark_complete);
+	for_each_ref(mark_complete, NULL);
 	if (cutoff)
 		mark_recent_complete_commits(cutoff);
 
diff --git a/fetch.c b/fetch.c
index 34df8d3..36d1e76 100644
--- a/fetch.c
+++ b/fetch.c
@@ -201,7 +201,7 @@ static int interpret_target(char *target
 	return -1;
 }
 
-static int mark_complete(const char *path, const unsigned char *sha1)
+static int mark_complete(const char *path, const unsigned char *sha1, void *cb_data)
 {
 	struct commit *commit = lookup_commit_reference_gently(sha1, 1);
 	if (commit) {
@@ -274,7 +274,7 @@ int pull(int targets, char **target, con
 	}
 
 	if (!get_recover)
-		for_each_ref(mark_complete);
+		for_each_ref(mark_complete, NULL);
 
 	for (i = 0; i < targets; i++) {
 		if (interpret_target(target[i], &sha1[20 * i])) {
diff --git a/fsck-objects.c b/fsck-objects.c
index 456c17e..bb0c94e 100644
--- a/fsck-objects.c
+++ b/fsck-objects.c
@@ -402,7 +402,7 @@ static void fsck_dir(int i, char *path)
 
 static int default_refs;
 
-static int fsck_handle_ref(const char *refname, const unsigned char *sha1)
+static int fsck_handle_ref(const char *refname, const unsigned char *sha1, void *cb_data)
 {
 	struct object *obj;
 
@@ -424,7 +424,7 @@ static int fsck_handle_ref(const char *r
 
 static void get_default_heads(void)
 {
-	for_each_ref(fsck_handle_ref);
+	for_each_ref(fsck_handle_ref, NULL);
 
 	/*
 	 * Not having any default heads isn't really fatal, but
diff --git a/http-push.c b/http-push.c
index 670ff00..460c9be 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1864,7 +1864,7 @@ static int update_remote(unsigned char *
 static struct ref *local_refs, **local_tail;
 static struct ref *remote_refs, **remote_tail;
 
-static int one_local_ref(const char *refname, const unsigned char *sha1)
+static int one_local_ref(const char *refname, const unsigned char *sha1, void *cb_data)
 {
 	struct ref *ref;
 	int len = strlen(refname) + 1;
@@ -1913,7 +1913,7 @@ static void one_remote_ref(char *refname
 static void get_local_heads(void)
 {
 	local_tail = &local_refs;
-	for_each_ref(one_local_ref);
+	for_each_ref(one_local_ref, NULL);
 }
 
 static void get_dav_remote_heads(void)
diff --git a/receive-pack.c b/receive-pack.c
index 78f75da..7abc921 100644
--- a/receive-pack.c
+++ b/receive-pack.c
@@ -12,7 +12,7 @@ static int report_status;
 static char capabilities[] = "report-status";
 static int capabilities_sent;
 
-static int show_ref(const char *path, const unsigned char *sha1)
+static int show_ref(const char *path, const unsigned char *sha1, void *cb_data)
 {
 	if (capabilities_sent)
 		packet_write(1, "%s %s\n", sha1_to_hex(sha1), path);
@@ -25,9 +25,9 @@ static int show_ref(const char *path, co
 
 static void write_head_info(void)
 {
-	for_each_ref(show_ref);
+	for_each_ref(show_ref, NULL);
 	if (!capabilities_sent)
-		show_ref("capabilities^{}", null_sha1);
+		show_ref("capabilities^{}", null_sha1, NULL);
 
 }
 
diff --git a/refs.c b/refs.c
index 7bd36e4..85564f0 100644
--- a/refs.c
+++ b/refs.c
@@ -275,7 +275,7 @@ int read_ref(const char *ref, unsigned c
 	return -1;
 }
 
-static int do_for_each_ref(const char *base, int (*fn)(const char *path, const unsigned char *sha1), int trim)
+static int do_for_each_ref(const char *base, each_ref_fn fn, int trim, void *cb_data)
 {
 	int retval;
 	struct ref_list *packed = get_packed_refs();
@@ -303,7 +303,7 @@ static int do_for_each_ref(const char *b
 			error("%s does not point to a valid object!", entry->name);
 			continue;
 		}
-		retval = fn(entry->name + trim, entry->sha1);
+		retval = fn(entry->name + trim, entry->sha1, cb_data);
 		if (retval)
 			return retval;
 	}
@@ -311,7 +311,7 @@ static int do_for_each_ref(const char *b
 	packed = packed ? packed : loose;
 	while (packed) {
 		if (!strncmp(base, packed->name, trim)) {
-			retval = fn(packed->name + trim, packed->sha1);
+			retval = fn(packed->name + trim, packed->sha1, cb_data);
 			if (retval)
 				return retval;
 		}
@@ -320,34 +320,39 @@ static int do_for_each_ref(const char *b
 	return 0;
 }
 
-int head_ref(int (*fn)(const char *path, const unsigned char *sha1))
+int head_ref(each_ref_fn fn, void *cb_data)
 {
 	unsigned char sha1[20];
 	if (!read_ref("HEAD", sha1))
-		return fn("HEAD", sha1);
+		return fn("HEAD", sha1, cb_data);
 	return 0;
 }
 
-int for_each_ref(int (*fn)(const char *path, const unsigned char *sha1))
+int for_each_ref(each_ref_fn fn, void *cb_data)
 {
-	return do_for_each_ref("refs/", fn, 0);
+	return do_for_each_ref("refs/", fn, 0, cb_data);
 }
 
-int for_each_tag_ref(int (*fn)(const char *path, const unsigned char *sha1))
+int for_each_tag_ref(each_ref_fn fn, void *cb_data)
 {
-	return do_for_each_ref("refs/tags/", fn, 10);
+	return do_for_each_ref("refs/tags/", fn, 10, cb_data);
 }
 
-int for_each_branch_ref(int (*fn)(const char *path, const unsigned char *sha1))
+int for_each_branch_ref(each_ref_fn fn, void *cb_data)
 {
-	return do_for_each_ref("refs/heads/", fn, 11);
+	return do_for_each_ref("refs/heads/", fn, 11, cb_data);
 }
 
-int for_each_remote_ref(int (*fn)(const char *path, const unsigned char *sha1))
+int for_each_remote_ref(each_ref_fn fn, void *cb_data)
 {
-	return do_for_each_ref("refs/remotes/", fn, 13);
+	return do_for_each_ref("refs/remotes/", fn, 13, cb_data);
 }
 
+/* NEEDSWORK: This is only used by ssh-upload and it should go; the
+ * caller should do resolve_ref or read_ref like everybody else.  Or
+ * maybe everybody else should use get_ref_sha1() instead of doing
+ * read_ref().
+ */
 int get_ref_sha1(const char *ref, unsigned char *sha1)
 {
 	if (check_ref_format(ref))
diff --git a/refs.h b/refs.h
index af347e6..886c857 100644
--- a/refs.h
+++ b/refs.h
@@ -14,11 +14,12 @@ struct ref_lock {
  * Calls the specified function for each ref file until it returns nonzero,
  * and returns the value
  */
-extern int head_ref(int (*fn)(const char *path, const unsigned char *sha1));
-extern int for_each_ref(int (*fn)(const char *path, const unsigned char *sha1));
-extern int for_each_tag_ref(int (*fn)(const char *path, const unsigned char *sha1));
-extern int for_each_branch_ref(int (*fn)(const char *path, const unsigned char *sha1));
-extern int for_each_remote_ref(int (*fn)(const char *path, const unsigned char *sha1));
+typedef int each_ref_fn(const char *refname, const unsigned char *sha1, void *cb_data);
+extern int head_ref(each_ref_fn, void *);
+extern int for_each_ref(each_ref_fn, void *);
+extern int for_each_tag_ref(each_ref_fn, void *);
+extern int for_each_branch_ref(each_ref_fn, void *);
+extern int for_each_remote_ref(each_ref_fn, void *);
 
 /** Reads the refs file specified into sha1 **/
 extern int get_ref_sha1(const char *ref, unsigned char *sha1);
diff --git a/revision.c b/revision.c
index 6a2539b..0e84b8a 100644
--- a/revision.c
+++ b/revision.c
@@ -466,7 +466,7 @@ static void limit_list(struct rev_info *
 static int all_flags;
 static struct rev_info *all_revs;
 
-static int handle_one_ref(const char *path, const unsigned char *sha1)
+static int handle_one_ref(const char *path, const unsigned char *sha1, void *cb_data)
 {
 	struct object *object = get_reference(all_revs, path, sha1, all_flags);
 	add_pending_object(all_revs, object, "");
@@ -477,7 +477,7 @@ static void handle_all(struct rev_info *
 {
 	all_revs = revs;
 	all_flags = flags;
-	for_each_ref(handle_one_ref);
+	for_each_ref(handle_one_ref, NULL);
 }
 
 static int add_parents_only(struct rev_info *revs, const char *arg, int flags)
diff --git a/send-pack.c b/send-pack.c
index 5bb123a..ee13093 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -215,7 +215,7 @@ static int ref_newer(const unsigned char
 static struct ref *local_refs, **local_tail;
 static struct ref *remote_refs, **remote_tail;
 
-static int one_local_ref(const char *refname, const unsigned char *sha1)
+static int one_local_ref(const char *refname, const unsigned char *sha1, void *cb_data)
 {
 	struct ref *ref;
 	int len = strlen(refname) + 1;
@@ -230,7 +230,7 @@ static int one_local_ref(const char *ref
 static void get_local_heads(void)
 {
 	local_tail = &local_refs;
-	for_each_ref(one_local_ref);
+	for_each_ref(one_local_ref, NULL);
 }
 
 static int receive_status(int in)
diff --git a/server-info.c b/server-info.c
index 2fb8f57..7667b41 100644
--- a/server-info.c
+++ b/server-info.c
@@ -7,7 +7,7 @@ #include "tag.h"
 /* refs */
 static FILE *info_ref_fp;
 
-static int add_info_ref(const char *path, const unsigned char *sha1)
+static int add_info_ref(const char *path, const unsigned char *sha1, void *cb_data)
 {
 	struct object *o = parse_object(sha1);
 
@@ -34,7 +34,7 @@ static int update_info_refs(int force)
 	info_ref_fp = fopen(path1, "w");
 	if (!info_ref_fp)
 		return error("unable to update %s", path0);
-	for_each_ref(add_info_ref);
+	for_each_ref(add_info_ref, NULL);
 	fclose(info_ref_fp);
 	rename(path1, path0);
 	free(path0);
diff --git a/upload-pack.c b/upload-pack.c
index 189b239..10237eb 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -416,7 +416,7 @@ static void receive_needs(void)
 	}
 }
 
-static int send_ref(const char *refname, const unsigned char *sha1)
+static int send_ref(const char *refname, const unsigned char *sha1, void *cb_data)
 {
 	static const char *capabilities = "multi_ack thin-pack side-band side-band-64k";
 	struct object *o = parse_object(sha1);
@@ -444,8 +444,8 @@ static int send_ref(const char *refname,
 static void upload_pack(void)
 {
 	reset_timeout();
-	head_ref(send_ref);
-	for_each_ref(send_ref);
+	head_ref(send_ref, NULL);
+	for_each_ref(send_ref, NULL);
 	packet_flush(1);
 	receive_needs();
 	if (want_obj.nr) {
-- 
1.4.2.1.g4dc7
