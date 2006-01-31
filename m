From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Shallow clone: low level machinery.
Date: Tue, 31 Jan 2006 03:02:37 -0800
Message-ID: <7vmzhc1wz6.fsf_-_@assigned-by-dhcp.cox.net>
References: <7voe1uchet.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0601301220420.6424@wbgn013.biozentrum.uni-wuerzburg.de>
	<7v8xsxa70o.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 31 12:02:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F3tHZ-0004tR-0S
	for gcvg-git@gmane.org; Tue, 31 Jan 2006 12:02:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750749AbWAaLCm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 Jan 2006 06:02:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750750AbWAaLCm
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jan 2006 06:02:42 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:29405 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1750749AbWAaLCl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jan 2006 06:02:41 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060131110126.OWUM20875.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 31 Jan 2006 06:01:26 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <7v8xsxa70o.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Mon, 30 Jan 2006 10:46:15 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15308>

This adds --shallow=refname option to git-clone-pack, and
extends upload-pack protocol with "shallow" extension.

An example:

	$ mkdir junk && cd junk && git init-db
	$ git clone-pack --shallow=refs/heads/master ../git.git master

This creates a very shallow clone of my repository.  It says
"pretend refs/heads/master commit is the beginning of time, and
clone your master branch".  As before, clone-pack with explicit
head name outputs the commit object name and refname to the
standard output instead of creating the branch.  The command
creates a .git/info/grafts file to cauterize the history at that
commit as well.

I think upload-pack side is more or less ready to be debugged,
but the client side is highly experimental.  It has quite
serious limitations and is more of a proof of correctness at the
protocol extension level than for practical use:

 - Currently it can take only one ---shallow option.

 - It has to be spelled in full (refs/heads/master, not
   "master").

 - It has to be included as part of explicit refname list.

 - There is no matching --shallow in git-fetch-pack.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 cache.h       |    9 +++
 clone-pack.c  |   69 ++++++++++++++++++++++-
 commit-tree.c |    5 --
 commit.c      |  174 +++++++++++++++++++++++++++++++++++++++------------------
 commit.h      |   14 +++++
 connect.c     |   24 ++++++++
 object.c      |    7 ++
 object.h      |    2 +
 upload-pack.c |   94 +++++++++++++++++++++++++++++--
 9 files changed, 331 insertions(+), 67 deletions(-)

75f1f4871277f403991c771eb642bdbd6fe82021
diff --git a/cache.h b/cache.h
index bdbe2d6..18d4cdb 100644
--- a/cache.h
+++ b/cache.h
@@ -111,11 +111,18 @@ static inline unsigned int create_ce_mod
 extern struct cache_entry **active_cache;
 extern unsigned int active_nr, active_alloc, active_cache_changed;
 
+/*
+ * Having more than two parents is not strange at all, and this is
+ * how multi-way merges are represented.
+ */
+#define MAXPARENT (16)
+
 #define GIT_DIR_ENVIRONMENT "GIT_DIR"
 #define DEFAULT_GIT_DIR_ENVIRONMENT ".git"
 #define DB_ENVIRONMENT "GIT_OBJECT_DIRECTORY"
 #define INDEX_ENVIRONMENT "GIT_INDEX_FILE"
 #define GRAFT_ENVIRONMENT "GIT_GRAFT_FILE"
+#define GRAFT_INFO_ENVIRONMENT "GIT_GRAFT_INFO"
 
 extern char *get_git_dir(void);
 extern char *get_object_directory(void);
@@ -296,6 +303,8 @@ struct ref {
 	char name[FLEX_ARRAY]; /* more */
 };
 
+extern void send_graft_info(int);
+
 extern int git_connect(int fd[2], char *url, const char *prog);
 extern int finish_connect(pid_t pid);
 extern int path_match(const char *path, int nr, char **match);
diff --git a/clone-pack.c b/clone-pack.c
index f634431..c1708d5 100644
--- a/clone-pack.c
+++ b/clone-pack.c
@@ -1,15 +1,76 @@
 #include "cache.h"
 #include "refs.h"
 #include "pkt-line.h"
+#include "commit.h"
 
 static const char clone_pack_usage[] =
-"git-clone-pack [--exec=<git-upload-pack>] [<host>:]<directory> [<heads>]*";
+"git-clone-pack [--shallow=name] [--exec=<git-upload-pack>] [<host>:]<directory> [<heads>]*";
 static const char *exec = "git-upload-pack";
+static char *shallow = NULL;
+
+static void shallow_exchange(int fd[2], struct ref *ref)
+{
+	char line[1024];
+	char *graft_file;
+	FILE *fp;
+	int i, j;
+
+	while (ref) {
+		if (!strcmp(ref->name, shallow))
+			break;
+		ref = ref->next;
+	}
+	if (!ref)
+		die("No matching ref specified for shallow clone %s",
+		    shallow);
+	if (!server_supports("shallow"))
+		die("The other end does not support shallow clone");
+	packet_write(fd[1], "shallow\n");
+	packet_flush(fd[1]);
+
+	/* Read their graft */
+	prepare_commit_graft();
+	for (;;) {
+		int len;
+		len = packet_read_line(fd[0], line, sizeof(line));
+		if (!len)
+			break;
+		add_graft_info(line);
+	}
+	/* And cauterize at --shallow=<sha1> */
+	sprintf(line, "%s\n", sha1_to_hex(ref->old_sha1));
+	add_graft_info(line);
+
+	/* tell ours */
+	packet_write(fd[1], "custom\n");
+	send_graft_info(fd[1]);
+	packet_flush(fd[1]);
+
+	/* write out ours */
+	graft_file = get_graft_file();
+	fp = fopen(graft_file, "w");
+	if (!fp)
+		die("cannot update grafts!");
+
+	for (i = 0; i < commit_graft_nr; i++) {
+		struct commit_graft *g = commit_graft[i];
+		fputs(sha1_to_hex(g->sha1), fp);
+		for (j = 0; j < g->nr_parent; j++) {
+			fputc(' ', fp);
+			fputs(sha1_to_hex(g->parent[j]), fp);
+		}
+		fputc('\n', fp);
+	}
+	fclose(fp);
+}
 
 static void clone_handshake(int fd[2], struct ref *ref)
 {
 	unsigned char sha1[20];
 
+	if (shallow)
+		shallow_exchange(fd, ref);
+
 	while (ref) {
 		packet_write(fd[1], "want %s\n", sha1_to_hex(ref->old_sha1));
 		ref = ref->next;
@@ -160,6 +221,10 @@ int main(int argc, char **argv)
 				exec = arg + 7;
 				continue;
 			}
+			if (!strncmp("--shallow=", arg, 10)) {
+				shallow = arg + 10;
+				continue;
+			}
 			usage(clone_pack_usage);
 		}
 		dest = arg;
@@ -167,6 +232,8 @@ int main(int argc, char **argv)
 		nr_heads = argc - i - 1;
 		break;
 	}
+	if (shallow && !nr_heads)
+		die("shallow clone needs an explicit head name");
 	if (!dest)
 		usage(clone_pack_usage);
 	pid = git_connect(fd, dest, exec);
diff --git a/commit-tree.c b/commit-tree.c
index 4634b50..cbf2979 100644
--- a/commit-tree.c
+++ b/commit-tree.c
@@ -53,11 +53,6 @@ static void check_valid(unsigned char *s
 	free(buf);
 }
 
-/*
- * Having more than two parents is not strange at all, and this is
- * how multi-way merges are represented.
- */
-#define MAXPARENT (16)
 static unsigned char parent_sha1[MAXPARENT][20];
 
 static const char commit_tree_usage[] = "git-commit-tree <sha1> [-p <sha1>]* < changelog";
diff --git a/commit.c b/commit.c
index 97205bf..a862287 100644
--- a/commit.c
+++ b/commit.c
@@ -102,12 +102,8 @@ static unsigned long parse_commit_date(c
 	return date;
 }
 
-static struct commit_graft {
-	unsigned char sha1[20];
-	int nr_parent;
-	unsigned char parent[0][20]; /* more */
-} **commit_graft;
-static int commit_graft_alloc, commit_graft_nr;
+struct commit_graft **commit_graft;
+int commit_graft_alloc, commit_graft_nr;
 
 static int commit_graft_pos(const unsigned char *sha1)
 {
@@ -128,62 +124,104 @@ static int commit_graft_pos(const unsign
 	return -lo - 1;
 }
 
-static void prepare_commit_graft(void)
+int add_graft_info(char *buf)
 {
-	char *graft_file = get_graft_file();
-	FILE *fp = fopen(graft_file, "r");
+	/* The format is just "Commit Parent1 Parent2 ...\n" */
+	int len = strlen(buf);
+	int i;
+	struct commit_graft *graft = NULL;
+
+	if (buf[len-1] == '\n')
+		buf[--len] = 0;
+	if (buf[0] == '#')
+		return 0;
+	if ((len + 1) % 41) {
+	bad_graft_data:
+		error("bad graft data: %s", buf);
+		free(graft);
+		return -1;
+	}
+	i = (len + 1) / 41 - 1;
+	graft = xmalloc(sizeof(*graft) + 20 * i);
+	graft->nr_parent = i;
+	if (get_sha1_hex(buf, graft->sha1))
+		goto bad_graft_data;
+	for (i = 40; i < len; i += 41) {
+		if (buf[i] != ' ')
+			goto bad_graft_data;
+		if (get_sha1_hex(buf + i + 1, graft->parent[i/41]))
+			goto bad_graft_data;
+	}
+	i = commit_graft_pos(graft->sha1);
+	if (0 <= i) {
+		free(commit_graft[i]);
+		commit_graft[i] = graft;
+		return 0;
+	}
+	i = -i - 1;
+	if (commit_graft_alloc <= ++commit_graft_nr) {
+		commit_graft_alloc = alloc_nr(commit_graft_alloc);
+		commit_graft = xrealloc(commit_graft,
+					sizeof(*commit_graft) *
+					commit_graft_alloc);
+	}
+	if (i < commit_graft_nr)
+		memmove(commit_graft + i + 1,
+			commit_graft + i,
+			(commit_graft_nr - i - 1) *
+			sizeof(*commit_graft));
+	commit_graft[i] = graft;
+	return 0;
+}
+
+void clear_commit_graft(void)
+{
+	int i;
+	for (i = 0; i < commit_graft_nr; i++)
+		free(commit_graft[i]);
+	free(commit_graft);
+	commit_graft_nr = commit_graft_alloc = 0;
+	commit_graft = NULL;
+}
+
+void prepare_commit_graft(void)
+{
+	char *graft_file;
+	FILE *fp;
 	char buf[1024];
+
+	if (getenv(GRAFT_INFO_ENVIRONMENT)) {
+		char *cp, *ep;
+		for (cp = getenv(GRAFT_INFO_ENVIRONMENT);
+		     *cp;
+		     cp = ep) {
+			int more = 0;
+			ep = strchr(cp, '\n');
+			if (ep) {
+				more = 1;
+				*ep = '\0';
+			}
+			else {
+				ep = cp + strlen(cp);
+			}
+			if (ep != cp)
+				add_graft_info(cp);
+			if (!more)
+				break;
+			*ep = '\n';
+			ep++;
+		}
+		return;
+	}
+	graft_file = get_graft_file();
+	fp = fopen(graft_file, "r");
 	if (!fp) {
-		commit_graft = (struct commit_graft **) "hack";
+		commit_graft = (struct commit_graft **) xmalloc(1);
 		return;
 	}
-	while (fgets(buf, sizeof(buf), fp)) {
-		/* The format is just "Commit Parent1 Parent2 ...\n" */
-		int len = strlen(buf);
-		int i;
-		struct commit_graft *graft = NULL;
+	while (fgets(buf, sizeof(buf), fp))
+		add_graft_info(buf);
 
-		if (buf[len-1] == '\n')
-			buf[--len] = 0;
-		if (buf[0] == '#')
-			continue;
-		if ((len + 1) % 41) {
-		bad_graft_data:
-			error("bad graft data: %s", buf);
-			free(graft);
-			continue;
-		}
-		i = (len + 1) / 41 - 1;
-		graft = xmalloc(sizeof(*graft) + 20 * i);
-		graft->nr_parent = i;
-		if (get_sha1_hex(buf, graft->sha1))
-			goto bad_graft_data;
-		for (i = 40; i < len; i += 41) {
-			if (buf[i] != ' ')
-				goto bad_graft_data;
-			if (get_sha1_hex(buf + i + 1, graft->parent[i/41]))
-				goto bad_graft_data;
-		}
-		i = commit_graft_pos(graft->sha1);
-		if (0 <= i) {
-			error("duplicate graft data: %s", buf);
-			free(graft);
-			continue;
-		}
-		i = -i - 1;
-		if (commit_graft_alloc <= ++commit_graft_nr) {
-			commit_graft_alloc = alloc_nr(commit_graft_alloc);
-			commit_graft = xrealloc(commit_graft,
-						sizeof(*commit_graft) *
-						commit_graft_alloc);
-		}
-		if (i < commit_graft_nr)
-			memmove(commit_graft + i + 1,
-				commit_graft + i,
-				(commit_graft_nr - i - 1) *
-				sizeof(*commit_graft));
-		commit_graft[i] = graft;
-	}
 	fclose(fp);
 }
 
@@ -288,6 +326,30 @@ int parse_commit(struct commit *item)
 	return ret;
 }
 
+static void reparse_commit_parents(struct object *o)
+{
+	struct commit *c;
+	struct commit_list *parents;
+	if ((o->type != commit_type) || !o->parsed)
+		return;
+	c = (struct commit *)o;
+	parents = c->parents;
+	o->parsed = 0;
+	while (parents) {
+		struct commit_list *next = parents->next;
+		free(parents);
+		parents = next;
+	}
+	c->parents = NULL;
+	free(c->buffer);
+	c->buffer = NULL;
+}
+
+void reparse_all_parsed_commits(void)
+{
+	for_each_object(reparse_commit_parents);
+}
+
 struct commit_list *commit_list_insert(struct commit *item, struct commit_list **list_p)
 {
 	struct commit_list *new_list = xmalloc(sizeof(struct commit_list));
diff --git a/commit.h b/commit.h
index 986b22d..abc5b9e 100644
--- a/commit.h
+++ b/commit.h
@@ -17,6 +17,20 @@ struct commit {
 	char *buffer;
 };
 
+struct commit_graft {
+	unsigned char sha1[20];
+	int nr_parent;
+	unsigned char parent[0][20]; /* more */
+};
+
+extern struct commit_graft **commit_graft;
+extern int commit_graft_alloc, commit_graft_nr;
+
+extern void prepare_commit_graft(void);
+extern void clear_commit_graft(void);
+extern int add_graft_info(char *);
+extern void reparse_all_parsed_commits(void);
+
 extern int save_commit_buffer;
 extern const char *commit_type;
 
diff --git a/connect.c b/connect.c
index 3f2d65c..046d1da 100644
--- a/connect.c
+++ b/connect.c
@@ -3,6 +3,7 @@
 #include "pkt-line.h"
 #include "quote.h"
 #include "refs.h"
+#include "commit.h"
 #include <sys/wait.h>
 #include <sys/socket.h>
 #include <netinet/in.h>
@@ -298,6 +299,29 @@ int match_refs(struct ref *src, struct r
 	return 0;
 }
 
+void send_graft_info(int outfd)
+{
+	int i, j;
+	char packet_buf[41*MAXPARENT], *buf;
+
+	for (i = 0; i < commit_graft_nr; i++) {
+		struct commit_graft *g = commit_graft[i];
+		buf = packet_buf;
+		memcpy(buf, sha1_to_hex(g->sha1), 40);
+		buf += 40;
+		if (MAXPARENT <= g->nr_parent)
+			die("insanely big octopus graft with %d parents: %s",
+			    g->nr_parent, sha1_to_hex(g->sha1));
+		for (j = 0; j < g->nr_parent; j++) {
+			*buf++ = ' ';
+			memcpy(buf, sha1_to_hex(g->parent[j]), 40);
+			buf += 40;
+		}
+		*buf = 0;
+		packet_write(outfd, "%s\n", packet_buf);
+	}
+}
+
 enum protocol {
 	PROTO_LOCAL = 1,
 	PROTO_SSH,
diff --git a/object.c b/object.c
index 1577f74..bbcfcd8 100644
--- a/object.c
+++ b/object.c
@@ -252,3 +252,10 @@ int object_list_contains(struct object_l
 	}
 	return 0;
 }
+
+void for_each_object(void (*fn)(struct object *))
+{
+	int i;
+	for (i = 0; i < nr_objs; i++)
+		fn(objs[i]);
+}
diff --git a/object.h b/object.h
index 0e76182..b4c9729 100644
--- a/object.h
+++ b/object.h
@@ -55,4 +55,6 @@ unsigned object_list_length(struct objec
 
 int object_list_contains(struct object_list *list, struct object *obj);
 
+void for_each_object(void (*)(struct object *));
+
 #endif /* OBJECT_H */
diff --git a/upload-pack.c b/upload-pack.c
index d198055..90ea549 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -13,11 +13,16 @@ static const char upload_pack_usage[] = 
 #define WANTED (1U << 2)
 #define MAX_HAS 256
 #define MAX_NEEDS 256
-static int nr_has = 0, nr_needs = 0, multi_ack = 0, nr_our_refs = 0;
+#define MAX_PARENTS 20
+static int nr_has = 0, nr_needs = 0, nr_our_refs = 0;
 static unsigned char has_sha1[MAX_HAS][20];
 static unsigned char needs_sha1[MAX_NEEDS][20];
 static unsigned int timeout = 0;
 
+/* protocol extensions */
+static int multi_ack = 0;
+static int using_custom_graft = 0;
+
 static void reset_timeout(void)
 {
 	alarm(timeout);
@@ -163,6 +168,77 @@ static int get_common_commits(void)
 	}
 }
 
+static void exchange_grafts(void)
+{
+	int len;
+	char line[41*MAX_PARENTS];
+
+	/* We heard "shallow"; drop up to the next flush */
+	for (;;) {
+		len = packet_read_line(0, line, sizeof(line));
+		reset_timeout();
+		if (!len)
+			break;
+	}
+
+	/* Send our graft */
+	prepare_commit_graft();
+	send_graft_info(1);
+	packet_flush(1);
+
+	/* For precise common commits discovery, we need to use
+	 * the graft information we received from them.
+	 * But this is expensive, so the downloader first says
+	 * if it wants to use our graft as is.
+	 */
+	len = packet_read_line(0, line, sizeof(line));
+	reset_timeout();
+	if (!len)
+		; /* use ours as is */
+	else if (!strcmp(line, "custom\n")) {
+		using_custom_graft = 1;
+		clear_commit_graft();
+		for (;;) {
+			len = packet_read_line(0, line, sizeof(line));
+			reset_timeout();
+			if (!len)
+				break;
+			if (add_graft_info(line))
+				die("Bad graft line %s", line);
+		}
+		/* And using that, we prepare our end. */
+		reparse_all_parsed_commits();
+	}
+	else
+		die("expected 'custom', got '%s'", line);
+}
+
+static void setup_custom_graft(void)
+{
+	char *graft_env = strdup(GRAFT_INFO_ENVIRONMENT "=");
+	int envlen = strlen(graft_env);
+	int i, j;
+
+	for (i = 0; i < commit_graft_nr; i++) {
+		struct commit_graft *g = commit_graft[i];
+		char buf[41*MAX_PARENTS], *ptr;
+		ptr = buf;
+		memcpy(ptr, sha1_to_hex(g->sha1), 40);
+		ptr += 40;
+		for (j = 0; j < g->nr_parent; j++) {
+			*ptr++ = ' ';
+			memcpy(ptr, sha1_to_hex(g->parent[j]), 40);
+			ptr += 40;
+		}
+		*ptr++ = '\n';
+		*ptr = 0;
+		graft_env = xrealloc(graft_env, envlen + (ptr - buf));
+		memcpy(graft_env + envlen, buf, ptr - buf + 1);
+		envlen += ptr - buf;
+	}
+	putenv(graft_env);
+}
+
 static int receive_needs(void)
 {
 	static char line[1000];
@@ -180,16 +256,22 @@ static int receive_needs(void)
 		sha1_buf = dummy;
 		if (needs == MAX_NEEDS) {
 			fprintf(stderr,
-				"warning: supporting only a max of %d requests. "
+				"warning: supporting only a max of "
+				"%d requests. "
 				"sending everything instead.\n",
 				MAX_NEEDS);
 		}
 		else if (needs < MAX_NEEDS)
 			sha1_buf = needs_sha1[needs];
 
-		if (strncmp("want ", line, 5) || get_sha1_hex(line+5, sha1_buf))
+		if (!strcmp("shallow\n", line)) {
+			exchange_grafts();
+			continue;
+		}
+		if (strncmp("want ", line, 5) ||
+		    get_sha1_hex(line+5, sha1_buf))
 			die("git-upload-pack: protocol error, "
-			    "expected to get sha, not '%s'", line);
+			    "expected to get want-sha1, not '%s'", line);
 		if (strstr(line+45, "multi_ack"))
 			multi_ack = 1;
 
@@ -213,7 +295,7 @@ static int receive_needs(void)
 
 static int send_ref(const char *refname, const unsigned char *sha1)
 {
-	static char *capabilities = "multi_ack";
+	static char *capabilities = "multi_ack shallow";
 	struct object *o = parse_object(sha1);
 
 	if (capabilities)
@@ -243,6 +325,8 @@ static int upload_pack(void)
 	if (!nr_needs)
 		return 0;
 	get_common_commits();
+	if (using_custom_graft)
+		setup_custom_graft();
 	create_pack_file();
 	return 0;
 }
-- 
1.1.6.gefef
