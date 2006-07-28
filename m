From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] Allow fetching from multiple repositories at once
Date: Fri, 28 Jul 2006 07:44:21 +0200
Message-ID: <20060728054341.15864.35862.stgit@machine>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, alp@atoker.com
X-From: git-owner@vger.kernel.org Fri Jul 28 07:44:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G6L9B-0007iA-7S
	for gcvg-git@gmane.org; Fri, 28 Jul 2006 07:44:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751976AbWG1Fo0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 28 Jul 2006 01:44:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751978AbWG1FoZ
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Jul 2006 01:44:25 -0400
Received: from w241.dkm.cz ([62.24.88.241]:3290 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751976AbWG1FoZ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Jul 2006 01:44:25 -0400
Received: (qmail 15902 invoked by uid 2001); 28 Jul 2006 07:44:21 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
User-Agent: StGIT/0.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24366>

This patch enables fetching multiple repositories at once over the Git
protocol (and SSH, and locally if git-fetch-pack is your cup of coffee
there). This is done especially for the xorg people who have tons of
repositories and dislike pulls much slower than they were used to with CVS.
I'm eager to hear how this affects the situation.

It's kind of "superproject" thing, basically, taking reverse approach than
the subproject ideas. However, in practice I think it can be used for
subprojects quite well and perhaps if I find some spare time during the day
I will add the lightweight subproject support to Cogito, using this.

So, you need some kind of porcelain for this. The idea is that instead of
telling git-fetch-pack a single repository, you pass multiple --repo=
parameters and refs always "belong" to the latest mentioned repository;
when outputting the new ref values, the appropriate repo is mentioned near
each ref. In order for this to be useful, on your local side you should
share the objects database in some way - either using alternates (then
you must fetch to an object database reachable from everywhere) or symlinked
object databases.

You still need to pass git-fetch-pack some URL in addition to the
repositories - it is used only for git_connect(), the purpose is that
repositories must be local directories so if you want to talk remote, you
need to do something like

	git-fetch-pack git://kernel.org/pub/scm/git/git.git --repo=/pub/scm/git/git.git master next --repo=/pub/scm/cogito/cogito.git master

The implementation is, well... rather hackish to say the least. :-)
We can do something nicer if it turns out to be a boost huge enough
in reality too.

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 cache.h       |    7 ++++--
 connect.c     |   11 ++++++---
 daemon.c      |    9 +++++---
 fetch-pack.c  |   58 +++++++++++++++++++++++++++++++++----------------
 path.c        |    5 ++++
 peek-remote.c |    4 ++-
 send-pack.c   |    4 ++-
 sha1_file.c   |    6 +++--
 upload-pack.c |   68 +++++++++++++++++++++++++++++++++++++++++++++++++--------
 9 files changed, 127 insertions(+), 45 deletions(-)

diff --git a/cache.h b/cache.h
index 457d1d0..ea2f5e8 100644
--- a/cache.h
+++ b/cache.h
@@ -225,6 +225,7 @@ int git_config_perm(const char *var, con
 int adjust_shared_perm(const char *path);
 int safe_create_leading_directories(char *path);
 char *enter_repo(char *path, int strict);
+int security_repo_check(int export_all_trees);
 
 /* Read and unpack a sha1 file into memory, write memory to a sha1 file */
 extern int sha1_object_info(const unsigned char *, char *, unsigned long *);
@@ -298,6 +299,7 @@ extern struct alternate_object_database 
 	char base[FLEX_ARRAY]; /* more */
 } *alt_odb_list;
 extern void prepare_alt_odb(void);
+extern int link_alt_odb_entry(const char * entry, int len, const char * relative_base, int depth, int allow_self);
 
 extern struct packed_git {
 	struct packed_git *next;
@@ -325,6 +327,7 @@ struct ref {
 	unsigned char new_sha1[20];
 	unsigned char force;
 	struct ref *peer_ref; /* when renaming */
+	char *repo; /* when doing multi-repo operations */
 	char name[FLEX_ARRAY]; /* more */
 };
 
@@ -334,11 +337,11 @@ #define REF_TAGS	(1u << 2)
 
 extern int git_connect(int fd[2], char *url, const char *prog);
 extern int finish_connect(pid_t pid);
-extern int path_match(const char *path, int nr, char **match);
+extern int path_match(const char *path, const char *repo, int nr, char **match, char **match_repo);
 extern int match_refs(struct ref *src, struct ref *dst, struct ref ***dst_tail,
 		      int nr_refspec, char **refspec, int all);
 extern int get_ack(int fd, unsigned char *result_sha1);
-extern struct ref **get_remote_heads(int in, struct ref **list, int nr_match, char **match, unsigned int flags);
+extern struct ref **get_remote_heads(int in, struct ref **list, int nr_match, char **match, char *repo, unsigned int flags);
 extern int server_supports(const char *feature);
 
 extern struct packed_git *parse_pack_index(unsigned char *sha1);
diff --git a/connect.c b/connect.c
index 4422a0d..63f095c 100644
--- a/connect.c
+++ b/connect.c
@@ -45,9 +45,8 @@ static int check_ref(const char *name, i
  */
 struct ref **get_remote_heads(int in, struct ref **list,
 			      int nr_match, char **match,
-			      unsigned int flags)
+			      char *repo, unsigned int flags)
 {
-	*list = NULL;
 	for (;;) {
 		struct ref *ref;
 		unsigned char old_sha1[20];
@@ -74,11 +73,12 @@ struct ref **get_remote_heads(int in, st
 
 		if (!check_ref(name, name_len, flags))
 			continue;
-		if (nr_match && !path_match(name, nr_match, match))
+		if (nr_match && !path_match(name, NULL, nr_match, match, NULL))
 			continue;
 		ref = xcalloc(1, sizeof(*ref) + len - 40);
 		memcpy(ref->old_sha1, old_sha1, 20);
 		memcpy(ref->name, buffer + 41, len - 40);
+		ref->repo = repo;
 		*list = ref;
 		list = &ref->next;
 	}
@@ -112,7 +112,8 @@ int get_ack(int fd, unsigned char *resul
 	die("git-fetch_pack: expected ACK/NAK, got '%s'", line);
 }
 
-int path_match(const char *path, int nr, char **match)
+int path_match(const char *path, const char *repo, int nr, char **match,
+               char **match_repo)
 {
 	int i;
 	int pathlen = strlen(path);
@@ -121,6 +122,8 @@ int path_match(const char *path, int nr,
 		char *s = match[i];
 		int len = strlen(s);
 
+		if (match_repo && repo != match_repo[i])
+			continue;
 		if (!len || len > pathlen)
 			continue;
 		if (memcmp(path + pathlen - len, s, len))
diff --git a/daemon.c b/daemon.c
index e4ec676..179f2fe 100644
--- a/daemon.c
+++ b/daemon.c
@@ -233,6 +233,7 @@ static int upload(char *dir)
 {
 	/* Timeout as string */
 	char timeout_buf[64];
+	char checkexport_buf[64];
 	const char *path;
 
 	loginfo("Request for '%s'", dir);
@@ -250,8 +251,7 @@ static int upload(char *dir)
 	 * path_ok() uses enter_repo() and does whitelist checking.
 	 * We only need to make sure the repository is exported.
 	 */
-
-	if (!export_all_trees && access("git-daemon-export-ok", F_OK)) {
+	if (!security_repo_check(export_all_trees)) {
 		logerror("'%s': repository not exported.", path);
 		errno = EACCES;
 		return -1;
@@ -265,8 +265,11 @@ static int upload(char *dir)
 
 	snprintf(timeout_buf, sizeof timeout_buf, "--timeout=%u", timeout);
 
+	strcpy(checkexport_buf, "--check-export");
+	if (export_all_trees) checkexport_buf[1] = '\0'; /* XXX */
+
 	/* git-upload-pack only ever reads stuff, so this is safe */
-	execl_git_cmd("upload-pack", "--strict", timeout_buf, ".", NULL);
+	execl_git_cmd("upload-pack", "--strict", timeout_buf, checkexport_buf, ".", NULL);
 	return -1;
 }
 
diff --git a/fetch-pack.c b/fetch-pack.c
index b7824db..2b02d0f 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -281,7 +281,8 @@ static void mark_recent_complete_commits
 	}
 }
 
-static void filter_refs(struct ref **refs, int nr_match, char **match)
+static void filter_refs(struct ref **refs, int nr_match, char **match,
+                        char **match_repo)
 {
 	struct ref **return_refs;
 	struct ref *newlist = NULL;
@@ -312,7 +313,7 @@ static void filter_refs(struct ref **ref
 			continue;
 		}
 		else {
-			int order = path_match(ref->name, nr_match, match);
+			int order = path_match(ref->name, ref->repo, nr_match, match, match_repo);
 			if (order) {
 				return_refs[order-1] = ref;
 				continue; /* we will link it later */
@@ -337,7 +338,8 @@ static void filter_refs(struct ref **ref
 	*refs = newlist;
 }
 
-static int everything_local(struct ref **refs, int nr_match, char **match)
+static int everything_local(struct ref **refs, int nr_match, char **match,
+                            char **match_repo)
 {
 	struct ref *ref;
 	int retval;
@@ -386,7 +388,7 @@ static int everything_local(struct ref *
 		}
 	}
 
-	filter_refs(refs, nr_match, match);
+	filter_refs(refs, nr_match, match, match_repo);
 
 	for (retval = 1, ref = *refs; ref ; ref = ref->next) {
 		const unsigned char *remote = ref->old_sha1;
@@ -414,13 +416,15 @@ static int everything_local(struct ref *
 	return retval;
 }
 
-static int fetch_pack(int fd[2], int nr_match, char **match)
+static int fetch_pack(int fd[2], int nr_repo, char **repo,
+                      int nr_match, char **match, char **match_repo)
 {
-	struct ref *ref;
+	struct ref *ref = NULL, **refn;
 	unsigned char sha1[20];
 	int status;
+	int i;
 
-	get_remote_heads(fd[0], &ref, 0, NULL, 0);
+	refn = get_remote_heads(fd[0], &ref, 0, NULL, nr_repo ? repo[0] : NULL, 0);
 	if (server_supports("multi_ack")) {
 		if (verbose)
 			fprintf(stderr, "Server supports multi_ack\n");
@@ -431,11 +435,19 @@ static int fetch_pack(int fd[2], int nr_
 			fprintf(stderr, "Server supports side-band\n");
 		use_sideband = 1;
 	}
+	if (!server_supports("switch-repo") && nr_repo > 1)
+		die("server does not support fetching multiple repositories at once");
+
+	for (i = 1; i < nr_repo; i++) {
+		packet_write(fd[1], "switch-repo %s", repo[i]);
+		refn = get_remote_heads(fd[0], refn, 0, NULL, repo[i], 0);
+	}
+
 	if (!ref) {
 		packet_flush(fd[1]);
 		die("no matching remote head");
 	}
-	if (everything_local(&ref, nr_match, match)) {
+	if (everything_local(&ref, nr_match, match, match_repo)) {
 		packet_flush(fd[1]);
 		goto all_done;
 	}
@@ -456,8 +468,9 @@ static int fetch_pack(int fd[2], int nr_
 
  all_done:
 	while (ref) {
-		printf("%s %s\n",
-		       sha1_to_hex(ref->old_sha1), ref->name);
+		printf("%s %s%s%s\n",
+		       sha1_to_hex(ref->old_sha1), ref->name,
+		       ref->repo ? " " : "", ref->repo ? : "");
 		ref = ref->next;
 	}
 	return 0;
@@ -465,15 +478,16 @@ static int fetch_pack(int fd[2], int nr_
 
 int main(int argc, char **argv)
 {
-	int i, ret, nr_heads;
-	char *dest = NULL, **heads;
+	int i, ret, nr_repo = 0, nr_heads = 0;
+	char *dest = NULL;
+	char **repo = xmalloc(argc * sizeof(*repo));
+	char **heads = xmalloc(argc * sizeof(*heads));
+	char **heads_repo = xmalloc(argc * sizeof(*heads_repo));
 	int fd[2];
 	pid_t pid;
 
 	setup_git_directory();
 
-	nr_heads = 0;
-	heads = NULL;
 	for (i = 1; i < argc; i++) {
 		char *arg = argv[i];
 
@@ -498,16 +512,22 @@ int main(int argc, char **argv)
 				fetch_all = 1;
 				continue;
 			}
+			if (!strncmp("--repo=", arg, 7)) {
+				repo[nr_repo++] = arg + 7;
+				continue;
+			}
 			if (!strcmp("-v", arg)) {
 				verbose = 1;
 				continue;
 			}
 			usage(fetch_pack_usage);
 		}
-		dest = arg;
-		heads = argv + i + 1;
-		nr_heads = argc - i - 1;
-		break;
+		if (!dest) {
+			dest = arg;
+			continue;
+		}
+		heads_repo[nr_heads] = nr_repo ? repo[nr_repo - 1] : NULL;
+		heads[nr_heads++] = arg;
 	}
 	if (!dest)
 		usage(fetch_pack_usage);
@@ -516,7 +536,7 @@ int main(int argc, char **argv)
 	pid = git_connect(fd, dest, exec);
 	if (pid < 0)
 		return 1;
-	ret = fetch_pack(fd, nr_heads, heads);
+	ret = fetch_pack(fd, nr_repo, repo, nr_heads, heads, heads_repo);
 	close(fd[0]);
 	close(fd[1]);
 	finish_connect(pid);
diff --git a/path.c b/path.c
index db8905f..3021164 100644
--- a/path.c
+++ b/path.c
@@ -243,6 +243,11 @@ char *enter_repo(char *path, int strict)
 	return NULL;
 }
 
+int security_repo_check(int export_all_trees)
+{
+	return (export_all_trees || access("git-daemon-export-ok", F_OK));
+}
+
 int adjust_shared_perm(const char *path)
 {
 	struct stat st;
diff --git a/peek-remote.c b/peek-remote.c
index 2b30980..7d8ae3c 100644
--- a/peek-remote.c
+++ b/peek-remote.c
@@ -9,9 +9,9 @@ static const char *exec = "git-upload-pa
 
 static int peek_remote(int fd[2], unsigned flags)
 {
-	struct ref *ref;
+	struct ref *ref = NULL;
 
-	get_remote_heads(fd[0], &ref, 0, NULL, flags);
+	get_remote_heads(fd[0], &ref, 0, NULL, NULL, flags);
 	packet_flush(fd[1]);
 
 	while (ref) {
diff --git a/send-pack.c b/send-pack.c
index 10bc8bc..24c47c9 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -232,14 +232,14 @@ static int receive_status(int in)
 
 static int send_pack(int in, int out, int nr_refspec, char **refspec)
 {
-	struct ref *ref;
+	struct ref *ref = NULL;
 	int new_refs;
 	int ret = 0;
 	int ask_for_status_report = 0;
 	int expect_status_report = 0;
 
 	/* No funny business with the matcher */
-	remote_tail = get_remote_heads(in, &remote_refs, 0, NULL, REF_NORMAL);
+	remote_tail = get_remote_heads(in, &remote_refs, 0, NULL, NULL, REF_NORMAL);
 	get_local_heads();
 
 	/* Does the other end support the reporting? */
diff --git a/sha1_file.c b/sha1_file.c
index 8f279d8..1ca39e1 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -229,7 +229,7 @@ static void read_info_alternates(const c
  * SHA1, an extra slash for the first level indirection, and the
  * terminating NUL.
  */
-static int link_alt_odb_entry(const char * entry, int len, const char * relative_base, int depth)
+int link_alt_odb_entry(const char * entry, int len, const char * relative_base, int depth, int allow_self)
 {
 	struct stat st;
 	const char *objdir = get_object_directory();
@@ -279,7 +279,7 @@ static int link_alt_odb_entry(const char
 			return -1;
 		}
 	}
-	if (!memcmp(ent->base, objdir, pfxlen)) {
+	if (!allow_self && !memcmp(ent->base, objdir, pfxlen)) {
 		free(ent);
 		return -1;
 	}
@@ -325,7 +325,7 @@ static void link_alt_odb_entries(const c
 						relative_base, last);
 			} else {
 				link_alt_odb_entry(last, cp - last,
-						relative_base, depth);
+						relative_base, depth, 0);
 			}
 		}
 		while (cp < ep && *cp == sep)
diff --git a/upload-pack.c b/upload-pack.c
index bbd6bd6..3440978 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -9,7 +9,7 @@ #include "object.h"
 #include "commit.h"
 #include "exec_cmd.h"
 
-static const char upload_pack_usage[] = "git-upload-pack [--strict] [--timeout=nn] <dir>";
+static const char upload_pack_usage[] = "git-upload-pack [--strict] [--timeout=nn] [--check-export] <dir>";
 
 #define THEY_HAVE (1U << 0)
 #define OUR_REF (1U << 1)
@@ -20,6 +20,8 @@ static struct object_array have_obj;
 static struct object_array want_obj;
 static unsigned int timeout = 0;
 static int use_sideband = 0;
+static int check_export = 0;
+static int strict = 0;
 
 static void reset_timeout(void)
 {
@@ -392,7 +394,7 @@ static int get_common_commits(void)
 	}
 }
 
-static void receive_needs(void)
+static char *receive_needs(void)
 {
 	static char line[1000];
 	int len;
@@ -403,8 +405,10 @@ static void receive_needs(void)
 		len = packet_read_line(0, line, sizeof(line));
 		reset_timeout();
 		if (!len)
-			return;
+			return NULL;
 
+		if (!strncmp("switch-repo ", line, 12))
+			return line+12;
 		if (strncmp("want ", line, 5) ||
 		    get_sha1_hex(line+5, sha1_buf))
 			die("git-upload-pack: protocol error, "
@@ -436,7 +440,7 @@ static void receive_needs(void)
 
 static int send_ref(const char *refname, const unsigned char *sha1)
 {
-	static const char *capabilities = "multi_ack thin-pack side-band";
+	static const char *capabilities = "multi_ack thin-pack side-band switch-repo";
 	struct object *o = parse_object(sha1);
 
 	if (!o)
@@ -461,11 +465,52 @@ static int send_ref(const char *refname,
 
 static int upload_pack(void)
 {
-	reset_timeout();
-	head_ref(send_ref);
-	for_each_ref(send_ref);
-	packet_flush(1);
-	receive_needs();
+	int multirepo = 0;
+
+	while (1) {
+		char *repo;
+		char cwd[PATH_MAX];
+
+		reset_timeout();
+		head_ref(send_ref);
+		for_each_ref(send_ref);
+		packet_flush(1);
+		repo = receive_needs();
+		if (!repo)
+			break;
+		multirepo++;
+
+		fprintf(stderr, "git-upload-pack: switching to repo %s", repo);
+
+		/* So that we still find objects of the original repository... */
+		getcwd(cwd, PATH_MAX);
+		if (strlen(cwd) < PATH_MAX - 8)
+			strcat(cwd, "/objects");
+		link_alt_odb_entry(cwd, strlen(cwd), NULL, 0, 1);
+
+		if (!enter_repo(repo, strict) || !security_repo_check(!check_export))
+			die("git-upload-pack: security violation");
+	}
+
+	if (multirepo) {
+#define ALTENV_SIZE 65536
+		/* Propagate all the repositories to the children */
+		char altenv[ALTENV_SIZE], *p = altenv;
+		struct alternate_object_database *alt;
+		strcpy(p, ALTERNATE_DB_ENVIRONMENT "=");
+		p += sizeof(ALTERNATE_DB_ENVIRONMENT);
+		for (alt = alt_odb_list; alt; alt = alt->next) {
+			strncpy(p, alt->base, alt->name - alt->base);
+			p += alt->name - alt->base;
+			if (p - altenv < ALTENV_SIZE)
+				*p++ = ':';
+			if (p - altenv >= ALTENV_SIZE)
+				die("fetching too many repositories");
+		}
+		p[-1] = '\0';
+		putenv(altenv);
+	}
+
 	if (!want_obj.nr)
 		return 0;
 	get_common_commits();
@@ -477,7 +522,6 @@ int main(int argc, char **argv)
 {
 	char *dir;
 	int i;
-	int strict = 0;
 
 	for (i = 1; i < argc; i++) {
 		char *arg = argv[i];
@@ -492,6 +536,10 @@ int main(int argc, char **argv)
 			timeout = atoi(arg+10);
 			continue;
 		}
+		if (!strcmp(arg, "--check-export")) {
+			check_export = 1;
+			continue;
+		}
 		if (!strcmp(arg, "--")) {
 			i++;
 			break;
