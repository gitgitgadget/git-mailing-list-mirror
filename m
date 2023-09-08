Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3B67EEB571
	for <git@archiver.kernel.org>; Fri,  8 Sep 2023 23:31:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345283AbjIHXbr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Sep 2023 19:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343698AbjIHXbl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Sep 2023 19:31:41 -0400
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDA0E2122
        for <git@vger.kernel.org>; Fri,  8 Sep 2023 16:31:33 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:37304)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qekdw-00FHJA-Ik; Fri, 08 Sep 2023 17:12:04 -0600
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:54328 helo=localhost.localdomain)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qekdv-009u13-5r; Fri, 08 Sep 2023 17:12:03 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Eric W . Biederman" <ebiederm@xmission.com>
Date:   Fri,  8 Sep 2023 18:10:35 -0500
Message-Id: <20230908231049.2035003-18-ebiederm@xmission.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <87sf7ol0z3.fsf@email.froward.int.ebiederm.org>
References: <87sf7ol0z3.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1qekdv-009u13-5r;;;mid=<20230908231049.2035003-18-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX19w69wNEceLJoODGas/yjuMTHX1rXQzKsk=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH 18/32] object-file-convert: convert commit objects when writing
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "brian m. carlson" <sandals@crustytoothpaste.net>

When writing a commit object in a repository with both SHA-1 and
SHA-256, we'll need to convert our commit objects so that we can write
the hash values for both into the repository.  To do so, let's add a
function to convert commit objects.

Read the commit object and map the tree value and any of the parent
values, and copy the rest of the commit through unmodified.  Note that
we don't need to modify the signature headers, because they are the same
under both algorithms.

****
- made static and moved to object-file-convert.c
- Renamed the variable compat_oid to mapped_oid for clarity
- Replaced repo_map_object with oid_to_algop
-- EWB

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 object-file-convert.c | 44 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/object-file-convert.c b/object-file-convert.c
index f266c8c6cc95..9c715a9864d5 100644
--- a/object-file-convert.c
+++ b/object-file-convert.c
@@ -83,6 +83,48 @@ static int convert_tree_object(struct strbuf *out,
 	return 0;
 }
 
+static int convert_commit_object(struct strbuf *out,
+				 const struct git_hash_algo *from,
+				 const struct git_hash_algo *to,
+				 const char *buffer, size_t size)
+{
+	const char *tail = buffer;
+	const char *bufptr = buffer;
+	const int tree_entry_len = from->hexsz + 5;
+	const int parent_entry_len = from->hexsz + 7;
+	struct object_id oid, mapped_oid;
+	const char *p;
+
+	tail += size;
+	if (tail <= bufptr + tree_entry_len + 1 || memcmp(bufptr, "tree ", 5) ||
+			bufptr[tree_entry_len] != '\n')
+		return error("bogus commit object");
+	if (parse_oid_hex_algop(bufptr + 5, &oid, &p, from) < 0)
+		return error("bad tree pointer");
+
+	if (repo_oid_to_algop(the_repository, &oid, to, &mapped_oid))
+		return error("unable to map tree %s in commit object",
+			     oid_to_hex(&oid));
+	strbuf_addf(out, "tree %s\n", oid_to_hex(&mapped_oid));
+	bufptr = p + 1;
+
+	while (bufptr + parent_entry_len < tail && !memcmp(bufptr, "parent ", 7)) {
+		if (tail <= bufptr + parent_entry_len + 1 ||
+		    parse_oid_hex_algop(bufptr + 7, &oid, &p, from) ||
+		    *p != '\n')
+			return error("bad parents in commit");
+
+		if (repo_oid_to_algop(the_repository, &oid, to, &mapped_oid))
+			return error("unable to map parent %s in commit object",
+				     oid_to_hex(&oid));
+
+		strbuf_addf(out, "parent %s\n", oid_to_hex(&mapped_oid));
+		bufptr = p + 1;
+	}
+	strbuf_add(out, bufptr, tail - bufptr);
+	return 0;
+}
+
 int convert_object_file(struct strbuf *outbuf,
 			const struct git_hash_algo *from,
 			const struct git_hash_algo *to,
@@ -101,6 +143,8 @@ int convert_object_file(struct strbuf *outbuf,
 		ret = convert_tree_object(outbuf, from, to, buf, len);
 		break;
 	case OBJ_COMMIT:
+		ret = convert_commit_object(outbuf, from, to, buf, len);
+		break;
 	case OBJ_TAG:
 	default:
 		/* Not implemented yet, so fail. */
-- 
2.41.0

