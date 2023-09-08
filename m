Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C349EEB571
	for <git@archiver.kernel.org>; Fri,  8 Sep 2023 23:30:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243950AbjIHXak (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Sep 2023 19:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233421AbjIHXag (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Sep 2023 19:30:36 -0400
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66838E46
        for <git@vger.kernel.org>; Fri,  8 Sep 2023 16:30:31 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:36982)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qekdO-00FHH8-Ds; Fri, 08 Sep 2023 17:11:30 -0600
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:54328 helo=localhost.localdomain)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qekdN-009u13-31; Fri, 08 Sep 2023 17:11:30 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Fri,  8 Sep 2023 18:10:20 -0500
Message-Id: <20230908231049.2035003-3-ebiederm@xmission.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <87sf7ol0z3.fsf@email.froward.int.ebiederm.org>
References: <87sf7ol0z3.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1qekdN-009u13-31;;;mid=<20230908231049.2035003-3-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX18cfkxQQNfPQVEKp6L0RzH8tHxUxqYf3xs=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH 03/32] object-file-convert:  Stubs for converting from one object format to another
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Two basic functions are provided:
- convert_object_file Takes an object file it's type and hash algorithm
  and converts it into the equivalent object file that would
  have been generated with hash algorithm "to".

  For blob objects there is no converstion to be done and it is an
  error to use this function on them.

  For commit, tree and tag objects that embedded oids are replaced by
  the oids of the objects they refer to if those objects had been
  generated with the hash "to".

- repo_oid_to_algop which takes an oid that refers to an object file
  and returns the oid of the equavalent object file generated
  with the target hash algorithm.

Two core functions are modified:
- oid_object_info_extended is updated to detect an oid encoding
  that does not match the current repository, use repo_oid_to_algop
  to find the correspoding oid in the current repository and to return
  the data for the oid.

The pair of files object-file-convert.c and object-file-convert.h
is introduced to hold as much of this logic as possible to keep
this conversion logic cleanly separated from everything else
and in the hopes that someday the code will be clean enough
git can support compiling out support for sha1 and the
various conversion functions.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 Makefile              |  1 +
 object-file-convert.c | 55 ++++++++++++++++++++++++++++
 object-file-convert.h | 24 +++++++++++++
 object-file.c         | 83 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 163 insertions(+)
 create mode 100644 object-file-convert.c
 create mode 100644 object-file-convert.h

diff --git a/Makefile b/Makefile
index 577630936535..f7e824f25cda 100644
--- a/Makefile
+++ b/Makefile
@@ -1073,6 +1073,7 @@ LIB_OBJS += notes-cache.o
 LIB_OBJS += notes-merge.o
 LIB_OBJS += notes-utils.o
 LIB_OBJS += notes.o
+LIB_OBJS += object-file-convert.o
 LIB_OBJS += object-file.o
 LIB_OBJS += object-name.o
 LIB_OBJS += object.o
diff --git a/object-file-convert.c b/object-file-convert.c
new file mode 100644
index 000000000000..9f4d5b354f5f
--- /dev/null
+++ b/object-file-convert.c
@@ -0,0 +1,55 @@
+#include "git-compat-util.h"
+#include "gettext.h"
+#include "strbuf.h"
+#include "repository.h"
+#include "hash-ll.h"
+#include "object.h"
+#include "object-file-convert.h"
+
+int repo_oid_to_algop(struct repository *repo, const struct object_id *src,
+		      const struct git_hash_algo *to, struct object_id *dest)
+{
+	/*
+	 * If the source alogirthm is not set, then we're using the
+	 * default hash algorithm for that object.
+	 */
+	const struct git_hash_algo *from =
+		src->algo ? &hash_algos[src->algo] : repo->hash_algo;
+
+	if (from == to) {
+		if (src != dest)
+			oidcpy(dest, src);
+		return 0;
+	}
+	return -1;
+}
+
+int convert_object_file(struct strbuf *outbuf,
+			const struct git_hash_algo *from,
+			const struct git_hash_algo *to,
+			const void *buf, size_t len,
+			enum object_type type,
+			int gentle)
+{
+	int ret;
+
+	/* Don't call this function when no conversion is necessary */
+	if ((from == to) || (type == OBJ_BLOB))
+		die("Refusing noop object file conversion");
+
+	switch (type) {
+	case OBJ_COMMIT:
+	case OBJ_TREE:
+	case OBJ_TAG:
+	default:
+		/* Not implemented yet, so fail. */
+		ret = -1;
+		break;
+	}
+	if (!ret)
+		return 0;
+	if (gentle)
+		return ret;
+	die(_("Failed to convert object from %s to %s"),
+		from->name, to->name);
+}
diff --git a/object-file-convert.h b/object-file-convert.h
new file mode 100644
index 000000000000..a4f802aa8eea
--- /dev/null
+++ b/object-file-convert.h
@@ -0,0 +1,24 @@
+#ifndef OBJECT_CONVERT_H
+#define OBJECT_CONVERT_H
+
+struct repository;
+struct object_id;
+struct git_hash_algo;
+struct strbuf;
+#include "object.h"
+
+int repo_oid_to_algop(struct repository *repo, const struct object_id *src,
+		      const struct git_hash_algo *to, struct object_id *dest);
+
+/*
+ * Convert an object file from one hash algorithm to another algorithm.
+ * Return -1 on failure, 0 on success.
+ */
+int convert_object_file(struct strbuf *outbuf,
+			const struct git_hash_algo *from,
+			const struct git_hash_algo *to,
+			const void *buf, size_t len,
+			enum object_type type,
+			int gentle);
+
+#endif /* OBJECT_CONVERT_H */
diff --git a/object-file.c b/object-file.c
index 7dc0c4bfbba8..7f24f19b8a68 100644
--- a/object-file.c
+++ b/object-file.c
@@ -36,6 +36,7 @@
 #include "quote.h"
 #include "packfile.h"
 #include "object-file.h"
+#include "object-file-convert.h"
 #include "object-store.h"
 #include "oidtree.h"
 #include "path.h"
@@ -1660,10 +1661,92 @@ static int do_oid_object_info_extended(struct repository *r,
 	return 0;
 }
 
+static int oid_object_info_convert(struct repository *r,
+				   const struct object_id *input_oid,
+				   struct object_info *input_oi, unsigned flags)
+{
+	const struct git_hash_algo *input_algo = &hash_algos[input_oid->algo];
+	int do_die = flags & OBJECT_INFO_DIE_IF_CORRUPT;
+	struct strbuf type_name = STRBUF_INIT;
+	struct object_info oi = *input_oi;
+	struct object_id oid, delta_base_oid;
+	unsigned long size;
+	void *content;
+	int ret;
+
+	if (repo_oid_to_algop(r, input_oid, the_hash_algo, &oid)) {
+		if (do_die)
+			die(_("missing mapping of %s to %s"),
+			    oid_to_hex(input_oid), the_hash_algo->name);
+		return -1;
+	}
+
+	/* Do we need to convert the delta base oid? */
+	if (oi.delta_base_oid)
+		oi.delta_base_oid = &delta_base_oid;
+
+	/* Do we need attributes that differ when converted? */
+	if (oi.sizep || oi.contentp) {
+		oi.contentp = &content;
+		oi.sizep = &size;
+		oi.type_name = &type_name;
+	}
+
+	ret = oid_object_info_extended(r, &oid, &oi, flags);
+	if (ret)
+		return -1;
+
+	if (oi.contentp == &content) {
+		struct strbuf outbuf = STRBUF_INIT;
+		enum object_type type;
+
+		type = type_from_string_gently(type_name.buf, type_name.len,
+					       !do_die);
+		if (type == -1)
+			return -1;
+		if (type != OBJ_BLOB) {
+			ret = convert_object_file(&outbuf,
+						  the_hash_algo, input_algo,
+						  content, size, type, !do_die);
+			if (ret == -1)
+				return -1;
+			size = outbuf.len;
+			content = strbuf_detach(&outbuf, NULL);
+		}
+		if (input_oi->sizep)
+			*input_oi->sizep = size;
+		if (input_oi->contentp)
+			*input_oi->contentp = content;
+		else
+			free(content);
+		if (input_oi->type_name)
+			*input_oi->type_name = type_name;
+		else
+			strbuf_release(&type_name);
+	}
+	if (oi.delta_base_oid == &delta_base_oid) {
+		if (repo_oid_to_algop(r, &delta_base_oid, input_algo,
+				 input_oi->delta_base_oid)) {
+			if (do_die)
+				die(_("missing mapping of %s to %s"),
+				    oid_to_hex(&delta_base_oid),
+				    input_algo->name);
+			return -1;
+		}
+	}
+	input_oi->whence = oi.whence;
+	input_oi->u = oi.u;
+	return ret;
+}
+
 int oid_object_info_extended(struct repository *r, const struct object_id *oid,
 			     struct object_info *oi, unsigned flags)
 {
 	int ret;
+
+	if (oid->algo && (hash_algo_by_ptr(r->hash_algo) != oid->algo))
+		return oid_object_info_convert(r, oid, oi, flags);
+
 	obj_read_lock();
 	ret = do_oid_object_info_extended(r, oid, oi, flags);
 	obj_read_unlock();
-- 
2.41.0

