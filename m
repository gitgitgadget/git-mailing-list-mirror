Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B6F720756
	for <e@80x24.org>; Fri, 13 Jan 2017 17:54:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751197AbdAMRyo (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Jan 2017 12:54:44 -0500
Received: from cloud.peff.net ([104.130.231.41]:38924 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751171AbdAMRyn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jan 2017 12:54:43 -0500
Received: (qmail 5950 invoked by uid 109); 13 Jan 2017 17:54:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 13 Jan 2017 17:54:43 +0000
Received: (qmail 7355 invoked by uid 111); 13 Jan 2017 17:55:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 13 Jan 2017 12:55:35 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 13 Jan 2017 12:54:39 -0500
Date:   Fri, 13 Jan 2017 12:54:39 -0500
From:   Jeff King <peff@peff.net>
To:     John Szakmeister <john@szakmeister.net>
Cc:     Dennis Kaarsemaker <dennis@kaarsemaker.net>, git@vger.kernel.org
Subject: [PATCH 2/6] sha1_file: fix error message for alternate objects
Message-ID: <20170113175439.jedroszyilb6idrd@sigill.intra.peff.net>
References: <20170113175258.e66taigy4wpokohk@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170113175258.e66taigy4wpokohk@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we fail to open a corrupt loose object, we report an
error and mention the filename via sha1_file_name().
However, that function will always give us a path in the
local repository, whereas the corrupt object may have come
from an alternate. The result is a very misleading error
message.

Teach the open_sha1_file() and stat_sha1_file() helpers to
pass back the path they found, so that we can report it
correctly.

Note that the pointers we return go to static storage (e.g.,
from sha1_file_name()), which is slightly dangerous.
However, these helpers are static local helpers, and the
names are used for immediately generating error messages.
The simplicity is an acceptable tradeoff for the danger.

Signed-off-by: Jeff King <peff@peff.net>
---
 sha1_file.c     | 46 +++++++++++++++++++++++++++++++---------------
 t/t1450-fsck.sh | 10 ++++++++++
 2 files changed, 41 insertions(+), 15 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 1eb47f611..c6b990f41 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1630,39 +1630,54 @@ int git_open_cloexec(const char *name, int flags)
 	return fd;
 }
 
-static int stat_sha1_file(const unsigned char *sha1, struct stat *st)
+/*
+ * Find "sha1" as a loose object in the local repository or in an alternate.
+ * Returns 0 on success, negative on failure.
+ *
+ * The "path" out-parameter will give the path of the object we found (if any).
+ * Note that it may point to static storage and is only valid until another
+ * call to sha1_file_name(), etc.
+ */
+static int stat_sha1_file(const unsigned char *sha1, struct stat *st,
+			  const char **path)
 {
 	struct alternate_object_database *alt;
 
-	if (!lstat(sha1_file_name(sha1), st))
+	*path = sha1_file_name(sha1);
+	if (!lstat(*path, st))
 		return 0;
 
 	prepare_alt_odb();
 	errno = ENOENT;
 	for (alt = alt_odb_list; alt; alt = alt->next) {
-		const char *path = alt_sha1_path(alt, sha1);
-		if (!lstat(path, st))
+		*path = alt_sha1_path(alt, sha1);
+		if (!lstat(*path, st))
 			return 0;
 	}
 
 	return -1;
 }
 
-static int open_sha1_file(const unsigned char *sha1)
+/*
+ * Like stat_sha1_file(), but actually open the object and return the
+ * descriptor. See the caveats on the "path" parameter above.
+ */
+static int open_sha1_file(const unsigned char *sha1, const char **path)
 {
 	int fd;
 	struct alternate_object_database *alt;
 	int most_interesting_errno;
 
-	fd = git_open(sha1_file_name(sha1));
+	*path = sha1_file_name(sha1);
+	fd = git_open(*path);
 	if (fd >= 0)
 		return fd;
 	most_interesting_errno = errno;
 
 	prepare_alt_odb();
 	for (alt = alt_odb_list; alt; alt = alt->next) {
-		const char *path = alt_sha1_path(alt, sha1);
-		fd = git_open(path);
+		*path = alt_sha1_path(alt, sha1);
+		fd = git_open(*path);
 		if (fd >= 0)
 			return fd;
 		if (most_interesting_errno == ENOENT)
@@ -1674,10 +1689,11 @@ static int open_sha1_file(const unsigned char *sha1)
 
 void *map_sha1_file(const unsigned char *sha1, unsigned long *size)
 {
+	const char *path;
 	void *map;
 	int fd;
 
-	fd = open_sha1_file(sha1);
+	fd = open_sha1_file(sha1, &path);
 	map = NULL;
 	if (fd >= 0) {
 		struct stat st;
@@ -1686,7 +1702,7 @@ void *map_sha1_file(const unsigned char *sha1, unsigned long *size)
 			*size = xsize_t(st.st_size);
 			if (!*size) {
 				/* mmap() is forbidden on empty files */
-				error("object file %s is empty", sha1_file_name(sha1));
+				error("object file %s is empty", path);
 				return NULL;
 			}
 			map = xmmap(NULL, *size, PROT_READ, MAP_PRIVATE, fd, 0);
@@ -2806,8 +2822,9 @@ static int sha1_loose_object_info(const unsigned char *sha1,
 	 * object even exists.
 	 */
 	if (!oi->typep && !oi->typename && !oi->sizep) {
+		const char *path;
 		struct stat st;
-		if (stat_sha1_file(sha1, &st) < 0)
+		if (stat_sha1_file(sha1, &st, &path) < 0)
 			return -1;
 		if (oi->disk_sizep)
 			*oi->disk_sizep = st.st_size;
@@ -3003,6 +3020,8 @@ void *read_sha1_file_extended(const unsigned char *sha1,
 {
 	void *data;
 	const struct packed_git *p;
+	const char *path;
+	struct stat st;
 	const unsigned char *repl = lookup_replace_object_extended(sha1, flag);
 
 	errno = 0;
@@ -3018,12 +3037,9 @@ void *read_sha1_file_extended(const unsigned char *sha1,
 		die("replacement %s not found for %s",
 		    sha1_to_hex(repl), sha1_to_hex(sha1));
 
-	if (has_loose_object(repl)) {
-		const char *path = sha1_file_name(sha1);
-
+	if (!stat_sha1_file(repl, &st, &path))
 		die("loose object %s (stored in %s) is corrupt",
 		    sha1_to_hex(repl), path);
-	}
 
 	if ((p = has_packed_and_bad(repl)) != NULL)
 		die("packed object %s (stored in %s) is corrupt",
diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index 3297d4cb2..f95174c9d 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -550,4 +550,14 @@ test_expect_success 'fsck --name-objects' '
 	)
 '
 
+test_expect_success 'alternate objects are correctly blamed' '
+	test_when_finished "rm -rf alt.git .git/objects/info/alternates" &&
+	git init --bare alt.git &&
+	echo "../../alt.git/objects" >.git/objects/info/alternates &&
+	mkdir alt.git/objects/12 &&
+	>alt.git/objects/12/34567890123456789012345678901234567890 &&
+	test_must_fail git fsck >out 2>&1 &&
+	grep alt.git out
+'
+
 test_done
-- 
2.11.0.629.g10075098c

