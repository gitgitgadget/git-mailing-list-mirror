From: Jeff King <peff@peff.net>
Subject: [PATCH v3 09/22] use xmallocz to avoid size arithmetic
Date: Mon, 22 Feb 2016 17:44:28 -0500
Message-ID: <20160222224428.GI10075@sigill.intra.peff.net>
References: <20160222224059.GA3857@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 22 23:44:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXzDa-00053o-1U
	for gcvg-git-2@plane.gmane.org; Mon, 22 Feb 2016 23:44:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756086AbcBVWoe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2016 17:44:34 -0500
Received: from cloud.peff.net ([50.56.180.127]:47078 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756015AbcBVWob (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2016 17:44:31 -0500
Received: (qmail 21679 invoked by uid 102); 22 Feb 2016 22:44:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 22 Feb 2016 17:44:31 -0500
Received: (qmail 23050 invoked by uid 107); 22 Feb 2016 22:44:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 22 Feb 2016 17:44:38 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 22 Feb 2016 17:44:28 -0500
Content-Disposition: inline
In-Reply-To: <20160222224059.GA3857@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286978>

We frequently allocate strings as xmalloc(len + 1), where
the extra 1 is for the NUL terminator. This can be done more
simply with xmallocz, which also checks for integer
overflow.

There's no case where switching xmalloc(n+1) to xmallocz(n)
is wrong; the result is the same length, and malloc made no
guarantees about what was in the buffer anyway. But in some
cases, we can stop manually placing NUL at the end of the
allocated buffer. But that's only safe if it's clear that
the contents will always fill the buffer.

In each case where this patch does so, I manually examined
the control flow, and I tried to err on the side of caution.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/check-ref-format.c | 2 +-
 builtin/merge-tree.c       | 2 +-
 builtin/worktree.c         | 2 +-
 column.c                   | 3 +--
 combine-diff.c             | 4 +---
 config.c                   | 4 +---
 dir.c                      | 2 +-
 entry.c                    | 2 +-
 grep.c                     | 3 +--
 imap-send.c                | 5 ++---
 ll-merge.c                 | 2 +-
 progress.c                 | 2 +-
 refs.c                     | 2 +-
 setup.c                    | 5 ++---
 strbuf.c                   | 2 +-
 15 files changed, 17 insertions(+), 25 deletions(-)

diff --git a/builtin/check-ref-format.c b/builtin/check-ref-format.c
index fd915d5..eac4994 100644
--- a/builtin/check-ref-format.c
+++ b/builtin/check-ref-format.c
@@ -20,7 +20,7 @@ static const char builtin_check_ref_format_usage[] =
  */
 static char *collapse_slashes(const char *refname)
 {
-	char *ret = xmalloc(strlen(refname) + 1);
+	char *ret = xmallocz(strlen(refname));
 	char ch;
 	char prev = '/';
 	char *cp = ret;
diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index d4f0cbd..ca57004 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -174,7 +174,7 @@ static struct merge_list *create_entry(unsigned stage, unsigned mode, const unsi
 
 static char *traverse_path(const struct traverse_info *info, const struct name_entry *n)
 {
-	char *path = xmalloc(traverse_path_len(info, n) + 1);
+	char *path = xmallocz(traverse_path_len(info, n));
 	return make_traverse_path(path, info, n);
 }
 
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 475b958..0a45710 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -52,7 +52,7 @@ static int prune_worktree(const char *id, struct strbuf *reason)
 		return 1;
 	}
 	len = st.st_size;
-	path = xmalloc(len + 1);
+	path = xmallocz(len);
 	read_in_full(fd, path, len);
 	close(fd);
 	while (len && (path[len - 1] == '\n' || path[len - 1] == '\r'))
diff --git a/column.c b/column.c
index f9fda68..d55ead1 100644
--- a/column.c
+++ b/column.c
@@ -173,9 +173,8 @@ static void display_table(const struct string_list *list,
 	if (colopts & COL_DENSE)
 		shrink_columns(&data);
 
-	empty_cell = xmalloc(initial_width + 1);
+	empty_cell = xmallocz(initial_width);
 	memset(empty_cell, ' ', initial_width);
-	empty_cell[initial_width] = '\0';
 	for (y = 0; y < data.rows; y++) {
 		for (x = 0; x < data.cols; x++)
 			if (display_cell(&data, initial_width, empty_cell, x, y))
diff --git a/combine-diff.c b/combine-diff.c
index a698016..890c415 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -1043,7 +1043,7 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
 				elem->mode = canon_mode(S_IFLNK);
 
 			result_size = len;
-			result = xmalloc(len + 1);
+			result = xmallocz(len);
 
 			done = read_in_full(fd, result, len);
 			if (done < 0)
@@ -1051,8 +1051,6 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
 			else if (done < len)
 				die("early EOF '%s'", elem->path);
 
-			result[len] = 0;
-
 			/* If not a fake symlink, apply filters, e.g. autocrlf */
 			if (is_file) {
 				struct strbuf buf = STRBUF_INIT;
diff --git a/config.c b/config.c
index b95ac3a..e7b589a 100644
--- a/config.c
+++ b/config.c
@@ -1902,7 +1902,7 @@ static int git_config_parse_key_1(const char *key, char **store_key, int *basele
 	 * Validate the key and while at it, lower case it for matching.
 	 */
 	if (store_key)
-		*store_key = xmalloc(strlen(key) + 1);
+		*store_key = xmallocz(strlen(key));
 
 	dot = 0;
 	for (i = 0; key[i]; i++) {
@@ -1926,8 +1926,6 @@ static int git_config_parse_key_1(const char *key, char **store_key, int *basele
 		if (store_key)
 			(*store_key)[i] = c;
 	}
-	if (store_key)
-		(*store_key)[i] = 0;
 
 	return 0;
 
diff --git a/dir.c b/dir.c
index 66c93c1..6c627d5 100644
--- a/dir.c
+++ b/dir.c
@@ -711,7 +711,7 @@ static int add_excludes(const char *fname, const char *base, int baselen,
 			close(fd);
 			return 0;
 		}
-		buf = xmalloc(size+1);
+		buf = xmallocz(size);
 		if (read_in_full(fd, buf, size) != size) {
 			free(buf);
 			close(fd);
diff --git a/entry.c b/entry.c
index 582c400..a410957 100644
--- a/entry.c
+++ b/entry.c
@@ -6,7 +6,7 @@
 static void create_directories(const char *path, int path_len,
 			       const struct checkout *state)
 {
-	char *buf = xmalloc(path_len + 1);
+	char *buf = xmallocz(path_len);
 	int len = 0;
 
 	while (len < path_len) {
diff --git a/grep.c b/grep.c
index 7b2b96a..528b652 100644
--- a/grep.c
+++ b/grep.c
@@ -1741,7 +1741,7 @@ static int grep_source_load_file(struct grep_source *gs)
 	i = open(filename, O_RDONLY);
 	if (i < 0)
 		goto err_ret;
-	data = xmalloc(size + 1);
+	data = xmallocz(size);
 	if (st.st_size != read_in_full(i, data, size)) {
 		error(_("'%s': short read %s"), filename, strerror(errno));
 		close(i);
@@ -1749,7 +1749,6 @@ static int grep_source_load_file(struct grep_source *gs)
 		return -1;
 	}
 	close(i);
-	data[size] = 0;
 
 	gs->buf = data;
 	gs->size = size;
diff --git a/imap-send.c b/imap-send.c
index 4d3b773..2c52027 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -892,12 +892,11 @@ static char *cram(const char *challenge_64, const char *user, const char *pass)
 	response = xstrfmt("%s %s", user, hex);
 	resp_len = strlen(response) + 1;
 
-	response_64 = xmalloc(ENCODED_SIZE(resp_len) + 1);
+	response_64 = xmallocz(ENCODED_SIZE(resp_len));
 	encoded_len = EVP_EncodeBlock((unsigned char *)response_64,
 				      (unsigned char *)response, resp_len);
 	if (encoded_len < 0)
 		die("EVP_EncodeBlock error");
-	response_64[encoded_len] = '\0';
 	return (char *)response_64;
 }
 
@@ -1188,7 +1187,7 @@ static void lf_to_crlf(struct strbuf *msg)
 		j++;
 	}
 
-	new = xmalloc(j + 1);
+	new = xmallocz(j);
 
 	/*
 	 * Second pass: write the new string.  Note that this loop is
diff --git a/ll-merge.c b/ll-merge.c
index 0338630..ff4a43a 100644
--- a/ll-merge.c
+++ b/ll-merge.c
@@ -205,7 +205,7 @@ static int ll_ext_merge(const struct ll_merge_driver *fn,
 	if (fstat(fd, &st))
 		goto close_bad;
 	result->size = st.st_size;
-	result->ptr = xmalloc(result->size + 1);
+	result->ptr = xmallocz(result->size);
 	if (read_in_full(fd, result->ptr, result->size) != result->size) {
 		free(result->ptr);
 		result->ptr = NULL;
diff --git a/progress.c b/progress.c
index 353bd37..76a88c5 100644
--- a/progress.c
+++ b/progress.c
@@ -247,7 +247,7 @@ void stop_progress_msg(struct progress **p_progress, const char *msg)
 		size_t len = strlen(msg) + 5;
 		struct throughput *tp = progress->throughput;
 
-		bufp = (len < sizeof(buf)) ? buf : xmalloc(len + 1);
+		bufp = (len < sizeof(buf)) ? buf : xmallocz(len);
 		if (tp) {
 			unsigned int rate = !tp->avg_misecs ? 0 :
 					tp->avg_bytes / tp->avg_misecs;
diff --git a/refs.c b/refs.c
index e2d34b2..1d9e2a7 100644
--- a/refs.c
+++ b/refs.c
@@ -124,7 +124,7 @@ int refname_is_safe(const char *refname)
 		char *buf;
 		int result;
 
-		buf = xmalloc(strlen(refname) + 1);
+		buf = xmallocz(strlen(refname));
 		/*
 		 * Does the refname try to escape refs/?
 		 * For example: refs/foo/../bar is safe but refs/foo/../../bar
diff --git a/setup.c b/setup.c
index 0deb022..ab21086 100644
--- a/setup.c
+++ b/setup.c
@@ -88,7 +88,7 @@ char *prefix_path_gently(const char *prefix, int len,
 	const char *orig = path;
 	char *sanitized;
 	if (is_absolute_path(orig)) {
-		sanitized = xmalloc(strlen(path) + 1);
+		sanitized = xmallocz(strlen(path));
 		if (remaining_prefix)
 			*remaining_prefix = 0;
 		if (normalize_path_copy_len(sanitized, path, remaining_prefix)) {
@@ -488,14 +488,13 @@ const char *read_gitfile_gently(const char *path, int *return_error_code)
 		error_code = READ_GITFILE_ERR_OPEN_FAILED;
 		goto cleanup_return;
 	}
-	buf = xmalloc(st.st_size + 1);
+	buf = xmallocz(st.st_size);
 	len = read_in_full(fd, buf, st.st_size);
 	close(fd);
 	if (len != st.st_size) {
 		error_code = READ_GITFILE_ERR_READ_FAILED;
 		goto cleanup_return;
 	}
-	buf[len] = '\0';
 	if (!starts_with(buf, "gitdir: ")) {
 		error_code = READ_GITFILE_ERR_INVALID_FORMAT;
 		goto cleanup_return;
diff --git a/strbuf.c b/strbuf.c
index bab316d..f60e2ee 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -718,7 +718,7 @@ char *xstrdup_tolower(const char *string)
 	size_t len, i;
 
 	len = strlen(string);
-	result = xmalloc(len + 1);
+	result = xmallocz(len);
 	for (i = 0; i < len; i++)
 		result[i] = tolower(string[i]);
 	result[i] = '\0';
-- 
2.7.2.645.g4e1306c
