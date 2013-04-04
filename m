From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 2/7] sha1_file, link: write link objects to the database
Date: Fri,  5 Apr 2013 00:00:38 +0530
Message-ID: <1365100243-13676-3-git-send-email-artagnon@gmail.com>
References: <1365100243-13676-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 04 20:29:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNov0-0007TW-I6
	for gcvg-git-2@plane.gmane.org; Thu, 04 Apr 2013 20:29:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764529Ab3DDS3T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Apr 2013 14:29:19 -0400
Received: from mail-da0-f54.google.com ([209.85.210.54]:38012 "EHLO
	mail-da0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764235Ab3DDS3R (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Apr 2013 14:29:17 -0400
Received: by mail-da0-f54.google.com with SMTP id p1so1233784dad.27
        for <git@vger.kernel.org>; Thu, 04 Apr 2013 11:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=yTB4vmz+2zUopPk0PgDd7TTk6DL6gsty4/F7kEOufGY=;
        b=A0L7oMh4kRUW1XbIKy3AWQNYNM2vSBIcTh9daKasKW+wlYQE/3KriO5o2xwRwsQWtQ
         bf0JyWt0ytYcLRHmfshyK8d7hGoGWGwLb680ZXocVgtAURoMcU9JmTqXTEI9BcTIzHEo
         p01LdfeUgRGN56PfRDkAhJPxSVhqzmujnTGn3ZPHlaHiBeoVIm84fNBn5BfAQI8xc1aH
         KyZyz8kmRdAHsSqLbeH9BUKm2PxhpeZ0WqGSKyv8xh+YeXj0vPNMb7Yr1LVPp1RnTvga
         d5xa1WFVZ74ovfGGoiaDEAXSowqcMviN2wvNkS7CQg4arYKyFlqljzOHISvuAYymdirC
         q4dg==
X-Received: by 10.68.138.135 with SMTP id qq7mr10251060pbb.42.1365100157190;
        Thu, 04 Apr 2013 11:29:17 -0700 (PDT)
Received: from localhost.localdomain ([122.174.41.36])
        by mx.google.com with ESMTPS id xl10sm12418525pac.15.2013.04.04.11.29.14
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 04 Apr 2013 11:29:16 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.380.g0d4e79b
In-Reply-To: <1365100243-13676-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220050>

On a 'git add', instead of returning the SHA-1 of the subproject
commit, write a real link object to the object database.  Also
implement parse_link_buffer() correspondingly.

index_path() determines the upstream_url and checkout_rev from a
pre-cloned submodule.  The checkout_rev is set to the SHA-1 of the
HEAD, and we get a non-floating submodule.

While at it, fix the 'ls-tree' output to correctly show a link object.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 builtin/ls-tree.c |  4 ++--
 link.c            | 22 ++++++++++++++++++++++
 sha1_file.c       | 38 +++++++++++++++++++++++++++++++++++++-
 3 files changed, 61 insertions(+), 3 deletions(-)

diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index fb76e38..ab17fb5 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -6,7 +6,7 @@
 #include "cache.h"
 #include "blob.h"
 #include "tree.h"
-#include "commit.h"
+#include "link.h"
 #include "quote.h"
 #include "builtin.h"
 #include "parse-options.h"
@@ -76,7 +76,7 @@ static int show_tree(const unsigned char *sha1, const char *base, int baselen,
 			retval = READ_TREE_RECURSIVE;
 		 *
 		 */
-		type = commit_type;
+		type = link_type;
 	} else if (S_ISDIR(mode)) {
 		if (show_recursive(base, baselen, pathname)) {
 			retval = READ_TREE_RECURSIVE;
diff --git a/link.c b/link.c
index bb20a51..349646d 100644
--- a/link.c
+++ b/link.c
@@ -20,8 +20,30 @@ struct link *lookup_link(const unsigned char *sha1)
 
 int parse_link_buffer(struct link *item, void *buffer, unsigned long size)
 {
+	char *bufptr = buffer;
+	char *tail = buffer + size;
+	char *eol;
+
 	if (item->object.parsed)
 		return 0;
 	item->object.parsed = 1;
+	while (bufptr < tail) {
+		eol = strchr(bufptr, '\n');
+		*eol = '\0';
+		if (!prefixcmp(bufptr, "upstream_url = "))
+			item->upstream_url = xstrdup(bufptr + 15);
+		else if (!prefixcmp(bufptr, "checkout_rev = "))
+			item->checkout_rev = xstrdup(bufptr + 15);
+		else if (!prefixcmp(bufptr, "ref_name = "))
+			item->ref_name = xstrdup(bufptr + 11);
+		else if (!prefixcmp(bufptr, "floating = "))
+			item->floating = atoi(bufptr + 11);
+		else if (!prefixcmp(bufptr, "statthrough = "))
+			item->statthrough = atoi(bufptr + 14);
+		else
+			return error("Parse error in link buffer");
+
+		bufptr = eol + 1;
+	}
 	return 0;
 }
diff --git a/sha1_file.c b/sha1_file.c
index 5f573d9..a8a6d72 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -12,6 +12,7 @@
 #include "pack.h"
 #include "blob.h"
 #include "commit.h"
+#include "link.h"
 #include "run-command.h"
 #include "tag.h"
 #include "tree.h"
@@ -35,6 +36,7 @@
 static inline uintmax_t sz_fmt(size_t s) { return s; }
 
 const unsigned char null_sha1[20];
+void *upstream_url = NULL;
 
 /*
  * This is meant to hold a *small* number of objects that you would
@@ -2859,10 +2861,19 @@ int index_fd(unsigned char *sha1, int fd, struct stat *st,
 	return ret;
 }
 
+static int parse_origin_url(const char *key, const char *value, void *cb) {
+	if (!strcmp(key, "remote.origin.url"))
+		upstream_url = xstrdup(value);
+	return 0;
+}
+
 int index_path(unsigned char *sha1, const char *path, struct stat *st, unsigned flags)
 {
 	int fd;
 	struct strbuf sb = STRBUF_INIT;
+	char pathbuf[PATH_MAX];
+	const char *submodule_gitdir;
+	unsigned char checkout_rev[20];
 
 	switch (st->st_mode & S_IFMT) {
 	case S_IFREG:
@@ -2888,7 +2899,32 @@ int index_path(unsigned char *sha1, const char *path, struct stat *st, unsigned
 		strbuf_release(&sb);
 		break;
 	case S_IFDIR:
-		return resolve_gitlink_ref(path, "HEAD", sha1);
+		/* gitlink.  Prepare and write a new link object to
+		 * the database.
+		 */
+
+		/* Figure out upstream_url */
+		sprintf(pathbuf, "%s/%s", path, ".git");
+		submodule_gitdir = resolve_gitdir(pathbuf);
+		sprintf(pathbuf, "%s/%s", submodule_gitdir, "config");
+		git_config_from_file(parse_origin_url, pathbuf, NULL);
+		if (!upstream_url)
+			die("Unable to read remote.origin.url from submodule");
+
+		/* Figure out checkout_rev */
+		if (resolve_gitlink_ref(path, "HEAD", checkout_rev) < 0)
+			die("Unable to resolve submodule HEAD");
+
+		/* Add fields to the strbuf */
+		strbuf_addf(&sb, "upstream_url = %s\n", (char *) upstream_url);
+		strbuf_addf(&sb, "checkout_rev = %s\n", sha1_to_hex(checkout_rev));
+		if (!(flags & HASH_WRITE_OBJECT))
+			hash_sha1_file(sb.buf, sb.len, link_type, sha1);
+		else if (write_sha1_file(sb.buf, sb.len, link_type, sha1))
+			return error("%s: failed to insert into database",
+				     path);
+		strbuf_release(&sb);
+		break;
 	default:
 		return error("%s: unsupported file type", path);
 	}
-- 
1.8.2.380.g0d4e79b
