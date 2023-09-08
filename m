Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47BB0EEB570
	for <git@archiver.kernel.org>; Fri,  8 Sep 2023 23:16:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344953AbjIHXQI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Sep 2023 19:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344945AbjIHXQH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Sep 2023 19:16:07 -0400
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D30133
        for <git@vger.kernel.org>; Fri,  8 Sep 2023 16:16:02 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:34686)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qekdr-007QxK-PB; Fri, 08 Sep 2023 17:11:59 -0600
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:54328 helo=localhost.localdomain)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qekdq-009u13-KR; Fri, 08 Sep 2023 17:11:59 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Fri,  8 Sep 2023 18:10:33 -0500
Message-Id: <20230908231049.2035003-16-ebiederm@xmission.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <87sf7ol0z3.fsf@email.froward.int.ebiederm.org>
References: <87sf7ol0z3.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1qekdq-009u13-KR;;;mid=<20230908231049.2035003-16-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1/wPHPM15oeeW8kgr97bzrp0nz7c5WXJQw=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH 16/32] object: Factor out parse_mode out of fast-import and tree-walk into in object.h
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

builtin/fast-import.c and tree-walk.c have almost identical version of
get_mode.  The two functions started out the same but have diverged
slightly.  The version in fast-import changed mode to a uint16_t to
save memory.  The version in tree-walk started erroring if no mode was
present.

As far as I can tell both of these changes are valid for both of the
callers, so add the both changes and place the common parsing helper
in object.h

Rename the helper from get_mode to parse_mode so it does not
conflict with another helper named get_mode in diff-no-index.c

This will be used shortly in a new helper decode_tree_entry_raw
which is used to compute cmpatibility objects as part of
the sha256 transition.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 builtin/fast-import.c | 18 ++----------------
 object.h              | 18 ++++++++++++++++++
 tree-walk.c           | 22 +++-------------------
 3 files changed, 23 insertions(+), 35 deletions(-)

diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 4dbb10aff3da..2c645fcfbe3f 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -1235,20 +1235,6 @@ static void *gfi_unpack_entry(
 	return unpack_entry(the_repository, p, oe->idx.offset, &type, sizep);
 }
 
-static const char *get_mode(const char *str, uint16_t *modep)
-{
-	unsigned char c;
-	uint16_t mode = 0;
-
-	while ((c = *str++) != ' ') {
-		if (c < '0' || c > '7')
-			return NULL;
-		mode = (mode << 3) + (c - '0');
-	}
-	*modep = mode;
-	return str;
-}
-
 static void load_tree(struct tree_entry *root)
 {
 	struct object_id *oid = &root->versions[1].oid;
@@ -1286,7 +1272,7 @@ static void load_tree(struct tree_entry *root)
 		t->entries[t->entry_count++] = e;
 
 		e->tree = NULL;
-		c = get_mode(c, &e->versions[1].mode);
+		c = parse_mode(c, &e->versions[1].mode);
 		if (!c)
 			die("Corrupt mode in %s", oid_to_hex(oid));
 		e->versions[0].mode = e->versions[1].mode;
@@ -2275,7 +2261,7 @@ static void file_change_m(const char *p, struct branch *b)
 	struct object_id oid;
 	uint16_t mode, inline_data = 0;
 
-	p = get_mode(p, &mode);
+	p = parse_mode(p, &mode);
 	if (!p)
 		die("Corrupt mode: %s", command_buf.buf);
 	switch (mode) {
diff --git a/object.h b/object.h
index 114d45954d08..70c8d4ae63dc 100644
--- a/object.h
+++ b/object.h
@@ -190,6 +190,24 @@ void *create_object(struct repository *r, const struct object_id *oid, void *obj
 
 void *object_as_type(struct object *obj, enum object_type type, int quiet);
 
+
+static inline const char *parse_mode(const char *str, uint16_t *modep)
+{
+	unsigned char c;
+	unsigned int mode = 0;
+
+	if (*str == ' ')
+		return NULL;
+
+	while ((c = *str++) != ' ') {
+		if (c < '0' || c > '7')
+			return NULL;
+		mode = (mode << 3) + (c - '0');
+	}
+	*modep = mode;
+	return str;
+}
+
 /*
  * Returns the object, having parsed it to find out what it is.
  *
diff --git a/tree-walk.c b/tree-walk.c
index 29ead71be173..3af50a01c2c7 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -10,27 +10,11 @@
 #include "pathspec.h"
 #include "json-writer.h"
 
-static const char *get_mode(const char *str, unsigned int *modep)
-{
-	unsigned char c;
-	unsigned int mode = 0;
-
-	if (*str == ' ')
-		return NULL;
-
-	while ((c = *str++) != ' ') {
-		if (c < '0' || c > '7')
-			return NULL;
-		mode = (mode << 3) + (c - '0');
-	}
-	*modep = mode;
-	return str;
-}
-
 static int decode_tree_entry(struct tree_desc *desc, const char *buf, unsigned long size, struct strbuf *err)
 {
 	const char *path;
-	unsigned int mode, len;
+	unsigned int len;
+	uint16_t mode;
 	const unsigned hashsz = the_hash_algo->rawsz;
 
 	if (size < hashsz + 3 || buf[size - (hashsz + 1)]) {
@@ -38,7 +22,7 @@ static int decode_tree_entry(struct tree_desc *desc, const char *buf, unsigned l
 		return -1;
 	}
 
-	path = get_mode(buf, &mode);
+	path = parse_mode(buf, &mode);
 	if (!path) {
 		strbuf_addstr(err, _("malformed mode in tree entry"));
 		return -1;
-- 
2.41.0

