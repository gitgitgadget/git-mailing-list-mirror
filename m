From: Petr Baudis <pasky@suse.cz>
Subject: [RFC][RESEND][PATCH] Allow fetching from multiple repositories at once
Date: Sat, 23 Sep 2006 18:45:09 +0200
Message-ID: <20060923164308.16334.49252.stgit@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 23 18:45:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GRAdM-0001bS-B1
	for gcvg-git@gmane.org; Sat, 23 Sep 2006 18:45:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751292AbWIWQpP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Sep 2006 12:45:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751299AbWIWQpO
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Sep 2006 12:45:14 -0400
Received: from w241.dkm.cz ([62.24.88.241]:21431 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751292AbWIWQpM (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Sep 2006 12:45:12 -0400
Received: (qmail 16535 invoked by uid 2001); 23 Sep 2006 18:45:09 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
User-Agent: StGIT/0.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27598>

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

The main target of this are the Xorg people who have plenty of small repos
and frequently want to update many of them. It would be nice if someone
from Xorg reading this and concerned with this could measure the
difference.

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 This is an even more awful hack than the previous version, because of
did_refs. I wonder how ugly would it be to have that in stock Git
version, or if there's a good way to eliminate that hack before
proceeding with full libification.

 This is a second resend. The first one was from the end of July but
flyed by with not much of a response.

 cache.h       |    7 ++++-
 connect.c     |   11 +++++---
 daemon.c      |    9 +++++--
 fetch-pack.c  |   58 ++++++++++++++++++++++++++++++---------------
 path.c        |    5 ++++
 peek-remote.c |    4 ++-
 refs.c        |    6 ++---
 send-pack.c   |    4 ++-
 sha1_file.c   |    6 ++---
 upload-pack.c |   74 +++++++++++++++++++++++++++++++++++++++++++++++++--------
 10 files changed, 136 insertions(+), 48 deletions(-)

diff --git a/cache.h b/cache.h
index a7f673d..59cf0ed 100644
--- a/cache.h
+++ b/cache.h
@@ -240,6 +240,7 @@ int git_config_perm(const char *var, con
 int adjust_shared_perm(const char *path);
 int safe_create_leading_directories(char *path);
 char *enter_repo(char *path, int strict);
+int security_repo_check(int export_all_trees);
 
 /* Read and unpack a sha1 file into memory, write memory to a sha1 file */
 extern int sha1_object_info(const unsigned char *, char *, unsigned long *);
@@ -332,6 +333,7 @@ extern struct alternate_object_database 
 	char base[FLEX_ARRAY]; /* more */
 } *alt_odb_list;
 extern void prepare_alt_odb(void);
+extern int link_alt_odb_entry(const char * entry, int len, const char * relative_base, int depth, int allow_self);
 
 extern struct packed_git {
 	struct packed_git *next;
@@ -359,6 +361,7 @@ struct ref {
 	unsigned char new_sha1[20];
 	unsigned char force;
 	struct ref *peer_ref; /* when renaming */
+	char *repo; /* when doing multi-repo operations */
 	char name[FLEX_ARRAY]; /* more */
 };
 
@@ -368,11 +371,11 @@ #define REF_TAGS	(1u << 2)
 
 extern pid_t git_connect(int fd[2], char *url, const char *prog);
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
index c55a20a..0b62406 100644
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
 		hashcpy(ref->old_sha1, old_sha1);
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
index eb4f3f1..d0b44b2 100644
--- a/daemon.c
+++ b/daemon.c
@@ -321,8 +321,7 @@ static int run_service(struct interp *it
 	 * path_ok() uses enter_repo() and does whitelist checking.
 	 * We only need to make sure the repository is exported.
 	 */
-
-	if (!export_all_trees && access("git-daemon-export-ok", F_OK)) {
+	if (!security_repo_check(export_all_trees)) {
 		logerror("'%s': repository not exported.", path);
 		errno = EACCES;
 		return -1;
@@ -355,11 +354,15 @@ static int upload_pack(void)
 {
 	/* Timeout as string */
 	char timeout_buf[64];
+	char checkexport_buf[64];
 
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
index 99ac08b..edbdf19 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -282,7 +282,8 @@ static void mark_recent_complete_commits
 	}
 }
 
-static void filter_refs(struct ref **refs, int nr_match, char **match)
+static void filter_refs(struct ref **refs, int nr_match, char **match,
+                        char **match_repo)
 {
 	struct ref **return_refs;
 	struct ref *newlist = NULL;
@@ -313,7 +314,7 @@ static void filter_refs(struct ref **ref
 			continue;
 		}
 		else {
-			int order = path_match(ref->name, nr_match, match);
+			int order = path_match(ref->name, ref->repo, nr_match, match, match_repo);
 			if (order) {
 				return_refs[order-1] = ref;
 				continue; /* we will link it later */
@@ -338,7 +339,8 @@ static void filter_refs(struct ref **ref
 	*refs = newlist;
 }
 
-static int everything_local(struct ref **refs, int nr_match, char **match)
+static int everything_local(struct ref **refs, int nr_match, char **match,
+                            char **match_repo)
 {
 	struct ref *ref;
 	int retval;
@@ -387,7 +389,7 @@ static int everything_local(struct ref *
 		}
 	}
 
-	filter_refs(refs, nr_match, match);
+	filter_refs(refs, nr_match, match, match_repo);
 
 	for (retval = 1, ref = *refs; ref ; ref = ref->next) {
 		const unsigned char *remote = ref->old_sha1;
@@ -415,13 +417,15 @@ static int everything_local(struct ref *
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
@@ -437,11 +441,19 @@ static int fetch_pack(int fd[2], int nr_
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
@@ -462,8 +474,9 @@ static int fetch_pack(int fd[2], int nr_
 
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
@@ -471,15 +484,16 @@ static int fetch_pack(int fd[2], int nr_
 
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
 
@@ -504,16 +518,22 @@ int main(int argc, char **argv)
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
@@ -522,7 +542,7 @@ int main(int argc, char **argv)
 	pid = git_connect(fd, dest, exec);
 	if (pid < 0)
 		return 1;
-	ret = fetch_pack(fd, nr_heads, heads);
+	ret = fetch_pack(fd, nr_repo, repo, nr_heads, heads, heads_repo);
 	close(fd[0]);
 	close(fd[1]);
 	ret |= finish_connect(pid);
diff --git a/path.c b/path.c
index bb89fb0..d669cac 100644
--- a/path.c
+++ b/path.c
@@ -251,6 +251,11 @@ char *enter_repo(char *path, int strict)
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
index 353da00..2cf9e50 100644
--- a/peek-remote.c
+++ b/peek-remote.c
@@ -8,9 +8,9 @@ static const char *exec = "git-upload-pa
 
 static int peek_remote(int fd[2], unsigned flags)
 {
-	struct ref *ref;
+	struct ref *ref = NULL;
 
-	get_remote_heads(fd[0], &ref, 0, NULL, flags);
+	get_remote_heads(fd[0], &ref, 0, NULL, NULL, flags);
 	packet_flush(fd[1]);
 
 	while (ref) {
diff --git a/refs.c b/refs.c
index 9b3986a..10e588e 100644
--- a/refs.c
+++ b/refs.c
@@ -144,12 +144,12 @@ nextitem:;
 	return list;
 }
 
+int did_read_loose_refs = 0;
 static struct ref_list *get_loose_refs(void)
 {
-	static int did_refs = 0;
 	static struct ref_list *refs = NULL;
 
-	if (!did_refs) {
+	if (!did_read_loose_refs) {
 		/* We need to make sure refs/heads and refs/tags always
 		 * go before everything else. */
 		char *except[] = {"refs/heads", "refs/tags", NULL};
@@ -167,7 +167,7 @@ static struct ref_list *get_loose_refs(v
 			refs = other_refs;
 		}
 
-		did_refs = 1;
+		did_read_loose_refs = 1;
 	}
 	return refs;
 }
diff --git a/send-pack.c b/send-pack.c
index fbd792c..e1cf58b 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -266,14 +266,14 @@ static int receive_status(int in)
 
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
index 27b1ebb..14f06c9 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -235,7 +235,7 @@ static void read_info_alternates(const c
  * SHA1, an extra slash for the first level indirection, and the
  * terminating NUL.
  */
-static int link_alt_odb_entry(const char * entry, int len, const char * relative_base, int depth)
+int link_alt_odb_entry(const char * entry, int len, const char * relative_base, int depth, int allow_self)
 {
 	struct stat st;
 	const char *objdir = get_object_directory();
@@ -285,7 +285,7 @@ static int link_alt_odb_entry(const char
 			return -1;
 		}
 	}
-	if (!memcmp(ent->base, objdir, pfxlen)) {
+	if (!allow_self && !memcmp(ent->base, objdir, pfxlen)) {
 		free(ent);
 		return -1;
 	}
@@ -331,7 +331,7 @@ static void link_alt_odb_entries(const c
 						relative_base, last);
 			} else {
 				link_alt_odb_entry(last, cp - last,
-						relative_base, depth);
+						relative_base, depth, 0);
 			}
 		}
 		while (cp < ep && *cp == sep)
diff --git a/upload-pack.c b/upload-pack.c
index 4e53edd..57ae127 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -10,7 +10,7 @@ #include "object.h"
 #include "commit.h"
 #include "exec_cmd.h"
 
-static const char upload_pack_usage[] = "git-upload-pack [--strict] [--timeout=nn] <dir>";
+static const char upload_pack_usage[] = "git-upload-pack [--strict] [--timeout=nn] [--check-export] <dir>";
 
 /* bits #0..7 in revision.h, #8..10 in commit.c */
 #define THEY_HAVE	(1u << 11)
@@ -30,6 +30,8 @@ static unsigned int timeout;
  * otherwise maximum packet size (up to 65520 bytes).
  */
 static int use_sideband;
+static int check_export;
+static int strict;
 
 static void reset_timeout(void)
 {
@@ -455,7 +457,7 @@ static int get_common_commits(void)
 	}
 }
 
-static void receive_needs(void)
+static char *receive_needs(void)
 {
 	static char line[1000];
 	int len;
@@ -466,8 +468,10 @@ static void receive_needs(void)
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
@@ -501,7 +505,7 @@ static void receive_needs(void)
 
 static int send_ref(const char *refname, const unsigned char *sha1, int flag, void *cb_data)
 {
-	static const char *capabilities = "multi_ack thin-pack side-band side-band-64k";
+	static const char *capabilities = "multi_ack thin-pack side-band side-band-64k switch-repo";
 	struct object *o = parse_object(sha1);
 
 	if (!o)
@@ -524,13 +528,60 @@ static int send_ref(const char *refname,
 	return 0;
 }
 
+extern int did_read_loose_refs;
 static void upload_pack(void)
 {
-	reset_timeout();
-	head_ref(send_ref, NULL);
-	for_each_ref(send_ref, NULL);
-	packet_flush(1);
-	receive_needs();
+	int multirepo = 0;
+
+	while (1) {
+		char *repo;
+		char cwd[PATH_MAX];
+
+		reset_timeout();
+		head_ref(send_ref, NULL);
+		for_each_ref(send_ref, NULL);
+		packet_flush(1);
+		repo = receive_needs();
+		if (!repo)
+			/* This is where we go most of the time, unless this is
+			 * a multirepo fetch */
+			break;
+		multirepo++;
+
+		fprintf(stderr, "git-upload-pack: switching to repo %s\n", repo);
+
+		/* So that we still find objects of the original repository... */
+		getcwd(cwd, PATH_MAX);
+		if (strlen(cwd) < PATH_MAX - 8)
+			strcat(cwd, "/objects");
+		link_alt_odb_entry(cwd, strlen(cwd), NULL, 0, 1);
+
+		if (!enter_repo(repo, strict) || !security_repo_check(!check_export))
+			die("git-upload-pack: security violation");
+		/* This is a hack and a memory leak. If you are seeing this
+		 * in a stock Git version, someone did a horrible mistake. */
+		did_read_loose_refs = 0;
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
 	if (want_obj.nr) {
 		get_common_commits();
 		create_pack_file();
@@ -541,7 +592,6 @@ int main(int argc, char **argv)
 {
 	char *dir;
 	int i;
-	int strict = 0;
 
 	for (i = 1; i < argc; i++) {
 		char *arg = argv[i];
@@ -556,6 +606,10 @@ int main(int argc, char **argv)
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
