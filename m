Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 506DFEEB565
	for <git@archiver.kernel.org>; Sat,  9 Sep 2023 00:02:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241374AbjIIACv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Sep 2023 20:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234904AbjIIACu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Sep 2023 20:02:50 -0400
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EE2EE46
        for <git@vger.kernel.org>; Fri,  8 Sep 2023 17:02:46 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:34542)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qekdc-007QwF-H6; Fri, 08 Sep 2023 17:11:44 -0600
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:54328 helo=localhost.localdomain)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qekdb-009u13-3x; Fri, 08 Sep 2023 17:11:44 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Fri,  8 Sep 2023 18:10:26 -0500
Message-Id: <20230908231049.2035003-9-ebiederm@xmission.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <87sf7ol0z3.fsf@email.froward.int.ebiederm.org>
References: <87sf7ol0z3.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1qekdb-009u13-3x;;;mid=<20230908231049.2035003-9-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1+SGm9p8oywgrtyp1HYOxvR3NVpzYRm+7s=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH 09/32] object-file: Update the loose object map when writing loose objects
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To implement SHA1 compatibility on SHA256 repositories the loose
object map needs to be updated whenver a loose object is written.
Updating the loose object map this way allows git to support
the old hash algorithm in constant time.

The functions write_loose_object, and stream_loose_object are
the only two functions that write to the loose object store.

Update stream_loose_object to compute the compatibiilty hash, update
the loose object, and then call repo_add_loose_object_map to update
the loose object map.

Update write_object_file_flags to convert the object into
it's compatibility encoding, hash the compatibility encoding,
write the object, and then update the loose object map.

Update force_object_loose to lookup the hash of the compatibility
encoding, write the loose object, and then update the loose object
map.

Update write_object_file_litterally to refuse to write any objects
when a compatibility encoding is enabled.  The problem is that
write_object_file_literally is frequently used to write ill-formed
objects.  Especially when the type of those objects is changed there
is by definition no possibile way to convert them, as no converstion
has been defined.

Since a compatibilty encoding can not be found and a compatibility
mapping can not be written the cleanest behavior is to simply
disallow write_object_file_literraly from writing files.

Except that the loose objects are updated before the loose object map
I have not done any analysis to see how robust this scheme is in the
event of failure.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 object-file.c | 94 +++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 76 insertions(+), 18 deletions(-)

diff --git a/object-file.c b/object-file.c
index 7f24f19b8a68..6a14b8875343 100644
--- a/object-file.c
+++ b/object-file.c
@@ -44,6 +44,7 @@
 #include "setup.h"
 #include "submodule.h"
 #include "fsck.h"
+#include "loose.h"
 
 /* The maximum size for an object header. */
 #define MAX_HEADER_LEN 32
@@ -2035,9 +2036,12 @@ static int start_loose_object_common(struct strbuf *tmp_file,
 				     const char *filename, unsigned flags,
 				     git_zstream *stream,
 				     unsigned char *buf, size_t buflen,
-				     git_hash_ctx *c,
+				     git_hash_ctx *c, git_hash_ctx *compat_c,
 				     char *hdr, int hdrlen)
 {
+	struct repository *repo = the_repository;
+	const struct git_hash_algo *algo = repo->hash_algo;
+	const struct git_hash_algo *compat = repo->compat_hash_algo;
 	int fd;
 
 	fd = create_tmpfile(tmp_file, filename);
@@ -2057,14 +2061,18 @@ static int start_loose_object_common(struct strbuf *tmp_file,
 	git_deflate_init(stream, zlib_compression_level);
 	stream->next_out = buf;
 	stream->avail_out = buflen;
-	the_hash_algo->init_fn(c);
+	algo->init_fn(c);
+	if (compat && compat_c)
+		compat->init_fn(compat_c);
 
 	/*  Start to feed header to zlib stream */
 	stream->next_in = (unsigned char *)hdr;
 	stream->avail_in = hdrlen;
 	while (git_deflate(stream, 0) == Z_OK)
 		; /* nothing */
-	the_hash_algo->update_fn(c, hdr, hdrlen);
+	algo->update_fn(c, hdr, hdrlen);
+	if (compat && compat_c)
+		compat->update_fn(compat_c, hdr, hdrlen);
 
 	return fd;
 }
@@ -2073,16 +2081,21 @@ static int start_loose_object_common(struct strbuf *tmp_file,
  * Common steps for the inner git_deflate() loop for writing loose
  * objects. Returns what git_deflate() returns.
  */
-static int write_loose_object_common(git_hash_ctx *c,
+static int write_loose_object_common(git_hash_ctx *c, git_hash_ctx *compat_c,
 				     git_zstream *stream, const int flush,
 				     unsigned char *in0, const int fd,
 				     unsigned char *compressed,
 				     const size_t compressed_len)
 {
+	struct repository *repo = the_repository;
+	const struct git_hash_algo *algo = repo->hash_algo;
+	const struct git_hash_algo *compat = repo->compat_hash_algo;
 	int ret;
 
 	ret = git_deflate(stream, flush ? Z_FINISH : 0);
-	the_hash_algo->update_fn(c, in0, stream->next_in - in0);
+	algo->update_fn(c, in0, stream->next_in - in0);
+	if (compat && compat_c)
+		compat->update_fn(compat_c, in0, stream->next_in - in0);
 	if (write_in_full(fd, compressed, stream->next_out - compressed) < 0)
 		die_errno(_("unable to write loose object file"));
 	stream->next_out = compressed;
@@ -2097,15 +2110,21 @@ static int write_loose_object_common(git_hash_ctx *c,
  * - End the compression of zlib stream.
  * - Get the calculated oid to "oid".
  */
-static int end_loose_object_common(git_hash_ctx *c, git_zstream *stream,
-				   struct object_id *oid)
+static int end_loose_object_common(git_hash_ctx *c, git_hash_ctx *compat_c,
+				   git_zstream *stream, struct object_id *oid,
+				   struct object_id *compat_oid)
 {
+	struct repository *repo = the_repository;
+	const struct git_hash_algo *algo = repo->hash_algo;
+	const struct git_hash_algo *compat = repo->compat_hash_algo;
 	int ret;
 
 	ret = git_deflate_end_gently(stream);
 	if (ret != Z_OK)
 		return ret;
-	the_hash_algo->final_oid_fn(oid, c);
+	algo->final_oid_fn(oid, c);
+	if (compat && compat_c)
+		compat->final_oid_fn(compat_oid, compat_c);
 
 	return Z_OK;
 }
@@ -2129,7 +2148,7 @@ static int write_loose_object(const struct object_id *oid, char *hdr,
 
 	fd = start_loose_object_common(&tmp_file, filename.buf, flags,
 				       &stream, compressed, sizeof(compressed),
-				       &c, hdr, hdrlen);
+				       &c, NULL, hdr, hdrlen);
 	if (fd < 0)
 		return -1;
 
@@ -2139,14 +2158,14 @@ static int write_loose_object(const struct object_id *oid, char *hdr,
 	do {
 		unsigned char *in0 = stream.next_in;
 
-		ret = write_loose_object_common(&c, &stream, 1, in0, fd,
+		ret = write_loose_object_common(&c, NULL, &stream, 1, in0, fd,
 						compressed, sizeof(compressed));
 	} while (ret == Z_OK);
 
 	if (ret != Z_STREAM_END)
 		die(_("unable to deflate new object %s (%d)"), oid_to_hex(oid),
 		    ret);
-	ret = end_loose_object_common(&c, &stream, &parano_oid);
+	ret = end_loose_object_common(&c, NULL, &stream, &parano_oid, NULL);
 	if (ret != Z_OK)
 		die(_("deflateEnd on object %s failed (%d)"), oid_to_hex(oid),
 		    ret);
@@ -2191,10 +2210,12 @@ static int freshen_packed_object(const struct object_id *oid)
 int stream_loose_object(struct input_stream *in_stream, size_t len,
 			struct object_id *oid)
 {
+	const struct git_hash_algo *compat = the_repository->compat_hash_algo;
+	struct object_id compat_oid;
 	int fd, ret, err = 0, flush = 0;
 	unsigned char compressed[4096];
 	git_zstream stream;
-	git_hash_ctx c;
+	git_hash_ctx c, compat_c;
 	struct strbuf tmp_file = STRBUF_INIT;
 	struct strbuf filename = STRBUF_INIT;
 	int dirlen;
@@ -2218,7 +2239,7 @@ int stream_loose_object(struct input_stream *in_stream, size_t len,
 	 */
 	fd = start_loose_object_common(&tmp_file, filename.buf, 0,
 				       &stream, compressed, sizeof(compressed),
-				       &c, hdr, hdrlen);
+				       &c, &compat_c, hdr, hdrlen);
 	if (fd < 0) {
 		err = -1;
 		goto cleanup;
@@ -2236,7 +2257,7 @@ int stream_loose_object(struct input_stream *in_stream, size_t len,
 			if (in_stream->is_finished)
 				flush = 1;
 		}
-		ret = write_loose_object_common(&c, &stream, flush, in0, fd,
+		ret = write_loose_object_common(&c, &compat_c, &stream, flush, in0, fd,
 						compressed, sizeof(compressed));
 		/*
 		 * Unlike write_loose_object(), we do not have the entire
@@ -2259,7 +2280,7 @@ int stream_loose_object(struct input_stream *in_stream, size_t len,
 	 */
 	if (ret != Z_STREAM_END)
 		die(_("unable to stream deflate new object (%d)"), ret);
-	ret = end_loose_object_common(&c, &stream, oid);
+	ret = end_loose_object_common(&c, &compat_c, &stream, oid, &compat_oid);
 	if (ret != Z_OK)
 		die(_("deflateEnd on stream object failed (%d)"), ret);
 	close_loose_object(fd, tmp_file.buf);
@@ -2286,6 +2307,8 @@ int stream_loose_object(struct input_stream *in_stream, size_t len,
 	}
 
 	err = finalize_object_file(tmp_file.buf, filename.buf);
+	if (!err && compat)
+		err = repo_add_loose_object_map(the_repository, oid, &compat_oid);
 cleanup:
 	strbuf_release(&tmp_file);
 	strbuf_release(&filename);
@@ -2296,17 +2319,38 @@ int write_object_file_flags(const void *buf, unsigned long len,
 			    enum object_type type, struct object_id *oid,
 			    unsigned flags)
 {
+	struct repository *repo = the_repository;
+	const struct git_hash_algo *algo = repo->hash_algo;
+	const struct git_hash_algo *compat = repo->compat_hash_algo;
+	struct object_id compat_oid;
 	char hdr[MAX_HEADER_LEN];
 	int hdrlen = sizeof(hdr);
 
+	/* Generate compat_oid */
+	if (compat) {
+		if (type == OBJ_BLOB)
+			hash_object_file(compat, buf, len, type, &compat_oid);
+		else {
+			struct strbuf converted = STRBUF_INIT;
+			convert_object_file(&converted, algo, compat,
+					    buf, len, type, 0);
+			hash_object_file(compat, converted.buf, converted.len,
+					 type, &compat_oid);
+			strbuf_release(&converted);
+		}
+	}
+
 	/* Normally if we have it in the pack then we do not bother writing
 	 * it out into .git/objects/??/?{38} file.
 	 */
-	write_object_file_prepare(the_hash_algo, buf, len, type, oid, hdr,
-				  &hdrlen);
+	write_object_file_prepare(algo, buf, len, type, oid, hdr, &hdrlen);
 	if (freshen_packed_object(oid) || freshen_loose_object(oid))
 		return 0;
-	return write_loose_object(oid, hdr, hdrlen, buf, len, 0, flags);
+	if (write_loose_object(oid, hdr, hdrlen, buf, len, 0, flags))
+		return -1;
+	if (compat)
+		return repo_add_loose_object_map(repo, oid, &compat_oid);
+	return 0;
 }
 
 int write_object_file_literally(const void *buf, unsigned long len,
@@ -2324,6 +2368,10 @@ int write_object_file_literally(const void *buf, unsigned long len,
 
 	if (!(flags & HASH_WRITE_OBJECT))
 		goto cleanup;
+	else if (the_repository->compat_hash_algo) {
+		status = -1;
+		goto cleanup;
+	}
 	if (freshen_packed_object(oid) || freshen_loose_object(oid))
 		goto cleanup;
 	status = write_loose_object(oid, header, hdrlen, buf, len, 0, 0);
@@ -2335,9 +2383,12 @@ int write_object_file_literally(const void *buf, unsigned long len,
 
 int force_object_loose(const struct object_id *oid, time_t mtime)
 {
+	struct repository *repo = the_repository;
+	const struct git_hash_algo *compat = repo->compat_hash_algo;
 	void *buf;
 	unsigned long len;
 	struct object_info oi = OBJECT_INFO_INIT;
+	struct object_id compat_oid;
 	enum object_type type;
 	char hdr[MAX_HEADER_LEN];
 	int hdrlen;
@@ -2350,8 +2401,15 @@ int force_object_loose(const struct object_id *oid, time_t mtime)
 	oi.contentp = &buf;
 	if (oid_object_info_extended(the_repository, oid, &oi, 0))
 		return error(_("cannot read object for %s"), oid_to_hex(oid));
+	if (compat) {
+		if (repo_oid_to_algop(repo, oid, compat, &compat_oid))
+			return error(_("cannot map object %s to %s"),
+				     oid_to_hex(oid), compat->name);
+	}
 	hdrlen = format_object_header(hdr, sizeof(hdr), type, len);
 	ret = write_loose_object(oid, hdr, hdrlen, buf, len, mtime, 0);
+	if (!ret && compat)
+		ret = repo_add_loose_object_map(the_repository, oid, &compat_oid);
 	free(buf);
 
 	return ret;
-- 
2.41.0

