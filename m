From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] (preview) Renaming push.
Date: Wed, 03 Aug 2005 22:26:26 -0700
Message-ID: <7vy87i46il.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0508030109210.21304@wgmdd8.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.58.0508030944210.3258@g5.osdl.org>
	<Pine.LNX.4.63.0508031849270.24318@wgmdd8.biozentrum.uni-wuerzburg.de>
	<200508031908.22562.Josef.Weidendorfer@gmx.de>
	<Pine.LNX.4.58.0508031102590.3258@g5.osdl.org>
	<7vek9a8uy9.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0508031641270.3258@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 04 07:27:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E0YFb-00074t-JE
	for gcvg-git@gmane.org; Thu, 04 Aug 2005 07:26:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261716AbVHDF0f (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 4 Aug 2005 01:26:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261796AbVHDF0b
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Aug 2005 01:26:31 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:44794 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S261716AbVHDF03 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2005 01:26:29 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050804052628.WKSZ1367.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 4 Aug 2005 01:26:28 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0508031641270.3258@g5.osdl.org> (Linus Torvalds's
	message of "Wed, 3 Aug 2005 16:48:13 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> In this format, "src" makes sense as a generic sha1_name, and _not_ 
> necessarily limited to a ref-name.
>
> IOW, there's really no reason to not allow
>
> 	git-send-pack .. dest .. <sha1>:dst-ref
>
> where "<sha1>" may be something else than a ref (but a ref obviously ends 
> up being one such thing).
>
> For example, let's say that I've got stuff at the HEAD of my tree that I'm
> not quite ready to push out yet, but I _do_ want to push out the parent of
> the current head. I'd love to be able to just do
>
> 	git-send-pack parent $(git-rev-parse HEAD^):master
>
> and there's no real reason why that syntax shouldn't just work: it's 
> entirely logical to say "I want to push out the parent of my HEAD as 
> 'master' on the other end", and that's _exactly_ what the above says.

While I have not updated the send-pack <src>:<dst> syntax, I
added a horrible hack that some people may love to see.  This
removes the need to use git-rev-parse from many commands.

This is a preview.  I've run the standard test suite and it does
not seem to break anything, but I expect it will stay in "pu"
for a while.

------------
[PATCH] Update get_sha1() to grok extended format.

Everybody envies rev-parse, who is the only one that can grok
the extended sha1 format.  Move the get_extended_sha1() out of
rev-parse, rename it to get_sha1() and make it available to
everybody else.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 Makefile    |    3 +
 rev-parse.c |  188 +-------------------------------------------------
 sha1_file.c |   39 ----------
 sha1_name.c |  222 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 229 insertions(+), 223 deletions(-)
 create mode 100644 sha1_name.c

99ef7de3e234347d2af1ab2129ce99c5876b591b
diff --git a/Makefile b/Makefile
--- a/Makefile
+++ b/Makefile
@@ -95,7 +95,8 @@ LIB_H=cache.h object.h blob.h tree.h com
 	pack.h pkt-line.h refs.h
 LIB_OBJS=read-cache.o sha1_file.o usage.o object.o commit.o tree.o blob.o \
 	 tag.o date.o index.o diff-delta.o patch-delta.o entry.o path.o \
-	 refs.o csum-file.o pack-check.o pkt-line.o connect.o ident.o
+	 refs.o csum-file.o pack-check.o pkt-line.o connect.o ident.o \
+	 sha1_name.o
 
 LIB_H += rev-cache.h
 LIB_OBJS += rev-cache.o
diff --git a/rev-parse.c b/rev-parse.c
--- a/rev-parse.c
+++ b/rev-parse.c
@@ -21,8 +21,6 @@ static int output_sq = 0;
 #define REVERSED 1
 static int show_type = NORMAL;
 
-static int get_extended_sha1(char *name, unsigned char *sha1);
-
 /*
  * Some arguments are relevant "revision" arguments,
  * others are about output format or other details.
@@ -107,182 +105,6 @@ static void show_arg(char *arg)
 		show_norev(arg);
 }
 
-static int get_parent(char *name, unsigned char *result, int idx)
-{
-	unsigned char sha1[20];
-	int ret = get_extended_sha1(name, sha1);
-	struct commit *commit;
-	struct commit_list *p;
-
-	if (ret)
-		return ret;
-	commit = lookup_commit_reference(sha1);
-	if (!commit)
-		return -1;
-	if (parse_commit(commit))
-		return -1;
-	if (!idx) {
-		memcpy(result, commit->object.sha1, 20);
-		return 0;
-	}
-	p = commit->parents;
-	while (p) {
-		if (!--idx) {
-			memcpy(result, p->item->object.sha1, 20);
-			return 0;
-		}
-		p = p->next;
-	}
-	return -1;
-}
-
-static int find_short_object_filename(int len, const char *name, unsigned char *sha1)
-{
-	static char dirname[PATH_MAX];
-	char hex[40];
-	DIR *dir;
-	int found;
-
-	snprintf(dirname, sizeof(dirname), "%s/%.2s", get_object_directory(), name);
-	dir = opendir(dirname);
-	sprintf(hex, "%.2s", name);
-	found = 0;
-	if (dir) {
-		struct dirent *de;
-		while ((de = readdir(dir)) != NULL) {
-			if (strlen(de->d_name) != 38)
-				continue;
-			if (memcmp(de->d_name, name + 2, len-2))
-				continue;
-			memcpy(hex + 2, de->d_name, 38);
-			if (++found > 1)
-				break;
-		}
-		closedir(dir);
-	}
-	if (found == 1)
-		return get_sha1_hex(hex, sha1) == 0;
-	return 0;
-}
-
-static int match_sha(unsigned len, const unsigned char *a, const unsigned char *b)
-{
-	do {
-		if (*a != *b)
-			return 0;
-		a++;
-		b++;
-		len -= 2;
-	} while (len > 1);
-	if (len)
-		if ((*a ^ *b) & 0xf0)
-			return 0;
-	return 1;
-}
-
-static int find_short_packed_object(int len, const unsigned char *match, unsigned char *sha1)
-{
-	struct packed_git *p;
-
-	prepare_packed_git();
-	for (p = packed_git; p; p = p->next) {
-		unsigned num = num_packed_objects(p);
-		unsigned first = 0, last = num;
-		while (first < last) {
-			unsigned mid = (first + last) / 2;
-			unsigned char now[20];
-			int cmp;
-
-			nth_packed_object_sha1(p, mid, now);
-			cmp = memcmp(match, now, 20);
-			if (!cmp) {
-				first = mid;
-				break;
-			}
-			if (cmp > 0) {
-				first = mid+1;
-				continue;
-			}
-			last = mid;
-		}
-		if (first < num) {
-			unsigned char now[20], next[20];
-			nth_packed_object_sha1(p, first, now);
-			if (match_sha(len, match, now)) {
-				if (nth_packed_object_sha1(p, first+1, next) || !match_sha(len, match, next)) {
-					memcpy(sha1, now, 20);
-					return 1;
-				}
-			}
-		}	
-	}
-	return 0;
-}
-
-static int get_short_sha1(char *name, unsigned char *sha1)
-{
-	int i;
-	char canonical[40];
-	unsigned char res[20];
-
-	memset(res, 0, 20);
-	memset(canonical, 'x', 40);
-	for (i = 0;;i++) {
-		unsigned char c = name[i];
-		unsigned char val;
-		if (!c || i > 40)
-			break;
-		if (c >= '0' && c <= '9')
-			val = c - '0';
-		else if (c >= 'a' && c <= 'f')
-			val = c - 'a' + 10;
-		else if (c >= 'A' && c <='F') {
-			val = c - 'A' + 10;
-			c -= 'A' - 'a';
-		}
-		else
-			return -1;
-		canonical[i] = c;
-		if (!(i & 1))
-			val <<= 4;
-		res[i >> 1] |= val;
-	}
-	if (i < 4)
-		return -1;
-	if (find_short_object_filename(i, canonical, sha1))
-		return 0;
-	if (find_short_packed_object(i, res, sha1))
-		return 0;
-	return -1;
-}
-
-/*
- * This is like "get_sha1()", except it allows "sha1 expressions",
- * notably "xyz^" for "parent of xyz"
- */
-static int get_extended_sha1(char *name, unsigned char *sha1)
-{
-	int parent, ret;
-	int len = strlen(name);
-
-	parent = 1;
-	if (len > 2 && name[len-1] >= '0' && name[len-1] <= '9') {
-		parent = name[len-1] - '0';
-		len--;
-	}
-	if (len > 1 && name[len-1] == '^') {
-		name[len-1] = 0;
-		ret = get_parent(name, sha1, parent);
-		name[len-1] = '^';
-		if (!ret)
-			return 0;
-	}
-	ret = get_sha1(name, sha1);
-	if (!ret)
-		return 0;
-	return get_short_sha1(name, sha1);
-}
-
 static void show_default(void)
 {
 	char *s = def;
@@ -291,7 +113,7 @@ static void show_default(void)
 		unsigned char sha1[20];
 
 		def = NULL;
-		if (!get_extended_sha1(s, sha1)) {
+		if (!get_sha1(s, sha1)) {
 			show_rev(NORMAL, sha1);
 			return;
 		}
@@ -372,10 +194,10 @@ int main(int argc, char **argv)
 			unsigned char end[20];
 			char *n = dotdot+2;
 			*dotdot = 0;
-			if (!get_extended_sha1(arg, sha1)) {
+			if (!get_sha1(arg, sha1)) {
 				if (!*n)
 					n = "HEAD";
-				if (!get_extended_sha1(n, end)) {
+				if (!get_sha1(n, end)) {
 					if (no_revs)
 						continue;
 					def = NULL;
@@ -386,14 +208,14 @@ int main(int argc, char **argv)
 			}
 			*dotdot = '.';
 		}
-		if (!get_extended_sha1(arg, sha1)) {
+		if (!get_sha1(arg, sha1)) {
 			if (no_revs)
 				continue;
 			def = NULL;
 			show_rev(NORMAL, sha1);
 			continue;
 		}
-		if (*arg == '^' && !get_extended_sha1(arg+1, sha1)) {
+		if (*arg == '^' && !get_sha1(arg+1, sha1)) {
 			if (no_revs)
 				continue;
 			def = NULL;
diff --git a/sha1_file.c b/sha1_file.c
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -46,21 +46,6 @@ int get_sha1_hex(const char *hex, unsign
 	return 0;
 }
 
-static int get_sha1_file(const char *path, unsigned char *result)
-{
-	char buffer[60];
-	int fd = open(path, O_RDONLY);
-	int len;
-
-	if (fd < 0)
-		return -1;
-	len = read(fd, buffer, sizeof(buffer));
-	close(fd);
-	if (len < 40)
-		return -1;
-	return get_sha1_hex(buffer, result);
-}
-
 static char *git_dir, *git_object_dir, *git_index_file, *git_refs_dir,
 	*git_graft_file;
 static void setup_git_env(void)
@@ -132,30 +117,6 @@ int safe_create_leading_directories(char
 	return 0;
 }
 
-int get_sha1(const char *str, unsigned char *sha1)
-{
-	static const char *prefix[] = {
-		"",
-		"refs",
-		"refs/tags",
-		"refs/heads",
-		"refs/snap",
-		NULL
-	};
-	const char **p;
-
-	if (!get_sha1_hex(str, sha1))
-		return 0;
-
-	for (p = prefix; *p; p++) {
-		char * pathname = git_path("%s/%s", *p, str);
-		if (!get_sha1_file(pathname, sha1))
-			return 0;
-	}
-
-	return -1;
-}
-
 char * sha1_to_hex(const unsigned char *sha1)
 {
 	static char buffer[50];
diff --git a/sha1_name.c b/sha1_name.c
new file mode 100644
--- /dev/null
+++ b/sha1_name.c
@@ -0,0 +1,222 @@
+#include "cache.h"
+#include "commit.h"
+
+static int find_short_object_filename(int len, const char *name, unsigned char *sha1)
+{
+	static char dirname[PATH_MAX];
+	char hex[40];
+	DIR *dir;
+	int found;
+
+	snprintf(dirname, sizeof(dirname), "%s/%.2s", get_object_directory(), name);
+	dir = opendir(dirname);
+	sprintf(hex, "%.2s", name);
+	found = 0;
+	if (dir) {
+		struct dirent *de;
+		while ((de = readdir(dir)) != NULL) {
+			if (strlen(de->d_name) != 38)
+				continue;
+			if (memcmp(de->d_name, name + 2, len-2))
+				continue;
+			memcpy(hex + 2, de->d_name, 38);
+			if (++found > 1)
+				break;
+		}
+		closedir(dir);
+	}
+	if (found == 1)
+		return get_sha1_hex(hex, sha1) == 0;
+	return 0;
+}
+
+static int match_sha(unsigned len, const unsigned char *a, const unsigned char *b)
+{
+	do {
+		if (*a != *b)
+			return 0;
+		a++;
+		b++;
+		len -= 2;
+	} while (len > 1);
+	if (len)
+		if ((*a ^ *b) & 0xf0)
+			return 0;
+	return 1;
+}
+
+static int find_short_packed_object(int len, const unsigned char *match, unsigned char *sha1)
+{
+	struct packed_git *p;
+
+	prepare_packed_git();
+	for (p = packed_git; p; p = p->next) {
+		unsigned num = num_packed_objects(p);
+		unsigned first = 0, last = num;
+		while (first < last) {
+			unsigned mid = (first + last) / 2;
+			unsigned char now[20];
+			int cmp;
+
+			nth_packed_object_sha1(p, mid, now);
+			cmp = memcmp(match, now, 20);
+			if (!cmp) {
+				first = mid;
+				break;
+			}
+			if (cmp > 0) {
+				first = mid+1;
+				continue;
+			}
+			last = mid;
+		}
+		if (first < num) {
+			unsigned char now[20], next[20];
+			nth_packed_object_sha1(p, first, now);
+			if (match_sha(len, match, now)) {
+				if (nth_packed_object_sha1(p, first+1, next) || !match_sha(len, match, next)) {
+					memcpy(sha1, now, 20);
+					return 1;
+				}
+			}
+		}
+	}
+	return 0;
+}
+
+static int get_short_sha1(const char *name, unsigned char *sha1)
+{
+	int i;
+	char canonical[40];
+	unsigned char res[20];
+
+	memset(res, 0, 20);
+	memset(canonical, 'x', 40);
+	for (i = 0;;i++) {
+		unsigned char c = name[i];
+		unsigned char val;
+		if (!c || i > 40)
+			break;
+		if (c >= '0' && c <= '9')
+			val = c - '0';
+		else if (c >= 'a' && c <= 'f')
+			val = c - 'a' + 10;
+		else if (c >= 'A' && c <='F') {
+			val = c - 'A' + 10;
+			c -= 'A' - 'a';
+		}
+		else
+			return -1;
+		canonical[i] = c;
+		if (!(i & 1))
+			val <<= 4;
+		res[i >> 1] |= val;
+	}
+	if (i < 4)
+		return -1;
+	if (find_short_object_filename(i, canonical, sha1))
+		return 0;
+	if (find_short_packed_object(i, res, sha1))
+		return 0;
+	return -1;
+}
+
+static int get_sha1_file(const char *path, unsigned char *result)
+{
+	char buffer[60];
+	int fd = open(path, O_RDONLY);
+	int len;
+
+	if (fd < 0)
+		return -1;
+	len = read(fd, buffer, sizeof(buffer));
+	close(fd);
+	if (len < 40)
+		return -1;
+	return get_sha1_hex(buffer, result);
+}
+
+static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
+{
+	static const char *prefix[] = {
+		"",
+		"refs",
+		"refs/tags",
+		"refs/heads",
+		"refs/snap",
+		NULL
+	};
+	const char **p;
+
+	if (!get_sha1_hex(str, sha1))
+		return 0;
+
+	for (p = prefix; *p; p++) {
+		char *pathname = git_path("%s/%.*s", *p, len, str);
+		if (!get_sha1_file(pathname, sha1))
+			return 0;
+	}
+
+	return -1;
+}
+
+static int get_sha1_1(const char *name, int len, unsigned char *sha1);
+
+static int get_parent(const char *name, int len,
+		      unsigned char *result, int idx)
+{
+	unsigned char sha1[20];
+	int ret = get_sha1_1(name, len, sha1);
+	struct commit *commit;
+	struct commit_list *p;
+
+	if (ret)
+		return ret;
+	commit = lookup_commit_reference(sha1);
+	if (!commit)
+		return -1;
+	if (parse_commit(commit))
+		return -1;
+	if (!idx) {
+		memcpy(result, commit->object.sha1, 20);
+		return 0;
+	}
+	p = commit->parents;
+	while (p) {
+		if (!--idx) {
+			memcpy(result, p->item->object.sha1, 20);
+			return 0;
+		}
+		p = p->next;
+	}
+	return -1;
+}
+
+static int get_sha1_1(const char *name, int len, unsigned char *sha1)
+{
+	int parent, ret;
+
+	parent = 1;
+	if (len > 2 && name[len-1] >= '0' && name[len-1] <= '9') {
+		parent = name[len-1] - '0';
+		len--;
+	}
+	if (len > 1 && name[len-1] == '^') {
+		ret = get_parent(name, len-1, sha1, parent);
+		if (!ret)
+			return 0;
+	}
+	ret = get_sha1_basic(name, len, sha1);
+	if (!ret)
+		return 0;
+	return get_short_sha1(name, sha1);
+}
+
+/*
+ * This is like "get_sha1_basic()", except it allows "sha1 expressions",
+ * notably "xyz^" for "parent of xyz"
+ */
+int get_sha1(const char *name, unsigned char *sha1)
+{
+	return get_sha1_1(name, strlen(name), sha1);
+}
