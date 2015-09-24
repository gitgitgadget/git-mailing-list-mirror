From: Jeff King <peff@peff.net>
Subject: [PATCH 08/68] add reentrant variants of sha1_to_hex and
 find_unique_abbrev
Date: Thu, 24 Sep 2015 17:05:45 -0400
Message-ID: <20150924210545.GE30946@sigill.intra.peff.net>
References: <20150924210225.GA23624@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 24 23:06:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZfDiK-0000bI-PT
	for gcvg-git-2@plane.gmane.org; Thu, 24 Sep 2015 23:06:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754150AbbIXVFu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Sep 2015 17:05:50 -0400
Received: from cloud.peff.net ([50.56.180.127]:35912 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754139AbbIXVFs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Sep 2015 17:05:48 -0400
Received: (qmail 11817 invoked by uid 102); 24 Sep 2015 21:05:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 24 Sep 2015 16:05:48 -0500
Received: (qmail 28907 invoked by uid 107); 24 Sep 2015 21:06:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 24 Sep 2015 17:06:00 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Sep 2015 17:05:45 -0400
Content-Disposition: inline
In-Reply-To: <20150924210225.GA23624@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278566>

The sha1_to_hex and find_unique_abbrev functions always
write into reusable static buffers. There are a few problems
with this:

  - future calls overwrite our result. This is especially
    annoying with find_unique_abbrev, which does not have a
    ring of buffers, so you cannot even printf() a result
    that has two abbreviated sha1s.

  - if you want to put the result into another buffer, we
    often strcpy, which looks suspicious when auditing for
    overflows.

This patch introduces sha1_to_hex_r and find_unique_abbrev_r,
which write into a user-provided buffer. Of course this is
just punting on the overflow-auditing, as the buffer
obviously needs to be GIT_SHA1_HEXSZ + 1 bytes. But it is
much easier to audit, since that is a well-known size.

We retain the non-reentrant forms, which just become thin
wrappers around the reentrant ones. This patch also adds a
strbuf variant of find_unique_abbrev, which will be handy in
later patches.

Signed-off-by: Jeff King <peff@peff.net>
---
 cache.h     | 31 ++++++++++++++++++++++++++++++-
 hex.c       | 13 +++++++++----
 sha1_name.c | 16 +++++++++++-----
 strbuf.c    |  9 +++++++++
 strbuf.h    |  8 ++++++++
 5 files changed, 67 insertions(+), 10 deletions(-)

diff --git a/cache.h b/cache.h
index e231e47..030b880 100644
--- a/cache.h
+++ b/cache.h
@@ -785,7 +785,24 @@ extern char *sha1_pack_name(const unsigned char *sha1);
  */
 extern char *sha1_pack_index_name(const unsigned char *sha1);
 
-extern const char *find_unique_abbrev(const unsigned char *sha1, int);
+/*
+ * Return an abbreviated sha1 unique within this repository's object database.
+ * The result will be at least `len` characters long, and will be NUL
+ * terminated.
+ *
+ * The non-`_r` version returns a static buffer which will be overwritten by
+ * subsequent calls.
+ *
+ * The `_r` variant writes to a buffer supplied by the caller, which must be at
+ * least `GIT_SHA1_HEXSZ + 1` bytes. The return value is the number of bytes
+ * written (excluding the NUL terminator).
+ *
+ * Note that while this version avoids the static buffer, it is not fully
+ * reentrant, as it calls into other non-reentrant git code.
+ */
+extern const char *find_unique_abbrev(const unsigned char *sha1, int len);
+extern int find_unique_abbrev_r(char *hex, const unsigned char *sha1, int len);
+
 extern const unsigned char null_sha1[GIT_SHA1_RAWSZ];
 
 static inline int hashcmp(const unsigned char *sha1, const unsigned char *sha2)
@@ -1067,6 +1084,18 @@ extern int for_each_abbrev(const char *prefix, each_abbrev_fn, void *);
 extern int get_sha1_hex(const char *hex, unsigned char *sha1);
 extern int get_oid_hex(const char *hex, struct object_id *sha1);
 
+/*
+ * Convert a binary sha1 to its hex equivalent. The `_r` variant is reentrant,
+ * and writes the NUL-terminated output to the buffer `out`, which must be at
+ * least `GIT_SHA1_HEXSZ + 1` bytes, and returns a pointer to out for
+ * convenience.
+ *
+ * The non-`_r` variant returns a static buffer, but uses a ring of 4
+ * buffers, making it safe to make multiple calls for a single statement, like:
+ *
+ *   printf("%s -> %s", sha1_to_hex(one), sha1_to_hex(two));
+ */
+extern char *sha1_to_hex_r(char *out, const unsigned char *sha1);
 extern char *sha1_to_hex(const unsigned char *sha1);	/* static buffer result! */
 extern char *oid_to_hex(const struct object_id *oid);	/* same static buffer as sha1_to_hex */
 
diff --git a/hex.c b/hex.c
index 899b74a..0519f85 100644
--- a/hex.c
+++ b/hex.c
@@ -61,12 +61,10 @@ int get_oid_hex(const char *hex, struct object_id *oid)
 	return get_sha1_hex(hex, oid->hash);
 }
 
-char *sha1_to_hex(const unsigned char *sha1)
+char *sha1_to_hex_r(char *buffer, const unsigned char *sha1)
 {
-	static int bufno;
-	static char hexbuffer[4][GIT_SHA1_HEXSZ + 1];
 	static const char hex[] = "0123456789abcdef";
-	char *buffer = hexbuffer[3 & ++bufno], *buf = buffer;
+	char *buf = buffer;
 	int i;
 
 	for (i = 0; i < GIT_SHA1_RAWSZ; i++) {
@@ -79,6 +77,13 @@ char *sha1_to_hex(const unsigned char *sha1)
 	return buffer;
 }
 
+char *sha1_to_hex(const unsigned char *sha1)
+{
+	static int bufno;
+	static char hexbuffer[4][GIT_SHA1_HEXSZ + 1];
+	return sha1_to_hex_r(hexbuffer[3 & ++bufno], sha1);
+}
+
 char *oid_to_hex(const struct object_id *oid)
 {
 	return sha1_to_hex(oid->hash);
diff --git a/sha1_name.c b/sha1_name.c
index da6874c..c58b477 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -368,14 +368,13 @@ int for_each_abbrev(const char *prefix, each_abbrev_fn fn, void *cb_data)
 	return ds.ambiguous;
 }
 
-const char *find_unique_abbrev(const unsigned char *sha1, int len)
+int find_unique_abbrev_r(char *hex, const unsigned char *sha1, int len)
 {
 	int status, exists;
-	static char hex[41];
 
-	memcpy(hex, sha1_to_hex(sha1), 40);
+	sha1_to_hex_r(hex, sha1);
 	if (len == 40 || !len)
-		return hex;
+		return 40;
 	exists = has_sha1_file(sha1);
 	while (len < 40) {
 		unsigned char sha1_ret[20];
@@ -384,10 +383,17 @@ const char *find_unique_abbrev(const unsigned char *sha1, int len)
 		    ? !status
 		    : status == SHORT_NAME_NOT_FOUND) {
 			hex[len] = 0;
-			return hex;
+			return len;
 		}
 		len++;
 	}
+	return len;
+}
+
+const char *find_unique_abbrev(const unsigned char *sha1, int len)
+{
+	static char hex[GIT_SHA1_HEXSZ + 1];
+	find_unique_abbrev_r(hex, sha1, len);
 	return hex;
 }
 
diff --git a/strbuf.c b/strbuf.c
index 29df55b..f3c44fb 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -743,3 +743,12 @@ void strbuf_addftime(struct strbuf *sb, const char *fmt, const struct tm *tm)
 	}
 	strbuf_setlen(sb, sb->len + len);
 }
+
+void strbuf_add_unique_abbrev(struct strbuf *sb, const unsigned char *sha1,
+			      int abbrev_len)
+{
+	int r;
+	strbuf_grow(sb, GIT_SHA1_HEXSZ + 1);
+	r = find_unique_abbrev_r(sb->buf + sb->len, sha1, abbrev_len);
+	strbuf_setlen(sb, sb->len + r);
+}
diff --git a/strbuf.h b/strbuf.h
index 43f27c3..0f9c8a7 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -475,6 +475,14 @@ static inline struct strbuf **strbuf_split(const struct strbuf *sb,
 extern void strbuf_list_free(struct strbuf **);
 
 /**
+ * Add the abbreviation, as generated by find_unique_abbrev, of `sha1` to
+ * the strbuf `sb`.
+ */
+extern void strbuf_add_unique_abbrev(struct strbuf *sb,
+				     const unsigned char *sha1,
+				     int abbrev_len);
+
+/**
  * Launch the user preferred editor to edit a file and fill the buffer
  * with the file's contents upon the user completing their editing. The
  * third argument can be used to set the environment which the editor is
-- 
2.6.0.rc3.454.g204ad51
