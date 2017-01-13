Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 519F220756
	for <e@80x24.org>; Fri, 13 Jan 2017 17:58:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751226AbdAMR6V (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Jan 2017 12:58:21 -0500
Received: from cloud.peff.net ([104.130.231.41]:38935 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751077AbdAMR6T (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jan 2017 12:58:19 -0500
Received: (qmail 6190 invoked by uid 109); 13 Jan 2017 17:58:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 13 Jan 2017 17:58:19 +0000
Received: (qmail 7408 invoked by uid 111); 13 Jan 2017 17:59:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 13 Jan 2017 12:59:12 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 13 Jan 2017 12:58:16 -0500
Date:   Fri, 13 Jan 2017 12:58:16 -0500
From:   Jeff King <peff@peff.net>
To:     John Szakmeister <john@szakmeister.net>
Cc:     Dennis Kaarsemaker <dennis@kaarsemaker.net>, git@vger.kernel.org
Subject: [PATCH 4/6] sha1_file: add read_loose_object() function
Message-ID: <20170113175816.jonlumcglz3ajchd@sigill.intra.peff.net>
References: <20170113175258.e66taigy4wpokohk@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170113175258.e66taigy4wpokohk@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's surprisingly hard to ask the sha1_file code to open a
_specific_ incarnation of a loose object. Most of the
functions take a sha1, and loop over the various object
types (packed versus loose) and locations (local versus
alternates) at a low level.

However, some tools like fsck need to look at a specific
file. This patch gives them a function they can use to open
the loose object at a given path.

The implementation unfortunately ends up repeating bits of
related functions, but there's not a good way around it
without some major refactoring of the whole sha1_file stack.
We need to mmap the specific file, then partially read the
zlib stream to know whether we're streaming or not, and then
finally either stream it or copy the data to a buffer.

We can do that by assembling some of the more arcane
internal sha1_file functions, but we end up having to
essentially reimplement unpack_sha1_file(), along with the
streaming bits of check_sha1_signature().

Still, most of the ugliness is contained in the new
function, and the interface is clean enough that it may be
reusable (though it seems unlikely anything but git-fsck
would care about opening a specific file).

Signed-off-by: Jeff King <peff@peff.net>
---
 cache.h     |  13 ++++++
 sha1_file.c | 133 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 143 insertions(+), 3 deletions(-)

diff --git a/cache.h b/cache.h
index 1b67f078d..33f1c2fa7 100644
--- a/cache.h
+++ b/cache.h
@@ -1140,6 +1140,19 @@ extern int finalize_object_file(const char *tmpfile, const char *filename);
 
 extern int has_sha1_pack(const unsigned char *sha1);
 
+/*
+ * Open the loose object at path, check its sha1, and return the contents,
+ * type, and size. If the object is a blob, then "contents" may return NULL,
+ * to allow streaming of large blobs.
+ *
+ * Returns 0 on success, negative on error (details may be written to stderr).
+ */
+int read_loose_object(const char *path,
+		      const unsigned char *expected_sha1,
+		      enum object_type *type,
+		      unsigned long *size,
+		      void **contents);
+
 /*
  * Return true iff we have an object named sha1, whether local or in
  * an alternate object database, and whether packed or loose.  This
diff --git a/sha1_file.c b/sha1_file.c
index c6b990f41..c0fccb73c 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1687,13 +1687,21 @@ static int open_sha1_file(const unsigned char *sha1, const char **path)
 	return -1;
 }
 
-void *map_sha1_file(const unsigned char *sha1, unsigned long *size)
+/*
+ * Map the loose object at "path" if it is not NULL, or the path found by
+ * searching for a loose object named "sha1".
+ */
+static void *map_sha1_file_1(const char *path,
+			     const unsigned char *sha1,
+			     unsigned long *size)
 {
-	const char *path;
 	void *map;
 	int fd;
 
-	fd = open_sha1_file(sha1, &path);
+	if (path)
+		fd = git_open(path);
+	else
+		fd = open_sha1_file(sha1, &path);
 	map = NULL;
 	if (fd >= 0) {
 		struct stat st;
@@ -1712,6 +1720,11 @@ void *map_sha1_file(const unsigned char *sha1, unsigned long *size)
 	return map;
 }
 
+void *map_sha1_file(const unsigned char *sha1, unsigned long *size)
+{
+	return map_sha1_file_1(NULL, sha1, size);
+}
+
 unsigned long unpack_object_header_buffer(const unsigned char *buf,
 		unsigned long len, enum object_type *type, unsigned long *sizep)
 {
@@ -3809,3 +3822,117 @@ int for_each_packed_object(each_packed_object_fn cb, void *data, unsigned flags)
 	}
 	return r ? r : pack_errors;
 }
+
+static int check_stream_sha1(git_zstream *stream,
+			     const char *hdr,
+			     unsigned long size,
+			     const char *path,
+			     const unsigned char *expected_sha1)
+{
+	git_SHA_CTX c;
+	unsigned char real_sha1[GIT_SHA1_RAWSZ];
+	unsigned char buf[4096];
+	unsigned long total_read;
+	int status = Z_OK;
+
+	git_SHA1_Init(&c);
+	git_SHA1_Update(&c, hdr, stream->total_out);
+
+	/*
+	 * We already read some bytes into hdr, but the ones up to the NUL
+	 * do not count against the object's content size.
+	 */
+	total_read = stream->total_out - strlen(hdr) - 1;
+
+	/*
+	 * This size comparison must be "<=" to read the final zlib packets;
+	 * see the comment in unpack_sha1_rest for details.
+	 */
+	while (total_read <= size &&
+	       (status == Z_OK || status == Z_BUF_ERROR)) {
+		stream->next_out = buf;
+		stream->avail_out = sizeof(buf);
+		if (size - total_read < stream->avail_out)
+			stream->avail_out = size - total_read;
+		status = git_inflate(stream, Z_FINISH);
+		git_SHA1_Update(&c, buf, stream->next_out - buf);
+		total_read += stream->next_out - buf;
+	}
+	git_inflate_end(stream);
+
+	if (status != Z_STREAM_END) {
+		error("corrupt loose object '%s'", sha1_to_hex(expected_sha1));
+		return -1;
+	}
+
+	git_SHA1_Final(real_sha1, &c);
+	if (hashcmp(expected_sha1, real_sha1)) {
+		error("sha1 mismatch for %s (expected %s)", path,
+		      sha1_to_hex(expected_sha1));
+		return -1;
+	}
+
+	return 0;
+}
+
+int read_loose_object(const char *path,
+		      const unsigned char *expected_sha1,
+		      enum object_type *type,
+		      unsigned long *size,
+		      void **contents)
+{
+	int ret = -1;
+	int fd = -1;
+	void *map = NULL;
+	unsigned long mapsize;
+	git_zstream stream;
+	char hdr[32];
+
+	*contents = NULL;
+
+	map = map_sha1_file_1(path, NULL, &mapsize);
+	if (!map) {
+		error_errno("unable to mmap %s", path);
+		goto out;
+	}
+
+	if (unpack_sha1_header(&stream, map, mapsize, hdr, sizeof(hdr)) < 0) {
+		error("unable to unpack header of %s", path);
+		goto out;
+	}
+
+	*type = parse_sha1_header(hdr, size);
+	if (*type < 0) {
+		error("unable to parse header of %s", path);
+		git_inflate_end(&stream);
+		goto out;
+	}
+
+	if (*type == OBJ_BLOB) {
+		if (check_stream_sha1(&stream, hdr, *size, path, expected_sha1) < 0)
+			goto out;
+	} else {
+		*contents = unpack_sha1_rest(&stream, hdr, *size, expected_sha1);
+		if (!*contents) {
+			error("unable to unpack contents of %s", path);
+			git_inflate_end(&stream);
+			goto out;
+		}
+		if (check_sha1_signature(expected_sha1, *contents,
+					 *size, typename(*type))) {
+			error("sha1 mismatch for %s (expected %s)", path,
+			      sha1_to_hex(expected_sha1));
+			free(*contents);
+			goto out;
+		}
+	}
+
+	ret = 0; /* everything checks out */
+
+out:
+	if (map)
+		munmap(map, mapsize);
+	if (fd >= 0)
+		close(fd);
+	return ret;
+}
-- 
2.11.0.629.g10075098c

