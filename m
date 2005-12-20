From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Racy GIT
Date: Tue, 20 Dec 2005 00:38:47 -0800
Message-ID: <7vwti0go2w.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: pasky@suse.cz, torvalds@osdl.org
X-From: git-owner@vger.kernel.org Tue Dec 20 09:39:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eod1K-0000OM-6E
	for gcvg-git@gmane.org; Tue, 20 Dec 2005 09:38:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750857AbVLTIiv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Dec 2005 03:38:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750856AbVLTIiv
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Dec 2005 03:38:51 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:57554 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1750824AbVLTIiv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Dec 2005 03:38:51 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051220083710.UQRV26964.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 20 Dec 2005 03:37:10 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13846>

This fixes the longstanding "Racy GIT" problem, which was pretty
much there from the beginning of time, but was first
demonstrated by Pasky in this message on October 24, 2005:

    http://marc.theaimsgroup.com/?l=git&m=113014629716878

If you run the following sequence of commands:

	echo frotz >infocom
        git update-index --add infocom
        echo xyzzy >infocom

so that the second update to file "infocom" does not change
st_mtime, what is recorded as the stat information for the cache
entry "infocom" exactly matches what is on the filesystem
(owner, group, inum, mtime, ctime, mode, length).  After this
sequence, we incorrectly think "infocom" file still has string
"frotz" in it, and get really confused.  E.g. git-diff-files
would say there is no change, git-update-index --refresh would
not even look at the filesystem to correct the situation.

Some ways of working around this issue were already suggested by
Linus in the same thread on the same day, including waiting
until the next second before returning from update-index if a
cache entry written out has the current timestamp, but that
means we can make at most one commit per second, and given that
the e-mail patch workflow used by Linus needs to process at
least 5 commits per second, it is not an acceptable solution.
Linus notes that git-apply is primarily used to update the index
while processing e-mailed patches, which is true, and
git-apply's up-to-date check is fooled by the same problem but
luckily in the other direction, so it is not really a big issue,
but still it is disturbing.

The function ce_match_stat() is called to bypass the comparison
against filesystem data when the stat data recorded in the cache
entry matches what stat() returns from the filesystem.  This
patch tackles the problem by changing it to actually go to the
filesystem data for cache entries that have the same mtime as
the index file itself.  This works as long as the index file and
working tree files are on the filesystems that share the same
monotonic clock.  Files on network mounted filesystems sometimes
get skewed timestamps compared to "date" output, but as long as
working tree files' timestamps are skewed the same way as the
index file's, this approach still works.  The only problematic
files are the ones that have the same timestamp as the index
file's, because two file updates that sandwitch the index file
update must happen within the same second to trigger the
problem.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 read-cache.c        |  140 +++++++++++++++++++++++++++++++--------------------
 t/t0010-racy-git.sh |   24 +++++++++
 2 files changed, 110 insertions(+), 54 deletions(-)
 create mode 100755 t/t0010-racy-git.sh

29e4d3635709778bcc808dbad0477efad82f8d7e
diff --git a/read-cache.c b/read-cache.c
index 6932736..780601f 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -6,6 +6,7 @@
 #include "cache.h"
 
 struct cache_entry **active_cache = NULL;
+static time_t index_file_timestamp;
 unsigned int active_nr = 0, active_alloc = 0, active_cache_changed = 0;
 
 /*
@@ -28,6 +29,64 @@ void fill_stat_cache_info(struct cache_e
 	ce->ce_size = htonl(st->st_size);
 }
 
+static int ce_compare_data(struct cache_entry *ce, struct stat *st)
+{
+	int match = -1;
+	int fd = open(ce->name, O_RDONLY);
+
+	if (fd >= 0) {
+		unsigned char sha1[20];
+		if (!index_fd(sha1, fd, st, 0, NULL))
+			match = memcmp(sha1, ce->sha1, 20);
+		close(fd);
+	}
+	return match;
+}
+
+static int ce_compare_link(struct cache_entry *ce, unsigned long expected_size)
+{
+	int match = -1;
+	char *target;
+	void *buffer;
+	unsigned long size;
+	char type[10];
+	int len;
+
+	target = xmalloc(expected_size);
+	len = readlink(ce->name, target, expected_size);
+	if (len != expected_size) {
+		free(target);
+		return -1;
+	}
+	buffer = read_sha1_file(ce->sha1, type, &size);
+	if (!buffer) {
+		free(target);
+		return -1;
+	}
+	if (size == expected_size)
+		match = memcmp(buffer, target, size);
+	free(buffer);
+	free(target);
+	return match;
+}
+
+static int ce_modified_check_fs(struct cache_entry *ce, struct stat *st)
+{
+	switch (st->st_mode & S_IFMT) {
+	case S_IFREG:
+		if (ce_compare_data(ce, st))
+			return DATA_CHANGED;
+		break;
+	case S_IFLNK:
+		if (ce_compare_link(ce, st->st_size))
+			return DATA_CHANGED;
+		break;
+	default:
+		return TYPE_CHANGED;
+	}
+	return 0;
+}
+
 int ce_match_stat(struct cache_entry *ce, struct stat *st)
 {
 	unsigned int changed = 0;
@@ -83,57 +142,37 @@ int ce_match_stat(struct cache_entry *ce
 
 	if (ce->ce_size != htonl(st->st_size))
 		changed |= DATA_CHANGED;
-	return changed;
-}
-
-static int ce_compare_data(struct cache_entry *ce, struct stat *st)
-{
-	int match = -1;
-	int fd = open(ce->name, O_RDONLY);
 
-	if (fd >= 0) {
-		unsigned char sha1[20];
-		if (!index_fd(sha1, fd, st, 0, NULL))
-			match = memcmp(sha1, ce->sha1, 20);
-		close(fd);
-	}
-	return match;
-}
-
-static int ce_compare_link(struct cache_entry *ce, unsigned long expected_size)
-{
-	int match = -1;
-	char *target;
-	void *buffer;
-	unsigned long size;
-	char type[10];
-	int len;
+	/*
+	 * Within 1 second of this sequence:
+	 * 	echo xyzzy >file && git-update-index --add file
+	 * running this command:
+	 * 	echo frotz >file
+	 * would give a falsely clean cache entry.  The mtime and
+	 * length match the cache, and other stat fields do not change.
+	 *
+	 * We could detect this at update-index time (the cache entry
+	 * being registered/updated records the same time as "now")
+	 * and delay the return from git-update-index, but that would
+	 * effectively mean we can make at most one commit per second,
+	 * which is not acceptable.  Instead, we check cache entries
+	 * whose mtime are the same as the index file timestamp more
+	 * careful than others.
+	 */
+	if (!changed &&
+	    index_file_timestamp &&
+	    index_file_timestamp <= ntohl(ce->ce_mtime.sec))
+		changed |= ce_modified_check_fs(ce, st);
 
-	target = xmalloc(expected_size);
-	len = readlink(ce->name, target, expected_size);
-	if (len != expected_size) {
-		free(target);
-		return -1;
-	}
-	buffer = read_sha1_file(ce->sha1, type, &size);
-	if (!buffer) {
-		free(target);
-		return -1;
-	}
-	if (size == expected_size)
-		match = memcmp(buffer, target, size);
-	free(buffer);
-	free(target);
-	return match;
+	return changed;
 }
 
 int ce_modified(struct cache_entry *ce, struct stat *st)
 {
-	int changed;
+	int changed, changed_fs;
 	changed = ce_match_stat(ce, st);
 	if (!changed)
 		return 0;
-
 	/*
 	 * If the mode or type has changed, there's no point in trying
 	 * to refresh the entry - it's not going to match
@@ -148,18 +187,9 @@ int ce_modified(struct cache_entry *ce, 
 	if ((changed & DATA_CHANGED) && ce->ce_size != htonl(0))
 		return changed;
 
-	switch (st->st_mode & S_IFMT) {
-	case S_IFREG:
-		if (ce_compare_data(ce, st))
-			return changed | DATA_CHANGED;
-		break;
-	case S_IFLNK:
-		if (ce_compare_link(ce, st->st_size))
-			return changed | DATA_CHANGED;
-		break;
-	default:
-		return changed | TYPE_CHANGED;
-	}
+	changed_fs = ce_modified_check_fs(ce, st);
+	if (changed_fs)
+		return changed | changed_fs;
 	return 0;
 }
 
@@ -471,6 +501,7 @@ int read_cache(void)
 		return active_nr;
 
 	errno = ENOENT;
+	index_file_timestamp = 0;
 	fd = open(get_index_file(), O_RDONLY);
 	if (fd < 0) {
 		if (errno == ENOENT)
@@ -504,6 +535,7 @@ int read_cache(void)
 		offset = offset + ce_size(ce);
 		active_cache[i] = ce;
 	}
+	index_file_timestamp = st.st_mtime;
 	return active_nr;
 
 unmap:
diff --git a/t/t0010-racy-git.sh b/t/t0010-racy-git.sh
new file mode 100755
index 0000000..eb175b7
--- /dev/null
+++ b/t/t0010-racy-git.sh
@@ -0,0 +1,24 @@
+#!/bin/sh
+
+test_description='racy GIT'
+
+. ./test-lib.sh
+
+# This test can give false success if your machine is sufficiently
+# slow or your trial happened to happen on second boundary.
+
+for trial in 0 1 2 3 4 5 6 7 8 9
+do
+	rm -f .git/index
+	echo frotz >infocom
+	echo xyzzy >activision
+	git update-index --add infocom activision
+	echo xyzzy >infocom
+
+	files=`git diff-files -p`
+	test_expect_success \
+	"Racy GIT trial #$trial" \
+	'test "" != "$files"'
+done
+
+test_done
-- 
0.99.9.GIT
