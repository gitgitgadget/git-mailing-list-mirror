From: Jeff King <peff@peff.net>
Subject: [PATCH 17/67] use xsnprintf for generating git object headers
Date: Tue, 15 Sep 2015 11:38:17 -0400
Message-ID: <20150915153816.GQ29753@sigill.intra.peff.net>
References: <20150915152125.GA27504@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 15 17:38:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZbsJN-0007XK-9U
	for gcvg-git-2@plane.gmane.org; Tue, 15 Sep 2015 17:38:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753512AbbIOPiU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Sep 2015 11:38:20 -0400
Received: from cloud.peff.net ([50.56.180.127]:59317 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753020AbbIOPiT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Sep 2015 11:38:19 -0400
Received: (qmail 11738 invoked by uid 102); 15 Sep 2015 15:38:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 15 Sep 2015 10:38:19 -0500
Received: (qmail 7072 invoked by uid 107); 15 Sep 2015 15:38:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 15 Sep 2015 11:38:28 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 15 Sep 2015 11:38:17 -0400
Content-Disposition: inline
In-Reply-To: <20150915152125.GA27504@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277918>

We generally use 32-byte buffers to format git's "type size"
header fields. These should not generally overflow unless
you can produce some truly gigantic objects (and our types
come from our internal array of constant strings). But it is
a good idea to use xsnprintf to make sure this is the case.

Note that we slightly modify the interface to
write_sha1_file_prepare, which nows uses "hdrlen" as an "in"
parameter as well as an "out" (on the way in it stores the
allocated size of the header, and on the way out it returns
the ultimate size of the header).

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/index-pack.c |  2 +-
 bulk-checkin.c       |  4 ++--
 fast-import.c        |  4 ++--
 http-push.c          |  2 +-
 sha1_file.c          | 13 +++++++------
 5 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 3431de2..1ad1bde 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -441,7 +441,7 @@ static void *unpack_entry_data(unsigned long offset, unsigned long size,
 	int hdrlen;
 
 	if (!is_delta_type(type)) {
-		hdrlen = sprintf(hdr, "%s %lu", typename(type), size) + 1;
+		hdrlen = xsnprintf(hdr, sizeof(hdr), "%s %lu", typename(type), size) + 1;
 		git_SHA1_Init(&c);
 		git_SHA1_Update(&c, hdr, hdrlen);
 	} else
diff --git a/bulk-checkin.c b/bulk-checkin.c
index 7cffc3a..4347f5c 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -200,8 +200,8 @@ static int deflate_to_pack(struct bulk_checkin_state *state,
 	if (seekback == (off_t) -1)
 		return error("cannot find the current offset");
 
-	header_len = sprintf((char *)obuf, "%s %" PRIuMAX,
-			     typename(type), (uintmax_t)size) + 1;
+	header_len = xsnprintf((char *)obuf, sizeof(obuf), "%s %" PRIuMAX,
+			       typename(type), (uintmax_t)size) + 1;
 	git_SHA1_Init(&ctx);
 	git_SHA1_Update(&ctx, obuf, header_len);
 
diff --git a/fast-import.c b/fast-import.c
index 6c7c3c9..d0c2502 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1035,8 +1035,8 @@ static int store_object(
 	git_SHA_CTX c;
 	git_zstream s;
 
-	hdrlen = sprintf((char *)hdr,"%s %lu", typename(type),
-		(unsigned long)dat->len) + 1;
+	hdrlen = xsnprintf((char *)hdr, sizeof(hdr), "%s %lu",
+			   typename(type), (unsigned long)dat->len) + 1;
 	git_SHA1_Init(&c);
 	git_SHA1_Update(&c, hdr, hdrlen);
 	git_SHA1_Update(&c, dat->buf, dat->len);
diff --git a/http-push.c b/http-push.c
index 154e67b..1f3788f 100644
--- a/http-push.c
+++ b/http-push.c
@@ -361,7 +361,7 @@ static void start_put(struct transfer_request *request)
 	git_zstream stream;
 
 	unpacked = read_sha1_file(request->obj->sha1, &type, &len);
-	hdrlen = sprintf(hdr, "%s %lu", typename(type), len) + 1;
+	hdrlen = xsnprintf(hdr, sizeof(hdr), "%s %lu", typename(type), len) + 1;
 
 	/* Set it up */
 	git_deflate_init(&stream, zlib_compression_level);
diff --git a/sha1_file.c b/sha1_file.c
index d295a32..f106091 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1464,7 +1464,7 @@ int check_sha1_signature(const unsigned char *sha1, void *map,
 		return -1;
 
 	/* Generate the header */
-	hdrlen = sprintf(hdr, "%s %lu", typename(obj_type), size) + 1;
+	hdrlen = xsnprintf(hdr, sizeof(hdr), "%s %lu", typename(obj_type), size) + 1;
 
 	/* Sha1.. */
 	git_SHA1_Init(&c);
@@ -2930,7 +2930,7 @@ static void write_sha1_file_prepare(const void *buf, unsigned long len,
 	git_SHA_CTX c;
 
 	/* Generate the header */
-	*hdrlen = sprintf(hdr, "%s %lu", type, len)+1;
+	*hdrlen = xsnprintf(hdr, *hdrlen, "%s %lu", type, len)+1;
 
 	/* Sha1.. */
 	git_SHA1_Init(&c);
@@ -2993,7 +2993,7 @@ int hash_sha1_file(const void *buf, unsigned long len, const char *type,
                    unsigned char *sha1)
 {
 	char hdr[32];
-	int hdrlen;
+	int hdrlen = sizeof(hdr);
 	write_sha1_file_prepare(buf, len, type, sha1, hdr, &hdrlen);
 	return 0;
 }
@@ -3139,7 +3139,7 @@ static int freshen_packed_object(const unsigned char *sha1)
 int write_sha1_file(const void *buf, unsigned long len, const char *type, unsigned char *sha1)
 {
 	char hdr[32];
-	int hdrlen;
+	int hdrlen = sizeof(hdr);
 
 	/* Normally if we have it in the pack then we do not bother writing
 	 * it out into .git/objects/??/?{38} file.
@@ -3157,7 +3157,8 @@ int hash_sha1_file_literally(const void *buf, unsigned long len, const char *typ
 	int hdrlen, status = 0;
 
 	/* type string, SP, %lu of the length plus NUL must fit this */
-	header = xmalloc(strlen(type) + 32);
+	hdrlen = strlen(type) + 32;
+	header = xmalloc(hdrlen);
 	write_sha1_file_prepare(buf, len, type, sha1, header, &hdrlen);
 
 	if (!(flags & HASH_WRITE_OBJECT))
@@ -3185,7 +3186,7 @@ int force_object_loose(const unsigned char *sha1, time_t mtime)
 	buf = read_packed_sha1(sha1, &type, &len);
 	if (!buf)
 		return error("cannot read sha1_file for %s", sha1_to_hex(sha1));
-	hdrlen = sprintf(hdr, "%s %lu", typename(type), len) + 1;
+	hdrlen = xsnprintf(hdr, sizeof(hdr), "%s %lu", typename(type), len) + 1;
 	ret = write_loose_object(sha1, hdr, hdrlen, buf, len, mtime);
 	free(buf);
 
-- 
2.6.0.rc2.408.ga2926b9
