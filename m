From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Teach parse_commit_buffer about grafting.
Date: Sat, 30 Jul 2005 01:00:34 -0700
Message-ID: <7vslxw4tb1.fsf_-_@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0507261136280.19309@g5.osdl.org>
	<1122457238.3027.37.camel@baythorne.infradead.org>
	<Pine.LNX.4.58.0507270819550.3227@g5.osdl.org>
	<1122478870.28128.52.camel@hades.cambridge.redhat.com>
	<Pine.LNX.4.58.0507270846360.3227@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Sat Jul 30 10:00:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DymH2-0001Sk-M1
	for gcvg-git@gmane.org; Sat, 30 Jul 2005 10:00:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263003AbVG3IAi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Jul 2005 04:00:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263007AbVG3IAi
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jul 2005 04:00:38 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:63962 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S263003AbVG3IAg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jul 2005 04:00:36 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050730080028.MZJD12158.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 30 Jul 2005 04:00:28 -0400
To: git@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0507270846360.3227@g5.osdl.org> (Linus Torvalds's message of "Wed, 27 Jul 2005 08:50:27 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Introduce a new file $GIT_DIR/info/grafts (or $GIT_GRAFT_FILE)
which is a list of "fake commit parent records".  Each line of
this file is a commit ID, followed by parent commit IDs, all
40-byte hex SHA1 separated by a single SP in between.  The
records override the parent information we would normally read
from the commit objects, allowing both adding "fake" parents
(i.e. grafting), and pretending as if a commit is not a child of
some of its real parents (i.e. cauterizing).

Bugs are mine, but the credits for the idea and implementation
outline all go to Linus, who kept hinting how this thing should
work.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 cache.h     |    2 +
 commit.c    |  114 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 sha1_file.c |   13 ++++++-
 3 files changed, 127 insertions(+), 2 deletions(-)

0f16b172aa7f0757b2af50ec7be58dc0e23913a6
diff --git a/cache.h b/cache.h
--- a/cache.h
+++ b/cache.h
@@ -127,10 +127,12 @@ extern unsigned int active_nr, active_al
 #define DEFAULT_GIT_DIR_ENVIRONMENT ".git"
 #define DB_ENVIRONMENT "GIT_OBJECT_DIRECTORY"
 #define INDEX_ENVIRONMENT "GIT_INDEX_FILE"
+#define GRAFT_ENVIRONMENT "GIT_GRAFT_FILE"
 
 extern char *get_object_directory(void);
 extern char *get_refs_directory(void);
 extern char *get_index_file(void);
+extern char *get_graft_file(void);
 
 #define ALTERNATE_DB_ENVIRONMENT "GIT_ALTERNATE_OBJECT_DIRECTORIES"
 
diff --git a/commit.c b/commit.c
--- a/commit.c
+++ b/commit.c
@@ -91,11 +91,108 @@ static unsigned long parse_commit_date(c
 	return date;
 }
 
+static struct commit_graft {
+	unsigned char sha1[20];
+	int nr_parent;
+	unsigned char parent[0][20]; /* more */
+} **commit_graft;
+static int commit_graft_alloc, commit_graft_nr;
+
+static int commit_graft_pos(const unsigned char *sha1)
+{
+	int lo, hi;
+	lo = 0;
+	hi = commit_graft_nr;
+	while (lo < hi) {
+		int mi = (lo + hi) / 2;
+		struct commit_graft *graft = commit_graft[mi];
+		int cmp = memcmp(sha1, graft->sha1, 20);
+		if (!cmp)
+			return mi;
+		if (cmp < 0)
+			hi = mi;
+		else
+			lo = mi + 1;
+	}
+	return -lo - 1;
+}
+
+static void prepare_commit_graft(void)
+{
+	char *graft_file = get_graft_file();
+	FILE *fp = fopen(graft_file, "r");
+	char buf[1024];
+	if (!fp) {
+		commit_graft = (struct commit_graft **) "hack";
+		return;
+	}
+	while (fgets(buf, sizeof(buf), fp)) {
+		/* The format is just "Commit Parent1 Parent2 ...\n" */
+		int len = strlen(buf);
+		int i;
+		struct commit_graft *graft = NULL;
+
+		if (buf[len-1] == '\n')
+			buf[--len] = 0;
+		if (buf[0] == '#')
+			continue;
+		if ((len + 1) % 41) {
+		bad_graft_data:
+			error("bad graft data: %s", buf);
+			free(graft);
+			continue;
+		}
+		i = (len + 1) / 41 - 1;
+		graft = xmalloc(sizeof(*graft) + 20 * i);
+		graft->nr_parent = i;
+		if (get_sha1_hex(buf, graft->sha1))
+			goto bad_graft_data;
+		for (i = 40; i < len; i += 41) {
+			if (buf[i] != ' ')
+				goto bad_graft_data;
+			if (get_sha1_hex(buf + i + 1, graft->parent[i/41]))
+				goto bad_graft_data;
+		}
+		i = commit_graft_pos(graft->sha1);
+		if (0 <= i) {
+			error("duplicate graft data: %s", buf);
+			free(graft);
+			continue;
+		}
+		i = -i - 1;
+		if (commit_graft_alloc <= ++commit_graft_nr) {
+			commit_graft_alloc = alloc_nr(commit_graft_alloc);
+			commit_graft = xrealloc(commit_graft,
+						sizeof(*commit_graft) *
+						commit_graft_alloc);
+		}
+		if (i < commit_graft_nr)
+			memmove(commit_graft + i + 1,
+				commit_graft + i,
+				(commit_graft_nr - i - 1) *
+				sizeof(*commit_graft));
+		commit_graft[i] = graft;
+	}
+	fclose(fp);
+}
+
+static struct commit_graft *lookup_commit_graft(const unsigned char *sha1)
+{
+	int pos;
+	if (!commit_graft)
+		prepare_commit_graft();
+	pos = commit_graft_pos(sha1);
+	if (pos < 0)
+		return NULL;
+	return commit_graft[pos];
+}
+
 int parse_commit_buffer(struct commit *item, void *buffer, unsigned long size)
 {
 	char *bufptr = buffer;
 	unsigned char parent[20];
 	struct commit_list **pptr;
+	struct commit_graft *graft;
 
 	if (item->object.parsed)
 		return 0;
@@ -109,17 +206,32 @@ int parse_commit_buffer(struct commit *i
 		add_ref(&item->object, &item->tree->object);
 	bufptr += 46; /* "tree " + "hex sha1" + "\n" */
 	pptr = &item->parents;
+
+	graft = lookup_commit_graft(item->object.sha1);
 	while (!memcmp(bufptr, "parent ", 7)) {
 		struct commit *new_parent;
 
 		if (get_sha1_hex(bufptr + 7, parent) || bufptr[47] != '\n')
 			return error("bad parents in commit %s", sha1_to_hex(item->object.sha1));
+		bufptr += 48;
+		if (graft)
+			continue;
 		new_parent = lookup_commit(parent);
 		if (new_parent) {
 			pptr = &commit_list_insert(new_parent, pptr)->next;
 			add_ref(&item->object, &new_parent->object);
 		}
-		bufptr += 48;
+	}
+	if (graft) {
+		int i;
+		struct commit *new_parent;
+		for (i = 0; i < graft->nr_parent; i++) {
+			new_parent = lookup_commit(graft->parent[i]);
+			if (!new_parent)
+				continue;
+			pptr = &commit_list_insert(new_parent, pptr)->next;
+			add_ref(&item->object, &new_parent->object);
+		}
 	}
 	item->date = parse_commit_date(bufptr);
 	return 0;
diff --git a/sha1_file.c b/sha1_file.c
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -61,7 +61,8 @@ static int get_sha1_file(const char *pat
 	return get_sha1_hex(buffer, result);
 }
 
-static char *git_dir, *git_object_dir, *git_index_file, *git_refs_dir;
+static char *git_dir, *git_object_dir, *git_index_file, *git_refs_dir,
+	*git_graft_file;
 static void setup_git_env(void)
 {
 	git_dir = gitenv(GIT_DIR_ENVIRONMENT);
@@ -79,6 +80,9 @@ static void setup_git_env(void)
 		git_index_file = xmalloc(strlen(git_dir) + 7);
 		sprintf(git_index_file, "%s/index", git_dir);
 	}
+	git_graft_file = gitenv(GRAFT_ENVIRONMENT);
+	if (!git_graft_file)
+		git_graft_file = strdup(git_path("info/grafts"));
 }
 
 char *get_object_directory(void)
@@ -102,6 +106,13 @@ char *get_index_file(void)
 	return git_index_file;
 }
 
+char *get_graft_file(void)
+{
+	if (!git_graft_file)
+		setup_git_env();
+	return git_graft_file;
+}
+
 int safe_create_leading_directories(char *path)
 {
 	char *pos = path;
