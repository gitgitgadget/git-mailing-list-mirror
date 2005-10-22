From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Allow caching of generated pack for full cloning.
Date: Sat, 22 Oct 2005 02:00:12 -0700
Message-ID: <7vhdbakjtv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "H Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Sat Oct 22 11:01:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ETFEo-0001cy-Hi
	for gcvg-git@gmane.org; Sat, 22 Oct 2005 11:00:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750749AbVJVJAQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 22 Oct 2005 05:00:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750951AbVJVJAP
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Oct 2005 05:00:15 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:22741 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1750749AbVJVJAN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Oct 2005 05:00:13 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051022085956.RFOY9394.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 22 Oct 2005 04:59:56 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10468>

git-pack-objects can reuse pack files stored in $GIT_DIR/pack-cache
directory, when a necessary pack is found.  This is hopefully useful
when upload-pack (called from git-daemon) is expected to receive
requests for the same set of objects many times (e.g full cloning
request of any project, or updates from the set of heads previous day
to the latest for a slow moving project).

Currently git-pack-objects does *not* keep pack files it creates for
reusing.  It might be useful to implement its --update-cache option,
which would let it store pack files it created in the pack-cache
directory, and prune rarely used ones from it.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

  Right now, this is not very useful except perhaps preparing
  for many clone requests by statically creating and storing a
  full pack in pack-cache directory.  I am expecting that
  enabling the unimplemented --update-cache option of
  git-pack-objects would let the server keep recently generated
  packs, hoping that fetch requests close together would be for
  the same "master" head, relative to the same previous heads
  (multiple people making a habit of pulling every day, or every
  week, or whatever).  These cached packs need to be purged from
  the pack-cache directory quite often.  They would become
  useless once you update a popular ref in the repository.

  Even if this caching would help git-daemon by reusing
  generated packs, I see one potential problem; --update-cache
  option would require the process to be able to write into the
  pack-cache directory, but I expect git-daemon would run as a
  user that does not have any write privilege to the filesystem.

 Makefile       |    2 +
 cache.h        |    1 +
 copy.c         |   37 +++++++++++++++++++++++
 pack-objects.c |   90 +++++++++++++++++++++++++++++++++++++++++++++++++-------
 upload-pack.c  |   12 ++++++-
 5 files changed, 126 insertions(+), 16 deletions(-)
 create mode 100644 copy.c

applies-to: a0d57ba5b9245eb3a4cc15fb029af51a40eb8136
dd42e422104f43b369929c4f900362d401d2e962
diff --git a/Makefile b/Makefile
index 903c57c..3d8503d 100644
--- a/Makefile
+++ b/Makefile
@@ -159,7 +159,7 @@ LIB_OBJS = \
 	object.o pack-check.o patch-delta.o path.o pkt-line.o \
 	quote.o read-cache.o refs.o run-command.o \
 	server-info.o setup.o sha1_file.o sha1_name.o strbuf.o \
-	tag.o tree.o usage.o config.o environment.o ctype.o \
+	tag.o tree.o usage.o config.o environment.o ctype.o copy.o \
 	$(DIFF_OBJS)
 
 LIBS = $(LIB_FILE)
diff --git a/cache.h b/cache.h
index d776016..2e36cc5 100644
--- a/cache.h
+++ b/cache.h
@@ -413,4 +413,5 @@ static inline int sane_case(int x, int h
 	return x;
 }
 
+extern int copy_fd(int ifd, int ofd);
 #endif /* CACHE_H */
diff --git a/copy.c b/copy.c
new file mode 100644
index 0000000..2009275
--- /dev/null
+++ b/copy.c
@@ -0,0 +1,37 @@
+#include "cache.h"
+
+int copy_fd(int ifd, int ofd)
+{
+	while (1) {
+		int len;
+		char buffer[8192];
+		char *buf = buffer;
+		len = read(ifd, buffer, sizeof(buffer));
+		if (!len)
+			break;
+		if (len < 0) {
+			if (errno == EAGAIN)
+				continue;
+			return error("copy-fd: read returned %s",
+				     strerror(errno));
+		}
+		while (1) {
+			int written = write(ofd, buf, len);
+			if (written > 0) {
+				buf += written;
+				len -= written;
+				if (!len)
+					break;
+			}
+			if (!written)
+				return error("copy-fd: write returned 0");
+			if (errno == EAGAIN || errno == EINTR)
+				continue;
+			return error("copy-fd: write returned %s",
+				     strerror(errno));
+		}
+	}
+	close(ifd);
+	return 0;
+}
+
diff --git a/pack-objects.c b/pack-objects.c
index b3e6152..915469e 100644
--- a/pack-objects.c
+++ b/pack-objects.c
@@ -4,7 +4,7 @@
 #include "pack.h"
 #include "csum-file.h"
 
-static const char pack_usage[] = "git-pack-objects [--local] [--incremental] [--window=N] [--depth=N] {--stdout | base-name} < object-list";
+static const char pack_usage[] = "git-pack-objects [--local] [--incremental] [--window=N] [--depth=N] {--stdout | base-name} [--update-cache] < object-list";
 
 struct object_entry {
 	unsigned char sha1[20];
@@ -400,6 +400,71 @@ static void find_deltas(struct object_en
 	free(array);
 }
 
+static void prepare_pack(int window, int depth)
+{
+	get_object_details();
+
+	fprintf(stderr, "Packing %d objects\n", nr_objects);
+
+	sorted_by_type = create_sorted_list(type_size_sort);
+	if (window && depth)
+		find_deltas(sorted_by_type, window+1, depth);
+	write_pack_file();
+}
+
+static int reuse_cached_pack(unsigned char *sha1, int pack_to_stdout)
+{
+	static const char cache[] = "pack-cache/pack-%s.%s";
+	char *cached_pack, *cached_idx;
+	int ifd, ofd, ifd_ix = -1;
+
+	cached_pack = git_path(cache, sha1_to_hex(sha1), "pack");
+	ifd = open(cached_pack, O_RDONLY);
+	if (ifd < 0)
+		return 0;
+
+	if (!pack_to_stdout) {
+		cached_idx = git_path(cache, sha1_to_hex(sha1), "idx");
+		ifd_ix = open(cached_idx, O_RDONLY);
+		if (ifd_ix < 0) {
+			close(ifd);
+			return 0;
+		}
+	}
+
+	fprintf(stderr, "Reusing %d objects pack %s\n", nr_objects,
+		sha1_to_hex(sha1));
+
+	if (pack_to_stdout) {
+		if (copy_fd(ifd, 1))
+			exit(1);
+		close(ifd);
+	}
+	else {
+		char name[PATH_MAX];
+		snprintf(name, sizeof(name),
+			 "%s-%s.%s", base_name, sha1_to_hex(sha1), "pack");
+		ofd = open(name, O_CREAT | O_EXCL | O_WRONLY, 0666);
+		if (ofd < 0)
+			die("unable to open %s (%s)", name, strerror(errno));
+		if (copy_fd(ifd, ofd))
+			exit(1);
+		close(ifd);
+
+		snprintf(name, sizeof(name),
+			 "%s-%s.%s", base_name, sha1_to_hex(sha1), "idx");
+		ofd = open(name, O_CREAT | O_EXCL | O_WRONLY, 0666);
+		if (ofd < 0)
+			die("unable to open %s (%s)", name, strerror(errno));
+		if (copy_fd(ifd_ix, ofd))
+			exit(1);
+		close(ifd_ix);
+		puts(sha1_to_hex(sha1));
+	}
+
+	return 1;
+}
+
 int main(int argc, char **argv)
 {
 	SHA_CTX ctx;
@@ -424,6 +489,10 @@ int main(int argc, char **argv)
 				incremental = 1;
 				continue;
 			}
+			if (!strcmp("--update-cache", arg)) {
+				/* Not implemented */
+				continue;
+			}
 			if (!strncmp("--window=", arg, 9)) {
 				char *end;
 				window = strtoul(arg+9, &end, 0);
@@ -472,9 +541,6 @@ int main(int argc, char **argv)
 	}
 	if (non_empty && !nr_objects)
 		return 0;
-	get_object_details();
-
-	fprintf(stderr, "Packing %d objects\n", nr_objects);
 
 	sorted_by_sha = create_sorted_list(sha1_sort);
 	SHA1_Init(&ctx);
@@ -485,14 +551,14 @@ int main(int argc, char **argv)
 	}
 	SHA1_Final(object_list_sha1, &ctx);
 
-	sorted_by_type = create_sorted_list(type_size_sort);
-	if (window && depth)
-		find_deltas(sorted_by_type, window+1, depth);
-
-	write_pack_file();
-	if (!pack_to_stdout) {
-		write_index_file();
-		puts(sha1_to_hex(object_list_sha1));
+	if (reuse_cached_pack(object_list_sha1, pack_to_stdout))
+		;
+	else {
+		prepare_pack(window, depth);
+		if (!pack_to_stdout) {
+			write_index_file();
+			puts(sha1_to_hex(object_list_sha1));
+		}
 	}
 	return 0;
 }
diff --git a/upload-pack.c b/upload-pack.c
index 8a41caf..6fb8eb7 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -29,6 +29,7 @@ static void create_pack_file(void)
 {
 	int fd[2];
 	pid_t pid;
+	int create_full_pack = (MAX_NEEDS <= nr_needs);
 
 	if (pipe(fd) < 0)
 		die("git-upload-pack: unable to create pipe");
@@ -43,7 +44,7 @@ static void create_pack_file(void)
 		char *buf;
 		char **p;
 
-		if (MAX_NEEDS <= nr_needs)
+		if (create_full_pack)
 			args = nr_has + 10;
 		else
 			args = nr_has + nr_needs + 5;
@@ -57,7 +58,7 @@ static void create_pack_file(void)
 		close(fd[1]);
 		*p++ = "git-rev-list";
 		*p++ = "--objects";
-		if (MAX_NEEDS <= nr_needs)
+		if (create_full_pack)
 			*p++ = "--all";
 		else {
 			for (i = 0; i < nr_needs; i++) {
@@ -79,7 +80,12 @@ static void create_pack_file(void)
 	dup2(fd[0], 0);
 	close(fd[0]);
 	close(fd[1]);
-	execlp("git-pack-objects", "git-pack-objects", "--stdout", NULL);
+	if (create_full_pack)
+		execlp("git-pack-objects", "git-pack-objects",
+		       "--stdout", NULL);
+	else
+		execlp("git-pack-objects", "git-pack-objects",
+		       "--stdout", "--update-cache", NULL);
 	die("git-upload-pack: unable to exec git-pack-objects");
 }
 
---
0.99.8.GIT
