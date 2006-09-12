From: Linus Torvalds <torvalds@osdl.org>
Subject: Make ref resolution saner
Date: Mon, 11 Sep 2006 20:17:35 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0609112010340.27779@g5.osdl.org>
References: <Pine.LNX.4.64.0609111158390.3960@g5.osdl.org>
 <Pine.LNX.4.64.0609111632050.27779@g5.osdl.org> <Pine.LNX.4.64.0609112008500.27779@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 12 05:17:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GMymV-0000FO-6e
	for gcvg-git@gmane.org; Tue, 12 Sep 2006 05:17:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751255AbWILDRo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Sep 2006 23:17:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751273AbWILDRo
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Sep 2006 23:17:44 -0400
Received: from smtp.osdl.org ([65.172.181.4]:38358 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751255AbWILDRn (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Sep 2006 23:17:43 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k8C3HanW012510
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 11 Sep 2006 20:17:36 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k8C3HZ8O005993;
	Mon, 11 Sep 2006 20:17:35 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <Pine.LNX.4.64.0609112008500.27779@g5.osdl.org>
X-Spam-Status: No, hits=-0.52 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.148 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26879>


The old code used to totally mix up the notion of a ref-name and the path 
that that ref was associated with.  That was not only horribly ugly (a 
number of users got the path, and then wanted to try to turn it back into 
a ref-name again), but it fundamnetally doesn't work at all once we do any 
setup where a ref doesn't have a 1:1 relationship with a particular 
pathname.

This fixes things up so that we use the ref-name throughout, and only
turn it into a pathname once we actually look it up in the filesystem.
That makes a lot of things much clearer and more straightforward.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---

This patch is a bit scary, but look at the first two hunks to 
builtin-fmt-merge-msg.c to get an idea of what kind of *crap* it gets rid 
of.

There were several places where we used "resolve_ref()" to figure out what 
the branch it was on, but then to actually figure out what the branch-name 
of that branch was (rather than the cwd-relative _filename_ is), it then 
did strange things with the string length of the original ref compared 
with the string length of the _filename_ of the original ref etc etc.

Making all the ref-related functions just use the ref-name itself 
throughout just gets rid of the crap, but more importantly, it's 
absolutely required for just about _any_ ref-packing scheme.

That said, it _is_ a scary patch. It removes more lines that it adds:

 builtin-fmt-merge-msg.c |    7 +----
 builtin-init-db.c       |    4 +--
 builtin-show-branch.c   |   46 +++++++++++++------------------
 builtin-symbolic-ref.c  |   14 +++-------
 cache.h                 |    4 +--
 refs.c                  |   69 +++++++++++++++++++++++++----------------------
 sha1_name.c             |   14 +++++-----
 7 files changed, 74 insertions(+), 84 deletions(-)

but if I missed some place where we used a ref as a pathname, or added one 
"git_path()" translation too many, it results in problems.

The good news is that our test-suite for this seems to be reasonably 
complete. It sure caught a lot of places I had missed the first time 
around. So this should be ok.

I'd _really_ like for this to go in, even regardless of the other patches 
I have sent (although I think it depends on them in mostly fairly trivial 
ways, since the previous patches changed how we do the recursive 
readdir() on the refs/ directory).

It's really needed.


diff --git a/builtin-fmt-merge-msg.c b/builtin-fmt-merge-msg.c
index c407c03..b93c17c 100644
--- a/builtin-fmt-merge-msg.c
+++ b/builtin-fmt-merge-msg.c
@@ -249,7 +249,7 @@ int cmd_fmt_merge_msg(int argc, const ch
 	FILE *in = stdin;
 	const char *sep = "";
 	unsigned char head_sha1[20];
-	const char *head, *current_branch;
+	const char *current_branch;
 
 	git_config(fmt_merge_msg_config);
 
@@ -277,10 +277,7 @@ int cmd_fmt_merge_msg(int argc, const ch
 		usage(fmt_merge_msg_usage);
 
 	/* get current branch */
-	head = xstrdup(git_path("HEAD"));
-	current_branch = resolve_ref(head, head_sha1, 1);
-	current_branch += strlen(head) - 4;
-	free((char *)head);
+	current_branch = resolve_ref("HEAD", head_sha1, 1);
 	if (!strncmp(current_branch, "refs/heads/", 11))
 		current_branch += 11;
 
diff --git a/builtin-init-db.c b/builtin-init-db.c
index 5085018..23b7714 100644
--- a/builtin-init-db.c
+++ b/builtin-init-db.c
@@ -218,8 +218,8 @@ static void create_default_files(const c
 	 * branch, if it does not exist yet.
 	 */
 	strcpy(path + len, "HEAD");
-	if (read_ref(path, sha1) < 0) {
-		if (create_symref(path, "refs/heads/master") < 0)
+	if (read_ref("HEAD", sha1) < 0) {
+		if (create_symref("HEAD", "refs/heads/master") < 0)
 			exit(1);
 	}
 
diff --git a/builtin-show-branch.c b/builtin-show-branch.c
index 578c9fa..4d8db0c 100644
--- a/builtin-show-branch.c
+++ b/builtin-show-branch.c
@@ -437,21 +437,13 @@ static void snarf_refs(int head, int tag
 	}
 }
 
-static int rev_is_head(char *head_path, int headlen, char *name,
+static int rev_is_head(char *head, int headlen, char *name,
 		       unsigned char *head_sha1, unsigned char *sha1)
 {
-	int namelen;
-	if ((!head_path[0]) ||
+	if ((!head[0]) ||
 	    (head_sha1 && sha1 && hashcmp(head_sha1, sha1)))
 		return 0;
-	namelen = strlen(name);
-	if ((headlen < namelen) ||
-	    memcmp(head_path + headlen - namelen, name, namelen))
-		return 0;
-	if (headlen == namelen ||
-	    head_path[headlen - namelen - 1] == '/')
-		return 1;
-	return 0;
+	return !strcmp(head, name);
 }
 
 static int show_merge_base(struct commit_list *seen, int num_rev)
@@ -559,9 +551,9 @@ int cmd_show_branch(int ac, const char *
 	int all_heads = 0, all_tags = 0;
 	int all_mask, all_revs;
 	int lifo = 1;
-	char head_path[128];
-	const char *head_path_p;
-	int head_path_len;
+	char head[128];
+	const char *head_p;
+	int head_len;
 	unsigned char head_sha1[20];
 	int merge_base = 0;
 	int independent = 0;
@@ -638,31 +630,31 @@ int cmd_show_branch(int ac, const char *
 		ac--; av++;
 	}
 
-	head_path_p = resolve_ref(git_path("HEAD"), head_sha1, 1);
-	if (head_path_p) {
-		head_path_len = strlen(head_path_p);
-		memcpy(head_path, head_path_p, head_path_len + 1);
+	head_p = resolve_ref("HEAD", head_sha1, 1);
+	if (head_p) {
+		head_len = strlen(head_p);
+		memcpy(head, head_p, head_len + 1);
 	}
 	else {
-		head_path_len = 0;
-		head_path[0] = 0;
+		head_len = 0;
+		head[0] = 0;
 	}
 
-	if (with_current_branch && head_path_p) {
+	if (with_current_branch && head_p) {
 		int has_head = 0;
 		for (i = 0; !has_head && i < ref_name_cnt; i++) {
 			/* We are only interested in adding the branch
 			 * HEAD points at.
 			 */
-			if (rev_is_head(head_path,
-					head_path_len,
+			if (rev_is_head(head,
+					head_len,
 					ref_name[i],
 					head_sha1, NULL))
 				has_head++;
 		}
 		if (!has_head) {
-			int pfxlen = strlen(git_path("refs/heads/"));
-			append_one_rev(head_path + pfxlen);
+			int pfxlen = strlen("refs/heads/");
+			append_one_rev(head + pfxlen);
 		}
 	}
 
@@ -713,8 +705,8 @@ int cmd_show_branch(int ac, const char *
 	if (1 < num_rev || extra < 0) {
 		for (i = 0; i < num_rev; i++) {
 			int j;
-			int is_head = rev_is_head(head_path,
-						  head_path_len,
+			int is_head = rev_is_head(head,
+						  head_len,
 						  ref_name[i],
 						  head_sha1,
 						  rev[i]->object.sha1);
diff --git a/builtin-symbolic-ref.c b/builtin-symbolic-ref.c
index 1d3a5e2..6f18db8 100644
--- a/builtin-symbolic-ref.c
+++ b/builtin-symbolic-ref.c
@@ -7,15 +7,11 @@ static const char git_symbolic_ref_usage
 static void check_symref(const char *HEAD)
 {
 	unsigned char sha1[20];
-	const char *git_HEAD = xstrdup(git_path("%s", HEAD));
-	const char *git_refs_heads_master = resolve_ref(git_HEAD, sha1, 0);
-	if (git_refs_heads_master) {
-		/* we want to strip the .git/ part */
-		int pfxlen = strlen(git_HEAD) - strlen(HEAD);
-		puts(git_refs_heads_master + pfxlen);
-	}
-	else
+	const char *refs_heads_master = resolve_ref("HEAD", sha1, 0);
+
+	if (!refs_heads_master)
 		die("No such ref: %s", HEAD);
+	puts(refs_heads_master);
 }
 
 int cmd_symbolic_ref(int argc, const char **argv, const char *prefix)
@@ -26,7 +22,7 @@ int cmd_symbolic_ref(int argc, const cha
 		check_symref(argv[1]);
 		break;
 	case 3:
-		create_symref(xstrdup(git_path("%s", argv[1])), argv[2]);
+		create_symref(argv[1], argv[2]);
 		break;
 	default:
 		usage(git_symbolic_ref_usage);
diff --git a/cache.h b/cache.h
index a53204f..5d6c7ee 100644
--- a/cache.h
+++ b/cache.h
@@ -287,8 +287,8 @@ extern int get_sha1_hex(const char *hex,
 extern char *sha1_to_hex(const unsigned char *sha1);	/* static buffer result! */
 extern int read_ref(const char *filename, unsigned char *sha1);
 extern const char *resolve_ref(const char *path, unsigned char *sha1, int);
-extern int create_symref(const char *git_HEAD, const char *refs_heads_master);
-extern int validate_symref(const char *git_HEAD);
+extern int create_symref(const char *ref, const char *refs_heads_master);
+extern int validate_symref(const char *ref);
 
 extern int base_name_compare(const char *name1, int len1, int mode1, const char *name2, int len2, int mode2);
 extern int cache_name_compare(const char *name1, int len1, const char *name2, int len2);
diff --git a/refs.c b/refs.c
index 72e2283..50c25d3 100644
--- a/refs.c
+++ b/refs.c
@@ -93,11 +93,11 @@ static struct ref_list *get_ref_dir(cons
 	if (dir) {
 		struct dirent *de;
 		int baselen = strlen(base);
-		char *path = xmalloc(baselen + 257);
+		char *ref = xmalloc(baselen + 257);
 
-		memcpy(path, base, baselen);
+		memcpy(ref, base, baselen);
 		if (baselen && base[baselen-1] != '/')
-			path[baselen++] = '/';
+			ref[baselen++] = '/';
 
 		while ((de = readdir(dir)) != NULL) {
 			unsigned char sha1[20];
@@ -111,20 +111,20 @@ static struct ref_list *get_ref_dir(cons
 				continue;
 			if (has_extension(de->d_name, ".lock"))
 				continue;
-			memcpy(path + baselen, de->d_name, namelen+1);
-			if (stat(git_path("%s", path), &st) < 0)
+			memcpy(ref + baselen, de->d_name, namelen+1);
+			if (stat(git_path("%s", ref), &st) < 0)
 				continue;
 			if (S_ISDIR(st.st_mode)) {
-				list = get_ref_dir(path, list);
+				list = get_ref_dir(ref, list);
 				continue;
 			}
-			if (read_ref(git_path("%s", path), sha1) < 0) {
-				error("%s points nowhere!", path);
+			if (read_ref(ref, sha1) < 0) {
+				error("%s points nowhere!", ref);
 				continue;
 			}
-			list = add_ref(path, sha1, list);
+			list = add_ref(ref, sha1, list);
 		}
-		free(path);
+		free(ref);
 		closedir(dir);
 	}
 	return list;
@@ -145,12 +145,14 @@ static struct ref_list *get_loose_refs(v
 /* We allow "recursive" symbolic refs. Only within reason, though */
 #define MAXDEPTH 5
 
-const char *resolve_ref(const char *path, unsigned char *sha1, int reading)
+const char *resolve_ref(const char *ref, unsigned char *sha1, int reading)
 {
 	int depth = MAXDEPTH, len;
 	char buffer[256];
+	static char ref_buffer[256];
 
 	for (;;) {
+		const char *path = git_path("%s", ref);
 		struct stat st;
 		char *buf;
 		int fd;
@@ -169,14 +171,16 @@ const char *resolve_ref(const char *path
 			if (reading || errno != ENOENT)
 				return NULL;
 			hashclr(sha1);
-			return path;
+			return ref;
 		}
 
 		/* Follow "normalized" - ie "refs/.." symlinks by hand */
 		if (S_ISLNK(st.st_mode)) {
 			len = readlink(path, buffer, sizeof(buffer)-1);
 			if (len >= 5 && !memcmp("refs/", buffer, 5)) {
-				path = git_path("%.*s", len, buffer);
+				buffer[len] = 0;
+				strcpy(ref_buffer, buffer);
+				ref = ref_buffer;
 				continue;
 			}
 		}
@@ -201,19 +205,22 @@ const char *resolve_ref(const char *path
 		while (len && isspace(*buf))
 			buf++, len--;
 		while (len && isspace(buf[len-1]))
-			buf[--len] = 0;
-		path = git_path("%.*s", len, buf);
+			len--;
+		buf[len] = 0;
+		memcpy(ref_buffer, buf, len + 1);
+		ref = ref_buffer;
 	}
 	if (len < 40 || get_sha1_hex(buffer, sha1))
 		return NULL;
-	return path;
+	return ref;
 }
 
-int create_symref(const char *git_HEAD, const char *refs_heads_master)
+int create_symref(const char *ref_target, const char *refs_heads_master)
 {
 	const char *lockpath;
 	char ref[1000];
 	int fd, len, written;
+	const char *git_HEAD = git_path("%s", ref_target);
 
 #ifndef NO_SYMLINK_HEAD
 	if (prefer_symlink_refs) {
@@ -251,9 +258,9 @@ #endif
 	return 0;
 }
 
-int read_ref(const char *filename, unsigned char *sha1)
+int read_ref(const char *ref, unsigned char *sha1)
 {
-	if (resolve_ref(filename, sha1, 1))
+	if (resolve_ref(ref, sha1, 1))
 		return 0;
 	return -1;
 }
@@ -306,7 +313,7 @@ static int do_for_each_ref(const char *b
 int head_ref(int (*fn)(const char *path, const unsigned char *sha1))
 {
 	unsigned char sha1[20];
-	if (!read_ref(git_path("HEAD"), sha1))
+	if (!read_ref("HEAD", sha1))
 		return fn("HEAD", sha1);
 	return 0;
 }
@@ -335,7 +342,7 @@ int get_ref_sha1(const char *ref, unsign
 {
 	if (check_ref_format(ref))
 		return -1;
-	return read_ref(git_path("refs/%s", ref), sha1);
+	return read_ref(mkpath("refs/%s", ref), sha1);
 }
 
 /*
@@ -416,31 +423,30 @@ static struct ref_lock *verify_lock(stru
 	return lock;
 }
 
-static struct ref_lock *lock_ref_sha1_basic(const char *path,
+static struct ref_lock *lock_ref_sha1_basic(const char *ref,
 	int plen,
 	const unsigned char *old_sha1, int mustexist)
 {
-	const char *orig_path = path;
+	const char *orig_ref = ref;
 	struct ref_lock *lock;
 	struct stat st;
 
 	lock = xcalloc(1, sizeof(struct ref_lock));
 	lock->lock_fd = -1;
 
-	plen = strlen(path) - plen;
-	path = resolve_ref(path, lock->old_sha1, mustexist);
-	if (!path) {
+	ref = resolve_ref(ref, lock->old_sha1, mustexist);
+	if (!ref) {
 		int last_errno = errno;
 		error("unable to resolve reference %s: %s",
-			orig_path, strerror(errno));
+			orig_ref, strerror(errno));
 		unlock_ref(lock);
 		errno = last_errno;
 		return NULL;
 	}
 	lock->lk = xcalloc(1, sizeof(struct lock_file));
 
-	lock->ref_file = xstrdup(path);
-	lock->log_file = xstrdup(git_path("logs/%s", lock->ref_file + plen));
+	lock->ref_file = xstrdup(git_path("%s", ref));
+	lock->log_file = xstrdup(git_path("logs/%s", ref));
 	lock->force_write = lstat(lock->ref_file, &st) && errno == ENOENT;
 
 	if (safe_create_leading_directories(lock->ref_file))
@@ -455,15 +461,14 @@ struct ref_lock *lock_ref_sha1(const cha
 {
 	if (check_ref_format(ref))
 		return NULL;
-	return lock_ref_sha1_basic(git_path("refs/%s", ref),
+	return lock_ref_sha1_basic(mkpath("refs/%s", ref),
 		5 + strlen(ref), old_sha1, mustexist);
 }
 
 struct ref_lock *lock_any_ref_for_update(const char *ref,
 	const unsigned char *old_sha1, int mustexist)
 {
-	return lock_ref_sha1_basic(git_path("%s", ref),
-		strlen(ref), old_sha1, mustexist);
+	return lock_ref_sha1_basic(ref, strlen(ref), old_sha1, mustexist);
 }
 
 void unlock_ref(struct ref_lock *lock)
diff --git a/sha1_name.c b/sha1_name.c
index 1fbc443..b497528 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -247,8 +247,8 @@ static int get_sha1_basic(const char *st
 		NULL
 	};
 	static const char *warning = "warning: refname '%.*s' is ambiguous.\n";
-	const char **p, *pathname;
-	char *real_path = NULL;
+	const char **p, *ref;
+	char *real_ref = NULL;
 	int refs_found = 0, am;
 	unsigned long at_time = (unsigned long)-1;
 	unsigned char *this_result;
@@ -276,10 +276,10 @@ static int get_sha1_basic(const char *st
 
 	for (p = fmt; *p; p++) {
 		this_result = refs_found ? sha1_from_ref : sha1;
-		pathname = resolve_ref(git_path(*p, len, str), this_result, 1);
-		if (pathname) {
+		ref = resolve_ref(mkpath(*p, len, str), this_result, 1);
+		if (ref) {
 			if (!refs_found++)
-				real_path = xstrdup(pathname);
+				real_ref = xstrdup(ref);
 			if (!warn_ambiguous_refs)
 				break;
 		}
@@ -293,12 +293,12 @@ static int get_sha1_basic(const char *st
 
 	if (at_time != (unsigned long)-1) {
 		read_ref_at(
-			real_path + strlen(git_path(".")) - 1,
+			real_ref,
 			at_time,
 			sha1);
 	}
 
-	free(real_path);
+	free(real_ref);
 	return 0;
 }
 
