Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C1F27202A5
	for <e@80x24.org>; Mon, 25 Sep 2017 20:33:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935802AbdIYUd1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Sep 2017 16:33:27 -0400
Received: from cloud.peff.net ([104.130.231.41]:49626 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S934254AbdIYUd0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2017 16:33:26 -0400
Received: (qmail 2652 invoked by uid 109); 25 Sep 2017 20:33:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 25 Sep 2017 20:33:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28565 invoked by uid 111); 25 Sep 2017 20:34:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Mon, 25 Sep 2017 16:34:04 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 25 Sep 2017 16:33:24 -0400
Date:   Mon, 25 Sep 2017 16:33:24 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 7/7] add xread_in_full() helper
Message-ID: <20170925203323.rmm3i5kx266ma3wu@sigill.intra.peff.net>
References: <20170925202646.agsnpmar3dzocdcr@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170925202646.agsnpmar3dzocdcr@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Many callers of read_in_full() expect to see exactly "len"
bytes, and die if that isn't the case. Since there are two
interesting error cases:

  1. We saw a read() error.

  2. We saw EOF with fewer bytes than expected.

we would ideally distinguish between them when reporting to
the user. Let's add a helper to make this easier. We can
convert cases that currently lump the two conditions
together (improving their error messages) and ones that
already distinguish (shortening their code).

There are a number of read_in_full() calls left that we
can't (or shouldn't) convert, for one or more of these
reasons:

 - Some are not trying to read an exact number in the first
   place. So they only care about case 1, and are fine.

 - Some call error() instead of die(). We could possibly
   accommodate these, at the expense of making our helper a
   bit more clunky.

 - Some print nothing and return a failing code up the
   stack, in which case somebody eventually looks at errno.
   Handling these with a helper would be hard. Ideally there
   would be some errno value that we could set for short
   read, but there's no standard one (ENODATA is kind-of
   accurate, but it's not really "no data"; it's "not enough
   data", and we wouldn't want to get confused with a real
   ENODATA error).

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/get-tar-commit-id.c |  3 +--
 bulk-checkin.c              |  4 +---
 cache.h                     |  7 +++++++
 combine-diff.c              |  8 +-------
 csum-file.c                 |  6 +-----
 pack-write.c                |  3 +--
 wrapper.c                   | 11 +++++++++++
 7 files changed, 23 insertions(+), 19 deletions(-)

diff --git a/builtin/get-tar-commit-id.c b/builtin/get-tar-commit-id.c
index 259ad40339..0b97196afc 100644
--- a/builtin/get-tar-commit-id.c
+++ b/builtin/get-tar-commit-id.c
@@ -24,8 +24,7 @@ int cmd_get_tar_commit_id(int argc, const char **argv, const char *prefix)
 	if (argc != 1)
 		usage(builtin_get_tar_commit_id_usage);
 
-	if (read_in_full(0, buffer, HEADERSIZE) != HEADERSIZE)
-		die_errno("git get-tar-commit-id: read error");
+	xread_in_full(0, buffer, HEADERSIZE, "stdin");
 	if (header->typeflag[0] != 'g')
 		return 1;
 	if (!skip_prefix(content, "52 comment=", &comment))
diff --git a/bulk-checkin.c b/bulk-checkin.c
index 9a1f6c49ab..a9743785fb 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -115,9 +115,7 @@ static int stream_to_pack(struct bulk_checkin_state *state,
 
 		if (size && !s.avail_in) {
 			ssize_t rsize = size < sizeof(ibuf) ? size : sizeof(ibuf);
-			if (read_in_full(fd, ibuf, rsize) != rsize)
-				die("failed to read %d bytes from '%s'",
-				    (int)rsize, path);
+			xread_in_full(fd, ibuf, rsize, path);
 			offset += rsize;
 			if (*already_hashed_to < offset) {
 				size_t hsize = offset - *already_hashed_to;
diff --git a/cache.h b/cache.h
index 49b083ee0a..deec532228 100644
--- a/cache.h
+++ b/cache.h
@@ -1757,6 +1757,13 @@ extern ssize_t read_in_full(int fd, void *buf, size_t count);
 extern ssize_t write_in_full(int fd, const void *buf, size_t count);
 extern ssize_t pread_in_full(int fd, void *buf, size_t count, off_t offset);
 
+/*
+ * Like read_in_full(), but die on errors or a failure to read exactly "count"
+ * bytes. The "desc" string will be inserted into the error message as "reading
+ * %s".
+ */
+extern void xread_in_full(int fd, void *buf, size_t count, const char *desc);
+
 static inline ssize_t write_str_in_full(int fd, const char *str)
 {
 	return write_in_full(fd, str, strlen(str));
diff --git a/combine-diff.c b/combine-diff.c
index 9e163d5ada..4bdf797a10 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -1027,7 +1027,6 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
 			free_filespec(df);
 		} else if (0 <= (fd = open(elem->path, O_RDONLY))) {
 			size_t len = xsize_t(st.st_size);
-			ssize_t done;
 			int is_file, i;
 
 			elem->mode = canon_mode(st.st_mode);
@@ -1042,12 +1041,7 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
 
 			result_size = len;
 			result = xmallocz(len);
-
-			done = read_in_full(fd, result, len);
-			if (done < 0)
-				die_errno("read error '%s'", elem->path);
-			else if (done < len)
-				die("early EOF '%s'", elem->path);
+			xread_in_full(fd, result, len, elem->path);
 
 			/* If not a fake symlink, apply filters, e.g. autocrlf */
 			if (is_file) {
diff --git a/csum-file.c b/csum-file.c
index a172199e44..8a9a6075a4 100644
--- a/csum-file.c
+++ b/csum-file.c
@@ -15,12 +15,8 @@ static void flush(struct sha1file *f, const void *buf, unsigned int count)
 {
 	if (0 <= f->check_fd && count)  {
 		unsigned char check_buffer[8192];
-		ssize_t ret = read_in_full(f->check_fd, check_buffer, count);
 
-		if (ret < 0)
-			die_errno("%s: sha1 file read error", f->name);
-		if (ret < count)
-			die("%s: sha1 file truncated", f->name);
+		xread_in_full(f->check_fd, check_buffer, count, f->name);
 		if (memcmp(buf, check_buffer, count))
 			die("sha1 file '%s' validation error", f->name);
 	}
diff --git a/pack-write.c b/pack-write.c
index a333ec6754..05a7defdd2 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -219,8 +219,7 @@ void fixup_pack_header_footer(int pack_fd,
 
 	if (lseek(pack_fd, 0, SEEK_SET) != 0)
 		die_errno("Failed seeking to start of '%s'", pack_name);
-	if (read_in_full(pack_fd, &hdr, sizeof(hdr)) != sizeof(hdr))
-		die_errno("Unable to reread header of '%s'", pack_name);
+	xread_in_full(pack_fd, &hdr, sizeof(hdr), pack_name);
 	if (lseek(pack_fd, 0, SEEK_SET) != 0)
 		die_errno("Failed seeking to start of '%s'", pack_name);
 	git_SHA1_Update(&old_sha1_ctx, &hdr, sizeof(hdr));
diff --git a/wrapper.c b/wrapper.c
index f55debc92d..66ba4dbff3 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -329,6 +329,17 @@ ssize_t read_in_full(int fd, void *buf, size_t count)
 	return total;
 }
 
+void xread_in_full(int fd, void *buf, size_t count, const char *desc)
+{
+	ssize_t ret = read_in_full(fd, buf, count);
+
+	if (ret < 0)
+		die_errno("error reading %s", desc);
+	if (ret != count)
+		die("too few bytes while reading %s (expected %"PRIuMAX", got %"PRIuMAX")",
+		    desc, (uintmax_t)count, (uintmax_t)ret);
+}
+
 ssize_t write_in_full(int fd, const void *buf, size_t count)
 {
 	const char *p = buf;
-- 
2.14.1.1148.ga2561536a1
