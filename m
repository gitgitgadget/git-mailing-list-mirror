Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84373EEB573
	for <git@archiver.kernel.org>; Fri,  8 Sep 2023 23:31:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345286AbjIHXbt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Sep 2023 19:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345277AbjIHXbq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Sep 2023 19:31:46 -0400
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 746681FFE
        for <git@vger.kernel.org>; Fri,  8 Sep 2023 16:31:39 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:37272)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qekdu-00FHJ1-3T; Fri, 08 Sep 2023 17:12:02 -0600
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:54328 helo=localhost.localdomain)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qekds-009u13-Ru; Fri, 08 Sep 2023 17:12:01 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Eric W . Biederman" <ebiederm@xmission.com>
Date:   Fri,  8 Sep 2023 18:10:34 -0500
Message-Id: <20230908231049.2035003-17-ebiederm@xmission.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <87sf7ol0z3.fsf@email.froward.int.ebiederm.org>
References: <87sf7ol0z3.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1qekds-009u13-Ru;;;mid=<20230908231049.2035003-17-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX19FBbcEN4AXtN6TA+x5luMNeTcnvcLO1vg=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH 17/32] object-file-convert: add a function to convert trees between algorithms
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "brian m. carlson" <sandals@crustytoothpaste.net>

In the future, we're going to want to provide SHA-256 repositories that
have compatibility support for SHA-1 as well.  In order to do so, we'll
need to be able to convert tree objects from SHA-256 to SHA-1 by writing
a tree with each SHA-256 object ID mapped to a SHA-1 object ID.

We implement a function, convert_tree_object, that takes an existing
tree buffer and writes it to a new strbuf, converting between
algorithms.  Let's make this function generic, because while we only
need it to convert from the main algorithm to the compatibility
algorithm now, we may need to do the other way around in the future,
such as for transport.

We avoid reusing the code in decode_tree_entry because that code
normalizes data, and we don't want that here.  We want to produce a
complete round trip of data, so if, for example, the old entry had a
wrongly zero-padded mode, we'd want to preserve that when converting to
ensure a stable hash value.

****
- Removed the repository parameter to convert_tree_object
- Removed setting from and to defaults in convert_tree_object
- Replaced repo_map_object with oid_to_algop
- Replaced get_mode with parse_mode
- Made convert_tree_object static.
- Called convert_tree_object from convert_object_file.

-- EWB

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 object-file-convert.c | 51 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 50 insertions(+), 1 deletion(-)

diff --git a/object-file-convert.c b/object-file-convert.c
index e7c62434016d..f266c8c6cc95 100644
--- a/object-file-convert.c
+++ b/object-file-convert.c
@@ -1,8 +1,10 @@
 #include "git-compat-util.h"
 #include "gettext.h"
 #include "strbuf.h"
+#include "hex.h"
 #include "repository.h"
 #include "hash-ll.h"
+#include "hash.h"
 #include "object.h"
 #include "loose.h"
 #include "object-file-convert.h"
@@ -36,6 +38,51 @@ int repo_oid_to_algop(struct repository *repo, const struct object_id *src,
 	return 0;
 }
 
+static int decode_tree_entry_raw(struct object_id *oid, const char **path,
+				 size_t *len, const struct git_hash_algo *algo,
+				 const char *buf, unsigned long size)
+{
+	uint16_t mode;
+	const unsigned hashsz = algo->rawsz;
+
+	if (size < hashsz + 3 || buf[size - (hashsz + 1)]) {
+		return -1;
+	}
+
+	*path = parse_mode(buf, &mode);
+	if (!*path || !**path)
+		return -1;
+	*len = strlen(*path) + 1;
+
+	oidread_algop(oid, (const unsigned char *)*path + *len, algo);
+	return 0;
+}
+
+static int convert_tree_object(struct strbuf *out,
+			       const struct git_hash_algo *from,
+			       const struct git_hash_algo *to,
+			       const char *buffer, size_t size)
+{
+	const char *p = buffer, *end = buffer + size;
+
+	while (p < end) {
+		struct object_id entry_oid, mapped_oid;
+		const char *path = NULL;
+		size_t pathlen;
+
+		if (decode_tree_entry_raw(&entry_oid, &path, &pathlen, from, p,
+					  end - p))
+			return error(_("failed to decode tree entry"));
+		if (repo_oid_to_algop(the_repository, &entry_oid, to, &mapped_oid))
+			return error(_("failed to map tree entry for %s"), oid_to_hex(&entry_oid));
+		strbuf_add(out, p, path - p);
+		strbuf_add(out, path, pathlen);
+		strbuf_add(out, mapped_oid.hash, to->rawsz);
+		p = path + pathlen + from->rawsz;
+	}
+	return 0;
+}
+
 int convert_object_file(struct strbuf *outbuf,
 			const struct git_hash_algo *from,
 			const struct git_hash_algo *to,
@@ -50,8 +97,10 @@ int convert_object_file(struct strbuf *outbuf,
 		die("Refusing noop object file conversion");
 
 	switch (type) {
-	case OBJ_COMMIT:
 	case OBJ_TREE:
+		ret = convert_tree_object(outbuf, from, to, buf, len);
+		break;
+	case OBJ_COMMIT:
 	case OBJ_TAG:
 	default:
 		/* Not implemented yet, so fail. */
-- 
2.41.0

