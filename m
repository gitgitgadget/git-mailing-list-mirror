Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11EFBEEB56E
	for <git@archiver.kernel.org>; Fri,  8 Sep 2023 23:12:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344516AbjIHXMU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Sep 2023 19:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344177AbjIHXMT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Sep 2023 19:12:19 -0400
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 904491FF5
        for <git@vger.kernel.org>; Fri,  8 Sep 2023 16:12:07 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:39630)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qekdy-006MpA-PX; Fri, 08 Sep 2023 17:12:06 -0600
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:54328 helo=localhost.localdomain)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qekdx-009u13-L5; Fri, 08 Sep 2023 17:12:06 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Eric W . Biederman" <ebiederm@xmission.com>
Date:   Fri,  8 Sep 2023 18:10:36 -0500
Message-Id: <20230908231049.2035003-19-ebiederm@xmission.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <87sf7ol0z3.fsf@email.froward.int.ebiederm.org>
References: <87sf7ol0z3.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1qekdx-009u13-L5;;;mid=<20230908231049.2035003-19-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX19Ckvsc6tmnaFuCKseftF4jBaOl9gyVK8A=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH 19/32] object-file-convert: convert tag commits when writing
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "brian m. carlson" <sandals@crustytoothpaste.net>

When writing a tag object in a repository with both SHA-1 and SHA-256,
we'll need to convert our commit objects so that we can write the hash
values for both into the repository.  To do so, let's add a function to
convert tag objects.

Note that signatures for tag objects in the current algorithm trail the
message, and those for the alternate algorithm are in headers.
Therefore, we parse the tag object for both a trailing signature and a
header and then, when writing the other format, swap the two around.

We expose the add_commit_signature function, which we rename now that it
is useful for tags as well, and use it to add the header.

****
- Moved convert_tag_object into object-file-convert.c and
  made it static
- Adjusted how convert_object_file calls convert_tag_object
--EWB

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 commit.c              |  6 +++---
 commit.h              |  1 +
 object-file-convert.c | 50 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 54 insertions(+), 3 deletions(-)

diff --git a/commit.c b/commit.c
index 522ebb4b3002..54f19ed0328c 100644
--- a/commit.c
+++ b/commit.c
@@ -1101,7 +1101,7 @@ static const char *gpg_sig_headers[] = {
 	"gpgsig-sha256",
 };
 
-static int add_commit_signature(struct strbuf *buf, struct strbuf *sig, const struct git_hash_algo *algo)
+int add_header_signature(struct strbuf *buf, struct strbuf *sig, const struct git_hash_algo *algo)
 {
 	int inspos, copypos;
 	const char *eoh;
@@ -1732,9 +1732,9 @@ int commit_tree_extended(const char *msg, size_t msg_len,
 		for (i = 0; i < ARRAY_SIZE(bufs); i++) {
 			if (!bufs[i].algo)
 				continue;
-			add_commit_signature(&buffer, bufs[i].sig, bufs[i].algo);
+			add_header_signature(&buffer, bufs[i].sig, bufs[i].algo);
 			if (r->compat_hash_algo)
-				add_commit_signature(&compat_buffer, bufs[i].sig, bufs[i].algo);
+				add_header_signature(&compat_buffer, bufs[i].sig, bufs[i].algo);
 		}
 	}
 
diff --git a/commit.h b/commit.h
index 28928833c544..03edcec0129f 100644
--- a/commit.h
+++ b/commit.h
@@ -370,5 +370,6 @@ int parse_buffer_signed_by_header(const char *buffer,
 				  struct strbuf *payload,
 				  struct strbuf *signature,
 				  const struct git_hash_algo *algop);
+int add_header_signature(struct strbuf *buf, struct strbuf *sig, const struct git_hash_algo *algo);
 
 #endif /* COMMIT_H */
diff --git a/object-file-convert.c b/object-file-convert.c
index 9c715a9864d5..d381d3d2ea65 100644
--- a/object-file-convert.c
+++ b/object-file-convert.c
@@ -7,6 +7,8 @@
 #include "hash.h"
 #include "object.h"
 #include "loose.h"
+#include "commit.h"
+#include "gpg-interface.h"
 #include "object-file-convert.h"
 
 int repo_oid_to_algop(struct repository *repo, const struct object_id *src,
@@ -125,6 +127,52 @@ static int convert_commit_object(struct strbuf *out,
 	return 0;
 }
 
+static int convert_tag_object(struct strbuf *out,
+			      const struct git_hash_algo *from,
+			      const struct git_hash_algo *to,
+			      const char *buffer, size_t size)
+{
+	struct strbuf payload = STRBUF_INIT, temp = STRBUF_INIT, oursig = STRBUF_INIT, othersig = STRBUF_INIT;
+	size_t payload_size;
+	struct object_id oid, mapped_oid;
+	const char *p;
+
+	/* Add some slop for longer signature header in the new algorithm. */
+	strbuf_grow(out, size + 7);
+
+	/* Is there a signature for our algorithm? */
+	payload_size = parse_signed_buffer(buffer, size);
+	strbuf_add(&payload, buffer, payload_size);
+	if (payload_size != size) {
+		/* Yes, there is. */
+		strbuf_add(&oursig, buffer + payload_size, size - payload_size);
+	}
+	/* Now, is there a signature for the other algorithm? */
+	if (parse_buffer_signed_by_header(payload.buf, payload.len, &temp, &othersig, to)) {
+		/* Yes, there is. */
+		strbuf_swap(&payload, &temp);
+		strbuf_release(&temp);
+	}
+
+	/*
+	 * Our payload is now in payload and we may have up to two signatrures
+	 * in oursig and othersig.
+	 */
+	if (strncmp(payload.buf, "object ", 7) || payload.buf[from->hexsz + 7] != '\n')
+		return error("bogus tag object");
+	if (parse_oid_hex_algop(payload.buf + 7, &oid, &p, from) < 0)
+		return error("bad tag object ID");
+	if (repo_oid_to_algop(the_repository, &oid, to, &mapped_oid))
+		return error("unable to map tree %s in tag object",
+			     oid_to_hex(&oid));
+	strbuf_addf(out, "object %s\n", oid_to_hex(&mapped_oid));
+	strbuf_add(out, p, payload.len - (p - payload.buf));
+	strbuf_addbuf(out, &othersig);
+	if (oursig.len)
+		add_header_signature(out, &oursig, from);
+	return 0;
+}
+
 int convert_object_file(struct strbuf *outbuf,
 			const struct git_hash_algo *from,
 			const struct git_hash_algo *to,
@@ -146,6 +194,8 @@ int convert_object_file(struct strbuf *outbuf,
 		ret = convert_commit_object(outbuf, from, to, buf, len);
 		break;
 	case OBJ_TAG:
+		ret = convert_tag_object(outbuf, from, to, buf, len);
+		break;
 	default:
 		/* Not implemented yet, so fail. */
 		ret = -1;
-- 
2.41.0

