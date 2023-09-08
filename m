Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB3A0EEB570
	for <git@archiver.kernel.org>; Fri,  8 Sep 2023 23:12:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344725AbjIHXMc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Sep 2023 19:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344545AbjIHXMb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Sep 2023 19:12:31 -0400
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A7471FF2
        for <git@vger.kernel.org>; Fri,  8 Sep 2023 16:12:25 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:39822)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qekeG-006MyC-CU; Fri, 08 Sep 2023 17:12:24 -0600
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:54328 helo=localhost.localdomain)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qekeE-009u13-SU; Fri, 08 Sep 2023 17:12:24 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Fri,  8 Sep 2023 18:10:43 -0500
Message-Id: <20230908231049.2035003-26-ebiederm@xmission.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <87sf7ol0z3.fsf@email.froward.int.ebiederm.org>
References: <87sf7ol0z3.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1qekeE-009u13-SU;;;mid=<20230908231049.2035003-26-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1+0rJW20o6ZkD0VvNQkSkqaxqQ3p6FDhaA=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH 26/32] object-file-convert: Implement convert_object_file_{begin,step,end}
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When converting trees, commits, and tags the objects they reference
need to be converted before the objects themselves can be converted.

Split convert_objet_file_convert into a couple of pieces that are
effectively an iterator over the oids that need to be converted.  This
allows the objects to be processed depth first when being converted
and it allows changing the logic to map oids.  In cases like "git
index-pack" none of the oids will be mapped in any of the existing
mapping tables so an in-memory table needs to be converted and
consulted, and this allows that.

Not having to update the existing object id mapping mechanisms
is particularly nice as it makes it easy to avoid having to
introduce new locks to syncrhonize the update of internal
mapping mechanisms.

This was inspired by a similar change by "brian m. carlson"
where he modified convert_object_file to return the
unmmaped oids.

Inspired-by: brian m. carlson <sandals@crustytoothpaste.net>
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 object-file-convert.c | 226 ++++++++++++++++++++++++++++++------------
 object-file-convert.h |  21 ++++
 2 files changed, 186 insertions(+), 61 deletions(-)

diff --git a/object-file-convert.c b/object-file-convert.c
index 7978aa63dfa9..3fd080ebc112 100644
--- a/object-file-convert.c
+++ b/object-file-convert.c
@@ -67,55 +67,74 @@ static int decode_tree_entry_raw(struct object_id *oid, const char **path,
 	return 0;
 }
 
-static int convert_tree_object(struct strbuf *out,
-			       const struct git_hash_algo *from,
-			       const struct git_hash_algo *to,
-			       const char *buffer, size_t size)
+static int convert_tree_object_step(struct object_file_convert_state *state)
 {
-	const char *p = buffer, *end = buffer + size;
+	const char *buf = state->buf, *p, *end = buf + state->buf_len;
+	const struct git_hash_algo *from = state->from;
+	const struct git_hash_algo *to = state->to;
+	struct strbuf *out = state->outbuf;
+
+	/* The current position */
+	p = buf + state->buf_pos;
 
 	while (p < end) {
-		struct object_id entry_oid, mapped_oid;
+		struct object_id entry_oid;
 		const char *path = NULL;
 		size_t pathlen;
 
 		if (decode_tree_entry_raw(&entry_oid, &path, &pathlen, from, p,
 					  end - p))
 			return error(_("failed to decode tree entry"));
-		if (repo_oid_to_algop(the_repository, &entry_oid, to, &mapped_oid))
-			return error(_("failed to map tree entry for %s"), oid_to_hex(&entry_oid));
+
+		if (!state->mapped_oid.algo) {
+			oidcpy(&state->oid, &entry_oid);
+			return 1;
+		}
+		else if (!oideq(&entry_oid, &state->oid))
+			return error(_("bad object_file_convert_state oid"));
+
 		strbuf_add(out, p, path - p);
 		strbuf_add(out, path, pathlen);
-		strbuf_add(out, mapped_oid.hash, to->rawsz);
+		strbuf_add(out, state->mapped_oid.hash, to->rawsz);
+		state->mapped_oid.algo = 0;
 		p = path + pathlen + from->rawsz;
+		state->buf_pos = p - buf;
 	}
 	return 0;
 }
 
-static int convert_commit_object(struct strbuf *out,
-				 const struct git_hash_algo *from,
-				 const struct git_hash_algo *to,
-				 const char *buffer, size_t size)
+static int convert_commit_object_step(struct object_file_convert_state *state)
 {
-	const char *tail = buffer;
-	const char *bufptr = buffer;
+	const struct git_hash_algo *from = state->from;
+	struct strbuf *out = state->outbuf;
+	const char *buf = state->buf;
+	const char *tail = buf + state->buf_len;
+	const char *bufptr = buf + state->buf_pos;
 	const int tree_entry_len = from->hexsz + 5;
 	const int parent_entry_len = from->hexsz + 7;
-	struct object_id oid, mapped_oid;
+	struct object_id oid;
 	const char *p;
 
-	tail += size;
-	if (tail <= bufptr + tree_entry_len + 1 || memcmp(bufptr, "tree ", 5) ||
-			bufptr[tree_entry_len] != '\n')
-		return error("bogus commit object");
-	if (parse_oid_hex_algop(bufptr + 5, &oid, &p, from) < 0)
-		return error("bad tree pointer");
+	if (state->buf_pos == 0) {
+		if (tail <= bufptr + tree_entry_len + 1 || memcmp(bufptr, "tree ", 5) ||
+		    bufptr[tree_entry_len] != '\n')
+			return error("bogus commit object");
+
+		if (parse_oid_hex_algop(bufptr + 5, &oid, &p, from) < 0)
+			return error("bad tree pointer");
 
-	if (repo_oid_to_algop(the_repository, &oid, to, &mapped_oid))
-		return error("unable to map tree %s in commit object",
-			     oid_to_hex(&oid));
-	strbuf_addf(out, "tree %s\n", oid_to_hex(&mapped_oid));
-	bufptr = p + 1;
+		if (!state->mapped_oid.algo) {
+			oidcpy(&state->oid, &oid);
+			return 1;
+		}
+		else if (!oideq(&oid, &state->oid))
+			return error(_("bad object_file_convert_state oid"));
+
+		strbuf_addf(out, "tree %s\n", oid_to_hex(&state->mapped_oid));
+		state->mapped_oid.algo = 0;
+		bufptr = p + 1;
+		state->buf_pos = bufptr - buf;
+	}
 
 	while (bufptr + parent_entry_len < tail && !memcmp(bufptr, "parent ", 7)) {
 		if (tail <= bufptr + parent_entry_len + 1 ||
@@ -123,26 +142,44 @@ static int convert_commit_object(struct strbuf *out,
 		    *p != '\n')
 			return error("bad parents in commit");
 
-		if (repo_oid_to_algop(the_repository, &oid, to, &mapped_oid))
-			return error("unable to map parent %s in commit object",
-				     oid_to_hex(&oid));
+		if (!state->mapped_oid.algo) {
+			oidcpy(&state->oid, &oid);
+			return 1;
+		}
+		else if (!oideq(&oid, &state->oid))
+			return error(_("bad object_file_convert_state oid"));
 
-		strbuf_addf(out, "parent %s\n", oid_to_hex(&mapped_oid));
+		strbuf_addf(out, "parent %s\n", oid_to_hex(&state->mapped_oid));
+		state->mapped_oid.algo = 0;
 		bufptr = p + 1;
+		state->buf_pos = bufptr - buf;
 	}
 	strbuf_add(out, bufptr, tail - bufptr);
 	return 0;
 }
 
-static int convert_tag_object(struct strbuf *out,
-			      const struct git_hash_algo *from,
-			      const struct git_hash_algo *to,
-			      const char *buffer, size_t size)
+static int convert_tag_object_step(struct object_file_convert_state *state)
 {
 	struct strbuf payload = STRBUF_INIT, temp = STRBUF_INIT, oursig = STRBUF_INIT, othersig = STRBUF_INIT;
-	size_t payload_size;
-	struct object_id oid, mapped_oid;
+	const struct git_hash_algo *from = state->from;
+	const struct git_hash_algo *to = state->to;
+	struct strbuf *out = state->outbuf;
+	const char *buffer = state->buf;
+	size_t payload_size, size = state->buf_len;;
+	struct object_id oid;
 	const char *p;
+	int ret = 0;
+
+	if (!state->mapped_oid.algo) {
+		if (strncmp(buffer, "object ", 7) ||
+		    buffer[from->hexsz + 7] != '\n')
+			return error("bogus tag object");
+		if (parse_oid_hex_algop(buffer + 7, &oid, &p, from) < 0)
+			return error("bad tag object ID");
+
+		oidcpy(&state->oid, &oid);
+		return 1;
+	}
 
 	/* Add some slop for longer signature header in the new algorithm. */
 	strbuf_grow(out, size + 7);
@@ -165,52 +202,119 @@ static int convert_tag_object(struct strbuf *out,
 	 * Our payload is now in payload and we may have up to two signatrures
 	 * in oursig and othersig.
 	 */
-	if (strncmp(payload.buf, "object ", 7) || payload.buf[from->hexsz + 7] != '\n')
-		return error("bogus tag object");
-	if (parse_oid_hex_algop(payload.buf + 7, &oid, &p, from) < 0)
-		return error("bad tag object ID");
-	if (repo_oid_to_algop(the_repository, &oid, to, &mapped_oid))
-		return error("unable to map tree %s in tag object",
-			     oid_to_hex(&oid));
-	strbuf_addf(out, "object %s\n", oid_to_hex(&mapped_oid));
+	if (strncmp(payload.buf, "object ", 7) || payload.buf[from->hexsz + 7] != '\n') {
+		ret = error("bogus tag object");
+		goto out;
+	}
+	if (parse_oid_hex_algop(payload.buf + 7, &oid, &p, from) < 0) {
+		ret = error("bad tag object ID");
+		goto out;
+	}
+	if (!oideq(&oid, &state->oid)) {
+		ret = error(_("bad object_file_convert_state oid"));
+		goto out;
+	}
+
+	strbuf_addf(out, "object %s\n", oid_to_hex(&state->mapped_oid));
 	strbuf_add(out, p, payload.len - (p - payload.buf));
 	strbuf_addbuf(out, &othersig);
 	if (oursig.len)
 		add_header_signature(out, &oursig, from);
-	return 0;
+out:
+	strbuf_release(&oursig);
+	strbuf_release(&othersig);
+	strbuf_release(&payload);
+	return ret;
 }
 
-int convert_object_file(struct strbuf *outbuf,
-			const struct git_hash_algo *from,
-			const struct git_hash_algo *to,
-			const void *buf, size_t len,
-			enum object_type type,
-			int gentle)
+void convert_object_file_begin(struct object_file_convert_state *state,
+			      struct strbuf *outbuf,
+			      const struct git_hash_algo *from,
+			      const struct git_hash_algo *to,
+			      const void *buf, size_t len,
+			      enum object_type type)
 {
-	int ret;
+	memset(state, 0, sizeof(*state));
+	state->outbuf = outbuf;
+	state->from = from;
+	state->to = to;
+	state->buf = buf;
+	state->buf_len = len;
+	state->buf_pos = 0;
+	state->type = type;
+
 
 	/* Don't call this function when no conversion is necessary */
 	if ((from == to) || (type == OBJ_BLOB))
-		die("Refusing noop object file conversion");
+		BUG("Attempting noop object file conversion");
 
 	switch (type) {
 	case OBJ_TREE:
-		ret = convert_tree_object(outbuf, from, to, buf, len);
+	case OBJ_COMMIT:
+	case OBJ_TAG:
+		break;
+	default:
+		/* Not implemented yet, so fail. */
+		BUG("Unknown object file type found in conversion");
+	}
+}
+
+int convert_object_file_step(struct object_file_convert_state *state)
+{
+	int ret;
+
+	switch(state->type) {
+	case OBJ_TREE:
+		ret = convert_tree_object_step(state);
 		break;
 	case OBJ_COMMIT:
-		ret = convert_commit_object(outbuf, from, to, buf, len);
+		ret = convert_commit_object_step(state);
 		break;
 	case OBJ_TAG:
-		ret = convert_tag_object(outbuf, from, to, buf, len);
+		ret = convert_tag_object_step(state);
 		break;
 	default:
-		/* Not implemented yet, so fail. */
 		ret = -1;
 		break;
 	}
-	if (!ret)
-		return 0;
-	if (gentle)
+	return ret;
+}
+
+void convert_object_file_end(struct object_file_convert_state *state, int ret)
+{
+	if (ret != 0) {
+		strbuf_release(state->outbuf);
+	}
+	memset(state, 0, sizeof(*state));
+}
+
+int convert_object_file(struct strbuf *outbuf,
+			const struct git_hash_algo *from,
+			const struct git_hash_algo *to,
+			const void *buf, size_t len,
+			enum object_type type,
+			int gentle)
+{
+	struct object_file_convert_state state;
+	int ret;
+
+	convert_object_file_begin(&state, outbuf, from, to, buf, len, type);
+
+	for (;;) {
+		ret = convert_object_file_step(&state);
+		if (ret != 1)
+			break;
+		ret = repo_oid_to_algop(the_repository, &state.oid, state.to,
+					&state.mapped_oid);
+		if (ret) {
+			error(_("failed to map %s entry for %s"),
+			      type_name(type), oid_to_hex(&state.oid));
+			break;
+		}
+	}
+
+	convert_object_file_end(&state, ret);
+	if (!ret || gentle)
 		return ret;
 	die(_("Failed to convert object from %s to %s"),
 		from->name, to->name);
diff --git a/object-file-convert.h b/object-file-convert.h
index a4f802aa8eea..da032d7a91ef 100644
--- a/object-file-convert.h
+++ b/object-file-convert.h
@@ -10,6 +10,27 @@ struct strbuf;
 int repo_oid_to_algop(struct repository *repo, const struct object_id *src,
 		      const struct git_hash_algo *to, struct object_id *dest);
 
+struct object_file_convert_state {
+	struct strbuf *outbuf;
+	const struct git_hash_algo *from;
+	const struct git_hash_algo *to;
+	const void *buf;
+	size_t buf_len;
+	size_t buf_pos;
+	enum object_type type;
+	struct object_id oid;
+	struct object_id mapped_oid;
+};
+
+void convert_object_file_begin(struct object_file_convert_state *state,
+			       struct strbuf *outbuf,
+			       const struct git_hash_algo *from,
+			       const struct git_hash_algo *to,
+			       const void *buf, size_t len,
+			       enum object_type type);
+int convert_object_file_step(struct object_file_convert_state *state);
+void convert_object_file_end(struct object_file_convert_state *state, int ret);
+
 /*
  * Convert an object file from one hash algorithm to another algorithm.
  * Return -1 on failure, 0 on success.
-- 
2.41.0

