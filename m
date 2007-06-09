From: Johan Herland <johan@herland.net>
Subject: [PATCH 2/7] Softrefs: Add implementation of softrefs API
Date: Sat, 09 Jun 2007 20:22:21 +0200
Message-ID: <200706092022.21234.johan@herland.net>
References: <200706040251.05286.johan@herland.net>
 <200706092019.13185.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 09 20:22:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hx5a9-0004Mm-KH
	for gcvg-git@gmane.org; Sat, 09 Jun 2007 20:22:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756009AbXFISWg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 9 Jun 2007 14:22:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755219AbXFISWg
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Jun 2007 14:22:36 -0400
Received: from smtp.getmail.no ([84.208.20.33]:41181 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753809AbXFISWf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jun 2007 14:22:35 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-009-z2.isp.get.no by
 no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JJD00L0JSDMVR00@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Sat, 09 Jun 2007 20:22:34 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJD00JLCSDAID00@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Sat, 09 Jun 2007 20:22:22 +0200 (CEST)
Received: from alpha.herland ([84.210.6.167])
 by no-osl-m323-srv-004-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJD000H9SD9V660@no-osl-m323-srv-004-z1.isp.get.no> for
 git@vger.kernel.org; Sat, 09 Jun 2007 20:22:22 +0200 (CEST)
In-reply-to: <200706092019.13185.johan@herland.net>
Content-disposition: inline
User-Agent: KMail/1.9.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49594>

This code tries to implement the softrefs API as straightforwardly as
possible. Virtually no optimization has been done, although I do have
a feeling the code has ok performance as is.

All functions that do not appear in the API docs have some comments
attached to them.

There are also a couple of things to be considered before inclusion:
- File locking. Currently no locking is performed on softrefs files
  before reading or writing entries.
- Packing. We need a plan for how softrefs should be included in packs,
  at which supporting code must be added to this implementation.

Signed-off-by: Johan Herland <johan@herland.net>
---
 softrefs.c |  712 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 712 insertions(+), 0 deletions(-)
 create mode 100644 softrefs.c

diff --git a/softrefs.c b/softrefs.c
new file mode 100644
index 0000000..c7308c8
--- /dev/null
+++ b/softrefs.c
@@ -0,0 +1,712 @@
+#include "cache.h"
+#include "softrefs.h"
+
+/* constants */
+static const char *       UNSORTED_FILENAME    = "softrefs.unsorted";
+static const char *       SORTED_FILENAME      = "softrefs.sorted";
+static const unsigned int MAX_UNSORTED_ENTRIES = 1000;
+
+
+/* softref entry as it appears in a softrefs file */
+struct softrefs_entry {
+	char from_sha1_hex[40];
+	char space;
+	char to_sha1_hex[40];
+	char lf;
+};
+
+/* simple encapsulation of a softrefs file */
+struct softrefs_file {
+	char *filename;
+	int fd;
+	struct softrefs_entry *data; /* mmap()ed softrefs_entry objects */
+	unsigned long data_len;      /* # of softrefs_entry objects in data */
+};
+
+/* Internal file opened/closed by (de)init_softrefs_access() */
+static struct softrefs_file *internal_file = 0;
+
+/*
+ * Open and mmap() the given filename, Assign the file descriptior, data
+ * pointer and data length to the given softrefs_file object.
+ * Return 0 on success, -1 on failure.
+ *
+ * Note that a non-existing file is not a failure per se, but is rather treated
+ * as an empty file, i.e. there will be no data in the file structure
+ * (data_len == 0), but 0/sucess will be returned.
+ *
+ * The caller must _always_ call close_softrefs_file() with the same
+ * softrefs_file argument after processing the file data, even if no file
+ * is actually opened and/or this function returns -1.
+ */
+static int open_softrefs_file(const char *filename, struct softrefs_file *file)
+{
+	struct stat st;
+
+	/* Default "failure" values */
+	file->filename = xstrdup(filename);
+	file->fd = -1;
+	file->data = MAP_FAILED;
+	file->data_len = 0;
+
+	/* FIXME: File locking!? */
+	if (access(file->filename, F_OK))
+		return 0;
+	file->fd = open(file->filename, O_RDONLY);
+	if (file->fd < 0)
+		return error("Failed to open softrefs file %s: %s",
+				file->filename, strerror(errno));
+	if (fstat(file->fd, &st))
+		return error("Failed to fstat softrefs file %s: %s",
+				file->filename, strerror(errno));
+	if (st.st_size == 0) /* Empty file. No need to call mmap() */
+		return 0;
+	if (st.st_size % sizeof(struct softrefs_entry))
+		return error("Refuse to mmap softrefs file %s: File does not have whole number of softref entries",
+				file->filename);
+
+	file->data = xmmap(NULL, st.st_size, PROT_READ, MAP_PRIVATE, file->fd, 0);
+	if (file->data == MAP_FAILED)
+		return error("Failed to mmap softrefs file %s: %s",
+				file->filename, strerror(errno));
+
+	file->data_len = st.st_size / sizeof(struct softrefs_entry);
+
+	return 0;
+}
+
+/*
+ * Close the softrefs file identified by the given softrefs_file object.
+ * Return 0 on success, non-zero on failure.
+ */
+static int close_softrefs_file(const struct softrefs_file *file)
+{
+	int ret = 0;
+	if (file->data != MAP_FAILED &&
+	    munmap(file->data, file->data_len * sizeof(struct softrefs_entry)))
+	{
+		ret = error("Failed to munmap softrefs file %s: %s",
+				file->filename, strerror(errno));
+	}
+	if (file->fd != -1 && close(file->fd))
+		ret = error("Failed to close softrefs file %s: %s",
+				file->filename, strerror(errno));
+	free(file->filename);
+	return ret;
+}
+
+/*
+ * Write the given softrefs_entry to the given file descriptor, which must be
+ * open and writable.
+ *
+ * Returns 0 on success, non-zero on failure.
+ */
+static int write_entry(int fd, const struct softrefs_entry *entry)
+{
+	if (write(fd, (const void *) entry, sizeof(struct softrefs_entry))
+		< sizeof(struct softrefs_entry))
+	{
+		return error("Failed to write entry '%.40s -> %.40s' to softrefs file descriptor %i: %s",
+				entry->from_sha1_hex, entry->to_sha1_hex,
+				fd, strerror(errno));
+	}
+	return 0;
+}
+
+/* See softrefs.h for documentation */
+void init_softrefs_access()
+{
+	if (internal_file) /* already initialized */
+		return;
+
+	/* Force merge into sorted, so that we only have one file to search */
+	if (merge_unsorted_softrefs(NULL, 1))
+		return; /* merge failed */
+
+	internal_file = xmalloc(sizeof(struct softrefs_file));
+	if (open_softrefs_file(git_path(SORTED_FILENAME), internal_file)) {
+		free(internal_file);
+		internal_file = 0;
+	}
+}
+
+/* See softrefs.h for documentation */
+void deinit_softrefs_access()
+{
+	if (!internal_file) /* already deinitialized */
+		return;
+	close_softrefs_file(internal_file);
+	internal_file = 0;
+}
+
+/* comparison between a SHA1 sum and a softrefs entry */
+static int sha1_to_entry_cmp(
+	const unsigned char *from_sha1, const struct softrefs_entry *entry)
+{
+	unsigned char sha1[20];
+	get_sha1_hex(entry->from_sha1_hex, sha1);
+	return hashcmp(from_sha1, sha1);
+}
+
+/* comparison between softrefs entries */
+static int softrefs_entry_cmp(
+		const struct softrefs_entry *a, const struct softrefs_entry *b)
+{
+	unsigned char sa[20], sb[20];
+	int ret;
+	get_sha1_hex(a->from_sha1_hex, sa);
+	get_sha1_hex(b->from_sha1_hex, sb);
+	ret = hashcmp(sa, sb);
+	if (!ret) {
+		get_sha1_hex(a->to_sha1_hex, sa);
+		get_sha1_hex(b->to_sha1_hex, sb);
+		ret = hashcmp(sa, sb);
+	}
+	return ret;
+}
+
+/* comparison between softrefs entries as invoked by qsort() */
+static int softrefs_entry_qsort_cmp(const void *a, const void *b)
+{
+	const struct softrefs_entry *na = *((const struct softrefs_entry **) a);
+	const struct softrefs_entry *nb = *((const struct softrefs_entry **) b);
+	return softrefs_entry_cmp(na, nb);
+}
+
+
+/*
+ * Sequentially process given 'file' starting at index 'i'
+ *
+ * For each entry matching 'from_sha1' (if NULL, match all entries), invoke
+ * callback function 'fn' with the from_sha1 and to_sha1 of the matching
+ * softref. Keep going until 'fn' returns non-zero, or end of file is reached.
+ *
+ * If the 'stop_at_first_non_match' flag is set, processing will stop when the
+ * first non-matching entry is encountered.
+ *
+ * Returns result of 'fn' if non-zero; otherwise 0 on success and -1 on failure.
+ */
+static int do_for_each_sequential(
+		const unsigned char *from_sha1,
+		each_softref_fn fn, void *cb_data,
+		struct softrefs_file *file,
+		unsigned long i,
+		int stop_at_first_non_match)
+{
+	unsigned char f_sha1[20], t_sha1[20]; /* Holds sha1 per entry */
+	int ret = 0;
+	for (; i < file->data_len; ++i) { /* Step through file, starting at i */
+		/* sanity check entry */
+		if (file->data[i].space != ' ' || file->data[i].lf != '\n') {
+			ret = error("Entry #%lu in softrefs file %s failed sanity check",
+					i, file->filename);
+			break;
+		}
+		/* retrieve SHA1 values */
+		if (get_sha1_hex(file->data[i].from_sha1_hex, f_sha1) ||
+		    get_sha1_hex(file->data[i].to_sha1_hex,   t_sha1)) {
+			ret = error("Failed to read SHA1 values from entry #%lu in softrefs file %s",
+					i, file->filename);
+			break;
+		}
+		/* Compare to lookup value */
+		if (!from_sha1 || !hashcmp(from_sha1, f_sha1)) {
+			if ((ret = fn(f_sha1, t_sha1, cb_data)))
+				break; /* bail out if callback returns != 0 */
+		}
+		else if (stop_at_first_non_match)
+			break;
+	}
+	return ret;
+}
+
+/* Invoke callback 'fn' for each matching entry in UNSORTED_FILENAME */
+static int do_for_each_unsorted(
+		const unsigned char *from_sha1,
+		each_softref_fn fn, void *cb_data)
+{
+	struct softrefs_file file;
+	int ret = 0;
+
+	if (internal_file)
+		/*
+		 * internal_file is open. Unsorted entries are merged just
+		 * before opening internal_file (in init_softrefs_access()).
+		 * Since internal_file is still open, no entries have been
+		 * added since last merge, meaning that there can be no
+		 * unsorted entries in the db, and thus no unsorted file.
+		 * Therefore return immediate success.
+		 */
+		return 0;
+
+	if (!(ret = open_softrefs_file(git_path(UNSORTED_FILENAME), &file)))
+		ret = do_for_each_sequential(from_sha1, fn, cb_data, &file, 0, 0);
+
+	close_softrefs_file(&file);
+	return ret;
+}
+
+/* Invoke callback 'fn' for each matching entry in SORTED_FILENAME */
+static int do_for_each_sorted(
+		const unsigned char *from_sha1,
+		each_softref_fn fn, void *cb_data)
+{
+	struct softrefs_file *file;
+	unsigned long i, left, right;
+	int cmp_result;
+	int ret = 0;
+
+	if (internal_file) /* use already open internal_file */
+		file = internal_file;
+	else { /* open file ourselves */
+		file = xmalloc(sizeof(struct softrefs_file));
+		if ((ret = open_softrefs_file(git_path(SORTED_FILENAME), file)))
+			goto done;
+	}
+	if (!file->data_len) /* no entries */
+		goto done;
+
+	if (!from_sha1) { /* match _all_ entries; do sequential walk instead */
+		ret = do_for_each_sequential(from_sha1, fn, cb_data, file, 0, 0);
+		goto done;
+	}
+
+	/* Calculate first index by 256-fanout */
+	left = 0;
+	right = file->data_len;
+	i = (from_sha1[0] * file->data_len) / 256;
+
+	/* Binary search */
+	while ((cmp_result = sha1_to_entry_cmp(from_sha1, &(file->data[i])))) {
+		if (right - left <= 1) /* not found; give up */
+			goto done;
+		if (cmp_result > 0) /* go right */
+			left = i + 1;
+		else /* go left */
+			right = i;
+		i = (left + right) / 2;
+	}
+
+	/* i points to a matching entry, but not necessarily the first */
+	while (i >= 1 && sha1_to_entry_cmp(from_sha1, &(file->data[i - 1])) == 0)
+		--i;
+
+	/* i points to the first matching entry */
+	/* do sequential processing from i, stopping at first non-match */
+	ret = do_for_each_sequential(from_sha1, fn, cb_data, file, i, 1);
+
+done:
+	if (!internal_file) { /* only close if we opened ourselves */
+		close_softrefs_file(file);
+		free(file);
+	}
+	return ret;
+}
+
+/* See softrefs.h for documentation */
+int for_each_softref_with_from(
+		const unsigned char *from_sha1,
+		each_softref_fn fn, void *cb_data)
+{
+	int ret = do_for_each_unsorted(from_sha1, fn, cb_data);
+	if (ret)
+		return ret;
+	ret = do_for_each_sorted(from_sha1, fn, cb_data);
+	return ret;
+}
+
+/* See softrefs.h for documentation */
+int for_each_softref(each_softref_fn fn, void *cb_data)
+{
+	return for_each_softref_with_from(0, fn, cb_data);
+}
+
+static int lookup_softref_helper(
+		const unsigned char *from_sha1, const unsigned char *to_sha1,
+		void *cb_data)
+{
+	struct softref_list **prev = (struct softref_list **) cb_data;
+
+	struct softref_list *current = xmalloc(sizeof(struct softref_list));
+	current->next = *prev;
+	hashcpy(current->from_sha1, from_sha1);
+	hashcpy(current->to_sha1, to_sha1);
+	*prev = current;
+	return 0;
+}
+
+/* See softrefs.h for documentation */
+struct softref_list *lookup_softref(const unsigned char *from_sha1)
+{
+	struct softref_list *result = NULL;
+	struct softref_list **p = &result;
+	if (for_each_softref_with_from(
+			from_sha1, lookup_softref_helper, (void *) p))
+	{
+		delete_softref_list(result);
+		result = NULL;
+	}
+	return result;
+}
+
+/* See softrefs.h for documentation */
+void delete_softref_list(struct softref_list *list)
+{
+	while (list) {
+		struct softref_list *next = list->next;
+		free(list);
+		list = next;
+	}
+}
+
+static int has_softref_helper(
+		const unsigned char *from_sha1, const unsigned char *to_sha1,
+		void *cb_data)
+{
+	const unsigned char *needle = (const unsigned char *) cb_data;
+	if (!hashcmp(to_sha1, needle))
+		return 1; /* found */
+	return 0; /* keep going */
+}
+
+/* See softrefs.h for documentation */
+int has_softref(const unsigned char *from_sha1, const unsigned char *to_sha1)
+{
+	int ret = for_each_softref_with_from(
+			from_sha1, has_softref_helper, (void *) to_sha1);
+	return ret == 1 ? 1 : 0;
+}
+
+
+/*
+ * Merge the unsorted softref entries in unsorted_filename into sorted_filename
+ *
+ * Returns 0 on success; non-zero on failure.
+ *
+ * If sorted_filename does not exist, the entries in unsorted_filename will be
+ * sorted and stored into sorted_filename.
+ * If unsorted_filename does not exist, this function will do nothing and
+ * return 0.
+ */
+static int merge_unsorted_into_sorted(
+		const char *unsorted_filename, const char *sorted_filename)
+{
+	struct softrefs_file unsorted, sorted;
+	char *result_filename = 0;
+	int result_fd = -1;
+	int ret = 0;
+	unsigned long i, j;
+	/* array of pointers to softrefs_entries in unsorted file */
+	struct softrefs_entry **to_insert;
+	/* keep track of last processed entry, to remove duplicates */
+	struct softrefs_entry *prev = NULL;
+
+	/* Open input files */
+	deinit_softrefs_access();
+	open_softrefs_file(unsorted_filename, &unsorted);
+	if (!unsorted.data_len) { /* no unsorted entries; nothing to do */
+		close_softrefs_file(&unsorted);
+		return 0;
+	}
+	open_softrefs_file(sorted_filename, &sorted);
+
+	/* Sort the unsorted entries */
+	to_insert = xmalloc(sizeof(struct softrefs_entry *) * unsorted.data_len);
+	for (i = 0; i < unsorted.data_len; ++i)
+		to_insert[i] = &(unsorted.data[i]);
+	qsort(to_insert, unsorted.data_len, sizeof(struct softrefs_entry *),
+			softrefs_entry_qsort_cmp);
+
+	/* Create result file */
+	result_filename = xmalloc(strlen(sorted_filename) + 4);
+	sprintf(result_filename, "%s.new", sorted_filename);
+	result_fd = open(result_filename, O_WRONLY|O_CREAT|O_EXCL|O_TRUNC, 0666);
+	if (result_fd < 0) {
+		ret = error("Failed to open merge result file %s: %s",
+				result_filename, strerror(errno));
+		goto done;
+	}
+
+	i = 0; /* index into to_insert (the sorted version of unsorted.data) */
+	j = 0; /* index into sorted.data */
+	while (!ret && (i < unsorted.data_len || j < sorted.data_len)) {
+		/* there are still entries in either list */
+		struct softrefs_entry *cur;
+		unsigned char from_sha1[20], to_sha1[20];
+		if (i < unsorted.data_len && j < sorted.data_len) {
+			/* there are still entries in _both_ lists */
+			/* choose "lowest" entry from either list */
+			if (softrefs_entry_cmp(to_insert[i], &(sorted.data[j])) < 0)
+				cur = to_insert[i++];
+			else
+				cur = &(sorted.data[j++]);
+		}
+		else if (i < unsorted.data_len) /* entries left in to_insert */
+			cur = to_insert[i++];
+		else /* entries left in sorted.data */
+			cur = &(sorted.data[j++]);
+
+		if (prev && !softrefs_entry_cmp(prev, cur))
+			continue; /* skip writing if prev == cur */
+		prev = cur;
+
+		/* skip writing if softref involves a non-existing object */
+		if (get_sha1_hex(cur->from_sha1_hex, from_sha1) ||
+			!has_sha1_file(from_sha1) ||
+		    get_sha1_hex(cur->to_sha1_hex,     to_sha1) ||
+			!has_sha1_file(  to_sha1))
+		{
+			continue;
+		}
+
+		ret = write_entry(result_fd, cur);
+	}
+
+done:
+	if (result_fd >= 0 && close(result_fd))
+		ret = error("Failed to close merge result file %s: %s",
+				result_filename, strerror(errno));
+	close_softrefs_file(&sorted);
+	close_softrefs_file(&unsorted);
+	if (ret) { /* Failure. Delete result_filename */
+		if (result_filename && unlink(result_filename))
+			error("Failed to remove merge result file %s: %s",
+					result_filename, strerror(errno));
+	}
+	else { /* Success. Replace sorted_filename with result_filename */
+		if (rename(result_filename, sorted_filename))
+			ret = error("Failed to replace sorted softrefs file %s: %s",
+					sorted_filename, strerror(errno));
+	}
+	return ret;
+}
+
+/*
+ * Merge the sorted softref entries in 'from_file' into 'to_file'
+ *
+ * Returns 0 on success; non-zero on failure.
+ *
+ * If to_file does not exist, from_file will be copied into to_file.
+ * If from_file does not exist, this function will do nothing and return 0.
+ */
+static int merge_sorted_into_sorted(const char *from_file, const char *to_file)
+{
+	struct softrefs_file file1, file2;
+	char *result_filename = 0;
+	int result_fd = -1;
+	int ret = 0;
+	unsigned long i, j;
+	/* keep track of last processed entry, to remove duplicates */
+	struct softrefs_entry *prev = NULL;
+
+	/* Open input files */
+	deinit_softrefs_access();
+	open_softrefs_file(from_file, &file1);
+	if (!file1.data_len) { /* no entries; nothing to do */
+		close_softrefs_file(&file1);
+		return 0;
+	}
+	open_softrefs_file(to_file, &file2);
+
+	/* Create result file */
+	result_filename = xmalloc(strlen(to_file) + 4);
+	sprintf(result_filename, "%s.new", to_file);
+	result_fd = open(result_filename, O_WRONLY|O_CREAT|O_EXCL|O_TRUNC, 0666);
+	if (result_fd < 0) {
+		ret = error("Failed to open merge result file %s: %s",
+				result_filename, strerror(errno));
+		goto done;
+	}
+
+	i = 0; /* index into file1.data */
+	j = 0; /* index into file2.data */
+	while (!ret && (i < file1.data_len || j < file2.data_len)) {
+		/* there are still entries in either list */
+		struct softrefs_entry *cur;
+		unsigned char from_sha1[20], to_sha1[20];
+		if (i < file1.data_len && j < file2.data_len) {
+			/* there are still entries in _both_ lists */
+			/* choose "lowest" entry from either list */
+			if (softrefs_entry_cmp(&(file1.data[i]), &(file2.data[j])) < 0)
+				cur = &(file1.data[i++]);
+			else
+				cur = &(file2.data[j++]);
+		}
+		else if (i < file1.data_len) /* entries left in file1.data */
+			cur = &(file1.data[i++]);
+		else                         /* entries left in file2.data */
+			cur = &(file2.data[j++]);
+
+		if (prev && !softrefs_entry_cmp(prev, cur))
+			continue; /* skip writing if cur and prev are duplicates */
+		prev = cur;
+
+		/* skip writing if softref involves a non-existing object */
+		if (get_sha1_hex(cur->from_sha1_hex, from_sha1) ||
+			!has_sha1_file(from_sha1) ||
+		    get_sha1_hex(cur->to_sha1_hex,     to_sha1) ||
+			!has_sha1_file(  to_sha1))
+		{
+			continue;
+		}
+
+		ret = write_entry(result_fd, cur);
+	}
+
+done:
+	if (result_fd >= 0 && close(result_fd))
+		ret = error("Failed to close merge result file %s: %s",
+				result_filename, strerror(errno));
+	close_softrefs_file(&file2);
+	close_softrefs_file(&file1);
+	if (ret) { /* Failure. Delete result_filename */
+		if (result_filename && unlink(result_filename))
+			error("Failed to remove merge result file %s: %s",
+					result_filename, strerror(errno));
+	}
+	else { /* Success. Replace to_file with result_filename */
+		if (rename(result_filename, to_file))
+			ret = error("Failed to replace sorted softrefs file %s: %s",
+					to_file, strerror(errno));
+	}
+	return ret;
+}
+
+/* See softrefs.h for documentation */
+int add_softrefs(const struct softref_list *list)
+{
+	struct softrefs_entry entry;
+	int fd;
+	struct stat st;
+	int ret = 0;
+
+	/* Close internal softrefs file, if initialized. */
+	deinit_softrefs_access();
+
+	/* FIXME: File locking!? */
+	fd = open(git_path(UNSORTED_FILENAME), O_WRONLY|O_APPEND|O_CREAT, 0666);
+	if (fd < 0)
+		return error("Failed to open softrefs file %s: %s",
+				git_path(UNSORTED_FILENAME), strerror(errno));
+	if (fstat(fd, &st))
+		return error("Failed to fstat softrefs file %s: %s",
+				git_path(UNSORTED_FILENAME), strerror(errno));
+	if (st.st_size % sizeof(struct softrefs_entry))
+		return error("Refuse to edit softrefs file %s: File does not have whole number of softref entries",
+				git_path(UNSORTED_FILENAME));
+
+	/* File is open; start writing entries */
+	while (list) {
+		if (!hashcmp(list->from_sha1, list->to_sha1)) {
+			/* self-reference: from_sha1 == to_sha1 */
+			error("Cannot add self-reference (%s -> %s)",
+					sha1_to_hex(list->from_sha1),
+					sha1_to_hex(list->to_sha1));
+		}
+		else if (has_softref(list->from_sha1, list->to_sha1)) {
+			/* softref exists already */
+			/* nada */;
+		}
+		else {  /* softref is ok */
+			strcpy(entry.from_sha1_hex, sha1_to_hex(list->from_sha1));
+			strcpy(entry.to_sha1_hex, sha1_to_hex(list->to_sha1));
+			entry.space = ' ';
+			entry.lf = '\n';
+			if (write_entry(fd, &entry))
+				error("Failed to write entry to softrefs file %s: %s",
+						git_path(UNSORTED_FILENAME),
+						strerror(errno));
+			else /* write_entry() succeeded */
+				ret++;
+		}
+		list = list->next;
+	}
+
+	/* finished writing entries */
+	if (close(fd))
+		return error("Failed to close softrefs file %s: %s",
+				git_path(UNSORTED_FILENAME), strerror(errno));
+
+	merge_unsorted_softrefs(NULL, 0);
+	return ret;
+}
+
+/* See softrefs.h for documentation */
+int add_softref(const unsigned char *from_sha1, const unsigned char *to_sha1)
+{
+	struct softref_list l;
+	int ret;
+
+	if (!hashcmp(from_sha1, to_sha1))
+		return error("Cannot add self-reference (%s -> %s)",
+			sha1_to_hex(from_sha1), sha1_to_hex(to_sha1));
+
+	hashcpy(l.from_sha1, from_sha1);
+	hashcpy(l.to_sha1, to_sha1);
+	l.next = NULL;
+	ret = add_softrefs(&l);
+	switch (ret) {
+		case 0:  return 1;
+		case 1:  return 0;
+		default: return -1;
+	}
+}
+
+/* See softrefs.h for documentation */
+int merge_unsorted_softrefs(const char *unsorted_file, int force)
+{
+	struct stat st;
+	int num_entries;
+	int delete_file = 0; /* set to true to delete unsorted_file afterwards */
+	int ret = 0;
+
+	if (unsorted_file == NULL) { /* use UNSORTED_FILENAME */
+		unsorted_file = git_path(UNSORTED_FILENAME);
+		delete_file = 1;
+		if (access(unsorted_file, F_OK))
+			/* UNSORTED_FILENAME doesn't exist; nothing to do */
+			return 0;
+	}
+	else {
+		force = 1; /* no threshold on merging external file */
+		if (access(unsorted_file, F_OK))
+			/* external unsorted file doesn't exist; failure */
+			return error("Failed to access softrefs file %s: %s",
+					unsorted_file, strerror(errno));
+	}
+
+	if (stat(unsorted_file, &st))
+		return error("Failed to stat() softrefs file %s: %s",
+				unsorted_file, strerror(errno));
+	if (st.st_size % sizeof(struct softrefs_entry))
+		return error("Corrupt softrefs file %s: Aborting",
+				unsorted_file);
+	if (st.st_size == 0) /* file is empty; nothing to do */
+		return 0;
+	num_entries = st.st_size / sizeof(struct softrefs_entry);
+	if (force || num_entries > MAX_UNSORTED_ENTRIES) { /* do it */
+		ret = merge_unsorted_into_sorted(
+				unsorted_file, git_path(SORTED_FILENAME));
+		if (!ret && delete_file && unlink(unsorted_file))
+			error("Failed to remove unsorted softrefs file %s: %s",
+					unsorted_file, strerror(errno));
+	}
+	return ret;
+}
+
+/* See softrefs.h for documentation */
+int merge_sorted_softrefs(const char *sorted_file)
+{
+	struct stat st;
+	if (access(sorted_file, F_OK)) /* external file doesn't exist; FAIL */
+		return error("Failed to access softrefs file %s: %s",
+				sorted_file, strerror(errno));
+	if (stat(sorted_file, &st))
+		return error("Failed to stat() softrefs file %s: %s",
+				sorted_file, strerror(errno));
+	if (st.st_size % sizeof(struct softrefs_entry))
+		return error("Corrupt softrefs file %s: Aborting", sorted_file);
+	if (st.st_size == 0) /* file is empty; nothing to do */
+		return 0;
+	return merge_sorted_into_sorted(sorted_file, git_path(SORTED_FILENAME));
+}
-- 
1.5.2.1.144.gabc40
