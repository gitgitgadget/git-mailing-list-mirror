From: Jeff King <peff@peff.net>
Subject: [RFC] Cache negative delta pairs
Date: Wed, 28 Jun 2006 23:58:49 -0400
Message-ID: <20060629035849.GA30749@coredump.intra.peff.net>
References: <20060628223744.GA24421@coredump.intra.peff.net> <7v4py4y7wo.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Jun 29 05:59:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FvngA-00081b-Qn
	for gcvg-git@gmane.org; Thu, 29 Jun 2006 05:58:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932135AbWF2D6y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Jun 2006 23:58:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932139AbWF2D6y
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jun 2006 23:58:54 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:12489 "HELO
	peff.net") by vger.kernel.org with SMTP id S932135AbWF2D6v (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Jun 2006 23:58:51 -0400
Received: (qmail 8193 invoked from network); 28 Jun 2006 23:58:29 -0400
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 28 Jun 2006 23:58:29 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 28 Jun 2006 23:58:49 -0400
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7v4py4y7wo.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22836>

>From repack to repack, we end up trying to delta many of the same object
pairs, which is computationally expensive.  This patch makes a
persistent cache, $GIT_DIR/delta-cache, which contains pairs of sha1
hashes (the presence of a pair indicates that it's not worth trying to
delta those two objects).

Signed-off-by: Jeff King <peff@peff.net>
---

[This is a repost, since the original got caught by the list filter.]

I found this especially to be a problem with repos that consist of many
large, unrelated files (e.g., photos). For example, on my test repo
(about 300 unrelated 1-2M jpgs), a 'git-repack -a' takes about 10
minutes to complete. With the delta cache, subsequent repacks take only
13 seconds. Results are not quite as dramatic for "normal" repos, but
there is still some speedup. Repacking a fully packed linux-2.6 repo
went from 1m12s to 36s. Repacking the git repo goes from 5.6s to 3.0s.

Here are some of my thoughts:

 - speed. The implementation is quite fast. The sha1 pairs are stored
   sorted, and we mmap and binary search them. Certainly the extra time
   spent in lookup is justified by avoiding the delta attempts.

 - size. The cache is a packed sequence of binary sha1 pairs. I was
   concerned that it would grow too large (obviously for n blobs you can
   end up with n^2/2 entries), but it doesn't seem unreasonable for most
   repos (either you don't have a lot of files, or if you do, they delta
   reasonably well). My test repo's cache is only 144K. The git cache is
   about 2.7M. The linux-2.6 cache is 22M.

   Theoretically, I could bound the cache size and boot old entries.
   However, that means storing age information, which increases the
   required size. I think keeping it simple is best.

 - correctness. Currently the code uses the output of try_delta for
   negative caching. Should the cache checking be moved inside try_delta
   instead? This would give more control over which reasons to mark a
   delta negative (I believe right now hitting the depth limit will
   cause a negative mark; we should perhaps only do so if the content
   itself makes the delta unpalatable).
 
 - optionalness. Currently the delta-cache is always used. Since it is a
   space-time tradeoff, maybe it should be optional (it will have
   negligible performance and horrible size impact on a repo that
   consists of many very small but unrelated objects).  Possible methods
   include:
     - enable cache saves only if .git/delta-cache is present; turn it
       on initially with 'touch .git/delta-cache'
     - config variable

 Makefile       |    4 +-
 delta-cache.c  |  119 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 delta-cache.h  |   11 +++++
 pack-objects.c |   11 +++++
 4 files changed, 142 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index cde619c..39c4308 100644
--- a/Makefile
+++ b/Makefile
@@ -202,7 +202,7 @@ LIB_H = \
 	blob.h cache.h commit.h csum-file.h delta.h \
 	diff.h object.h pack.h pkt-line.h quote.h refs.h \
 	run-command.h strbuf.h tag.h tree.h git-compat-util.h revision.h \
-	tree-walk.h log-tree.h dir.h
+	tree-walk.h log-tree.h dir.h delta-cache.h
 
 DIFF_OBJS = \
 	diff.o diff-lib.o diffcore-break.o diffcore-order.o \
@@ -217,7 +217,7 @@ LIB_OBJS = \
 	server-info.o setup.o sha1_file.o sha1_name.o strbuf.o \
 	tag.o tree.o usage.o config.o environment.o ctype.o copy.o \
 	fetch-clone.o revision.o pager.o tree-walk.o xdiff-interface.o \
-	alloc.o $(DIFF_OBJS)
+	alloc.o delta-cache.o $(DIFF_OBJS)
 
 BUILTIN_OBJS = \
 	builtin-log.o builtin-help.o builtin-count.o builtin-diff.o builtin-push.o \
diff --git a/delta-cache.c b/delta-cache.c
new file mode 100644
index 0000000..d132867
--- /dev/null
+++ b/delta-cache.c
@@ -0,0 +1,119 @@
+#include "delta-cache.h"
+#include "cache.h"
+
+static const unsigned char* disk_cache = 0;
+static unsigned disk_cache_len = 0;
+static unsigned char* mem_cache = 0;
+static unsigned mem_cache_len = 0;
+static unsigned mem_cache_alloc = 0;
+
+#define GETCACHE(c, n) (c+(40*n))
+
+static void disk_cache_init()
+{
+	static int done = 0;
+	int fd;
+	struct stat st;
+
+	if (done) return;
+	done = 1;
+
+	fd = open(git_path("delta-cache"), O_RDONLY);
+	if (fd < 0)
+		return;
+	if (fstat(fd, &st) || (st.st_size == 0)) {
+		close(fd);
+		return;
+	}
+	disk_cache = mmap(NULL, st.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
+	close(fd);
+	if (disk_cache != MAP_FAILED)
+		disk_cache_len = st.st_size / 40;
+}
+
+static int
+check_cache(const unsigned char* c, unsigned len, const unsigned char s[40])
+{
+	int left, right, mid, cmp;
+
+	left = 0;
+	right = len - 1;
+	while (left <= right) {
+		mid = left + (right - left) / 2;
+		cmp = memcmp(s, GETCACHE(c, mid), 40);
+		if(cmp == 0) return 1;
+		else if(cmp <  0) right = mid - 1;
+		else left = mid + 1;
+	}
+	return 0;
+}
+
+extern int
+delta_cache_check(const unsigned char a[20], const unsigned char b[20])
+{
+	unsigned char search[40];
+
+	disk_cache_init();
+	memcpy(search, a, 20);
+	memcpy(search+20, b, 20);
+	return check_cache(disk_cache, disk_cache_len, search);
+}
+
+extern void
+delta_cache_mark(const unsigned char a[20], const unsigned char b[20])
+{
+	if (mem_cache_len == mem_cache_alloc) {
+		mem_cache_alloc = mem_cache_alloc ? mem_cache_alloc * 2 : 16;
+		mem_cache = xrealloc(mem_cache, mem_cache_alloc * 40);
+	}
+	memcpy(GETCACHE(mem_cache, mem_cache_len), a, 20);
+	memcpy(GETCACHE(mem_cache, mem_cache_len)+20, b, 20);
+	mem_cache_len++;
+}
+
+static int
+compare_sha1pair(const void *a, const void *b)
+{
+	return memcmp(a, b, 40);
+}
+
+static int
+merge_write(int fd, const unsigned char* p1, unsigned n1,
+		    const unsigned char* p2, unsigned n2)
+{
+#define EMIT(p, x) do { \
+	if (xwrite(fd, GETCACHE(p, x), 40) < 0) return -1; x++; \
+	} while(0)
+
+	int i = 0, j = 0, cmp;
+	while (i < n1 && j < n2) {
+		cmp = memcmp(GETCACHE(p1, i), GETCACHE(p2, j), 40);
+		if (cmp < 0) EMIT(p1, i);
+		else EMIT(p2, j);
+	}
+	while (i < n1) EMIT(p1, i);
+	while (j < n2) EMIT(p2, j);
+#undef EMIT
+	return 0;
+}
+
+extern void
+delta_cache_save(void)
+{
+	int fd;
+	char tmpfile[PATH_MAX];
+
+	strcpy(tmpfile, git_path("delta-cache.%u", getpid()));
+	fd = open(tmpfile, O_WRONLY|O_EXCL|O_CREAT, 0666);
+	if (fd < 0)
+		return;
+
+	qsort(mem_cache, mem_cache_len, 40, compare_sha1pair);
+	if (merge_write(fd, mem_cache, mem_cache_len,
+			    disk_cache, disk_cache_len) < 0) {
+		close(fd);
+		return;
+	}
+
+	rename(tmpfile, git_path("delta-cache"));
+}
diff --git a/delta-cache.h b/delta-cache.h
new file mode 100644
index 0000000..19201be
--- /dev/null
+++ b/delta-cache.h
@@ -0,0 +1,11 @@
+#ifndef DELTA_CACHE_H
+#define DELTA_CACHE_H
+
+extern int
+delta_cache_check(const unsigned char a[20], const unsigned char b[20]);
+extern void
+delta_cache_mark(const unsigned char a[20], const unsigned char b[20]);
+extern void
+delta_cache_save(void);
+
+#endif /* DELTA_CACHE_H */
diff --git a/pack-objects.c b/pack-objects.c
index bed2497..46b9775 100644
--- a/pack-objects.c
+++ b/pack-objects.c
@@ -8,6 +8,7 @@ #include "delta.h"
 #include "pack.h"
 #include "csum-file.h"
 #include "tree-walk.h"
+#include "delta-cache.h"
 #include <sys/time.h>
 #include <signal.h>
 
@@ -1083,14 +1084,21 @@ static void find_deltas(struct object_en
 		j = window;
 		while (--j > 0) {
 			unsigned int other_idx = idx + j;
+			int r;
 			struct unpacked *m;
 			if (other_idx >= window)
 				other_idx -= window;
 			m = array + other_idx;
 			if (!m->entry)
 				break;
-			if (try_delta(n, m, m->index, depth) < 0)
+			if (delta_cache_check(n->entry->sha1, m->entry->sha1))
+				continue;
+			r = try_delta(n, m, m->index, depth);
+			if (r < 0)
 				break;
+			if (r == 0)
+				delta_cache_mark(n->entry->sha1,
+						 m->entry->sha1);
 		}
 		/* if we made n a delta, and if n is already at max
 		 * depth, leaving it in the window is pointless.  we
@@ -1342,5 +1350,6 @@ int main(int argc, char **argv)
 	if (progress)
 		fprintf(stderr, "Total %d, written %d (delta %d), reused %d (delta %d)\n",
 			nr_result, written, written_delta, reused, reused_delta);
+	delta_cache_save();
 	return 0;
 }
-- 
1.4.1.rc1.g3000
